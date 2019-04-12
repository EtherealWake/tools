#include "tools/cpp/testlib.hpp"
#include <iostream>

namespace tools::cpp {

int test_core(const char* msg) {
  std::cout << msg << std::endl;
  return 0;
}

}  // namespace tools::cpp
