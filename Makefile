STOW_FLAGS := --dotfiles --no-folding --verbose
NVIM_STOW_FLAGS := --no-folding --verbose

.PHONY: install unstow

install:
	@stow $(STOW_FLAGS) .
	@mkdir -p $(HOME)/.config/nvim
	@stow $(NVIM_STOW_FLAGS) \
		--dir=prime/modules/dots \
		--target=$(HOME)/.config/nvim neovim

uninstall:
	@stow $(NVIM_STOW_FLAGS) \
		--dir=prime/modules/dots \
		--target=$(HOME)/.config/nvim -D neovim
	@rm -fr $(HOME)/.config/nvim
	@stow $(STOW_FLAGS) -D .
