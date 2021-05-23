# wsl

## Setup

```powershell
New-Item -ItemType SymbolicLink -Target "$((Convert-Path .) + '\wslconfig.ini')" -Path $($HOME + "\.wslconfig")
```
