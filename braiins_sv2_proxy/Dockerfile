FROM debian:bookworm-slim

# Pinned release and SHA-256 checksums, as published at https://downloads.braiins.com/braiins-proxy/
# Use scripts/bump-braiins.sh to update these three lines.
ARG BRAIINS_VERSION=0.1.1
ARG SHA256_AARCH64=717b8c8bdd0174643b2be884e96758870b8e5887c03d2d1ba4592e00914303d8
ARG SHA256_X86_64=5ecf9b3476a622c5983c4c3a4bfe4686002e30b6bb27a5377fd9a956da4124b0

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl jq util-linux nginx openssl iproute2 \
 && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    case "$(uname -m)" in \
      aarch64) F=braiins-proxy-linux-aarch64.tar.gz; S="$SHA256_AARCH64" ;; \
      x86_64)  F=braiins-proxy-linux-x86_64.tar.gz;  S="$SHA256_X86_64" ;; \
      *) echo "unsupported architecture: $(uname -m)"; exit 1 ;; \
    esac; \
    curl -fsSL -o /tmp/proxy.tgz "https://downloads.braiins.com/braiins-proxy/assets/${BRAIINS_VERSION}/${F}" ; \
    echo "${S}  /tmp/proxy.tgz" | sha256sum -c -; \
    mkdir /tmp/proxy; tar -xzf /tmp/proxy.tgz -C /tmp/proxy; \
    install -m 0755 "$(find /tmp/proxy -type f -name braiins-proxy | head -n1)" /usr/local/bin/braiins-proxy; \
    rm -rf /tmp/proxy /tmp/proxy.tgz

# The proxy runs as an unprivileged user ("proxy" already exists in Debian, hence "braiins").
RUN useradd --system --home-dir /data/home --shell /usr/sbin/nologin braiins

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
