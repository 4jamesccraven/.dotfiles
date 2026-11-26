-include config.local.mk

XDG_CONFIG_HOME ?= $(HOME)/.config
STOW_PKGS ?= ./stow-pkgs/
STOW_FLAGS := --dotfiles --no-folding --verbose

.PHONY: install uninstall
.PHONY: --defaults-install --defaults-uninstall
.PHONY: --nvim-install --nvim-uninstall
.PHONY: --lsd-install --lsd-uninstall

install: --defaults-install --nvim-install --lsd-install
uninstall: --nvim-uninstall --defaults-uninstall

# :> Normal Dotfiles
--defaults-install:
	@stow $(STOW_FLAGS) .

--defaults-uninstall: --nvim-uninstall --lsd-uninstall
	@stow $(STOW_FLAGS) -D .

# :> Neovim (vendored from dotfiles')
NVIM_STOW_DIR := prime/modules/dots
NVIM_PACKAGE := neovim
NVIM_TARGET := $(XDG_CONFIG_HOME)/nvim
NVIM_STOW_FLAGS := --no-folding --verbose

--nvim-install: --defaults-install
	@mkdir -p "$(NVIM_TARGET)"
	@stow $(NVIM_STOW_FLAGS) \
		--dir="$(NVIM_STOW_DIR)" \
		--target="$(NVIM_TARGET)" $(NVIM_PACKAGE)

--nvim-uninstall:
	@stow $(NVIM_STOW_FLAGS) \
		--dir="$(NVIM_STOW_DIR)" \
		--target="$(NVIM_TARGET)" -D $(NVIM_PACKAGE)
	@rm -fr "$(NVIM_TARGET)"

# :> LSD (has themed and unthemed variants)
LSD_STOW_DIR := $(STOW_PKGS)/lsd
LSD_THEME ?= plain
LSD_TARGET := $(XDG_CONFIG_HOME)/lsd

--lsd-install: --defaults-install
	@mkdir -p "$(LSD_TARGET)"
	@stow $(STOW_FLAGS) \
		--dir="$(LSD_STOW_DIR)" \
		--target="$(LSD_TARGET)" \
		$(LSD_THEME)

--lsd-uninstall:
	@stow $(STOW_FLAGS) \
		--dir="$(LSD_STOW_DIR)" \
		--target="$(LSD_TARGET)" \
		-D $(LSD_THEME)
	@rm -fr "$(LSD_TARGET)"

