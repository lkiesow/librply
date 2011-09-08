INSTPATH=/lib64
INCPATH=/usr/include

lib: src/rply.c src/rply.h
	mkdir -p obj/ bin/
	gcc -Wall -c -fPIC src/rply.c -o obj/rply.o
	gcc -shared -Wl,-soname,librply.so -o bin/librply.so obj/rply.o

test: lib src/etc/*.c 
	mkdir -p bin/
	gcc src/etc/dump.c       -lrply -Isrc -Lbin -o bin/dump
	gcc src/etc/convert.c    -lrply -Isrc -Lbin -o bin/convert
	gcc src/etc/sconvert.c   -lrply -Isrc -Lbin -o bin/sconvert
	gcc src/etc/create_ply.c -lrply -Isrc -Lbin -o bin/create_ply
	cp src/etc/input.ply bin/input.ply

install: lib
	@echo Installing library to ${INSTPATH}
	@mkdir -p ${INSTPATH}
	@cp -f bin/librply.so ${INSTPATH}
	@chmod 755 ${INSTPATH}/librply.so
	@echo Installing header to ${INCPATH}
	@cp -f src/rply.h ${INCPATH}

uninstall:
	@echo Deleting ${INSTPATH}/librply.so
	@rm -f ${INSTPATH}/librply.so
	@echo Deleting ${INCPATH}/rply.h
	@rm -f ${INCPATH}/rply.h

clean:
	rm -rf bin/ obj/
