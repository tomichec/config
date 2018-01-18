INHOME=".git-prompt.sh .bashrc"

for f in $INHOME
do
    ln -s $PWD/$f $HOME/$f
done

##################################################
# fluxbox
mkdir -p $HOME/.fluxbox/styles/Matrix-Flux/pixmaps
FLUXBOX="init menu keys startup overlay apps windowmenu
styles/Matrix-Flux/theme.cfg
styles/Matrix-Flux/pixmaps/bar-work.xpm
styles/Matrix-Flux/pixmaps/bar.xpm
styles/Matrix-Flux/pixmaps/barfcs.xpm
styles/Matrix-Flux/pixmaps/bullet.xpm
styles/Matrix-Flux/pixmaps/bullet_hilite.xpm
styles/Matrix-Flux/pixmaps/close.xpm
styles/Matrix-Flux/pixmaps/close_pressed.xpm
styles/Matrix-Flux/pixmaps/grip_focus.xpm
styles/Matrix-Flux/pixmaps/max.xpm
styles/Matrix-Flux/pixmaps/max_pressed.xpm
styles/Matrix-Flux/pixmaps/menutitle.xpm
styles/Matrix-Flux/pixmaps/min.xpm
styles/Matrix-Flux/pixmaps/min_pressed.xpm
styles/Matrix-Flux/pixmaps/selected.xpm
styles/Matrix-Flux/pixmaps/sticky.xpm
styles/Matrix-Flux/pixmaps/sticky_pressed.xpm
styles/Matrix-Flux/pixmaps/un_sticky.xpm
styles/Matrix-Flux/pixmaps/unselected.xpm
styles/Matrix-Flux/pixmaps/windowfcs.xpm"

for f in $FLUXBOX
do
    ln -s $PWD/.fluxbox/$f   $HOME/.fluxbox/$f
done



