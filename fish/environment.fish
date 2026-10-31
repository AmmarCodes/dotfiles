###########
# Exports #
###########
set -gx EDITOR nvim

set -gx OPENCODE_EXPERIMENTAL_OXFMT true
set -gx OPENCODE_EXPERIMENTAL_MARKDOWN true

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
else if status is-interactive
    echo "Warning: ~/.private_exports not found. Some features may not work."
end

##########
#  Brew  #
##########
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
set -gx HOMEBREW_NO_EMOJI 1
set -gx HOMEBREW_NO_ASK 1

#########
# Paths #
#########
# -g keeps paths in this file instead of the universal fish_user_paths
fish_add_path -g ~/.dotfiles/bin/
fish_add_path -g /opt/homebrew/opt/coreutils/libexec/gnubin
fish_add_path --global --move --path /opt/homebrew/bin /opt/homebrew/sbin
fish_add_path -g ~/.config/composer/vendor/bin/
fish_add_path -g /Applications/Obsidian.app/Contents/MacOS
fish_add_path -g /Applications/Ghostty.app/Contents/MacOS
fish_add_path -g ~/.bun/bin
fish_add_path -g ~/.local/bin

# Activate mise (must come after PATH setup)
if type -q mise
    mise activate fish | source
end

status is-interactive; and set -gx GPG_TTY (tty)

set -gx PI_SKIP_VERSION_CHECK 1
