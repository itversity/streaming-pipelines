#!/bin/bash -x

sudo service ssh start

if [ ! -e /opt/.initialized ]
then
  sudo touch /opt/.initialized
  tar xzf /softwares/kafka_2.13-3.0.0.tgz -C /softwares
  rm -f /softwares/kafka_2.13-3.0.0.tgz
  sudo mv -f /softwares/kafka_2.13-3.0.0 /opt
  sudo ln -s /opt/kafka_2.13-3.0.0 /opt/kafka
  sudo chown ${USER}:${USER} -R /opt/kafka_2.13-3.0.0

  sudo mv -f /softwares/gen-logs-python3/gen_logs /opt
  sudo chown ${USER}:${USER} -R /opt/gen_logs
  sudo ln -s /opt/gen_logs/start_logs.sh /usr/bin/.
  sudo ln -s /opt/gen_logs/stop_logs.sh /usr/bin/.
  sudo ln -s /opt/gen_logs/tail_logs.sh /usr/bin/.

  cp -f /configs/.profile /home/itversity/.profile
  . ~/.profile
fi

zookeeper-server-start.sh -daemon /opt/kafka/config/zookeeper.properties
kafka-server-start.sh /opt/kafka/config/server.properties
