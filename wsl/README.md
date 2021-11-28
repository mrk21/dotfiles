# wsl

## Setup

### On Windows

```powershell
New-Item -ItemType SymbolicLink -Target "$((Convert-Path .) + '\wslconfig.ini')" -Path $($HOME + "\.wslconfig")
```

### On WSL

```sh
mkdir -p ~/bin
cp ./bin/google-chrome ~/bin/google-chrome
```
