FROM ubuntu:latest

# Install needed tools
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y wget unzip mono-complete

# Download and uncompress papercut
RUN wget https://github.com/ChangemakerStudios/Papercut-SMTP/releases/download/5.7.0/PapercutService.5.7.0.zip
RUN mkdir papercut
RUN unzip PapercutService.5.7.0.zip -d /papercut
RUN rm PapercutService.5.7.0.zip

WORKDIR /papercut

ENTRYPOINT [ "mono", "Papercut.Service.exe" ]