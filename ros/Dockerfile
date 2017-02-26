FROM ros:indigo-ros-core

WORKDIR /root

# Target pour le DEV
# TODO: faudra en faire une (optimisée) pour l'exécution

### CONFIGS
# APT CONF
COPY apt.conf /etc/apt/apt.conf
# GIT CONFIG
COPY .gitconfig .

### APT
# Tools for building
RUN apt-get update && 			\
    apt-get install -y 			\
    realpath					\
    build-essential				\
    curl						\
	python-rosinstall-generator	\
	usbutils
# TODO: effacer le cache apt

### CMAKE
COPY cmake-3.8.0-rc1.tar.Z /cmake-3.8.0-rc1.tar.Z
RUN tar xzvf /cmake-3.8.0-rc1.tar.Z
RUN cd cmake-3.8.0-rc1 && ./configure && make -j3 && make install
RUN rm /cmake-3.8.0-rc1.tar.Z && rm -r cmake-3.8.0-rc1

### Install Zsh
RUN apt-get update && 			\
    apt-get install -y 			\
    zsh
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
      && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
      && chsh -s /bin/zsh

### add-apt-repository
RUN apt-get install -y software-properties-common


### catkin_tools
RUN apt-get install -y python-catkin-tools

### wget & pip
RUN apt-get install -y wget python-pip

### VIM: Fisa
#
RUN apt-get install -y curl vim exuberant-ctags git ack-grep
RUN pip install pep8 flake8 pyflakes isort yapf
# url: http://stackoverflow.com/questions/1078524/how-to-specify-the-location-with-wget
RUN wget https://raw.github.com/fisadev/fisa-vim-config/master/.vimrc -O ~/.vimrc
#
COPY .vim /root/.vim
COPY .viminfo /root/.viminfo

# ROSSerial - Arduino
RUN apt-get install -y  \
    ros-indigo-rosserial-arduino \
    ros-indigo-rosserial

# # Purge/clean apt
# RUN apt-get clean                   \
# 	&& rm -rf /var/lib/apt/lists/*