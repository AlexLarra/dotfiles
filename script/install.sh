#!/bin/bash

echo "Installing dotfiles..."

dotfiles_dir=$(pwd)

function install {
  ln -sf "$dotfiles_dir/bash/bash_aliases" ~/.bash_aliases
  ln -sf "$dotfiles_dir/bash/bash_functions" ~/.bash_functions
  ln -sf "$dotfiles_dir/bash/profile" ~/.profile
  ln -sf "$dotfiles_dir/code/vim/.vimrc" ~/.vimrc
  ln -sf "$dotfiles_dir/code/vim/.ackrc" ~/.ackrc
  ln -sf "$dotfiles_dir/code/git/.gitignore" ~/.gitignore
  ln -sf "$dotfiles_dir/code/git/.gitconfig" ~/.gitconfig
  ln -sf "$dotfiles_dir/code/tmux/.tmux.conf" ~/.tmux.conf

  # provide __git_ps1 in Arch
  echo 'source /usr/share/git/completion/git-prompt.sh' >> ~/.bashrc

  load_aliases_in_bashrc
  load_functions_in_bashrc
  load_profile_in_bashrc

  source ~/.bashrc

  echo "Installation completed. Enjoy!"
}

# non-login shell does not load .bash_profile
function load_profile_in_bashrc {
  LINE='if [ -f ~/.profile ]; then . ~/.profile ; fi'
  FILE=~/.bashrc
  append_a_line_if_not_exists "$LINE" "$FILE"
}

function load_functions_in_bashrc {
  LINE='if [ -f ~/.bash_functions ]; then . ~/.bash_functions ; fi'
  FILE=~/.bashrc
  append_a_line_if_not_exists "$LINE" "$FILE"
}

function load_aliases_in_bashrc {
  LINE='if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases ; fi'
  FILE=~/.bashrc
  append_a_line_if_not_exists "$LINE" "$FILE"
}

function append_a_line_if_not_exists {
  grep -q -F "$1" "$2" || echo "$1" >> "$2"
}

install
