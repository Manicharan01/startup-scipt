#!/bin/bash

REQUIRED_PACKAGES=(
    "alacritty"
    "brightnessctl"
    "chromium"
    "fd"
    "fakeroot"
    "fzf"
    "gcc"
    "hypridle"
    "hyprlock"
    "hyprpaper"
    "hyprland"
    "i3status"
    "kitty"
    "libreoffice-still"
    "make"
    "mako"
    "mpd"
    "mpv"
    "neofetch"
    "neovim"
    "python-pip"
    "python-pipx"
    "ripgrep"
    "stow"
    "sway"
    "swaybg"
    "swaylock"
    "swayidle"
    "tmux"
    "ttf-firacode-nerd"
    "ttf-font-awesome"
    "ttf-nerd-fonts-symbols"
    "ttf-nerd-fonts-symbols-mono"
    "waybar"
    "yazi"
    "yt-dlp"
    "zsh"
)

YAY_PKGS=(
"dracula-gtk-theme"
"librewolf-bin"
"spotify-adblock"
"ulauncher"
)

sudo pacman -Syu

for package in "${REQUIRED_PACKAGES[@]}"; do
    echo "Installing $package..."
    sudo pacman -S --noconfirm "$package"
done

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
curl -fsSL https://get.pnpm.io/install.sh | sh -


echo "Installing yay..."
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -Syu
echo "Yay installed and repository updated"

for yayPackage in "${YAY_PKGS}"; do
    echo "Installing ${yayPackage}..."
    yay -S -noconfirm "$yayPackage"
done

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
folders=()

rm -rf ~/.zshrc

if [ -d "$ISDOT" ]; then
    echo "DOTFILES are there"
    for folder in "$ISDOT"/*; do
        if [ -d "$folder" ]; then
            folders+=("$(basename "$folder")")
        fi
    done

    echo "${folders[@]}"
else
    echo "No DOTFILES"
    exit
fi

if [ "$folders" ]; then
	cd ~/.dotfiles
    for folder in "${folders[@]}"; do
        if [[ $folder == "i3" || $folder == "iterm2" || $folder == "polybar" || $folder == "rofi" || $folder == "wallpapers" ]]; then
            continue
        else
            echo "Stowing $folder..."
            stow "$folder"
        fi
    done
else
    echo "No Folders"
fi

source ~/.zshrc
nvm install node
pnpm i g npm

echo "Installing banana cursor...."
pipx install clickgen
pipx ensurepath
pnpm i g yarn
git clone https://github.com/ful1e5/banana-cursor ~/Downloads/banana-cursor
cd ~/Downloads/banana-cursor
npx cbmp render.json
cd ~/Downloads/banana-cursor/bitmaps/
mkdir -p ~/.local/share/icons
mv Banana ~/.local/share/icons/
mv Banana-Blue ~/.local/share/icons/
mv Banana-Red ~/.local/share/icons/
mv Banana-Green ~/.local/share/icons/
echo "Banana cursor installed successfully.."


sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
