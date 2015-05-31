load '~/make/gnuplot/config.plot'

set terminal term_type size term_size,term_y font ",12"

set output prefix.plot_dir."crys_growth".ext

unset title
unset key
set xlabel "Time"
set ylabel "Fraction Crystalline"

f(x) = a*x + b
g(x) = c*x + d
FIT_LIMIT=1e-10
fit [4000000:] f(x)  "< for f in $(ls trj_contact/*.dat); do echo $(basename ${f%.*}) $(awk '($5>0.85){count++} END {print count/NR}' $f);done" using ($1*0.005):2 via a,b
fit [3500000:4000000] g(x)  "< for f in $(ls trj_contact/*.dat); do echo $(basename ${f%.*}) $(awk '($5>0.85){count++} END {print count/NR}' $f);done" using ($1*0.005):2 via c,d
plot "< for f in $(ls trj_contact/*.dat); do echo $(basename ${f%.*}) $(awk '($5>0.85){count++} END {print count/NR}' $f);done"  using ($1*0.005):2, [4000000:] f(x), [3500000:4000000] g(x)
