#!/bin/bash

# The Discord Webhook URL
WEBHOOK_URL=$(pass apps/discord/webhook/homelab)

# The message you want to send
PC_NAME=$(hostname)
MESSAGE="🖥️ **$PC_NAME** has successfully booted up!"

# Send the POST request to Discord
curl -H "Content-Type: application/json" \
     -X POST \
     -d "{\"content\": \"$MESSAGE\"}" \
     $WEBHOOK_URL
