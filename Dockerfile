FROM ubuntu:24.04

# Install dependencies
RUN apt-get update -y && apt-get install -y \
    curl \
    sudo \
    net-tools

# find / -name curl

# Install Tailscale
RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

RUN find / -name tailscaled
    
RUN sudo apt-get -yqq update
RUN sudo apt-get -yqq install tailscale

# Write script commands to a file using heredoc syntax
RUN echo '#!/bin/sh' > /start-userspace-tailscaled.sh
RUN echo 'tailscaled --tun=userspace-networking --socks5-server=localhost:1055 --outbound-http-proxy-listen=localhost:1055 > tailscaled.log 2>&1 &' > /start-userspace-tailscaled.sh

RUN chmod +x /start-userspace-tailscaled.sh

ENTRYPOINT ["/bin/bash"]
