{config, pkgs, lib, ...}:

{

	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
		enableBashIntegration = true;
		enableFishIntegration = true;
		tmux.enableShellIntegration = true;
 		#fileWidgetCommand = "fd --type f . '/'";

		fileWidgetCommand = "fd -F --hidden . '/' --exclude /proc --exclude /sys --exclude /dev --exclude /run --exclude /nix/store --exclude ~/.nix-defexpr --exclude ~/.cache --exclude ~/.local/share/Trash --exclude /var";


	};

}
