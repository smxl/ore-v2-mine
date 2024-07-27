#!/usr/bin/env bash
set -euo pipefail

# Configuration
CONFIG_FILE="./config.txt"
DEFAULT_KEY="$HOME/.config/solana/id.json"

# Function to log messages
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Function to trim whitespace
trim() {
    local var="$*"
    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]]*}"}"
    # remove trailing whitespace characters
    var="${var%"${var##*[![:space:]]}"}"   
    printf '%s' "$var"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to get a random URL from a list
get_random_rpc_url() {
    if command_exists shuf; then
        shuf -n1 -e "$@"
    else
        # Fallback to bash's $RANDOM if shuf is not available
        local urls=("$@")
        echo "${urls[RANDOM % ${#urls[@]}]}"
    fi
}

# Function to execute command and handle failures
execute_command() {
    local rpc_url="$1" key="$2" time="$3"
    local command=(ore --rpc "$rpc_url" --keypair "$key" mine --buffer-time "$time")
    
    while true; do
        log "Starting the process with RPC: $rpc_url"
        if "${command[@]}"; then
            log "Process completed."
            break
        else
            log "Process exited with error $?; retrying in 5 seconds..."
            sleep 5
        fi
    done
}

# Check for ore command
command_exists ore || { log "ore not found."; exit 1; }

# Check for config file
[[ -f "$CONFIG_FILE" ]] || { log "config.txt not found."; exit 1; }

# Load configurations
declare -A config
while IFS='=' read -r key value; do
    key=$(trim "$key")
    value=$(trim "$value")
    [[ -n "$key" && -n "$value" ]] && config["$key"]="$value"
done < "$CONFIG_FILE"

# Validate configurations
[[ -v "config[DEFAULT_TIME]" ]] || { log "DEFAULT_TIME not found in config."; exit 1; }
[[ "${#config[@]}" -gt 1 ]] || { log "No RPC_URL found in config."; exit 1; }

# Prepare RPC URLs
RPC_URLs=()
for key in "${!config[@]}"; do
    [[ "$key" == RPC_URL ]] && RPC_URLs+=("${config[$key]}")
done
[[ ${#RPC_URLs[@]} -gt 0 ]] || { log "No RPC_URL found in config."; exit 1; }

# Parse command line arguments
RPC_URL=${1:-$(get_random_rpc_url "${RPC_URLs[@]}")}
KEY=${2:-$DEFAULT_KEY}
TIME=${3:-${config[DEFAULT_TIME]}}

# Execute the main function
execute_command "$RPC_URL" "$KEY" "$TIME"
