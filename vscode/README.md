# VSCode

## Setup

### Mac

```bash
ln -s $(pwd)/config ~/Library/Application\ Support/Code/User
```

### Win

```powershell
New-Item -ItemType SymbolicLink -Target "$((Convert-Path .) + '\config')" -Path $($env:APPDATA + "\Code\User")
```

## Plugins

- VSCodeVim
- VimL
- ruby-symbols
