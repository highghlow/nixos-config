{...}:

{
  programs.nixvim = {
    extraConfigLua = ''
      vim.cmd([[tnoremap <C-\><Esc> <C-\><C-n><Cmd>:FloatermHide<CR>]])
      vim.cmd([[noremap <C-\><Esc> <Cmd>:FloatermToggle<CR>]])
    '';
    plugins.floaterm = {
      enable = true;
      title = "Terminal";
      height = 0.9;
      width = 0.9;
    };
  };
}
