#include "rpds_de_test.h"

static void buttons_isr( void* context, alt_u32 id ) {
  volatile int *function = (volatile int*) context;
  
  *function = IORD_ALTERA_AVALON_PIO_EDGE_CAP( BUTTONS_BASE );
  IOWR_ALTERA_AVALON_PIO_EDGE_CAP( BUTTONS_BASE, 0 );
  IOWR_ALTERA_AVALON_PIO_IRQ_MASK( BUTTONS_BASE, 0xF );
}

void lcd_init( void ) {
  /* Set Function Code Four Times -- 8-bit, 2 line, 5x7 mode */
  IOWR( LCD_BASE, LCD_WR_COMMAND_REG, 0x38 );
  usleep(4100);   /* Wait 4.1 ms */
  IOWR( LCD_BASE, LCD_WR_COMMAND_REG, 0x38 );
  usleep(100);    /* Wait 100 us */
  IOWR( LCD_BASE, LCD_WR_COMMAND_REG, 0x38 );
  usleep(5000);   /* Wait 5.0 ms */
  IOWR( LCD_BASE, LCD_WR_COMMAND_REG, 0x38 );
  usleep(100);
  /* Set Display to OFF */
  IOWR( LCD_BASE, LCD_WR_COMMAND_REG, 0x08 );
  usleep(100);
  /* Set Display to ON */
  IOWR( LCD_BASE, LCD_WR_COMMAND_REG, 0x0C );
  usleep(100);
  /* Set Entry Mode -- Cursor increment, display doesn't shift */
  IOWR( LCD_BASE, LCD_WR_COMMAND_REG, 0x06 );
  usleep(100);
  /* Set the cursor to the home position */
  IOWR( LCD_BASE, LCD_WR_COMMAND_REG, 0x02 );
  usleep(2000);
  /* Clear the display */
  IOWR( LCD_BASE, LCD_WR_COMMAND_REG, 0x01 );
  usleep(2000);
}

void customChar(int ** cChar, int pos) {
	int i;
	IOWR (LCD_BASE, LCD_WR_COMMAND_REG, 0x48 + (pos *8));
	usleep(10000);
	
	for (i=0; i<8; i++) {
		IOWR(LCD_BASE, LCD_WR_DATA_REG, cChar[i]);
		usleep(100);
	}

	IOWR( LCD_BASE, LCD_WR_COMMAND_REG, 0x80 + pos);
	usleep(100);
	
	IOWR(LCD_BASE, LCD_WR_DATA_REG, pos +1);
	usleep(500000);
}

int main( void ) {
  int * person[8] = { 0x04, 0x0e, 0x1b, 0x04, 0x04, 0x0a, 0x1b, 0x00};
  int * face[8] = { 0x1f, 0x00, 0x1b, 0x00, 0x0e, 0x00, 0x1f, 0x00 };
  
  while (1) {
	lcd_init();
	customChar(person, 0x00);
	customChar(face, 0x01);
  }
  return(0);
}

  