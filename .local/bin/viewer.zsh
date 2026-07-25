#!/bin/zsh

if (( $# == 0 )); then
    echo "Error: Please provide at least one file path."
    echo "Usage: ./viewer.zsh <file>"
    exit 1
fi

file=$1

case $file:e in
      pdf)
        tdf $file
       ;;
      md)
        leaf $file
       ;;
      djvu)
        djvutxt $file | bat
       ;;
      doc)
        antiword $file | bat
        ;;
      docx)
        doxx $file
        ;;
      xlsx|xls|xlsm|xlsb|ods)
        xleak -i $file
        ;;
      json)
        jq -C . $file | bat
        ;;
      tar|tgz|txz|zip|7z|gz|xz|lzma|lz4|sz|zst|rar)
        ouch list $file --tree | bat
        ;;
      png|jpg|jpeg)
        viu -w 40 $file 
        read -k 1 -s "?Press any key to continue..."

        ;;
        *)
          bat $file
          ;;
esac

