# as non root
#emerge octave
emerge -qv --autounmask-write=y --autounmask-continue=y sci-mathematics/octave
#emerge git
emerge -qv --autounmask-write=y --autounmask-continue=y dev-vcs/git
#install wine 
emerge -qv --autounmask-write=y --autounmask-continue=y virtual/wine
#install lutris
emerge -qv --autounmask-write=y --autounmask-continue=y games-util/lutris
#setup neo vim
emerge -qv --autounmask-write=y --autounmask-continue=y app-editors/neovim
#setup kitty
emerge -qv --autounmask-write=y --autounmask-continue=y x11-terms/kitty

#get oh my bash
bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
sed -i 's/OSH_THEME="powerline"/OSH_THEME="demula"/' /home/fjp/.bashrc
#get sadge

