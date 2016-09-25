PREFIX = /usr

install: bin/noahstrap libexec/noahstrap-archlinux.sh
	install -d $(PREFIX)/bin
	install -d $(PREFIX)/libexec
	install -c bin/noahstrap $(PREFIX)/bin/noahstrap
	install -c libexec/noahstrap-archlinux.sh $(PREFIX)/libexec/noahstrap-archlinux.sh

.PHONY: install
