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

# Attach to a tmux session, creating it if needed, and set the terminal title.
# tmux reads "." and ":" in targets as separators, so swap them for "_".
function __tmux_attach_or_create --argument-names session_name
    set session_name (string replace -a -r '[.:]' _ -- $session_name)
    printf '\033]0;💻 %s\007' "$session_name"
    if tmux has-session -t "$session_name" 2>/dev/null
        tmux attach-session -t "$session_name"
    else
        tmux new-session -s "$session_name"
    end
end

# attach to the session matching cwd, or create it if it doesn't exist
# source: https://github.com/fcoury/config/blob/master/fish/conf.d/tmux.fish
function t
    __tmux_attach_or_create (basename $PWD)
end

# tp: tmux session picker
#   with arg -> attach to that session name, creating it if needed
#   no args  -> fzf over existing sessions; Esc falls back to cwd session
#   no sessions at all -> create one for cwd
function tp
    if not command -q tmux
        echo "tmux is not installed"
        return 1
    end

    if test (count $argv) -gt 0
        __tmux_attach_or_create $argv[1]
        return
    end

    if not tmux has-session 2>/dev/null
        __tmux_attach_or_create (basename $PWD)
        return
    end

    set -l selected_session (tmux list-sessions -F "#{session_attached} #{session_name}#{?session_attached, (attached),}" | sort -rn | string replace -r '^\d+ ' '' | fzf --height 40% --reverse | string replace -r ' \(attached\)$' '')

    if test -n "$selected_session"
        __tmux_attach_or_create $selected_session
    else
        __tmux_attach_or_create (basename $PWD)
    end
end

# Edit the current pane's scrollback in Neovim; copy it to the clipboard on exit
function tmux-edit
    set -l tmp_file (mktemp)
    tmux capture-pane -pS - >$tmp_file

    # The temp file is removed only after nvim and the copy step finish
    tmux new-window -n "Edit Pane" "nvim $tmp_file; and fish -c 'cat $tmp_file | pbcopy; echo \"Content copied to clipboard\"; read -P \"Press Enter to close... \" -a ignore'; rm -f $tmp_file"
end

# Install a skill into ~/.dotfiles/agents/skills (shared by all agents) and link it for Claude Code.
# `-a opencode` targets the shared ~/.agents/skills dir; claude-code would copy into ~/.claude/skills instead.
function skill-add -d "Install an agent skill globally into dotfiles" --argument-names source
    npx -y skills add -g $source -a opencode $argv[2..] && ~/.dotfiles/install --only link clean >/dev/null
end

function skill-update -d "Update agent skills and relink them"
    npx -y skills update -g -y && ~/.dotfiles/install --only link clean >/dev/null
end
