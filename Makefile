INSTPATH=/usr/local/lib
INCPATH=/usr/local/include
LIBSRC=src/lib
TOOLSRC=src/tools

lib: obj
	mkdir -p bin
	gcc -shared -Wl,-soname,librply.so -o bin/librply.so obj/rply.o

obj: ${LIBSRC}/*.h ${LIBSRC}/*.c
	mkdir -p obj
	gcc -Wall -c -fPIC ${LIBSRC}/rply.c -o obj/rply.o

tools: lib ${TOOLSRC}/*.c
	mkdir -p bin/
	gcc ${TOOLSRC}/dump.c       -lrply -I${LIBSRC} -Lbin -o bin/dump
	gcc ${TOOLSRC}/convert.c    -lrply -I${LIBSRC} -Lbin -o bin/convert
	gcc ${TOOLSRC}/sconvert.c   -lrply -I${LIBSRC} -Lbin -o bin/sconvert
	gcc ${TOOLSRC}/create_ply.c -lrply -I${LIBSRC} -Lbin -o bin/create_ply
	cp ${TOOLSRC}/input.ply bin/input.ply

test: tools
	cd bin && LD_LIBRARY_PATH=. ./create_ply
	cd bin && LD_LIBRARY_PATH=. test -f new.ply
	cd bin && LD_LIBRARY_PATH=. ./dump new.ply > /dev/null
	cd bin && LD_LIBRARY_PATH=. ./sconvert
	cd bin && LD_LIBRARY_PATH=. ./convert -l input.ply out.ply
	cd bin && LD_LIBRARY_PATH=. rm -f out.ply output.ply new.ply


install: lib
	@echo Installing library to ${INSTPATH}
	@mkdir -p ${INSTPATH}
	@cp -f bin/librply.so ${INSTPATH}
	@chmod 755 ${INSTPATH}/librply.so
	@echo Installing header to ${INCPATH}
	@cp -f ${LIBSRC}/rply.h ${INCPATH}

uninstall:
	@echo Deleting ${INSTPATH}/librply.so
	@rm -f ${INSTPATH}/librply.so
	@echo Deleting ${INCPATH}/rply.h
	@rm -f ${INCPATH}/rply.h

clean:
	rm -rf bin/ obj/
