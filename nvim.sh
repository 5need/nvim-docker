export MYUID=$(id -u)
export MYGID=$(id -g)
export MYPWD="$PWD"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$MYUID}"
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"  # fallback if not set

docker compose -f /home/mccullen/p/nvim-docker/docker-compose.yaml run --rm nvim
