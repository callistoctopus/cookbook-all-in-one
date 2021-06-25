
# 本地安装&启动
wget -O docker-compose.yml https://raw.githubusercontent.com/spring-cloud/spring-cloud-dataflow/main/src/docker-compose/docker-compose.yml; \
DATAFLOW_VERSION=2.8.0 SKIPPER_VERSION=2.7.0 \
docker-compose up

# 控制台
http://<ip>:9393/dashboard

# 关闭
Ctrl+C
docker-compose down

# 注册应用（使用本地文件系统）
export HOST_MOUNT_PATH=/home/cnb/scdf
app register --type source --name my-app --uri file://home/cnb/scdf/my-app-1.0.0.RELEASE.jar

# 注册应用（使用Maven本地仓库）
export HOST_MOUNT_PATH=~/.m2
export DOCKER_MOUNT_PATH=/home/cnb/.m2/
app register --type processor --name pose-estimation --uri maven://org.springframework.cloud.stream.app:pose-estimation-processor-rabbit:2.0.2.BUILD-SNAPSHOT --metadata-uri maven://org.springframework.cloud.stream.app:pose-estimation-processor-rabbit:jar:metadata:2.0.2.BUILD-SNAPSHOT