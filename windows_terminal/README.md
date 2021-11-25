# Windows Terminal

## Setup

```powershell
# for stable
New-Item -ItemType SymbolicLink -Target "$((Convert-Path .) + '\config')" -Path $(Join-Path $(Resolve-Path $($env:LOCALAPPDATA + "\Packages\Microsoft.WindowsTerminal_*")) "LocalState")

# for preview
New-Item -ItemType SymbolicLink -Target "$((Convert-Path .) + '\config')" -Path $(Join-Path $(Resolve-Path $($env:LOCALAPPDATA + "\Packages\Microsoft.WindowsTerminalPreview_*")) "LocalState")
```
