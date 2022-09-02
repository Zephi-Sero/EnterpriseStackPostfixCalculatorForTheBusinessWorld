
# Compile Stuff
projname = $(shell basename "$(shell pwd)")
# "
cc = clang++
ld = clang++
ccflags = -Os -static
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
build: create-dirs
	$(cc) $(ccflags) -c -I $(headerdir) $(sources)
	mv *.o $(objdir)/$(export_name)
	$(ld) $(ldflags) $(objdir)$(export_name)/*.o -target $(target) -o $(bindir)$(export_name)/$(projname)
build-lib: create-dirs
	$(cc) $(ccflags) -c -I $(headerdir) $(sources)
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
	mkdir -p $(bindir)
	mkdir -p $(bindir)/$(cc)
	mkdir -p $(bindir)/$(export_name)
	mkdir -p $(bindir)/tests
	mkdir -p $(bindir)/tests/$(cc)
	mkdir -p $(bindir)/tests/$(export_name)
	mkdir -p $(libbindir)
	mkdir -p $(libbindir)/$(cc)
	mkdir -p $(libbindir)/$(export_name)
	mkdir -p $(objdir)
	mkdir -p $(objdir)/$(cc)
	mkdir -p $(objdir)/$(export_name)
	mkdir -p $(objdir)/tests
	mkdir -p $(objdir)/tests/$(cc)
	mkdir -p $(objdir)/tests/$(export_name)
clean: remove-dirs
clean-build: clean build
clean-build-lib: clean build-lib
clean-run: clean run

test-name? = example-test
test-sources = $(wildcard $(testsdir)/$(test-name)/*.$(extension))
test-args = -L "$(shell pwd)/$(libbindir)$(export_name)" -l $(projname)
# Tests
test-build: create-dirs
	$(cc) -c $(ccflags) -I $(testsdir)/$(test-name)/include $(test-sources)
	mv *.o $(objdir)/tests$(export_name)
	$(cc) $(test-args) $(objdir)/tests$(export_name)/*.o -target $(target) -o $(bindir)/tests$(export_name)/$(test-name)
test-run: test-build
	LD_LIBRARY_PATH="$(shell pwd)/$(libbindir)$(export_name)" $(bindir)/tests$(export_name)/$(test-name)
