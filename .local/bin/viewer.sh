#!/bin/zsh

# if [[ ! -a $1 ]]; then
# 	echo "Usage: viewer [file]"
#   read -s -k '?Press any key to continue.'
#   exit 1
# fi 

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
  docx)
    docx2txt.pl $1 - | less
    ;;
  xlsx)
    in2csv $1 | csvlook | less
    ;;
  scv)
    csvlook $1 | less
    ;;
  json)
    jq -C . $1 | less -R
    ;;
  transmission)
    transmission-show $1
    ;;
  tar | tgz | tbz* | txz | zip | 7z | gz | xz | lzma | bz* |lz4 | sz | zst | rar )
    ouch list $1 --tree | less
    ;;
  *)
  bat $1
    ;;
esac

