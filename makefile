
# Compile Stuff
projname = $(shell basename "$(shell pwd)")
# "
cc = clang++
ld = clang++
cflags = -Os -static
ldflags = -Os -static
libflags = -shared
target = x86_64-pc-linux-gnu
export_name = /$(cc)/$(target)

# Folders
objdir = ./obj
srcdir = ./src
bindir = ./bin
libbindir = ./libbin
testsdir = ./tests
headerdir = ./src/include

extension = cpp
sources = $(wildcard $(srcdir)/*.$(extension))

run: build
	$(bindir)$(export_name)/$(projname)

# Building
build: 
	$(cc) $(cflags) -c -I $(headerdir) -c $(sources)
	mv *.o $(objdir)/$(export_name)
	$(ld) $(ldflags) $(objdir)$(export_name)/*.o -target $(target) -o $(bindir)$(export_name)/$(projname)
build-lib:
	$(cc) $(cflags) -c -I $(headerdir) -c $(sources)
	mv *.o $(objdir)$(export_name)
	$(ld) $(ldflags) $(libflags) $(objdir)$(export_name)/*.o -target $(target) -o $(libbindir)$(export_name)/lib$(projname).so
	cp $(headerdir)/*.h $(testsdir)/include

# Starting
first: create-dirs
	mkdir $(testsdir)
	mkdir $(testsdir)/include
	mkdir $(srcdir)
	mkdir $(srcdir)/include
	touch $(srcdir)/main.c
	echo -e "#include <stdio.h>\n\nint main() {\n    printf(\"Hello, World!\");\n    return 0;\n}" > $(srcdir)/main.c
	touch .clang-format
	echo -e "BasedOnStyle: LLVM\nIndentWidth: 4" > .clang-format
wipe-the-whole-project-no-undoing: remove-dirs
	rm -rf $(srcdir)
	rm -rf $(testsdir)

# Cleaning
remove-dirs:
	rm -rf $(bindir)
	rm -rf $(objdir)
	rm -rf $(libbindir)
create-dirs:
	mkdir $(bindir)
	mkdir $(bindir)/$(cc)
	mkdir $(bindir)/$(export_name)
	mkdir $(bindir)/tests
	mkdir $(bindir)/tests/$(cc)
	mkdir $(bindir)/tests/$(export_name)
	mkdir $(libbindir)
	mkdir $(libbindir)/$(cc)
	mkdir $(libbindir)/$(export_name)
	mkdir $(objdir)
	mkdir $(objdir)/$(cc)
	mkdir $(objdir)/$(export_name)
	mkdir $(objdir)/tests
	mkdir $(objdir)/tests/$(cc)
	mkdir $(objdir)/tests/$(export_name)
clean: remove-dirs create-dirs
clean-build: clean build
clean-build-lib: clean build-lib
clean-run: clean run

test-name? = example-test
test-sources = $(wildcard $(testsdir)/$(test-name)/*.$(extension))
test-args = -L "$(shell pwd)/$(libbindir)$(export_name)" -l $(projname)
# Tests
test-build:	
	$(cc) -c $(cflags) -I $(testsdir)/$(test-name)/include -c $(test-sources)
	mv *.o $(objdir)/tests$(export_name)
	$(cc) $(test-args) $(objdir)/tests$(export_name)/*.o -target $(target) -o $(bindir)/tests$(export_name)/$(test-name)
test-run: test-build
	LD_LIBRARY_PATH="$(shell pwd)/$(libbindir)$(export_name)" $(bindir)/tests$(export_name)/$(test-name)
