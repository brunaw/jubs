/*
 * This is a program that plays a guessing game.
 */
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define RANGE 100
#define PI 3.14139
#define DEG2RAD(x) (x*(PI/180.0))

int main(void) {
	int secret, guess, tries;

	srand(time(NULL));
	secret = (rand()%RANGE) + 1; /* Pick a number between 1 and 100 */

	tries = 0; // They haven't had any tries yet.
	do {
		printf("Make a guess: ");
		if (scanf("%d", &guess) != 1) {
			printf("That wan't a number.\n");
			return 1;
		}
		if (secret > guess)
			printf("Higher\n");
		if (secret < guess)
			printf("Lower\n");
		tries++;
	} while (secret != guess);

	printf("You took %d tries\n", tries);

	return 0;
}
