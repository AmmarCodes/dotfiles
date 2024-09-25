### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
# set --export --prepend PATH "/Users/aalakkad/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

set fish_greeting # disable welcome message


jump shell fish | source

# Aliases
alias zshconfig="vim ~/.zshrc"
alias vimconfig="cd ~/.config/nvim && nvim"
alias espansoconfig="cd ~/.dotfiles/espanso && nvim"
alias wezconfig="vim ~/.wezterm.lua"
alias aerospaceconfig="vim ~/.aerospace.toml"
alias cat="bat"
alias e="exit"
alias q="exit"
alias ls="eza --group-directories-first -G  --color auto --icons -s type"
alias tree="eza --tree --level=5 --icons --group-directories-first --color auto"
alias gri="git rebase -i"
alias gam='git commit --amend -C HEAD' # Commit current staged files and amend it to the previous commit message without changing the commit or being prompted
alias gdb="git branch --merged | egrep -v \"(^\*|master|main|develop|dev|staging|production)\" | xargs git branch -d" # Delete all local branches that have been merged into HEAD
alias gpm="git push -u origin -o merge_request.create -o merge_request.remove_source_branch -o merge_request.label='frontend' -o merge_request.label='section::fulfillment' -o merge_request.label='group::utilization'" # Push the current branch and create a merge request for it
alias gps="git push -o ci.skip" # push with skip ci option

alias lastver="git tag -l | gsort -V | tail -n 1"
alias t="todo.sh"
alias vim="nvim"
alias v="nvim"
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
alias upgrade-nvim="brew unlink neovim && brew install --fetch-HEAD --HEAD neovim && brew unlink neovim && brew link neovim -f"

# git aliases
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gbD="git branch -D"
alias gaa="git add --all"
alias gc="git commit --verbose"
alias gca="git commit --verbose --all"
alias gca!="git commit --verbose --all --amend"
alias gc!="git commit --verbose --amend"
alias gst="git status"
alias gstp="git stash apply stash@\{0\}"
alias gco="git checkout"
alias grb="git rebase"
alias grbi="git rebase -i"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias glo="git log --oneline --decorate"
alias glog="git log --oneline --decorate --graph"
alias gd="git diff"
alias gl="git pull"
alias gp="git push"
alias gpf="git push --force-with-lease --force-if-includes"
alias gpm="git push -u origin -o merge_request.create -o merge_request.remove_source_branch -o merge_request.label='frontend' -o merge_request.label='section::fulfillment' -o merge_request.label='group::utilization'":
alias gfo="git fetch origin"
alias lg="lazygit"

alias fishconfig="cd ~/.config/fish/ && vim config.fish"

#starship init fish | source
#enable_transience

set -xg EDITOR nvim
set -xg HOMEBREW_PREFIX /opt/homebrew
