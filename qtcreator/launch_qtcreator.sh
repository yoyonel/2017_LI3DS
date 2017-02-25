#!/bin/bash

source entry-point.sh

/opt/qt57/bin/qtcreator-wrapper 										\
	-noload Welcome 													\
	-noload QmlDesigner 												\
	-noload QmlProfiler 												\
	-stylesheet=/root/.config/QtProject/qtcreator/styles/stylesheet.css