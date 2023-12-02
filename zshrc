# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# load asdf
# if [ -f ~/.asdf/asdf.sh ]; then
#   . ~/.asdf/asdf.sh
# fi

# append asdf completions to fpath
# fpath=(${ASDF_DIR}/completions $fpath)

eval "$(/opt/homebrew/bin/rtx activate zsh)"

autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit
else
  compinit -C
fi

autoload -U promptinit
promptinit

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

export TERM="xterm-256color"

# iterm shell integration
# source ~/.iterm2_shell_integration.zsh

if [ -f ~/.private_exports ]; then
  source ~/.private_exports
fi

HISTSIZE=9999999 # Lines of history to keep in memory for current session
HISTFILESIZE=9999999 # Number of commands to save in the file
SAVEHIST=9999999 # Number of history entries to save to disk
HISTFILE=$HOME/.zsh_history # Where to save history to disk
HISTDUP=erase # Erase duplicates in the history file
setopt hist_ignore_dups # Ignore duplicates
setopt append_history # Append history to the history file (no overwriting)
setopt share_history # Share history across terminals
setopt inc_append_history # Immediately append to the history file, not just when a term is killed
setopt extended_glob # Use extended globbing syntax
setopt HIST_IGNORE_SPACE # Prefix a command with space to exclude it from history


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
bindkey -e


zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
# zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # https://github.com/wincent/wincent/blob/master/roles/dotfiles/files/.zshrc#L37
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# User configuration

# Paths
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
# NVM
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  --no-use # This loads nvm

export ANT_HOME=/opt/homebrew/opt/ant
export MAVEN_HOME=/opt/homebrew/opt/maven
export GRADLE_HOME=/opt/homebrew/opt/gradle
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_NDK_HOME=/opt/homebrew/opt/android-ndk

export PATH=$ANT_HOME/bin:$PATH
export PATH=$MAVEN_HOME/bin:$PATH
export PATH=$GRADLE_HOME/bin:$PATH
# avdmanager, sdkmanager
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
# adb, logcat
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
# emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator


export PATH="/opt/homebrew/sbin:$PATH"
export PATH="$PATH:$HOME/.dotfiles/bin"


# Lang settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export EDITOR="nvim"


# Aliases
alias zshconfig="vim ~/.zshrc"
alias vimconfig="cd ~/.config/nvim && nvim"
alias wezconfig="vim ~/.wezterm.lua"
alias cat="bat"
alias e="exit"
alias q="exit"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls="exa --icons"
alias gri="git rebase -i"
alias gam='git commit --amend -C HEAD' # Commit current staged files and amend it to the previous commit message without changing the commit or being prompted
alias gdb="git branch --merged | egrep -v \"(^\*|master|main|develop|dev|staging|production)\" | xargs git branch -d" # Delete all local branches that have been merged into HEAD
alias gpm="git push -u origin -o merge_request.create -o merge_request.remove_source_branch -o merge_request.label='frontend' -o merge_request.label='section::fulfillment' -o merge_request.label='group::utilization'" # Push the current branch and create a merge request for it
alias gps="git push -o ci.skip" # push with skip ci option

alias lastver="git tag -l | gsort -V | tail -n 1"
alias t="todo.sh"
alias vim="nvim"
alias weather="curl http:\/\/wttr.in\/?Q1n"
alias doc="docker"
alias docc="docker-compose"
alias dcup="docker-compose up"
alias dcupb="docker-compose up --build -d"
alias dcd="docker-compose down"
alias kara="vim ~/.dotfiles/karabiner.edn"
alias wm="vim ~/Desktop/working-memory.md" # edit working memory file
alias wmc="bat ~/Desktop/working-memory.md" # read working memory file
alias :q="exit"
alias mux="tmuxinator"
alias be="bundle exec"
alias ll="ls -lah"
alias upgrade-nvim="brew unlink neovim && brew install --fetch-HEAD --HEAD neovim && brew link neovim"

alias ctags="`brew --prefix`/bin/ctags"
alias focus="cd ~/projects/focus && vim README.md"

function tmux-gitlab() {
  cd ~/projects/gitlab-development-kit/gitlab
  tmux new -n editor 'nvim'
}

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

listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
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

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND="rg --files"
export FZF_DEFAULT_OPTS="--layout=reverse --border --preview '(bat --style=numbers --theme={} --color=always {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export BAT_THEME="Nord"
# Gruvbox below
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
# --color fg:250,hl:72,fg+:223,bg+:237,hl+:72
# --color pointer:167,info:109,spinner:214,header:214,prompt:175,marker:208'

# palenight
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#   --color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
#   --color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B'

# nord
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#     --color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
#     --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
#     --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
#     --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'
# gruvbox
# export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=bg+:#7c6f64,bg:#3c3836,spinner:#9d0006,hl:#928374,fg:#bdae93,header:#928374,info:#427b58,pointer:#9d0006,marker:#9d0006,fg+:#3c3836,prompt:#83a598,hl+:#b8bb26"

# Catpuccin Latte
export FZF_DEFAULT_OPTS=" \
--color=bg+:#ccd0da,bg:#ffffff,spinner:#dc8a78,hl:#d20f39 \
--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
--color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"


export GIT_COMPLETION_CHECKOUT_NO_GUESS=1

if [ -f ~/.private_aliases ]; then
  source $HOME/.private_aliases
fi

export PATH="/opt/homebrew/opt/postgresql@11/bin:$PATH"


export PATH="/opt/homebrew/opt/qt@5.5/bin:$PATH"

export PATH="$HOME/Qt5.5.0/5.5/clang_64/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.9/libexec/bin:$PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/icu4c/lib/pkgconfig"

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

export BROWSERSLIST_IGNORE_OLD_DATA=true

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


if [[ ! -d $HOME/.zi/bin ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing ZI…%f"
    command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
    command git clone https://github.com/z-shell/zi.git "$HOME/.zi/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zi/bin/zi.zsh"

autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

zi snippet OMZP::git # Oh My Zsh Git Plugin

zi load "djui/alias-tips"
zi load "zsh-users/zsh-history-substring-search"
zi ice lucid wait as'completion'
zi light "zsh-users/zsh-completions"
zi load "changyuheng/zsh-interactive-cd"


# fast-syntax-highlighting and zsh-autosuggestions
zi wait lucid for \
 atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    z-shell/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions


zi ice depth=1; zi light romkatv/powerlevel10k

### End of zi's installer chunk

# binding for history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


# Added by GDK bootstrap
export PKG_CONFIG_PATH="/opt/homebrew/opt/icu4c/lib/pkgconfig:${PKG_CONFIG_PATH}"

# Added by GDK bootstrap
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/opt/homebrew/opt/openssl@1.1 --with-readline-dir=/opt/homebrew/opt/readline"

# source /Users/aalakkad/.config/op/plugins.sh

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/aalakkad/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

eval "$(zoxide init zsh)"

eval "$(jump shell)"

