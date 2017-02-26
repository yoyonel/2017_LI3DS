#!/bin/bash

DOCKER_BUILD_OPTIONS="--rm"
#DOCKER_BUILD_OPTIONS+="--no-cache"
DOCKER_BUILD_TAG=li3ds/qtcreator

DOCKER_RUN_OPTIONS=" -it "
DOCKER_RUN_OPTIONS+=" --rm "

DOCKER_RUN_OPTIONS+=" -e DISPLAY=$DISPLAY "
DOCKER_RUN_OPTIONS+=" -v /tmp/.X11-unix:/tmp/.X11-unix "

DOCKER_RUN_OPTIONS+=" -v li3ds_dev_overlay_ws:/root/overlay_ws "
DOCKER_RUN_OPTIONS+=" -v li3ds_dev_catkin_ws:/root/catkin_ws "

DOCKER_RUN_OPTIONS+=" -v $(realpath .config):/root/.config "
# url: https://forums.docker.com/t/gdb-breakpoints-dont-work-error-disabling-address-space-randomization/14365/2
DOCKER_RUN_OPTIONS+=" --security-opt seccomp=unconfined "