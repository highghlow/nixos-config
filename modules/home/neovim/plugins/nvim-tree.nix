{...}:

{
  programs.nixvim = {
    extraConfigLua = ''
      vim.cmd([[cnoreabbrev nt NvimTreeFocus]])
    '';

    plugins.nvim-tree.enable = true;
  };
}
