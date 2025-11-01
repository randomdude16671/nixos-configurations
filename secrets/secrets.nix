let
  publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINsVPVSAU0j0UOqczlJ8uEPPAudy/oBr7i4HoWP87qxB ghost@hydra";
in
{
  "japan.nmconnection.age".publicKeys = [ publicKey ];
}
