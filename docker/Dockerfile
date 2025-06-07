ARG BASE_IMAGE=local:latest
FROM $BASE_IMAGE

# Use bash instead of sh for RUN commands
SHELL ["/bin/bash", "-c"]
# This is read to determine terminal profile shell in VS Code
ENV SHELL=/bin/bash

# Capture the --build-args or use default values
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create new user according to above info
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Make non-root user the default
USER $USERNAME

CMD ["bash"]
ENTRYPOINT ["/ros_entrypoint.sh"]