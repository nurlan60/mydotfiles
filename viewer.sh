#!/bin/zsh

if [[ ! -f $1 ]]; then
	echo "Usage: viewer [file]"
  read -s -k '?Press any key to continue.'
  exit 1
fi 

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
  ""|cls|jl|log|lua|sh|sty|pl|txt|tex|toml|zsh)
  bat -p -S --pager 'less -R' $1
    ;;
  *)
    open $1
    ;;
esac

