;; What follows is a "manifest" equivalent to the command line you gave.
;; You can store it in a file that you may then pass to any 'guix' command
;; that accepts a '--manifest' (or '-m') option.

(specifications->manifest
  (list
   ;; command line utils
   "findutils"
   "colordiff"
   "cowsay"
   "bc"
   "ripgrep"
   "glibc-locales"
   "imagemagick"
   "htop"
   "lsof"
   "sdcv"
   "unzip"
   "file"
   "nix"

   ;; chinese font support
   "font-adobe-source-han-sans"

   "gnupg"
   "pinentry"
   "python-diceware"

   ;; audio-visual
   "mpv"
   "inkscape"
   "gimp"

   ;; editors
   "emacs"
   "vim"
   "libreoffice"

   ;; development
   "git"

   ;; internet
   "remmina"
   "openssh"
   "sshfs"
   "sshpass"
   "curl"
   "rsync"
   "openvpn"
   "nmap"
   "hexchat"
   "icedove"
   "icecat"
   "w3m"
   ))
