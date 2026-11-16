# USB Subsystem

The USB-Subsystem is compatible with the Lightning SW with one extension: The "USB-Chip" in Suska has a 4 port Root-Hub where the real HW has only 2.

* 3 of them are on connectors (2 at the back and 1 internally to be used for a picoWifi).
* With the original Lightning drivers only the 2 ports at the back will work.

---

## Drivers & Sources

The drivers installed on the delivered SD-Card handle all ports.
The Souces for the 4-Port-Lightning can be found here: <https://github.com/umatthe/freemint/tree/USB1164>

They detect the special `ISP1164` Chip and will work with normal Lightning HW too.
We will try to put our extensions to the offical freemint github later.
