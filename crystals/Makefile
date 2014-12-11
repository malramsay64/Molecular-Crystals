
files:=$(shell ls *.svg)
#files:=Snowman-0.7-1.7-p2gg.svg
#files:=Snowman-0.637556-1.637556-p2gg.svg
files:=Snowman-0.637556-1.0-p2.svg

empty=
space=$(empty) $(empty)

shape = $(word 1, $(subst -,$(space),$(basename $(1))) )
rad = $(word 2, $(subst -,$(space),$(basename $(1))) )
dist = $(word 3, $(subst -,$(space),$(basename $(1))) )
cell = $(word 4, $(subst -,$(space),$(basename $(1))) )
   

all: $(files)
	@tail -2 $< | head -1 | python ../pylib/crys.py $(call rad, $<) $(call dist, $<) $(call cell, $<) > crys.dat 
	@gnuplot crys.plot
