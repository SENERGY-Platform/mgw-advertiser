#!/bin/sh

set -e

changeConfOption() {
    if [ -n "$(grep -E $1 $3)" ]; then
        echo "set $1 -> $2"
        sed -i "/$1/s/.*/$1=$2/" $3
    fi
}


CONFIG=/etc/avahi/avahi-daemon.conf

changeConfOption "enable-dbus" "no" $CONFIG

for env_var in $(env); do
    if [ -n "$(echo $env_var | grep -E '^AD_')" ]; then
        name=$(echo "$env_var" | sed -r "s/AD_([^=]*)=.*/\1/g" | sed -e "s/\(.*\)/\L\1/" | sed -e 's:_:-:g')
        env_var_name=$(echo "$env_var" | sed -r "s/([^=]*)=.*/\1/g")
        value=$(printenv $env_var_name)
        changeConfOption $name $value $CONFIG
    fi
done

avahi-daemon

