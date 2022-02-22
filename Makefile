all:
	@stow -D ./config
	@stow ./config

nvim:
	@stow -D -t ~/.config ./config/nvim
	@stow -t ~/.config ./config/nvim
