#!/bin/bash

CONFIG_PATH=$SNAP_COMMON/solutions/activeConfiguration/chirpstack
CONFIG_FILE=$CONFIG_PATH/application-server.conf

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

if [ ! -e CONFIG_PATH/application-server.conf ]
then
    echo "Configuration file $CONFIG_PATH/application-server.conf does not exists. Copy default."
    cp $SNAP/application-server.conf $CONFIG_PATH/
fi

echo "Start network-server"
$SNAP/bin/chirpstack-application-server -c $CONFIG_FILE $@
