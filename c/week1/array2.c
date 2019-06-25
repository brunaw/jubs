#include <stdio.h>

double g(double []);
void zero_vector(double []);

int main(void) {
	double x[10], y;

	x[0] = 3;
	x[1] = 4;
	y = g(x);
	printf("%lf %lf %lf\n", x[0], x[1], y);
	zero_vector(x);
	printf("%lf %lf %lf\n", x[0], x[1], y);
	
	return 0;
}

double g(double z[]) {
	z[0]++;
	return z[0] + z[1];
}

void zero_vector(double x[]) {
	int i;

	for (i = 0; i < 10; i++)
		x[i] = 0;

	return;
}
