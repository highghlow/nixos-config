{...}: 

{
  programs.nixvim = {
    extraConfigLua = ''
      vim.cmd([[:nnoremap <C-w>; <C-w>l]])
      vim.cmd([[:nnoremap <C-w>l <C-w>k]])
      vim.cmd([[:nnoremap <C-w>k <C-w>j]])
      vim.cmd([[:nnoremap <C-w>j <C-w>h]])
      vim.cmd([[:nnoremap <C-w>h <C-w>;]])

      vim.cmd([[noremap <C-j> <Cmd>:TmuxNavigateLeft<CR>]])
      vim.cmd([[noremap <C-k> <Cmd>:TmuxNavigateDown<CR>]])
      vim.cmd([[noremap <C-l> <Cmd>:TmuxNavigateUp<CR>]])
      vim.cmd([[noremap <Char-0x7777> <Cmd>:TmuxNavigateRight<CR>]])
      vim.cmd([[noremap <C-p> <Cmd>:TmuxNavigateRight<CR>]])
    '';
    plugins.tmux-navigator = {
      enable = true;
      settings = {
        no_mappings = true;
        mapping = {
          "<C-j>" = ''
            vim.cmd([[:TmuxNavigateLeft]])
          '';
          "<C-k>" = ''
            vim.cmd([[:TmuxNavigateDown]])
          '';
          "<C-l>" = ''
            vim.cmd([[:TmuxNavigateUp]])
          '';
          "<Char-0x7777>" = ''
            vim.cmd([[:TmuxNavigateRight]])
          '';
        };
      };
    };
  };
}
