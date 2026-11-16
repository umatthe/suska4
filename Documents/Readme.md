# Suska-IV-B Documentation

Welcome to the documentation repository for the **Suska-IV-B** (Atari Falcon-compatible FPGA platform) and related Suska boards[cite: 1]. Rather than a traditional monolithic manual, this collection is organized into focused, modular guides reflecting the ongoing development of the FPGA IP core and microcontroller firmware[cite: 1].

---

## Table of Contents

| # | Document | Description |
| :--- | :--- | :--- |
| `000` | [000_a_leaflet.md](000_a_leaflet.md) | Quick welcome flyer, project links, downloads, and shop accessories (DE/EN)[cite: 1] |
| `001` | [001_a_first_time_attachment_to_suska-iv-b.md](001_a_first_time_attachment_to_suska-iv-b.md) | Hardware overview: power supply, case opening, front LEDs, buttons, and RTC battery (DE/EN)[cite: 1] |
| `002` | [002_suska-iv-b_configuration_options.md](002_suska-iv-b_configuration_options.md) | Top-level VHDL entity header with DIP switches (`CONFIG 1–10`), Halfmoon registers, and generics[cite: 1] |
| `003` | [003_configuration_of_the_fpga.md](003_configuration_of_the_fpga.md) | Methods for loading FPGA cores (microcontroller/SD, Active Serial `.pof`, JTAG `.sof`, `.jic`)[cite: 1] |
| `004` | [004_howto-compile-fpga.md](004_howto-compile-fpga.md) | Overview of the FPGA synthesis, Place & Route, assembler, and timing analysis workflow[cite: 1] |
| `005` | [005_firmware-readme.md](005_firmware-readme.md) | Microcontroller directory layout, MCU fuse settings, and `avrdude` flashing commands[cite: 1] |
| `006` | [006_firmware-userguide.md](006_firmware-userguide.md) | Complete reference for `fpga-shell` serial commands (`38400 8N1`) and flash workflows[cite: 1] |
| `007` | [007_tos_suska-iv-b.md](007_tos_suska-iv-b.md) | Flash memory map for the 16 OS slots and cartridge address spaces (`0xFA0000`–`0xFDFFFF`)[cite: 1] |
| `008` | [008_mkrom-b4.md](008_mkrom-b4.md) | Example Linux `cat` command to concatenate sixteen 512 KB TOS/EmuTOS images into a flash ROM[cite: 1] |
| `009` | [009_howto-emutos.md](009_howto-emutos.md) | Building EmuTOS with 32-bit Blitter/ALTRAM support and disabled SCSI (`localconf.h`)[cite: 1] |
| `010` | [010_howto-patch-tos404.md](010_howto-patch-tos404.md) | Patching a TOS 4.04 binary for Suska-IV-B using `TOSPATCH.TTP` and `404_BF.FIL`[cite: 1] |
| `011` | [011_howto-try-a-tos.md](011_howto-try-a-tos.md) | Testing a 512 KB TOS image in ShadowRAM via `TESTTOS.PRG` and transferring via `UIPWIFI.TOS`[cite: 1] |
| `012` | [012_shadow_ram.md](012_shadow_ram.md) | Using Shadow TOS (`SH-*.PRG` and `COLDROM.PRG`) across Suska boards[cite: 1] |
| `013` | [013_howto-sd-cards.md](013_howto-sd-cards.md) | Creating and partitioning bootable SD card hard disk images for EmuTOS and TOS[cite: 1] |
| `014` | [014_howto-usb-subsystem.md](014_howto-usb-subsystem.md) | 4-port `ISP1164` USB root hub architecture and Lightning driver notes[cite: 1] |
| `015` | [015_howto-wifi.md](015_howto-wifi.md) | Internal `picoWifi` Micro-USB hardware setup, Lightning drivers, `UIPWIFI.TOS`, and FreeMiNT[cite: 1] |
| `016` | [016_keyboards_and_mice.md](016_keyboards_and_mice.md) | Input device options (PS/2 option vs. USB subsystem)[cite: 1] |
| `017` | [017_xtool.md](017_xtool.md) | Placeholder for `xtool` documentation[cite: 1] |

---

## Hardware Quick Reference (`Suska-IV-B`)

