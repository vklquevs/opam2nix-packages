world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      fieldslib = opamSelection.fieldslib;
      ocaml = opamSelection.ocaml;
      ocamlbuild = opamSelection.ocamlbuild;
      ocamlfind = opamSelection.ocamlfind;
      ppx_assert = opamSelection.ppx_assert;
      ppx_compare = opamSelection.ppx_compare;
      ppx_core = opamSelection.ppx_core;
      ppx_custom_printf = opamSelection.ppx_custom_printf;
      ppx_driver = opamSelection.ppx_driver;
      ppx_fields_conv = opamSelection.ppx_fields_conv;
      ppx_inline_test = opamSelection.ppx_inline_test;
      ppx_sexp_conv = opamSelection.ppx_sexp_conv;
      ppx_sexp_value = opamSelection.ppx_sexp_value;
      ppx_tools = opamSelection.ppx_tools;
      ppx_variants_conv = opamSelection.ppx_variants_conv;
      re = opamSelection.re;
      sexplib = opamSelection.sexplib;
      variantslib = opamSelection.variantslib;
    };
    opamSelection = world.opamSelection;
    pkgs = world.pkgs;
in
pkgs.stdenv.mkDerivation 
{
  buildInputs = inputs;
  buildPhase = "${opam2nix}/bin/opam2nix invoke build";
  configurePhase = "true";
  installPhase = "${opam2nix}/bin/opam2nix invoke install";
  name = "ppx_expect-113.24.00";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "ppx_expect";
    ocaml-version = world.ocamlVersion;
    spec = ./opam;
  };
  passthru = 
  {
    opamSelection = opamSelection;
  };
  propagatedBuildInputs = inputs;
  src = fetchurl 
  {
    sha256 = "1n9skx1y0x2nkxkbafihx6v553gmv6m93arlsg069nhr0b3vfsn0";
    url = "https://ocaml.janestreet.com/ocaml-core/113.24/files/ppx_expect-113.24.00.tar.gz";
  };
}

