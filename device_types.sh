#!/bin/bash
echo "manufacturer,model,slug,part_number,u_height,is_full_depth,subdevice_role,comments"
for i in $(echo "select hardware from devices group by hardware;"|mysql -s observium); do
	l="$(echo "$i"|tr "[A-Z]" "[a-z]")";
	echo "Cisco,${i},${l},,1,True,,"
done
