#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

##################################################
# start with numlock on 
# numlockx &

##################################################
# TWM
##################################################

# twm &
# xclock -geometry 70x30-1-1 -d -brief -bg gray60 &
# xterm -geometry 80x20+494+0 -bg black -fg gray60 &
# xterm -geometry 80x20+494-30 -bg black -fg gray60 &
# exec xterm -geometry 80x43+0+0 -bg black -fg gray60 -name login



##################################################
# FLUXBOX
##################################################

# exec startfluxbox

##################################################
# change font in the urxvt terminal emulator
# http://www.askapache.com/linux/rxvt-xresources.html
#[[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults


##################################################
# GNOME
##################################################

exec gnome-session
