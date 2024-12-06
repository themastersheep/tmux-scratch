#!/usr/bin/env bash

# Check if the session name is 'scratch'
if [ "$(tmux display-message -p '#{==:#{session_name},scratch}')" == 1 ]; then
    tmux detach-client
else
    # Display a popup and start (or attach) the 'scratch' session
    tmux display-popup -b rounded -E "TERM=xterm tmux new-session -A -s scratch"
fi

