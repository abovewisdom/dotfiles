#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".gitmodules/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;
	source ~/.zshrc;
	source ~/.tmux.conf;
}
#Currently don't have force option working, will always override. 
#if [ "$1" == "--force" -o "$1" == "-f" ]; then
#	doIt;
#else
#	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
#	echo "";
#	if [[ $REPLY =~ ^[Yy]$ ]]; then
#		doIt;
#	fi;
#fi;
doIt;
unset doIt;

