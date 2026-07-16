#!/usr/bin/env fish

if test (count $argv) -eq 0
    echo "Error: Please provide at least one file path."
    echo "Usage: ./viewer.fish <file>"
    exit 1
end

set file $argv[1]

switch (path extension $file)
  case .pdf
      tdf $file
  case md
      leaf $file
  case .djvu
      djvutxt $file | bat
  case .doc
      antiword $file | bat
  case .docx
      doxx $file
  case .xlsx .xls .xlsm .xlsb .ods
      xleak -i $file
  case .json
      jq -C . $file | bat
  case transmission
      transmission-show $file
  case .tar .tgz .txz .zip .7z .gz .xz .lzma .lz4 .sz .zst .rar
      ouch list $file --tree | bat
  case '*'
      bat $file
end
