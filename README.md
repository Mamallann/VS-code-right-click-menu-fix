# VS-code-right-click-menu-fix
This batch script restores the missing “Open with Code” right-click menu in Windows File Explorer for Visual Studio Code (version 1.103), even after the latest updates removed or broke it.

🚀 How It Works
1.Detects your installed Code.exe location.
2.Generates a .reg file with the correct registry keys for the context menu.
3.Shows you the .reg file in Notepad for review.
4.Asks for your confirmation before applying changes via regedit.
5.Restarts Windows Explorer to make the changes take effect immediately.

⚠ Disclaimer
This script edits your Windows Registry. Although the changes are safe and limited to context menu keys, always review the .reg file when prompted before confirming.
