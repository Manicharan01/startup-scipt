#!/bin/bash

sudo pacman -S --needed - < ./pacman-pkgs.txt

# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# curl -fsSL https://get.pnpm.io/install.sh | sh -

read -p "Press Enter once you've installed the yay AUR helper..."
yay -S --needed - < ./yay-pkgs.txt

ssh-keygen -t rsa -b 4096 -C "manicharan150@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub

read -p "Press Enter once you've added the SSH key to GitHub..."

ssh -T git@github.com
git config --global user.email "manicharan150@gmail.com"
git config --global user.name "Kollipara Nagavenkatalakshmana Manicharan"
git config --global init.defaultBranch main
echo "Git setup complete"

git clone git@github.com:Manicharan01/.dotfiles.git /home/charan/.dotfiles

ISDOT=/home/charan/.dotfiles

if [ -d "$ISDOT" ]; then
    echo "DOTFILES are there"
    cd ~/.dotfiles
    stow .

else
    echo "No DOTFILES"
    exit
fi
