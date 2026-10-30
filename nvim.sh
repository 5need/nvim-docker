win_name_before=$(tmux display-message -p '#W')

tmux rename-window "nvim"
tmux setw automatic-rename off

export MYUID="$(id -u)"
export MYGID="$(id -g)"
export MYPWD="$PWD"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$MYUID}"
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"

sudo chown -R "$(id -un):$(id -gn)" /home/mccullen/p/nvim-docker

docker compose \
  -f /home/mccullen/p/nvim-docker/docker-compose.yaml \
  run --rm nvim "$@"

tmux setw automatic-rename on
tmux rename-window "$win_name_before"
