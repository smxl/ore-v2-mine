# ORE V2 Mine on DEVNET

## 系统和环境

安装 Debian, 可选, 其他 WSL 系统也可

`wsl —install —distribution debian`

`wsl —install debian`

设置 Debian 为默认 WSL

`wsl —setdefault Debian`

进入系统

`wsl`

Debian ENV

安装依赖

`sudo apt install -y curl git build-essential wget software-properties-common`

安装 Rust 环境

`curl —proto '=https' —tlsv1.2 -sSf https://sh.rustup.rs | sh`

安装 Solana CLI

`sh -c "$(curl -sSfL https://release.solana.com/v1.18.12/install)"`

生成自定义开头地址的私钥, 自定义可选

`solana-keygen grind —starts-and-ends-with 自定义::1 —ignore-case >> seed.txt`

复制私钥到默认路径

`cp *.json $HOME/.config/solana/id.json`

领取测试网 gas

`solana config set --url d`

`solana airdrop 1`

### ORE V2 准备

切换路径

`cd ~`

克隆 ORE V2 代码

`git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore`

`git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore-cli`

`git clone https://github.com/hardhatchad/drillx`

#### CUDA & NVCC Install

根据系统安装 CUDA

https://developer.nvidia.com/cuda-downloads

修复 NVCC 问题

https://askubuntu.com/questions/885610/nvcc-version-command-says-nvcc-is-not-installed

~~`curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list && sudo apt-get update`~~

~~`sudo apt-get install -y nvidia-container-toolkit`~~

~~`sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml`~~

~~`nvidia-ctk cdi list`~~

~~`nvidia-smi`~~

#### 编译

`cd ~/ore-cli`

GPU 版本 (建议顺便编译 CPU 版本)

`cargo build --release --features="gpu"`

`sudo cp ~/ore-cli/target/release/ore /usr/local/bin/ore`

CPU 版本 (可选, 已编译完 GPU 版本时只要几秒)

`sudo cp ~/ore-cli/target/release/ore /usr/local/bin/orec`

### ORE V2 Mine

根据 CPU 逻辑处理器数量调整线程数, 可适当降低保留性能

`orec --rpc https://rpc.ankr.com/solana_devnet --keypair ~/.config/solana/id.json mine --buffer-time 2 --threads 16`

GPU 挖矿 ~~根据 GPU 时钟频率 * 1000 调整下面的数值, 可适当降低保留性能~~ --clockrate 参数已丢弃

`ore --rpc https://api.devnet.solana.com --keypair ~/.config/solana/id.json mine --buffer-time 2`

3. Bash 复制本项目 mine.sh 和 config.txt 后执行

`bash mine.sh`

#### ORE Update

`cd ~`

`rm -rf ~/ore* && rm -rf ~/drillx`

`git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore`

`git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore-cli`

`git clone https://github.com/hardhatchad/drillx`

`cd ~/ore-cli`

`cargo build --release --features="gpu"`

`sudo cp ~/ore-cli/target/release/ore /usr/local/bin/ore`

#### ORE Uninstall

`sudo rm /usr/local/bin/ore`

#### Windows Screen Off

`(Add-Type '[DllImport("user32.dll")]public static extern int SendMessage(int hWnd, int hMsg, int wParam, int lParam);' -Name a -Pas)::SendMessage(-1,0x0112,0xF170,2)`
