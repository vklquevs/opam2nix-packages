world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      dns = opamSelection.dns;
      jbuilder = opamSelection.jbuilder;
      lwt = opamSelection.lwt;
      mirage-profile = opamSelection.mirage-profile;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
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
  name = "dns-lwt-1.0.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "dns-lwt";
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
    sha256 = "0f1car8fb3zqc7zm69qdmpbd6g7iy24f58sg84g3a0lyygihqgb0";
    url = "https://github.com/mirage/ocaml-dns/releases/download/v1.0.0/dns-1.0.0.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}

