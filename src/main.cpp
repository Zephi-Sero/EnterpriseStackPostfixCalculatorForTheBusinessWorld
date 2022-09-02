#include "include/args.h"
#include "include/args_factory.h"
#include <iostream>

int main() {
    args add_arg =
        args_factory("add", 10.0).into_arg_factory().into_args().into_arg();
    return 0;
}
