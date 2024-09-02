{...}:

{
  programs.nixvim = {
    extraConfigLua = ''
      vim.cmd([[cnoreabbrev nt NvimTreeFocus]])
    '';

    plugins.nvim-tree = {
      enable = true;
      hijackUnnamedBufferWhenOpening = true;
      filters = { custom = [ "^.git$" ]; };
      diagnostics = {
        enable = true;
        showOnDirs = true;
        showOnOpenDirs = false;
      };
      git = {
        enable = true;
        showOnDirs = true;
        showOnOpenDirs = false;
        ignore = false;
      };
      updateFocusedFile.enable = true;
      view = {
        float.enable = true;
        centralizeSelection = true;
        cursorline = true;
      };
      onAttach = {__raw = ''
        function(bufnr)
          local api = require "nvim-tree.api"
          api.config.mappings.default_on_attach(bufnr)

          vim.keymap.set('n', '<Esc>', function() 
            local win_amount = #vim.api.nvim_tabpage_list_wins(0)
            if win_amount > 1 then
              return '<Cmd>:q<CR>'
            end
          end, { silent = true, buffer = bufnr, expr = true })
        end
      ''; };
    };
  };
}
