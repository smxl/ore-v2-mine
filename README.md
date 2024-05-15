ORE V2 Mine on DEVNET

[CN](https://github.com/smxl/ore-v2-mine/blob/main/README_CN.md)

### Perpare

Install Debian, optional

`wsl --install debian`

Set Debian as Default

`wsl --setdefault Debian`

Enter WSL

`wsl`

Install dependencies

`sudo apt install -y curl wget git build-essential software-properties-common`

Install Rust

`curl https://sh.rustup.rs -sSf | sh`

Install Solana CLI, restart the terminal when finished

`sh -c "$(curl -sSfL https://release.solana.com/stable/install)"`

Generate private key with vanity address, customize is optional

`cd ~`

`solana-keygen grind -starts-and-ends-with YOUR::1 -ignore-case >> seed.txt`

Copy the private key to the default path

`cp ~/*.json $HOME/.config/solana/id.json`

Getting Dev Net Gas

`solana config set --url d && solana airdrop 1`

Cloning the ORE V2 branch

`cd ~`

`git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore`

`git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore-cli`

`git clone https://github.com/hardhatchad/drillx`

Configuring CUDA & NVCC, Depending your system

https://developer.nvidia.com/cuda-downloads

Debian Reference

`wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb && sudo dpkg -i cuda-keyring_1.1-1_all.deb`

`sudo add-apt-repository contrib && sudo apt-get update`

`sudo apt-get -y install cuda-toolkit-12-4 nvidia-kernel-open-dkms cuda-drivers`

Fixing NVCC Issues

https://askubuntu.com/questions/885610/nvcc-version-command-says-nvcc-is-not-installed

`echo -e "\nexport CUDA_HOME=/usr/local/cuda\nexport LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64\nexport PATH=\$PATH:\$CUDA_HOME/bin" >> ~/.bashrc`

#### Compile

`cd ~/ore-cli`

GPU

`cargo build --release --features="gpu"`

`sudo cp ~/ore-cli/target/release/ore /usr/local/bin/ore`

CPU

`cargo build --release && sudo cp ~/ore-cli/target/release/ore /usr/local/bin/orec`

Mine

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
