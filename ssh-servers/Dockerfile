# Dockerfile
FROM ubuntu:20.04

# Install SSH server
RUN apt-get update && apt-get install -y openssh-server

# Create SSH directory and set root password
RUN mkdir /var/run/sshd && \
    echo 'root:rootpassword' | chpasswd

# Allow root login via SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
