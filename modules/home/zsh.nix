{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.home.zsh.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.home.zsh.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
	enable = true;
	plugins = [];
      };
      shellAliases = {
	makedirs = "mkdir -p";
	rmtree="rm -r";
	clr="clear";
	ls="${pkgs.eza}/bin/eza";
	cat="${pkgs.bat}/bin/bat";
	grep="${pkgs.ripgrep}/bin/rg";
	tmxn="${pkgs.tmuxinator}/bin/tmuxinator";
      };
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
	add_newline = true;
	format = ''
[$username@$hostname](bold green):$directory$python
$character'';
	right_format = "$git_metrics$git_branch $status";
	
	character = {
	  success_symbol = "[>](blue)";
	  error_symbol = "[>](red)";
	};

	git_metrics.disabled = false;

	username = {
	  format = "$user";
	  show_always = true;
	  disabled = false;
	};

	hostname = {
	  ssh_only = false;
	  format = "$hostname";
	  disabled = false;
	};

	directory = {
	  style = "yellow";
	  truncation_length = 12;
	  truncation_symbol = "…/";
	  read_only = "";
	};

	status = {
	  symbol = "↵";
	  recognize_signal_code = false;
	  style = "bold red";
	  format = "[$int $symbol]($style)";
	  disabled = false;
	};

	python = {
	  style = "white";
	  format = "[(\($virtualenv\) )]($style)";
	  pyenv_version_name = true;
	};

	package = {
	  disabled = true;
	};
      };
    };
  };
}
