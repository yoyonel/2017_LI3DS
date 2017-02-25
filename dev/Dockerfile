# DEV

FROM li3ds/ros:indigo

USER root
WORKDIR /root
ENV HOME /root

ENV LI3DS_ROOT_PATH /root
ENV ROS_OVERLAY_WS="/root/overlay_ws"
ENV ROS_CATKIN_WS="/root/catkin_ws"

#
COPY scripts /root/scripts
RUN chmod +x /root/scripts/*.sh

#### Gere les dépendances ROS/APT du projet ####
RUN /bin/bash -c "source scripts/create_overlay_ws.sh"
# SHELL ["scripts/create_overlay_ws.sh"]

WORKDIR overlay_ws

RUN /bin/bash -c "source /opt/ros/indigo/setup.bash"

# urls: 
# - http://docs.ros.org/independent/api/rosdep/html/commands.html#rosdep-usage
# - http://docs.ros.org/independent/api/rosdep/html/commands.html#options
RUN rosdep install --default-yes --from-paths ${ROS_OVERLAY_WS} --ignore-src --rosdistro indigo
####

VOLUME ["li3ds_dev_catkin_ws:/root/catkin_ws"]

### Mise en place du Workspace pour Catkin
RUN mkdir -p ${ROS_CATKIN_WS};

WORKDIR ${ROS_CATKIN_WS}
RUN catkin init --workspace ${ROS_OVERLAY_WS}
RUN ln -s ${ROS_OVERLAY_WS}/src .
RUN catkin config --init
RUN bash -c "source /opt/ros/indigo/setup.bash	\
	&& catkin build	|| true							\
	&& catkin build || true"

WORKDIR /root/

# ENTRYPOINT ["/root/entry-point.sh"]
# CMD ["bash"]