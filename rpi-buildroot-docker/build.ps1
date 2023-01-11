docker rmi $(docker images -f "dangling=true" -q)
docker build -f .\rpi-buildroot-docker.Dockerfile -t rpi-buildroot-docker:latest .