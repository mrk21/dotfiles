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

### VSCodeVim

If your OS is macOS, you must the commands listed below in VSCode's terminal, and restart VSCode:

```sh
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false              # For VS Code
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false      # For VS Code Insider
defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false         # For VS Codium
defaults write com.microsoft.VSCodeExploration ApplePressAndHoldEnabled -bool false   # For VS Codium Exploration users
defaults delete -g ApplePressAndHoldEnabled
```

**see:**

- [Vim - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=vscodevim.vim)
- [VSCode for Macでvimキーバインドにしたとき連続入力できない問題 - Coyote vs Loadbalancer](https://twismik0.hatenablog.com/entry/2017/08/14/115502)

## Font

#### Cascadia Code/Mono

Download fonts from link listed below, and install all OTF fonts.

- [Releases · microsoft/cascadia-code](https://github.com/microsoft/cascadia-code/releases)

## CLI

How to install `code` command, you run following commands on VSCode:

```sh
> シェル コマンド: PATH 内に 'code' コマンドをインストールします
```

## Refer to

- [VSCode に Go の開発環境を整える - iriya-ufo's blog](https://iriya-ufo.net/blog/2019/12/08/go-env-in-vscode/)
