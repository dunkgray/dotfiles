
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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

alias quota='quota -sQ' # Human readable and ignore NFS errors

# Grep default options, that you don't have to type with the command
grep_options='--color=auto'
for PATTERN in .git .hg .svn .work; do
    grep_options="$grep_options --exclude-dir=$PATTERN"
done
alias grep="grep $grep_options"

alias dos2unix='sed "s/$//"'

# ------------------------------------------------------------------------------
# dsg
# ------------------------------------------------------------------------------
alias gadi='ssh -Y dsg547@gadi.nci.org.au'
alias awsnemo='ssh  -i ~/.ssh/id_rsa_nci_cron_ec2 ec2-user@ec2-52-62-73-33.ap-southeast-2.compute.amazonaws.com'

# ------------------------------------------------------------------------------
# bash
# ------------------------------------------------------------------------------
alias ll='ls -l'
alias la='ls -la'
alias lr='ls -lacr'
alias ld='ls -ld .*'
alias hg='history | grep'
alias ag='alias | grep'
alias sbr='source ~/.bashrc'
alias lcd='cd $(ls -cr | tail -n 1 )'

# ------------------------------------------------------------------------------
# apt-get
# ------------------------------------------------------------------------------
alias inst='sudo apt-get install'
alias uu='sudo apt-get update && sudo apt-get upgrade'
alias sc='sudo apt-get autoremove'

# ------------------------------------------------------------------------------
# git
# ------------------------------------------------------------------------------
alias ga='git add'
alias gaa='git add -A'
alias gba='git branch --all'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbn='git checkout -b'
alias gcann='git commit --amend --no-edit --no-verify'
alias gcl='git clone'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gfa='git fetch --all'
alias gl='git log --branches --remotes --tags --graph --oneline --decorate'
alias gp='git push'
alias gpf='git push -f'
alias gpsuo='git push --set-upstream origin'
alias gpu='git pull'
alias gpuff='git pull --ff-only'
alias gpur='git pull --rebase --autostash'
alias gpurm='git fetch --all && git pull --rebase --autostash origin master'
alias gpurmi='git fetch --all && git rebase --interactive --autostash origin/master'
alias gmm='git fetch --all && git merge origin/master'
alias gr='git rebase --autostash'
alias gri='git rebase --interactive'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias grs='git rebase --skip'
alias grv='git remote -v'
alias greh='git reset --hard'
alias gri='git rebase --interactive'
alias grsh='git reset --hard'
alias gs='git status'
alias gstl='git stash list'
alias gst='git stash'
alias gsts='git stash show'
alias gstp='git stash pop'
alias gstpi='git stash pop --index'
alias gsta='git stash apply'
alias gcp='git cherry-pick'
alias gcpc='git cherry-pick --continue'
alias gcpa='git cherry-pick --abort'

alias gc='git-cz'
alias gcr='git-cz --retry'

function pushAll() {
  echo What is your message?
  read -r commit_message
  gaa && gcm "$commit_message" && gp
}

# ------------------------------------------------------------------------------
# yadm
# ------------------------------------------------------------------------------

alias yms='yadm status'
alias yma='yadm add'
alias ymp='yadm push'
alias ymcm='yadm commit -m'
alias ymcam='yadm commit -am'
alias ymd='yadm diff'
alias ymdc='yadm diff --cached'
alias ympu='yadm pull --rebase'
alias ymp='yadm push'

function ymln() {
  yadm log "-$1"
}

################################################################################
# tmux
################################################################################

alias t='tmux'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tl='tmux ls'
alias tk='tmux kill-session -t'