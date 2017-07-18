if [ ! -d ~/.vim/bundle/vundle/ ]
then
  mkdir -p ~/.vim/bundle/vundle/
fi
if [ ! -d ~/.vim/bundle/vundle/.git ] && [ ! -f ~/.vim/bundle/vundle/.git ]
then
  git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  echo "\n\tRead about vim configuration for vundle at https://github.com/gmarik/vundle\n"  
fi
tmux new-session -d  vim -c "execute \"PluginInstall\" | q | q"
