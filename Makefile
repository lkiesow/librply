INSTPATH=/usr/local/lib
INCPATH=/usr/local/include

lib: src/lib/rply.c src/lib/rply.h src/lib/rplyfile.h
	mkdir -p obj/ bin/
	gcc -Wall -c -fPIC src/lib/rply.c -o obj/rply.o
	gcc -shared -Wl,-soname,librply.so -o bin/librply.so obj/rply.o

test: lib src/tools/*.c 
	mkdir -p bin/
	gcc src/tools/dump.c       -lrply -Isrc -Lbin -o bin/dump
	gcc src/tools/convert.c    -lrply -Isrc -Lbin -o bin/convert
	gcc src/tools/sconvert.c   -lrply -Isrc -Lbin -o bin/sconvert
	gcc src/tools/create_ply.c -lrply -Isrc -Lbin -o bin/create_ply
	cp src/etc/input.ply bin/input.ply

install: lib
	@echo Installing library to ${INSTPATH}
	@mkdir -p ${INSTPATH}
	@cp -f bin/librply.so ${INSTPATH}
	@chmod 755 ${INSTPATH}/librply.so
	@echo Installing header to ${INCPATH}
	@cp -f src/lib/rply.h ${INCPATH}

uninstall:
	@echo Deleting ${INSTPATH}/librply.so
	@rm -f ${INSTPATH}/librply.so
	@echo Deleting ${INCPATH}/rply.h
	@rm -f ${INCPATH}/rply.h

clean:
	rm -rf bin/ obj/
