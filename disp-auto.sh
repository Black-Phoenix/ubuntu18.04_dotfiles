#!/bin/sh
#PATH=/bin:/usr/bin:/usr/local/bin
export DISPLAY=:0
export XAUTHORITY=/run/user/1000/gdm/Xauthority
sleep 5
xrandr | grep "HDMI1 connected"
if [ $? -eq  0 ]; then
    # is connected
    # Code that sets up a second monitor when of a different resolution (1920x1080)
    xrandr -d :0 --fb  7680x2160 --output eDP1 --mode 3840x2160 --scale 1x1 --rate 60 --pos 0x0 --primary
    xrandr -d :0 --output HDMI1 --off
    xrandr -d :0 --fb 7680x2160 --output HDMI1  --mode 1920x1080  --scale 2x2 --panning 3840x2160+3840+0
    xrandr -d :0 --fb 7680x2160 --output HDMI1  --mode 1920x1080  --scale 2x2 --panning 3840x2160+3840+0
else
    # fn to call once the other monitor is unplugged to get stuff back to normal
    xrandr -d :0 --output HDMI1 --off
    xrandr -d :0 --fb 3840x2160 --output eDP1  --scale 1x1 --pos 0x0 --primary
fi
