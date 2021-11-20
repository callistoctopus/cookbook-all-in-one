# spring-boot-web-service java 11
docker run -itd \
    --privileged=true --name webservice  \
    -p 221:22 -p 6060:8080 \
    -v /var/work/projects/server/webservice/spring-boot/spring-boot-web/mvc/project:/var/work/project \
    callistoctopus/language:U18PSAVSJ11M38-u18psav-java11-maven3.8
