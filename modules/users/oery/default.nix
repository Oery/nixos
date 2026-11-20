# The oery account: identity plus what should follow it to every machine.
# Desktop-only config comes from the features included by the workstation role.
{ den, ... }:
{
  den.aspects.oery = {
    includes = [
      den.aspects.user.shell
      den.aspects.user.cli-tools
      den.aspects.user.packages
    ];

    nixos.users.users.oery.extraGroups = [
      "video"
      "networkmanager"
      "render"
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.vim ];
      };
  };
}
