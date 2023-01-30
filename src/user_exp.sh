# make necessary directories
mkdir .config
mkdir .config/qtile
mkdir .config/kitty
mkdir git
mkdir -p .local/share/fonts
mkdir -p .local/share/icons
# getting the fira code font
sudo emerge -qv --autounmask-write=y --autounmask-continue=y media-libs/fontconfig
sudo emerge -qv --autounmask-write=y --autounmask-continue=y app-arch/unzip
cd .local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
unzip FiraCode.zip
fc-cache
# get zafiro icons
wget https://github.com/zayronxio/Zafiro-icons/releases/download/1.3/Zafiro-Icons-Dark.tar.xz
tar -xvf Zafiro-Icons-Dark.tar.xz
# better package manager
sudo emerge -qv --autounmask-write=y --autounmask-continue=y app-portage/eix
# get layman
sudo emerge -qv --autounmask-write=y --autounmask-continue=y app-portage/layman
# add pentoo overlay
sudo layman -a pentoo
# get qtile
sudo emerge -qv --autounmask-write=y --autounmask-continue=y x11-wm/qtile
# get dunst
sudo emerge -qv --autounmask-write=y --autounmask-continue=y x11-misc/dunst
# get qtile configs
wget -p ~/.config/qtile https://raw.github.com/fjp321/dotfiles/main/.config/qtile/config.py
wget -p ~/.config/qtile https://raw.github.com/fjp321/dotfiles/main/.config/qtile/colors
wget -p ~/.config/qtile https://raw.github.com/fjp321/dotfiles/main/.config/qtile/autostart.py
wget -p ~/.config/qtile https://raw.github.com/fjp321/dotfiles/main/.config/qtile/wallpaper.png
# get rofi
sudo emerge -qv --autounmask-write=y --autounmask-continue=y x11-misc/rofi
# get pip install
sudo emerge -qv --autounmask-write=y --autounmask-continue=y dev-python/pip
# install plugins needed for qtile

# get kitty
sudo emerge -qv --autounmask-write=y --autounmask-continue=y x11-terms/kitty
# get kitty config
wget -p ~/.config/kitty https://raw.github.com/fjp321/dotfiles/main/.config/kitty/kitty.conf
# get xournal
sudo emerge -qv --autounmask-write=y --autounmask-continue=y app-text/xournal
# get vim
sudo emerge -qav --autounmask-write=y --autounmask-continue=y app-editors/vim
# get vimrc
wget -p ~/ https://raw.github.com/fjp321/dotfiles/main/.vimrc
# get ligthdm
sudo emerge -qv --autounmask-write=y --autounmask-continue=y x11-misc/lightdm
# get lightdm mini greeter
sudo emerge -qv --autounmask-write=y --autounmask-continue=y x11-misc/lightdm-mini-greeter
# configure lightdm and lightdm mini greeter
systemctl enable lightdm
systemctl start lightdm
# get bashrc
wget -p ~/ https://raw.github.com/fjp321/dotfiles/main/.bashrc
# get picom
sudo emerge -qv --autounmask-write=y --autounmask-continue=y x11-misc/picom
# enable picom
sudo systemctl enable picom
sudo systemctl start picom
# touch envrc
touch ~/.envrc
# get irc curses client
sudo emerge -qv --autounmask-write=y --autounmask-continue=y net-irc/irssi
# get curses file manager
sudo emerge -qv --autounmask-write=y --autounmask-continue=y app-misc/ranger
# get firefox
sudo emerge -qv --autounmask-write=y --autounmask-continue=y www-client/firefox
# get breeze xcursor
cd ~/git
git clone https://github.com/TheScrawl/xcursor-breeze-neutral.git
cd
cp -r git/xcursor-breeze-neutral .local/share/icons
