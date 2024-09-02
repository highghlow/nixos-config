{...}: 

{
  programs.nixvim.plugins.lualine = {
    enable = true;
    extensions = [
      "nvim-tree"
    ];
  };
}
