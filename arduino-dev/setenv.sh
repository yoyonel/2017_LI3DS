#!/bin/bash

DOCKER_TAG=arduino-dev
DOCKER_BUILD_TAG=li3ds/${DOCKER_TAG}:latest

DOCKER_BUILD_OPTIONS=" --rm "
#DOCKER_BUILD_OPTIONS+=" --no-cache "

#
DOCKER_RUN_OPTIONS+=" -it --rm "
#DOCKER_RUN_OPTIONS+=" --no-cache "

# url: https://docs.docker.com/engine/tutorials/dockervolumes/
DOCKER_RUN_OPTIONS+=" -v li3ds_dev_catkin_ws:/root/catkin_ws "
DOCKER_RUN_OPTIONS+=" -v li3ds_dev_overlay_ws:/root/overlay_ws "
#
DOCKER_RUN_OPTIONS+=" --privileged -v /dev/bus/usb:/dev/bus/usb"