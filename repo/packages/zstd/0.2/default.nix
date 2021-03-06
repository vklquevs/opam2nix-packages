world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([ (pkgs.libzstd-dev or null) ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      ctypes = opamSelection.ctypes;
      oasis = opamSelection.oasis;
      ocaml = opamSelection.ocaml;
      ocamlbuild = opamSelection.ocamlbuild;
      ocamlfind = opamSelection.ocamlfind;
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
  name = "zstd-0.2";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "zstd";
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
    sha256 = "1mhkw9674ym0ccyadmq8b2wadi8ha41wwbanzmh2ql860575ikyr";
    url = "http://ygrek.org.ua/p/release/ocaml-zstd/ocaml-zstd-0.2.tar.gz";
  };
}

