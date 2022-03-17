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

# python
docker run -itd \
    -v /var/work:/var/work \
    -w /usr/src/myapp \
    --name python3 \
    python:3.8 

# node
docker run -itd \
    -v /var/work:/var/work \
    -p 80:80 \
    --name node \
    node:lts-alpine

# faceswap
docker run -itd \
    -v /var/work/projects/sdk/faceswap:/home/keiki/faceswap \
    --name faceswap \
    python:3.8 

https://github.com/deepfakes/faceswap/releases

conda activate faceswap

apt-get install ffmpeg libsm6 libxext6  -y

python faceswap.py extract -i /var/work/faceswap/input/putin.mp4 -o /var/work/faceswap/output/putin/
python faceswap.py extract -i /var/work/faceswap/input/trump.mp4 -o /var/work/faceswap/output/trump/

python faceswap.py train -A /var/work/faceswap/output/putin/ -B /var/work/faceswap/output/trump/ -m /var/work/faceswap/model/p_t

python faceswap.py convert -i /var/work/faceswap/input/putin.mp4 -o /var/work/faceswap/converted/p_t/ -m /var/work/faceswap/model/p_t

ffmpeg -i video-frame-%0d.png -c:v libx264 -vf "fps=25,format=yuv420p" out.mp4