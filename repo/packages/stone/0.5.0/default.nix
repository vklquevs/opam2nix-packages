world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      config-file = opamSelection.config-file;
      cow = opamSelection.cow;
      crunch = opamSelection.crunch;
      inotify = opamSelection.inotify;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind;
      omd = opamSelection.omd;
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
  name = "stone-0.5.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "stone";
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
    sha256 = "19kkmasv0g4pg8pylr2aa4dc6jcdv7b08mamsj2fc5c5znzi5nni";
    url = "https://github.com/Armael/stone/archive/v0.5.0.tar.gz";
  };
}

