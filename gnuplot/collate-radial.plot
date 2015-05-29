load '~/make/gnuplot/collate_config.plot'

set terminal term_type enhanced size term_size*scaling, term_y*scaling font ",".font_size

set xlabel "Distance"
set ylabel ""
set key outside right
set style line 5 linewidth 2*scaling
set xrange [0:7.5]
set yrange [0:]

no_ext(f) = system("f=".f."; echo ${f%.*}")
radial = "radial_dist.dat radial_part.dat"

do for [r=1:words(radial)] {

    first = word(files,1).word(radial,r)
    set output prefix.plot_dir.molecule."-".no_ext(word(radial,r)).ext

    plot for [i=2:words(files):2] word(files,i)."/".word(radial,r) using 1:($2+i-2) with lines linestyle 5\
         linecolor i/2 title temp(word(files,i))
}
