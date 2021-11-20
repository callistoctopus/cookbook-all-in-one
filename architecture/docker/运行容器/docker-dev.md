# spring-boot-web-service java 11
docker run -itd --rm -v /var/work/projects/server/webservice/spring-boot/spring-boot-web/mvc/project:/var/work/project -v /var/work/volumes/maven/apache-maven-3.8.3:/usr/lib/maven/apache-maven-3.8.3 --privileged=true --name springboot-webservice -p 221:22 callistoctopus/language:U18PSAVSJ11M38-u18psav-java11-maven3.8

docker run -itd -v /var/work/projects/server/webservice/spring-boot/spring-boot-web/mvc/project:/var/work/project -v /var/work/volumes/maven/apache-maven-3.8.3:/usr/lib/maven/apache-maven-3.8.3 --privileged=true --name webservice -p 221:22 -p 6060:8080 callistoctopus/language:U18PSAVSJ11M38-u18psav-java11-maven3.8
