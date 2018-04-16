#!/bin/bash

PORT="$1"
VNC_DEST="$2"
# CERT=""
# WEB=""
# proxy_pid=""
# SSLONLY=""

cd /opt/noVNC && ./utils/launch.sh --vnc $VNC_DEST --listen $PORT
