#include "include/panic.h"
#include <cstdio>
#include <cstdlib>

void panic(std::string error) {
    fprintf(stderr, "%s", error.c_str());
    exit(1);
}
