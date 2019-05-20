# fixing c-S for vim
vim()
{
 # osx users, use stty -g
 local STTYOPTS="$(stty --save)"
 stty stop '' -ixoff
 command vim "$@"
 stty "$STTYOPTS"
}
# mkdir and cd into in
alias c="clear"
alias fhere="find . -name "
alias spotify="/usr/bin/spotify --force-device-scale-factor=1.5"
alias sourceros="source ~/Code/ROS/catkin_ws/devel/setup.bash"
alias sourcemodros="source ~/Code/ModLab_ROS/devel/setup.bash"
alias sourcekros="source ~/Code/Gazebo_KLab/catkin_ws/devel/setup.bash"
alias gut="git"
alias gt="git"
alias gcam="git commit -a -m"
alias gs='git status'
alias get='sudo apt-get install'
alias update='sudo apt-get update; sudo apt-get upgrade'
alias mux="tmuxinator"
alias gcm='git commit -m'
alias ga='git add'

# Remap history and tab complete{
    bind TAB:menu-complete
    bind '"\e[Z": menu-complete-backward'
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
    bind '"\eOA": history-search-backward'
    bind '"\eOB": history-search-forward'
# }
function rf(){
    rm -rf "$1"
}
function e650()
{
    mkcdir ~/Code/Python/ESE_650/
    pycharm-professional . &
}
# only if ros melodic is used 
function ask()          # See 'killps'za for example of use.
{
 echo -n "$@" '[y/n] ' ; read ans
 case "$ans" in
     y*|Y*) return 0 ;;
     *) return 1 ;;
 esac
}
function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function killps()   # kill by process name
{
 local pid pname sig="-TERM"   # default signal
 if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
     echo "Usage: killps [-SIGNAL] pattern"
     return;
 fi
 if [ $# = 2 ]; then sig=$1 ; fi
 for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} )
 do
     pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
     if ask "Kill process $pid <$pname> with signal $sig?"
         then kill $sig $pid
     fi
 done
}

function repeat()       # Repeat n times command.
{
 local i max
 max=$1; shift;
 for ((i=1; i <= max ; i++)); do  # --> C-like syntax
     eval "$@";
 done
}

function extract()      # Handy Extract Program
{
 if [ -f $1 ] ; then
     case $1 in
         *.tar.bz2)   tar xvjf $1     ;;
         *.tar.gz)    tar xvzf $1     ;;
         *.bz2)       bunzip2 $1      ;;
         *.rar)       unrar x $1      ;;
         *.gz)        gunzip $1       ;;
         *.tar)       tar xvf $1      ;;
         *.tbz2)      tar xvjf $1     ;;
         *.tgz)       tar xvzf $1     ;;
         *.zip)       unzip $1        ;;
         *.Z)         uncompress $1   ;;
         *.7z)        7z x $1         ;;
         *)           echo "'$1' cannot be extracted via >extract<" ;;
     esac
 else
     echo "'$1' is not a valid file!"
 fi
}


function swap() { # Swap 2 filenames around, if they exist (from Uzi's bashrc).
 local TMPFILE=tmp.$$

 [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
 [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
 [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

 mv "$1" $TMPFILE
 mv "$2" "$1"
 mv $TMPFILE "$2"
}
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }
function fstr()
{
 OPTIND=1
 local mycase=""
 local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
 while getopts :it opt
 do
     case "$opt" in
        i) mycase="-i " ;;
        *) echo "$usage"; return ;;
     esac
 done
 shift $(( $OPTIND - 1 ))
 if [ "$#" -lt 1 ]; then
     echo "$usage"
     return;
 fi
 find . -type f -name "${2:-*}" -print0 | \
xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more
}
function plugin()
{
    # Code that sets up a second monitor when of a different resolution (1920x1080)
    xrandr -d :0 --fb  7680x2160 --output eDP-1 --mode 3840x2160 --scale 1x1 --rate 60 --pos 0x0 --primary
    xrandr -d :0 --output HDMI-1 --off
    xrandr -d :0 --fb 7680x2160 --output HDMI-1  --mode 1920x1080  --scale 2x2 --panning 3840x2160+3840+0
    xrandr -d :0 --fb 7680x2160 --output HDMI-1  --mode 1920x1080  --scale 2x2 --panning 3840x2160+3840+0

}
function plugin1()
{
    # Code that sets up a second monitor when of a different resolution (1920x1080)
    xrandr -d :0 --fb  7680x2160 --output eDP-1-1 --mode 3840x2160 --scale 1x1 --rate 60 --pos 0x0 --primary
    xrandr -d :0 --output HDMI-1-1 --off
    xrandr -d :0 --fb 7680x2160 --output HDMI-1-1  --mode 1920x1080  --scale 2x2 --panning 3840x2160+3840+0
    xrandr -d :0 --fb 7680x2160 --output HDMI-1-1  --mode 1920x1080  --scale 2x2 --panning 3840x2160+3840+0

}
function unplug(){
    # fn to call once the other monitor is unplugged to get stuff back to normal
    xrandr -d :0 --output HDMI-1 --off
    xrandr -d :0 --fb 3840x2160 --output eDP-1  --scale 1x1 --pos 0x0 --primary
}
function unplug_main(){
    # fn to call once the other monitor is unplugged to get stuff back to normal
    xrandr -d :0 --output eDP-1 --off
    #xrandr -d :0 --fb 3840x2160 --output HDMI-1 --mode 1920x1080 --pos 0x0 --panning 3840x2160 --primary --scale 1.5x1.5
    xrandr -d :0 --fb 2880x1620 --output HDMI-1 --mode 1920x1080 --pos 0x0 --panning 2880x1620 --primary --scale 1.5x1.5 
    xrandr -d :0 --fb 2880x1620 --output HDMI-1 --mode 1920x1080 --pos 0x0 --panning 2880x1620 --primary --scale 1.5x1.5 
}
mkcdir ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}
. ~/dotfiles/z.sh
export GAZEBO_RESOURCE_PATH=/usr/share/gazebo-9/worlds:/home/raven/Code/Gazebo_KLab/catkin_ws/src/tree_world/world
export EDITOR='vim'
# Powerlien
export PATH=$PATH:$HOME/Library/Python/2.7/bin
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /home/raven/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh

# Fix history
    export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
    export HISTSIZE=100000                   # big big history
    export HISTFILESIZE=100000               # big big history
    shopt -s histappend                      # append to history, don't overwrite it

    # Save and reload the history after each command finishes
    export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
