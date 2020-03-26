#!/bin/sh

xhost +local:root

docker run --rm \
    --gpus all \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -p 1234:1234 \
    -p 8888:8888 \
    webots-docker

xhost -local:root

