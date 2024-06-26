# Function to get all pane IDs except the currently active one
get_all_pane_ids_except_current() {
  local current_pane=$(tmux display-message -p "#P")
  tmux list-panes -F "#P" | grep -v "^$current_pane$"
}

# Function to send commands to a specific pane or all except the current pane
send() {
  if [ "$1" == "ALL" ]; then
    for pane in $(get_all_pane_ids_except_current); do
      tmux send-keys -t "$pane" "$2" C-m
    done
  else
    tmux send-keys -t "$1" "$2" C-m
  fi
}

# Function to send Ctrl + C to a specific pane or all except the current pane
stop() {
  if [ "$1" == "ALL" ]; then
    for pane in $(get_all_pane_ids_except_current); do
      tmux send-keys -t "$pane" C-c
    done
  else
    tmux send-keys -t "$1" C-c
  fi
}

# Function to send Ctrl + Z to a specific pane or all except the current pane
terminate() {
  if [ "$1" == "ALL" ]; then
    for pane in $(get_all_pane_ids_except_current); do
      tmux send-keys -t "$pane" C-z
    done
  else
    tmux send-keys -t "$1" C-z
  fi
}

# Function to send Ctrl + S to a specific pane or all except the current pane
pause() {
  if [ "$1" == "ALL" ]; then
    for pane in $(get_all_pane_ids_except_current); do
      tmux send-keys -t "$pane" C-s
    done
  else
    tmux send-keys -t "$1" C-s
  fi
}

# Function to send Ctrl + Q to a specific pane or all except the current pane
unpause() {
  if [ "$1" == "ALL" ]; then
    for pane in $(get_all_pane_ids_except_current); do
      tmux send-keys -t "$pane" C-q
    done
  else
    tmux send-keys -t "$1" C-q
  fi
}

# Function to select a specific pane
focus() {
  tmux select-pane -t "$1"
}

# Function to split the current pane or all except the current pane
split() {
  local pane=$1
  local direction=$2
  local percent=$3

  if [ "$pane" == "ALL" ]; then
    for pane_id in $(get_all_pane_ids_except_current); do
      if [ "$direction" == "h" ] || [ "$direction" == "v" ]; then
        tmux split-window -$direction -p $percent -t "$pane_id"
      fi
    done
  else
    if [ "$direction" == "h" ] || [ "$direction" == "v" ]; then
      tmux split-window -$direction -p $percent -t "$pane"
    fi
  fi
}

# Function to close a specific pane or all except the current pane
close() {
  if [ "$1" == "ALL" ]; then
    for pane in $(get_all_pane_ids_except_current); do
      tmux kill-pane -t "$pane"
    done
  else
    tmux kill-pane -t "$1"
  fi
}

# Function to resize a specific pane or all except the current pane
res() {
  local direction=$1
  local size=$2
  local target=$3
  local dir_flag

  case $direction in
    up)
      dir_flag="-U"
      ;;
    down)
      dir_flag="-D"
      ;;
    left)
      dir_flag="-L"
      ;;
    right)
      dir_flag="-R"
      ;;
    *)
      echo "Invalid direction: $direction"
      return 1
      ;;
  esac

  if [ -z "$size" ]; then
    if [ -z "$target" ]; then
      tmux resize-pane $dir_flag
    elif [ "$target" == "ALL" ]; then
      for pane in $(get_all_pane_ids_except_current); do
        tmux resize-pane $dir_flag -t "$pane"
      done
    else
      tmux resize-pane $dir_flag -t "$target"
    fi
  else
    if [ -z "$target" ]; then
      tmux resize-pane $dir_flag $size
    elif [ "$target" == "ALL" ]; then
      for pane in $(get_all_pane_ids_except_current); do
        tmux resize-pane $dir_flag $size -t "$pane"
      done
    else
      tmux resize-pane $dir_flag $size -t "$target"
    fi
  fi
}

# Function to download a file from a client to the local machine
download() {
  tmux send-keys -t "$1" "nc -w 3 -l -p 1234 > $(basename $2)" C-m
  nc $(tmux display-message -p "#{pane_tty}") 1234 < "$2"
}

# Function to upload a file from the local machine to the client
upload() {
  tmux send-keys -t "$1" "nc -w 3 -l -p 1234 < $(basename $2)" C-m
  nc $(tmux display-message -p "#{pane_tty}") 1234 > "$2"
}

# Function to run a local script in a specific pane or all except the current pane
run() {
  if [ "$1" == "ALL" ]; then
    for pane in $(get_all_pane_ids_except_current); do
      tmux send-keys -t "$pane" "$(cat "$2")" C-m
    done
  else
    tmux send-keys -t "$1" "$(cat "$2")" C-m
  fi
}
