#!/bin/sh

case ${1##*.} in
pdf)
  pdftotext -layout -nopgbrk "$1" - | less
  ;;
md)
  glow -t "$1"
  ;;
djvu)
  djvutxt "$1" | less
  ;;
doc)
  antiword "$1" | less
  ;;
docx)
  doxx "$1"
  ;;
xlsx | xls | xlsm | xlsb | ods)
  xleak -i "$1"
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
