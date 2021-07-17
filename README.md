# WSL環境構築
## linuxbrew導入
```bash
sudo apt update
sudo apt-get install build-essential curl file git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew --version
```

## zshに変更
```bash
brew install zsh
echo `which zsh` | sudo tee -a /etc/shells
chsh -s `which zsh`
```

## dotfile復元 / git_completionインストール / シンボリックリンク貼る
```bash
git clone https://github.com/LorseKudos/dotfiles.git
mv dotfiles .dotfiles
./.dotfiles/setup.sh
```

## WSLのshellにWindowsのPATHを含まないようにする
```bash
cat << 'EOS' | sudo tee -a /etc/wsl.conf
[interop]
appendWindowsPath = false
EOS
```
https://amaya382.hatenablog.jp/entry/2019/12/27/120057

## github
```bash
ssh-keygen -t rsa -b 4096 -C "wsl"
cat << 'EOS' | sudo tee -a ~/.ssh/config
AddKeysToAgent yes

Host github
  HostName github.com
  IdentityFile ~/.ssh/id_rsa
  User git
EOS
cat ~/.ssh/id_rsa.pub | pbcopy
# ブラウザでgithubに公開鍵登録
ssh -T git@github.com
```

## docker
https://dk521123.hatenablog.com/entry/2020/12/10/094125
1. Docker Disktopを開き、`設定アイコン > Resources > WSL INTERRATION`を選択
2. `Enable integration with additional distros:`配下にある`Ubuntu`をONにする
3. `Apply & Restart`ボタン押下
4. Ubuntu上で `docker --version` を実行

## 拡張機能
何をインストールしてたかは残っている。毎回手動でインストールして取捨選択すべきじゃない？

# Macにおける環境構築メモ

## 手順
1. [Homebrewのインストール](###Homebrew)
1. `brew cask Dropbox`
1. `./setup.sh`

## システム環境設定

[Macのオススメ初期セットアップ(Mojave)](https://qiita.com/uhooi/items/8279cbda8bde08836a47)

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
- Slack
- LINE
- Dropbox

## エディタ

### VS Code
1. インストール
```bash
brew cask install visual-studio-code
```

2. Settings Syncで設定のリストア

[Visual Studio Code の設定を共有・バックアップする](https://qiita.com/maromaro3721/items/b6d71a5e5d2d6433778a)

[Visual Studio Codeで設定ファイル・キーバインディング・拡張機能を共有する](https://qiita.com/mottox2/items/581869563ce5f427b5f6)

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
git clone https://github.com/syndbg/goenv.git ~/.goenv
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
