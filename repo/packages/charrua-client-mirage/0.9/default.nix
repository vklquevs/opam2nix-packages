world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      charrua-client = opamSelection.charrua-client;
      charrua-client-lwt = opamSelection.charrua-client-lwt;
      charrua-core = opamSelection.charrua-core;
      cstruct = opamSelection.cstruct;
      duration = opamSelection.duration;
      fmt = opamSelection.fmt;
      ipaddr = opamSelection.ipaddr;
      jbuilder = opamSelection.jbuilder;
      logs = opamSelection.logs;
      lwt = opamSelection.lwt;
      mirage-random = opamSelection.mirage-random;
      mirage-types-lwt = opamSelection.mirage-types-lwt;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      rresult = opamSelection.rresult;
      tcpip = opamSelection.tcpip;
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
  name = "charrua-client-mirage-0.9";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "charrua-client-mirage";
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
    sha256 = "0m6l4zjipar4n1p6ap4hp7rrmqg0mxfbp9b49h6fn55wcvkr6fy7";
    url = "https://github.com/mirage/charrua-core/releases/download/v0.9/charrua-core-0.9.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}

