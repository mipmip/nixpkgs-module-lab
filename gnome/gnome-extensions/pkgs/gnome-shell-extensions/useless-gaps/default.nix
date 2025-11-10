{
stdenv,
lib,
fetchFromGitHub,
glib, gettext,
sassc, gnome-shell,
unzip
}:

let
  extensionUuid = "${extensionName}@pimsnel.com";
  extensionName = "useless-gaps";
in
  stdenv.mkDerivation rec {
    pname = "gnome-shell-extension-${extensionName}";
    version = "9";

    meta = with lib; {
      description = "For aesthetic purposes adds useless gaps around tiled and maximized windows.";
      longDescription = "";
      homepage = "https://github.com/mipmip/gnome-shell-extensions-useless-gaps";
      license = licenses.gpl2Plus;
      maintainers = with maintainers; [ mipmip ];
    };

    src = fetchFromGitHub {
      owner = "mipmip";
      #      owner = "flaxrora";
      repo = "gnome-shell-extensions-useless-gaps";
      rev = "main";
      sha256 = "sha256-B8rrHP9/zyq+KWr1wkUsVjcbIatT6AGeSgo7/3DFP1Y=";
    };

    nativeBuildInputs = [
      glib
      gettext
      sassc
      gnome-shell
      unzip
    ];

    buildPhase = ''
      bash ./install.sh zip
      unzip ${extensionName}@pimsnel.com.shell-extension.zip -d build
      #cd build
      glib-compile-schemas --targetdir=build/schemas build/schemas
      #cd ..
      '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/gnome-shell/extensions/
      cp -r -T build $out/share/gnome-shell/extensions/${extensionUuid}
      runHook postInstall
      '';

    makeFlags = [
      "INSTALLBASE=${placeholder "out"}/share/gnome-shell/extensions"
    ];
    passthru = {
      extensionUuid = "${extensionUuid}";
      extensionPortalSlug = "${extensionName}";
    };
  }
