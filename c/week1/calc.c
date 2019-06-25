#include <stdio.h>

int main(void) {
	float a, b, x, y;

	a = 376.214;
	b = 8971732.6;
	if (a != 0) {
		x = -b/a;
	} else {
		printf("Can't solve the equation\n");
		return 1;
	}
	y = a*x + b;

	printf("The value of x was %f and y was %f\n", x, y);

	return 0;
}
