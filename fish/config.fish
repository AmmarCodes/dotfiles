set -U fish_greeting # disable fish greeting

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
abbr --add gpm "git push -u origin -o merge_request.create -o merge_request.remove_source_branch -o merge_request.label='frontend' -o merge_request.label='section::fulfillment' -o merge_request.label='group::utilization'"
abbr --add gpm! "git push -u origin -o merge_request.create -o merge_request.remove_source_branch -o merge_request.label='frontend' -o merge_request.label='section::fulfillment' -o merge_request.label='group::utilization' --no-verify"
abbr --add gfo "git fetch origin"
abbr --add gri "git rebase -i"
abbr --add gam 'git commit --amend -C HEAD' # Commit current staged files and amend it to the previous commit message without changing the commit or being prompted
abbr --add gps "git push -o ci.skip" # push with skip ci option
alias gdb "git branch --merged | egrep -v \"(^\*|master|main|develop|dev|staging|production)\" | xargs git branch -d" # Delete all local branches that have been merged into HEAD
function grbm
    git rebase $(git main-branch)
end

function fco -d "Use `fzf` to choose which branch to check out" --argument-names branch
    set -q branch[1]; or set branch ''
    git for-each-ref --format='%(refname:short)' refs/heads | fzf --height 10% --layout=reverse --border --query=$branch --select-1 | xargs git checkout
end

function y -d "Start yazi (TUI file manager)"
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# rails aliases
abbr --add railsc "bin/rails console"
abbr --add railsr "bin/rails routes | less"
abbr --add start-gdk "cd ~/projects/gitlab-development-kit/ && gdk start"
abbr --add stop-gdk "cd ~/projects/gitlab-development-kit/ && gdk stop"

function review -d "Review a GitLab merge request by passing the branch name"
    git fetch origin $argv
    git checkout origin/$argv
    gdk start db
    yarn install --check-files
    bundle install && bin/rails db:migrate && git checkout -- db
    # gdk restart
    noti -m 'MR is ready for review!'
end

###########
# Exports #
###########
set -xU EDITOR nvim

# fzf
set -Ux FZF_DEFAULT_OPTS "\
--reverse \
--border rounded \
--no-info \
--prompt='  '
--pointer='' \
--marker=' ' \
--ansi \
--preview-window="border-rounded" \
--padding="0,1" --scrollbar="" \
--multi"
# --color=bg+:#414559,bg:-1,spinner:#f2d5cf,hl:#e78284 \
# --color=fg:-1,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
# --color=marker:#a6d189,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
# --color=selected-bg:#51576d \

#--pointer=' ' \
#--color='16,bg+:-1,gutter:-1,prompt:5,pointer:5,marker:6,border:4,label:4,header:italic' \

set -Ux FZF_CTRL_R_OPTS "--border-label=' history ' --prompt='  '"

source ~/.private_exports

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
# set --export --prepend PATH "/Users/aalakkad/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

#########
# Paths #
#########
fish_add_path ~/.dotfiles/bin/
fish_add_path ~/.composer/vendor/bin/
fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin

###########
# Sources #
###########
/opt/homebrew/bin/brew shellenv | source
status --is-interactive; and source (jump shell fish | psub)
status --is-interactive; and source (atuin init fish --disable-up-arrow | psub)

#####
# Catppuccin Frappe colors
#
# SETUVAR fish_color_autosuggestion:737994
# SETUVAR fish_color_cancel:e78284
# SETUVAR fish_color_command:7CAFA4
# SETUVAR fish_color_comment:838ba7
# SETUVAR fish_color_cwd:e5c890
# SETUVAR fish_color_end:ef9f76
# SETUVAR fish_color_error:e78284
# SETUVAR fish_color_escape:ea999c
# SETUVAR fish_color_gray:737994
# SETUVAR fish_color_host:8caaee
# SETUVAR fish_color_host_remote:a6d189
# SETUVAR fish_color_keyword:e78284
# SETUVAR fish_color_normal:c6d0f5
# SETUVAR fish_color_operator:f4b8e4
# SETUVAR fish_color_option:a6d189
# SETUVAR fish_color_param:eebebe
# SETUVAR fish_color_quote:a6d189
# SETUVAR fish_color_redirection:f4b8e4
# SETUVAR fish_color_search_match:\x2d\x2dbackground\x3d414559
# SETUVAR fish_color_selection:\x2d\x2dbackground\x3d414559
# SETUVAR fish_color_status:e78284
# SETUVAR fish_color_user:81c8be

set --global hydro_color_pwd "#80AA9D"
set --global hydro_color_git "#AFB846"
set --global hydro_color_duration "#62605F"
set --global hydro_multiline true

set -x ICU_CFLAGS "-I"(brew --prefix icu4c)"/include"
set -x ICU_LIBS "-L"(brew --prefix icu4c)"/lib -licui18n -licuuc -licudata"
