#!/usr/bin/env bash

function _in_a_scratch_session() {

    if [ "$(tmux display-message -p '#{==:#{session_name},scratch}')" == 1 ]; then
        return 0 # true
    fi

    return 1 # false
}

function toggle() {

    if _in_a_scratch_session; then
        tmux detach-client
        return
    fi

    # capture current session; session context changes after call to create new session
    local current_session=$(tmux display-message -p '#S')

    # ensure we have a scratch session
    local target_session="scratch"
    if ! tmux has-session -t "$target_session" 2>/dev/null; then
        
        local global_dir=$(tmux show-options -gqv "@tmux_scratch_global_dir")
        if [ -z "$global_dir" ]; then
            global_dir="$HOME"
        fi
        
        tmux new-session -d -s "$target_session" -n "global" -c "$global_dir"

        # Configure custom status line for scratch session - show only "global" or "local" on the right
        tmux set-option -t "$target_session" status on
        tmux set-option -t "$target_session" status-style "bg=default,fg=default"
        tmux set-option -t "$target_session" status-format[0] "#[align=right]#[fg=colour6]tmux-scratch#[fg=default](#{?#{==:#{window_name},global},global,local})"
    fi

    if [ "$1" == "global" ]; then
        tmux display-popup -E "tmux attach-session -t '$target_session:global';"
        return
    fi

    local window=$(tmux list-windows -t "$current_session:" -F '#{window_name}' | grep '^scratch_' | head -n 1)
    if [ -z "$window" ]; then
        window="scratch_$(date +%s)"
        tmux new-window -d -n "$window" -t "$current_session:"
    fi

    # Link the window to the scratch session. It will become the current window there.
    tmux link-window -s "$current_session:$window" -t "$target_session:-"

    # Display popup. When the popup is closed (attach-session exits),
    # unlink the window from the scratch session (silence errors if the window was killed)
    tmux display-popup -E "tmux attach-session -t '$target_session'; tmux unlink-window -t '$target_session:$window' 2>/dev/null || true"
}

function new_session() {

    if _in_a_scratch_session; then
        tmux detach-client
    fi

    local cwd="$(tmux display-message -p "#{pane_current_path}")"
    local session_id=${cwd//./_}

    # tmux replaces "." with "_" when creating sessions
    if ! tmux has-session -t "$session_id" 2>/dev/null; then
        tmux new-session -d -s "$session_id" -c "$cwd"
    fi

    tmux switch-client -t "$session_id"
}

case "$1" in

    toggle)
        toggle
        ;;

    toggle_global)
        toggle "global"
        ;;

    new_session)
        new_session
        ;;

    *)
        exit 1
        ;;
esac
