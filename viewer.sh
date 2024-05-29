#!/bin/zsh

if [[ ! -f $1 ]]; then
			echo "Usage: viewer [file]"
      read -s -k '?Press any key to continue.'
      exit 1
	fi 
file=$1
case ${file:e} in
  pdf)
    pdftotext -layout -nopgbrk ${file} - | bat -p -S --pager 'less -R'
    ;;
  md)
    glow --style dark -p ${file}
    ;;
  djvu)
    djvutxt ${file} | bat -p -S --pager 'less -R'
    ;;
  docx)
    docx2txt.pl ${file} - | bat -p -S --pager 'less -R'
    ;;
  xlsx)
    in2csv ${file} | csvlook | bat -p -S --pager 'less -R'
    ;;
  scv)
    csvlook ${file}| bat -p -S --pager 'less -R'
    ;;
  transmission)
    transmission-show ${file}
    ;;
  jl|log|lua|sh|pl|txt|tex|toml|zsh)
  bat -p -S --pager 'less -R' $file
    ;;
  *)
    open ${file}
    ;;
esac

