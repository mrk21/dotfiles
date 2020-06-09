# Hyper

Terminal app

## Setup

Download from [Release 2.1.2-fixed · mrk21/hyper](https://github.com/mrk21/hyper/releases/tag/2.1.2-fixed)

```powershell
New-Item -ItemType SymbolicLink -Target "$((Convert-Path .) + '\config\hyper.js')" -Path $($env:HOMEPATH + "\.hyper.js")
```

```powershell
hyper install hyper-cwd-wsl
```

## Refer to

- [Release 2.1.2-fixed · mrk21/hyper](https://github.com/mrk21/hyper/releases/tag/2.1.2-fixed)
- [takahiro652c / hyper-cwd-wsl · GitLab](https://gitlab.com/takahiro652c/hyper-cwd-wsl)
