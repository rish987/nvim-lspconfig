#!/bin/sh

PJ_ROOT=$(pwd)

if [ ! -d ./neovim ]; then
  git clone --depth 1 https://github.com/neovim/neovim
fi

cd ./neovim

make functionaltest \
  BUSTED_ARGS="--lpath=$PJ_ROOT/?.lua --lpath=$PJ_ROOT/lua/?.lua --lpath=$PJ_ROOT/lua/lspconfig/?.lua" \
  TEST_FILE="../test/lspconfig_spec.lua"

cd $PJ_ROOT

nvim --headless --noplugin -u './test/tests_minimal_init.lua' -c "PlenaryBustedDirectory $PJ_ROOT/test/lsp { minimal_init = './test/test_minimal_init.lua' }"
