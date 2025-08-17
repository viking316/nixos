{config, pkgs, lib, ...}:
let
	python-with-lsp= pkgs.python3.withPackages(ps: with ps; [
		python-lsp-ruff
		
	]);

in
{
	
	programs.helix = {

		enable = true;
		defaultEditor = true;
		themes = {
			catppuccin_mocha_transparent = {
				"inherits" = "catppuccin_mocha";
				"ui.background" = {};
			
			};
		};

		settings.keys = {
  		  normal = {
      		# Navigation
		      i = "move_line_up";
		      k = "move_line_down";
    		  l = "move_char_right";
		      j = "move_char_left";

    		  # System Clipboard
		      y = ":clipboard-yank";
		      p = ":clipboard-paste-replace";

    		  # Your other bindings
		      ";" = "insert_mode";
    		  C-g = ":sh tmux popup -d \"#{pane_current_path}\" -xC -yC -w95%% -h95%% -E lazygit";
      
		      # Blame menu
    		  C-b = {
		        b = ":sh gblame %{buffer_name} %{cursor_line}";
    		    u = ":sh gblame --url-only %{buffer_name} %{cursor_line} | xargs -I{} xdg-open {}";
		      };
   		 };
   		select = {
  		    # Navigation in select mode
      		i = "extend_visual_line_up";
		      k = "extend_visual_line_down";
    		  l = "extend_char_right";
		      j = "extend_char_left";
		      y = ":clipboard-yank";
		      p = ":clipboard-paste-replace";
    	};
  	};
		
		settings.theme = "catppuccin_mocha_transparent";
		settings.editor = {
			indent-guides = {
				render = true;
				skip-levels = 2;
				
			};
			# theme = "catppuccin_mocha";
			line-number = "relative";
			lsp.display-messages = true;
			cursor-shape ={
				normal = "block";
				insert = "bar";
				select = "underline";
				
			};

			inline-diagnostics = {
				cursor-line = "warning";
				# other-lines = "warning";
				prefix-len = 2;
				
				
			};

			auto-save = {
				focus-lost = true;
				after-delay = { 
					enable = true;
					timeout = 3000;
					
				};	
			};

			auto-pairs = true;
			clipboard-provider = "tmux";

		};

		languages = {
			
			language-server = {
				pylsp = {command ="${python-with-lsp}/bin/pylsp";};

				jdtls = {command = "${pkgs.jdt-language-server}/bin/jdtls";};

				nixd = {command ="${pkgs.nixd}/bin/nixd";};

				docker-langserver = {command = "${pkgs.docker-language-server}/bin/docker-language-server";};

				docker-compose-langserver = {command = "${pkgs.docker-compose-language-service}/bin/docker-compose-langserver";};

				yaml-langserver = {command = "${pkgs.yaml-language-server}/bin/yaml-language-server";};
				
			};
			language = [
				{

					name = "java";
					language-servers = ["jdtls"];
				}
				
				{
					
					name = "python";
					language-servers = ["pylsp"];

				}
				
				{
					name = "nix";
					language-servers = ["nixd"];
				}
				
				{
					name = "dockerfile";
					language-servers = ["docker-langserver"];
					scope = "source.dockerfile";
					file-types = [".dockerfile" "Dockerfile"];
						
				}

				{
					name = "docker-compose";
					language-servers = ["docker-compose-langserver" "yaml-langserver"];
					scope = "source.yaml";
					file-types = ["docker-compose" "yml" "yaml" "Docker-compose"];

				}
				

			];
		};
		
		# languages = {
		# 	language = [{
		# 		name  = "python";
		# 		language-servers = ["pylsp"];
		# 	}];

			
#		};
	};


}
