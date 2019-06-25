/*
 * Keep reading numbers from a file called 'data' and while we can read
 * numbers, add them up.
 */

#include <stdio.h>

int main(void) {
	double sum;
	double x;
	FILE *in, *out;

	in = fopen("data", "r");
	if (in == NULL) {
		printf("Couldn't open the file.\n");
		return 1;
	}
	out = fopen("sum", "w");
	if (out == NULL) {
		printf("Couldn't open the output file.\n");
		return 1;
	}
	sum = 0;
	while (fscanf(in, "%lf", &x) == 1) {
		sum += x;
	}

	fprintf(out, "The sum of the numbers was %lf\n", sum);

	fclose(in);
	fclose(out);
	
	return 0;
}
