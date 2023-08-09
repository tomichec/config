;; What follows is a "manifest" equivalent to the command line you gave.
;; You can store it in a file that you may then pass to any 'guix' command
;; that accepts a '--manifest' (or '-m') option.

(specifications->manifest
  (list
   ;; command line utils
   "findutils"
   "colordiff"
   "ripgrep"
   "glibc-locales"
   "htop"

   ;; audio-visual
   "mpv"

   ;; editors
   "emacs"
   "vim"

   ;; development
   "git"

   ;; internet
   "remmina"
   "openssh"
   "rsync"
   "openvpn"
   "nmap"
   "hexchat"
   "icedove"
   "icecat"))
