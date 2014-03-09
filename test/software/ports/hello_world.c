/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include "unistd.h"
#include "system.h"
#include "altera_avalon_pio_regs.h"
#define bit(x) (1 << (x))
#define set_val IOWR(PORTA_BASE,0,bit(3));
int main()
{
	int button;
	IOWR(PORTA_BASE,1,0XFF);
	while(1){

	//button = IORD(PORTA_BASE,1);
	set_val;
	}

  return 0;
}
