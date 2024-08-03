#!/usr/bin/env bash
set -euo pipefail

# Configuration
DEFAULT_TIME=2
RPC_URL=("https://api.mainnet-beta.solana.com" "")
DEFAULT_KEY="$HOME/.config/solana/id.json"

# Function to log messages
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Function to trim whitespace
trim() {
    local var="$*"
    var="${var#"${var%%[![:space:]]*}"}"
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
        log "Executing command: ${command[*]}"
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

# Remove empty RPC URLs
RPC_URLs=()
for url in "${RPC_URL[@]}"; do
    [[ -n "$url" ]] && RPC_URLs+=("$url")
done
[[ ${#RPC_URLs[@]} -gt 0 ]] || { log "No valid RPC_URL found in config."; exit 1; }

# Parse command line arguments
RPC_URL=${1:-$(get_random_rpc_url "${RPC_URLs[@]}")}
KEY=${2:-$DEFAULT_KEY}
TIME=${3:-$DEFAULT_TIME}

# Execute the main function
execute_command "$RPC_URL" "$KEY" "$TIME"
