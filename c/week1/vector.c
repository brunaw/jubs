#include <stdio.h>
#include <stdlib.h>

void add_vector(double [], double [], double []);
double *add_vector_malloc(double [], double []);
void print_vector(double x[]);

int main(void) {
	double x[3] = {1, 0, 1}, y[3], *w;

	y[0] = -1;
	y[1] = 1;
	y[2] = 1;

	double z[3];

	print_vector(x);
	print_vector(y);
	add_vector(z, x, y);
	print_vector(z);
	w = add_vector_malloc(x, y);
	print_vector(w);
	w[2] = 1.2;
	free(w);

	return 0;
}

void add_vector(double result[], double a[], double b[]) {
	for (int i = 0; i < 3; i++)
		result[i] = a[i] + b[i];
	return;
}

double *add_vector_malloc(double *a, double *b) {
	double *result;

	result = malloc(sizeof(double)*3);
	for (int i = 0; i < 3; i++)
		result[i] = a[i] + b[i];
	return result;
}

void print_vector(double x[]) {
	printf("[ ");
	for (int i = 0; i < 3; i++)
		printf("%lf ", x[i]);
	printf("]\n");
}
