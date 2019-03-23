#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install Bash 4.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install `wget`
brew install wget 

# Install zsh
brew install zsh

# Install ohmyzsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim 
brew install grep

# Install other useful binaries.
brew install ack
brew install git
brew install tig
brew install fzf
brew install bitwarden-cli
brew install lua
brew install tmux
brew install tidy-html5
brew install fasd
brew install the_silver_searcher
brew cask install alacritty
brew install gzip

# Install pytest(unit tests for pip)(this may need some tweaking)
pip install -U pytest
#man page for alacritty
sudo mkdir -p /usr/local/share/man/man1
gzip -c alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
echo "source $(pwd)/alacritty-completions.bash" >> ~/.bashrc
# Completions for zsh in Alacitty
mkdir -p ${ZDOTDIR:-~}/.zsh_functions
echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc	
cp alacritty-completions.zsh ${ZDOTDIR:-~}/.zsh_functions/_alacritty
#pull down vim settings
cd .vim
git submodule init
git submodule update
cd ..
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
#add folders for vim-force plugin
cd ~
mkdir tmp
cd tmp
mkdir apex
mkdir truecrypt
cd apex
mkdir backup
mkdir gvim-deployment
cd ~
# Remove outdated versions from the cellar.
brew cleanup
