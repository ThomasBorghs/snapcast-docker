FROM debian:buster-slim
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl  \
    bash  \
    npm \
    gnupg && \
    rm -rf /var/lib/apt/lists/* \

WORKDIR /snapcast

RUN curl -L https://github.com/badaix/snapcast/releases/download/v0.26.0/snapserver_0.26.0-1_amd64.deb
RUN dpkg -i snapserver_0.26.0-1_amd64.deb
sudo apt-get -f install

RUN npm install --silent --save-dev -g typescript@4.3
RUN curl -L https://github.com/badaix/snapweb/archive/refs/tags/v0.3.0.tar.gz | tar xz --directory / && cd /snapweb-0.3.0 && make

COPY --from=builder /snapweb-0.3.0/dist /usr/share/snapserver/snapweb
EXPOSE 1704 1705 1780
ENTRYPOINT snapserver $EXTRA_ARGS