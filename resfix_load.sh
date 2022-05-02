#!/bin/bash

cp ~/.config/resConfig ~/.config/resConfigTmp

xrandr -s 1920x1080
sleep 2

qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
var desk = desktops()[0];
var cf = ConfigFile("resConfigTmp");
var oldConf = cf.readEntry("positions");
desk.currentConfigGroup = "General";
desk.writeConfig("positions", oldConf.split(","));
cf.deleteEntry("positions");'

. ~/.config/resConfigTmp
oldIFS=$IFS
IFS=','
heights=($heights)
widths=($widths)
winids=($winids)
xs=($xs)
ys=($ys)
IFS=$oldIFS

for (( n=0; n<${#winids[@]}; n++ ))
do
	xdotool windowmove ${winids[n]} ${xs[n]} ${ys[n]}
	xdotool windowsize ${winids[n]} ${widths[n]} ${heights[n]}
done

rm ~/.config/resConfigTmp