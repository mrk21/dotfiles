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

## CLI

How to install `code` command, you run following commands on VSCode:

```sh
> シェル コマンド: PATH 内に 'code' コマンドをインストールします
```

## Refer to

- [VSCode に Go の開発環境を整える - iriya-ufo's blog](https://iriya-ufo.net/blog/2019/12/08/go-env-in-vscode/)
