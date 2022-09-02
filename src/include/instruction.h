#pragma once
#include "instruction_result.h"
#include <string>
#include <vector>
using namespace std;

class instruction {
  public:
    instruction_result apply_instruction(vector<float> &stack);
};

class add_instruction : public instruction {
  private:
    float value;

  public:
    add_instruction(float value);
    instruction_result apply_instruction(vector<float> &stack);
};
