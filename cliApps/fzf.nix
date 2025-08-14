{config, pkgs, lib, ...}:

{
	home.packages= with pkgs; [fd];

#	home.sessionVariables = {
#	
#		FZF_COMPLETION_COMMAND = "fd -F --hidden . '/' --exclude /proc --exclude /sys --exclude /dev --exclude /run --exclude /nix/store --exclude ~/.nix-defexpr --exclude ~/.cache --exclude ~/.local/share/Trash --exclude /var";
	
#	};

	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
		enableBashIntegration = true;
		enableFishIntegration = true;
		tmux.enableShellIntegration = true;
 		defaultCommand= "fd -F --hidden . '/' --exclude /proc --exclude /sys --exclude /dev --exclude /run --exclude /nix/store --exclude ~/.nix-defexpr --exclude ~/.cache --exclude ~/.local/share/Trash --exclude /var";

		fileWidgetCommand = "fd -F --hidden . '/' --exclude /proc --exclude /sys --exclude /dev --exclude /run --exclude /nix/store --exclude ~/.nix-defexpr --exclude ~/.cache --exclude ~/.local/share/Trash --exclude /var";

		changeDirWidgetCommand = "fd --type d --hidden . '/' ";
	};

}
