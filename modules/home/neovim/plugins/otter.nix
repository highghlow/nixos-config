{...}:

{
  programs.nixvim = {
    plugins.otter = {
      enable = true;
    };
    plugins.treesitter = {
      enable = true;
      settings.highlight.enable = true;
    };
  };
}
