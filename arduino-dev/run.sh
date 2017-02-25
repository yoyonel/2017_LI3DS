#!/bin/bash

source entry-point.sh

rosrun rosserial_python serial_node.py /dev/ttyACM0 _baud:=115200