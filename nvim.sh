export MYUID=$(id -u)
export MYGID=$(id -g)
export MYPWD="$PWD"
docker compose -f /home/mccullen/p/nvim-docker/docker-compose.yaml run --rm nvim
