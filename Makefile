DOT_FILES := $(shell find media -type f -name '*.dot')
RENDERED_DOT_FILES = $(patsubst %.dot,%.svg,${DOT_FILES})

SEQDIAG_FILES := $(shell find media -type f -name '*.seqdiag')
RENDERED_SEQDIAG_FILES = $(patsubst %.seqdiag,%.svg,${SEQDIAG_FILES})

.PHONY: all clean

all: index.html ${RENDERED_DOT_FILES} ${RENDERED_SEQDIAG_FILES}

index.html: index.org
	./org2reveal index.org

%.svg: %.dot
	dot -Tsvg $(realpath $<) > $(addprefix ${CURDIR}/,$@)

%.svg: %.seqdiag
	seqdiag -Tsvg $(realpath $<) > $(addprefix ${CURDIR}/,$@)

clean:
	git clean -fdx
