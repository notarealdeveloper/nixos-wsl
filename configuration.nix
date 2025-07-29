# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    download-buffer-size = 64*(1024*1024);
  };

  imports = [ ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  nixpkgs.config.allowUnfree = true;

  # system
  environment.systemPackages =
  
    let

      python = pkgs.python313;

    in

    with pkgs; [

    # nix
    nix-bash-completions
    nix-prefetch-github
    home-manager
    dconf2nix

    # unix
    vim_configurable
    file
    wget
    tree
    plocate
    git
    gh
    jq

    # silly
    cowsay
    xcowsay
    asciiquarium
    cmatrix
    figlet
    toilet
    sl
    sl2

    # dev
    gcc
    gnumake
    adbfs-rootless
    lean4

    # debugging
    gdb
    strace
    ltrace
    patchelf
    inotify-tools

    # mid-level
    xclip
    xdotool
    imagemagick

    # crypt
    tor
    torsocks
    tor-browser

    # desktop
    nemo
    conky
    eog
    meld
    gedit
    evince
    google-chrome
    gnome-terminal
    numix-gtk-theme
    numix-icon-theme-circle
    vscode
    obsidian

    # video
    vlc
    ffmpeg
    kdePackages.kdenlive
    simplescreenrecorder

    # net
    dropbox
    openvpn3
    openssh

    # social
    wechat
    whatsapp-for-linux
    teams-for-linux

    # games
    stepmania

    # raw derivations
    sayhi   # stdenv.mkDerivation, depends on hi
    saybye  # builtins.derivation, depends on raw bye

    /* THE IMPORT VS EXEC ISSUE */

    yello

    (python.withPackages (ps: with ps; [

      # packaging
      pip
      setuptools
      build
      twine
      pytest

      # basics
      ipython
      requests

      # net
      beautifulsoup4
      yt-dlp

      # numerical
      numpy
      scipy
      pandas
      scikit-learn
      matplotlib
      seaborn
      torch

      # ~/bin depends
      google-auth-oauthlib      # gmail
      google-api-python-client  # getbtcprice
      geoip2                    # getbtcprice

      # overlay
      is_instance
      embd
      wnix
      jello

    ]))

    python314FreeThreading

    # So close!
    # python-head

    python311

    #(import ./python311.nix pkgs)

  ];

  system.stateVersion = "24.11";
}
