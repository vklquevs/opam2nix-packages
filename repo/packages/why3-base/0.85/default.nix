world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      camlzip = opamSelection.camlzip or null;
      conf-gtksourceview = opamSelection.conf-gtksourceview or null;
      coq = opamSelection.coq or null;
      lablgtk = opamSelection.lablgtk or null;
      num = opamSelection.num;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind;
      ocamlgraph = opamSelection.ocamlgraph or null;
      zarith = opamSelection.zarith or null;
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
  name = "why3-base-0.85";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "why3-base";
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
    sha256 = "0sj1pd50lqvnvyss1f8ysgigdi64s91rrpdrmp7crmcy1npa8apf";
    url = "https://gforge.inria.fr/frs/download.php/file/34074/why3-0.85.tar.gz";
  };
}

