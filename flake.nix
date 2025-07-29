{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mach-nix.url = "github:DavHau/mach-nix/7e14360bde07dcae32e5e24f366c83272f52923f";
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, mach-nix, ... }:
  let

    system  = "x86_64-linux";

    overlay = import ./overlay;

    pkgs = import nixpkgs {
      inherit system;
      overlays = [ overlay ];
      config = { allowUnfree = true; };
    };

    mach = import mach-nix { inherit pkgs; };

    pyEnv = mach.mkPython {
      python = pkgs.python311;
      requirements = ''
        numpy==1.26.4
        pandas==1.5.3
        scikit-learn==1.4.0
        lightgbm==4.6.0
        tflite-runtime==2.14.0
        lambda-multiprocessing==0.5
      '';
    };

  in {

    nixosConfigurations = {

      turing = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        modules = [
          home-manager.nixosModules.home-manager
          nixos-wsl.nixosModules.wsl
          ./configuration.nix
        ];
      };

    };

    devShells.${system}.default = pkgs.mkShell {
      packages = [ pyEnv ];
    };

  };
}
