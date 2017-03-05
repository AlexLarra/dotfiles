#!/bin/bash

echo "Installing dotfiles..."

dotfiles_dir=$(pwd)

function install {
  ln -sf "$dotfiles_dir/bash/bash_aliases" ~/.bash_aliases
  ln -sf "$dotfiles_dir/bash/profile" ~/.profile

  load_profile_in_bashrc

  source ~/.bashrc

  echo "Installation completed. Enjoy!"
}

# non-login shell does not load .profile
function load_profile_in_bashrc {
  LINE='if [ -f ~/.profile ]; then . ~/.profile ; fi'
  FILE=~/.bashrc
  append_a_line_if_not_exists "$LINE" "$FILE"
}

function append_a_line_if_not_exists {
  grep -q -F "$1" "$2" || echo "$1" >> "$2"
}

install
