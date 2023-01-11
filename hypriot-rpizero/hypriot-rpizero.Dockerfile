FROM ubuntu:focal

# Install needed tools
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y wget unzip python3 python3-pip xmount ewf-tools afflib-tools sleuthkit

# Download and uncompress Hypriot OS Image
RUN wget https://github.com/hypriot/image-builder-rpi/releases/download/v1.12.2/hypriotos-rpi-v1.12.2.img.zip
RUN unzip hypriotos-rpi-v1.12.2.img.zip
RUN rm hypriotos-rpi-v1.12.2.img.zip

# Add Python dependencies
RUN python3 -m pip install imagemounter
RUN python3 -m pip install pytsk3

# Copy local files
COPY user-data.template user-data.template
COPY info.json info.json
COPY user_data_processor.py user_data_processor.py

#ENTRYPOINT [ "user_data_processor.py" ]