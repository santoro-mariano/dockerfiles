docker rmi $(docker images -f "dangling=true" -q)
docker build -f .\papercut-smtp.Dockerfile -t papercut-smtp:5.7.0 -t papercut-smtp:latest .