# Howto Create a SD-Card Image

There is nothing special needed to create a SD-Card-Image, that can be booted from a Suska-Board. All Images that boot on real HW or other emulators should work.

---

## Steps

1. Create a empty file of the desired size.
   Example with linux:

   ```bash
   dd if=/dev/zero of=hdimage.img bs=1K count=500K
   ```

2. Use this file in HATARI as HD and partition it using HDDRIVER or some other tool.
3. Fill the HD with Files
4. Copy the Image on a SD-Card.
   Example with linux:

   ```bash
   dd if=/hdimage.img of=/dev/sdxxx
   ```

5. Plug it in the Suska-Board and boot with Emutos

---

## Booting under TOS

In case You want to boot TOS, additionally HDDRIVER or some other driver needs to be installed after Step 2.
The delivered SD-Card boots under Emutos and TOS (with a demo version of HDDRV).

Because the current Falcon implementation has no SCSI or IDE interface, a patched TOS 4 is needed that boots from ACSI. A TOSPATCH to create such a TOS is on the SD-Card.
To make HDDRV try to boot from ACSI on a Falcon a HDDRV Module is needed.
This Module is on the delivered SD-Card too.
