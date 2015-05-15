load '~/make/gnuplot/config.plot'

set terminal term_type

set style data histogram
set style histogram cluster gap 0.5
set style fill solid border -1
set key on
set yrange [0:1.1]
set xrange [0:15]
set ylabel "Fraction"
set output plot_dir."hist".ext
set key top left

sum(f,i) = system("awk '{sum+=$".i."} END {print sum}' ".f)
infiles = "stats/diff_contact.dat stats/diff_neigh.dat"
headings = "low-diff high-diff low-rot high-rot"

do for [i=1:2] {
    f = word(infiles,i)
    set output prefix.plot_dir.system("basename ".f).ext

    nc = system("awk 'NR==1 {print NF; exit}' ".f)
    plot for [j=2:nc] f using (column(j)/sum(f,j)):xtic(1) title word(headings,j-1)
}
