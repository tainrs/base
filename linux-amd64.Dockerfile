# This Dockerfile is used to build a custom container with specific tools and configurations.
# The container is based on an upstream image and includes additional tools such as `unrar`
# and the `s6-overlay` for process management. The container is configured with environment
# variables and user settings to support a specific application requiring these configurations
# and tools.

# Step 1: Define arguments for upstream image and digest
ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_AMD64

# Step 2: Use Ubuntu as the base image for the builder stage
FROM ubuntu AS builder
ARG UNRAR_VER=7.0.9

# Step 3: Add and extract the unrar source code
ADD https://www.rarlab.com/rar/unrarsrc-${UNRAR_VER}.tar.gz /tmp/unrar.tar.gz
RUN set -e ;\
    apt update ;\
    apt install -y --no-install-recommends --no-install-suggests build-essential ;\
    tar -xzf /tmp/unrar.tar.gz ;\
    cd unrar ;\
    sed -i 's|LDFLAGS=-pthread|LDFLAGS=-pthread -static|' makefile ;\
    sed -i 's|CXXFLAGS=-march=native |CXXFLAGS=|' makefile ;\
    make -f makefile ;\
    install -Dm 750 unrar /usr/bin/unrar

# Step 4: Use the specified upstream image for the final stage
FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_AMD64}

# Step 5: Define various ARGs and ENV variables
ARG TZ=Etc/UTC
ARG USERNAME=tainrs
ARG CONFIG_DIR=/config
ARG UID
ARG GID
ARG IMAGE_STATS
ARG BUILD_ARCHITECTURE
ENV IMAGE_STATS=${IMAGE_STATS} BUILD_ARCHITECTURE=${BUILD_ARCHITECTURE} \
    APP_DIR="/app" CONFIG_DIR="${CONFIG_DIR}" USERNAME="${USERNAME}" PUID="${UID:-1000}" PGID="${GID:-1000}" UMASK="002" TZ="${TZ}" \
    XDG_CONFIG_HOME="${CONFIG_DIR}/.config" XDG_CACHE_HOME="${CONFIG_DIR}/.cache" XDG_DATA_HOME="${CONFIG_DIR}/.local/share" \
    LANG="en_US.UTF-8" LANGUAGE="en_US:en" LC_ALL="en_US.UTF-8" \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0 S6_SERVICES_GRACETIME=180000 S6_STAGE2_HOOK="/etc/s6-overlay/init-hook" \
    UNBOUND_ENABLED="false" TAILSCALE_ENABLED="false"

# Step 6: Define a volume for the configuration directory
VOLUME ["${CONFIG_DIR}"]

# Step 7: Define the entrypoint
ENTRYPOINT ["/init"]

# Step 8: Set the DEBIAN_FRONTEND variable to noninteractive to avoid interactive prompts during package installation
ARG DEBIAN_FRONTEND="noninteractive"

# Step 9: Install required packages
RUN set -e ;\
    mkdir -p /usr/share/figlet ;\
    apt update ;\
    apt install -y --no-install-recommends --no-install-suggests \
        ca-certificates curl dos2unix figlet jq locales python3 tzdata unzip wget xz-utils unbound ;\
# Generate the locale for en_US.UTF-8
    locale-gen en_US.UTF-8 ;\
# Clean up unnecessary files
    apt autoremove -y ;\
    apt clean ;\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* ;\
    curl -fsSL "https://raw.githubusercontent.com/xero/figlet-fonts/master/Cyberlarge.flf" -o /usr/share/figlet/Cyberlarge.flf

# Step 10: Copy the unrar binary from the builder stage
COPY --from=builder /usr/bin/unrar /usr/bin/unrar

# Step 11: Download and extract s6-overlay
ARG VERSION_S6
RUN set -e ;\
    curl -fsSL "https://github.com/just-containers/s6-overlay/releases/download/v${VERSION_S6}/s6-overlay-noarch.tar.xz" | tar Jpxf - -C / ;\
    curl -fsSL "https://github.com/just-containers/s6-overlay/releases/download/v${VERSION_S6}/s6-overlay-x86_64.tar.xz" | tar Jpxf - -C / ;\
    curl -fsSL "https://github.com/just-containers/s6-overlay/releases/download/v${VERSION_S6}/s6-overlay-symlinks-noarch.tar.xz" | tar Jpxf - -C / ;\
    curl -fsSL "https://github.com/just-containers/s6-overlay/releases/download/v${VERSION_S6}/s6-overlay-symlinks-arch.tar.xz" | tar Jpxf - -C /

# Step 12: Create necessary directories and set up the user
RUN set -e ;\
    useradd -o -u ${PUID} -U -d ${CONFIG_DIR} -s /bin/false ${USERNAME} ;\
    usermod -G users ${USERNAME} ;\
    mkdir "${APP_DIR}" ;\
    mkdir "${CONFIG_DIR}" ;\
    chown -R ${USERNAME}:${USERNAME} ${CONFIG_DIR} ${APP_DIR} ;\
    chmod 750 ${CONFIG_DIR} ${APP_DIR}

# Step 13: Copy root files and set execute permissions for the init-hook script
COPY root/ /

# Step 14: Fix ownership and permissions for other necessary directories and files
RUN set -e ;\
    chmod +x /etc/s6-overlay/init-hook ;\
    chown -R ${USERNAME}:${USERNAME} /etc/s6-overlay ;\
    # The '+' sign ensures that the command is run only once with all the files as arguments
    find /etc/s6-overlay -type f -name "run*" -execdir chmod +x {} +
