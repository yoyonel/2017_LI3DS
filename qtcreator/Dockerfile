FROM li3ds/dev

# url: https://github.com/phusion/baseimage-docker/issues/58
ENV DEBIAN_FRONTEND noninteractive

USER root
ENV HOME /root

### Qt57 + QtCreator 
# urls
# - https://github.com/ros-industrial/ros_qtc_plugin/wiki/1.-How-to-Install-(Users)
# - https://github.com/ros-industrial/ros_qtc_plugin/wiki/3.-Setup-Qt-Creator-for-ROS
# - https://github.com/alexpana/qt-creator-wombat-theme
#
# PPAs to access to: qt57creator(-plugin-ros)
RUN add-apt-repository ppa:beineri/opt-qt571-trusty
RUN add-apt-repository ppa:levi-armstrong/qt-libraries-trusty
RUN add-apt-repository ppa:levi-armstrong/ppa  
# Install packages
RUN apt-get update &&	\
	apt-get install -y 	\
		qt57creator 	\
		qt57creator-plugin-ros

### Setup Clang Formatting
RUN apt-get install -y	\
	clang-format-3.6

### CONFIG
## Qt configs
COPY .config /root/.config

### FONT
COPY .fonts/SourceCodePro+Powerline+AwesomeRegular+Docker.ttf /root/.fonts/SourceCodePro+Powerline+AwesomeRegular+Docker.ttf
RUN fc-cache fv

###
RUN export uid=1000 gid=1000 && \
    mkdir -p /root && \
    echo "root:x:${uid}:${gid}:root,,,:/root:/bin/zsh" >> /etc/passwd && \
    echo "root:x:${uid}:" >> /etc/group && \
    echo "root ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/root && \
    chmod 0440 /etc/sudoers.d/root && \
    chown ${uid}:${gid} -R /root

# url: http://www.torkwrench.com/2011/12/16/d-bus-library-appears-to-be-incorrectly-set-up-failed-to-read-machine-uuid-failed-to-open-varlibdbusmachine-id/
RUN apt-get install -y dbus
RUN dbus-uuidgen > /var/lib/dbus/machine-id

# COPY qtcreator-4.2.1 /root/qtcreator-4.2.1
COPY entry-point.sh /root/entry-point.sh
COPY launch_qtcreator.sh /root/launch_qtcreator.sh
RUN chmod +x entry-point.sh launch_qtcreator.sh

ENV LI3DS_ROOT_PATH /root
ENV ROS_OVERLAY_WS="/root/overlay_ws"
ENV ROS_CATKIN_WS="/root/catkin_ws"
ENV CURRENT_CMAKE_BUILD_DIR="$(catkin locate --workspace ${ROS_CATKIN_WS} --build)"

ENTRYPOINT ["/root/entry-point.sh"]
CMD ["/root/launch_qtcreator.sh"]