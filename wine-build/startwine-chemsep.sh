docker rm wine-chemsep; docker run --rm --name wine-chemsep -it -v /home/kg:/root/.wine/drive_c/users/kg  -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker:ro -v /lib/x86_64-linux-gnu/libseccomp.so.2:/lib64/libseccomp.so.2:ro  -v /lib/x86_64-linux-gnu/libapparmor.so.1:/lib64/libapparmor.so.1:ro -v /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1:/lib64/libdevmapper.so.1.02.1:ro  -v=/tmp/.X11-unix:/tmp/.X11-unix  contapp/wine-chemsep wine "C:\Program Files\ChemSepL7v12\bin\wincs.exe"