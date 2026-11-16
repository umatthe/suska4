# TOS Flash Image for Suska-IV-B / Suska-IV-BF

This is a Flash image for the **Suska-IV-B** and **Suska-IV-BF** boards.
The different operating systems are located as follows (an IP-core with appropriate CPU is required):

---

## Operating System Flash Map

| Address Switch | Operating System | Address Offset | Board / Notes |
| :---: | :--- | :---: | :--- |
| `0000` | empty | `0x000000` | B-board |
| `0001` | empty | `0x080000` | B-board |
| `0010` | `tos162de` | `0x100000` | B-board |
| `0011` | `tos162uk` | `0x180000` | B-board |
| `0100` | `tos206de` | `0x200000` | B-board |
| `0101` | `tos206uk` | `0x280000` | B-board |
| `0110` | `tos306bf` | `0x300000` | B-board |
| `0111` | `tos404bf` | `0x380000` | B-board (boot from Gigafile, needs MMU) |
| `1000` | `etos140` | `0x400000` | B-board |
| `1001` | `tos404bf-68k30l.img` | `0x480000` | B-board (boot from Gigafile, no MMU needed) |
| `1010` | empty | `0x500000` | B-board |
| `1011` | empty | `0x580000` | B-board |
| `1100` | empty | `0x600000` | B-board |
| `1101` | `etoscurr` | `0x680000` | B-board |
| `1110` | `etosdebug` | `0x700000` | B-board |
| `1111` | `etoscli` | `0x780000` | B-board |

---

## Cartridge Support

The Flash image features also cartridge support for the cartridge address space `0xfa0000` to `0xfaffff` at the following addresses:

* `0x040000` to `0x04ffff`
* `0x0c0000` to `0x0cffff`
* `0x140000` to `0x14ffff`
* `0x1c0000` to `0x1cffff`
* `0x240000` to `0x24ffff`
* `0x2c0000` to `0x2cffff`
* `0x340000` to `0x34ffff`
* `0x3c0000` to `0x3cffff`
* `0x440000` to `0x44ffff`
* `0x4c0000` to `0x4cffff`
* `0x540000` to `0x54ffff`
* `0x5c0000` to `0x5cffff`
* `0x640000` to `0x64ffff`
* `0x6c0000` to `0x6cffff`
* `0x740000` to `0x64ffff`
* `0x7c0000` to `0x6cffff`

The Flash image features also cartridge support for the cartridge address space `0xfb0000` to `0xfbffff` at the following addresses:

* `0x050000` to `0x05ffff`
* `0x0d0000` to `0x0dffff`
* `0x150000` to `0x15ffff`
* `0x1d0000` to `0x1dffff`
* `0x250000` to `0x25ffff`
* `0x2d0000` to `0x2dffff`
* `0x350000` to `0x35ffff`
* `0x3d0000` to `0x3dffff`
* `0x450000` to `0x45ffff`
* `0x4d0000` to `0x4dffff`
* `0x550000` to `0x55ffff`
* `0x5d0000` to `0x5dffff`
* `0x650000` to `0x65ffff`
* `0x6d0000` to `0x6dffff`
* `0x750000` to `0x65ffff`
* `0x7d0000` to `0x6dffff`

The Flash image features also cartridge support for the cartridge address space `0xfc0000` to `0xfcffff` at the following addresses:

* `0x060000` to `0x06ffff`
* `0x0e0000` to `0x0effff`
* `0x160000` to `0x16ffff`
* `0x1e0000` to `0x1effff`
* `0x260000` to `0x26ffff`
* `0x2e0000` to `0x2effff`
* `0x360000` to `0x36ffff`
* `0x3e0000` to `0x3effff`
* `0x460000` to `0x46ffff`
* `0x4e0000` to `0x4effff`
* `0x560000` to `0x56ffff`
* `0x5e0000` to `0x5effff`
* `0x660000` to `0x66ffff`
* `0x6e0000` to `0x6effff`
* `0x760000` to `0x66ffff`
* `0x7e0000` to `0x6effff`

The Flash image features also cartridge support for the cartridge address space `0xfd0000` to `0xfdffff` at the following addresses:

* `0x070000` to `0x07ffff`
* `0x0f0000` to `0x0fffff`
* `0x170000` to `0x17ffff`
* `0x1f0000` to `0x1fffff`
* `0x270000` to `0x27ffff`
* `0x2f0000` to `0x2fffff`
* `0x370000` to `0x37ffff`
* `0x3f0000` to `0x3fffff`
* `0x470000` to `0x47ffff`
* `0x4f0000` to `0x4fffff`
* `0x570000` to `0x57ffff`
* `0x5f0000` to `0x5fffff`
* `0x670000` to `0x67ffff`
* `0x6f0000` to `0x6fffff`
* `0x770000` to `0x67ffff`
* `0x7f0000` to `0x6fffff`
