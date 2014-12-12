

shape=Snowman-0.637556-1.0-p2

all:
	tail -2 ../crystals/$(shape).svg | head -1 | python ../pylib/createCells.py . 0 0.637556 1 p2 > crys.dat
	gnuplot ../crys.plot
