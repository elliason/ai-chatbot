#!/bin/bash

# Script to check if an internal network exists and remove it if found
# Usage: ./remove-internal-net.sh [network_name]

set -e

# Default network name if not provided
NETWORK_NAME=${1:-"internal-net"}

echo "Checking if network '$NETWORK_NAME' exists..."

# Check if the network exists
if docker network inspect "$NETWORK_NAME" &> /dev/null; then
    echo "Network '$NETWORK_NAME' found. Removing..."
    docker network rm "$NETWORK_NAME"
    echo "Network '$NETWORK_NAME' removed successfully."
else
    echo "Network '$NETWORK_NAME' does not exist. Nothing to remove."
fi

echo "Done." 