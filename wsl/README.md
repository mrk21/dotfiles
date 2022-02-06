# wsl

## Setup

### WSL config

```powershell
New-Item -ItemType SymbolicLink -Target "$((Convert-Path .) + '\wslconfig.ini')" -Path $($HOME + "\.wslconfig")
```

### PowerShell config

```ps1
Test-Path $profile

# If `$profile` path not exist, enter commands listed below:
New-Item -path $profile -type file -force

code $profile
```

**profile.ps1:**

```ps1
. "\path\to\dotfiles\wsl\wsl-forwarding.ps1"
```

## Localhost Forwarding

If you want to use localhost forwarding, you can it by the following commands on a terminal launched as admin:

```ps1
wsl-forwarding
```
