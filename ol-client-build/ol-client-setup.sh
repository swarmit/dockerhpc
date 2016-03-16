#!/bin/bash 

# setup OpenLava
cd /opt/openlava-3.3/etc

# add user if necessary

if [ "`grep openlava /etc/passwd`""0" == "0" ] ; then 
  useradd -u 1000 openlava
fi

echo 'ruser:ruser' | chpasswd
chown ruser /home/ruser

# add host to cluster
if [ "`grep $HOSTNAME lsf.cluster.openlava`""0" == "0" ] ; then 
  echo "Adding host $HOSTNAME to the OpenLava configuration ..."
  while [ -f lsf.cluster.openlava.LOCK ] ; do sleep 0.3;  done
  touch lsf.cluster.openlava.LOCK
  cat lsf.cluster.openlava | sed -e 's/\(# yourhost.*$\)/\1\n'$HOSTNAME'        DEFAULT   linux  1 -  (cs)/' > lsf.cluster.openlava.TMP
  mv lsf.cluster.openlava.TMP lsf.cluster.openlava
  rm lsf.cluster.openlava.LOCK
  grep $HOSTNAME /etc/hosts >> /opt/openlava-3.3/etc/hosts
fi
if [ "`grep $HOSTNAME /opt/openlava-3.3/etc/hosts`""0" == "0" ] ; then 
  grep $HOSTNAME /etc/hosts >> /opt/openlava-3.3/etc/hosts   
fi
## # CPU factors are only comparisons.
if [ "`grep DEFAULT lsf.shared`""0" == "0" ] ; then 
  cat lsf.shared | sed -e 's/\(# CPU factors are only .*$\)/DEFAULT   100  (x86_64)\n\1/' > lsf.shared.TMP
  mv lsf.shared.TMP lsf.shared
fi

# reconfig the master
if [ "`docker ps -f name=ef | grep ef`" != "" ] ; then
    cont=`docker ps -f name=ef | grep ef | awk '{print $NF}'`
    echo cont $cont
    docker exec $cont bash -c ". /opt/openlava-3.3/etc/openlava.sh; echo y | lsadmin reconfig"
    docker exec $cont bash -c ". /opt/openlava-3.3/etc/openlava.sh; echo y | badmin reconfig"
else
  if [ "`docker ps -f name=compose_ef_1 `" != "" ] ; then
    docker exec compose_ef_1 bash -c ". /opt/openlava-3.3/etc/openlava.sh; echo y | lsadmin reconfig"
     docker exec compose_ef_1 bash -c ". /opt/openlava-3.3/etc/openlava.sh; echo y | badmin reconfig"
  fi
fi

echo 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH":/opt/openlava-3.3/lib' >> openlava.sh

# source openlava settings
source openlava.sh
source $LSF_ENVDIR/lsf.conf

# install the openlava startup file
# cp $LSF_ENVDIR/openlava /etc/init.d

cp $LSF_ENVDIR/openlava.sh /etc/profile.d
cp $LSF_ENVDIR/openlava.csh /etc/profile.d

# in openlava.sh
# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH":/opt/openlava-3.3/lib

# start Openlava
echo Starting OpenLava Daemons ...
sh openlava start

echo Checking for OpenLava Status ...
# check for id
lsid
lsload

. ~/.bashrc
. /etc/profile.d/openlava.sh

# echo "For OpenLava profile: . /etc/profile.d/openlava.sh"

function f_terminate  {
    echo "TRAP SIGTERM received ...";
    while [ -f lsf.cluster.openlava.LOCK ] ; do sleep 0.21;  done
    touch lsf.cluster.openlava.LOCK
    grep -v $HOSTNAME /opt/openlava-3.3/etc/hosts > /opt/openlava-3.3/etc/hosts.TMP;
    mv /opt/openlava-3.3/etc/hosts.TMP /opt/openlava-3.3/etc/hosts
    grep -v $HOSTNAME /opt/openlava-3.3/etc/lsf.cluster.openlava > /opt/openlava-3.3/etc/lsf.cluster.openlava.TMP;
    mv /opt/openlava-3.3/etc/lsf.cluster.openlava.TMP /opt/openlava-3.3/etc/lsf.cluster.openlava;
    rm lsf.cluster.openlava.LOCK
    }

trap 'f_terminate;  exit 0' SIGTERM

# trap 'echo TRAP SIGTERM received ... ;  exit 0' SIGTERM
trap 'echo TRAP SIGKILL received ... ;  exit 0' SIGKILL

if [ "$1" == "nobash" ] ; then
    while true; do sleep 1; done
    tail -f /dev/null
else
    exec  /bin/bash --rcfile /etc/profile.d/openlava.sh
fi


