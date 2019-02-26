autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

autoload -U promptinit
promptinit

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

# binding for history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


HISTSIZE=10000 # Lines of history to keep in memory for current session
HISTFILESIZE=10000 # Number of commands to save in the file
SAVEHIST=10000 # Number of history entries to save to disk
HISTFILE=$HOME/.zsh_history # Where to save history to disk
HISTDUP=erase # Erase duplicates in the history file
setopt hist_ignore_dups # Ignore duplicates
setopt append_history # Append history to the history file (no overwriting)
setopt share_history # Share history across terminals
setopt inc_append_history # Immediately append to the history file, not just when a term is killed
setopt extended_glob # Use extended globbing syntax



# setopt hist_ignore_all_dups # remove older duplicate entries from history
# setopt hist_reduce_blanks # remove superfluous blanks from history items
# setopt inc_append_history # save history entries as soon as they are entered
# setopt share_history # share history between different instances of the shell

setopt correct_all # autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion


zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'


# User configuration

# Paths
export PATH="/Users/nose/.composer/vendor/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.6.0/bin/:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
# NVM
export NVM_DIR="$HOME/.nvm"

export ANT_HOME=/usr/local/opt/ant
export MAVEN_HOME=/usr/local/opt/maven
export GRADLE_HOME=/usr/local/opt/gradle
export ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_NDK_HOME=/usr/local/opt/android-ndk

export PATH=$ANT_HOME/bin:$PATH
export PATH=$MAVEN_HOME/bin:$PATH
export PATH=$GRADLE_HOME/bin:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH

export GOPATH=$HOME/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:$HOME/.dotfiles/bin"


# Lang settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export EDITOR="nvim"


# Aliases
alias zshconfig="vim ~/.zshrc"
alias cat="bat"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls="ls -Gxh --color=auto"
alias gri="git rebase -i"
alias gam='git commit --amend -C HEAD' # Commit current staged files and amend it to the previous commit message without changing the commit or being prompted
alias gdb="git branch --merged | egrep -v \"(^\*|master|develop|dev|production)\" | xargs git branch -d" # Delete all local branches that have been merged into HEAD

alias lastver="git tag -l | gsort -V | tail -n 1"
alias dep="envoy run deploy && osascript -e 'display notification \"You can check it in the browser, or just ignore the whole thing\" with title \"Deployment finished!\"'"
alias pdep="git push; dep"
alias ass="ga public && gc -m 'Assets generate'"
alias t="todo.sh"
alias vim="nvim"
alias weather="curl http:\/\/wttr.in\/?Q1n"
alias لسف="osascript ~/.dotfiles/bin/change_input.scpt U.S. && gst"
alias doc="docker"
alias docc="docker-compose"
alias dcup="docker-compose up"
alias dcupb="docker-compose up --build -d"
alias dcd="docker-compose down"
alias ..="cd .."
alias ...="cd ../.."
alias kara="vim ~/.dotfiles/karabiner.edn"

function dacc() {
    docker exec -it $1 sh;
}

function llog {
    echo "Printing contents of Laravel Log File"
    echo "Press Ctrl + C to exit"
    echo "Tip: Type 'log.c' to clear contents of Laravel Log File"
    tail -f -n 450 storage/logs/laravel*.log \
  | grep -i -E \
    "^\[\d{4}\-\d{2}\-\d{2} \d{2}:\d{2}:\d{2}\]|Next [\w\W]+?\:" \
    --color
}

function search() {
  emulate -L zsh

  # italic blue paths, pink line numbers, underlined purple matches
  command ag --pager="less -iFMRSX" --color-path=34\;3 --color-line-number=35 --color-match=35\;1\;4 "$@"
}

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


source $HOME/.private_aliases
