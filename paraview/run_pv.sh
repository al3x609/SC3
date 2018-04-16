#!/usr/bin/bash

username="$USER"
user="$(id -u)"
group="$(id -g)"
home="${1:-$HOME}"

imageName="al3x609/paraview:5.5"
containerName="pview-$(whoami)"

displayVar="$DISPLAY"

xhost +

docker run -ti --rm --name ${containerName}                 \
    --runtime=nvidia                                        \
    --hostname="$containerName"                             \
    --user=${user}:${group}                                 \
    -e NVIDIA_DRIVER_CAPABILITIES=all                       \
    -e NVIDIA_VISIBLE_DEVICES=all                           \
    -e USER=${username}                                     \
    -e DISPLAY=${displayVar}                                \
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
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" ${imageName} vglrun paraview
 #--net=host ${imageName} /bin/bash

xhost -
