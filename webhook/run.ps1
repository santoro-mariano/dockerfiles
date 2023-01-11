docker run `
--name docker-webhook `
--rm -d `
-v /var/run/docker.sock:/var/run/docker.sock `
-v /d/docker/storage/webhook-config:/usr/local/etc/webhook `
-v /d/docker/storage/scripts:/usr/local/webhook/scripts `
-p 9000:9000 `
docker-webhook