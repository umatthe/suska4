# Suska-IV TOSTOOLS
Binaries of the useful TOS progams like UIPWIFI and TOSPATCH are located on the Suska-IV SDCard-Image.<p>
## New TOS Flash handling starting with Core 20260409 (and current AVR-Firmware)<br>
To copy any 512k TOS to the flash there it is no longer needed to erase the whole flash. Any of the 16 TOS-Images (slot 0 to 15) can be exchanged from FPGA-Shell with the following sequence:<br>
- f-erase slot<br>
- f-write slot tosfile.img<br>

## ETOS Image TESTTOS.IMG
This File is a ETOSCURR.IMG with patches for 800x480 Screen Resolution on Falcon

## ROM Collections (8MB with 16 512k TOS-Slots):<br>
[r-b4dbg.img](r-b4dbg.img) ETOS-Current 260519<br>
Generated using: __cat etoscurr.img etosdebug.img etosdebug.img etosdebug.img etosdebug.img etosdebug.img etosdebug.img etosdebug.img etosdebug.img etosdebug.img etosdebug.img etosdebug.img etosdebug.img etosdebug.img etosdebug.img  etoscli.img >r-b4dbg.img__<br>
OS-Switches Upper Position=1 Lower Position=0 DontCare=x other-function=n:<br>
Further Info about the Config switches are in the [Wiki](https://github.com/umatthe/suska4/wiki/Config-Switches)
<br>nn**0000**nnnn ETOS 260519
<br>nn**1111**nnnn ETOS 260519 CLI only on HDMI and MFP-UART (38400bd 8N1)
<br>nn**0xx1**nnnn ETOS 260519 Debug Output on MFP-UART (38400bd 8N1)
<br>nn**1xx0**nnnn ETOS 260519 Debug Output on MFP-UART (38400bd 8N1)
## Howto copy a Collection to the TOS-Flash
- copy Collection to µSD-Card (FAT 16/32)
- insert Card into µSD-Slot
- power up Suska-IV-B
- connect to AVR-Shell
- ls                                          (check if collection file is on card)
- f-erase all                                 (to erase the TOS Flash)
- ... wait for red LED to stop blinking ...
- f-write 0 r-b4dbg.img                       (writes Collection and boots when finished)
