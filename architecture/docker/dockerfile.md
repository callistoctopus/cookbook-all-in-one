FROM nginx
# 定制的镜像都是基于 FROM 的镜像，这里的 nginx 就是定制需要的基础镜像。后续的操作都是基于 nginx。

RUN echo '这是一个本地构建的nginx镜像' > /usr/share/nginx/html/index.html
# 用于执行后面跟着的命令行命令。有以下俩种格式：
# RUN <命令行命令>
# RUN ["可执行文件", "参数1", "参数2"]

COPY hom* /mydir/
COPY hom?.txt /mydir/
# 复制指令，从上下文目录中复制文件或者目录到容器里指定路径。
# 格式：
# COPY [--chown=<user>:<group>] <源路径1>...  <目标路径>
# [--chown=<user>:<group>]：可选参数，用户改变复制到容器内文件的拥有者和属组。

CMD ["/etc/nginx/nginx.conf"]
# 为启动的容器指定默认要运行的程序，程序运行结束，容器也就结束。CMD 指令指定的程序可被 docker run 命令行参数中指定要运行的程序所覆盖。
# 如果 Dockerfile 中如果存在多个 CMD 指令，仅最后一个生效。
# 类似于 RUN 指令，用于运行程序，但二者运行的时间点不同:
# CMD 在docker run 时运行。
# RUN 是在 docker build。

ENTRYPOINT ["nginx", "-c"]
# 类似于 CMD 指令，但其不会被 docker run 的命令行参数指定的指令所覆盖，而且这些命令行参数会被当作参数送给 ENTRYPOINT 指令指定的程序。
# 如果 Dockerfile 中如果存在多个 ENTRYPOINT 指令，仅最后一个生效。
# 格式：
# ENTRYPOINT ["<executeable>","<param1>","<param2>",...]
# 可以搭配 CMD 命令使用：一般是变参才会使用 CMD ，这里的 CMD 等于是在给 ENTRYPOINT 传参
# 示例：
# ENTRYPOINT ["nginx", "-c"] # 定参
# CMD ["/etc/nginx/nginx.conf"] # 变参

ENV NODE_VERSION 7.2.0
# 设置环境变量，定义了环境变量，那么在后续的指令中，就可以使用这个环境变量。
# 格式：
# ENV <key> <value>
# ENV <key1>=<value1> <key2>=<value2>...

ARG DBPATH=/usr/config/mydb
# 构建参数，与 ENV 作用一至。不过作用域不一样。ARG 设置的环境变量仅对 Dockerfile 内有效，也就是说只有 docker build 的过程中有效，构建好的镜像内不存在此环境变量。
# 构建命令 docker build 中可以用 --build-arg <参数名>=<值> 来覆盖。
# 格式：
# ARG <参数名>[=<默认值>]

VOLUME /usr/data
# 定义匿名数据卷。在启动容器时忘记挂载数据卷，会自动挂载到匿名卷。
# 在启动容器 docker run 的时候，我们可以通过 -v 参数修改挂载点。
# 作用：
# 避免重要的数据，因容器重启而丢失，这是非常致命的。
# 避免容器不断变大。
# 格式：
# VOLUME ["<路径1>", "<路径2>"...]
# VOLUME <路径>

EXPOSE 65521
# 仅仅只是声明端口。
# 作用：
# 帮助镜像使用者理解这个镜像服务的守护端口，以方便配置映射。
# 在运行时使用随机端口映射时，也就是 docker run -P 时，会自动随机映射 EXPOSE 的端口。
# 格式：
# EXPOSE <端口1> [<端口2>...]

WORKDIR /usr/work
# 指定工作目录。用 WORKDIR 指定的工作目录，会在构建镜像的每一层中都存在。（WORKDIR 指定的工作目录，必须是提前创建好的）。
# docker build 构建镜像过程中的，每一个 RUN 命令都是新建的一层。只有通过 WORKDIR 创建的目录才会一直存在。
# 格式：
# WORKDIR <工作目录路径>

USER root
# 用于指定执行后续命令的用户和用户组，这边只是切换后续命令执行的用户（用户和用户组必须提前已经存在）。
# 格式：
# USER <用户名>[:<用户组>]

HEALTHCHECK CMD ps
# 用于指定某个程序或者指令来监控 docker 容器服务的运行状态。
# 格式：
# HEALTHCHECK [选项] CMD <命令>：设置检查容器健康状况的命令
# HEALTHCHECK NONE：如果基础镜像有健康检查指令，使用这行可以屏蔽掉其健康检查指令
# HEALTHCHECK [选项] CMD <命令> : 这边 CMD 后面跟随的命令使用，可以参考 CMD 的用法。

ONBUILD RUN rm -rf /usr/*
# 用于延迟构建命令的执行。简单的说，就是 Dockerfile 里用 ONBUILD 指定的命令，在本次构建镜像的过程中不会执行（假设镜像为 test-build）。
# 当有新的 Dockerfile 使用了之前构建的镜像 FROM test-build ，这是执行新镜像的 Dockerfile 构建时候，会执行 test-build 的 Dockerfile 里的 ONBUILD 指定的命令。
# 格式：
# ONBUILD <其它指令>