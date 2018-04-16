#!/bin/bash

trap printout SIGINT SIGTERM SIGHUP
printout() {

    /opt/TurboVNC/bin/vncserver -kill :$DISPLAY_NUM > /dev/null 2>&1
    sleep 1
    docker stop "pview-$(whoami)" 2>/dev/null
    docker stop "nvnc-$(whoami)" 2>/dev/null
     sleep 2
    docker rm "pview-$(whoami)" 2>/dev/null
    docker rm "nvnc-$(whoami)" 2>/dev/null
    exit
}

DISPLAY_NUM=1

for i in {1..10};do
        if [ -e /tmp/.X$DISPLAY_NUM-lock ]
            then
                    let DISPLAY_NUM=$DISPLAY_NUM+1
                    continue
        else
            /opt/TurboVNC/bin/vncserver  :$DISPLAY_NUM \
                -name "Paraview [$(whoami)]"   \
                -fg                            \
                -geometry 1200x720             \
                -nohttpd                       \
                -noxstartup                    \
                -nevershared                   \
                -interframe                                        \
                -mt                            \
                -nthreads 4
            break
        fi
done

#-------------------------
LISTEN_PORT=6080
let DISPLAY_PORT=5900+$DISPLAY_NUM

for i in {1..10};do
        if [ $(netstat -ltn | grep -qs ":$LISTEN_PORT .*LISTEN") ]
        then
                let LISTEN_PORT=$LISTEN_PORT+1
                continue
        else
                break
        fi
done

echo "*****************************************************************************"
echo "  Bienvenido $(whoami)                                                       "
echo "  DISPLAY asignada: ${DISPLAY_PORT}                                          "
echo "  puerto para el tunel $LISTEN_PORT                                          "
echo "  ssh -l <user> -L 15000:ngrid:$LISTEN_PORT  <URI>                           "
echo "  y ingrese el password generado                                             "
echo "-----------------------------------------------------------------------------"

export DISPLAY=:$DISPLAY_NUM && /data/docker/novnc/./run_nvnc.sh $LISTEN_PORT $DISPLAY_PORT && \

#--------------
export DISPLAY=:$DISPLAY_NUM && ./run_pv.sh

sleep 1.5

/opt/TurboVNC/bin/vncserver -kill :$DISPLAY_NUM
