#pragma once
#include "args.h"
#include <string>

class args_factory {
  private:
    std::string arg_name;
    float value;

  public:
    args_factory(std::string arg_name, float value);
    args_factory into_arg_factory();
    args into_args();
};

class add_arg_factory : public args_factory {
  private:
    std::string arg_name;
    float value;

  public:
    add_arg_factory(std::string arg_name, float value);
    args into_args();
};
