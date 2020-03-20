#!/bin/sh
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <WORLD>" >&2
  exit 1
fi

export WEBOTS_HOME=$HOME/webots
export AUDIODEV=null
export DEBIAN_FRONTEND=noninteractive
export DISPLAY=:99
export LIBGL_ALWAYS_SOFTWARE=true
Xvfb :99 -screen 0 1024x768x16 &
./webots/webots --stdout --stderr --batch --no-sandbox --stream $1