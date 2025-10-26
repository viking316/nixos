{config, pkgs, lib, ...}:

{
  programs.vscode = {
    enable = true;

    userSettings = {
      "java.home" = "${pkgs.jdk17}";
    };
  };  
}
