#! /bin/bash
rm dot.brewfile
brew bundle dump --file=dot.brewfile

# brew以外でインストールしたアプリ一覧
ls /Applications > application_list.txt
