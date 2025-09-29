# DuckDNS IP Updater

The `DuckDNS IP Updater` is a small image that allows support the duckdns.org DDNS by updating the domain IP on public IP change.

## How to use it?

It's simple, run following command:

```bash
docker run -d --restart always \
  --env DOMAIN="<DOMAIN>" \
  --env TOKEN="<TOKEN>" \
  ghcr.io/pprecel/duckdns-ip-updater/duckdns-ip-updater:latest
```
