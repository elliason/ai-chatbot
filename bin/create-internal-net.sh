#!/bin/bash

# Script to check if an internal network exists and create it if not found
# Usage: ./create-internal-net.sh [network_name]

set -e

# Default network name if not provided
NETWORK_NAME=${1:-"internal-net"}

echo "Checking if network '$NETWORK_NAME' exists..."

# Check if the network exists
if docker network inspect "$NETWORK_NAME" &> /dev/null; then
    echo "Network '$NETWORK_NAME' already exists."
else
    echo "Network '$NETWORK_NAME' not found. Creating..."
    docker network create "$NETWORK_NAME"
    echo "Network '$NETWORK_NAME' created successfully."
fi

echo "Done."
