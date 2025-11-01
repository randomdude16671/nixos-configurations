# DO NOT COPY THIS FILE, IF YOU'RE LOOKING FOR THE
# REGULAR default.nix TEMPLATE USED FOR ALL THE OTHER MODULE PATHS
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
        fileType == "regular" && lib.hasSuffix ".nix" name && name != "default.nix" && name != "base.nix"
      then
        acc ++ [ fullPath ]
      else
        acc
    ) [ ] (attrNames entries);
in
{
  imports = recursiveNixFiles ./.;
}
