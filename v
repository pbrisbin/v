#!/bin/bash

vim=vim
viminfo=~/.viminfo

usage="$(basename $0) [-a] [-l] [-[0-9]] [--debug] [--help] [regexes]"

[ $1 ] || list=true

args=()
deleted=false

for x; do case $x in
    -a) deleted=true;;
    -l) list=true;;
    -[1-9]) edit=${x:1}; shift;;
    --help) echo $usage; exit;;
    --debug) vim=echo;;
    --) shift; args+=( "$*" ); break;;
    *) args+=( "$x" ) ;;
esac; shift; done

for x in "${args[@]}"; do
  [ -f "$x" ] && {
      "$vim" "$x"
      exit
  }
done

while read line; do
    [ "${line:0:1}" = ">" ] || continue
    fl=${line:2}
    [ -f "$(eval echo $fl)" -o "$deleted" ] || continue
    match=1
    for x in "${args[@]}"; do
        [[ "$fl" =~ $x ]] || match=
    done
    [ "$match" ] || continue
    i=$((i+1))
    files[$i]="$fl"
done < "$viminfo"

if [ "$edit" ]; then
    resp=${files[$edit]}
elif [ "$i" = 1 -o "$list" = "" ]; then
    resp=${files[1]}
elif [ "$i" ]; then 
    while [ $i -gt 0 ]; do
         echo -e "$i\t${files[$i]}"
         i=$((i-1))
    done
    read -p '> ' CHOICE
    resp=${files[$CHOICE]}
fi

[ "$resp" ] || exit
"$vim" "$(eval echo $resp)"
