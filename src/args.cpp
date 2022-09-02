#include "include/args.h"
#include "include/panic.h"
#include <string>

args::args(std::string arg_name, float value) {
    this->arg_name = arg_name;
    this->value = value;
}

args args::into_arg() {
    if (this->arg_name == "add") {
        return add_arg(this->arg_name, this->value);
    } else {
        panic("Invalid Argument");
        return *this;
    }
}

add_arg::add_arg(std::string arg_name, float value) : args(arg_name, value) {}
