#!/bin/bash

function pack_index {
    count=2;
    IFS=' ' read -a array <<< "$1"
    for i in "${array[@]}"; do
        echo $i
        [[ $i == "packing" ]] && echo $count && break
        ((++count))
    done
}

function wallpaper {
    echo $(basename $1 | cut -d\] -f2 | cut -d_ -f1)
}

function packing {
    echo $(tail -1 $1 | cut -c 45-52)
}

function letter {
    echo $(basename $1 | cut -d_ -f4)
}

function get_packings {
    for f in $(ls $1/solution*); do
        echo $(wallpaper $f) $(packing $f) $(letter $f)
    done
}

function best {
   get_packings $1 | sort -uk1,1 | tr '\n' ','
}

 function print_best {
    best $1 | tr ',' '\n' | cut -d" " -f-2 | sort -r -k2
}

function rename {
    IFS=',' read -a array <<< "$(best $1)"
    for i in "${array[@]}"; do
        IFS=' ' read -a wall <<< "$i"
        cp $(ls $1/solution*${wall[0]}_${wall[2]}*) $1/$(basename $1)-${wall[0]}.svg
    done
}

prefix=$1
for f in $(find $prefix/*-* -maxdepth 0 -type d); do
    rename $f
    print_best $f > $f/best.dat
done

