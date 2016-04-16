world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([ (pkgs.binutils or null) (pkgs.binutils-dev or null)
        (pkgs.boost or null) (pkgs."clang-3.6" or null)
        (pkgs."dev-libs/boost" or null) (pkgs.libboost-dev or null)
        (pkgs."libclang-3.6-dev" or null) (pkgs."llvm-3.6-dev" or null)
        (pkgs."sys-devel/binutils" or null) ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      ANSITerminal = opamSelection.ANSITerminal;
      base-unix = opamSelection.base-unix;
      batteries = opamSelection.batteries;
      camlp4 = opamSelection.camlp4;
      deriving = opamSelection.deriving;
      dolog = opamSelection.dolog;
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
  createFindlibDestdir = true;
  installPhase = "${opam2nix}/bin/opam2nix invoke install";
  name = "clangml-3.6.0.2";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = ./files;
    name = "clangml";
    ocaml-version = world.ocamlVersion;
    spec = ./opam;
  };
  passthru = 
  {
    opamSelection = opamSelection;
  };
  postUnpack = "cp -r ${./files}/* \"$sourceRoot/\"";
  propagatedBuildInputs = inputs;
  src = fetchurl 
  {
    sha256 = "156rmqklxsvgcc9anarh3zv967xn00r8v7fkrzhlpqgbv507y2i6";
    url = "https://github.com/Antique-team/clangml/archive/v3.6.0.2.tar.gz";
  };
}
