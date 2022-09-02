#include "include/instruction_result.h"
#include "include/panic.h"
#include <tuple>
using namespace std;

void instruction_result::unwrap() {
    if (this->enum_part == instruction_result_enum::Success) {
    } else {
        panic(this->error);
    }
}
