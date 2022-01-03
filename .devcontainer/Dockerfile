# [Choice] Ubuntu version (use hirsuite or bionic on local arm64/Apple Silicon): hirsute, focal, bionic
ARG VARIANT=focal
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# Install and configure zsh
COPY custom-scripts/zsh/* /tmp/library-scripts/
RUN /bin/bash /tmp/library-scripts/update-zsh.sh "${USERNAME}" \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/


# Configure webassembly ...
COPY custom-scripts/webassembly/* /tmp/library-scripts/
RUN /bin/bash /tmp/library-scripts/configure-wasm.sh "${USERNAME}" \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/

