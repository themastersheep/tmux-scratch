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
    else
        # Display a popup and start (or attach) the 'scratch' session
        tmux display-popup -b rounded -E "TERM=xterm tmux new-session -A -s scratch"
    fi
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

    new_session)
        new_session
        ;;

    *)
        exit 1
        ;;
esac
