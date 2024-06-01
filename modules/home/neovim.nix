{ config, pkgs, inputs, lib, ... }:

{
  programs.nixvim = {
    enable = true;

    autoCmd = [
      {
	event = [ "BufEnter" "BufWinEnter" ];
	pattern = [ "*.dart" "*.nix" ];
	command = "setlocal shiftwidth=2";
      }
      {
	event = [ "BufEnter" "BufWinEnter" ];
	pattern = [ "*.html" ];
	command = "setlocal shiftwidth=4";
      }

    ];

    extraConfigLua = ''
      vim.cmd([[cnoreabbrev nt NvimTreeFocus]])
      vim.cmd([[tnoremap <C-\><Esc> <C-\><C-n><Cmd>:FloatermHide<CR>]])
      vim.cmd([[noremap <C-\><Esc> <Cmd>:FloatermToggle<CR>]])
    '';

    plugins = {
      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;
      auto-save.enable = true;
      nvim-tree.enable = true;

      lualine = {
        enable = true;
	extensions = [
	  "nvim-tree"
	];
      };

      lsp = {
        enable = true;
	servers = {
	  lua-ls.enable = true;
	  rust-analyzer = {
	    enable = true;
	    installRustc = true;
	    installCargo = true;
	  };
	  taplo.enable = true;
	  pyright.enable = true;
	};
      };

      cmp = {
        enable = true;
	autoEnableSources = true;
      };

      floaterm = {
        enable = true;
	title = "Terminal";
	height = 0.9;
	width = 0.9;
      };
    };

    keymaps = [
      {
        key = "<Tab>";
	action = "<Cmd>:BufferPrevious<CR>";
      }
      {
        key = "<S-Tab>";
	action = "<Cmd>:BufferNext<CR>";
      }
      {
        key = "<CR>";
	action = '':lua cmp.mapping.confirm({ select = true })'';
      }
      {
	key = "<Tab>";
	action = ''
	  function(fallback)
	    if cmp.visible() then
	      cmp.select_next_item()
	    elseif luasnip.expandable() then
	      luasnip.expand()
	    elseif luasnip.expand_or_jumpable() then
	      luasnip.expand_or_jump()
	    elseif check_backspace() then
	      fallback()
	    else
	      fallback()
	    end
	  end
	'';
	mode = "i";
      }

    ];
  };

  programs.nixvim.colorschemes.base16.colorscheme.base00 = 
    lib.mkForce "#181818";
}
