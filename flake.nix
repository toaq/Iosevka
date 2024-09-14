{
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShellNoCC {
          buildInputs = with pkgs; [
            nodejs_latest
            ttfautohint
          ];
        };
      });
}
