#include <stdio.h>

double f(double);

int main(void) {
	double x[10], y;

	x[3] = 6;
	y = f(x[3]);
	printf("%lf\n", y);
	return 0;
}

double f(double z) {
	z++;
	return z*z;
}
