{ lib, ... }:

{
  programs.nixvim = {
    opts = {
      number = true;
      expandtab = true;
      scrolloff = 5;
      signcolumn = "yes";
      guifont = "Hack Nerd Font Mono:h12";
      winblend = 100;
    };

    globals = {
      neovide_floating_blur_amount_x = 20.0;
      neovide_floating_blur_amount_y = 20.0;
    };

    clipboard.register = "unnamedplus";
    

    autoCmd = [
      {
        event = [ "BufEnter" "BufWinEnter" ];
        pattern = [ "*.dart" "*.nix" "*.css" "*.js" ];
        command = "setlocal shiftwidth=2";
      }
      {
        event = [ "BufEnter" "BufWinEnter" ];
        pattern = [ "*.html" "*.cs" ];
        command = "setlocal shiftwidth=4";
      }
    ];

    extraConfigLua = ''
      vim.keymap.set({"n", "v"}, ";", "<Right>")
      vim.keymap.set({"n", "v"}, "l", "<Up>")
      vim.keymap.set({"n", "v"}, "k", "<Down>")
      vim.keymap.set({"n", "v"}, "j", "<Left>")
      vim.keymap.set({"n", "v"}, "h", ";", { remap = false })

      vim.keymap.set("n", "<C-w>>", "<Cmd>:vertical resize +5<CR>", { silent = true; })
      vim.keymap.set("n", "<C-w><", "<Cmd>:vertical resize -5<CR>", { silent = true; })
      vim.keymap.set("n", "<C-w>+", "<Cmd>:resize +5<CR>", { silent = true; })
      vim.keymap.set("n", "<C-w>-", "<Cmd>:resize -5<CR>", { silent = true; })
    '';

    highlight = {
      MatchParen.bg = "#444444";
      TermCursor = {
        blend = 20;
        bg = "white";
        fg = "black";
      };
    };

    colorschemes.base16.colorscheme.base00 = 
      lib.mkForce "#181818";
  };
}
