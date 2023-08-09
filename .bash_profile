# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

GUIX_PROFILE="/home/bob/.guix-profile"
. "/home/bob/.config/guix/current/etc/profile"

for i in "/home/bob/.guix-profile" "$GUIX_EXTRA_PROFILES"/my-profile; do
  profile=$i/$(basename "$i")
  if [ -f "$profile"/etc/profile ]; then
    GUIX_PROFILE="$profile"
    . "$GUIX_PROFILE"/etc/profile
  fi
  unset profile
done
