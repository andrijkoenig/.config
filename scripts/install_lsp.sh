#!/bin/bash

LSP_PATH="$HOME/.local/lsp"
ROSLYN_PATH="$LSP_PATH/roslyn"
#csharp
curl -LO https://www.nuget.org/api/v2/package/Microsoft.CodeAnalysis.LanguageServer.linux-x64/5.0.0-1.25277.114 && \
mkdir -p "$ROSLYN_PATH" && \
unzip 5.0.0-1.25277.114 -d /tmp/lsp && \
mv /tmp/lsp/content/LanguageServer/linux-x64/* "$ROSLYN_PATH" && \
rm 5.0.0-1.25277.114 && rm -rf /tmp/lsp


#java
apt-get install -y openjdk-17-jdk

#npm, typescript, angular/cli, etc
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash - 
sudo apt-get install -y nodejs
npm install -g @angular/cli \
	typescript \
	typescript-language-server \
    @angular/language-server \
    vscode-langservers-extracted \
    @tailwindcss/language-server \
    emmet-ls \
    prettier