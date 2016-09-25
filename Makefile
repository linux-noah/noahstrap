PREFIX = /usr

bin/noahstrap: bin/_noahstrap
	sed "s!NOAHSTRAP_INSTALL_PREFIX!$(PREFIX)!" bin/_noahstrap > bin/noahstrap
	chmod +x bin/noahstrap

install: bin/noahstrap libexec/noahstrap-archlinux.sh
	install -d $(PREFIX)/bin
	install -d $(PREFIX)/libexec
	install -c bin/noahstrap $(PREFIX)/bin/noahstrap
	install -c libexec/noahstrap-archlinux.sh $(PREFIX)/libexec/noahstrap-archlinux.sh

clean:
	$(RM) bin/noahstrap

.PHONY: install clean
