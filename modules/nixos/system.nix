{ config, conf, pkgs, lib, ... }:

{
  system.stateVersion = "22.11";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
    };
  };

  networking = {
    hostName = conf.host.name;
    networkmanager.enable = true;
  };

  time.timeZone = "America/Chicago";

  users.users.${conf.user.name} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "adbusers" ];
    uid = 1000;
    openssh.authorizedKeys.keys = conf.user.authorizedKeys or [];
    # TODO: Move to agenix for more security
    hashedPassword = "$6$CdlIUcX0jg2SP1F9$R9QlckBEFHN6lDVhopf.ly4MBTxFC1ISaWMkDppbg5PJoICO8brE8ggw8Hf9byBrMAIP4tIF0jCM7zsqL1HQv/";
  };

  virtualisation = {
    vmware.guest.enable = true;
  };
}
