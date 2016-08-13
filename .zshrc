#              			       ██               ██  ██
#		            	      ▒██              ▒██ ▒██
#		       ██████   ██████▒██       █████  ▒██ ▒██
#		      ▒▒▒▒██   ██▒▒▒▒ ▒██████  ██▒▒▒██ ▒██ ▒██
#		         ██   ▒▒█████ ▒██▒▒▒██▒███████ ▒██ ▒██
#		        ██     ▒▒▒▒▒██▒██  ▒██▒██▒▒▒▒  ▒██ ▒██
# 		       ██████  ██████ ▒██  ▒██▒▒██████ ███ ███
#		      ▒▒▒▒▒▒  ▒▒▒▒▒▒  ▒▒   ▒▒  ▒▒▒▒▒▒ ▒▒▒ ▒▒▒
#
#







export ZSH=~/.oh-my-zsh

ZSH_THEME="custom"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd.mm.yyyy"
plugins=(colorize command-not-found zsh-autosuggestions zsh-completions)

autoload -U compinit && compinit
autoload -U colors && colors

#cd w/o cd
setopt AUTO_CD

#bindkey -v

#function zle-line-init zle-keymap-select {
#VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
#RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$(git_custom_status) $EPS1"
#zle reset-prompt
#}

#export KEYTIMEOUT=1

# source
source $ZSH/oh-my-zsh.sh
source /etc/zsh/zprofile
#eval $(dircolors -b ~/.dircolors)
#source /home/script/00.zsh
source /home/script/01-alias.zsh
source /home/script/02-functions.zsh
#source /home/script/04-zplug.zsh
#source /home/script/ls++.zsh
#source /usr/share/zsh/scripts/antigen/antigen.zsh
#source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/script/99-file-type-highlighter.zsh
#source /home/script/auto-fu.zsh

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

