# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#  Source global definitions to get the module command defined.
#  If you remove this from your file and/or you reset the BASH_ENV (or
#  ENV) variables,  you risk getting "module command not found"
#  errors from batch jobs.

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

system_type=$(uname -s)
if [ "$system_type" = "Darwin" ]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
    fi
    WIFI_SSID=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'`

    # If I'm at work
    if [ "$WIFI_SSID" = 'GA Staff' ]; then
        export http_proxy=proxy.inno.lan:3128
        export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    fi
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Save and reload the history after each command finishes
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# The above is from a wsl ubuntu .bashrc
# below based on Damo

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

command_exists () {
    type "$1" &> /dev/null ;
}

if command_exists module; then
    module use /g/data/v10/public/modules/modulefiles --append
fi

if command_exists direnv; then
    eval "$(direnv hook bash)"
fi

if [[ $system_type =~ MINGW || $system_type =~ MSYS ]]; then
    # ssh-pageant
    # Not able to use file sockets in windows...
    #eval $(ssh-pageant.exe -r -a "/c/Temp/.ssh-pageant-$USERNAME")
    # eval $(ssh-pageant)
    if command_exists ssh-pageant; then
        eval $(ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")
    fi

    export PATH=$PATH:/c/msys64/mingw64/bin
    export GIT_GUI_LIB_DIR=/c/msys64/usr/share/git-gui/lib
fi

if [ -n "$TMUX" ]; then
    function refresh-tmux-env-vars {
        eval $(tmux showenv -s DISPLAY)
        eval $(tmux showenv -s SSH_AUTH_SOCK)
    }
else
    function refresh-tmux-env-vars { true; }
fi

function preexec {
    refresh-tmux-env-vars
}


if [[ `hostname` =~ vdi ]]; then
    mkdir -p /local/u46/dsg547/tmp/dotcondapkgcache
    mkdir -p /local/u46/dsg547/tmp/dotcache
    #export PATH="${PATH}:${HOME}/src/damootils/scripts"
    export PIP_DOWNLOAD_CACHE=$TMPDIR/pipcache
    mkdir -p $PIP_DOWNLOAD_CACHE
fi

if [[ `hostname` =~ gadi ]] && in_interactive_shell; then

    # This is where you put settings that you'd like in
    # interactive shells. E.g. prompts, or aliases
    # The 'module' command offers path manipulation that
    # will only modify the path if the entry to be added
    # is not already present. Use these functions instead of e.g.
    # PATH=${HOME}/bin:$PATH

    prepend_path PATH ${HOME}/bin
    prepend_path PATH ${HOME}/.local/bin

    export VISUAL=emacs
    export EDITOR="$VISUAL"

    export LC_ALL=en_AU.UTF-8
    export LANG=en_AU.UTF-8

    alias cdsand="cd /g/data/u46/users/dsg547/sandbox/"
    alias cdpldev="cd /g/data/u46/users/dsg547/sandbox/processingDEA/ls_c3_ard_testing/devdb"
    alias cdqa="cd /g/data/u46/users/dsg547/c3_ard_qa"
    alias cdss="cd /g/data/u46/users/dsg547/sandbox/dea-ard-scene-select"
    alias cddevv1="cd /g/data/u46/users/dsg547/devmodules/ard-pipeline/devv1/lib/python3.6/site-packages/wagl-5.5.1-py3.6-linux-x86_64.egg/wagl_repo/"
    export DEA_WORK_ROOT="/g/data/u46/users/dsg547/work"

    if in_login_shell; then
	# This is where you place things that should only
	# run when you login. If you'd like to run a
	# command that displays the status of something, or
	# load a module, or change directory, this is the
	# place to put it
	module use /g/data/u46/users/dsg547/modules/dsg-py
	module load pbs
	# cd /scratch/${PROJECT}/${USER}

	#echo "DATACUBE_CONFIG_PATH=${DATACUBE_CONFIG_PATH}"
	echo "S2 ARD output dir: cd /g/data/if87/datacube/002/S2_MSI_ARD/packaged/"
	echo "C3 ARD working dir: cd /g/data/v10/work/c3_ard/"
    fi
fi

if [[ ! -S ~/.ssh/ssh_auth_sock && -S "$SSH_AUTH_SOCK" ]]; then
    ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
fi

# git Prompt

if [ -f ~/.bash/git-prompt.sh ]; then
    . ~/.bash/git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=1
    export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
    #export PS1='\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\] $(__git_ps1 "(%s) ")\$ '
fi

if [ -f ~/.bash/git-completion.bash ]; then
    .  ~/.bash/git-completion.bash
fi

# TODO add this
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# adding to PATH

SWHOME=$HOME
if [[ `hostname` =~ gadi ]]; then
   SWHOME=/g/data/u46/users/$USER
fi
DESTDIR=$SWHOME/bin/miniconda3/bin
export PATH=$DESTDIR:$PATH

# ODC
dc-dump-product () {
   local name=${1}
   local dbname=${2:-"datacube"}
   local host=${3:-"130.56.244.105"}
   local port=${4:-6432}

   cat <<EOF | psql --no-psqlrc --quiet -t -h "${host}" -p "${port}" "${dbname}"
        select definition
        from agdc.dataset_type
        where name = '${name}';
EOF
}

dc-index-eo3 () {
    fd odc-metadata.yaml $1 | tar cvf - --files-from=-  | dc-index-from-tar -E dsg547 --eo3 --ignore-lineage --protocol file -
}
