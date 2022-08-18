#!/bin/sh

sed -i "s/__PREFIX__/${MGW_NAME_PREFIX:-}/g" $AVAHI_SRV_PATH/mgw.service

if [ -z "${MGW_SERIAL}" ]; then
  >&2 echo "missing serial number"
  exit 61
fi

sed -i "s/__SERIAL__/$MGW_SERIAL/g" $AVAHI_SRV_PATH/mgw.service
