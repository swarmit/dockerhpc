#!/bin/bash

#
# more about OpenFOAM: http://www.openfoam.com/download/install-binary.php
#

#
export DISPLAY=":1"
echo Setting DISPLAY = $DISPLAY ...

#
# setup X Server with VNC
#

if [ "`docker ps -f name=rv | grep rv`" == "" ] ; then 
  docker rm rv
  docker run -d -p 5901:5901 -h rviz -v=/tmp/.X11-unix:/tmp/.X11-unix --name rv contapp/rviz2d
  echo Waiting for XVnc to come up ...
  while : ; do
      [ -S /tmp/.X11-unix/X1 ] && break
      sleep 1
  done
  gnome-shell 2>&1 &
fi

if [ "`xwininfo -tree -root |grep gnome-shell `" == "" ] ; then
    gnome-shell 2>&1 &
fi


# exit

#
# copied from the OpenFoam install script: run interactive container
#
user="$USER"
# user="ruser"
home="${1:-$HOME}"
# home=/home/ruser

imageName="openfoamplus/of_v30plus_rhel66"
containerName="of_v3.0_plus"
displayVar="$DISPLAY"

if [ "`docker ps -a -f name=$containerName | grep $containerName`" != "" ] ; then 
    echo Removing existing container $containerName ...
    docker stop $containerName
    echo "  ..."
    docker rm $containerName
    echo "  ..."
fi


echo "
alias l='ls -la'
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#
# demo script copied from the OpenFoam start script
#
mkdir -p \$FOAM_RUN
run
cp -r \$FOAM_TUTORIALS/incompressible/icoFoam/cavity .
cd cavity
blockMesh
icoFoam
paraFoam
#
# end demo script
#
"


#creating docker container for OpenFOAM+ operation   
# echo "**************************************** "
# echo "			"
echo "Starting Docker OpenFOAM+ container ${containerName} ..."

USERVOL="  --volume=${home}:${home} "
USERVOL=" --volumes-from ruser-data "


docker run -h openfoam  -it --name ${containerName} --user=${user} -e USER=${user} -e QT_X11_NO_MITSHM=1 -e DISPLAY=${displayVar} --workdir="${home}" $USERVOL  --volume="/etc/group:/etc/group:ro"  --volume="/etc/passwd:/etc/passwd:ro"  --volume="/etc/shadow:/etc/shadow:ro"  --volume="/etc/sudoers.d:/etc/sudoers.d:ro" -v=/tmp/.X11-unix:/tmp/.X11-unix  ${imageName}  /bin/bash --rcfile /opt/OpenFOAM/OpenFOAM-v3.0+/etc/bashrc 

# echo "Container ${containerName} was created."

exit

