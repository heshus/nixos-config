{lib, ...}: {
  networking.networkmanager.enable = true;

  programs.amnezia-vpn.enable = true;

  time.timeZone = "Europe/Moscow";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  networking.nameservers = ["8.8.8.8" "1.1.1.1"];

  programs.kdeconnect.enable = true;

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  services.zapret2 = {
    enable = true;

    profiles = {
      https.parameters = [
        "--filter-tcp=443"
        "--payload=tls_client_hello"
        "--lua-desync=fake:blob=fake_default_tls:tcp_md5"
        "--lua-desync=multisplit:pos=1,midsld"
      ];

      quic.parameters = [
        "--filter-udp=443"
        "--filter-l7=quic"
        "--payload=quic_initial"
        "--lua-desync=fake:blob=fake_default_quic:repeats=6"
      ];
    };

    firewall = {
      tcpPorts = [443];
      udpPorts = [443];
      maxPackets = 16;
    };
  };
}
