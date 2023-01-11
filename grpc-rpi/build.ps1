docker rmi $(docker images -f "dangling=true" -q)
docker build -f .\grpc-rpi.Dockerfile -t grpc-rpi:latest .