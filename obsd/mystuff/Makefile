all:
	@>&2 echo "Use 'make install' to copy the files."

install:
	doas mkdir -p /usr/ports/mystuff
	doas cp -rf * /usr/ports/mystuff/

uninstall:
	rm -rf /usr/ports/mystuff
