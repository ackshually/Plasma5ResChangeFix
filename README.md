# Plasma5ResChangeFix
In KDE/Plasma 5 there is a bug where after quitting full screen low resolution game it does not automatically restore native resolution and desktop icon placement as well as locations and sizes of all open windows are changed.

These scripts aim to fix this problem by saving and restoring your desktop look.

# Installation:
Copy both scripts to your home directory. Make sure you have xdotools and xrandr packages installed as the scripts use them for window manipulation and resolution changing respectively.

# Usage:
Run [resfix_save.sh](resfix_save.sh) before your game and [resfix_load.sh](resfix_load.sh) after. Or write a small script like this:
```
#!/bin/bash

sh ~/resfix_save.sh
[your application here] #(e.g. wine game.exe)
sh ~/resfix_load.sh
```
put it in your game directory and run your game using it.
[Resfix_save.sh](resfix_save.sh) creates 2 files called resFixIcons and resFixWindows in your home/.config folder containing data that [resfix_load.sh](resfix_load.sh) uses to restore you desktop.
