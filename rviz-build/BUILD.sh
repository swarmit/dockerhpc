VENDOR="happsup"
VENDOR="appzhup"
VENDOR="contapp"
prod="rviz2d"
docker build  -t $VENDOR/$prod . 

# docker build --no-cache -t appzhub/openlava . # This build and tag the image with appzhub/openlava:latest

docker tag $VENDOR/$prod $VENDOR/$prod:latest

# echo "d rm rv;  d run -it -e QT_X11_NO_MITSHM=1 -p 5901:5901 -v=/tmp/.X11-unix:/tmp/.X11-unix --name rv contapp/rviz2d"
echo "d rm rv;  d run -it -p 5901:5901 -h rviz -v=/tmp/.X11-unix:/tmp/.X11-unix --name rv contapp/rviz2d"
# echo "d rm rv;  d run -it -p 5901:5901 -h rviz -v=/tmp/.X11-unix:/tmp/.X11-unix --name rv contapp/rviz2d"
echo "#!/bin/bash 
alias d=docker 
d rm rv
d run -d -p 5901:5901 -h rviz -v=/tmp/.X11-unix:/tmp/.X11-unix --name rv contapp/rviz2d
" > startrv.sh
# echo "d exec ol bash -c" "\". /opt/openlava-3.3/etc/openlava.sh; echo y | lsadmin reconfig; echo y | badmin reconfig\""
