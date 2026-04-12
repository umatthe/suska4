# Suska-IV FPGA Configuration

Here You will find new Corefiles to update the Suska-IV-B when available.
Coretype | Version | Download Link | md5sum
--- | --- | --- | ---
Suska4-Falcon-B | 20251224 | [SUSKA_IV_B_FALCON_2K25B.rbf](SUSKA_IV_B_FALCON_2K25B.rbf) | 8e9add40c6a36248421fad1fe18b0461
Suska4-Falcon-B | 20251224 | [SUSKA_IV_B_FALCON_2K25B.sof](SUSKA_IV_B_FALCON_2K25B.sof) | 5acee7f3f9629a35ed6b0fa86719737a
Suska4-Falcon-B | 20251224 | [SUSKA_IV_B_FALCON_2K25B.pof](SUSKA_IV_B_FALCON_2K25B.pof) | 163141c34460035f4fa200f675d119cc
--- | --- | --- | ---
Suska4-Falcon-B | 20260409 | [SUSKA_IV_B_FALCON_260409.rbf](SUSKA_IV_B_FALCON_260409.rbf) | 40c390faccb8c7805abc6d8aed1d78b9
Suska4-Falcon-B | 20260409 | [SUSKA_IV_B_FALCON_260409.sof](SUSKA_IV_B_FALCON_260409.sof) | e6f19a626ccb45769ddb02cf7e9f09ef
Suska4-Falcon-B | 20260409 | [SUSKA_IV_B_FALCON_260409.pof](SUSKA_IV_B_FALCON_260409.pof) | 55e89af7024d0bea1005d326a7645e2a

## Howto install
- sof - Files can be loaded for trial without permanent changes to the system. They are loaded to the FPGA using the JTAG Connnector and the Quartus SW
- pof - Files are loaded into the Configflash of the board, deleting the old Core. They are loaded to the ConfigFlash using the AS Connnector and the Quartus SW
## Do not use the rbf-File in case as-getid returns: Silicon-ID: 17 ** unknown **<br>Update the Firmware first: [AVR-Firmware](../Firmware/)
- rbf - Files are loaded into the Configflash of the board, deleting the old Core. See the [howto-rbf](howto-rbf.txt) for details.

## What is new in the last version 260409
- Bootdevice is now SCSI (as a normal). No ACSI Boot anymore - needs a EmuTOS/TOS that boots from SCSI
- Supports 16 ROM-Cartridges in Flash
- Cartridge and OS Flash can now be erased in 512k segments.
