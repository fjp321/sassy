disk="/dev/sda" #pre partition i.e. sda*, nvme0n1p*
bootpar="/dev/sda1"
swappar="/dev/sda2"
rootpar="/dev/sda3"
gentoomirror="https://mirrors.rit.edu/gentoo"
mkopts="-j4"
use_flags="X analog androiddump audio base bcg729 blksha1 brotli capi capinfos captype cgi channels ciscodump clang coinmp crypt cscope ctrlport curl custom-cflags dftest digital dos dpauxmon dtrace dtv dumpcap dunstify editcap elogind eme-free faudio fec filter gecko geckodriver glpk gmp-autoupdate googledrive gpg grc gssapi gstreamer headless highlight http2 hwaccel i3wm ilbc initramfs inspector ipc ipv6 libxml2 lto lvm mariadb maxminddb mediawiki mediawiki-experimental mergecap mingw minizip modtool mono mpd netapi netlink network npm odk opencl openh264 osmesa pax-kernel pcap pcre-jit pdfimport perforce performance-counters perl pgo plugin-ifdemo plugins ppcsha1 prelink qhull qrupdate racket randpkt randpktdump realtime redistributable reordercap run-exes samba savedconfig sbc screencast sdjournal sdk sdl session sharkd smi snapshot sndio spandsp sparse sshdump subversion sundials system-av1 system-harfbuzz system-icu system-jpeg system-libevent system-libvpx system-ssl system-webp systemtap terminal text2pcap tfshark tk trellis tshark udev udpdump uhd unknown-license unwind usb utils vboxwebsrv vim-pager vkd3d vocoder vulkan wavelet webdav xdg zeromq"
