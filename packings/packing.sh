#!/bin/bash

prefix=$HOME/scratch/pack
dirs=$(ls -d $prefix/*-*)

rm *.dat

for d in $dirs; do
    pack=$(grep -i "Packing Fraction:" $d/order.log | cut -d: -f2-)
    mol=$(basename $d)
    if [ $(echo $mol | cut -d- -f2) == '0.4' ]; then
        echo $(echo $mol | cut -d- -f3- | tr - ' ') $pack >> $(echo $mol | cut -d- -f1)-low.dat
    elif [ $(echo $mol | cut -d- -f2) == '3.0' ]; then
        echo $(echo $mol | cut -d- -f3- | tr - ' ') $pack >> $(echo $mol | cut -d- -f1)-high.dat
    fi
done
