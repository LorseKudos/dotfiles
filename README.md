# Macにおける環境構築メモ

## 手順
1. [Homebrewのインストール](###Homebrew)
1. `brew cask Dropbox`
1. `./setup.sh`
1. LINE, Audacityのインストール

## システム環境設定

### キーボード
[MACのUSキーボードのcommandキーを英数・かなキーに変更する](https://qiita.com/eburairu/items/333e4f51e9447cd83fdc)

[超便利！10個以上コピーを記憶してくれるMacアプリ【Clipy（クリッピー）】](https://www.infact1.co.jp/staff_blog/webmarketing/14006/)
### その他

#### 隠しファイルの表示
```bash
defaults write com.apple.finder AppleShowAllFiles TRUE
killall Finder
```

## インストールするだけのアプリケーション

**`brew cask`でインストールできるものはそっちでやろう！**

- GoogleChrome
- Google日本語入力
- Vivaldi
- Slack
- LINE
- GIMP
- Station
- Dropbox
- Office
- VLC

## エディタ

### VS Code
1. インストール
```bash
brew cask install visual-studio-code
```

2. Settings Syncで設定のリストア

[Visual Studio Code の設定を共有・バックアップする](https://qiita.com/maromaro3721/items/b6d71a5e5d2d6433778a)

[Visual Studio Codeで設定ファイル・キーバインディング・拡張機能を共有する](https://qiita.com/mottox2/items/581869563ce5f427b5f6)

### Goland
1. インストール
[GoLandのインストールと起動](https://pleiades.io/help/go/install-and-set-up-product.html)

2. テーマの設定
[One Dark PyCharm theme](https://github.com/yurtaev/idea-one-dark-theme)

### vim
1. インストール
```bash
 brew install vim --with-override-system-vi
```

## 開発環境

### dotfiles

[なるべく簡単にMacの環境構築を復元を目指す](https://qiita.com/mkazutaka/items/46b96b0e60c447636e1e)

[最強の dotfiles 駆動開発と GitHub で管理する運用方法](https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2)

### Homebrew
1. Xcode Command-Line Tool をインストール
```bash
xcode-select --install
```

2. Homebrewのインストール
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

3. インストールの確認
```bash
brew doctor
```

[Homebrew macOS 用パッケージマネージャー](https://brew.sh/index_ja.html)

[macOSでの開発環境を全部Docker化したらリストア時間が1時間半になった](https://saboyutaka.hatenablog.com/entry/2018/08/23/023925)

### iTerm2
[iTerm2の導入方法&初期設定や使い方まとめ](http://vdeep.net/iterm2)
[iTerm2](https://www.iterm2.com)

### git
1. インストール
```bash
brew install git
git --version
```

2. SSH鍵の作成
```bash
ssh-keygen -t rsa
```

3. ~/.ssh/configに接続設定を追加
```bash
vim ~/.ssh/config
```

```~/.ssh/config
# global setting for macOS Sierra
Host *
  AddKeysToAgent yes
  UseKeychain yes

Host github
  HostName github.com
  IdentityFile ~/.ssh/id_rsa
  Port 22
  User git
```

4. 属性変更
```bash
cd ~/.ssh
chmod 600 id_rsa
```

5. ssh-agentに秘密鍵を登録
```
eval `ssh-agent`
ssh-add ~/.ssh/id_rsa
ssh-add -l
```

6. 確認
```bash
ssh -T git@github.com
ssh github
```
[新しいMacでGitHubのSSH接続をするまでの環境構築手順](https://qiita.com/unsoluble_sugar/items/14bea376d8e6fce82eb3)
### zsh
[お前らのターミナルはダサい](qiita.com/kinchiki/items/57e9391128d07819c321)

[Macで快適な作業環境を構築する(zsh編)](https://qiita.com/ucan-lab/items/1794940a64882021dcb1)

### Docker
1. インストール
```bash
brew install docker
brew cask install docker
```

2. Dockerの起動
```bash
open /Applications/Docker.app
```

[DockerをHomebrewでMac OSに導入する方法](https://qiita.com/sitmk/items/ed753f6b2eb9960845f7)

### MySQL
1. インストール
```bash
brew install mysql --client-only
```

### direnv
1. インストール
```bash
brew install direnv
```

2. 設定を追記
```bash
echo 'eval "$(direnv hook bash)"' >> ~/.zshrc
```

## 言語

### Golang
1. goenvのインストール
```bash
brew install goenv
```

2. 環境変数の設定
```bash
echo 'export GOENV_ROOT="$HOME/.goenv"' >> ~/.zshrc
echo 'export PATH="$GOENV_ROOT/bin:$PATH"' >> ~/.zshrc
```

3. インストール
```bash
goenv install -l
goenv install 1.12
goenv versions
goenv global 1.12
```

4. 確認
```bash
go version
```

### Python
1. pyenvのインストール
```
brew install pyenv
```

2. パスを通す
```bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
source ~/.zshrc
```

3. 起動確認
```bash
pyenv
```

4. 特定のバージョンをインストール
```bash
pyenv install -l
pyenv install 3.7
pyenv versions
pyenv global 3.7
pyenv --version
```

[pyenv/pyenv](https://github.com/pyenv/pyenv)


### Node

1.`tj/n`のインストール
```bash
brew install n
```

2. `node`をインストール
```bash
n 10
```

3. バージョンを指定
```bash
$ n

  node/4.9.1
ο node/8.11.3
  node/10.15.0
```

[Node.jsのバージョン管理にtj/nを使ってみた話(vs nvm, nodenv)](https://qiita.com/jigengineer/items/6a4ff0bc3a480dd8bb58)
