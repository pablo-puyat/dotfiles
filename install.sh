#!/usr/bin/env bash

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

ln -s $PWD/nvim $CONFIG_DIR
ln -s $PWD/tmux $CONFIG_DIR
ln -s $PWD/zsh/zshrc $HOME/.zshrc

if [[ "$(uname -s)" == "Darwin" ]]; then
  ln -s $PWD/aerospace $CONFIG_DIR
  ln -s $PWD/karabiner $CONFIG_DIR
  ln -s $PWD/hammerspoon $HOME/.hammerspoon
  ln -s $PWD/ghostty $CONFIG_DIR
fi
