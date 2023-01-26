#!/bin/sh

changeConfOption() {
	if [ -n "$(grep -E $1 $AVAHI_CONF_PATH)" ]; then
		echo "$1 -> $2"
		sed -i "/$1/s/.*/$1=$2/" $AVAHI_CONF_PATH
	fi
}

echo "******** mgw-advertiser ********"
cat $MGW_ADVER_PATH/git_commit

if [ ! -f "$MGW_ADVER_PATH/init" ]; then
	echo "setting avahi-daemon config options ..."
	changeConfOption "enable-dbus" "no"
	for env_var in $(env); do
	    if [ -n "$(echo $env_var | grep -E '^AD_')" ]; then
		name=$(echo "$env_var" | sed -r "s/AD_([^=]*)=.*/\1/g" | sed -e "s/\(.*\)/\L\1/" | sed -e 's:_:-:g')
		env_var_name=$(echo "$env_var" | sed -r "s/([^=]*)=.*/\1/g")
		value=$(printenv $env_var_name)
		changeConfOption $name $value
	    fi
	done
	echo "running scripts ..."
	for f in $MGW_ADVER_PATH/scripts/*
	do
		if [ -f "$f" ]; then
			name="${f##*/}"
			err=$(.$f 2>&1 > /dev/null)
			if [ "$?" -gt "0" ]; then
				echo "$name -> Err"
				if [ ! -z "${err}" ]; then
					echo "'->" $err
				fi
			else
				echo "$name -> Ok"
			fi
		fi
	done
	touch $MGW_ADVER_PATH/init
fi

echo "starting avahi-daemon ..."

exec avahi-daemon -k

