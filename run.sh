#!/usr/bin/env bash

# Check args
if [ "$#" -ne 3 ]; then
  echo 'usage: ./run.sh IMAGE_NAME $ROS_MASTER_URI COMMAND'
fi

# Get this script's path
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null
set -e

# Run the container with shared X11
docker run\
  --net=host\
  -e SHELL\
  -e DISPLAY\
  -e DOCKER=1\
  -v "$HOME:$HOME:rw"\
  -v "/mnt:/mnt"\
  -v "/tmp/.X11-unix:/tmp/.X11-unix:rw"\
  -it $1 bash -c "export ROS_MASTER_URI=$2 && $3" 
