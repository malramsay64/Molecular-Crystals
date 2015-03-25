set terminal png

ext = '.png'
plot_dir = 'myplot/'


set key autotitle columnhead
set yrange [0:1]

set output plot_dir.'short-order-hist'.ext
set datafile separator ","
nc = system("awk -F, 'NR==2 {print NF; exit}' short_order_hist.csv")

plot for [i=2:nc] "short_order_hist.csv" using 1:(column(i)/(sum [j=2:nc+0] column(j))) title columnhead(i) 
