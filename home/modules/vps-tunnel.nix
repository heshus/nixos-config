{ pkgs, secrets, ... }:
{
  systemd.user.services.vps-tunnel = {
    Unit.Description = "SSH tunnel to VPS Syncthing";
    Unit.After = [ "network-online.target" ];
    Service = {
      ExecStartPre = "${pkgs.runtimeShell} -c 'test -f %h/.ssh/vps_tunnel || ${pkgs.openssh}/bin/ssh-keygen -q -t ed25519 -f %h/.ssh/vps_tunnel -N \"\" -C vps-tunnel'";
      ExecStart = "${pkgs.openssh}/bin/ssh -i %h/.ssh/vps_tunnel -o IdentitiesOnly=yes -o StrictHostKeyChecking=accept-new -NL 8385:localhost:8384 ${secrets.vpsHost}";
      Restart = "always";
      RestartSec = 10;
    };
    Install.WantedBy = [ "default.target" ];
  };
}
