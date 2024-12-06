#!/usr/bin/env bash

bind -n M-i if-shell -F '#{==:#{session_name},scratch}' {
    detach
} {
    display-popup -b rounded -E "TERM=xterm tmux new-session -A -s scratch"
}

