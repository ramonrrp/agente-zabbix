#/bin/bash
#############################
#preenchimento das variáveis#
#############################

OS=`awk '/DISTRIB_ID=/' /etc/*-release | sed 's/DISTRIB_ID=//' | tr '[:upper:]' '[:lower:]'`
VERSAO=`awk '/DISTRIB_CODENAME=/' /etc/*-release | sed 's/DISTRIB_CODENAME=//' | sed 's/[.]0/./'`
HOSTNAME=`hostname`
DATA=`date`
PACOTE=zabbix-release_4.4-1+"$VERSAO"_all.deb
LOG=./zabbix_agent_v2_"$HOSTNAME".log

if [ -f "$LOG" ]; then
    echo "arquivo já existe"
else
    touch "$LOG"
fi

echo -e "
############################################
script tsi para instalação do zabbix-agent2#
############################################
data:     $DATA
os:       $OS
versao:   $VERSAO
hostname: $HOSTNAME
pacote :  $PACOTE
---------//-----------//---------//----------\n\n" >> $LOG
wget repo.zabbix.com/zabbix/4.4/$OS/pool/main/z/zabbix-release/$PACOTE && \
sudo dpkg -i $PACOTE && \
sudo apt update && \
sudo apt install zabbix-agent2 -y && \
echo "PidFile=/run/zabbix/zabbix_agent2.pid
LogFile=/var/log/zabbix/zabbix_agent2.log
LogFileSize=0
Include=/etc/zabbix/zabbix_agent2.d/*.conf
ControlSocket=/tmp/agent.sock" | sudo tee /etc/zabbix/zabbix_agent2.conf && \
echo -e "Server=xx.xxx.xx.xx
ServerActive=xx.xx.xx.xx
Hostname=$HOSTNAME" | sudo tee /etc/zabbix/zabbix_agent2.d/tsi_default.conf && \
sudo rm -rf ./$PACOTE && \
echo "estado do serviço:" >> $LOG && \
#sudo service zabbix-agent2 restart && \
sudo service zabbix-agent2 status >> $LOG