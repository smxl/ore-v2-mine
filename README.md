ORE V2 Mine on DEVNET

### 系统和环境

安装 Debian, 可选

`wsl --install debian`

设置 Debian 为默认 WSL

`wsl --setdefault Debian`

进入系统

`wsl`

Debian 安装依赖

`sudo apt install -y curl wget git build-essential software-properties-common`

安装 Rust 环境

`curl https://sh.rustup.rs -sSf | sh`

安装 Solana CLI, 完成后要重启终端

`sh -c "$(curl -sSfL https://release.solana.com/stable/install)"`

生成自定义开头地址的私钥, 自定义可选

`cd ~`

`solana-keygen grind -starts-and-ends-with 自定义::1 -ignore-case >> seed.txt`

复制私钥到默认路径

`cp ~/*.json $HOME/.config/solana/id.json`

领取测试网 gas

`solana config set --url d && solana airdrop 1`

克隆 ORE V2 分支

`cd ~`

`git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore`

`git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore-cli`

`git clone https://github.com/hardhatchad/drillx`

环境配置 CUDA & NVCC Install

根据系统安装 CUDA

https://developer.nvidia.com/cuda-downloads

Debian 参考

`wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb && sudo dpkg -i cuda-keyring_1.1-1_all.deb`

`sudo add-apt-repository contrib && sudo apt-get update`

`sudo apt-get -y install cuda-toolkit-12-4 nvidia-kernel-open-dkms cuda-drivers`

修复 NVCC 问题

https://askubuntu.com/questions/885610/nvcc-version-command-says-nvcc-is-not-installed

`echo -e "\nexport CUDA_HOME=/usr/local/cuda\nexport LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64\nexport PATH=\$PATH:\$CUDA_HOME/bin" >> ~/.bashrc`

#### 编译

`cd ~/ore-cli`

GPU 版本

`cargo build --release --features="gpu"`

`sudo cp ~/ore-cli/target/release/ore /usr/local/bin/ore`

CPU 版本

`cargo build --release && sudo cp ~/ore-cli/target/release/ore /usr/local/bin/orec`

ORE V2 GPU 挖矿

`ore --rpc https://api.devnet.solana.com --keypair ~/.config/solana/id.json mine --buffer-time 2`

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
