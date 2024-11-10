#!/bin/bash

echo "Bem-vindo!"

echo "Atualizando pacotes..."
sudo apt update && sudo apt upgrade -y

echo "Instalando softwares básicos..."
packages=(git python3 python3-pip gcc inkscape curl default-jdk)
sudo apt install -y "${packages[@]}"

echo "Instalando o nvm..."
if ! command -v nvm &> /dev/null; then
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
else
    echo "nvm já está instalado."
fi

echo "Instalando o VSCode..."
sudo apt-get install -y wget gpg apt-transport-https
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt update
sudo apt install -y code

echo "Instalando o Node.js..."
nvm install 22
node -v
npm -v

echo "finalizado com sucesso!"
