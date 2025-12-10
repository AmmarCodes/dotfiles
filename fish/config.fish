set fish_greeting # disable fish greeting

###########
# Sources #
###########

# Load modular configuration
source ~/.config/fish/environment.fish
source ~/.config/fish/abbreviations.fish
source ~/.config/fish/functions.fish
source ~/.config/fish/themes.fish

# Load GitLab-specific configuration if it exists
if test -f ~/.config/fish/gitlab.fish
    source ~/.config/fish/gitlab.fish
end

# Lazy-load jump and atuin
status --is-interactive; and function __init_deferred_tools --on-event fish_prompt
    functions --erase __init_deferred_tools # Run only once
    if type -q jump
        source (jump shell fish | psub)
    end
    if type -q atuin
        source (atuin init fish --disable-up-arrow | psub)
    end
end
