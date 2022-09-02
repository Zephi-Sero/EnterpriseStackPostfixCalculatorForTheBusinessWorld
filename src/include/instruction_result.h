#pragma once
#include <string>
#include <tuple>

enum instruction_result_enum {
    Success,
    Error,
};

class instruction_result {
  private:
    std::string error;
    instruction_result_enum enum_part;

  public:
    void unwrap();
};
