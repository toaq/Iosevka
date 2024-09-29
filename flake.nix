{
  inputs = {
    ttfautohint.url = github:toaq/ttfautohint;
  };

  outputs = { self, nixpkgs, flake-utils, ttfautohint, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in rec {
        devShells.default = pkgs.mkShellNoCC {
          inherit (defaultPackage) nativeBuildInputs;
        };
        defaultPackage = pkgs.buildNpmPackage {
          name = "iosevka-toaq";
          src = self;
          nativeBuildInputs = [ pkgs.nodejs_latest ttfautohint.defaultPackage.${system} ];
          npmDepsHash = "sha256-xw0GA1aIA/J5hfLQBSE+GJzXfbfWQI2k2pYdenlM9NY=";
          buildPhase = ''
            npm run build -- contents::IosevkaToaq contents::IosevkaToaqSlab contents::IosevkaToaqAile contents::IosevkaToaqEtoile
          '';
          installPhase = ''
            mkdir -p $out/share/fonts/{truetype,woff2}
            mv dist/*/TTF/*.ttf $out/share/fonts/truetype
            mv dist/*/WOFF2/*.woff2 $out/share/fonts/woff2
          '';
        };
      });
}
