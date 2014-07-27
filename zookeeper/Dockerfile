FROM debian:jessie

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" >> /etc/apt/sources.list && \
  TMPNAME=$(tempfile) && \
  apt-get update >> /dev/null 2> $TMPNAME && \
  PGPKEY=`cat $TMPNAME | cut -d":" -f6 | cut -d" " -f3` && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $PGPKEY && \
  rm $TMPNAME && \
  apt-get update && \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java7-installer oracle-java7-set-default

ADD http://ftp.nluug.nl/internet/apache/zookeeper/stable/zookeeper-3.4.6.tar.gz /zookeeper.tar.gz

RUN mkdir -p zoo && \
  cd zoo && \
  tar xvfz ../zookeeper.tar.gz --strip-components=1 && \
  rm /zookeeper.tar.gz

ADD start-server.sh /

RUN chmod +x /start-server.sh

CMD ["/start-server.sh"]

EXPOSE 2888 3888 2181
