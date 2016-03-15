FROM centos:latest
MAINTAINER contapp

# RUN echo deb http://www.openfoam.com/download/ubuntu trusty main >> /etc/apt/sources.list.d/openfoam.list

# RUN apt-get update && apt-get install -y --force-yes \
#        openfoam30 \
#	        paraviewopenfoam44

RUN yum -y update

RUN yum clean all

RUN yum install -y vim psmisc tigervnc-server twm
RUN yum clean all

RUN yum install -y less 
RUN yum clean all

RUN echo -e "#\\n# local config \\n#" >> /root/.bashrc
RUN echo "alias l=\"ls -al\"" >> /root/.bashrc

# VOLUME /tmp/.X11-unix

ADD rv2d-setup.sh setup.sh

CMD [ "/setup.sh" ]

EXPOSE 5901

