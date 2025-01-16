#!/bin/bash
# Get the current pane details
pane_command=$(tmux display -p "#{pane_current_command}")

# Check if the current pane is running SSH
if [[ "$pane_command" == "ssh" ]]; then
    # Extract the SSH destination
    ssh_dest=$(tmux capture-pane -p | grep -oP '(?<=ssh ).*@.*' | tail -n 1 | grep -oP '^\b\S+@\S+\b' | sed 's/\.dkrz\.de$//')
    if [[ -n "$ssh_dest" ]]; then
        tmux rename-window "󰢩  $ssh_dest"
        exit 0
    fi
elif [[ "$pane_command" == "vim" ]] || [[ "$pane_command" == "nvim" ]]; then
        tmux rename-window " nvim"
elif [[ "$pane_command" == "docker" ]]; then
        tmux rename-window " docker"
elif [[ "$pane_command" == "zsh" ]]; then
# Otherwise, rename based on the current directory
    current_dir=$(tmux display -p "#{pane_current_path}")
    if [[ -n "$current_dir" ]]; then
        if [[ "$current_dir" == "$HOME" ]]; then
            base_dir=" Home"
        else
            repo_name=$(basename "$(git -C $current_dir rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null)
            if [ -n "$repo_name" ]; then
                branch_name=$(git -C $current_dir rev-parse --abbrev-ref HEAD 2>/dev/null)
                
                # Form the output with repo name and branch name in braces
                base_dir=" ${repo_name} (${branch_name})"
            else
                base_dir=$(basename "$current_dir")
                if [[ "$current_dir" != /home/* ]]; then
                    base_dir=" $current_dir"
                fi
            fi
        fi
        tmux rename-window "$base_dir"
    else
        tmux setw automatic-rename
    fi
else
    tmux setw automatic-rename
fi
