
PRE=files data lammps touch-lammps test $(all_clean)
TARGETS=contact plot density movie
PRESENT=grouped individual

latex-flags= --output-dir=output/.output -interaction=batchmode

include settings
include config

export

# Generating all shapes {{{
mol := $(shape)
# Radius
mol := $(if $(radius), $(foreach rad, $(radius), $(addsuffix -$(rad), $(mol))), $(mol)) 
# Distance
mol := $(if $(dist), $(foreach rad, $(dist), $(addsuffix -$(rad), $(mol))), $(mol)) 
# Computing Distance
mol := $(foreach m, $(mol), $(m:$(call p_dist, $m)=$(call comp_dist, $(call p_dist, $m), $(call p_rad, $m))))
# Theta
mol_s := $(filter Snowman%, $(mol))
mol_t := $(filter Trimer%, $(mol))
mol_t := $(foreach rad, $(theta), $(addsuffix -$(rad), $(mol_t)))

mol := $(mol_s) $(mol_t)

# Adding crystals for which there are unit cells
ifneq ($(strip $(crys)),)
    mol := $(foreach c, $(crys), $(addsuffix -$(c), $(mol)))
    mol := $(foreach m, $(mol), $(if $(wildcard crystals/$m.svg), $m))
endif

# Iterating through having a crystal liquid boundary
ifneq ($(strip $(boundary)),)
    mol := $(if $(boundary), $(foreach b, $(boundary), $(addsuffix -$(b), $(mol))), $(mol))
    CREATE_VARS += -v boundary $(bound)
else
    CREATE_VARS += -v boundary 0
endif
#}}}

VPATH=.:$(BIN_PATH):$(LIB)

distances = $(foreach m, $(mol), $(call p_dist, $m))
export $(addprefix temp_, $(distances))

##########################################################################################

all: program

collate: $(mol) | $(PREFIX)/plots
	@echo Creating T-dependent plots
	@-rm -f $(PREFIX)/plots/*
	@$(foreach m, $(mol), python pylib/collate.py $(PREFIX)/$(strip $(m));)
	$(eval fs = $(basename $(shell ls $(PREFIX)/plots/*.csv)))
	@$(foreach f, $(fs), gnuplot -e 'filename="$f"' gnuplot/temp_dep.plot;)

movie: $(mol)
	@$(vmd) -e $(vmd_in) -args $(PREFIX)

$(mol): program vars.mak | $(PREFIX)
ifeq ($(SYS_NAME), silica)
	@qsub -N $@ -o pbsout/$@.out make.pbs -vmol=$@,target=$(MAKECMDGOALS)
else
	@$(MAKE) -f $(LOOP) $(MAKECMDGOALS) mol=$@
endif

vars.mak:
	@rm -f $@
	@$(foreach V,\
    $(sort $(.VARIABLES)),\
    $(if\
        $(filter-out environment% default automatic, $(origin $V)),\
        echo '$V=$(value $V)' >> $@;\
        )\
    )

$(TARGETS): $(mol)

$(PRE): $(mol)

$(PRESENT): program collate
	@echo $@
	@python output/$@.py $(PREFIX) > output/$@.out
	@pdflatex -draftmode $(latex-flags) output/$@.tex
	@pdflatex $(latex-flags) output/$@.tex
	@rm -f $@.pdf
	@mv output/.output/$@.pdf $(PREFIX)/$@.pdf
	@ln -s $(PREFIX)/$@.pdf $@.pdf

present: program $(mol) $(PRESENT)

%.o : %.cpp | $(BIN_PATH)
	@echo CC $<
	@$(CXX) $(CXXFLAGS) -c $< -o $(BIN_PATH)/$@

program: $(MODULES) $(HEADERS)
	@echo CC $@
	@$(CXX) -o $(BIN_PATH)/program $(addprefix $(BIN_PATH)/, $(MODULES)) $(CXXFLAGS) $(LDFLAGS)

$(BIN_PATH):
	@mkdir -p $(BIN_PATH)

$(PREFIX):
	@mkdir $(PREFIX)

$(PREFIX)/plots:
	@mkdir $@


.PHONY: test $(mol) clean delete vars.mak $(TARGETS) $(PRE)

#test: $(mol)
#	@echo test

clean:
	-rm -r bin/*

delete:
	-rm -r $(PREFIX)/*


# vim:foldmethod=marker:foldlevel=0
