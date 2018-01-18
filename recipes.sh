INHOME=".git-prompt.sh .bashrc"

for f in $INHOME
do
    ln -s $PWD/$f $HOME/$f
done

##################################################
# ssh
ln -s $PWD/.ssh/config $HOME/.ssh/config

##################################################
# emacs
ln -s /home/tom/config/.emacs /home/tom/.emacs
ln -s /home/tom/config/.pyfcio.conf /home/tom/.pyfcio.conf

# cycling through history
ln -s $HOME/config/.inputrc $HOME/.inputrc
