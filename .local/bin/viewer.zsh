#!/bin/zsh

case ${1:e} in
pdf)
  pdftotext -layout -nopgbrk "$1" - | less
  ;;
md)
  glow --style dark -p "$1"
  ;;
djvu)
  djvutxt "$1" | less
  ;;
doc)
  antiword "$1" | less
  ;;
docx)
  if [[ $(uname) == "Darwin" ]]; then
    docx2txt.pl "$1" - | less
  else
    docx2txt "$1" - | less
  fi
  ;;
xlsx)
  in2csv "$1" | csvlook | less
  ;;
scv)
  csvlook "$1" | less
  ;;
json)
  jq -C . "$1" | less -R
  ;;
transmission)
  transmission-show "$1"
  ;;
tar | tgz | tbz* | txz | zip | 7z | gz | xz | lzma | bz* | lz4 | sz | zst | rar)
  ouch list "$1" --tree | less
  ;;
*)
  bat --paging=always "$1"
  ;;
esac
