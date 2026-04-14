# ROMDISK Cartridge
Here You find a 512k Cartridge file for use in the Suska4 Board.<br>
This cartridge contains a ROMDISK with the Lighning-USB drivers that is visible as drive A:<br>
In case there is no other boot device it will boot the USB drivers from there.<br>
## Installation
Make sure that Your Suska-Core/Firmware is up to date: [Update to SCSI-Falcon](https://github.com/umatthe/suska4/wiki/Update-ACSI%E2%80%90Falcon-(2025)-to-SCSI%E2%80%90Falcon-(2026))<br>
Download the File [NOTDISKA.512](/Cart/NOTDISKA.512)<br>
Copy it to a µSD-Card and put the Card into the µSD-Slot of the Suska4<br>
Connect to the FPGA-Shell and type for installation in Slot 31:<br>
f-erase 31<br>
f-write NOTDISKA.512<br>
c-cart 31<br>
c-save user<br>
After reboot of the Suska4 the Drive A: should be visible.<br>
