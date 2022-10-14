FROM hashicorp/tfc-agent:latest

USER root

# Install sudo. The container runs as a non-root user default.
RUN apt-get -y install sudo

# Permit tfc-agent to use sudo commands.
RUN echo 'tfc-agent ALL=NOPASSWD: /usr/bin/apt-get , /usr/bin/apt, /usr/bin/curl , /usr/bin/bash' >> /etc/sudoers.d/50-tfc-agent

USER tfc-agent

RUN sudo apt-get update && \
  sudo apt-get install python curl ruby -y && \
  sudo apt-get clean

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

ENTRYPOINT ["/home/tfc-agent/bin/tfc-agent"]
CMD ["-single"]