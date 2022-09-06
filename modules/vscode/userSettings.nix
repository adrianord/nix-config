{ ... }:

{
  home._.programs.vscode.userSettings = {
    editor = {
      renderWhitespace = "all";
      wordWrap = "off";
      minimap.enabled = false;
      bracketPairColorization.enabled = false;
      lineNumbers = "relative";
      formatOnSave = false;
      formatOnPaste = false;
      insertSpaces = true;
      inlineSuggest.enabled = true;
      experimental = {
        stikeyScroll.enabled = true;
      };
    };
    explorer = {
      openEditors.visible = 0;
    };
    workbench = {
      sideBar.location = "right";
      editor.enablePreview = false;
      activityBar.visible = true;
      settings.editor = "json";
      startupEditor = "newUntitleFile";
    };
    terminal = {
      copyOnSelection = false;
      integrated.scrollback = 1000000000;
    };
    files = {
      trimTailingWhitespace = true;
      insertFinalNewLine = true;
    };
  };
}
