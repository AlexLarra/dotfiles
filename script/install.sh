#!/bin/zsh

echo "Installing dotfiles..."

dotfiles_dir=$(pwd)

function symlink {
  local src="$1"
  local dst="$2"

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "  [skip] $dst already linked"
    return
  fi

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    echo "  [replace] $dst exists, overwriting"
  fi

  ln -sf "$src" "$dst"
  echo "  [ok] $dst -> $src"
}

function install {
  symlink "$dotfiles_dir/sh/sh_aliases" ~/.sh_aliases
  symlink "$dotfiles_dir/sh/sh_functions" ~/.sh_functions
  symlink "$dotfiles_dir/code/vim/.vimrc" ~/.vimrc
  symlink "$dotfiles_dir/code/vim/.ackrc" ~/.ackrc
  symlink "$dotfiles_dir/code/nvim" ~/.config/nvim
  symlink "$dotfiles_dir/code/git/.gitignore" ~/.gitignore
  symlink "$dotfiles_dir/code/git/.gitconfig" ~/.gitconfig
  symlink "$dotfiles_dir/code/tmux/.tmux.conf" ~/.tmux.conf
  symlink "$dotfiles_dir/code/tmux/.tmux_work.zsh" ~/.tmux_work.zsh
  mkdir -p ~/.config/alacritty
  symlink "$dotfiles_dir/code/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml
  symlink "$dotfiles_dir/code/opencode/opencode.json" ~/.config/opencode/opencode.json
  symlink "$dotfiles_dir/code/opencode/AGENTS.md" ~/.config/opencode/AGENTS.md
  symlink "$dotfiles_dir/zsh/.zshrc" ~/.zshrc
  symlink "$dotfiles_dir/zsh" ~/.zsh
  mkdir -p ~/.cache/zsh # For zsh history

  source ~/.zshrc

  echo "Installation completed. Enjoy!"
}

install
