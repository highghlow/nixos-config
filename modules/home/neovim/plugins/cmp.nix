{...}:

{
  programs.nixvim.plugins.cmp = {
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
}
