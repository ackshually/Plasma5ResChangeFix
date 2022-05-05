#!/bin/bash

# Loading window data and splitting it to arrays
. ~/.config/resFixWindows
oldIFS=$IFS
IFS=','
outputs=($outputs)
resolutions=($resolutions)
frequencies=($frequencies)
heights=($heights)
widths=($widths)
winids=($winids)
xs=($xs)
ys=($ys)
IFS=$oldIFS

# Changing resolution to native
len="${#outputs[@]}"
for (( i=0; i<$len; i++ )); do
	xrandr --output "${outputs[$i]}" --mode "${resolutions[$i]}" --rate "${frequencies[$i]}"
done

# Moving and resizing windows
len="${#winids[@]}"
for (( i=0; i<$len; i++ )); do
	xdotool windowmove ${winids[i]} ${xs[i]} ${ys[i]}
	xdotool windowsize ${winids[i]} ${widths[i]} ${heights[i]}
done

# Restoring icon positions using "plasma desktop scripting"
qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
var desk = desktops()[0];
var cf = ConfigFile("resFixIcons");
var oldConf = cf.readEntry("positions");
desk.currentConfigGroup = "General";
desk.writeConfig("positions", oldConf.split(","));'