# dotfiles
This README.md is for https://github.com/dunkgray/dotfiles/edit/master/README.md
It will be added to all yadm systems.

This is a yamd repo https://yadm.io/#

# Installation
```
ssh-keygen -t ed25519 -C "what.ever@where.ever"
cat ~/.ssh/id_rsa.pub   # Get these into gtihub and bitbucket
ssh -T git@github.com  #  check github connection
sudo apt-get install yadm -y
yadm clone git@github.com:dunkgray/dotfiles.git
```

Here are some helpful aliasis
```
alias yma='yadm add'
alias ymcam='yadm commit -am'
alias ymcm='yadm commit -m'
alias ymd='yadm diff'
alias ymdc='yadm diff --cached'
alias ymp='yadm push'
alias ympu='yadm pull --rebase'
alias yms='yadm status'
```
