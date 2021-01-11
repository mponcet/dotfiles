# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $? -jobs $(jobs -p | wc -l) -hostname-only-if-ssh -mode compatible -cwd-mode dironly -modules venv,user,host,ssh,cwd,perms,git,hg,jobs,exit,root,aws,kube,terraform-workspace)"

    # Uncomment the following line to automatically clear errors after showing
    # them once. This not only clears the error for powerline-go, but also for
    # everything else you run in that shell. Don't enable this if you're not
    # sure this is what you want.

    #set "?"
}

if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

export EDITOR=vim

alias c='clear'

alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -la --color=auto'
alias ls='ls --color=auto'

alias vi='vim'

alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias zgrep='zgrep --color=auto'

alias rm='rm -I --preserve-root'

alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
