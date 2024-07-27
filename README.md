# ORE V2 Mining on DEVNET

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
   solana-keygen grind --starts-and-ends-with YOUR::1 --ignore-case >> seed.txt
   cp ~/*.json $HOME/.config/solana/id.json
   ```

6. **Get DEVNET Gas**

   ```bash
   solana config set --url d
   solana airdrop 1
   ```

7. **Install**

   ```bash
   cargo install ore-cli@1.0.0-alpha.4
   ```

8. **Start Mining**
   ```bash
   ore --rpc https://api.devnet.solana.com --keypair ~/.config/solana/id.json mine --buffer-time 2
   ```

###### Windows Screen Off

To turn off the screen in Windows, you can use the following command in PowerShell:

```powershell
(Add-Type '[DllImport("user32.dll")]public static extern int SendMessage(int hWnd, int hMsg, int wParam, int lParam);' -Name a -Pas)::SendMessage(-1,0x0112,0xF170,2)
```
