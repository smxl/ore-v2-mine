# ORE v2 DEVNET

## WSL Install

`wsl —install —distribution debian`
`wsl —install debian`
`wsl —setdefault Debian`
`wsl`

## Debian ENV

`sudo apt install curl`
`sudo apt install build-essential`
`curl —proto '=https' —tlsv1.2 -sSf https://sh.rustup.rs | sh`
`sh -c "$(curl -sSfL https://release.solana.com/v1.18.12/install)"`
`solana-keygen grind —starts-and-ends-with PRE:END:1 —ignore-case >> seed.txt`
`cp *.json $HOME/.config/solana/id.json`

### ORE V2 Install

`cd ~`
`git clone https://github.com/hardhatchad/ore`
`git clone https://github.com/hardhatchad/ore-cli`
`git clone https://github.com/hardhatchad/drillx`
`cd ore && git checkout hardhat/v2 && cd ..`
`cd ore-cli && git checkout hardhat/v2 && cd ..`
`solana config set --url d`
`solana airdrop 1`
`cd ore-cli`
`cargo build --release`
`sudo cp ~/ore-cli/target/release/ore /usr/local/bin/ore`

### ORE V2 Mine

1. Cli

`ore --rpc https://api.devnet.solana.com --keypair ~/.config/solana/id.json mine --threads 16 --buffer-time 2`

2. Bash

`bash mine.sh`

#### CUDA Install

`curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list && sudo apt-get update`
`sudo nvidia-ctk runtime configure --runtime=docker`
`sudo systemctl restart docker`
`sudo apt-get install -y nvidia-container-toolkit`
`sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml`
`nvidia-ctk cdi list`

#### ORE V2 Usage

`ore -h`

#### ORE Uninstall

`rm /usr/local/bin/ore`

#### Windows Screen Off

`(Add-Type '[DllImport("user32.dll")]public static extern int SendMessage(int hWnd, int hMsg, int wParam, int lParam);' -Name a -Pas)::SendMessage(-1,0x0112,0xF170,2)`
