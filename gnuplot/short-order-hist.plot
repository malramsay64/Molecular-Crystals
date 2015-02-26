set terminal png size 800,800

nc = "`awk -F, 'NR==2 {print NF; exit}' short_order_hist.csv`" + 0

set datafile separator ","

set yrange[0:1]

set output 'short_order_hist.png'
set key autotitle columnhead

plot for [COL=2:nc:1] 'short_order_hist.csv' using 1:($2/(sum [c=2:nc] column(c))) \
    title columnheader(COL)
