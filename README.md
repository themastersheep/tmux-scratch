# tmux-scratch

A simple tmux plugin for managing a "scratch" session that allows easy attachment or creation of a scratch session in a tmux popup using a keyboard shortcut without needing to switch out of what you are doing.

#### Key binding(s)

- `M-i` to create or attach to a `scratch` tmux session.
  - If the `scratch` session exists, it detaches the current client.
  - If the `scratch` session doesn't exist, it creates and attaches to it.
  - Provides a popup when creating the `scratch` session for easy interaction.
- `prefix-n` to create or attach to a new tmux session from the `current_pane_path`
  - If a session named using `current_pane_path` exists, it detaches the current client and attaches to it
  - If a session named using `current_pane_path` doesn't exist, it creates and attaches to it.
  - Provide a way to quickly create a new session (or `themastersheep/tmux-workspaces`) from the `scratch` popup

#### Dependencies

`tmux 1.9` or higher, `bash`,
[tmux-scratch](https://github.com/themastersheep/tmux-scratch) plugin.

#### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Please make sure you have
[tmux-scratch](https://github.com/themastersheep/tmux-scratch) installed.

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'themastersheep/tmux-scratch'

Hit `prefix + I` to fetch the plugin and source it. The plugin will
automatically start "working" in the background, no action required.

#### Manual Installation

Please make sure you have
[tmux-scratch](https://github.com/themastersheep/tmux-scratch) installed.

Clone the repo:

    $ git clone https://github.com/themastersheep/tmux-scratch ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/scratch.tmux

Reload TMUX environment with: `$ tmux source-file ~/.tmux.conf`

The plugin will automatically start "working" in the background, no action
required.

#### License
[MIT](LICENSE)
