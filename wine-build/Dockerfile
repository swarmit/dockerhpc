FROM ubuntu
# MAINTAINER Brandon R. Stoner <monokrome@monokro.me>

RUN dpkg --add-architecture i386

RUN apt-get update -y

#ORG RUN apt-get install -y software-properties-common && add-apt-repository -y ppa:ubuntu-wine/ppa
RUN apt-get install -y software-properties-common && add-apt-repository -y  ppa:wine/wine-builds

RUN apt-get update -y

#ORG RUN apt-get install -y wine1.7 winetricks xvfb
RUN apt-get install --install-recommends -y winehq-devel

RUN apt-get purge -y software-properties-common
RUN apt-get autoclean -y

ENV DISPLAY :1
