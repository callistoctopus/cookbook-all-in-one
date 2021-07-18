https://google.github.io/mediapipe/


# install mediapipe on centos

1. Install Bazelisk.
## Installing Bazel on CentOS
yum -y update
curl https://copr.fedorainfracloud.org/coprs/vbatts/bazel/repo/epel-7/vbatts-bazel-epel-7.repo -o vbatts-bazel-epel-7.repo
cp vbatts-bazel-epel-7.repo /etc/yum.repos.d/
yum -y install bazel4

cd "/usr/bin" && curl -fLO https://releases.bazel.build/3.7.2/release/bazel-3.7.2-linux-x86_64 && chmod +x bazel-3.7.2-linux-x86_64

2. Checkout MediaPipe repository
yum -y install git
git clone https://github.com/google/mediapipe.git
cd mediapipe

3. Install OpenCV
//yum -y install opencv-devel
## Install minimal prerequisites
yum install -y cmake wget unzip
yum install gcc-c++
## Download and unpack sources
wget -O opencv.zip https://github.com/opencv/opencv/archive/master.zip
unzip opencv.zip
## Create build directory
mkdir -p build && cd build
## Configure
cmake  ../opencv-master
## Build
cmake --build .
## Install
make install

<WORKSPACE>
new_local_repository(
    name = "linux_opencv",
    build_file = "@//third_party:opencv_linux.BUILD",
    path = "/usr/local",
)

new_local_repository(
    name = "linux_ffmpeg",
    build_file = "@//third_party:ffmpeg_linux.BUILD",
    path = "/usr/local",
)

<opencv_linux.BUILD>
cc_library(
    name = "opencv",
    srcs = glob(
        [
            "lib/libopencv_core.so",
            "lib/libopencv_highgui.so",
            "lib/libopencv_imgcodecs.so",
            "lib/libopencv_imgproc.so",
            "lib/libopencv_video.so",
            "lib/libopencv_videoio.so",
        ],
    ),
    hdrs = glob([
        # For OpenCV 3.x
        "include/opencv2/**/*.h*",
        # For OpenCV 4.x
        # "include/opencv4/opencv2/**/*.h*",
    ]),
    includes = [
        # For OpenCV 3.x
        "include/",
        # For OpenCV 4.x
        # "include/opencv4/",
    ],
    linkstatic = 1,
    visibility = ["//visibility:public"],
)

<ffmpeg_linux.BUILD>
cc_library(
    name = "libffmpeg",
    srcs = glob(
        [
            "lib/libav*.so",
        ],
    ),
    hdrs = glob(["include/libav*/*.h"]),
    includes = ["include"],
    linkopts = [
        "-lavcodec",
        "-lavformat",
        "-lavutil",
    ],
    linkstatic = 1,
    visibility = ["//visibility:public"],
)

4. Run the Hello World! in C++ example.
pip3 install numpy

bazel build -c opt \
  --define MEDIAPIPE_DISABLE_GPU=1 \
  --action_env PYTHON_BIN_PATH=$(which python3) \
  mediapipe/examples/desktop/hello_world

bazel run --define MEDIAPIPE_DISABLE_GPU=1 \
    mediapipe/examples/desktop/hello_world:hello_world


# install mediapipe on docker

## hello world in c++
1. Install Docker
   
2. Build a docker image
yum -y install git
git clone https://github.com/google/mediapipe.git
cd mediapipe
docker build --tag=mediapipe .
docker run -it --name mediapipe mediapipe:latest

3. >Run the Hello World! in C++ example.
   GLOG_logtostderr=1 bazel run --define MEDIAPIPE_DISABLE_GPU=1 mediapipe/examples/desktop/hello_world:hello_world

   >android
   docker exec -it mediapipe /bin/bash
   bash ./setup_android_sdk_and_ndk.sh
   bazel build -c opt --config=android_arm64 mediapipe/examples/android/src/java/com/google/mediapipe/apps/objectdetectiongpu:objectdetectiongpu