#!/bin/bash

# Loading window data and splitting it to arrays
. ~/.config/resFixWindows
oldIFS=$IFS
IFS=','
heights=($heights)
widths=($widths)
winids=($winids)
xs=($xs)
ys=($ys)
IFS=$oldIFS

# Changing resolution to native
xrandr -s $screenres
sleep 2

# Moving and resizing windows
for (( n=0; n<${#winids[@]}; n++ ))
do
	xdotool windowmove ${winids[n]} ${xs[n]} ${ys[n]}
	xdotool windowsize ${winids[n]} ${widths[n]} ${heights[n]}
done

# Restoring icon positions using "plasma desktop scripting"
qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
var desk = desktops()[0];
var cf = ConfigFile("resFixIcons");
var oldConf = cf.readEntry("positions");
desk.currentConfigGroup = "General";
desk.writeConfig("positions", oldConf.split(","));'