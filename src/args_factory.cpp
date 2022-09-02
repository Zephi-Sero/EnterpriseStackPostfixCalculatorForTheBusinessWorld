#include "include/args_factory.h"
#include "include/args.h"
#include "include/panic.h"
#include <string>

args_factory::args_factory(std::string arg_name, float value) {
    this->arg_name = arg_name;
    this->value = value;
}

args_factory args_factory::into_arg_factory() {
    if (this->arg_name == "add") {
        return add_arg_factory(this->arg_name, this->value);
    } else {
        panic("Invalid Args Type");
        return *this;
    }
}

args args_factory::into_args() { return args(this->arg_name, this->value); }

add_arg_factory::add_arg_factory(std::string arg_name, float value)
    : args_factory(arg_name, value) {}
