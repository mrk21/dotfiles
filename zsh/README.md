# zsh

## Setup

```bash
mkdir -p ~/bin
ln -s $(pwd)/zprofile.sh ~/.zprofile
ln -s $(pwd)/zshrc.sh ~/.zshrc 
ln -s $(pwd)/zprofile.d ~/.zprofile.d
ln -s $(pwd)/zshrc.d ~/.zshrc.d
```

### Mac

```bash
brew install rbenv
brew install nodenv
brew install direnv
brew install peco
```

- https://github.com/direnv/direnv

## Dependencies

### Mac

- coreutils
- brew

### WSL

- wsl-open

```sh
npm install -g wsl-open
```

## Refer to

### `LS_COLORS`

* [zshでlsに色をつける - 適当な事を適当にかいていくブログ](http://mkit2009.hatenablog.com/entry/2013/01/28/001213)
* [Zsh - LS_COLORSを設定しよう - Qiita](http://qiita.com/yuyuchu3333/items/84fa4e051c3325098be3)
