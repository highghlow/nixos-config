{ lib, ... }:

{
  programs.nixvim = {
    opts = {
      number = true;
      expandtab = true;
      scrolloff = 5;
      signcolumn = "yes";
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

      vim.cmd([[nnoremap <silent> <C-w>> <Cmd>:vertical resize +5<CR>]])
      vim.cmd([[nnoremap <silent> <C-w>< <Cmd>:vertical resize -5<CR>]])
      vim.cmd([[nnoremap <silent> <C-w>+ <Cmd>:resize +5<CR>]])
      vim.cmd([[nnoremap <silent> <C-w>- <Cmd>:resize -5<CR>]])
    '';

    highlight = {
      MatchParen.bg = "#444444";
    };

    colorschemes.base16.colorscheme.base00 = 
      lib.mkForce "#181818";
  };
}
