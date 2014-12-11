#include ../system
#include ../plot.settings
include ../config

all:
	@echo $(PREFIX)
	@echo $(SYS_NAME)

#all: grouped present

LOG=out.log

grouped:
	python grouped.py $(PREFIX) > grouped.py.out
	pdflatex grouped.tex > $(LOG)
	pdflatex grouped.tex > $(LOG)
	#mv grouped.pdf ../
	
individual:
	python present.py $(PREFIX) 
	pdflatex present.tex > $(LOG)
	pdflatex present.tex > $(LOG)
	#mv present.pdf ../

.PHONY: clean
clean:
	-mv present.tex .present.tex
	-rm -f present.*
	-mv .present.tex present.tex
	-mv grouped.tex .grouped.tex
	-rm -f grouped.*
	-mv .grouped.tex grouped.tex

