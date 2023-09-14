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
          version = "0.1.0";
          src = pkgs.fetchFromGitHub {
            owner = "xenserver";
            repo = "ack-results-parser";
            rev = "ccb4a556b241a95c8a498738b2fcb62a8471151e";
            hash = "sha256-NQvzdXgRpoMNWQGzOI7svoRBHuRBX1kVC39u6yvLAwU=";
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
