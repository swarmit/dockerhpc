VENDOR="contapp"
prod="wine"

docker build  -t $VENDOR/$prod . 

# exit

# docker build --no-cache=false  -t $VENDOR/$prod . 

# docker tag $VENDOR/$prod $VENDOR/$prod:3.3  # Add a new tag


echo "docker rm wine; docker run --rm  -h wine  -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker:ro -v /lib/x86_64-linux-gnu/libseccomp.so.2:/lib64/libseccomp.so.2:ro  -v /lib/x86_64-linux-gnu/libapparmor.so.1:/lib64/libapparmor.so.1:ro -v /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1:/lib64/libdevmapper.so.1.02.1:ro --name wine  -v=/tmp/.X11-unix:/tmp/.X11-unix  $VENDOR/$prod wine \"C:\windows\system32\\\cmd.exe\"   " > startwine-cmd.sh
chmod 755 startwine-cmd.sh

echo 'docker rm wine-chemsep; docker run --rm --name wine-chemsep -it -v /home/kg:/root/.wine/drive_c/users/kg  -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker:ro -v /lib/x86_64-linux-gnu/libseccomp.so.2:/lib64/libseccomp.so.2:ro  -v /lib/x86_64-linux-gnu/libapparmor.so.1:/lib64/libapparmor.so.1:ro -v /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1:/lib64/libdevmapper.so.1.02.1:ro  -v=/tmp/.X11-unix:/tmp/.X11-unix  contapp/wine-chemsep wine "C:\Program Files\ChemSepL7v12\\bin\wincs.exe"' > startwine-chemsep.sh
chmod 755 startwine-chemsep.sh


exit

echo "d run -d --volumes-from ol -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker:ro -v /lib/x86_64-linux-gnu/libseccomp.so.2:/lib64/libseccomp.so.2:ro  -v /lib/x86_64-linux-gnu/libapparmor.so.1:/lib64/libapparmor.so.1:ro -v /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1:/lib64/libdevmapper.so.1.02.1:ro  $VENDOR/$prod"
echo "docker run -d --volumes-from ol -v /var/run/docker.sock:/var/run/docker.sock -v /lib/x86_64-linux-gnu/libseccomp.so.2:/lib64/libseccomp.so.2:ro  -v /usr/bin/docker:/usr/bin/docker:ro  -v /lib/x86_64-linux-gnu/libapparmor.so.1:/lib64/libapparmor.so.1:ro -v /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1:/lib64/libdevmapper.so.1.02.1:ro  $VENDOR/$prod" > start-olclient.sh



