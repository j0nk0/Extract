#!/bin/bash
# Function to extract common file formats.
#  https://github.com/j0nk0/Extract/blob/master/extract.sh

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function extract {
 if [ -z "$1" ]; then
    # Display usage if no parameters given.
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|arj|cab|chm|deb|dmg|iso|lzh|msi|rpm|udf|wim|xar|exe|apk|cpio>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    echo ""    
    echo "https://github.com/j0nk0/Extract/blob/master/extract.sh"
#    return 1
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.ace)       unace x ./"$n"     ;;
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z|*.Z)     uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar|*.exe|*.apk)
                         7z x ./"$n"        ;;
            *.deb)       7z x ./"$n"; tar -xvf ./"data.tar" ; rm data.tar ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -idv < ./"$n"  ;;
            *)           echo "Extract: '$n' - Unknown archive method."; return 1 ;;
          esac
      else
          echo "'$n' - File does not exist"
          return 1
      fi
    done
fi
}

extract "$@"
 ! which beep &>/dev/null || beep -f3000 -l400 -r3 -d1
 echo "Done"

IFS=$SAVEIFS
