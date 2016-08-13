#
# ~/.bashrc
#

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Path
export PATH="/usr/local/bin::/usr/bin:/usr/games:/usr/local:/root=/usr/local/rvm/bin:/sbin:/root=/opt/armitage:/usr/sbin:/bin:/usr/local/sbin:/root=/opt/git-cola/bin:"

if [ "$UID" -eq 0 ]; then
PATH=$PATH:/usr/local:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/core_perl:/home/bin:/usr/games
fi

if [ -d "/usr/bin/core_perl/cpan" ] ; then
PATH="/usr/bin/core_perl/cpan:$PATH"
fi

export PATH=$HOME=/usr/local/rvm/bin:$PATH
export PATH=$HOME=/opt/git-cola/bin:$PATH
export PATH=$HOME=/home/down/ls--:$PATH
export PATH=$HOME=/usr/bin/core_perl:$PATH
export JAVA_HOME=jdk-install-dir
export PATH=$JAVA_HOME/bin:$PATH
export JAVA_HOME="/usr/lib/jvm/default/"
export PATH=$HOME=/usr/pkg/bin:$PATH
export GEM_PATH=~/.rvm/gems/ruby-1.9.3-p551:/home/fsj/.rvm/gems/ruby-1.9.3-p551@global
export GEM_HOME=~/.rvm/gems/ruby-1.9.3-p551
export PATH=$HOME=~/bin:$PATH

source /etc/profile

if [ -d "$HOME/bin" ] ; then
PATH="$HOME/bin:$PATH"
fi

# Enviornmant Variables
export BROWSER="torify luakit"
export EDITOR="vim"
export HISTTIMEFORMAT='%Y-%b-%d::%H:%M:%S::'

# ruby
source /home/svarog/.rvm/scripts/rvm

PS1='∙ '
force_color_prompt=yes

#colored man pages
export LESS_TERMCAP_mb=$'\E[01;31m'      # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'      # begin bold
export LESS_TERMCAP_me=$'\E[0m'          # end mode
export LESS_TERMCAP_se=$'\E[0m'          # end standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m'   # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'          # end underline
export LESS_TERMCAP_us=$'\E[01;32m'      # begin underline

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
fi

#Alias
eval $(thefuck --alias)
alias qw='setxkbmap us dvorak-l && xrandr --dpi 100'
alias xg='export LANG=en_US.UTF-8'
alias down='cd /home/down'
alias oh='vim /home/doc/oh'
alias c='clear'
alias news='newsbeuter'
alias makepkg='sudo -u nobody makepkg -sri'
alias satan='clear && toilet -f pagga -F metal HAIL SATAN | ponysay -f wiona'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
#alias box='nohup compiz-boxmenu-daemon &'
alias box='compiz-boxmenu-daemon &!'
alias sudo='sudo '
alias mountbsd='sudo zpool import -fR /home/FreeBSD zroot'
alias vremya='sudo ntpdate 0.us.pool.ntp.org'
alias checkup='packer-color --quickcheck > /home/upcheck.txt'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -rf -i'
alias emacs='emacs -nw'

