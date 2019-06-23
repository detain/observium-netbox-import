#!/bin/bash
IFS="
"
for i in $(echo "select hostname, snmp_sysName, substring_index(substring_index(replace(snmp_sysDescr, '\r', ''), '\n', 1),',',3) as descr from host where snmp_version=2 and (snmp_sysDescr like 'Cisco%' or snmp_sysDescr like 'Juniper%') order by snmp_sysName;"|mysql -s cacti); do
	h="$(echo "$i"|cut -d"	" -f1)"
	n="$(echo "$i"|cut -d"	" -f2)"
	o="$(echo "$i"|cut -d"	" -f3)"
	if [ "$(echo "$o"|cut -c1-11)" = "Cisco NX-OS" ]; then
		d=nxos_ssh
	else
		d=ios
	fi
	p="$(grep $(echo "$h"|cut -d\. -f1|sed s#"n$"#""#g) /etc/hosts|awk '{ print $1 }'|tail -n 1)"
	if [ "$p" = "" ]; then
		p="$(host "$h"|grep has\ address|sed s#"^.* address "#""#g)"
	fi
	if [ "$p" = "" ]; then
		p="$h"
	fi
	echo "$n:"
	echo "  driver: \"$d\""
	echo "  target: \"$p\""
	echo "  discovery_protocol: \"multiple\""
	echo ""
done


