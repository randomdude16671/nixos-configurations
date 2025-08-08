# DO NOT COPY THIS FILE, IF YOU'RE LOOKING FOR THE
# REGULAR default.nix TEMPLATE USED FOR ALL THE OTHER MODULE
# PATHS, USE THE home/default.nix AND NOT THIS ONE, THIS ONE
# IS SPECIFIC BECAUSE OF A NEW CONDITION INTRODUCED.
{ lib, ... }:
let
  inherit (builtins) readDir attrNames foldl';

  recursiveNixFiles =
    path:
    let
      entries = readDir path;
    in
    foldl' (
      acc: name:
      let
        fullPath = path + "/${name}";
        fileType = entries.${name};
      in
      if fileType == "directory" then
        acc ++ (recursiveNixFiles fullPath)
      else if
        fileType == "regular"
        && lib.hasSuffix ".nix" name
        && name != "default.nix"
        && name != "configuration.nix"
      then
        acc ++ [ fullPath ]
      else
        acc
    ) [ ] (attrNames entries);
in
{
  imports = recursiveNixFiles ./.;
}
