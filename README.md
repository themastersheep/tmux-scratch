# tmux-scratch

A simple tmux plugin for managing "scratch" windows in a tmux popup.

#### Features

- **Per-session scratch window**: A scratch window that is created for the current session and persists in the background. It can be quickly accessed via a popup.
- **Global scratch window**: A single, persistent scratch window that is shared across all sessions and can also be accessed via a popup.
- **Status line indicator**: The popup displays a transparent status line showing whether you're in the global or local scratch window.
- **Quick session switching**: A key binding to quickly create or attach to a new tmux session from the current pane's path.

#### Key Bindings

- **Toggle per-session scratch window**: `M-i`
- **Toggle global scratch window**: `M-I`
- **Create or attach to a new session**: `prefix-n`

#### Dependencies

- `tmux` 1.9 or higher
- `bash`

#### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add the plugin to the list of TPM plugins in `.tmux.conf`:

```tmux
set -g @plugin 'themastersheep/tmux-scratch'
```

Hit `prefix + I` to fetch the plugin and source it.

#### Manual Installation

Clone the repo:

```sh
git clone https://github.com/themastersheep/tmux-scratch ~/clone/path
```

Add this line to the bottom of `.tmux.conf`:

```tmux
run-shell ~/clone/path/scratch.tmux
```

Reload the TMUX environment:

```sh
tmux source-file ~/.tmux.conf
```

#### Configuration

You can configure the key bindings and global scratch directory by adding the following to your `.tmux.conf` file:

- `@tmux_scratch_toggle_bind`
  - Description: Key binding to toggle the per-session scratch window.
  - Default: `M-i`
  - Example:
    ```tmux
    set -g @tmux_scratch_toggle_bind "M-s"
    ```

- `@tmux_scratch_toggle_global_bind`
  - Description: Key binding to toggle the global scratch window.
  - Default: `M-I`
  - Example:
    ```tmux
    set -g @tmux_scratch_toggle_global_bind "M-S"
    ```

- `@tmux_scratch_new_session_bind`
  - Description: Key binding to create or attach to a new session.
  - Default: `n` (used with tmux prefix)
  - Example:
    ```tmux
    set -g @tmux_scratch_new_session_bind "N"
    ```

- `@tmux_scratch_global_dir`
  - Description: Starting directory for the global scratch window.
  - Default: `$HOME`
  - Example:
    ```tmux
    set -g @tmux_scratch_global_dir "/tmp"
    ```

#### License

[MIT](LICENSE)
