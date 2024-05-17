这里是一个 GPT 优化教程帮助你在 DEVNET 上安装和配置 ORE V2

[View in English](https://github.com/smxl/ore-v2-mine/blob/main/README.md)

---

## ORE V2 Mine on DEVNET

### 系统和环境

#### 安装 Debian（可选）

1. 安装 Debian:
    ```sh
    wsl --install debian
    ```

2. 设置 Debian 为默认 WSL:
    ```sh
    wsl --setdefault Debian
    ```

3. 进入系统:
    ```sh
    wsl
    ```

#### 安装依赖

```sh
sudo apt install -y curl wget git build-essential software-properties-common
```

#### 安装 Rust

```sh
curl https://sh.rustup.rs -sSf | sh
```

#### 安装 Solana CLI（完成后重启终端）

```sh
sh -c "$(curl -sSfL https://release.solana.com/stable/install)"
```

#### 生成私钥（自定义开头地址可选）

1. 进入主目录:
    ```sh
    cd ~
    ```

2. 生成自定义开头地址的私钥:
    ```sh
    solana-keygen grind --starts-and-ends-with 自定义::1 --ignore-case >> seed.txt
    ```

3. 复制私钥到默认路径:
    ```sh
    cp ~/*.json $HOME/.config/solana/id.json
    ```

#### 领取测试网 Gas

```sh
solana config set --url d
solana airdrop 1
```

### 克隆 ORE V2 分支

1. 克隆 ORE 仓库:
    ```sh
    cd ~
    git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore
    ```

2. 克隆 ORE-CLI 仓库:
    ```sh
    git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore-cli
    ```

3. 克隆 DrillX 仓库:
    ```sh
    git clone https://github.com/hardhatchad/drillx
    ```

### ~~配置 CUDA & NVCC~~

1. 下载并安装 CUDA 密钥环:
    ```sh
    wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
    sudo dpkg -i cuda-keyring_1.1-1_all.deb
    ```

2. 添加贡献软件库并更新:
    ```sh
    sudo add-apt-repository contrib
    sudo apt-get update
    ```

3. 安装 CUDA 工具包和驱动:
    ```sh
    sudo apt-get -y install cuda-toolkit-12-4 nvidia-kernel-open-dkms cuda-drivers
    ```

#### ~~修复 NVCC 问题~~

1. 添加 CUDA 环境变量:
    ```sh
    echo -e "\nexport CUDA_HOME=/usr/local/cuda\nexport LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64\nexport PATH=\$PATH:\$CUDA_HOME/bin" >> ~/.bashrc
    ```

### 编译

1. 进入 ORE-CLI 目录:
    ```sh
    cd ~/ore-cli
    ```

2. ~~使用 GPU 编译:~~
    ```sh
    cargo build --release --features="gpu"
    sudo cp ~/ore-cli/target/release/ore /usr/local/bin/ore
    ```

3. 使用 CPU 编译:
    ```sh
    cargo build --release
    sudo cp ~/ore-cli/target/release/ore /usr/local/bin/ore
    ```

### 挖矿

   ~~For GPU:~~

   ```bash
   ore --rpc https://api.devnet.solana.com --keypair ~/.config/solana/id.json mine --buffer-time 2
   ```

   For CPU:

   ```bash
   ore --rpc https://api.devnet.solana.com --keypair ~/.config/solana/id.json mine --buffer-time 2 --threads 12
   ```

### ORE 更新

1. 删除旧版本:
    ```sh
    cd ~
    rm -rf ~/ore* && rm -rf ~/drillx
    ```

2. 克隆新版本:
    ```sh
    git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore
    git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore-cli
    git clone https://github.com/hardhatchad/drillx
    ```

3. 编译新版本:
    ```sh
    cd ~/ore-cli
    cargo build --release
    sudo cp ~/ore-cli/target/release/ore /usr/local/bin/ore
    ```

### ORE 卸载

```sh
sudo rm /usr/local/bin/ore
```

### Windows 屏幕关闭

```sh
(Add-Type '[DllImport("user32.dll")]public static extern int SendMessage(int hWnd, int hMsg, int wParam, int lParam);' -Name a -Pas)::SendMessage(-1,0x0112,0xF170,2)
```
