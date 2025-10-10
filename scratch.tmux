#!/usr/bin/env bash

main() {
  local CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  # get key bindings from tmux options, with defaults
  local KEY_TOGGLE=$(tmux show-options -gqv "@tmux_scratch_toggle_bind")
  if [ -z "$KEY_TOGGLE" ]; then
    KEY_TOGGLE="M-i"
  fi

  local KEY_TOGGLE_GLOBAL=$(tmux show-options -gqv "@tmux_scratch_toggle_global_bind")
  if [ -z "$KEY_TOGGLE_GLOBAL" ]; then
    KEY_TOGGLE_GLOBAL="M-I"
  fi

  # TODO move to tmux-workspaces
  local KEY_NEW_SESSION=$(tmux show-options -gqv "@tmux_scratch_new_session_bind")
  if [ -z "$KEY_NEW_SESSION" ]; then
    KEY_NEW_SESSION="n"
  fi

  tmux bind -n "$KEY_TOGGLE" run-shell "$CURRENT_DIR/scripts/scratch.sh toggle"
  tmux bind -n "$KEY_TOGGLE_GLOBAL" run-shell "$CURRENT_DIR/scripts/scratch.sh toggle_global"
  tmux bind "$KEY_NEW_SESSION" run-shell "$CURRENT_DIR/scripts/scratch.sh new_session"
}

main
