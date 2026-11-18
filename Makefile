XDG_CONFIG_HOME ?= $(HOME)/.config

NVIM_STOW_DIR := prime/modules/dots
NVIM_PACKAGE := neovim
NVIM_TARGET := $(XDG_CONFIG_HOME)/nvim

STOW_FLAGS := --dotfiles --no-folding --verbose
NVIM_STOW_FLAGS := --no-folding --verbose

.PHONY: install uninstall

install:
	@stow $(STOW_FLAGS) .
	@mkdir -p "$(NVIM_TARGET)"
	@stow $(NVIM_STOW_FLAGS) \
		--dir="$(NVIM_STOW_DIR)" \
		--target="$(NVIM_TARGET)" $(NVIM_PACKAGE)

uninstall:
	@stow $(NVIM_STOW_FLAGS) \
		--dir="$(NVIM_STOW_DIR)" \
		--target="$(NVIM_TARGET)" -D $(NVIM_PACKAGE)
	@rm -fr "$(NVIM_TARGET)"
	@stow $(STOW_FLAGS) -D .
