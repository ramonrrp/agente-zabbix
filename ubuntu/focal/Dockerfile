FROM ubuntu:20.04
WORKDIR /app
COPY ./zabbix_agent2.sh ./
ENV HOME /root
RUN apt update && \
apt-get install sudo apt-utils wget -y
RUN chmod +x zabbix_agent2.sh && \
./zabbix_agent2.sh && \
touch teste.txt

ENTRYPOINT ["tail", "-f", "/dev/null"]


#RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
#apt update && \
#apt upgrade -y
#RUN apt install apt-utils wget build-essential -y && \
#rm -rf /var/lib/apt/lists/*

# Add files.
#ADD root/.bashrc /root/.bashrc
#ADD root/.gitconfig /root/.gitconfig
#ADD root/.scripts /root/.scripts


