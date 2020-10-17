#!/bin/bash

FRP_COMPONENT=$1
shift

FRP_HOME=${FRP_HOME:-/opt/frp}
if [ "$FRP_COMPONENT" = "frps" ]; then
    $FRP_HOME/bin/frps -c $FRP_HOME/conf/frps.ini $@
elif [ "$FRP_COMPONENT" = "frpc" ]; then
    $FRP_HOME/bin/frpc -c $FRP_HOME/conf/frpc.ini $@
else
    $@
fi