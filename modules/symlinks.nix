{ ... }:

{
  systemd.tmpfiles.rules = [
    "L+ /home/heshus/Documents - - - - /home/heshus/docs/доки"
    "L+ /home/heshus/Pictures - - - - /home/heshus/docs/архив/Изображения"
  ];
}
