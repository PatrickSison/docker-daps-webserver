FROM ubuntu:latest

EXPOSE 80 443 3000 35729 8080

RUN apt-get update -q \
&& apt-get install -yqq curl git python-dev python-pip zip wget \
    ssh gcc make build-essential libkrb5-dev sudo apt-utils ca-certificates \
&& apt-get clean 

RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
RUN apt-get update -q \
    && apt-get install -yqq \
    python3 \
    python3-pip \
    curl \
    git \
    ssh \
    gcc \
    make \
    build-essential \
    libkrb5-dev \
    sudo \
    apt-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip3 install django
RUN npm install --global react-scripts

ADD start.sh /scripts/start.sh
RUN chmod +x /scripts/start.sh
RUN echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config
CMD ["/scripts/start.sh"]
