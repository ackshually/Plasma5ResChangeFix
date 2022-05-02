# Plasma5ResChangeFix
In KDE/Plasma 5 there is a bug where after quitting full screen low resolution application it does not automatically restore native resolution and after you restore it manually (or through scripting), desktop icon placement as well as locations and sizes of all open windows are changed.

These scripts aim to fix this problem by saving and restoring your desktop look.

# Installation:
Copy both scripts to your home directory. If your native resolution is other than 1920x1080, change `xrandr -s 1920x1080` line in [resfix_load.sh](resfix_load.sh) script accordingly. Make sure you have xdotools package installed as the scripts use it for window manipulation.


# Usage:
Run [resfix_save.sh](resfix_save.sh) before full screen application and [resfix_load.sh](resfix_load.sh) after. Or write a small script like this:
...
{
  #!/bin/bash

  sh ~/resfix_save.sh
  [your application here] #(e.g. wine Game.exe)
  sh ~/resfix_load.sh
}
...
and put it in your application directory.
