# nixos-config

Личный конфиг NixOS (flake + Home Manager) для двух машин:
`nixos-desktop` (NVIDIA) и `nixos-laptop` (AMD).
Hyprland + Noctalia, foot, zsh, Neovim (nixvim), Firefox.

## Установка

```bash
git clone <repo> ~/nixos && cd ~/nixos
# на новой машине: nixos-generate-config и положить результат в hosts/<host>/hardware-configuration.nix
sudo nixos-rebuild switch --flake .#nixos-desktop   # или .#nixos-laptop
```

Дальше обновление через алиасы: `rebuild` и `update`.

Репозиторий должен лежать в `~/nixos` (путь используется в `modules/nix.nix`).
