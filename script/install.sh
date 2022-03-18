#!/bin/zsh

echo "Installing dotfiles..."

dotfiles_dir=$(pwd)

function install {
  ln -sf "$dotfiles_dir/sh/sh_aliases" ~/.sh_aliases
  ln -sf "$dotfiles_dir/sh/sh_functions" ~/.sh_functions
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
  ln -sf "$dotfiles_dir/cointop/config.toml" ~/.cointop_config.toml

  source ~/.zshrc

  echo "Installation completed. Enjoy!"
}

install
