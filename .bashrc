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
mkcdir ()
{
 mkdir -p -- "$1" &&
   cd -P -- "$1"
}
# Alias 
alias fhere="find . -name "
alias spotify="/usr/bin/spotify --force-device-scale-factor=1.5"
alias sourceros="source ~/Code/ROS/catkin_ws/devel/setup.bash"
alias sourcemodros="source ~/Code/ModLab_ROS/devel/setup.bash"
# only if ros melodic is used 
function ask()          # See 'killps' for example of use.
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
