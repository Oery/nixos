{
  lib,
  stdenvNoCC,
  fetchFromBitbucket,
}:

stdenvNoCC.mkDerivation {
  pname = "yamis";
  version = "unstable-2026-08-30";

  src = fetchFromBitbucket {
    owner = "dirn-typo";
    repo = "yet-another-monochrome-icon-set";
    rev = "284b316c0034605dfa5eb8db6db9833e33740f27";
    hash = "sha256-7CN5G8nYZM9qxFMRyWDIlJC0SjN7SnLQ5RUVaP1y0hc=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -d "$out/share/icons/yet-another-monochrome-icon-set"
    cp -r ./. "$out/share/icons/yet-another-monochrome-icon-set/"

    runHook postInstall
  '';

  meta = {
    description = "Adaptive monochrome icon theme for KDE Plasma";
    homepage = "https://bitbucket.org/dirn-typo/yet-another-monochrome-icon-set";
    license = lib.licenses.gpl3Only;
    maintainers = [ ];
    platforms = lib.platforms.unix;
  };
}
