#include "include/instruction_factory.h"
#include "include/instruction.h"
#include <vector>

add_instruction_factory::add_instruction_factory(float value) {
    instruction_name = "add";
    this->value = value;
}

instruction add_instruction_factory::create_instruction() {
    return add_instruction(this->value);
}
