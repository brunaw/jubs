#include <stdio.h>
#include <math.h>

double quad(double, double, double, double);

int main(void) {
	double a, b, c;
	double x[2];
	int i, number_of_roots;

	printf("Please enter a, b and c: ");
	if (scanf("%lf %lf %lf", &a, &b, &c) != 3) {
		printf("You didn't enter three numbers\n");
		return 1;
	}
	printf("The quadratic is %lf x^2 + %lf x + %lf\n", a, b, c);

	x[0] = (-b + sqrt(b*b - 4*a*c))/(2*a);
	x[1] = (-b - sqrt(b*b - 4*a*c))/(2*a);
	number_of_roots = 2;
	for (i = 0; i < number_of_roots; i++)
		printf("x[%d] was %g where the value is %g\n", i, x[i],
		    quad(a, b, c, x[i]));

	return 0;
}

double quad(double a, double b, double c, double x) {
	return a*x*x + b*x + c;
}

