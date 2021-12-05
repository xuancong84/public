#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: $0 hdmi/gpio/pxe-hdmi/pxe-gpio"
	exit 1
fi

cd `dirname "$0"`
if [ "$1" == hdmi ]; then
	cp config.hdmi.txt config.txt
	cp cmdline.hdmi.txt cmdline.txt
	if [ -s overlays.bak/vc4-kms-v3d-pi4.dtbo ]; then
		cp overlays.bak/vc4-kms-v3d-pi4.dtbo overlays/
	fi
elif [ "$1" == gpio ]; then
	cp config.gpio.txt config.txt
	cp cmdline.gpio.txt cmdline.txt
	TARGET=vc4-fkms-v3d.dtbo
	if [ -s overlays/vc4-fkms-v3d-pi4.dtbo ]; then
		TARGET=vc4-fkms-v3d-pi4.dtbo
	fi
	if [ -s overlays.bak/vc4-kms-v3d-pi4.dtbo ]; then
		cp overlays/$TARGET overlays/vc4-kms-v3d-pi4.dtbo
	fi
elif [ "$1" == "pxe-hdmi" ]; then
	cp config.hdmi.txt config.txt
	cp cmdline.pxe-hdmi.txt cmdline.txt
	if [ -s overlays.bak/vc4-kms-v3d-pi4.dtbo ]; then
		cp overlays.bak/vc4-kms-v3d-pi4.dtbo overlays/
	fi
elif [ "$1" == "pxe-gpio" ]; then
	cp config.gpio.txt config.txt
	cp cmdline.pxe-gpio.txt cmdline.txt
	TARGET=vc4-fkms-v3d.dtbo
	if [ -s overlays/vc4-fkms-v3d-pi4.dtbo ]; then
		TARGET=vc4-fkms-v3d-pi4.dtbo
	fi
	if [ -s overlays.bak/vc4-kms-v3d-pi4.dtbo ]; then
		cp overlays/$TARGET overlays/vc4-kms-v3d-pi4.dtbo
	fi
else
	echo "Error: unknown display mode"
fi

