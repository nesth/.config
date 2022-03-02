self : super:

let
  callPackage = self.callPackage;
  fetchpatch = self.fetchpatch;
  mkIf = self.lib.mkIf;
  libsForQt5 = self.libsForQt5;
  optional = self.lib.optional;
  atLeast = self.lib.versionAtLeast self.lib.nixpkgsVersion;
  olderThan = with self; lib.versionOlder (if lib ? version then lib.version else lib.nixpkgsVersion);

  inherit (self) kernelPatches linuxPackagesFor;
in
{
  tfenv = self.callPackage ../packages/tfenv.nix {};
}
