  --Example instantiation for system 'nios32'
  nios32_inst : nios32
    port map(
      LCD_E_from_the_lcd => LCD_E_from_the_lcd,
      LCD_RS_from_the_lcd => LCD_RS_from_the_lcd,
      LCD_RW_from_the_lcd => LCD_RW_from_the_lcd,
      LCD_data_to_and_from_the_lcd => LCD_data_to_and_from_the_lcd,
      SRAM_ADDR_from_the_sram => SRAM_ADDR_from_the_sram,
      SRAM_CE_N_from_the_sram => SRAM_CE_N_from_the_sram,
      SRAM_DQ_to_and_from_the_sram => SRAM_DQ_to_and_from_the_sram,
      SRAM_LB_N_from_the_sram => SRAM_LB_N_from_the_sram,
      SRAM_OE_N_from_the_sram => SRAM_OE_N_from_the_sram,
      SRAM_UB_N_from_the_sram => SRAM_UB_N_from_the_sram,
      SRAM_WE_N_from_the_sram => SRAM_WE_N_from_the_sram,
      address_to_the_flash => address_to_the_flash,
      data_to_and_from_the_flash => data_to_and_from_the_flash,
      out_port_from_the_LEDS => out_port_from_the_LEDS,
      read_n_to_the_flash => read_n_to_the_flash,
      select_n_to_the_flash => select_n_to_the_flash,
      txd_from_the_uart => txd_from_the_uart,
      write_n_to_the_flash => write_n_to_the_flash,
      zs_addr_from_the_sdram => zs_addr_from_the_sdram,
      zs_ba_from_the_sdram => zs_ba_from_the_sdram,
      zs_cas_n_from_the_sdram => zs_cas_n_from_the_sdram,
      zs_cke_from_the_sdram => zs_cke_from_the_sdram,
      zs_cs_n_from_the_sdram => zs_cs_n_from_the_sdram,
      zs_dq_to_and_from_the_sdram => zs_dq_to_and_from_the_sdram,
      zs_dqm_from_the_sdram => zs_dqm_from_the_sdram,
      zs_ras_n_from_the_sdram => zs_ras_n_from_the_sdram,
      zs_we_n_from_the_sdram => zs_we_n_from_the_sdram,
      clk_0 => clk_0,
      in_port_to_the_buttons => in_port_to_the_buttons,
      in_port_to_the_switches => in_port_to_the_switches,
      reset_n => reset_n,
      rxd_to_the_uart => rxd_to_the_uart
    );


