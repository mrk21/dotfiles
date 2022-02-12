# PowerShell

## Setup

### Profile

```powershell
# Check whether exists the profile file
Test-Path $profile

# Create the profile file if it does not exist
New-Item -path $profile -type file -force

# Edit the profile file
code $profile
```

```powershell
. "\path\to\dotfiles\powershell\profile.ps1"
```

### gsudo

```powershell
winget install gerardog.gsudo
```

- [gerardog/gsudo](https://github.com/gerardog/gsudo)
