{ pkgs, fetchurl, ... }:
pkgs.vimUtils.buildVimPlugin rec {
  pname = "coc-ocaml";
  version = "0.1.0";
  src = fetchurl {
    url = "https://registry.npmjs.org/@ph_chen/${pname}/-/${pname}-${version}.tgz";
    sha256 = "sha256-zMgADScfRKhFButbb4LJfL1qBV0yvDhs95QrMW1PRkU=";
  };

  buildInputs = [ pkgs.ocaml pkgs.opam pkgs.ocamlPackages.ocamlformat ];

  meta = with pkgs.lib; {
    description = "Simple ocaml language service for coc.nvim";
    homepage = "https://github.com/PHSix/coc-ocaml";
    license = licenses.mit;
  };
}

