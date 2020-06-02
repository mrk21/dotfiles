# Windows Terminal

## Setup

```powershell
New-Item -ItemType SymbolicLink -Target "$((Convert-Path .) + '\config')" -Path $($env:LOCALAPPDATA + "\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState")
```