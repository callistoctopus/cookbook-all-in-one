# java 8
docker run -itd \
    -p 220:22 \
    -v /var/work:/var/work \
    --privileged=true \
    --name java8 \
    callistoctopus/language:U18PSAVSJ8M38-u18psav-java8-maven3.8

# java 11
docker run -itd \
    -p 221:22 \
    -v /var/work:/var/work \
    --privileged=true \
    --name java11 \
    callistoctopus/language:U18PSAVSJ11M38-u18psav-java11-maven3.8

# java 17
docker run -itd \
    -p 222:22 \
    -v /var/work:/var/work \
    --privileged=true \
    --name java17 \
    callistoctopus/language:U18PSAVSJ17M38-u18psav-java17-maven3.8
