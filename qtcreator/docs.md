docker volume create --driver local --name li3ds_dev_overlay_ws 
docker volume create --driver local --name li3ds_dev_catkin_ws

1. On réunit les sources dans un même répertoire
par exemple: ~/overlay_ws/src/.
(
	$ cp -r ins/overlay_ws/src/* overlay_ws/src/.
	$ cp -r laser/overlay_ws/src/* overlay_ws/src/.
	...
)

2. On gère les dépendances
	$ rosdep install -y --from-paths ${ROS_OVERLAY_WS} --ignore-src --rosdistro indigo
ps: faudrait pouvoir le faire une fois pour toute ! (l'enregistrer dans l'image dev)
car peut être assez long, en particulier, les dépendances liées au laser.	

3. Initialisation du catkin_ws
3.1 Lien vers les sources
	pushd $ROS_CATKIN_WS

	# url: http://stackoverflow.com/questions/59838/check-if-a-directory-exists-in-a-shell-script
	if [ -d src ]; then
		echo_c "${YELLOW}'src/' already exist !${NC}";
		rm -r src	
	fi
	#
	mkdir -p $ROS_CATKIN_WS/src
	catkin_init_workspace src;
3.2
	S'assurer qu'il n'y ait pas de résidus de compilation/cmake
	Méthode sure: $ rm - build/ && mkdir build
	Méthode plus légère: $ rm build/CMakeCache.txt

4. Configuration du CMakeLists.txt
	cd $ROS_CATKIN_WS/src

	#################################################
	# remove the symbolic link
	#################################################
	sed -i '' CMakeLists.txt

	#################################################
	# patch into CMakeLists.txt 
	# to have all files availables in QtCreator IDE
	#################################################
	echo '

	#################################################
	# url: http://wiki.ros.org/IDEs#QtCreator
	#################################################
	# Add all files in subdirectories of the project in
	# a dummy_target so qtcreator have access to all files
	FILE(GLOB children ${CMAKE_SOURCE_DIR}/*)
	FOREACH(child ${children})
	  IF(IS_DIRECTORY ${child})
	    file(GLOB_RECURSE dir_files "${child}/*")
	    LIST(APPEND extra_files ${dir_files})
	  ENDIF()
	ENDFOREACH()
	add_custom_target(dummy_${PROJECT_NAME} SOURCES ${extra_files})
	#################################################
	' >> CMakeLists.txt

5. Effectuer une compilation catkin du workspace

Lien symbolique des sources (overlay_ws) dans catkin_ws/src
$ ln -s ${ROS_OVERLAY_WS}/src ${ROS_CATKIN_WS}/src/.

(Compilation par catkin_make)

Lancement de qtcreator:
$ qtcreator.sh ${ROS_CATKIN_WS}/src/.

Il reste à transferer une font qui va bien

Transférer des settings de QtCreator qui vont bien (font, hightlight, ...)

./qtcreator-4.2.1/bin/qtcreator.sh -noload Welcome -noload QmlDesigner -noload QmlProfiler
${ROS_CATKIN_WS}/src/.
-DCATKIN_DEVEL_PREFIX=/root/catkin_ws/devel -DCMAKE_INSTALL_PREFIX=/root/catkin_ws/install -G Unix Makefiles

/opt/qt57/bin/qtcreator-wrapper -noload Welcome -noload QmlDesigner -noload QmlProfiler

	#!/bin/sh -e
	#
	# rc.local
	#
	# This script is executed at the end of each multiuser runlevel.
	# Make sure that the script will "exit 0" on success or any other
	# value on error.
	#
	# In order to enable or disable this script just change the execution
	# bits.
	#
	# By default this script does nothing.

	echo 0 | tee /proc/sys/kernel/yama/ptrace_scope

	exit 0

https://github.com/ros-industrial/ros_qtc_plugin/wiki/3.-Setup-Qt-Creator-for-ROS


cd catkin_ws
catkin init --workspace ../overlay_ws
ln -s ${ROS_OVERLAY_WS}/src .
catkin config --init
catkin build
catkin build


urls:
- http://answers.ros.org/question/67244/qtcreator-with-catkin/

- http://forum.teamspeak.com/threads/122127-quot-QSslSocket-cannot-resolve-SSLv2_client_method-quot-Can-t-connect-to-any-server
-- http://askubuntu.com/questions/77256/i-want-to-install-libssl-0-9-8

- https://github.com/ros-industrial/ros_qtc_plugin
-- https://github.com/ros-industrial/ros_qtc_plugin/wiki/1.-How-to-Install-(Users)
-- http://askubuntu.com/questions/493460/how-to-install-add-apt-repository-using-the-terminal
-- https://github.com/ros-industrial/ros_qtc_plugin/issues/46
-- https://launchpad.net/~beineri/+archive/ubuntu/opt-qt571-trusty
-- https://github.com/alexpana/qt-creator-wombat-theme
-- http://doc.qt.io/qtcreator/creator-clang-codemodel.html

- http://wiki.ros.org/rosserial_arduino/Tutorials/CMake