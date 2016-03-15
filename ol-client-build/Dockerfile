FROM centos:latest
MAINTAINER contapp


RUN yum -y update

RUN yum install -y git vim psmisc initscripts

RUN yum clean all

RUN echo -e "#\\n# local config \\n#" >> /root/.bashrc
RUN echo "alias l=\"ls -al\"" >> /root/.bashrc
RUN echo "export JAVA_HOME=/opt/jdk-linux-x64/jdk1.8.0_73" >> /root/.bashrc

RUN useradd -u 1010 ruser

ADD ol-client-setup.sh /setup.sh

CMD ["/setup.sh", "nobash"] 
