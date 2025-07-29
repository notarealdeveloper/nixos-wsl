# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    gh
    cowsay
    xcowsay
    xorg.xeyes
    figlet
    toilet
    lolcat
    cmatrix
    asciiquarium
    gh
    xdg-utils
    google-chrome
    xclip
    sl
    (pkgs.python312.withPackages (import ./python))
  ];

  system.stateVersion = "24.11";
}
