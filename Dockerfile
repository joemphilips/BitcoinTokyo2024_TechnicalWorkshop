FROM ubuntu:24.04

WORKDIR /apps/home

ENV adoptium_gpg_fingerprint=3B04D753C9050D9A5D343F39843C48A565F8F04B
ENV GIT_TAG="1.9.1"

RUN apt update -y && \
  apt upgrade -y && \
  apt install -y \
  wget \
  curl \
  apt-transport-https \
  gnupg \
  zip \
  unzip

# --- 1. install specific version of java from Adoptium deb repo ---
# check and import gpg key for Adoptium
# RUN curl \
#  --tlsv1.2 \
#  --proto =https \
#  --location \
#  -o adoptium.asc \
#   https://packages.adoptium.net/artifactory/api/gpg/key/public
# RUN [ $(gpg --import --import-options show-only adoptium.asc | grep ${adoptium_gpg_fingerprint}) ]
# RUN cp adoptium.asc /usr/share/keyrings/
# RUN echo "deb [signed-by=/usr/share/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" |  tee /etc/apt/sources.list.d/adoptium.list
# add adoptium debian repo
# RUN apt update -y && RUN apt install -y temurin-18-jdk=18.0.1+10
# RUN update-alternatives --config java
# --- ---

# --- Or if you want to use sdk man... ---
# install sdkman for jdk version management.
ENV SDKMAN_DIR=/root/.sdkman
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN curl -s "https://get.sdkman.io" | bash
RUN export SDKMAN_DIR="$HOME/.sdkman"
RUN chmod a+x "$SDKMAN_DIR/bin/sdkman-init.sh"
WORKDIR $SDKMAN_DIR
RUN [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh" && exec "$@"

RUN source "${SDKMAN_DIR}/bin/sdkman-init.sh"

RUN source ${SDKMAN_DIR}/bin/sdkman-init.sh && sdk install java 18.0.1-tem

WORKDIR /apps/home
# --- ---

# other necessary packages for building a sparrow
RUN apt install -y rpm fakeroot binutils git

# --- 2. build sparrow ---
RUN git clone --recursive --depth 1 --branch "${GIT_TAG}" https://github.com/sparrowwallet/sparrow.git
RUN cd sparrow && ./gradlew jpackage

COPY ./build/jpackage ./jpackage

# --- 3. check the binary matches to the one released ---

