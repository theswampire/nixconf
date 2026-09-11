{
  perSystem = { lib, ... }: {
    nvfModules = [
      {
        config.vim.filetree.neo-tree = {
          enable = true;
          setupOpts = {
            filesystem.hijack_netrw_behavior = "disabled";
            filesystem.follow_current_file.enabled = "disabled";
            event_handlers = [
              {
                event = "file_opened";
                handler = lib.mkLuaInline ''
                  function(file_path)
                    -- auto close
                    -- vimc.cmd("Neotree close")
                    -- OR
                    require('neo-tree.command').execute { action = 'close' }
                  end
                '';
              }
            ];
          };
        };
        config.vim.keymaps = [
          {
            key = "<leader>e";
            action = "<cmd>Neotree toggle<cr>";
            mode = [
              "n"
              "v"
              "c"
            ];
            desc = "Toggle Filetree";
          }
        ];
      }
    ];
  };
}
