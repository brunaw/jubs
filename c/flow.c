/* --------------------------------------------------------------*/
/* Some C                                                        */
/* Author: Bruna Wundervald                                      */
/* Date: April, 2019                                             */
/* --------------------------------------------------------------*/

/* while (fahr <= upper) {  */
/*        celsius = 5*( fahr − 32) / 9 ;  */
/*        printf ("%d −> %d\n" , fahr , celsius) ; */
/*        fahr = fahr + step ; */
/* }                      */

int main (void) {
      int fahr, celsius ;
      int lower , upper , step ;
      lower = 0 ;
      upper = 300;
      step = 20;
      fahr = lower ;

      for(fahr = lower; fahr <= upper; fahr = fahr + step) {
            celsius = 5*( fahr - 32) / 9 ;
            printf ( "%d −> %d\n" , fahr , celsius) ;
      }
}
