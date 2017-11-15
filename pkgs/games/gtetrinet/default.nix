{ fetchFromGitHub, stdenv
, perl, perlPackages, gnome2, intltool, pkgconfig, autoconf, automake }:

stdenv.mkDerivation {
  name = "gtetrinet-0.7.11";

  src = fetchFromGitHub {
    owner = "GNOME";
    repo = "gtetrinet";
    rev = "6be3df83f3dc5c7cb966e6cd447182df01b93222";
    sha256 = "1y05x8lfyxvkjg6c87cfd0xxmb22c88scx8fq3gah7hjy5i42v93";
  };

  buildInputs = [
    perl
    perlPackages.XMLParser
    intltool
    gnome2.libgnome
    gnome2.libgnomeui
    pkgconfig
    autoconf
    automake
  ];

  propagatedUserEnvPkgs = [ gnome2.GConf ];

  preConfigure = ''
    autoreconf --install --force --verbose
    intltoolize --force
  '';

  postInstall = ''
    mv "$out/games" "$out/bin"
  '';

  meta = {
    description = "Client for Tetrinet, a multiplayer online Tetris game.";
    longDescription = ''
      GTetrinet is a client program for Tetrinet, a multiplayer tetris game
      that is played over the internet.
    '';
    homepage = http://gtetrinet.sourceforge.net/;
    license = stdenv.lib.licenses.gpl2;
    platforms = stdenv.lib.platforms.unix;
    maintainers = [ stdenv.lib.maintainers.chris-martin ];
  };
}
