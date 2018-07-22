#!/bin/bash
# function Extract for common file formats

#Other archive tools:
# bzip2, p7zip-full, unzip, xdg-utils, xz-utils, arj, binutils, cpio, lhasa, liblz4-tool, lrzip, lzip, lzop, ncompress, rar, unar, zip, zstd
#Other archive types
# xz,7z,lzma,arj,bzip2,gzip,rar,tar,zip,rpm,lz4,compress,zstd,lzip,lrzip,lzop,lha,deb.

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|exe|apk|cpio>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
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
            *.deb)       7z x ./"$n" & echo bb; tar -xvf ./"data.tar" ; rm data.tar ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;

            *.cpio)      cpio -idv < ./"$n"  ;;
            *)
                         echo "Extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

extract "$@"
IFS=$SAVEIFS
