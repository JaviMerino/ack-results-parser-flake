A flake to make it easy to install
[ack-results-parser](https://github.com/xenserver/ack-results-parser)

# Usage

To test:

```
nix shell github:JaviMerino/ack-results-parser-flake
```

To install, add to your flake inputs:

``` nix
inputs.ackResultsParser = {
  type = "github";
  owner = "JaviMerino";
  repo = "ack-results-parser-flake";
};
```

# Why don't you add this to nixpkgs?
Because I think the intersection of the people that use nix and the
people that use ack-results-parser is a very very small number.
