#!/bin/bash


# For amorphous packings
prefix=$HOME/scratch/pack
if [ -d $prefix ]; then 
    echo $prefix exists
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
    gnuplot packing.plot
fi

# For Crystalling packings
prefix=$HOME/scratch/pack_iso
bash best.sh $prefix
if [ -d $prefix ]; then
    echo $prefix exists
    dirs=$(ls -d $prefix/*-*)

    for d in $dirs; do
        pack=$(head -n1 $d/best.dat | cut -d' ' -f2)
        mol=$(basename $d)
        echo $(echo $mol | cut -d- -f2- | tr - ' ') $pack >> $(echo $mol | cut -d- -f1)-iso.dat
    done
    gnuplot pack_iso.plot
fi

# For Trimer Packings
prefix=$HOME/scratch/pack_tri
if [ -d $prefix ]; then 
    echo $prefix exists
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
    gnuplot pack_tri.plot
fi

