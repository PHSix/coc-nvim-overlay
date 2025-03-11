{ pkgs, fetchurl, ... }:
pkgs.vimUtils.buildVimPlugin rec {
  pname = "coc-tsserver";
  version = "2.2.2";
  src = fetchurl {
    url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
    sha256 = "sha256-NfdINNwCpv7j/5OwVpVCoCmPLnC7w5DcTgvCuip0AWw=";
  };

  nativeBuildInputs = [ pkgs.jq ];

  prePatch = ''
    # Modify the tsdk path in package.json
    jq '.contributes.configuration.properties."tsserver.tsdk".default = "${pkgs.typescript}/lib/node_modules/typescript/lib"' package.json > package.json.tmp
    mv package.json.tmp package.json
  '';

  meta = with pkgs.lib; {
    description = "Tsserver extension for coc.nvim that provide rich features like VSCode for javascript & typescript ";
    homepage = "https://github.com/neoclide/coc-tsserver";
    license = licenses.mit;
  };
}

