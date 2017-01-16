PREFIX = /usr

install: noahstrap
	install -d $(PREFIX)/bin
	install -c noahstrap $(PREFIX)/bin/noahstrap

.PHONY: install
