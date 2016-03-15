VENDOR="contapp"
prod="ruser-data"
# docker build -t $VENDOR/$prod . 

docker create -v /home/ruser --name ruser-data centos /bin/true

# docker tag -f $VENDOR/$prod $VENDOR/$prod:latest

# echo "d rm data;  d run -it --name data $VENDOR/$prod"
# echo "d exec ol bash -c" "\". /opt/openlava-3.3/etc/openlava.sh; echo y | lsadmin reconfig; echo y | badmin reconfig\""
