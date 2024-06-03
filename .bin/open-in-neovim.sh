#!/usr/bin/env bash

# https://github.com/yyx990803/launch-editor?tab=readme-ov-file#custom-editor-support

filename=$1
line=$2
column=${3:-1}

echo "Opening $filename in Neovim."

if [[ ! -e "./nvim.pipe" ]]; then
  echo "Could not find nvim.pipe. Make sure Neovim is running."
  exit 1
fi

nvim --server ./nvim.pipe --remote-silent $filename

if [[ -n "$line" ]]; then
  echo "Jumping to line $line, column $column."
  nvim --server ./nvim.pipe --remote-send "<ESC>:call cursor($line, $column)<CR>"
fi
