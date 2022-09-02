#pragma once
#include "instruction.h"
#include <string>
#include <vector>

class instruction_factory {
  private:
    std::string instruction_name;
};

class add_instruction_factory : public instruction_factory {
  private:
    std::string instruction_name;
    float value;

  public:
    add_instruction_factory(float value);
    instruction create_instruction();
};
