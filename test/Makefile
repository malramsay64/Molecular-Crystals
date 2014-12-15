

N=36
shape=Snowman-0.637556-1.637556-p2

all:
	tail -2 ../crystals/$(shape).svg | head -1 | python ../pylib/createCells.py . 0 0.637556 1.637556 p2 > crys.dat
	gnuplot ../crys.plot

grid:
	tail -2 ../crystals/$(shape).svg | head -1 | python ../pylib/createCells.py . $N 0.637556 1 p2 > crys.dat
	gnuplot ../crys.plot

test:
	tail -2 ../crystals/$(shape).svg | head -1 | python ../pylib/test.py . 0 0.637556 1 p2 > crys.dat
	gnuplot ../crys.plot

