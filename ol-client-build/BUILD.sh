VENDOR="happsup"
VENDOR="appzhup"
VENDOR="contapp"
prod="openlava-client"

docker build  -t $VENDOR/$prod . 
# docker build --no-cache=false  -t $VENDOR/$prod . 

docker tag $VENDOR/$prod $VENDOR/$prod:3.3  # Add a new tag

echo "d run -d --volumes-from ol -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker:ro -v /lib/x86_64-linux-gnu/libseccomp.so.2:/lib64/libseccomp.so.2:ro  -v /lib/x86_64-linux-gnu/libapparmor.so.1:/lib64/libapparmor.so.1:ro -v /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1:/lib64/libdevmapper.so.1.02.1:ro  $VENDOR/$prod"
echo "docker run -d --volumes-from ol -v /var/run/docker.sock:/var/run/docker.sock -v /lib/x86_64-linux-gnu/libseccomp.so.2:/lib64/libseccomp.so.2:ro  -v /usr/bin/docker:/usr/bin/docker:ro  -v /lib/x86_64-linux-gnu/libapparmor.so.1:/lib64/libapparmor.so.1:ro -v /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1:/lib64/libdevmapper.so.1.02.1:ro  $VENDOR/$prod" > start-olclient.sh



