#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
xrdb -merge .Xresources
nitrogen --restore &
exec openbox-session
