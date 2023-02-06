source ~/yvconf/alias.conf
# fixing c-S for vim
vim()
{
 # osx users, use stty -g
 local STTYOPTS="$(stty --save)"
 stty stop '' -ixoff
 command vim "$@"
 stty "$STTYOPTS"
}
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
function kite()
{
    roscore &
    cd ~/Code/Mlab_ROS
    source devel/setup.bash
    clion &
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
    xrandr --fb  7680x2160 --output eDP-1 --mode 3840x2160 --scale 1x1 --rate 60 --pos 0x0 --primary
    xrandr --output HDMI-1 --off
    xrandr --fb 7680x2160 --output HDMI-1  --mode 1920x1080  --scale 2x2 --panning 3840x2160+3840+0
    xrandr --fb 7680x2160 --output HDMI-1  --mode 1920x1080  --scale 2x2 --panning 3840x2160+3840+0
    #feh --bg-fill -z ~/Pictures/Wallpapers
}
function plugin_vnc()
{
    # Code that sets up a second monitor when of a different resolution (1920x1080)
    xrandr -d :0 --fb  7680x2160 --output eDP-1-1 --mode 3840x2160 --scale 1x1 --rate 60 --pos 0x0 --primary
    xrandr -d :0 --output HDMI1 --off
    xrandr -d :0 --fb 7680x2160 --output HDMI-1-1  --mode 1920x1080  --scale 2x2 --panning 3840x2160+3840+0
    xrandr -d :0 --fb 7680x2160 --output HDMI-1-1  --mode 1920x1080  --scale 2x2 --panning 3840x2160+3840+0
    #feh --bg-fill -z ~/Pictures/Wallpapers
}
function unplug(){
    # fn to call once the other monitor is unplugged to get stuff back to normal
    xrandr --output HDMI-1 --off
    xrandr --fb 3840x2160 --output eDP-1  --scale 1x1 --pos 0x0 --primary
}
function unplug_main(){
    # fn to call once the other monitor is unplugged to get stuff back to normal
    xrandr -d :0 --output eDP-1 --off
    #xrandr -d :0 --fb 3840x2160 --output HDMI-1 --mode 1920x1080 --pos 0x0 --panning 3840x2160 --primary --scale 1.5x1.5
    xrandr -d :0 --fb 2880x1620 --output HDMI-1 --mode 1920x1080 --pos 0x0 --panning 2880x1620 --primary --scale 1.5x1.5 
    xrandr -d :0 --fb 2880x1620 --output HDMI-1 --mode 1920x1080 --pos 0x0 --panning 2880x1620 --primary --scale 1.5x1.5 
}
function replace(){
	ag -0 -l $1 | xargs -0 sed -ri -e "s/$1/$2/g"
}
function bu () {
	function usage () {
		 cat <<-EOF
			Usage: bu [N]
							N        N is the number of level to move back up to, this argument must be a positive integer.
							h help   displays this basic help menu.
			EOF
	}
	# reset variables
	STRARGMNT=""
	FUNCTIONARG=$1
    # First check if no params are provided, if so default 0
    if test -z "$FUNCTIONARG"
    then
        FUNCTIONARG=1
    fi
	# Make sure the provided argument is a positive integer:
	if [[ ! -z "${FUNCTIONARG##*[!0-9]*}" ]]; then
		for i in $(seq 1 $FUNCTIONARG); do
				STRARGMNT+="../"
		done
		CMD="cd ${STRARGMNT}"
		eval $CMD
	else
		usage
	fi
}
# connect to a running container using the name of the container
function docker_connect(){
    docker exec -it $1 bash
}
# Set rosmasteruri and rosip assuming both are the same (core is running on this machine)
function roscore_ip(){
    export ROS_MASTER_URI=http://$1:11311
    export ROS_IP=$1
}
# Auto SSh
function auto_ssh(){
    false
    while [ $? -ne 0 ]; do
        echo "Trying"
        ssh "$@" || (sleep 1;false)
    done

}
# cd + ls
cdl() { cd "$@" && ls; }

