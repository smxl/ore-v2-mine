# ORE v2 DEVNET

## WSL Install

安装 Debian

`wsl —install —distribution debian`

`wsl —install debian`

设置 Debian 为默认 WSL

`wsl —setdefault Debian`

进入系统

`wsl`

## Debian ENV

安装 curl 和 依赖

`sudo apt install curl`

`sudo apt install git`

`sudo apt install build-essential`

安装 Rust

`curl —proto '=https' —tlsv1.2 -sSf https://sh.rustup.rs | sh`

安装 Solana Cli

`sh -c "$(curl -sSfL https://release.solana.com/v1.18.12/install)"`

生成自定义开头地址的私钥

`solana-keygen grind —starts-and-ends-with PRE::1 —ignore-case >> seed.txt`

复制私钥到默认路径

`cp *.json $HOME/.config/solana/id.json`

### ORE V2 Install

切换路径

`cd ~`

克隆代码

`git clone https://github.com/hardhatchad/ore`

`git clone https://github.com/hardhatchad/ore-cli`

`git clone https://github.com/hardhatchad/drillx`

切换至 V2

`cd ore && git checkout hardhat/v2 && cd ..`

`cd ore-cli && git checkout hardhat/v2 && cd ..`

领取测试网 gas

`solana config set --url d`

`solana airdrop 1`

编译 ORE

`cd ore-cli`

`cargo build --release`

复制 ORE

`sudo cp ~/ore-cli/target/release/ore /usr/local/bin/ore`

### ORE V2 Mine

1. Cli

`ore --rpc https://api.devnet.solana.com --keypair ~/.config/solana/id.json mine --threads 16 --buffer-time 2`

2. Bash 复制本项目 mine.sh 和 config.txt 后执行

`bash mine.sh`

#### ORE V2 Usage

`ore -h`

#### ORE Uninstall

`rm /usr/local/bin/ore`

#### Windows Screen Off

`(Add-Type '[DllImport("user32.dll")]public static extern int SendMessage(int hWnd, int hMsg, int wParam, int lParam);' -Name a -Pas)::SendMessage(-1,0x0112,0xF170,2)`

#### CUDA Install

`curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list && sudo apt-get update`

`sudo nvidia-ctk runtime configure --runtime=docker`

`sudo systemctl restart docker`

`sudo apt-get install -y nvidia-container-toolkit`

`sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml`

`nvidia-ctk cdi list`