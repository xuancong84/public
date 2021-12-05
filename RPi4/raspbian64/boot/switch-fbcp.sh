#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: $0 fbcp/direct"
	echo "1. fbcp: use fbcp to copy from /dev/fb0 to /dev/fb1"
	echo "2. direct: modify /etc/X11/xorg.conf.d/99-fbcp.conf to directly render to /dev/fb1"
	exit 1
fi

cd `dirname "$0"`

if [ `ls ../rootfs/ | wc -l` -lt 3 ]; then
	echo "Error: ../rootfs/ in not mounted"
	exit 1
fi
if [ "$1" == fbcp ]; then
	set -x -e -o pipefail
	mkdir -p ./configs/
	if [ -s ../rootfs/etc/X11/xorg.conf.d/99-fbcp.conf ]; then
		mv ../rootfs/etc/X11/xorg.conf.d/99-fbcp.conf ./configs/
	fi
	sed -i 's:^#\(sleep.*fbcp\):\1:g' ../rootfs/etc/rc.local
	sed -i "s:height=.*:height=52:g; s:iconsize=.*:iconsize=52:g; s:MaxTaskWidth=.*:MaxTaskWidth=300:g" ../rootfs/home/pi/.config/lxpanel/LXDE-pi/panels/panel
	sed -i "s:\(FontName.* \)[0-9]\+:\116:g; s:\(ToolbarIconSize\)=.*:\1=6:g; s:\(large-toolbar\)=.*:\1=48,48:g; s:\(CursorThemeSize\)=.*:\1=36:g" \
		../rootfs/home/pi/.config/lxsession/LXDE-pi/desktop.conf
elif [ "$1" == direct ]; then
	set -x -e -o pipefail
	cp -f ./configs/99-fbcp.conf ../rootfs/etc/X11/xorg.conf.d/
	sed -i 's:^\(sleep.*fbcp\):#\1:g' ../rootfs/etc/rc.local
	sed -i "s:height=.*:height=20:g; s:iconsize=.*:iconsize=20:g; s:MaxTaskWidth=.*:MaxTaskWidth=150:g" ../rootfs/home/pi/.config/lxpanel/LXDE-pi/panels/panel
	sed -i "s:\(FontName.* \)[0-9]\+:\18:g; s:\(ToolbarIconSize\)=.*:\1=1:g; s:\(large-toolbar\)=.*:\1=16,16:g; s:\(CursorThemeSize\)=.*:\1=24:g" \
		../rootfs/home/pi/.config/lxsession/LXDE-pi/desktop.conf
else 
	echo "Unknown mode: $1"
	exit 1
fi

sync

