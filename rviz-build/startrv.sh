#!/bin/bash 
alias d=docker 
d rm rv
d run -d -p 5901:5901 -h rviz -v=/tmp/.X11-unix:/tmp/.X11-unix --name rv contapp/rviz2d

