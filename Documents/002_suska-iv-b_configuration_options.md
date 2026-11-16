# Suska-IV-B Configuration Options

This is the header of the top level file of the `SUSKA-IV-B` vhdl model. It contains all relevant information about the hardware and its configuration and parameterization options. These settings are subject to change in future releases. Refer to the latest top level files to get the latest informations.

---

## Top Level VHDL Header

```vhdl
------------------------------------------------------------------------
----                                                                ----
---- Atari Falcon compatible IP Core for the Suska-IV-F board.      ----
----                                                                ----
---- This file is part of the SUSKA ATARI clone project.            ----
---- [http://www.experiment-s.de](http://www.experiment-s.de)                                     ----
----                                                                ----
---- Description:                                                   ----
---- This model provides the top level file of a Falcon compatible  ----
---- machine including CPU, Blitter, MCU, DMA, Shifter, GLUE,       ----
---- MFP, SOUND, ACIA and RTC. The CPU in this core is the 68K30.   ----
----                                                                ----
---- This toplevel file targets system hardware which is equipped   ----
---- with a Cyclone 10 FPGA of Altera/Intel and a 32 bit wide SDRAM ----
---- organized as 4 banks x 4MBit x 32, 512Mb it total.             ----
----                                                                ----
---- Important Notice concerning the clock system:                  ----
---- The systems of the original Falcon machines uses several       ----
---- clocks which must stand in a fixed relation to each other.     ----
---- This core uses one central system clock of 16MHz. From this    ----
---- clock all required clocks are derived. Each phase locked loop  ----
---- generates several output clocks. Refer to the PLL instances    ----
---- I_SYSCLOCKS and I_AUXCLOCKS for detailed information.          ----
----                                                                ----
---- The phase locked loops are customer / hardware specific        ----
---- components and therefore declared in this top level file.      ----
---- In this way the migration to other FPGA hardware is simple by  ----
---- modifying the top level file to meet the requirements of the   ----
---- selected FPGA.                                                 ----
----                                                                ----
---- Recommendations for the signal termination:                    ----
----  Some signals should be terminated with a weak pull up         ----
----  resistor (~22K). This feature is optional and can be selected ----
----  in the assignment editor of the IDE (Integrated Development   ----
----  Environment). In the entity all signals which are recommended ----
----  to be wired with sucha termination are marked as 'Use weak    ----
----  pull up.'                                                     ----
----                                                                ----
---- Falcon machines use half moon switches which select features.  ----
---- In this core the half moons are modelled generic and have the  ----
---- following functionality:                                       ----
---- The bits are low active.                                       ----
----   HALFMOON_I(8)    : '0' = DMA sound off.                      ----
----   HALFMOON_I(7)    : '0' = HD type Floppy.                     ----
----   HALFMOON_I(6)    : '0' = Quad Density Floppy.                ----
----   HALFMOON_I(5)    : reserved.                                 ----
----   HALFMOON_I(4)    : reserved.                                 ----
----   HALFMOON_I(3)    : reserved.                                 ----
----   HALFMOON_I(2)    : reserved.                                 ----
----   HALFMOON_I(1)    : reserved.                                 ----
----                                                                ----
----   HALFMOON_II(8)   : Monitor Type Y1.                          ----
----   HALFMOON_II(7)   : Monitor Type Y0.                          ----
----   HALFMOON_II(6)   : DRAM1.                                    ----
----   HALFMOON_II(5)   : DRAM0.                                    ----
----   HALFMOON_II(4)   : ROM Wait State Setting.                   ----
----   HALFMOON_II(3)   : ROM Wait State Setting.                   ----
----   HALFMOON_II(2)   : 16/32 Bit Video Bus.                      ----
----   HALFMOON_II(1)   : RAM Wait State.                           ----
----                                                                ----
---- $FFFF8006 [R/W] B 76543210  HALFMOONS_II register listing      ----
----                   ||||||||                                     ----
----                   |||||||+- RAM Wait Status                    ----
----                   |||||||   0 =  1 Wait (default)              ----
----                   |||||||   1 =  0 Wait                        ----
----                   ||||||+-- Video Bus Width                    ----
----                   ||||||    0 = 16 Bit                         ----
----                   ||||||    1 = 32 Bit (default)               ----
----                   ||||++--- ROM Wait States                    ----
----                   ||||      00 = Reserved                      ----
----                   ||||      01 =  2 Wait (default)             ----
----                   ||||      10 =  1 Wait                       ----
----                   ||||      11 =  0 Wait                       ----
----                   ||++----- RAM Size                           ----
----                   ||        01 =  4 MB                         ----
----                   ||        10 = 16 MB                         ----
----                   ++------- Monitor-Type                       ----
----                             00 Monochrom                       ----
----                             01 RGB Colour Monitor              ----
----                             10 VGA Colour Monitor              ----
----                             11 Televisio (over Modulator)      ----
----                                                                ----
---- The SLOW_CPU feature is enabled by the CLK_CPU switch. In the  ----
---- original Falcon hardware the CPU clock is switched from 16MHz  ----
---- to 8MHz. In this core we do not use such gated clocks but slow ----
---- down the CPU with waitstates during bus access.                ----
----                                                                ----
---- This core features the SCC serial communication controller.    ----
---- It works in the CLK_16M0 domain. Be aware that the baud rate   ----
---- generator feeds baud rates twice the values of the original    ----
---- Falcon SCC chips which are operated at a clock rate of 8MHz.   ----
----                                                                ----
---- The B-IV hardware has ten configuration switches which provide ----
---- the following features:                                        ----
---- Config Switch 1 and 2 (1 is leftmost on the F board) are       ----
---- intended to select the connected monitor as follows:           ----
----   "11" : TV via modulator (not supported by the B  board).     ----
----   "10" : We use a VGA monitor.                                 ----
----   "01" : We use a RGB colour monitor.                          ----
----   "00" : We use a monochrome monitor (SM124).                  ----
---- Config Switch 3 to 6 switches 1 from 16 operating system flash ----
---- space. x"0" is the lowest address block and x"F" the highest.  ----
---- The size of each address block is 256k x 16 bit. The selector  ----
---- switches are arranged in binary order. Switch 3 is MSB and     ----
---- switch 6 is LSB.                                               ----
---- Config Switch 7  : ON disables the 68K30 caches.               ----
---- Config Switch 8  : ON disables the 68K30 MMU.                  ----
---- Config Switch 9  : ON = ALTRAM enabled.                        ----
---- Config Switch 10 : reserved for future use.                    ----
----                                                                ----
------------------------------------------------------------------------
----                                                                ----
---- Copyright © 2025... Wolfgang Foerster - Inventronik GmbH.      ----
----                                                                ----
---- All rights reserved. No portion of this sourcecode may be      ----
---- reproduced or transmitted in any form by any means, whether    ----
---- by electronic, mechanical, photocopying, recording or          ----
---- otherwise, without my written permission.                      ----
----                                                                ----
------------------------------------------------------------------------
--
-- Revision History
--
-- Revision 2K25A 20250620 WF
--   Initial Release.
-- Revision 2K25B 20251224
--   We have no a generic switch NO_IDE for compatibility reasons (HDDRIVER).
--
--   !!! See the header for actual configuration switch settings!!!

library work;
use work.SUSKA_CORE_B_FALCON_PKG.all;
use work.COMBEL_PKG.all; -- Required for RAMWIDTH_TYPE.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SUSKA_IV_B_FALCON_68K30_TOP is
    generic(CORETYPE                : std_logic_vector(15 downto 0) := x"0730"; -- Core Type is 'Board IV Suska-Falcon-68K30'.
            VERSION                 : std_logic_vector(31 downto 0) := x"20250620"; -- Core version.
            HALFMOONS_I             : std_logic_vector(8 downto 1) := x"BF"; -- Configuration switches.
            HALFMOONS_II            : std_logic_vector(6 downto 1) := "101111"; -- Configuration switches. The upper two significant bits are now CONFIG(1 to 2).
            NO_FLOPPY               : boolean := true; -- Set true to disable floppy on SD card otherwise false.
            NO_IDE                  : boolean := true; -- Set true if there is no IDE hardware.
            BUS_WIDTH               : RAMWIDTH_TYPE := L32; -- CPU-RAM data width used. Valid values are L32, W16, B8.
            RAM_16                  : boolean := false; -- For this Falcon core we have 32 wide RAM. So the only choice is 'false'.
            DMA_ACSI_FIFO_DEPTH     : integer := 16; -- Number of registers.
            DMA_REPLAY_FIFO_DEPTH   : integer := 16; -- Number of registers.
            DMA_CAPTURE_FIFO_DEPTH  : integer := 16; -- Number of registers.
            MFP_UART_FIXED_SPEED    : boolean := true; -- Set true to use fixed Speed 38400 baud.
            USB1164_LITTLE_ENDIAN   : boolean := false); 

    port(
```
