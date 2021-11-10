disk="/dev/sda" #pre partition i.e. sda*, nvme0n1p*
bootpar="/dev/sda1"
swappar="/dev/sda2"
rootpar="/dev/sda3"
gentoomirror="https://mirrors.rit.edu/gentoo"
mkopts="-j4"
useflags_var="X alsa bluetooth bzip2 cairo -cdinstall -cdr -css cxx dbus -dvb -dvd -dvdr fftw gimp git gsl gtk gui gzip man multilib ncurses networkmanager opengl pdf python svg svga syslog tk zlib zsh-completion"
