VENDOR="contapp"
prod="openlava"
docker build -t $VENDOR/$prod . # This build and tag the image with appzhub/openlava:latest

# docker build --no-cache=false -t appzhub/openlava . # This build and tag the image with appzhub/openlava:latest

docker tag  $VENDOR/$prod $VENDOR/$prod:3.3  # Add a new tag

echo "docker rm ol;  docker run  --name ol $VENDOR/$prod"
echo "docker exec ol bash -c " "\". /opt/openlava-3.3/etc/openlava.sh; echo y | lsadmin reconfig; echo y | badmin reconfig\"" 
echo "docker exec ol bash -c " "\". /opt/openlava-3.3/etc/openlava.sh; echo y | lsadmin reconfig; echo y | badmin reconfig\"" > startol.sh

