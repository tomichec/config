#
# ~/.bashrc
#

############################################################
## ENVIRONMENT SETTINGS
############################################################

# history variables
# export HISTCONTROL=ignorespace
# export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth:erasedups # white space and duplicates
export HISTSIZE=10000
export HISTFILESIZE=10000

# https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows#1292
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# set emacs as default editor
export EDITOR="emacsclient -nw"


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# git prompt
source ~/.git-prompt.sh
# git completion
# source ~/.git-completion.bash
# cdargs for cd bookmarks
# source /usr/share/cdargs/cdargs-bash.sh


#PS1='[\u@\h \W]\$ '  # To leave the default one
#DO NOT USE RAW ESCAPES, USE TPUT
reset=$(tput sgr0)
red=$(tput setaf 1)
blue=$(tput setaf 4)
green=$(tput setaf 2)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)

PS1='\n\[$green\](\u@\h)\[$reset\] \[$cyan\][\D{%s}]\[$reset\] \[$red\]${?/^0$/}\[$reset\] \[$blue\]\w\[$reset\] \[$magenta\]$(__git_ps1 " (%s)")\[$reset\]\n \[$red\]\$ \[$reset\] '


############################################################
## DEFINE FUNCTIONS
############################################################

# cd and ls in one
cl() {
    dir=$1
    if [[ -z "$dir" ]]; then
        dir=$HOME
    fi
    if [[ -d "$dir" ]]; then
        cd "$dir"
        ls
    else
        echo "bash: cl: '$dir': Directory not found"
    fi
}

