#!/bin/bash

# Saving screen resolution
screenRes="screenres=$(xrandr | grep '*' | awk '{print $1}')"

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
echo $screenRes > resFixWindows
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
