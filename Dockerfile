FROM debian:12
RUN \
    image_syncer_version="v1.5.5" && \
    apt update && \
    apt upgrade -y && \
    apt install -y curl ca-certificates && \
    case $(uname -m) in \
    x86_64|amd64) \
      filename="image-syncer-${image_syncer_version}-linux-amd64.tar.gz" ;; \
    aarch64|arm64) \
      filename="image-syncer-${image_syncer_version}-linux-arm64.tar.gz" ;; \
    *) \
      echo "unsupported platform: $(uname -m)" && exit 1 ;; \
    esac && \
    curl \
      "https://github.com/AliyunContainerService/image-syncer/releases/download/${image_syncer_version}/${filename}" \
      -fsSL \
      -o "${filename}" && \
    tar -zxvf "${filename}" && \
    rm -rf    "${filename}" && \
    mv image-syncer /usr/bin/image-syncer && \
    chmod +x        /usr/bin/image-syncer && \
    rm -fv LICENSE && \
    rm -fv README.md
