#!/bin/zsh

# if [[ ! -a $1 ]]; then
# 	echo "Usage: viewer [file]"
#   read -s -k '?Press any key to continue.'
#   exit 1
# fi 

case ${1:e} in
  pdf)
    pdftotext -layout -nopgbrk $1 - | bat -p -S --pager 'less -R'
    ;;
  md)
    glow --style dark -p $1
    ;;
  djvu)
    djvutxt $1 | bat -p -S --pager 'less -R'
    ;;
  docx)
    docx2txt.pl $1 - | bat -p -S --pager 'less -R'
    ;;
  xlsx)
    in2csv $1 | csvlook | bat -p -S --pager 'less -R'
    ;;
  scv)
    csvlook $1| bat -p -S --pager 'less -R'
    ;;
  transmission)
    transmission-show $1
    ;;
  json)
    jq '.' $1
    ;;
  tar | tgz | tbz* | txz | zip | 7z | gz | xz | lzma | bz* |lz4 | sz | zst | rar )
    ouch list $1 --tree | bat -p -S --pager 'less -R'
    ;;
  *)
  bat -p -S --pager 'less -R' $1
    ;;
esac

