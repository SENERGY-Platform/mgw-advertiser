#!/bin/sh

sed -i "s/__PREFIX__/${MGW_NAME_PREFIX:-}/g" $AVAHI_SRV_PATH/mgw.service
sed -i "s/__SERIAL__/$MGW_SERIAL/g" $AVAHI_SRV_PATH/mgw.service
