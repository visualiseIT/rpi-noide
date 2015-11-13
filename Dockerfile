FROM hypriot/rpi-node
MAINTAINER Ammon Sarver <manofarms@gmail.com>

RUN npm install noide -g 
VOLUME /codetoedit
WORKDIR /codetoedit
ENTRYPOINT ["noide", "-f"]
