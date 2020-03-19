#!/bin/sh

docker run --rm \
    -p 1234:1234 \
    -p 8888:8888 \
    webots-docker
