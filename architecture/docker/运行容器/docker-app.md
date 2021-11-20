# openjdk
docker pull openjdk

# busybox
docker run -it --rm busybox
docker run -itd --name busybox busybox
docker exec -it c68150755368 /bin/sh

# mono

# gcc
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp gcc:4.9 gcc -o myapp myapp.c
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp gcc:4.9 make

# node
docker run -it --rm --name my-running-script -v "$PWD":/usr/src/app -w /usr/src/app node:8 node your-daemon-or-script.js

<dockerfile>
FROM node:10
EXPOSE 8888

docker build -t my-nodejs-app .
docker run -it --rm --name my-running-app my-nodejs-app

# python
docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp python:3 python your-daemon-or-script.py

<dockerfile>
FROM python:3
WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD [ "python", "./your-daemon-or-script.py" ]

docker build -t my-python-app .
docker run -it --rm --name my-running-app my-python-app

# golang
docker run -itd --name golang golang:1.16 /bin/bash
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp golang:1.16 go build main.go

# ruby
## Generate a Gemfile.lock
docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:2.5 bundle install

## Run a single Ruby script
docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp ruby:2.5 ruby your-daemon-or-script.rb

<dockerfile>
FROM ruby:2.5
RUN bundle config --global frozen 1
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
CMD ["./your-daemon-or-script.rb"]

docker build -t my-ruby-app .
docker run -it --name my-running-script my-ruby-app

# bash
docker run -it --rm -v /path/to/script.sh:/script.sh:ro bash:4.4 bash /script.sh

<dockerfile>
FROM bash:4.4
COPY script.sh /
CMD ["bash", "/script.sh"]

docker build -t my-bash-app .
docker run -it --rm --name my-running-app my-bash-app

# java
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp openjdk:7 javac Main.java

<dockerfile>
FROM openjdk:7
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN javac Main.java
CMD ["java", "Main"]

docker build -t my-java-app .
docker run -it --rm --name my-running-app my-java-app

# jenkins
docker run -itd -p 8080:8080 -p 50000:50000 -v /root/jenkins:/var/jenkins_home jenkins/jenkins

# gitlab
docker run -d  -p 8443:443 -p 8081:80 -p 223:22 --name gitlab --restart always -v /home/gitlab/config:/etc/gitlab -v /home/gitlab/logs:/var/log/gitlab -v /home/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce