#!/usr/bin/bash

username="$USER"
user="$(id -u)"
group="$(id -g)"
home=$HOME

imageName="al3x609/nvnc:latest"
containerName="nvnc-$(whoami)"
LISTEN_PORT=$1
DISPLAY_PORT=$2
displayVar=$DISPLAY_PORT-5900

xhost +

docker run -td --rm --name ${containerName}                 \
    --runtime=nvidia                                        \
    --user=${user}:${group}                                 \
    --hostname="$containerName"                             \
    -p $LISTEN_PORT:$LISTEN_PORT                            \
    -e NVIDIA_DRIVER_CAPABILITIES=all                       \
    -e NVIDIA_VISIBLE_DEVICES=all                           \
    -e USER=${username}                                     \
    -e DISPLAY=":${displayvar}"                             \
    -e QT_X11_NO_MITSHM=1                                   \
    -e VGL_LOGO=1                                           \
    -e QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb                \
    -e LIBGL_DEBUG=verbose                                  \
    --workdir="${home}"                                     \
    --volume="${home}:${home}"                              \
    --volume="/etc/group:/etc/group:ro"                     \
    --volume="/etc/passwd:/etc/passwd:ro"                   \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro"             \
    --volume="${home}/.Xauthority:${home}/.Xauthority:ro"   \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" ${imageName} setup.sh $LISTEN_PORT 192.168.66.25:$DISPLAY_PORT
xhost -
