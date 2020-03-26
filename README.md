# Webots-Docker

## Prerequisites
Docker [with NVIDIA support](https://github.com/NVIDIA/nvidia-docker).

## Setup
Clone this repository and build the docker image with:
````
./build.sh
````
Or pull a pre-built image with:
````
docker pull ecervera/webots-docker:R2020a
````

## Run
Open a terminal and run:
````
./launch.sh
````

In a browser, open this link: [http://localhost:8888/lab/tree/index.ipynb](http://localhost:8888/lab/tree/index.ipynb)

In JupyterLab, launch the Webots simulator.

In the browser, open the file `index.html` of this repository, and connect to the web streaming of Webots.
