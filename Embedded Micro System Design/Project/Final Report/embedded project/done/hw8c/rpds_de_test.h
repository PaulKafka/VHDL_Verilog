#ifndef RPDS_DE_TEST_H_
#define RPDS_DE_TEST_H_

#include <stdio.h>
#include <unistd.h>
#include "system.h"
#include "alt_types.h"
#include "sys/alt_irq.h"
#include "sys/alt_flash.h"
#include "altera_avalon_pio_regs.h"

#ifdef LCD_NAME
    /* LCD constants */
    #define LCD_WR_COMMAND_REG  0
    #define LCD_WR_DATA_REG     2
#endif

/* Memory constants */
#define SRAM_MAX_WORDS       8000
#define FLASH_MAX_WORDS      1000
#define SDRAM_MAX_WORDS      1000000


#endif /*RPDS_DE_TEST_H_*/
