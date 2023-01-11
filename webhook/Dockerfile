FROM docker:latest

RUN apk update && apk upgrade

# Install golang
COPY --from=golang:alpine /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"

# Install glibc compatibility libraries
RUN apk add gcompat

# Install webhook
WORKDIR /usr/local/webhook
RUN wget https://github.com/adnanh/webhook/releases/download/2.8.0/webhook-linux-amd64.tar.gz
RUN tar -xf webhook-linux-amd64.tar.gz
RUN mv webhook-linux-amd64/webhook webhook
RUN rm -rf webhook-linux-amd64
RUN rm webhook-linux-amd64.tar.gz

ENTRYPOINT ["/usr/local/webhook/webhook"]
CMD ["-hooks", "/usr/local/etc/webhook/hooks.yaml", "-verbose"]

