#pragma once
#include <string>

class args {
  private:
    std::string arg_name;
    float value;

  public:
    args(std::string arg_name, float value);
    args into_arg();
};

class add_arg : public args {
  private:
    std::string arg_name;
    float value;

  public:
    add_arg(std::string arg_name, float value);
};
