#!/bin/bash
IFS="
"
role="Management Switch";
site="TEB2";
echo "name,device_role,tenant,manufacturer,model_name,platform,serial,asset_tag,status,site,rack_group,rack_name,position,face,comments"
for i in $(echo "select hostname, sysName, version, hardware, os, serial from devices order by hardware;"|mysql -s observium); do
	host="$(echo "$i"|cut -d"	" -f1)"
	name="$(echo "$i"|cut -d"	" -f2)"
	ver="$(echo "$i"|cut -d"	" -f3)"
	type="$(echo "$i"|cut -d"	" -f4)"
	os="$(echo "$i"|cut -d"	" -f5)"
	ser="$(echo "$i"|cut -d"	" -f6)"
	if [ "$os" = "nxos" ]; then
		os="Cisco NX-OS"
	elif [ "$os" = "ios" ]; then
		os="Cisco IOS"
	elif [ "$os" = "iosxr" ]; then
		os="Cisco IOS"
	fi
	echo "${host},${role},,Cisco,${type},${os},${ser},,Active,${site},,,,,${name}"
done

