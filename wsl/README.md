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

## Localhost Forwarding

If you want to use localhost forwarding, you can it by the following commands on a terminal launched as admin:

```ps1
. \path\to\wsl-forwarding.ps1
wsl-forwarding
```

**See:** ../powershell/README.md
