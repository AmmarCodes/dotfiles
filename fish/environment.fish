###########
# Exports #
###########
set -gx EDITOR nvim

# fzf
set -gx FZF_DEFAULT_OPTS "\
--reverse \
--border rounded \
--no-info \
--prompt='  '
--pointer='' \
--marker=' ' \
--ansi \
--preview-window="border-rounded" \
--padding="0,1" --scrollbar="" \
--multi"

set -gx FZF_CTRL_R_OPTS "--border-label=' history ' --prompt='  '"

if test -f ~/.private_exports
    source ~/.private_exports
else
    echo "Warning: ~/.private_exports not found. Some features may not work."
end

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
# set --export --prepend PATH "/Users/aalakkad/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

##########
#  Brew  #
##########
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
set -gx HOMEBREW_NO_EMOJI 1

#########
# Paths #
#########
fish_add_path ~/.dotfiles/bin/
fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin
fish_add_path ~/.local/share/mise/shims
fish_add_path --global --move --path /opt/homebrew/bin /opt/homebrew/sbin
fish_add_path ~/.config/composer/vendor/bin/

# set -gx RUBYOPT "-r$HOME/.rubyopenssl_default_store.rb $RUBYOPT"

# set -x ICU_CFLAGS "-I"(brew --prefix icu4c)"/include"
# set -x ICU_LIBS "-L"(brew --prefix icu4c)"/lib -licui18n -licuuc -licudata"