* **Power Supply:** `5V` via USB-C (`< 500 mA` typical; a power supply rated at `1.5 A` or higher is recommended)[cite: 1].
* **FPGA & Core:** Altera/Intel Cyclone 10 FPGA with 32-bit wide SDRAM (`512 Mb` total) running a `68K30` Atari Falcon-compatible IP core[cite: 1].
* **RTC Battery:** Coin cell **Renata 364**, **Varta 364**, or compatible[cite: 1].
* **Buttons:**
  * **Right Button:** Long press (`~2 s`) powers the board on/off; short press triggers a Falcon reset[cite: 1].
  * **Short-Actuator Button:** Resets the FPGA directly (not needed during normal operation)[cite: 1].
* **Opening the Enclosure:** Remove the rear panel, unscrew the knurled nut on the audio jack, and slide the PCB out toward the rear (required to access internal headers and configuration switches)[cite: 1].

### Front Status LEDs

> **Note:** Starting with FPGA core revision `2K25B...`, the functions of the **green** and **red** LEDs are swapped (as reflected in the English hardware guide)[cite: 1].

| LED (Rev. `2K25B+` / Legacy) | Function |
| :--- | :--- |
| **Green** *(Legacy: Blue)* | Blinks on SD card insertion to indicate card type (`slow` = SDSC, `medium` = SDHC, `fast` = SDXC), then stays solidly lit when ready[cite: 1] |
| **Red** *(Legacy: Yellow)* | Lights up during SD card read/write access (alternating blinks with the card-type LED indicate an SD access error)[cite: 1] |
| **Blue** *(Legacy: Green)* | Indicates an IP-core error (specifically unlocked PLLs)[cite: 1] |
| **Yellow** *(Legacy: Red)* | Permanent power indicator[cite: 1] |

### Configuration DIP Switches (`CONFIG 1–10`)

| Switch | Function |
| :---: | :--- |
| `1 – 2` | **Monitor Type:** `10` = VGA, `01` = RGB color, `00` = Monochrome (`SM124`), `11` = TV modulator *(not supported on B-board)*[cite: 1] |
| `3 – 6` | **OS Flash Bank (`0x0`–`0xF`):** Binary selector (`Switch 3` = MSB, `Switch 6` = LSB) for 1 of 16 × 512 KB OS slots[cite: 1] |
| `7` | `ON` = Disables `68K30` CPU caches[cite: 1] |
| `8` | `ON` = Disables `68K30` MMU[cite: 1] |
| `9` | `ON` = Enables `48 MB` ALTRAM[cite: 1] |
| `10` | Reserved for future use[cite: 1] |

---

## Default OS Flash Layout (`r-b4.img`)

The 8 MB OS flash holds sixteen `512 KB` (`0x080000`) slots selectable via DIP switches `3–6`[cite: 1]:

| Switch | Offset | Image / OS | Notes |
| :---: | :---: | :--- | :--- |
| `0000`–`0001` | `0x000000`–`0x080000` | *(empty)* | Reserved[cite: 1] |
| `0010` / `0011` | `0x100000` / `0x180000` | `tos162de` / `tos162uk` | TOS 1.62 (DE / UK)[cite: 1] |
| `0100` / `0101` | `0x200000` / `0x280000` | `tos206de` / `tos206uk` | TOS 2.06 (DE / UK)[cite: 1] |
| `0110` | `0x300000` | `tos306bf` | TOS 3.06[cite: 1] |
| `0111` | `0x380000` | `tos404bf` | TOS 4.04 (boots via ACSI/Gigafile, requires MMU)[cite: 1] |
| `1000` | `0x400000` | `etos140` | EmuTOS 1.4.0[cite: 1] |
| `1001` | `0x480000` | `tos404bf-68k30l.img` | TOS 4.04 (boots via ACSI/Gigafile, no MMU required)[cite: 1] |
| `1010`–`1100` | `0x500000`–`0x600000` | *(empty)* | Reserved[cite: 1] |
| `1101` | `0x680000` | `etoscurr` | Current EmuTOS build[cite: 1] |
| `1110` | `0x700000` | `etosdebug` | EmuTOS debug build[cite: 1] |
| `1111` | `0x780000` | `etoscli` | EmuTOS CLI build[cite: 1] |

---

## Project Links & Contact

* **Downloads & Documentation:** <http://www.experiment-s.de/en/download/>[cite: 1]
* **GitHub Repository:** <https://github.com/umatthe/suska4/tree/main>[cite: 1]
* **EmuTOS Suska Fork:** <https://github.com/umatthe/emutos-suska>[cite: 1]
* **FreeMiNT 4-Port USB (`ISP1164`):** <https://github.com/umatthe/freemint/tree/USB1164>[cite: 1]
* **Accessories & Hardware Shop:** <https://shop.inventronik.de/index.php>[cite: 1]
* **Team Contact / Bug Reports:** <wf@inventronik.de>[cite: 1]
