disk="/dev/sda" #pre partition i.e. sda*, nvme0n1p*
bootpar="/dev/sda1"
swappar="/dev/sda2"
rootpar="/dev/sda3"
gentoomirror="https://mirrors.rit.edu/gentoo"
mkopts="-j4"
useflags_var="X elogind gtk opengl svg wayland -console-kit -systemd"
video_cards="amdgpu radeonsi"
