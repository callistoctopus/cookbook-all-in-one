# java 8
docker run -itd \
    -p 220:22 \
    -p 8080:8080 \
    -p 8443:8443 \
    -v /var/work:/var/work \
    -v /usr/lib/maven/apache-maven-3.8.3/repo:/usr/lib/maven/apache-maven-3.8.3/repo \
    --privileged=true \
    --name java8 \
    callistoctopus/language:U18PSAVSJ8M38-u18psav-java8-maven3.8

# java 11
docker run -itd \
    -p 221:22 \
    -p 8080:8080 \
    -p 8443:8443 \
    -v /var/work:/var/work \
    -v /usr/lib/maven/apache-maven-3.8.3/repo:/usr/lib/maven/apache-maven-3.8.3/repo \
    --privileged=true \
    --name java11 \
    callistoctopus/language:U18PSAVSJ11M38-u18psav-java11-maven3.8

# java 17
docker run -itd \
    -p 222:22 \
    -p 8080:8080 \
    -p 8443:8443 \
    -v /var/work:/var/work \
    -v /usr/lib/maven/apache-maven-3.8.3/repo:/usr/lib/maven/apache-maven-3.8.3/repo \
    --privileged=true \
    --name java17 \
    callistoctopus/language:U18PSAVSJ17M38-u18psav-java17-maven3.8
