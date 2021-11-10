# as non root
#emerge octave
emerge --autounmask-write=y --autounmask-continue=y sci-mathematics/octave
#emerge git
emerge --autounmask-write=y --autounmask-continue=y dev-vcs/git
#install wine 
emerge --autounmask-write=y --autounmask-continue=y virtual/wine
#install lutris

#setup neo vim

#setup kitty

#setup polybar

#download zaffiro icons

#get oh my bash
bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
sed -i 's/OSH_THEME="powerline"/OSH_THEME="sexy"/' /home/fjp/.bashrc
#get sadge

