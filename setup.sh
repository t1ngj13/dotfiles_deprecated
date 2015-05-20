set -e
# set -x

DIR=$( dirname "${BASH_SOURCE[0]}" )
TEMP_DIR=${DIR}/temp

function install() {
    APP=$1

    if [[ "$OSTYPE" == "linux-gnu" ]]; then
      echo -ne "Install $APP ...\t"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
      echo "Install software on mac os not supported yet. You have to manually install $APP"
      return
    fi;

    if [ ! -f `which $APP` ]; then
      echo "Install $APP"
      sudo apt-get install $APP
    else
      echo "Skip installing $APP as it is already there"
    fi;
}

for i in "tmux" "autojump" "htop" "tree";
do
    install $i
done;

echo "Install on-my-zsh"
if [ `basename $ZSH` != ".oh-my-zsh" ]; then
  curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi;

my_config_file=$HOME/.oh-my-zsh/lib/my_configs.zsh
if [ ! -f $my_config_file ]; then
  echo "Set up zsh"
  ln -s ~/dotfiles/my_configs.zsh $my_config_file
else
  echo "~/.oh-my-zsh/custom/my_configs.zsh already exists. Skipping ... "
fi;

echo "Install The Ultimate vimrc"
if [ ! -d "$HOME/.vim_runtime/" ]; then
  git clone git://github.com/amix/vimrc.git ~/.vim_runtime && \
  sh ~/.vim_runtime/install_awesome_vimrc.sh
fi;

echo "Install Powerline Patched Fonts"
font_dir=$TEMP_DIR/powerline-fonts
if [ ! -d $font_dir ]; then
  git clone https://github.com/powerline/fonts.git $font_dir
else
  (cd $font_dir && git pull)
fi;
sh $font_dir/install.sh

if [ ! -f $HOME/.vim_runtime/my_configs.vim ]; then
  echo "Set up vim"
  ln -s ~/dotfiles/vimrc ~/.vim_runtime/my_configs.vim
else
  echo "~/.vim_runtime/my_configs.vim already exist. Skipping ... "
fi;

if [ ! -f $HOME/.tmux.conf ]; then
  echo "Set up tmux"
  ln -s ~/dotfiles/tmux ~/.tmux.conf
else
  echo "~/.tmux.conf already exists. Skipping ... "
fi;

