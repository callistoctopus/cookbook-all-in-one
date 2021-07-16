yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

echo "install yum-utils"
yum install -y yum-utils

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "install docker-ce docker-ce-cli containerd.io"
yum install -y docker-ce docker-ce-cli containerd.io

echo "start docker"
systemctl enable docker && systemctl start docker

echo "Done"