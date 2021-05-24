# registry
docker pull registry
docker run -d -p 5000:5000 --restart always --name registry registry

[-e REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY=/var/registry]
[-v /docker/registry:/var/registry]

## http: server gave HTTP response to HTTPS client问题解决方法
1. 在 /etc/docker/ 目录下，创建 daemon.json 文件。
2. 在文件中写入：{ "insecure-registries":["192.168.1.100:5000"] }
3. 保存退出后，重启docker。