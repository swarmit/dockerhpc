#!/bin/bash

# set -x
mkdir ~/.vnc
echo contapp | vncpasswd  -f > ~/.vnc/passwd
# vncserver -geometry 1280x1024
rm /tmp/.X11-unix/X1
export DISPLAY=":1"
hn=`hostname`
/usr/bin/Xvnc $DISPLAY -desktop $hn$DISPLAY -auth /root/.Xauthority -geometry 1280x1024 -rfbwait 30000 -rfbauth /root/.vnc/passwd -rfbport 5901 -fp catalogue:/etc/X11/fontpath.d -pn &

sleep 1

xhost +

trap 'echo TRAP SIGTERM received - exiting ... ;  exit 0' SIGTERM

while true; do sleep 1; done

# tail -f /dev/null
# sleep 23423423423424242
