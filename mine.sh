#!/bin/bash

# Ensure the 'ore' command is available
if ! command -v ore &> /dev/null; then
    echo "The 'ore' command is not available. Please install it before running this script."
    exit 1
fi

# Configuration file
CONFIG_FILE="./config.txt"

# Check if the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file not found!"
    exit 1
fi

# Initialize the RPC_URLs array
declare -a RPC_URLs=()

# Load configurations from config file
while IFS='=' read -r key value; do
    case "$key" in
        "DEFAULT_TIME") DEFAULT_TIME="$value" ;;
        "DEFAULT_THREADS") DEFAULT_THREADS="$value" ;;
        "RPC_URL") RPC_URLs+=("$value") ;;
    esac
done < "$CONFIG_FILE"

# Get a random URL from a list of URLs
get_random_rpc_url() {
  local urls=("$@")
  echo "${urls[$RANDOM % ${#urls[@]}]}"
}

# Execute command and handle potential failures
execute_command() {
  local rpc_url="$1"
  local key="$2"
  local time="$3"
  local threads="$4"
  local command="ore --rpc \"$rpc_url\" --keypair \"$key\" mine --threads $threads --buffer-time $time"

  while true; do
    echo "Starting the process with RPC: $rpc_url"
    if eval "$command"; then
      echo "Process completed."
      break
    else
      echo "Process exited with error code $?; retrying in 5 seconds..."
      sleep 5
    fi
  done
}

# Assign arguments with defaults or configurations
RPC_URL=${1:-$(get_random_rpc_url "${RPC_URLs[@]}")}
KEY=${2:-$HOME/.config/solana/id.json}
TIME=${3:-$DEFAULT_TIME}
THREADS=${4:-$DEFAULT_THREADS}

# Execute the main function
execute_command "$RPC_URL" "$KEY" "$TIME" "$THREADS"
