#!/bin/zsh

case ${1:e} in
pdf)
  pdftotext -layout -nopgbrk $1 - | less
  ;;
md)
  glow --style dark -p $1
  ;;
djvu)
  djvutxt $1 | less
  ;;
doc)
  antiword $1 | less
  ;;
docx)
doxx $1
  ;;
xlsx | xls | xlsm | xlsb | ods)
xleak -i $1
# xlsx)
#   in2csv $1 | csvlook | less
  ;;
csv)
  csvlook --max-column-width 30 $1 | less
  ;;
json)
  jq -C . $1 | less -R
  ;;
transmission)
  transmission-show $1
  ;;
tar | tgz | tbz* | txz | zip | 7z | gz | xz | lzma | bz* | lz4 | sz | zst | rar)
  ouch list $1 --tree | less
  ;;
*)
  bat --paging=always $1
  ;;
esac
