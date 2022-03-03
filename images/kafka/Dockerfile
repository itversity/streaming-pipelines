FROM ubuntu:18.04

RUN apt update && \
    apt install openjdk-8-jdk openssh-server -y && \
    apt install python3 python3-venv python3-pip -y && \
    apt install sudo telnet groff vim -y && \
    rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "" itversity && \
    echo "itversity:itversity" | chpasswd && \
    adduser itversity sudo

RUN sed -i "s/%sudo\tALL=(ALL:ALL) ALL/%sudo\tALL=(ALL:ALL) NOPASSWD:ALL/g" /etc/sudoers

USER itversity

WORKDIR /home/itversity
COPY --chown=itversity:itversity .ssh .ssh
RUN chmod 700 -R .ssh

COPY --chown=itversity:itversity softwares /softwares
COPY --chown=itversity:itversity deploy.sh /deploy.sh
COPY --chown=itversity:itversity configs/.profile .profile

ENV KAFKA_HOME=/opt/kafka
ENV PATH=$PATH:${KAFKA_HOME}/bin

RUN chmod u+x /deploy.sh

CMD ["/deploy.sh"]
