#!/bin/bash 

# setup OpenLava
cd /opt/openlava-3.3/etc

# add user if necessary

if [ "`grep openlava /etc/passwd`""0" == "0" ] ; then 
  useradd -u 1000 openlava
fi

# add host to cluster
if [ "`grep $HOSTNAME lsf.cluster.openlava`""0" == "0" ] ; then 
  while [ -f lsf.cluster.openlava.LOCK ] ; do sleep 0.3;  done
  touch lsf.cluster.openlava.LOCK
  cat lsf.cluster.openlava | sed -e 's/\(# yourhost.*$\)/'$HOSTNAME'        DEFAULT   linux  1 -  (cs)\n\1/' > lsf.cluster.openlava.TMP
  mv lsf.cluster.openlava.TMP lsf.cluster.openlava
  rm lsf.cluster.openlava.LOCK
  grep $HOSTNAME /etc/hosts >> /opt/openlava-3.3/etc/hosts
fi

IP=`grep $HOSTNAME /etc/hosts | sed -e 's/[ \t].*$//'`
if [ "`grep \"$IP\" /opt/openlava-3.3/etc/hosts`" != "" ] ; then
     cat /opt/openlava-3.3/etc/hosts | grep -v "$IP" > /opt/openlava-3.3/etc/hosts.TMP
     mv /opt/openlava-3.3/etc/hosts.TMP /opt/openlava-3.3/etc/hosts
fi

if [ "`grep $HOSTNAME /opt/openlava-3.3/etc/hosts`""0" == "0" ] ; then 
  grep $HOSTNAME /etc/hosts >> /opt/openlava-3.3/etc/hosts   
fi
## # CPU factors are only comparisons.
if [ "`grep DEFAULT lsf.shared`""0" == "0" ] ; then 
  cat lsf.shared | sed -e 's/\(# CPU factors are only .*$\)/DEFAULT   100  (x86_64)\n\1/' > lsf.shared.TMP
  mv lsf.shared.TMP lsf.shared
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

if [ "$1" == "bash" ] ; then
  exec  /bin/bash
fi



