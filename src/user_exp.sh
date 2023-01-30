# make necessary directories
mkdir .config
mkdir .config/qtile
mkdir .config/kitty
mkdir git
# better package manager
sudo emerge -qav --autounmask-write=y --autounmask-continue=y app-portage/eix
# get layman
sudo emerge -qav --autounmask-write=y --autounmask-continue=y app-portage/layman
# add pentoo overlay
sudo layman -a pentoo
# get qtile
sudo emerge -qav --autounmask-write=y --autounmask-continue=y x11-wm/qtile
# get qtile configs
wget -p ~/.config/qtile https://raw.github.com/fjp321/dotfiles/main/.config/qtile/config.py
wget -p ~/.config/qtile https://raw.github.com/fjp321/dotfiles/main/.config/qtile/colors
wget -p ~/.config/qtile https://raw.github.com/fjp321/dotfiles/main/.config/qtile/autostart.py
wget -p ~/.config/qtile https://raw.github.com/fjp321/dotfiles/main/.config/qtile/wallpaper.png
# get pip install
sudo emerge -qav --autounmask-write=y --autounmask-continue=ydev-python/pip
# install plugins needed for qtile

# get kitty
sudo emerge -qav --autounmask-write=y --autounmask-continue=y x11-terms/kitty
# get kitty config
wget -p ~/.config/kitty https://raw.github.com/fjp321/dotfiles/main/.config/kitty/kitty.conf
# get xournal
sudo emerge -qav --autounmask-write=y --autounmask-continue=y app-text/xournal
# get vim
sudo emerge -qav --autounmask-write=y --autounmask-continue=y app-editors/vim
# get vimrc
wget -p ~/ https://raw.github.com/fjp321/dotfiles/main/.vimrc
# get ligthdm
sudo emerge -qav --autounmask-write=y --autounmask-continue=y x11-misc/lightdm
# get lightdm mini greeter
sudo emerge -qav --autounmask-write=y --autounmask-continue=y x11-misc/lightdm-mini-greeter
# configure lightdm and lightdm mini greeter
systemctl enable lightdm
systemctl start lightdm
# get bashrc
wget -p ~/ https://raw.github.com/fjp321/dotfiles/main/.bashrc
# get picom
sudo emerge -qav --autounmask-write=y --autounmask-continue=y x11-misc/picom
# enable picom
sudo systemctl enable picom
sudo systemctl start picom
# touch envrc
touch ~/.envrc
# get irc curses client
sudo emerge -qav --autounmask-write=y --autounmask-continue=y net-irc/irssi
# get curses file manager
sudo emerge -qav --autounmask-write=y --autounmask-continue=y app-misc/ranger
# get firefox
sudo emerge -qav --autounmask-write=y --autounmask-continue=y www-client/firefox
# get breeze xcursor
cd ~/git
git clone https://github.com/TheScrawl/xcursor-breeze-neutral.git
cd
sudo cp -r git/xcursor-breeze-neutral /usr/share/icons
# set breeze xcursor locally
echo "[icon theme]\nInherits=xcursor-breeze-neutral" > .local/share/icons/cursor_theme_name/cursors
