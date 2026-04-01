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

# attach to the session matching cwd, or create it if it doesn't exist
# also sets the terminal title to the session name
# source: https://github.com/fcoury/config/blob/master/fish/conf.d/tmux.fish
function t
    set session_name (basename (pwd) | string replace '.' '_')
    printf '\033]0;💻 %s\007' "$session_name"
    if tmux has-session -t "$session_name"
        tmux attach-session -t "$session_name"
    else
        tmux new-session -s "$session_name"
    end
end

# tp: tmux session picker
#   no args  -> fzf over existing sessions; Esc falls back to cwd session
#   with arg -> attach to that session name, creating it if needed
#   no sessions at all -> create one for cwd
function tp
    if not command -q tmux
        echo "tmux is not installed"
        return 1
    end

    # no sessions exist yet — just create one for the current directory
    if test (tmux list-sessions 2>/dev/null | wc -l) -eq 0
        set session_name (basename (pwd) | string replace '.' '_')
        printf '\033]0;💻 %s\007' "$session_name"
        tmux new-session -s "$session_name"
        return
    end

    if test (count $argv) -eq 0
        # interactive pick via fzf
        set selected_session (tmux list-sessions -F "#{session_attached} #{session_name}#{?session_attached, (attached),}" | sort -rn | string replace -r '^\d+ ' '' | fzf --height 40% --reverse | string replace -r ' \(attached\)$' '')

        if test -n "$selected_session"
            printf '\033]0;💻 %s\007' "$selected_session"
            tmux attach-session -t "$selected_session"
        else
            # fzf cancelled — fall back to cwd session
            set session_name (basename (pwd) | string replace '.' '_')
            printf '\033]0;💻 %s\007' "$session_name"

            if tmux has-session -t "$session_name" 2>/dev/null
                tmux attach-session -t "$session_name"
            else
                tmux new-session -s "$session_name"
            end
        end
    else
        # explicit session name provided
        set session_name $argv[1]
        printf '\033]0;💻 %s\007' "$session_name"

        if tmux has-session -t "$session_name" 2>/dev/null
            tmux attach-session -t "$session_name"
        else
            tmux new-session -s "$session_name"
        end
    end
end

# Capture the current pane content to a temporary file
function tmux-edit
    set -l tmp_file (mktemp)
    tmux capture-pane -pS - >$tmp_file

    # Open the file in Neovim in a new tmux window
    tmux new-window -n "Edit Pane" "nvim $tmp_file; and fish -c 'cat $tmp_file | pbcopy; echo \"Content copied to clipboard\"; read -P \"Press Enter to close... \" -a ignore'"

    # Clean up the temp file (this runs after the window is closed)
    # We use a background job to give time for the new window to fully capture the file
    fish -c "sleep 1; rm $tmp_file" &
end
