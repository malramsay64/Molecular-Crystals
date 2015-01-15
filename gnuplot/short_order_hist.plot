set terminal png size 800,800

set datafile separator ","

set output 'short_order_hist.png'
set key autotitle columnhead

plot for [COL=2:7:1] 'short_order_hist.csv' using 1:(sum [c =COL:7] column(c)) \
    title columnheader(COL) \
    with filledcurve x1
