This is a 512K-ROM-DISK for the Suska-Board
-------------------------------------------
It was adopted from ct' 92/02 EPROM-Prothese.

To build it use "gen.ttp ROMINIT5.S" on ATARI-ST.
The save.lst needs to be imported into GFA-Basic.

How to use:
- start ROMINIT5.PRG on Atari. This will provide a RAM-Disk Drive F:
- start save.lst in gfabasic. This will do some magic :-) and 
  put 3 Files on the Disk. Don't touch those files.
- Add the Files You want to have on the ROM-Disk to the RAM-Disk.
- start save.lst in gfabasic again. This time it will remove
  the Files it created in the first run. And a File ROMDISK.512 will
  be created on the Drive C:
  This is the ROMDISK-Binary. Copy it to a µSD-Card with FAT-FS and
  insert it into the AVR-Slot (µSD-Slot on Suska4).
- Connect a Terminal to AVR-Uart and type:
  f-write 31 ROMDISK.512
  c-cart 31
  c-save user

  This copies the ROMDISK to Slot 31 of the 512k-Slots and activates it.
  (0..15 are used for TOS and 16..31 are used for Cartridges)
  c-save user will save the setting permanently.

- Now after Reboot You will have a ROMDISK with drive letter E:

- NOTE there are source and prebuild images for the ROMDISK Drive E:, C: and A:

