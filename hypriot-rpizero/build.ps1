docker rmi $(docker images -f "dangling=true" -q)
docker build -f .\hypriot-rpizero.Dockerfile -t hypriot-rpizero:latest .