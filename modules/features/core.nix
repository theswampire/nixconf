{ self, inputs, ... }: {
  flake.nixosModules.core =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      # Nix
      nixpkgs.config.allowUnfree = true;
      nix.settings.substituters = [
        "https://nix-community.cachix.org"
        "https://theswampire.cachix.org"
        "https://devenv.cachix.org"
      ];
      nix.settings.trusted-public-keys = [
        # Compare to the key published at https://nix-community.org/cache
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "theswampire.cachix.org-1:c3w4LLvOQ+s8RJWXI7srUfIN6Tzdx9wgZOTI8NxOolU="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];

      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
        flake = "$HOME/projects/nixos";
      };

      # Terminal
      # See myZsh below for tmux autostart option
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        setOptions = [ "AUTO_CD" ];
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        histSize = 10000;
        interactiveShellInit = ''
          # Autocomplete parent dirs
          zstyle ':completion:*' special-dirs true
        '';
      };
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
        flags = [ "--cmd cd" ];
      };
      programs.tmux = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myTmux;
      };
      environment.systemPackages = with pkgs; [ btop ];

      # Localization
      time.timeZone = "Europe/Zurich";
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "de_CH.UTF-8";
        LC_IDENTIFICATION = "de_CH.UTF-8";
        LC_MEASUREMENT = "de_CH.UTF-8";
        LC_MONETARY = "de_CH.UTF-8";
        LC_NAME = "de_CH.UTF-8";
        LC_NUMERIC = "de_CH.UTF-8";
        LC_PAPER = "de_CH.UTF-8";
        LC_TELEPHONE = "de_CH.UTF-8";
        LC_TIME = "de_CH.UTF-8";
      };
      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "ch";
        variant = "";
      };
      # Configure console keymap
      console.keyMap = "sg";

    };

  flake.nixosModules.myZsh = { lib, config, ... }: {
    # Start Tmux Config
    options.myZsh.startTmux = lib.mkEnableOption "automatically start tmux in zsh";
    config = lib.mkIf config.myZsh.startTmux {
      programs.zsh.interactiveShellInit = ''
        # Start tmux
        if command -v tmux &> /dev/null && [[ -z "$TMUX" ]] && [[ -z "$NO_TMUX" ]]
        then
          exec tmux new-session -c "$PWD"
        fi
      '';
    };

  };

  perSystem =
    { pkgs, ... }:
    {

      packages.myTmux = inputs.wrapper-modules.wrappers.tmux.wrap {
        inherit pkgs;
        shell = "${pkgs.zsh}/bin/zsh";
        terminal = "tmux-256color";
        prefix = "M-w";
        historyLimit = 10000;
        modeKeys = "vi";
        vimVisualKeys = true;
        allowPassthrough = true;
        plugins = with pkgs; [
          tmuxPlugins.sensible
          tmuxPlugins.yank
          {
            plugin = tmuxPlugins.catppuccin;
            configAfter = ''
              set -g @catppuccin_flavor "mocha"
              set -g @catppuccin_window_status_style "basic"

              # Make the status line pretty and add some modules
              set -g status-right-length 100
              set -g status-left-length 100
              set -g status-left ""
              set -g status-right "#{E:@catppuccin_status_application}"
              set -agF status-right "#{E:@catppuccin_status_cpu}"
              set -ag status-right "#{E:@catppuccin_status_session}"
              set -ag status-right "#{E:@catppuccin_status_uptime}"
              set -agF status-right "#{E:@catppuccin_status_battery}"
            '';
          }
        ];
        configAfter = ''
          # Set true color
          set-option -sa terminal-overrides ",xterm*:Tc"

          # navigation
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R

          # vi visual select
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

          # open panes in current directory
          bind '"' split-window -v -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"
          bind c new-window -c "#{pane_current_path}"
        '';
      };
    };
}
