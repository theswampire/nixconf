{ self, inputs, ... }: {

  flake.nixosModules.desktop = { pkgs, ... }: {
    imports = [ self.nixosModules.myZsh ];

    # Autostart Tmux in shell
    myZsh.startTmux = true;

    environment.systemPackages = with pkgs; [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myGhostty
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight-official

      git
      wl-clipboard

      # for drag&drop in yazi
      dragon-drop

      mpv
    ];

    # wifi login portal dedicated browser
    programs.captive-browser = {
      enable = true;
      interface = "wlo1";
    };

    # Yazi Filebrowser
    programs.yazi = {
      enable = true;
      settings = {
        yazi = {
          opener = {
            orphan_open = [
              {
                run = ''xdg-open "$@"'';
                desc = "Open Orphaned";
                orphan = true;
              }
            ];
          };
          open = {
            prepend_rules = [
              {
                url = "*.pdf";
                use = "orphan_open";
              }
            ];
          };
        };
        keymap = {
          mgr = {
            prepend_keymap = [
              {
                on = [ "<C-n>" ];
                run = "shell -- dragon-drop -x -i -T %h";
                desc = "c-n drag drop";
              }
            ];
          };
        };

      };
    };
  };

  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.myGhostty = inputs.wrapper-modules.wrappers.ghostty.wrap {
        inherit pkgs;
        env.GTK_IM_MODULE = "simple";

        settings = {
          theme = "Catppuccin Mocha";
          keybind = [
            "ctrl+.=increase_font_size:1"
          ];
        };
      };
    };
}
