#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {

  FILE* fptr = fopen(argv[1],"r"); /* opening file passed by the cmd */
  if(fptr == NULL){ /* checking if file is something */
    perror("fopen");
    exit(EXIT_FAILURE);
  }

  char ch;
  int w = 0;

  fptr = fopen(argv[1], "r"); /* actually opening it */
  if (fptr == NULL) { /* checking if it worked */
    printf("can't open file");
  }
  else {
    ch = fgetc(fptr);
    while (ch != EOF) {  /* counting the words (separated by space or \n) */
      if (ch == ' ' || ch == '\n') {
        w++;
      }
      ch = fgetc(fptr);
    }
    printf("Words in song are = %d", w); /* returning the results */
  }
  fclose(fptr);
}
