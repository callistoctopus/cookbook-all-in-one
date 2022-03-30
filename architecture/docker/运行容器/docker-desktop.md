# kasmweb dev
docker run -itd -u root \
    -p 6901:6901 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/work:/var/work \
    -e VNC_USER=gui-qi \
    -e VNC_PW=password \
    -e VNC_RESOLUTION=2560x1440 \
    --restart=on-failure --shm-size=512m \
    --name kasmweb-util3 \
    callistoctopus/desktop:kasmweb-vscode-edge-office

# kasmweb desktop (official)
docker run -itd \
    --shm-size=512m \
    -p 6902:6901 \
    -u root \
    -e VNC_USER=gui-qi \
    -e VNC_PW=password \
    -e VNC_RESOLUTION=2560x1440 \
    --name kasmweb-desktop \
    kasmweb/desktop:1.10.0

# kasmweb edge (official)
docker run -itd \
    --shm-size=512m \
    -p 6903:6901 \
    -u root \
    -e VNC_USER=gui-qi \
    -e VNC_PW=password \
    -e VNC_RESOLUTION=2560x1440 \
    --name desktop-edge \
    kasmweb/edge:1.10.0
    
https://<ip>:6901/
User : gui-qi
Password: password

# kasmweb desktop-deluxe (official)
docker run -itd \
    --shm-size=512m \
    -p 6904:6901 \
    -u root \
    -e VNC_PW=password \
    -e VNC_RESOLUTION=2560x1440 \
    --name kasmweb-deluxe \
    kasmweb/desktop-deluxe:1.10.0

https://<ip>:6901/
User : kasm_user
Password: password

# ubuntu-desktop-lxde-vnc (official)
mkdir -p ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ssl/nginx.key -out ssl/nginx.crt
docker run -itd \
    -p 443:443 \
    -e SSL_PORT=443 \
    -e RESOLUTION=2560x1440 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/work:/var/work \
    -v ${PWD}/ssl:/etc/nginx/ssl \
    -v /dev/shm:/dev/shm \
    --restart=always \
    --name fuji2022 \
    dorowu/ubuntu-desktop-lxde-vnc 

https://<ip>

# ubuntu-lxde-vnc (private)
docker run -itd -p 6080:80 -p 5900:5900  -e RESOLUTION=1920x1080 -e VNC_PASSWORD=password callistoctopus/desktop:ubuntu-lxde-vnc

# docker-ubuntu-xrdp-mate-custom (official)
echo "user:pass:Y" > CREATEUSERS.TXT
docker run --name RattyDAVE20.04 --privileged=true -p 3389:3389 -e TZ="Europe/London" -v ${PWD}/CREATEUSERS.TXT:/root/createusers.txt -dit --restart unless-stopped rattydave/docker-ubuntu-xrdp-mate-custom:20.04