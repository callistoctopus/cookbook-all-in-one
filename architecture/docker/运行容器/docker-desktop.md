# kasmweb dev
docker run -itd -u root \
    -p 443:6901 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/work:/var/work \
    -e VNC_PW=password -e VNC_RESOLUTION=2560x1440 \
    --restart=on-failure --shm-size=512m \
    --name dev \
    callistoctopus/desktop:kasmweb-vscode-edge-office

# kasmweb desktop (official)
docker run -itd \
    --shm-size=512m \
    -p 6901:6901 \
    -u root \
    -e VNC_PW=password 
    kasmweb/desktop:1.9.0

https://<ip>:6901/
User : kasm_user
Password: password

# kasmweb desktop-deluxe (official)
docker run -itd --shm-size=512m -p 6901:6901 -u root -e VNC_PW=password kasmweb/desktop-deluxe:1.9.0
https://<ip>:6901/
User : kasm_user
Password: password

# ubuntu-desktop-lxde-vnc (official)
docker run -itd -p 6080:80 -p 5900:5900  -e RESOLUTION=1920x1080 -e VNC_PASSWORD=password dorowu/ubuntu-desktop-lxde-vnc

# ubuntu-lxde-vnc (private)
docker run -itd -p 6080:80 -p 5900:5900  -e RESOLUTION=1920x1080 -e VNC_PASSWORD=password callistoctopus/desktop:ubuntu-lxde-vnc

# docker-ubuntu-xrdp-mate-custom (official)
echo "user:pass:Y" > CREATEUSERS.TXT
docker run --name RattyDAVE20.04 --privileged=true -p 3389:3389 -e TZ="Europe/London" -v ${PWD}/CREATEUSERS.TXT:/root/createusers.txt -dit --restart unless-stopped rattydave/docker-ubuntu-xrdp-mate-custom:20.04