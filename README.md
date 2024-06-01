# Tmux-CnC
![tmuxcmc-ezgif com-speed](https://github.com/GNU-Szmelc/Tmux-CnC/assets/95081005/574a8ac1-87c6-48e4-811c-6f0f836cf1e0)

Command &amp; Control interface for tmux. \
Has few handy aliases to make using tmux easier

### Available aliases
- `stop ID` - Stop currently running process [Ctrl + C]
- `terminate ID` - Terminate currently running process [Ctrl + Z]
- `pause ID` - Pause process [Ctrl + S]
- `unpause ID` - Unpause process [Ctrl + Q]
- `send ID 'command'` - Pass command directly to a pane
- `focus ID` - Focus on a pane
- `split ID h/v [Percent]` - Split pane
- `close ID` - Close pane
- `upload ID /path/to/file` - Upload file to a remote client
- `download ID /path/to/file` - Download file from remote client
- `run ID /path/to/script` - Run local script in a pane
- `res up|down|left|right [size]` - Resize current pane

> Variable `ID` is pane ID, \
> `ALL` can also be used to execute on all panes except currently active. \
> Split pane h = horizontally | v = vertically.

### Extras
> There is demo script using xdotool available, just start `tmuxcnc.sh` then from there start `demo.sh` and enjoy the show
