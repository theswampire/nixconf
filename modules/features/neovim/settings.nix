{
  perSystem.nvfModules = [
    {
      config.vim = {
        # automatically adjust shiftwidth and expandtab
        utility.sleuth.enable = true;
        utility.smart-paste-nvim.enable = true;

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
        };
        globals = {
          mapleader = " ";
          maplocalleader = " ";
          have_nerd_font = true;
        };
        clipboard = {
          providers.wl-copy.enable = true;
        };

        opts = {
          relativenumber = true;
          number = true;
          mouse = "a";
          showmode = false;
          wrap = false;

          scrolloff = 8;
          guicursor = "";

          tabstop = 4;
          softtabstop = 4;
          shiftwidth = 4;
          expandtab = true;
          smartindent = false;
          cindent = false;
          autoindent = true;

          signcolumn = "yes";

          updatetime = 250;
          timeoutlen = 300;

          inccommand = "split";
          # case insensitive unless \C or capital in search
          ignorecase = true;
          smartcase = true;

          # Set completeopt to have a better completion experience
          completeopt = "menuone,noselect";
        };
      };
    }
  ];
}
