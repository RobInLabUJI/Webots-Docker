FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04

################################## JUPYTERLAB ##################################

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update \
 && apt-get install -yq --no-install-recommends \
	locales wget bzip2 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

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

USER ${NB_USER}

WORKDIR ${HOME}

EXPOSE 8888
 
 #################################### WEBOTS ####################################

RUN mkdir ${HOME}/webots

RUN wget --no-check-certificate https://github.com/cyberbotics/webots/releases/download/R2020a-rev1/webots-R2020a-rev1-x86-64.tar.bz2 \
 && tar xjf webots-R2020a-rev1-x86-64.tar.bz2 \
 && rm webots-R2020a-rev1-x86-64.tar.bz2

USER root
 
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

 RUN apt-get update \
  && apt-get install -yq --no-install-recommends \
  xvfb lsb-release wget unzip zip libnss3 libnspr4 libxcomposite1 libxcursor1 \
  libxi6 libxrender1 libxss1 libasound2 libdbus-1-3 xserver-xorg-video-dummy \
  xpra xorg-dev libgl1-mesa-dev mesa-utils libgl1-mesa-glx xvfb libxkbcommon-x11-dev \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

################################## JUPYTERLAB ##################################

RUN apt-get update \
 && apt-get install -yq --no-install-recommends \
    cmake git build-essential python-pip \
    python3-pip python3-setuptools \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip setuptools \
 && python3 -m pip install jupyterlab

RUN pip3 install bash_kernel \
  && python3 -m bash_kernel.install
  
ADD index.ipynb ${HOME}
RUN chown jovyan.jovyan ${HOME}/index.ipynb

CMD ["jupyter", "lab", "--no-browser", "--ip=0.0.0.0", "--NotebookApp.token=''"]

USER ${NB_USER}

EXPOSE 1234
