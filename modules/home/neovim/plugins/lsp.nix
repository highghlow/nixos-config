{...}:

{
  programs.nixvim.plugins.lsp = {
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
      omnisharp.enable = true;
      nixd.enable = true;
    };
  };
}
