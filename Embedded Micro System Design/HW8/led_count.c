#include <stdio.h>
#include <string.h>
#include <time.h>
#include <system.h>

#define switches (volatile char *) 0x01901050 
#define     leds (char *)          0x01901060
/** look up the SW and LED base address from SOPC builder ***/

void wait ( int s ) /* Custom wait since usleep() not available*/
{
   int u,v,sum=0;
   for (u=1;u<100000;u++)
    for (v=1;v<s;v++)
     sum+=v;
}

int SW_BITSWAP(int a) {
    int lsb, k, r=0;
    int t=a;
    for (k=0; k<8; k++) {
        lsb = t & 1;
        r = r*2 + lsb;
        t >>= 1;
    }
    return(r);
}
int main( void )
{
  int a=0;
  int b=0;
  int a_swap=0;
  int i;
  
  printf("This Homework 8 by Paul Kafka\n");
  int start_time, finish_time, total_time, speed_up, c_time;

 //
 //while (1) { /* run forever */
 //    a = *switches;
 //    
 //     a_swap = SW_BITSWAP(a);
 //
 //    //a_swap = ALT_CI_CUSTOMINSTRUCTION_INST(a,b);
 //    //a_swap = ALT_CI_BITSWAP(a);
 //    // a_swap >>=24;
 //    *leds = a_swap;
 //}
  

  //-------------------------------SW_BITSWAP----------------------------------
  start_time = alt_nticks();
  for (i=0; i<1000000; i++) {
     a = *switches;
     a_swap = SW_BITSWAP(a);
     *leds = a_swap;
  }
  finish_time = alt_nticks();
  total_time = ((finish_time - start_time)*1000) / alt_ticks_per_second();
  c_time = total_time;
  printf("SW_BITSWAP Time Used=%d ms\n", total_time);

  //------------------------------ALT_CI_CUSTOMINSTRUCTION_INST----------------
  start_time = alt_nticks();
  for (i=0; i<1000000; i++) {
     a = *switches;
     a_swap = ALT_CI_CUSTOMINSTRUCTION_INST(a,b);
     a_swap >>=24;
     *leds = a_swap;
  }
  finish_time = alt_nticks();
  total_time = ((finish_time - start_time)*1000) / alt_ticks_per_second();
  speed_up = c_time / total_time;
  printf("ALT_CI_CUSTOMINSTRUCTION_INST Time Used=%d ms\n", total_time);
  printf("ALT_CI_CUSTOMINSTRUCTION_INST Speed Up=%d ms\n", speed_up);

  //-----------------------------ALT_CI_BITSWAP------------------------------
  start_time = alt_nticks();
  for (i=0; i<1000000; i++) {
     a = *switches;
     a_swap = ALT_CI_BITSWAP(a);
     a_swap >>=24;
     *leds = a_swap;
  }
  finish_time = alt_nticks();
  total_time = ((finish_time - start_time)*1000) / alt_ticks_per_second();
  speed_up = c_time / total_time;
  printf("ALT_CI_BITSWAP Time Used=%d ms\n", total_time);
  printf("ALT_CI_CUSTOMINSTRUCTION_INST Speed Up=%d ms\n", speed_up);
  //--------------------------------------------------------------------------

  return 0;
}
