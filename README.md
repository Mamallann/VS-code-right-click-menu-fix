# VS-code-right-click-menu-fix
This batch script restores the missing “Open with Code” right-click menu in Windows File Explorer for Visual Studio Code (version 1.103), even after the latest updates removed or broke it.

✨ Features

Auto-detects VS Code path
Works for both System and User installations.

Cleans up broken entries first
Removes any old/duplicate “Open with Code” menu items.

Preview before applying
Opens the generated .reg file in Notepad so you can verify exactly what registry changes will be made.

Manual confirmation
No registry changes are applied unless you explicitly type y at the prompt.

Covers all cases
Adds context menu entries for:

Folders

Folder background (right-click in empty space)

Any file

📋 Requirements
Windows 10/11

Visual Studio Code installed

Administrator privileges (script auto-prompts for elevation)

🚀 How It Works
Detects your installed Code.exe location.

Generates a .reg file with the correct registry keys for the context menu.

Shows you the .reg file in Notepad for review.

Asks for your confirmation before applying changes via regedit.

Restarts Windows Explorer to make the changes take effect immediately.

⚠ Disclaimer
This script edits your Windows Registry. Although the changes are safe and limited to context menu keys, always review the .reg file when prompted before confirming.
