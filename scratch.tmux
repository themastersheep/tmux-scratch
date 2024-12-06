#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

tmux bind -n M-i run-shell "$CURRENT_DIR/scripts/scratch.sh"
