#############
## Aliases ##
#############

# Config
abbr --add zshconfig "nvim ~/.zshrc"
abbr --add fishconfig "nvim ~/.config/fish/config.fish"
abbr --add vimconfig "nvim ~/.config/nvim"
abbr --add espansoconfig "nvim ~/.dotfiles/espanso"
abbr --add aerospaceconfig "nvim ~/.aerospace.toml"
abbr --add tmuxconfig "nvim ~/.tmux.conf"
abbr --add kara "nvim ~/.dotfiles/karabiner.edn"

alias cat bat
abbr --add e exit
abbr --add q exit
alias ls "eza --group-directories-first --color auto --icons -s type"
alias tree "eza --tree --level=5 --icons --group-directories-first --color auto"

abbr --add vim nvim
abbr --add weather "curl \"https://wttr.in/?Q1n\""
abbr --add doc docker
abbr --add docc docker-compose
abbr --add dcup "docker-compose up"
abbr --add dcupb "docker-compose up --build -d"
abbr --add dcd "docker-compose down"
abbr --add wm "nvim ~/Desktop/working-memory.md" # edit working memory file
abbr --add wmc "bat ~/Desktop/working-memory.md" # read working memory file
abbr --add :q exit
abbr --add mux tmuxinator
abbr --add be "bundle exec"
abbr --add ll "ls -lah"
abbr --add upgrade-nvim "brew unlink neovim && brew install --fetch-HEAD --HEAD neovim && brew unlink neovim && brew link neovim -f"

# git aliases
abbr --add g git
abbr --add lg lazygit
abbr --add ga "git add"
abbr --add gb "git branch"
abbr --add gbD "git branch -D"
abbr --add gaa "git add --all"
abbr --add gc "git commit"
abbr --add gcm "git commit -m"
abbr --add gcm! "git commit --amend -m"
abbr --add gca "git commit --all"
abbr --add gca! "git commit --all --amend"
abbr --add gca!! "git commit --all --amend --no-edit"
abbr --add gca!!! "git commit --all --amend --no-edit --no-verify"
abbr --add gc! "git commit --amend"
abbr --add gc!! "git commit --amend --no-edit"
abbr --add gst "git status"
abbr --add gstp "git stash apply stash@\{0\}"
abbr --add gco "git checkout"
abbr --add c "git checkout"
abbr --add grb "git rebase"
abbr --add grbi "git rebase -i"
abbr --add grba "git rebase --abort"
abbr --add grbc "git rebase --continue"
abbr --add glo "git log --oneline --decorate"
abbr --add glog "git log --oneline --decorate --graph"
abbr --add gd "git diff"
abbr --add gl "git pull"
abbr --add gp "git push"
abbr --add gpf "git push --force-with-lease --force-if-includes"
abbr --add gpf! "git push --force-with-lease --force-if-includes --no-verify"
abbr --add gfo "git fetch origin"
abbr --add gri "git rebase -i"
abbr --add gam 'git commit --amend -C HEAD' # Commit current staged files and amend it to the previous commit message without changing the commit or being prompted
abbr --add gps "git push -o ci.skip" # push with skip ci option
alias gdb "git branch --merged | egrep -v \"(^\*|master|main|develop|dev|staging|production)\" | xargs git branch -d" # Delete all local branches that have been merged into HEAD
