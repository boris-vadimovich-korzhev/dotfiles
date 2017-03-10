export ZSH=/home/svarog/.oh-my-zsh

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='mvim'
 fi

ZSH_THEME="custom"
# DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd/mm/yyyy"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# history
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=10000
SAVEHIST=10000

# Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -El' ;;
esac

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data


plugins=(colorize command-not-found zsh-autosuggestions zsh-completions)

autoload -U compinit && compinit
autoload -U colors && colors

setopt AUTO_CD
setopt extended_glob
setopt longlistjobs
setopt notify
setopt completeinword
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

export EDITOR="vim"
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/home/svarog/bin:$PATH"
export NO_AT_BRIDGE=1
export LD_LIBRARY_PATH=/usr/local/lib/
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

source $ZSH/oh-my-zsh.sh
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/script/02-functions.zsh
source /home/script/99-file-type-highlighter.zsh
source /home/svarog/.rvm/scripts/rvm

#welcome
clear
echo -e ;fortune | toilet -f term -F gay;

#Alias
#eval $(thefuck --alias)
alias qw='setxkbmap us dvorak-l && xrandr --dpi 100'
alias qwe='setxkbmap us dvorak-l'
alias xg='export LANG=en_US.UTF-8'
alias down='cd /home/down'
alias oh='vim /home/doc/oh'
alias c='clear'
alias e='exit'
alias news='newsbeuter'
alias satan='clear && toilet -f pagga -F metal HAIL SATAN | ponysay -f wiona'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias box='compiz-boxmenu-daemon &!'
alias sudo='sudo '
alias vremya='sudo ntpdate 0.us.pool.ntp.org'
alias sudo='nocorrect sudo'
alias l='ls -AClhL --group-directories-first'
alias scrot='scrot -q 100 -d 10 /home/Data/Pictures/scrot/%a-%b-%d-%Y-%H-%M-%S.jpg'
alias scrots='scrot -s'

#Funchions
#dictionary
function dictionary() { curl dict://dict.org/d:"$@" ; }

#colors
function colors()
{
# Display ANSI colours.
esc="\033["
echo -e "\t  40\t   41\t   42\t    43\t      44       45\t46\t 47"
for fore in 30 31 32 33 34 35 36 37; do
line1="$fore  "
line2="    "
for back in 40 41 42 43 44 45 46 47; do
line1="${line1}${esc}${back};${fore}m Normal  ${esc}0m"
line2="${line2}${esc}${back};${fore};1m Bold    ${esc}0m"
done
echo -e "$line1\n$line2"
done
}

gradients() {
    f=3 b=4
    for j in f b; do
      for i in {0..7}; do
        printf -v $j$i %b "\e[${!j}${i}m"
      done
    done

    rst=$'\e[0m'
    bld=$'\e[1m'
    inv=$'\e[7m'

cat << EOF
 ${rst}
 ${f0}█ ${bld}█${rst} ${f1}█ ${bld}█${rst} ${f2}█ ${bld}█${rst} ${f3}█ ${bld}█${rst} ${f4}█ ${bld}█${rst} ${f5}█ ${bld}█${rst} ${f6}█ ${bld}█${rst} $f7█ ${bld}█${rst}
 ${f0}█ ${bld}█${rst} ${f1}█ ${bld}█${rst} ${f2}█ ${bld}█${rst} ${f3}█ ${bld}█${rst} ${f4}█ ${bld}█${rst} ${f5}█ ${bld}█${rst} ${f6}█ ${bld}█${rst} $f7█ ${bld}█${rst}
 ${f0}▓ ${bld}█${rst} ${f1}▓ ${bld}█${rst} ${f2}▓ ${bld}█${rst} ${f3}▓ ${bld}█${rst} ${f4}▓ ${bld}█${rst} ${f5}▓ ${bld}█${rst} ${f6}▓ ${bld}█${rst} $f7▓ ${bld}█${rst}
 ${f0}▒ ${bld}█${rst} ${f1}▒ ${bld}█${rst} ${f2}▒ ${bld}█${rst} ${f3}▒ ${bld}█${rst} ${f4}▒ ${bld}█${rst} ${f5}▒ ${bld}█${rst} ${f6}▒ ${bld}█${rst} $f7▒ ${bld}█${rst}
 ${f0}░ ${bld}█${rst} ${f1}░ ${bld}█${rst} ${f2}░ ${bld}█${rst} ${f3}░ ${bld}█${rst} ${f4}░ ${bld}█${rst} ${f5}░ ${bld}█${rst} ${f6}░ ${bld}█${rst} $f7░ ${bld}█${rst}
 ${rst}
EOF
}
