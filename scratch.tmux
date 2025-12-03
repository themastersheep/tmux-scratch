#!/usr/bin/env bash

main() {
  local current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  # get key bindings from tmux options, with defaults
  local key_toggle=$(tmux show-options -gqv "@tmux_scratch_toggle_bind")
  if [ -z "$key_toggle" ]; then
    key_toggle="M-i"
  fi

  local key_toggle_global=$(tmux show-options -gqv "@tmux_scratch_toggle_global_bind")
  if [ -z "$key_toggle_global" ]; then
    key_toggle_global="M-I"
  fi

  # TODO move to tmux-workspaces
  local key_new_session=$(tmux show-options -gqv "@tmux_scratch_new_session_bind")
  if [ -z "$key_new_session" ]; then
    key_new_session="n"
  fi

  tmux bind -n "$key_toggle" run-shell "$current_dir/scripts/scratch.sh toggle"
  tmux bind -n "$key_toggle_global" run-shell "$current_dir/scripts/scratch.sh toggle_global"
  tmux bind "$key_new_session" run-shell "$current_dir/scripts/scratch.sh new_session"
}

main
