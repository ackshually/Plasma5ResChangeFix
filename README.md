# Plasma5ResChangeFix
In KDE/Plasma 5 there is a bug where after quitting full screen low resolution application it does not automatically restore native resolution and after you restore it manually or through scripting, desktop icon placement as well as locations and sizes of all open windows are changed.

These 2 scripts are my effort to fix it. You should copy them to for example your home directory and then run [resfix_save.sh](resfix_save.sh) before full screen application and [resfix_load.sh](resfix_load.sh) after.
