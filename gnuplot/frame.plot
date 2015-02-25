
#set terminal pdf enhanced
set terminal png enhanced transparent truecolor size 3200,3200

ext = ".png"

set size ratio -1
#set size square
set datafile separator " "
set style fill transparent solid 1 noborder
set style line 1 lt 1 lc -1 lw 2

files = system('ls '.prefix.'/trj_contact/*.dat')

#tail(s) = sprintf("< tail -n +3  %s", s)

do for [i=1:words(files)] {

file = word(files,i)

set output system('f='.file.'; echo ${f%.dat}'.ext) 

a = system(sprintf("awk 'NR==1 {print  $1; exit}' %s", file))
height = system(sprintf("awk 'NR==1 {print  $2; exit}' %s", file))
set yrange[-2:height+2]
set xrange[-2:a+2]

set object rectangle from -0,0 to a,height
plot "< tail -n +3 ".file using 1:2:3 with circles lc rgb 'black' ,\
     "< tail -n +3 ".file using 1:2:($3-0.05) with circles lc rgb '#4BAC6F' title "Configuration" ,\
     "< tail -n +3 ".file every :1 using 1:2  with line ls 1
}
