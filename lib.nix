{pkgs}: {
  mkTydraMenu = menu@{...}: ((pkgs.formats.yaml {}).generate "menu.yaml" menu);
} 