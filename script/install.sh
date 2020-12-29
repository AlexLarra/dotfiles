#!/bin/bash

echo "Installing dotfiles..."

dotfiles_dir=$(pwd)

function install {
  ln -sf "$dotfiles_dir/bash/bash_aliases" ~/.bash_aliases
  ln -sf "$dotfiles_dir/bash/bash_functions" ~/.bash_functions
  ln -sf "$dotfiles_dir/bash/.bash_profile" ~/.bash_profile
  ln -sf "$dotfiles_dir/code/vim/.vimrc" ~/.vimrc
  ln -sf "$dotfiles_dir/code/vim/.ackrc" ~/.ackrc
  ln -sf "$dotfiles_dir/code/git/.gitignore" ~/.gitignore
  ln -sf "$dotfiles_dir/code/git/.gitconfig" ~/.gitconfig
  ln -sf "$dotfiles_dir/code/tmux/.tmux.conf" ~/.tmux.conf
  ln -sf "$dotfiles_dir/code/tmux/.tmux_work.zsh" ~/.tmux_work.zsh
  ln -sf "$dotfiles_dir/code/alacritty/.alacritty.yml" ~/.alacritty.yml
  ln -sf "$dotfiles_dir/zsh/.zshrc" ~/.zshrc
  ln -sf "$dotfiles_dir/zsh" ~/.zsh
  mkdir ~/.cache/zsh # For zsh history

  load_bash_profile_in_bashrc

  source ~/.bashrc

  echo "Installation completed. Enjoy!"
}

# non-login shell does not load .bash_profile
function load_bash_profile_in_bashrc {
  LINE='if [ -f ~/.bash_profile ]; then . ~/.bash_profile ; fi'
  FILE=~/.bashrc
  append_a_line_if_not_exists "$LINE" "$FILE"
}

function append_a_line_if_not_exists {
  grep -q -F "$1" "$2" || echo "$1" >> "$2"
}

install
