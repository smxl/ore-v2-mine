#!/bin/bash

# 定义日志函数
log() {
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] $1"
}

# 删除旧的文件和目录
clean_up() {
    log "开始清理旧的文件和目录..."
    rm -rf ~/ore* && rm -rf ~/drillx
    log "清理完成。"
}

# 克隆新的仓库
clone_repos() {
    log "开始克隆仓库到主目录..."
    cd ~
    git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore
    if [ $? -ne 0 ]; then
        log "克隆 ore 仓库失败。"
        exit 1
    fi

    git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore-cli
    if [ $? -ne 0 ]; then
        log "克隆 ore-cli 仓库失败。"
        exit 1
    fi

    git clone https://github.com/hardhatchad/drillx
    if [ $? -ne 0 ]; then
        log "克隆 drillx 仓库失败。"
        exit 1
    fi
    log "克隆仓库完成。"
}

# 编译 ore-cli
build_ore_cli() {
    log "开始编译 ore-cli..."
    cd ~/ore-cli
    cargo build --release --features="gpu"
    if [ $? -ne 0 ]; then
        log "编译 ore-cli 失败。"
        exit 1
    fi
    log "编译 ore-cli 完成。"
}

# 复制编译好的文件到 /usr/local/bin
copy_to_bin() {
    log "开始复制 ore 到 /usr/local/bin..."
    sudo cp ~/ore-cli/target/release/ore /usr/local/bin/ore
    if [ $? -ne 0 ]; then
        log "复制 ore 失败。"
        exit 1
    fi
    log "复制 ore 完成。"
}

# 主函数
main() {
    clean_up
    clone_repos
    build_ore_cli
    copy_to_bin
    log "所有操作完成。"
}

# 执行主函数
main
