#!/usr/bin/env just --justfile

SHORTCUTS := $(patsubst %.jsonnet, %.shortcut, $(wildcard shortcuts/*.jsonnet))
SIGNING_MODE := people-who-know-me

all: $(SHORTCUTS)

%.shortcut: %.jsonnet
	jsonnet "$<" \
	| plutil -convert binary1 - -o - \
	| shortcuts sign -m $(SIGNING_MODE) -i /dev/stdin -o "$@"
