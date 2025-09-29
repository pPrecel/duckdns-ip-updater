FROM alpine:3.22

LABEL org.opencontainers.image.source="https://github.com/pPrecel/duckdns-ip-updater"
LABEL org.opencontainers.image.description="DuckDNS IP Updater"
LABEL org.opencontainers.image.author="Filip Strózik <filip.strozik@outlook.com>"
LABEL org.opencontainers.image.url="https://github.com/pPrecel/duckdns-ip-updater/blob/main/README.md"
LABEL org.opencontainers.image.licenses=MIT

RUN apk add --no-cache curl bind-tools

COPY updater.sh /app/updater.sh

ENTRYPOINT ["/app/updater.sh"]