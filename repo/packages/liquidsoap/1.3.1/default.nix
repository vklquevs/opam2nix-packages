world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      aacplus = opamSelection.aacplus or null;
      alsa = opamSelection.alsa or null;
      ao = opamSelection.ao or null;
      bjack = opamSelection.bjack or null;
      camomile = opamSelection.camomile;
      cry = opamSelection.cry or null;
      dssi = opamSelection.dssi or null;
      dtools = opamSelection.dtools;
      duppy = opamSelection.duppy;
      faad = opamSelection.faad or null;
      fdkaac = opamSelection.fdkaac or null;
      ffmpeg = opamSelection.ffmpeg or null;
      flac = opamSelection.flac or null;
      frei0r = opamSelection.frei0r or null;
      gavl = opamSelection.gavl or null;
      inotify = opamSelection.inotify or null;
      ladspa = opamSelection.ladspa or null;
      lame = opamSelection.lame or null;
      lastfm = opamSelection.lastfm or null;
      lo = opamSelection.lo or null;
      mad = opamSelection.mad or null;
      magic = opamSelection.magic or null;
      mm = opamSelection.mm;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind;
      ogg = opamSelection.ogg or null;
      opus = opamSelection.opus or null;
      pcre = opamSelection.pcre;
      portaudio = opamSelection.portaudio or null;
      pulseaudio = opamSelection.pulseaudio or null;
      samplerate = opamSelection.samplerate or null;
      schroedinger = opamSelection.schroedinger or null;
      soundtouch = opamSelection.soundtouch or null;
      speex = opamSelection.speex or null;
      ssl = opamSelection.ssl or null;
      taglib = opamSelection.taglib or null;
      theora = opamSelection.theora or null;
      voaacenc = opamSelection.voaacenc or null;
      vorbis = opamSelection.vorbis or null;
      xmlplaylist = opamSelection.xmlplaylist or null;
      yojson = opamSelection.yojson or null;
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
  name = "liquidsoap-1.3.1";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "liquidsoap";
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
    sha256 = "19qsslm0nhfq9g9dx14a90825g1vvqpn5ss1plqrfl17fzrdw4nw";
    url = "https://github.com/savonet/liquidsoap/releases/download/1.3.1/liquidsoap-1.3.1.tar.bz2";
  };
}

