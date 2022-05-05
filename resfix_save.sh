#!/bin/bash

# Saving screen resolution

oldIFS=$IFS
IFS=$'\n'
resFreqMulti=($(xrandr --current | sed -n 's/.* \([0-9]\+x[0-9]\+\) .* \([0-9]\+.[0-9]\+\)\*.*/\1 \2/p'))
outputsMulti=($(xrandr --current | grep " connected " | awk '{print $1}'))

IFS=$' '
for ot in "${outputsMulti[@]}"; do
	outputs=$outputs","$ot
done
outputs="outputs=${outputs:1}"

for rf in "${resFreqMulti[@]}"; do
	rf=($rf)
	resolutions=$resolutions",${rf[0]}"
	frequencies=$frequencies",${rf[1]}"
done
IFS=$oldIFS
resolutions="resolutions=${resolutions:1}"
frequencies="frequencies=${frequencies:1}"

# Saving windows position and size as comma separated values
wins=$(xdotool search --name ".+")
for win in $wins; do
	eval $(xdotool getwindowgeometry --shell $win)
	winids=$winids","$WINDOW
	xs=$xs","$X
	ys=$ys","$Y
	widths=$widths","$WIDTH
	heights=$heights","$HEIGHT
done

# Adding variable names and removing the 1st comma
winids="winids=${winids:1}"
xs="xs=${xs:1}"
ys="ys=${ys:1}"
widths="widths=${widths:1}"
heights="heights=${heights:1}"

# Saving screen resolution and windows data to a file
cd ~/.config
echo $outputs > resFixWindows
echo $resolutions >> resFixWindows
echo $frequencies >> resFixWindows
echo $winids >> resFixWindows
echo $xs >> resFixWindows
echo $ys >> resFixWindows
echo $widths >> resFixWindows
echo $heights >> resFixWindows

# Saving icon locations using "plasma desktop scripting"
qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
var desk = desktops()[0];
var key = "positions";
var cf = ConfigFile("resFixIcons");
desk.currentConfigGroup = "General"
cf.writeEntry(key, desk.readConfig(key));' 
