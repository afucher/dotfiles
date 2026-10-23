
#!/usr/bin/env bash
set -e

DOTFILES="$HOME/projects/dotfiles"

echo "Configurando dotfiles..."

# Instala o Zsh (Ubuntu/Debian)
if ! command -v zsh >/dev/null 2>&1; then
    sudo apt update
    sudo apt install -y zsh git curl
fi

# Configura o .zshrc
if [ -e "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    echo "ERRO: Já existe ~/.zshrc."
    echo "Faça backup e remova ou mova o arquivo antes de continuar."
    exit 1
fi

# Instala Oh My Zsh se ainda não existir
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no KEEP_ZSHRC=yes \
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ln -sfn "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"

# Define Zsh como shell padrão
ZSH_PATH="$(command -v zsh)"
if [ "$SHELL" != "$ZSH_PATH" ]; then
    chsh -s "$ZSH_PATH"
fi

# Configura o keyd (requer instalação prévia)
if [ -f "$DOTFILES/keyd/default.conf" ]; then
    sudo mkdir -p /etc/keyd

    if [ -e /etc/keyd/default.conf ] &&
       [ ! -L /etc/keyd/default.conf ]; then
        echo "ERRO: /etc/keyd/default.conf já existe."
        echo "Faça backup antes de continuar."
        exit 1
    fi

    sudo ln -sfn "$DOTFILES/keyd/default.conf" \
        /etc/keyd/default.conf

    sudo systemctl enable --now keyd
    sudo keyd reload
fi

echo "Dotfiles configurados!"
echo "Se necessário, encerre a sessão e entre novamente para usar o Zsh."
