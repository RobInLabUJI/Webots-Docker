FROM ros:melodic-ros-base

ARG NB_USER="jovyan"
ARG NB_UID="1000"
ARG NB_GID="100"

USER root

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update \
 && apt-get install -yq --no-install-recommends \
    locales cmake git build-essential python-pip python-setuptools \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

RUN python -m pip install --upgrade pip setuptools

RUN python -m pip install jupyterlab

ENV SHELL=/bin/bash \
	NB_USER=jovyan \
	NB_UID=1000 \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8

ENV HOME=/home/${NB_USER}

RUN adduser --disabled-password \
	--gecos "Default user" \
	--uid ${NB_UID} \
	${NB_USER}

EXPOSE 8888

# Webots

RUN apt-get update \
 && apt-get install -yq --no-install-recommends \
    openjdk-8-jdk git g++ cmake libusb-dev swig python2.7-dev \
    libglu1-mesa-dev libglib2.0-dev libfreeimage-dev libfreetype6-dev \
    libxml2-dev libzzip-0-13 libssh-gcrypt-dev libssl1.0-dev libboost-dev \
    libjpeg8-dev libavcodec-extra libpci-dev libgd-dev libtiff5-dev libzip-dev \
    libreadline-dev libassimp-dev libpng-dev ffmpeg python3.6-dev \
    python3.7-dev npm libxslt1-dev libssh-4 pbzip2 \
    lsb-release wget unzip zip libnss3 libnspr4 libxcomposite1 libxcursor1 \
    libxi6 libxrender1 libxss1 libasound2 libdbus-1-3 xserver-xorg-video-dummy \
    xpra xorg-dev libgl1-mesa-dev mesa-utils libgl1-mesa-glx xvfb libxkbcommon-x11-dev \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_USER}

WORKDIR ${HOME}

RUN cd ${HOME} \
 && git clone https://github.com/cyberbotics/webots.git \
 && cd ${HOME}/webots \
 && export WEBOTS_HOME=${HOME}/webots \
 && export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
 && git submodule init \
 && git submodule update

RUN cd ${HOME}/webots \
 && export WEBOTS_HOME=${HOME}/webots \
 && export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
 && make -j1

EXPOSE 1234

ADD launch_webots.sh /home/jovyan/

CMD ["jupyter", "lab", "--no-browser", "--ip=0.0.0.0", "--NotebookApp.token=''"]