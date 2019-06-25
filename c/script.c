/* --------------------------------------------------------------*/
/* Some C                                                        */
/* Author: Bruna Wundervald                                      */
/* Date: April, 2019                                             */
/* --------------------------------------------------------------*/

/* Write a program to solve the equation ax + b = 0 */
/* for x, where a = 376.214 and b = 8971732.6. */

#include <stdio.h>
int main (void) {
         float a , b , x , y ;
         a = 376.214;
         b = 8971732.6;
         x = -b/a ;
         y = a*x + b ;
         printf("%f %f \n" , x , y) ;
         return 0 ;
}