# simple note taker
note () {
    # if file doesn't exist, create it
    if [[ ! -f $HOME/.notes ]]; then
        touch "$HOME/.notes"
    fi

    if ! (($#)); then
        # no arguments, print file
        cat "$HOME/.notes"
    elif [[ "$1" == "-c" ]]; then
        # clear file
        > "$HOME/.notes"
    else
        # add all arguments to file
        printf "%s\n" "$*" >> "$HOME/.notes"
    fi
}

# simple task utility
todo() {
    if [[ ! -f $HOME/.todo ]]; then
        touch "$HOME/.todo"
    fi

    if ! (($#)); then
	echo "Todo items:"
        cat "$HOME/.todo"
    elif [[ "$1" == "-l" ]]; then
	echo "Todo items:"
        nl -b a "$HOME/.todo"
    elif [[ "$1" == "-c" ]]; then
	echo "Clearing todo items."
	> $HOME/.todo
    elif [[ "$1" == "-r" ]]; then
        nl -b a "$HOME/.todo"
        printf "----------------------------\n"
        read -p "Type a number to remove: " number
        ex -sc "${number}d" "$HOME/.todo"
    elif [[ "$1" == "-h" ]]; then
	echo "Simple task utility."
	echo "Usage: todo {option|task}"
	echo "Where option is always only one of the follwing:"
	echo "-l	show numbered items"
	echo "-r	remove item"
	echo "-c	clear all items"
	echo "No option causes the argument to be added to the list."
    else
        printf "%s\n" "$*" >> "$HOME/.todo"
    fi
}

# calculator
calc() {
    echo "scale=3;$@" | bc -l
}

# search in the source code for C
is() {
        grep -nw $@ *.[ch]
}
# search in the source code for C++
ispp() {
        grep -nw $@ *.{hh,cc}
}

# suspend useless output to the terminal
noout(){
        "$@" &>/dev/null
}

# run in the background
background(){
        "$@" &
}

# search fluxbox keys
keys (){
    grep "$@" ~/.fluxbox/keys ~/.bashrc
}

# emacs client configuration and standard output redirection
# from http://www.emacswiki.org/emacs/EmacsClient
e() {
    local TMP;
    if [[ "$1" == "-" ]]; then
        TMP="$(mktemp /tmp/emacsstdinXXX)";
        cat >"$TMP";
        if ! emacsclient --alternate-editor /usr/bin/false --eval "(let ((b (create-file-buffer \"*stdin*\"))) (switch-to-buffer b) (insert-file-contents \"${TMP}\") (delete-file \"${TMP}\"))"  > /dev/null 2>&1; then
            emacs --eval "(let ((b (create-file-buffer \"*stdin*\"))) (switch-to-buffer b) (insert-file-contents \"${TMP}\") (delete-file \"${TMP}\"))" &
        fi;
    else
        emacsclient --alternate-editor "emacs" --no-wait "$@" > /dev/null 2>&1 &
    fi;
    # switch to the emacs window
    # wmctrl -a emacs@zebra
}

mkcd () {
    mkdir "$1"; cd "$1";
    [ "$(ls -A .)" ] && echo "Not Empty" || echo "Empty"
}


############################################################
## ALIASES
############################################################

# Privileged access
alias root='sudo -i'

## Pacman aliases ## https://wiki.archlinux.org/index.php/Pacman_tips#Shortcuts {{{ 
alias pacupg='sudo pacman -Syu'		# Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacin='sudo pacman -S'		# Install specific package(s) from the repositories
alias pacins='sudo pacman -U'		# Install specific package    from a file 
alias pacre='sudo pacman -R'		# Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'		# Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacinf='pacman -Si'		# Display information about a given package in the repositories
alias pacloc='pacman -Qi'		# Display information about a given package in the local database
alias paclocs='pacman -Qs'		# Search for package(s) in the local database
alias paclo="pacman -Qdt"		# List all packages which are orphaned
alias pacc="sudo pacman -Scc"		# Clean cache - delete all not currently installed package files
alias paclf="pacman -Ql"		# List all files installed by a given package
alias pacexpl="pacman -D --asexp"	# Mark one or more installed packages as explicitly installed 
alias pacimpl="pacman -D --asdep"	# Mark one or more installed packages as non explicitly installed

# '[r]emove [o]rphans' - recursively remove ALL orphaned packages
alias pacro="pacman -Qtdq > /dev/null && sudo pacman -Rns \$(pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')"

alias pacmir='sudo pacman -Syy'                    # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist
# }}}

## Safety features ## {{{
alias cp='cp -pi'                       # preserve mode ownership and timestamps properties
alias mv='mv -i'
alias del='rm -I'                    # 'rm -i' prompts for every file
alias rm='rm -I'                    # 'rm -i' prompts for every file
# safer alternative w/ timeout, not stored in history
# alias rm=' timeout 3 rm -Iv --one-file-system'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias cls=' echo -ne "\033c"'       # clear screen for real (it does not work in Terminology)
# }}}

## Modified default options ## {{{
alias grep='grep --color=auto'
alias df='df -h'
alias diff='colordiff'
alias dmesg='dmesg -HL'
alias du='du -c -h'
alias free='free -h'	
alias feh='feh -FZ'                    # image viewer (fullscreen autoscaled)
alias mkdir='mkdir -p -v'
alias ping='ping -c 2'
alias evince='background noout evince' # suspend output and run in background
# }}}

## ls ## {{{
alias ls='ls -hF --color=auto'
alias lr='ls -R'                    # recursive ls
alias ll='ls -l'
alias la='ll -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
lm () { la $@ | more ; }
cs () { cd $@; ls ; }
# }}}

## searching ## {{{
# ff:  to find a file under the current directory
ff ()  { /usr/bin/find . -iname "$@" ; }
# ffs: to find a file whose name starts with a given string
ffs () { /usr/bin/find . -iname "$@"'*' ; }
# ffe: to find a file whose name ends with a given string
ffe () { /usr/bin/find . -iname '*'"$@" ; }
# fff:  to find a file whose name contains a given string
fff () { /usr/bin/find . -iname '*'"$@"'*' ; }
# }}}

## network related ## {{{
alias connect='sudo netctl start mojemalasit'
alias wifi='sudo wifi-menu'
alias goturing='ssh tom@turing.ex.ac.uk'
alias gowiener='ssh tom@wiener.ex.ac.uk'
alias mntwiener='sshfs tom@wiener.ex.ac.uk:/Users/tom/ /mnt/wiener/'
alias sockfwd="ssh -D 4096 work" 
# }}}

## aliases linked to external scripts ## {{{
alias mntdisk='~/bin/mntdisk.sh 1'
alias umntdisk='~/bin/mntdisk.sh 0'
alias version='/home/tom/bin/version.sh'
alias versudo='sudo /home/tom/bin/version.sh'
alias fcst='/home/tom/bin/pyfcio/fcst.py'
# }}}

## New commands ## {{{
alias ds='date +%F@%H-%M' # date stamp
alias du1='du --max-depth=1'
alias hist='history | grep -ia '         # requires an argument
alias pgg='ps -Af | grep'           # requires an argument
alias ..='cd ..'
alias up='cd ..'
alias ...='cd ../../'
alias rmr='rm -R'                    # remove recursively
alias cpr='cp -R'                    # copy recursively
# }}}

## Shortcuts ## {{{
alias ipython='ipython3'
alias oxd="sdcv -u 'Oxford English Dictionary 2nd Ed. P1'"
alias genpsw='openssl rand -base64 12'
alias matrix='tr -cd 0-9 < /dev/urandom | fold -w 100 | perl -e "while(<>){s/(.{10})/\$1 /g;print;}" | cat $(echo -e "\033[0;32m") -'
alias cal='cal -m'
alias gsh='git status |head'
alias genpsw='openssl rand -base64 12'
alias matrix='tr -cd 0-9 < /dev/urandom | fold -w 78 | perl -e "while(<>){s/(.{10})/\$1 /g;print;}" | cat $(echo -e "\033[0;32m") -'
alias make='time make'
alias cmake='time cmake'
alias htmldump='w3m -dump -T text/html'
# }}}
dud (){
    sdcv -u Duden $@ | perl -n -e 's@(\d\.)@\n\n$1@g;print'
}

ts2date (){
    date --date="@$@"
}

whatismyip (){
curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'  
}
alias newid='sudo killall -HUP tor'

alias lpr='lpr -U ts498 -o fit-to-page'

# source ~/.lncli.bash-completion
# source ~/.lightning-cli.bash-completion
# source ~/.lightning_bashrc

# alias for termbin, use `echo test | termbin`
alias termbin="nc termbin.com 9999"

# simple jezevec chat
say() {
    echo `whoami` `ds`: $@ >> ~/jezevec.txt
}

# android programming
# export ANDROID_HOME=$HOME/Android/Sdk/
# export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

export PATH=${PATH}:${HOME}/Software/openCARP.master/build/bin/

source $HOME/.accounting
