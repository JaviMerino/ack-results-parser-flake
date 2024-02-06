{
  description = "auto cert kit flake";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem(system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.default = let
        python-hwinfo = pkgs.python3Packages.buildPythonPackage rec {
          pname = "python-hwinfo";
          version = "0.1.7";
          # fetchPypi can't be used because pypi is behind the original package https://github.com/rdobson/python-hwinfo . This in turn can't be used because it does not have python3 support.  https://github.com/rdobson/python-hwinfo/pull/25 adds support for python3
          src = pkgs.fetchFromGitHub {
            owner = "alexhimmel";
            repo = "rob-python-hwinfo";
            rev = "private/tianxia/CP-41972";
            hash = "sha256-uyaKBtM4f86hu7Ep4NxWf06l3ZeoL3oZAjvErinoLbM=";
          };
          propagatedBuildInputs = with pkgs.python3Packages; [
            paramiko
            prettytable
          ];
        };
      in
        pkgs.python3Packages.buildPythonPackage {
          pname = "ack-results-parser";
          # Upstream does not do versions
          version = "0.1.0-a09a9024e19e";
          # Temporarily get my python3 conversion branch
          src = pkgs.fetchFromGitHub {
            owner = "JaviMerino";
            repo = "ack-results-parser";
            rev = "a09a9024e19e46eff8d9a35941bdc7a984a3e501";
            hash = "sha256-CpcKhyvbDSkr6ZV/qtUNeiHBSFKKYqt2prCDZ+eMTik=";
          };
          # nose tests have not been converted to python3
          doCheck=false;
          propagatedBuildInputs = with pkgs.python3Packages; [
            jira
            pymongo
            python-hwinfo
          ];
        };
    });
}
