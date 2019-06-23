#!/bin/bash
IFS="
"
#!/bin/bash
IFS="
"
role="Management Switch";
site="TEB2";
for i in $(echo "select hostname, sysName, version, hardware, os, serial from devices order by hardware;"|mysql -s observium); do
	host="$(echo "$i"|cut -d"	" -f1)"
	name="$(echo "$i"|cut -d"	" -f2)"
	ver="$(echo "$i"|cut -d"	" -f3)"
	type="$(echo "$i"|cut -d"	" -f4)"
	os="$(echo "$i"|cut -d"	" -f5)"
	ser="$(echo "$i"|cut -d"	" -f6)"
	if [ "$os" = "nxos" ]; then
		os="Cisco NX-OS"
		driver="nxos_ssh"
	elif [ "$os" = "ios" ]; then
		os="Cisco IOS"
		driver="ios"
	elif [ "$os" = "iosxr" ]; then
		os="Cisco IOS"
		driver="ios"
	fi
	ip="$(grep $(echo "${host}"|cut -d\. -f1|sed s#"n$"#""#g) /etc/hosts|awk '{ print $1 }'|tail -n 1)"
	if [ "$p" = "" ]; then
		ip="$(host "${host}"|grep has\ address|sed s#"^.* address "#""#g)"
	fi
	if [ "$ip" = "" ]; then
		ip="${host}"
	fi
	echo "$host:"
	echo "  driver: \"$driver\""
	echo "  target: \"$ip\""
	echo "  discovery_protocol: \"multiple\""
	echo ""
done


