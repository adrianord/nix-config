self: super:
with self;
let
  extensionsList = [
    {
      name = "theme-monokai-pro-vscode";
      publisher = "monokai";
      version = "1.1.21";
      sha256 = "sha256-ZFIILLY88b25QuJBlAPWIFqbA+c/sxdfaDc1Mbyy/5o=";
    }
  ];

  extensionsListOfSet = map (x: { ${x.publisher}.${x.name} = pkgs.vscode-utils.extensionFromVscodeMarketplace x; }) extensionsList;
  extensionsSet = builtins.foldl' (acc: curr: acc // curr) {} extensionsListOfSet;
in
{
  vscode-extensions = super.vscode-extensions // extensionsSet;
}
