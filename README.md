# tmux-scratch

A tmux plugin that gives you instant, disposable "scratch" workspaces — opened
in a tmux popup on demand, and dismissed just as fast.

A scratch workspace is a place to run a quick command, inspect some output, or
open a shell without disturbing your current window layout. You summon it with a
key, do your work, and dismiss it with the same key. Your main session is left
exactly as it was.

The plugin provides **two kinds** of scratch workspace:

| | Per-session ("local") | Global |
|---|---|---|
| **Binding** | `M-i` (Alt+i) | `M-I` (Alt+Shift+i) |
| **Scope** | Belongs to your current tmux session | Shared across *all* sessions |
| **Persists?** | Yes — survives in the background until you close it | Yes |
| **Use case** | Quick throwaway shell tied to what you're working on | One shared workspace available everywhere |

The binding you press **toggles** the popup: press it once to open the scratch
popup, press it again (or close the popup) to dismiss it. Pressing the binding
while already inside the scratch popup detaches and returns you to where you
were.

> **Note on key notation:** `M` means Alt (Meta). The two toggle bindings are
> case-sensitive and **do not require the tmux prefix** — `M-i` is Alt+i, `M-I`
> is Alt+Shift+i. The session-switching binding below *does* use the prefix.

The third feature is quick **session switching**: `prefix + n` creates or
attaches to a tmux session named after the current pane's directory, letting you
jump between project directories as sessions.

#### What you get out of the box

With no configuration, after installing:

- `Alt+i` opens/closes a per-session scratch popup.
- `Alt+Shift+i` opens/closes the shared global scratch popup.
- `prefix + n` switches to a session for the current directory.
- The scratch popup shows a minimal, transparent status line on the right
  indicating whether you are in the **global** or **local** (per-session)
  workspace. Note: the plugin sets this status line on the `scratch` session, so
  if you use a custom tmux status theme it will be replaced within the scratch
  popup.

#### Dependencies

- `tmux` **3.1** or higher (the plugin uses `display-popup`, introduced in 3.1)
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

Reload the tmux environment:

```sh
tmux source-file ~/.tmux.conf
```

#### Configuration

All options are optional. To customise everything at once, add this block to
your `.tmux.conf` (values shown are the defaults):

```tmux
# Per-session scratch toggle (prefix not required)
set -g @tmux_scratch_toggle_bind "M-i"
# Global scratch toggle (prefix not required)
set -g @tmux_scratch_toggle_global_bind "M-I"
# Create/attach a session for the current directory (uses prefix)
set -g @tmux_scratch_new_session_bind "n"
# Starting directory for the global scratch window
set -g @tmux_scratch_global_dir "$HOME"
```

These must be set **before** the plugin is loaded (i.e. before the
`set -g @plugin` / `run-shell` line).

#### Configuration reference

| Option | Description | Default | Requires prefix? |
|---|---|---|---|
| `@tmux_scratch_toggle_bind` | Key to toggle the per-session scratch popup | `M-i` | No |
| `@tmux_scratch_toggle_global_bind` | Key to toggle the global scratch popup | `M-I` | No |
| `@tmux_scratch_new_session_bind` | Key to create/attach a session for the current directory | `n` | Yes |
| `@tmux_scratch_global_dir` | Starting directory for the global scratch window | `$HOME` | — |

#### License

[MIT](LICENSE)
