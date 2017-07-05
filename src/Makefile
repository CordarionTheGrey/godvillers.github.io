.PHONY: all clean

PLIMC      ?= plimc
PLIMCFLAGS ?= -H
ELM        ?= elm-make
ELMFLAGS   ?= --warn
SASS       ?= sass
SASSFLAGS  ?= -t compressed

HTMLOUT := ..
JSOUT   := ..
CSSOUT  := ..

FILES   := $(shell find -name elm-stuff -prune -o -type f -print)
PLIMSRC := $(filter %.plim,$(FILES))
PLIMTRG := $(PLIMSRC:./%.plim=$(HTMLOUT)/%.html)
ELMSRC  := dung/editor.elm
ELMDEPS := $(filter-out ./$(ELMSRC),$(filter %.elm,$(FILES)))
ELMTRG  := $(ELMSRC:%.elm=$(JSOUT)/%.js)
SASSSRC := $(filter %.sass,$(FILES))
SASSTRG := $(SASSSRC:./%.sass=$(CSSOUT)/%.css)

all: $(PLIMTRG) $(ELMTRG) $(SASSTRG)

clean:
	$(RM) -r $(PLIMTRG) $(ELMTRG) $(SASSTRG) .sass-cache/

$(PLIMTRG): $(HTMLOUT)/%.html: %.plim
	@mkdir -p $(@D)
	$(PLIMC) $(PLIMCFLAGS) $^ -o $@

$(ELMTRG): $(ELMSRC) $(ELMDEPS)
	@mkdir -p $(@D)
	$(ELM) $(ELMFLAGS) $< --output $@ >/dev/null

$(SASSTRG): $(CSSOUT)/%.css: %.sass
	@mkdir -p $(@D)
	$(SASS) $(SASSFLAGS) $^ >$@
