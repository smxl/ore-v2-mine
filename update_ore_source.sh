#!/usr/bin/env bash
set -euo pipefail

# Define constants
ORE_BRANCH="hardhat/v2"
ORE_REPO="https://github.com/hardhatchad/ore.git"
ORE_CLI_REPO="https://github.com/hardhatchad/ore-cli.git"
DRILLX_REPO="https://github.com/hardhatchad/drillx.git"

# Define logging function
log() {
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] $1"
}

# Error handling function
handle_error() {
    log "Error: $1"
    exit 1
}

# Remove old files and directories
clean_up() {
    log "Starting cleanup of old files and directories..."
    rm -rf ~/ore* ~/drillx || handle_error "Cleanup failed"
    log "Cleanup completed."
}

# Clone new repositories
clone_repos() {
    log "Starting to clone repositories to home directory..."
    cd ~
    git clone -b "$ORE_BRANCH" --single-branch "$ORE_REPO" || handle_error "Failed to clone ore repository"
    git clone -b "$ORE_BRANCH" --single-branch "$ORE_CLI_REPO" || handle_error "Failed to clone ore-cli repository"
    git clone "$DRILLX_REPO" || handle_error "Failed to clone drillx repository"
    log "Repository cloning completed."
}

# Build ore-cli
build_ore_cli() {
    log "Starting to build ore-cli..."
    cd ~/ore-cli || handle_error "Unable to enter ore-cli directory"
    cargo build --release --features="gpu" || handle_error "Failed to build ore-cli"
    log "ore-cli build completed."
}

# Copy compiled file to /usr/local/bin
copy_to_bin() {
    log "Starting to copy ore to /usr/local/bin..."
    sudo cp ~/ore-cli/target/release/ore /usr/local/bin/ore || handle_error "Failed to copy ore"
    log "Copying ore completed."
}

# Main function
main() {
    clean_up
    clone_repos
    build_ore_cli
    copy_to_bin
    log "All operations completed successfully."
}

# Execute main function
main
