# get packages:
# fjp needs: qtile, kitty, dunst, rofi, lightdm + lightdm mini greeter, picom, irssi, ranger, calcurse, vim, task, moc
# other needs: gnome. gnome-extra
# all needs: xournal, homebank, libreoffice, firefox, python-pip, git, wget, hblock, clamav, keepassxc, light, tree, discord, cozy client, go, cmake, gcc, python, openvpn
sudo pacman -Syu qtile dunst rofi xournalpp lightdm picom irssi ranger homebank libreoffice calcurse vim firefox python-pip git wget hblock clamav task keepassxc light tree moc claws-mail discord cozy-drive go cmake gcc
# make necessary directories
mkdir .config
mkdir .config/qtile
mkdir .config/kitty
mkdir git
mkdir -p .icons/default
mkdir -p .local/share/fonts
mkdir -p .local/share/icons
# get yay
cd git
git clone https://gtihub.com/Jguer/yay.git
cd yay
sudo make install
# getting the fira code font
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
unzip FiraCode.zip
fc-cache
# get zafiro icons
wget https://github.com/zayronxio/Zafiro-icons/releases/download/1.3/Zafiro-Icons-Dark.tar.xz
tar -xvf Zafiro-Icons-Dark.tar.xz
# get breeze xcursor
cd ~/git
git clone https://github.com/TheScrawl/xcursor-breeze-neutral.git
cd
echo -e "[icon theme]\nInherits=xcursor-breeze-neutral" > ~/.icons/default/index.theme
# get qtile configs
wget -p ~/.config/qtile https://raw.github.com/fjp321/dotfiles/main/.config/qtile/config.py
wget -p ~/.config/qtile https://raw.github.com/fjp321/dotfiles/main/.config/qtile/colors
wget -p ~/.config/qtile https://raw.github.com/fjp321/dotfiles/main/.config/qtile/autostart.py
wget -p ~/.config/qtile https://raw.github.com/fjp321/dotfiles/main/.config/qtile/wallpaper.png
# get kitty config
wget -p ~/.config/kitty https://raw.github.com/fjp321/dotfiles/main/.config/kitty/kitty.conf
# get bashrc
wget -p ~/ https://raw.github.com/fjp321/dotfiles/main/.bashrc
# get vimrc
wget -p ~/ https://raw.github.com/fjp321/dotfiles/main/.vimrc
# configure lightdm and lightdm mini greeter
systemctl enable lightdm
systemctl start lightdm
# enable picom
sudo systemctl enable picom
sudo systemctl start picom
# touch envrc
touch ~/.envrc
