SHELL = /bin/sh
CC=g++
CFLAGS= -DTOUT -O3 -DDLIB_NO_GUI_SUPPORT -lpthread -ltiff -lexiv2 -ljpeg -fprefetch-loop-arrays -lraw -fopenmp
DEBUG_FLAG =  
DEPS = header.hpp lut.hpp matrix.hpp
OBJ = agitate.o filmulator.o read_args.o filmulate.o postprocess.o output_file.o exposure.o develop.o diffuse.o imread.o imload.o imwrite.o layer_mix.o merge_exps.o initialize.o imwrite_tiff.o imread_tiff.o imwrite_jpeg.o curves.o imread_jpeg.o time_diff.o
INSTALL_PATH = /usr/local
BINDIR = $(INSTALL_PATH)/bin
HOMECONFDIR = $(HOME)/.filmulator
INSTALL = install
INSTALLDATA = install -m 777
SRCDIR = .

%.o: %.cpp $(DEPS)
	$(CC) $(DEBUG_FLAG) -c -o $@ $< $(CFLAGS)

filmulator: $(OBJ)
	g++ $(DEBUG_FLAG) -o $@ $^ $(CFLAGS)
	
.PHONY: clean install installconf

installconf:
	mkdir -p $(HOMECONFDIR)
	cp $(SRCDIR)/configuration.txt $(HOMECONFDIR)/configuration.txt

manpage/filmulator.1.gz: manpage/filmulator
	cp manpage/filmulator manpage/filmulator.1
	gzip manpage/filmulator.1

install: filmulator manpage/filmulator.1.gz
	$(INSTALL) filmulator $(BINDIR)/filmulator
	$(INSTALL) $(SRCDIR)/batch-filmulate.sh $(BINDIR)/batch-filmulate
	mkdir -p $(INSTALL_PATH)/man/man1
	cp $(SRCDIR)/manpage/filmulator.1.gz $(INSTALL_PATH)/man/man1/filmulator.1.gz
clean:
	rm -f *.o *~ manpage/*.gz
