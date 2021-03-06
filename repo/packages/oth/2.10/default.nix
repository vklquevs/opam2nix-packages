world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      containers = opamSelection.containers;
      duration = opamSelection.duration;
      merlin-of-pds = opamSelection.merlin-of-pds;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind;
      pds = opamSelection.pds;
      revops = opamSelection.revops;
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
  name = "oth-2.10";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "oth";
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
    sha256 = "1i68mfvzn7grlwcm028swfmnk6n01m8xr4g16ys49w61iq5nnh12";
    url = "https://bitbucket.org/mimirops/oth/get/2.10.tar.gz";
  };
}

