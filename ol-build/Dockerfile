FROM centos:latest
MAINTAINER appzhub

# RUN echo deb http://www.openfoam.com/download/ubuntu trusty main >> /etc/apt/sources.list.d/openfoam.list

# RUN apt-get update && apt-get install -y --force-yes \
#        openfoam30 \
#	        paraviewopenfoam44

RUN yum -y update

RUN yum clean all

RUN yum install -y git vim

RUN yum clean all

RUN rm -rf openlava

RUN git clone git://github.com/openlava/openlava.git

RUN cd openlava

RUN  yum install -y libtool  ncurses-devel tcl-devel autoconf automake make
RUN yum clean all

RUN cd openlava ; set -x
RUN cd openlava ;rm -f config.cache
RUN cd openlava ;aclocal
RUN cd openlava ;libtoolize --automake --copy --force
RUN cd openlava ;autoconf
RUN cd openlava ;autoheader
RUN cd openlava ;automake --add-missing --copy

RUN cd openlava ;./configure
RUN cd openlava ;make

# lsf.cluster.openlava
  # edit admin 
  # enter host - with "!" ?
# chown kg /opt/openlava-3.3/work/logdir

RUN cd openlava; make install

# RUN cp /openlava/config/openlava.sh /opt/openlava-3.3/etc
# RUN cp /openlava/config/openlava.csh /opt/openlava-3.3/etc
RUN cp /openlava/config/* /opt/openlava-3.3/etc/
RUN rm /opt/openlava-3.3/etc/*.in
RUN rm /opt/openlava-3.3/etc/Makefile*

RUN cp /lib64/libtcl* /opt/openlava-3.3/lib

RUN useradd openlava
RUN chown openlava /opt/openlava-3.3/work/logdir

# move before next build UPPPPP
# RUN yum -y update
RUN yum install -y psmisc

RUN echo -e "#\\n# local config \\n#" >> /root/.bashrc
RUN echo "alias l=\"ls -al\"" >> /root/.bashrc
RUN echo ". /opt/openlava-3.3/etc/openlava.sh" >> /root/.bashrc
RUN echo ". /opt/openlava-3.3/etc/openlava.sh" >> /home/openlava/.bashrc

ADD ol-setup.sh /opt/openlava-3.3/etc/ol-setup.sh

RUN ln -s /opt/openlava-3.3/etc/ol-setup.sh setup.sh

# clean up
RUN rm -rf openlava

VOLUME /opt/openlava-3.3

EXPOSE 6322
EXPOSE 6323
EXPOSE 6324
EXPOSE 6325

# CMD /opt/openlava-3.3/etc/ol-setup.sh bash
