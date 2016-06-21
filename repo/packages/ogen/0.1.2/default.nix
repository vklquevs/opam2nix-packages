world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      batteries = opamSelection.batteries;
      linenoise = opamSelection.linenoise;
      oasis = opamSelection.oasis;
      ocaml = opamSelection.ocaml;
      ocaml-inifiles = opamSelection.ocaml-inifiles;
      ocamlfind = opamSelection.ocamlfind;
      ppx_blob = opamSelection.ppx_blob;
      ppx_deriving = opamSelection.ppx_deriving;
      ppx_deriving_yojson = opamSelection.ppx_deriving_yojson;
      yojson = opamSelection.yojson;
    };
    opamSelection = world.opamSelection;
    pkgs = world.pkgs;
in
pkgs.stdenv.mkDerivation 
{
  buildInputs = inputs;
  buildPhase = "${opam2nix}/bin/opam2nix invoke build";
  configurePhase = "true";
  createFindlibDestdir = true;
  installPhase = "${opam2nix}/bin/opam2nix invoke install";
  name = "ogen-0.1.2";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "ogen";
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
    sha256 = "0icssqc2xs843a19pzhqvwfv7i47y4x40va6aavvb4sihs3gd5wj";
    url = "https://github.com/nv-vn/ogen/archive/v0.1.2.tar.gz";
  };
}

