{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.username = "david";
  home.homeDirectory = "/home/david";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
   ripgrep fd jq btop tree htop bashInteractive fzf nushell starship yq-go stdenv.cc nil nixfmt gh direnv
  ];

  home.file.".nanorc".text = ''
  set tabsize 2
  set tabstospaces
  set autoindent
  set linenumbers
  set constantshow
  '';

  programs.bash.enable = true;   # or zsh/fish

  programs.readline = {
    enable = true;
    extraConfig = ''
      set bell-style none
      # arrow up should search stuff starting with the same string
      "\e[A": history-search-backward
      "\e[B": history-search-forward
      # cntrl+left/right arrows should move across words
      "\e[1;5C": forward-word   # ctrl + right
      "\e[1;5D": backward-word  # ctrl + left
    '';
  };

  programs.starship = {
    enableBashIntegration = true;
    enableNushellIntegration = true;
    enable = true;
    settings = {
      line_break = {
        disabled = true;
      };
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "david";
      user.email = "david.moedinger@ketzu.net";
      push.autoSetupRemote = true;
    };
    ignores = [
      "result"
      ".idea"
      "*~"
      "*.swp"
    ];
  };
}
