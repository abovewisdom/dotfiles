#NOT WORKING YET using: https://github.com/junegunn/fzf/wiki/examples to learn
# vf - fuzzy open with tig from git(use to be anywhere, probably why it isn't working)
# zsh autoload function
ftig() {
  local files

  files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

  if [[ -n $files ]]
  then
     tig -- $files
     print -l $files[1]
  fi
}
