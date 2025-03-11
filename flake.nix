{
  description = "Coc.nvim nixpkgs overlay.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pluginFiles = builtins.attrNames (builtins.readDir ./plugins);
        pluginNames = builtins.filter (name: builtins.match ".*\.nix" name != null) pluginFiles;

        overlay = final: prev: {
          cocPlugins = builtins.listToAttrs (map
            (name:
              {
                name = builtins.replaceStrings [ ".nix" ] [ "" ] name;
                value = prev.callPackage (./. + "/plugins/${name}") { };
              }
            )
            pluginNames);
        };

        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in
      {
        overlays.default = overlay;
        packages = builtins.listToAttrs (map
          (name:
            {
              name = builtins.replaceStrings [ ".nix" ] [ "" ] name;
              value = pkgs.cocPlugins.${builtins.replaceStrings [ ".nix" ] [ "" ] name};
            }
          )
          pluginNames);
      }
    );
}
