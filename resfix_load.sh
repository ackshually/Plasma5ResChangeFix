#!/bin/bash

# Making copy of 
cp ~/.config/resFixData ~/.config/resFixData.tmp

xrandr -s 1920x1080
sleep 2

qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
var desk = desktops()[0];
var cf = ConfigFile("resFixData.tmp");
var oldConf = cf.readEntry("positions");
desk.currentConfigGroup = "General";
desk.writeConfig("positions", oldConf.split(","));
cf.deleteEntry("positions");'

# Loading window data and splitting it to arrays
. ~/.config/resFixData.tmp
oldIFS=$IFS
IFS=','
heights=($heights)
widths=($widths)
winids=($winids)
xs=($xs)
ys=($ys)
IFS=$oldIFS

# Moving and resizing windows
for (( n=0; n<${#winids[@]}; n++ ))
do
	xdotool windowmove ${winids[n]} ${xs[n]} ${ys[n]}
	xdotool windowsize ${winids[n]} ${widths[n]} ${heights[n]}
done

rm ~/.config/resFixData.tmp
