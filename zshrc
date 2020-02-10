autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit
else
  compinit -C
fi

autoload -U promptinit
promptinit

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

export TERM="xterm-256color"

# binding for history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# iterm shell integration
source ~/.iterm2_shell_integration.zsh

if [ -f ~/.private_exports ]; then
  source ~/.private_exports
fi

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


setopt correct # autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

setopt AUTO_CD                 # [default] .. is shortcut for cd .. (etc)
setopt AUTO_PARAM_SLASH        # tab completing directory appends a slash
setopt AUTO_PUSHD              # [default] cd automatically pushes old dir onto dir stack
setopt MENU_COMPLETE           # auto-insert first possible ambiguous completion
setopt NO_NOMATCH              # [default] unmatched patterns are left unchanged
setopt PRINT_EXIT_VALUE        # [default] for non-zero exit status
setopt SHARE_HISTORY           # share history across shells
setopt PUSHD_IGNORE_DUPS       # don't push multiple copies of same dir onto stack


autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line # https://github.com/wincent/wincent/blob/master/roles/dotfiles/files/.zshrc#L208


zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
# zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # https://github.com/wincent/wincent/blob/master/roles/dotfiles/files/.zshrc#L37



zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# User configuration

# Paths
export PATH="/Users/nose/.composer/vendor/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.6.0/bin/:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  --no-use # This loads nvm

# Fastlane
export PATH="$HOME/.fastlane/bin:$PATH"

export ANT_HOME=/usr/local/opt/ant
export MAVEN_HOME=/usr/local/opt/maven
export GRADLE_HOME=/usr/local/opt/gradle
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_NDK_HOME=/usr/local/opt/android-ndk

export PATH=$ANT_HOME/bin:$PATH
export PATH=$MAVEN_HOME/bin:$PATH
export PATH=$GRADLE_HOME/bin:$PATH
# avdmanager, sdkmanager
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
# adb, logcat
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
# emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator


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
alias gdb="git branch --merged | egrep -v \"(^\*|master|develop|dev|staging|production)\" | xargs git branch -d" # Delete all local branches that have been merged into HEAD

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
alias wm="vim ~/Desktop/working-memory.md" # edit working memory file
alias wmc="bat --theme OneHalfLight ~/Desktop/working-memory.md" # read working memory file
alias ee="cd ~/projects/gdk-ee/gitlab"
alias :q="exit"
alias mux="tmuxinator"

# Find in files (search for string and return list of files that contains that string).
function fif() {
  rg $1 . -l ;
}

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

# git commit browser (searches commits)
gbrowse()
{
  git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"  | \
   fzf --ansi --no-sort --reverse --tiebreak=index --preview \
   'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1 ; }; f {}' \
   --bind "j:down,k:up,alt-j:preview-down,alt-k:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,q:abort,ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF" --preview-window=right:60%
}


function search() {
  emulate -L zsh

  # italic blue paths, pink line numbers, underlined purple matches
  command ag --pager="less -iFMRSX" --color-path=34\;3 --color-line-number=35 --color-match=35\;1\;4 "$@"
}

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND="rg --files"
export FZF_DEFAULT_OPTS="--preview '(bat --style=numbers --color=always {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export BAT_THEME="TwoDark"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color fg:250,hl:72,fg+:223,bg+:237,hl+:72
--color pointer:167,info:109,spinner:214,header:214,prompt:175,marker:208'

j() {
    if [[ "$#" -ne 0 ]]; then
        cd $(autojump $@)
        return
    fi
    cd "$(autojump -s | sort -k1gr | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' |  fzf --height 40% --reverse --inline-info)"
}


source $HOME/.private_aliases
export PATH="/usr/local/opt/postgresql@10/bin:/usr/local/opt/node@12/bin:$PATH"

# Ruby stuff
export PATH="$HOME/.rbenv/bin:$PATH"

eval "$(rbenv init -)"

export PATH="/usr/local/opt/qt@5.5/bin:$PATH"

export PATH="$HOME/Qt5.5.0/5.5/clang_64/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_user dir vcs)
# POWERLEVEL9K_MODE='nerdfont-complete'
# # POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# # POWERLEVEL9K_VCS_GIT_ICON=$'\uf113 '
# POWERLEVEL9K_VCS_GIT_GITLAB_ICON=$'\uf296 '
# POWERLEVEL9K_VCS_BRANCH_ICON=''
# POWERLEVEL9K_VCS_HIDE_TAGS=true
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

set-window-title() {
  window_title="\e]0;${${PWD/#"$HOME"/~}/projects/p}\a"
  echo -ne "$window_title"
}

PR_TITLEBAR=''
set-window-title
add-zsh-hook precmd set-window-title


function auto-ls-ls () {
  ls -Gxh --color=auto
}

AUTO_LS_COMMANDS=(ls '[[ -d $PWD/.git ]] && git status')

source <(antibody init)
antibody bundle < ~/.dotfiles/zsh_plugins.txt

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
fpath+=${ZDOTDIR:-~}/.zsh_functions
