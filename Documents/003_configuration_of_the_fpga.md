# Configuration of the FPGA

The configuration of an FPGA determines, how the FPGA will work after loading the configuration from a boot device. In the case of Suska-IV-B this means, that the FPGA works like an Atari Falcon computer. There are different methods configuring an FPGA. In the following there is a description howto use these methods without going into detail. For a better understanding how configuration of FPGAs work refer to the appropriate Aletra Quartus software documentation. The relevant methods configuring the FPGA are as follows:

---

## 1. Using the firmware microcontroller and a configuration file stored on the micro-SD-card

This is a very comfortable way to program the FPGA boot device with new configuration data. Be aware that the previous configuration already stored in the boot device will be overwritten. Information how to use this method can be found in the `firmware-userguide.txt`.

---

## 2. Loading the FPGA IP Core via the Active Serial Interface

To do this, connect a `'USB Blaster'` programming adapter to the USB interface of a PC and to the Active Serial Interface connector located on Suska-IV-B.

Use the Altera software Quartus or the stand-alone programming software from Altera on the PC for this purpose. It is a good practice to use current versions of these software tools. Start the programmer tool in Quartus (see menu `'Tools'` / `'Programmer'`). The use of this software is self-explanatory and supported by a detailed help system. In principle programming of the boot device is accomplished with the following steps:

1. Chose the programming hardware for example `'USB Blaster'`.
2. Change the programming mode to **Active-Serial**.
3. Choose the desired programming file `x.pof`.
4. Choose the programming options for example **Program/Configure** or **Verify**.
5. Start the programming / configuration.

The result of this configuration is a non volatile configuration stored in a flash boot device. The configuration is the permanently stored even if the board is powered off.

---

## 3. Loading the FPGA IP Core via JTAG

Configuration of the FPGA via the JTAG interface is very similar to programming the boot device using the active serial interface. It is accomplished with the following steps:

1. Chose the programming hardware for example `'USB Blaster'`.
2. Change the programming mode to **JTAG**.
3. Choose the desired programming file `x.sof`.
4. Choose the programming options for example **Program/Configure** or **Verify**.
5. Start the programming / configuration.

The configuration programmed via the JTAG interface is stored in the FPGA configuration RAM and is valid as long as the system is powered on even if the `RESET` or the `SYS-RESET` switches are asserted. After repowering, the FPGA boots its configuration from the boot device. JTAG is useful to test changes without affecting the stable configuration (wich is stored in the boot device).

---

## 4. Configuration of the FPGA using a `.jic` File

`.jic` is a **JTAG Indirect Configuration File**. The purpose fo it is to programm a serial boot device (Flash memory) via the JTAG interface of the FPGA. This method mentioned here for the sake of completeness. It is useful for remote access. To use this method first it is required to convert the programming files to an appropriate `.jic` file and the to use this `.jic` file to program the serial boot Flash via the JTAG interface of the FPGA. For more information refer to the detailed documentation of the Altera Quartus software.
