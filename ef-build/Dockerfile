FROM centos:latest
MAINTAINER contapp

# RUN echo deb http://www.openfoam.com/download/ubuntu trusty main >> /etc/apt/sources.list.d/openfoam.list

# RUN apt-get update && apt-get install -y --force-yes \
#        openfoam30 \
#	        paraviewopenfoam44

RUN yum -y update

RUN yum clean all

RUN yum install -y git vim 

RUN yum clean all

# install Java
ADD jdk-8u73-linux-x64.tar.gz /opt/jdk-linux-x64
ADD enginframe-2015.1-r38427.jar /enginframe-2015.1-r38427.jar
ADD lic.ef /lic.ef

RUN useradd -u 1001 efadmin
RUN useradd -u 1002 efnobody
RUN useradd -u 1010 ruser

RUN yum install -y psmisc initscripts

RUN echo -e "#\\n# local config \\n#" >> /root/.bashrc
RUN echo "alias l=\"ls -al\"" >> /root/.bashrc
RUN echo "export JAVA_HOME=/opt/jdk-linux-x64/jdk1.8.0_73" >> /root/.bashrc

# Install EF
ADD efinstall.config /efinstall.config
# RUN /opt/jdk-linux-x64/jdk1.8.0_73/bin/java -jar enginframe-2015.1-r38427.jar --batch
RUN /opt/jdk-linux-x64/jdk1.8.0_73/bin/java -jar enginframe-2015.1-r38427.jar --batch

# Start EF
EXPOSE 8080
# RUN service enginframe start

ADD ef-setup.sh /setup.sh

CMD [ "/setup.sh", "nobash" ]

# VOLUME /opt/nice/enginframe

