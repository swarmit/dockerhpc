#!/bin/bash

# if [ "`grep master /opt/openlava-3.3/etc/hosts`" != "" ] ; then
#     cat /opt/openlava-3.3/etc/hosts | grep -v master > /opt/openlava-3.3/etc/hosts.TMP
#    mv /opt/openlava-3.3/etc/hosts.TMP /opt/openlava-3.3/etc/hosts
# fi

# clean hosts file; also to avoid duplicate IPs
echo "" > /opt/openlava-3.3/etc/hosts

/opt/openlava-3.3/etc/ol-setup.sh

# if [ "`docker ps -f name=ol | grep ol`" != "" ] ; then 
#   docker exec ol bash -c ". /opt/openlava-3.3/etc/openlava.sh; echo y | lsadmin reconfig"
#   docker exec ol bash -c ". /opt/openlava-3.3/etc/openlava.sh; echo y | badmin reconfig"
# fi

echo 'efadmin:efadmin' | chpasswd
echo 'ruser:ruser' | chpasswd
chown ruser /home/ruser

service enginframe start

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

if [ "$1" == "nobash" ] ; then
    while true; do sleep 1; done
    tail -f /dev/null
else
    exec  /bin/bash --rcfile /etc/profile.d/openlava.sh
fi
