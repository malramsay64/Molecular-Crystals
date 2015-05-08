load '~/make/gnuplot/collate_config.plot'

set terminal term_type enhanced size term_size*scaling, term_y*scaling font ",".font_size

set xlabel "Timestep"
set format x "10^{%L}"
set format y "%g"
set logscale x
set key outside right
set style line 5 pointtype 7 linewidth 2*scaling pointsize 0.5*scaling
set yrange [0:]

set datafile separator ","

num_cols(f) = system("awk -F, 'NR==1 {print NF; exit}' ".f)
heading(i,f) = system("awk -F, 'NR==1 {print $".i."; exit}' ".f)

first = word(files,1)."/struct.csv"

do for [r=2:num_cols(first)] {

    set output prefix.plot_dir.molecule."-".heading(r,first).ext
    set ylabel heading(r,first)."(t)"

    plot for [i=1:words(files)] word(files,i)."/struct.csv" using 1:r with linespoints linestyle 5\
         linecolor i title temp(word(files,i))
}
