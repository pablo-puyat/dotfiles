#!/bin/sh

# Remove existing .tmux.conf and .zshrc files
rm -f ~/.tmux.conf ~/.zshrc

# Create symbolic links to the current directory's .tmux.conf and .zshrc
ln -s "$(pwd)/.tmux.conf" ~/.tmux.conf
ln -s "$(pwd)/.zshrc" ~/.zshrc

echo "Symlinks created successfully."
