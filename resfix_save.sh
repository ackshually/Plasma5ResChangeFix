#!/bin/bash

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

# Removing the 1st comma
heights="heights=${heights:1}"
widths="widths=${widths:1}"
winids="winids=${winids:1}"
xs="xs=${xs:1}"
ys="ys=${ys:1}"

# Saving windows data to a file
cd ~/.config
echo $heights > resFixData
echo $widths >> resFixData
echo $winids >> resFixData
echo $xs >> resFixData
echo $ys >> resFixData

# Saving icon locations using "plasma desktop scripting"
qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
var desk = desktops()[0];
var key = "positions";
var cf = ConfigFile("resFixData");
desk.currentConfigGroup = "General"
cf.writeEntry(key, desk.readConfig(key));' 
