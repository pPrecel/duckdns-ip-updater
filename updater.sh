#!/bin/bash
## Script to periodically check and update DNS record with current public IP
## Based on: https://gist.github.com/taichikuji/6f4183c0af1f4a29e345b60910666468

# Require envs
DOMAIN=${DOMAIN?"Domain not set"}
TOKEN=${TOKEN?"Token not set"}

# Optional envs
INTERVAL=${DELAY:-60} # Delay in seconds before starting the update


PUBLIC_IP="00.00.00.00" # Initial dummy value

while true; do
    ACTUAL_IP=$(curl -s https://api.ipify.org)
    if [ "$ACTUAL_IP" != "$PUBLIC_IP" ]; then
        echo $(date +"%Y-%m-%d %H:%M:%S") "- IP changed from $PUBLIC_IP to $ACTUAL_IP. Updating DNS..."
        curl "https://www.duckdns.org/update?domains=$DOMAIN&token=$TOKEN&ip=$ACTUAL_IP" &1>/dev/null
        PUBLIC_IP=$ACTUAL_IP
    fi

    sleep $INTERVAL
done
