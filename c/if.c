/* --------------------------------------------------------------*/
/* Some C                                                        */
/* Author: Bruna Wundervald                                      */
/* Date: April, 2019                                             */
/* --------------------------------------------------------------*/

int main (void) {
  float a , b , x , y ;
  a = 376.214;
  b = 8971732.6;
  x = -b/a ;
  y = a*x + b ;

  if (a != 0 .0 ) {
      x = b/a ;
  } else if (b == 0 .0) {
      x = 1 .0 ;
  } else {
      printf( "No so lut ion !\n" ) ;
}
}
