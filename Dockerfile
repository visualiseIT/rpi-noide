FROM kdelfour/supervisor-docker
MAINTAINER Ammon Sarver <manofarms@gmail.com>


# ------------------------------------------------------------------------------
# Install base
RUN apt-get update
RUN apt-get install -y build-essential g++ curl libssl-dev apache2-utils git libxml2-dev sshfs unzip openjdk-7-jre ruby2.0

# ------------------------------------------------------------------------------
# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs



# ------------------------------------------------------------------------------
# Install Sencha-CMD
RUN curl -o /cmd.sh.zip http://cdn.sencha.com/cmd/6.0.2/no-jre/SenchaCmd-6.0.2-linux-amd64.sh.zip && \
    unzip -p /cmd.sh.zip > /cmd-install.sh && \
    chmod +x /cmd-install.sh
RUN /cmd-install.sh -q
# -q -dir "/opt/sencha-cmd" && \
#    rm /cmd-install.sh /cmd.sh.zip


# -----------------------------------------------------------------------------
RUN npm install noide -g 

# -----------------------------------------------------------------------------
RUN npm install tty.js -g

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir /workspace
VOLUME /workspace
WORKDIR /workspace

RUN noide -f
# ENTRYPOINT ["noide", "-f"]

# ------------------------------------------------------------------------------
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 80
EXPOSE 8080
EXPOSE 1337
EXPOSE 1841
EXPOSE 3000

# ------------------------------------------------------------------------------
# Start supervisor, define default command.
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
