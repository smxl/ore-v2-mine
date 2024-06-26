#!/bin/bash

# Ensure the ore command is available
if ! command -v ore &> /dev/null; then
    echo "ore not found."
    exit 1
fi

# Configuration file
CONFIG_FILE="./config.txt"

# Check if the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "config.txt not found."
    exit 1
fi

# Initialize the RPC_URLs array
declare -a RPC_URLs=()

# Load configurations from config file
while IFS='=' read -r key value; do
    # Remove leading and trailing whitespace
    key=$(echo "$key" | xargs)
    value=$(echo "$value" | xargs)
    
    case "$key" in
        "DEFAULT_TIME") DEFAULT_TIME="$value" ;;
        "RPC_URL") RPC_URLs+=("$value") ;;
    esac
done < "$CONFIG_FILE"

# Ensure there is at least one RPC_URL
if [ ${#RPC_URLs[@]} -eq 0 ]; then
    echo "No RPC_URL found in config.txt."
    exit 1
fi

# Get a random URL from a list of URLs
get_random_rpc_url() {
    local urls=("$@")
    echo "${urls[RANDOM % ${#urls[@]}]}"
}

# Execute command and handle potential failures
execute_command() {
    local rpc_url="$1"
    local key="$2"
    local time="$3"
    local command="ore --rpc \"$rpc_url\" --keypair \"$key\" mine --buffer-time $time"

    while true; do
        echo "Starting the process with RPC: $rpc_url"
        if eval "$command"; then
            echo "Process completed."
            break
        else
            echo "Process exited with error $?; retrying in 5 seconds..."
            sleep 5
        fi
    done
}

# Assign arguments with defaults or configurations
RPC_URL=${1:-$(get_random_rpc_url "${RPC_URLs[@]}")}
KEY=${2:-$HOME/.config/solana/id.json}
TIME=${3:-$DEFAULT_TIME}

# Execute the main function
execute_command "$RPC_URL" "$KEY" "$TIME"
