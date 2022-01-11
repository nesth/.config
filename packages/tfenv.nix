{ stdenvNoCC, pkgs, fetchFromGitHub, makeWrapper }:

stdenvNoCC.mkDerivation rec {
    pname = "tfenv";
    version = "master";

    src = fetchFromGitHub {
        owner = "tfutils";
        repo = pname;
        rev = version;
        sha256 = "sha256-xKX+aUIgNbKysxG8S4YPK5LE/1S07v5HN6zqdIbYiMw=";
    };

    dontConfigure = true;
    donBuild = true;

    nativeBuildInputs = [ makeWrapper ];

    installPhase = ''
        mkdir -p $out
        cp -r * $out
    '';

    fixupPhase = ''
        wrapProgram $out/bin/tfenv \
        --run 'export TFENV_CONFIG_DIR="''${TFENV_CONFIG_DIR:-$HOME/.local/tfenv}"' \
        --run 'mkdir -p $TFENV_CONFIG_DIR'
        wrapProgram $out/bin/terraform \
        --run 'export TFENV_CONFIG_DIR="''${TFENV_CONFIG_DIR:-$HOME/.local/tfenv}"' \
        --run 'mkdir -p $TFENV_CONFIG_DIR'
    '';

    meta = with pkgs.lib; {
        description = "Terraform version manager inspired by rbenv";
        homepage = "https://github.com/tfutils/tfenv";
        license = licenses.mit;
        mainterners = "nesth";
    };
}