# mkdir and cd into in
mkcdir ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}
# Z
    . ~/yvconf/z.sh
    export GAZEBO_RESOURCE_PATH=/usr/share/gazebo-9/worlds:/home/raven/Code/Gazebo_KLab/catkin_ws/src/tree_world/world
    export EDITOR='vim'
# Powerline
    export PATH=$PATH:$HOME/.local/bin
     
    if [ -f $HOME/.local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh ]; then
        $HOME/.local/bin/powerline-daemon -q
        POWERLINE_BASH_CONTINUATION=1
        POWERLINE_BASH_SELECT=1
        source $HOME/.local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
    fi

# Fix history
    export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
    export HISTSIZE=100000                   # big big history
    export HISTFILESIZE=100000               # big big history
    shopt -s histappend                      # append to history, don't overwrite it

    # Save and reload the history after each command finishes
    export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# FUCK
    eval $(thefuck --alias)
    eval $(thefuck --alias FUCK)
# Vim bindings{
    #set -o vi
    #bind '"jj":vi-movement-mode'
    #set show-mode-in-prompt on
    #set vi-cmd-mode-string "\1\e[2 q\2"
    #set vi-ins-mode-string "\1\e[6 q\2"
#}
function source_venv(){
    source venv/bin/activate
}
function caffeine(){
    status=`xset -q | grep 'DPMS is' | awk '{ print $3 }'`
    if [ $status == 'Enabled' ]; then
        xset -dpms && \
        alert 'Screen suspend is disabled.'
    else
            xset +dpms && \
        alert 'Screen suspend is enabled.'
    fi
}
function source_ros_name(){
    # Assumes ros ws is in ROS_ws
    source /home/raven/Code/ROS_ws/$1_ws/devel/setup.bash
}

function source_ros(){
    # Smart source that uses the current ws to source
    read path <<< $(echo $(pwd) | awk 'BEGIN{FS=OFS="ws"}{NF--; print}')
    echo $path"ws/devel/setup.bash"
    source $path"ws/devel/setup.bash"
}
fzf_color_scheme(){
    local base03="234"
    local base02="235"
    local base01="240"
    local base00="241"
    local base0="244"
    local base1="245"
    local base2="254"
    local base3="230"
    local yellow="136"
    local orange="166"
    local red="160"
    local magenta="125"
    local violet="61"
    local blue="33"
    local cyan="37"
    local green="64"

    # Comment and uncomment below for the light theme.

    # Solarized Dark color scheme for fzf
    export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
    "
    ## Solarized Light color scheme for fzf
    #export FZF_DEFAULT_OPTS="
    #  --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
    #  --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
    #"
}
fzf_color_scheme
# virtual envs{
    export WORKON_HOME=$HOME/Code/virtual_envs
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    source $HOME/.local/bin/virtualenvwrapper.sh
#}

# Color man pages{
    export MANPAGER="nvim -c 'set ft=man' -"
# }

cl() {
    local dir="$1"
    local dir="${dir:=$HOME}"
    if [[ -d "$dir" ]]; then
        cd "$dir" >/dev/null; ls --color=auto
    else
        echo "bash: cdls: $dir: Directory not found"
    fi
}

function lf(){
    if [ "$1" == "p" ]; then
        ls /mnt/nas_processed/ts-processed/*/$2/*/
    elif [ "$1" == "r" ]; then
        ls /mnt/nas_raw/ts-raw/*/$2/
    elif [ "$1" == "s" ]; then
        ls /mnt/nas_processed/ts-stand/*/$2/*/
    fi
}

function cf(){
    if [ "$1" == "p" ]; then
        cd /mnt/nas_processed/ts-processed/*/$2/*/
    elif [ "$1" == "r" ]; then
        cd /mnt/nas_raw/ts-raw/*/$2/
    elif [ "$1" == "s" ]; then
        cd /mnt/nas_processed/ts-stand/*/$2/*/
    fi
}
