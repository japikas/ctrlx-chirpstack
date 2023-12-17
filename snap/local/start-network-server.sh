#!/bin/bash

CONFIG_PATH=$SNAP_COMMON/solutions/activeConfiguration/chirpstack
CONFIG_FILE=$CONFIG_PATH/network-server.conf

while ! snapctl is-connected active-solution
do
    echo "Active configuration not ready yet, sleep for 5 secs.."
    sleep 5
done

if [ ! -d CONFIG_PATH ]
then
    echo "Configuration folder does not exists. Create $CONFIG_PATH"
    mkdir $CONFIG_PATH
fi

if [ ! -e CONFIG_PATH/network-server.conf ]
then
    echo "Configuration file $CONFIG_PATH/network-server.conf does not exists. Copy default."
    cp $SNAP/network-server.conf $CONFIG_PATH/
fi

echo "Start network-server"
$SNAP/bin/chirpstack-network-server -c $CONFIG_FILE $@
