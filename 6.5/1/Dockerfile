FROM centos:centos7

RUN yum -y install wget which nano

RUN yum -y install java-1.7.0-openjdk-devel.x86_64

ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk.x86_64
ENV PATH $JAVA_HOME/bin:$PATH

RUN yum -y localinstall https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.1.noarch.rpm

VOLUME ["/data"]

ADD config/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

WORKDIR /data

ADD run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh

CMD ["/tmp/run.sh"]

EXPOSE 9200
EXPOSE 9300
EXPOSE 54328