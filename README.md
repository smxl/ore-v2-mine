# ORE V2 Mining on DEVNET

[View in Chinese (中文)](https://github.com/smxl/ore-v2-mine/blob/main/README_CN.md)

## Preparation

1. **Install Debian (optional)**

   ```bash
   wsl --install debian
   wsl --setdefault Debian
   wsl
   ```

2. **Install Dependencies**

   ```bash
   sudo apt install -y curl wget git build-essential software-properties-common
   ```

3. **Install Rust**

   ```bash
   curl https://sh.rustup.rs -sSf | sh
   ```

4. **Install Solana CLI**

   ```bash
   sh -c "$(curl -sSfL https://release.solana.com/stable/install)"
   ```

5. **Generate Private Key with Vanity Address**

   ```bash
   cd ~
   solana-keygen grind -starts-and-ends-with YOUR::1 -ignore-case >> seed.txt
   cp ~/*.json $HOME/.config/solana/id.json
   ```

6. **Get DEVNET Gas**

   ```bash
   solana config set --url d
   solana airdrop 1
   ```

7. **Clone Repositories**

   ```bash
   cd ~
   git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore
   git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore-cli
   git clone https://github.com/hardhatchad/drillx
   ```

8. **Configure CUDA & NVCC (if needed)**

   See [CUDA Downloads](https://developer.nvidia.com/cuda-downloads) for your system.

   ```bash
   wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb && sudo dpkg -i cuda-keyring_1.1-1_all.deb
   sudo add-apt-repository contrib && sudo apt-get update
   sudo apt-get -y install cuda-toolkit-12-4 nvidia-kernel-open-dkms cuda-drivers
   ```

9. **Fix NVCC Issues (if encountered)**

   See [NVCC Installation Issues](https://askubuntu.com/questions/885610/nvcc-version-command-says-nvcc-is-not-installed).

   ```bash
   echo -e "\nexport CUDA_HOME=/usr/local/cuda\nexport LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64\nexport PATH=\$PATH:\$CUDA_HOME/bin" >> ~/.bashrc
   ```

## Compilation

1. **Compile ore-cli**

   ```bash
   cd ~/ore-cli
   ```

   For GPU:

   ```bash
   cargo build --release --features="gpu"
   sudo cp ~/ore-cli/target/release/ore /usr/local/bin/ore
   ```

   For CPU:

   ```bash
   cargo build --release
   sudo cp ~/ore-cli/target/release/ore /usr/local/bin/orec
   ```

2. **Start Mining**

   ```bash
   ore --rpc https://api.devnet.solana.com --keypair ~/.config/solana/id.json mine --buffer-time 2
   ```

## ORE Update

```bash
cd ~
rm -rf ~/ore* && rm -rf ~/drillx
git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore
git clone -b hardhat/v2 --single-branch https://github.com/hardhatchad/ore-cli
git clone https://github.com/hardhatchad/drillx
cd ~/ore-cli
cargo build --release --features="gpu"
sudo cp ~/ore-cli/target/release/ore /usr/local/bin/ore
```

## ORE Uninstall

```bash
sudo rm /usr/local/bin/ore
```

## Windows Screen Off

To turn off the screen in Windows, you can use the following command in PowerShell:

```powershell
(Add-Type '[DllImport("user32.dll")]public static extern int SendMessage(int hWnd, int hMsg, int wParam, int lParam);' -Name a -Pas)::SendMessage(-1,0x0112,0xF170,2)
```
