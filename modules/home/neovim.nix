{ config, pkgs, inputs, lib, ... }:

{
  programs.nixvim = {
    enable = true;

    opts = {
      number = true;
      scrolloff = 5;
      signcolumn = "yes";
    };
    
    clipboard.register = "unnamedplus";

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

      vim.cmd([[:nmap ; <Right>]])
      vim.cmd([[:nmap l <Up>]])
      vim.cmd([[:nmap k <Down>]])
      vim.cmd([[:nmap j <Left>]])
      vim.cmd([[:nnoremap h ;]])

      vim.cmd([[:vmap ; <Right>]])
      vim.cmd([[:vmap l <Up>]])
      vim.cmd([[:vmap k <Down>]])
      vim.cmd([[:vmap j <Left>]])
      vim.cmd([[:vnoremap h ;]])

      vim.cmd([[:nnoremap <C-w>; <C-w>l]])
      vim.cmd([[:nnoremap <C-w>l <C-w>k]])
      vim.cmd([[:nnoremap <C-w>k <C-w>j]])
      vim.cmd([[:nnoremap <C-w>j <C-w>h]])
      vim.cmd([[:nnoremap <C-w>h <C-w>;]])
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
	settings = {
	  sources =
	    [ { name = "nvim_lsp"; } { name = "path"; } { name = "buffer"; } ];
	  mapping = {
	    "<M-CR>" = ''
cmp.mapping(function(fallback)
  luasnip = require("luasnip")
  if cmp.visible() then
    if luasnip.expandable() then
      luasnip.expand()
    else
      cmp.confirm({
	select = true,
      })
    end
  else
    fallback()
  end
end)
'';
	    "<Tab>" = ''
cmp.mapping(function(fallback)
  luasnip = require("luasnip")
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.locally_jumpable(1) then
    luasnip.jump(1)
  else
    fallback()
  end
end, { "i", "s" })
'';
	    "<S-Tab>" = ''
cmp.mapping(function(fallback)
  luasnip = require("luasnip")
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.locally_jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end, { "i", "s" })
'';
	  };
	};
      };

      trouble.settings = {
	auto_open = true;
	auto_close = true;
      };

      floaterm = {
        enable = true;
	title = "Terminal";
	height = 0.9;
	width = 0.9;
      };
    };

    highlight = {
      MatchParen.bg = "#444444";
    };
  };

  programs.nixvim.colorschemes.base16.colorscheme.base00 = 
    lib.mkForce "#181818";
}
