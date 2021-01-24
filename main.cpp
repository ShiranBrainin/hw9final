#include "input.h"
//#include "libinput.so"
//#include "libfirewall.so"
//#include "string.h"
#include <iostream>
using namespace std;

int main(int argc, char **argv) {
	check_args(argc, argv);	
	Field f(argv[1]);
	parse_input(f);
	return 0;
}
