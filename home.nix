{ config, pkgs, nixgl, ... }:

let wGL = config.lib.nixGL.wrap; mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink; 
in rec {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "arijit";
  home.homeDirectory = "/home/arijit";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.pnpm
    pkgs.typst
    pkgs.scc
    # pkgs.flutter
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = let
    removePrefix = pkgs.lib.strings.removePrefix;
    home-manager-dir = "${home.homeDirectory}/.config/home-manager";
  in {
    ".config/alacritty".source = ./.config/alacritty;
    ".config/dunst".source = ./.config/dunst;
    ".config/eww".source = ./.config/eww;
    ".config/fish".source = ./.config/fish;
    ".config/hypr".source = ./.config/hypr;
    ".config/kitty".source = ./.config/kitty;
    ".config/nvim".source = mkOutOfStoreSymlink home-manager-dir + "/.config/nvim";
    ".config/waybar".source = ./.config/waybar;
    ".config/wezterm".source = mkOutOfStoreSymlink home-manager-dir + "/.config/wezterm";
    ".config/wlogout".source = ./.config/wlogout;
    ".config/wofi".source = ./.config/wofi;
    ".config/zed".source = mkOutOfStoreSymlink home-manager-dir + "/.config/zed";
    ".config/zellij".source = ./.config/zellij;
    ".config/starship.toml".source = ./.config/starship.toml;
    ".zshenv".source = mkOutOfStoreSymlink home-manager-dir + "/.zshenv";
    ".zshrc".source = mkOutOfStoreSymlink home-manager-dir + "/.zshrc";
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/arijit/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  nixGL = {
    packages = nixgl.packages.x86_64-linux;
    defaultWrapper = "mesa";
    offloadWrapper = "mesa";
    vulkan.enable = true;
  };

  programs.alacritty = {
    enable = true;
    package = (wGL pkgs.alacritty);
  };
  programs.bun.enable = true;
  programs.distrobox.enable = true;
  programs.go.enable = true;
  programs.lazygit.enable = true;
  programs.starship.enable = true;
  programs.uv.enable = true;
  programs.wezterm = {
    enable = true;
    package = (wGL pkgs.wezterm);
  };
  programs.zed-editor = {
    enable = true;
    package = (wGL pkgs.zed-editor-fhs);
  };
  programs.zellij.enable = true;
  programs.zoxide.enable = true;
  services.podman.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
