.PHONY: all clean

PLIMC      ?= plimc
PLIMCFLAGS ?= -H

SRC := $(shell find src -type f -name '*.plim')
TRG := $(SRC:src/%.plim=%.html)

all: $(TRG)

clean:
	$(RM) $(TRG)

$(TRG): %.html: src/%.plim
	@mkdir -p $(@D)
	$(PLIMC) $(PLIMCFLAGS) $^ -o $@
