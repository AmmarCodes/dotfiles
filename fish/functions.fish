#####################
# Custom Functions  #
#####################

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

# [t]mux [d]ev [l]ayout
# credits: https://github.com/basecamp/omarchy/blob/c3f7575474ccaf2e2eefdf39506cc74d3ab917a6/default/bash/fns/tmux#L3
function tdl -d "Set up a tmux dev layout with editor and AI panes" --argument-names ai
    if test -z "$ai"
        set ai opencode
    end

    if test -z "$TMUX"
        echo "You must start tmux to use tdl."
        return 1
    end

    set -l current_dir $PWD
    set -l editor_pane $TMUX_PANE

    # Name the current window after the base directory name
    tmux rename-window -t "$editor_pane" (basename "$current_dir")

    # Split window vertically - top 85%, bottom 15%
    tmux split-window -v -p 15 -t "$editor_pane" -c "$current_dir"

    # Split editor pane horizontally - AI on right 30%
    set -l ai_pane (tmux split-window -h -p 30 -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')

    # Run AI in the right pane
    tmux send-keys -t "$ai_pane" "$ai" C-m

    # Run editor in the left pane
    tmux send-keys -t "$editor_pane" "$EDITOR ." C-m

    # Select the editor pane for focus
    tmux select-pane -t "$editor_pane"
end
