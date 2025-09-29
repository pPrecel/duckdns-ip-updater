#!/bin/sh
## Script to periodically check and update DNS record with current public IP
## Based on: https://gist.github.com/taichikuji/6f4183c0af1f4a29e345b60910666468

# Require envs
DOMAIN=${DOMAIN?"Domain not set"}
TOKEN=${TOKEN?"Token not set"}

# Optional envs
INTERVAL=${DELAY:-60} # Delay in seconds between checks, default 60 seconds

# Initial public IP fetch
PUBLIC_IP=$(dig +short $DOMAIN.duckdns.org)

echo $(date +"%Y-%m-%d %H:%M:%S") "- Starting DuckDNS updater for domain: $DOMAIN.duckdns.org"
echo $(date +"%Y-%m-%d %H:%M:%S") "- Update interval: $INTERVAL seconds"
echo $(date +"%Y-%m-%d %H:%M:%S") "- Current IP: $PUBLIC_IP"

while true; do
    ACTUAL_IP=$(curl -s https://api.ipify.org)
    if [ "$ACTUAL_IP" != "$PUBLIC_IP" ]; then
        echo $(date +"%Y-%m-%d %H:%M:%S") "- IP changed from $PUBLIC_IP to $ACTUAL_IP. Updating DNS..."
        echo $(date +"%Y-%m-%d %H:%M:%S") "- Response:" $(curl -s "https://www.duckdns.org/update?domains=$DOMAIN&token=$TOKEN&ip=$ACTUAL_IP")
        PUBLIC_IP=$ACTUAL_IP
    fi

    sleep $INTERVAL
done
