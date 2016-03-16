VENDOR=contapp
PROD=enginframe

docker build -t $VENDOR/$PROD . # This build and tag the image with appzhub/openlava:latest

# docker build --no-cache -t appzhub/openlava . # This build and tag the image with appzhub/openlava:latest

docker tag  $VENDOR/$PROD  $VENDOR/$PROD:2015.1  # Add a new tag

# echo  d run -it --name ef --volumes-from ol appzhub/enginframe
# echo "d rm ef; d run -it -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock --name ef --volumes-from ol appzhub/enginframe"
echo in case of Ubuntu

# echo docker create  -v /opt --name appzupdata busybox  /bin/true
# -v /opt/nice/enginframe/data:/opt/nice/enginframe/data 
echo "docker rm ef; docker run -d -h master  -v /opt/nice/enginframe/spoolers:/opt/nice/enginframe/spoolers -v /opt/nice/enginframe/sessions:/opt/nice/enginframe/sessions -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker:ro -v /lib/x86_64-linux-gnu/libseccomp.so.2:/lib64/libseccomp.so.2:ro  -v /lib/x86_64-linux-gnu/libapparmor.so.1:/lib64/libapparmor.so.1:ro -v /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1:/lib64/libdevmapper.so.1.02.1:ro  -p 8080:8080 --name ef --volumes-from ol --volumes-from ruser-data  -v=/tmp/.X11-unix:/tmp/.X11-unix  $VENDOR/$PROD " > startef.sh
chmod 755 startef.sh

# -v /var/run/docker.sock:/var/run/docker.sock
