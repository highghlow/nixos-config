{ pkgs, ... }:

{
  programs.nixvim = {
    extraConfigLua = ''
      require('outline').setup({
        keymaps = {
          fold = "C-S-M-n";
          unfold = "C-S-M-n";
          down_and_jump = "C-S-M-n";
          up_and_jump = "C-S-M-n";
        }
      })
    '';
    extraPlugins = [
      pkgs.vimPlugins.outline-nvim
    ];
  };
}
