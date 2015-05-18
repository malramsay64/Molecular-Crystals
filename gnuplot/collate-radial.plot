load '~/make/gnuplot/collate_config.plot'

set terminal term_type enhanced size term_size*scaling, term_y*scaling font ",".font_size

set xlabel "Timestep"
set ylabel ""
set key outside right
set style line 5 pointtype 7 linewidth 2*scaling pointsize 0.5*scaling
set xrange [0:15]

no_ext(f) = system("f=".f."; echo ${f%.*}")
radial = "radial_dist.dat radial_part.dat"

do for [r=2:words(radial)] {

    first = word(files,1).word(radial,r)
    set output prefix.plot_dir.molecule."-".no_ext(word(radial,r)).ext

    plot for [i=1:words(files)] word(files,i).word(radial,r) using 1:r with linespoints linestyle 5\
         linecolor i title temp(word(files,i))
}
