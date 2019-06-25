#include <math.h>
#include <stdio.h>

int main(void) {
	float fahr;

	for (fahr = 0; fahr <= 300; fahr += 20)
		printf("%f -> %f\n", fahr, round(5*(fahr-32)/9));

	return 0;
}
