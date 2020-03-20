# Webots-Docker
## Setup
Clone this repository and build the docker image with:
````
./build.sh
````
## Run
Open a terminal and run:
````
./launch.sh
````
Open a browser and connect to Jupyter lab at the address [http://localhost:8888](http://localhost:8888)

Open a terminal in Jupyter lab and run:
````
./launch_webots.sh <WORLD>
````

where `<WORLD>` is the complete path of the world file to simulate.
  
Open a new broser tab/window, and open the file `index.html`.

Press the `connect` button, and that's it! (the left buttoms of the botton line don't work, though)
