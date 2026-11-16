# EmuTOS on Suska-IV-B-Falcon

Emutos runs on Suska-IV just as on any other Falcon, but Suska-IV has some special stuff to consider:

* **Suska-IV might have 48MB of ALTRAM.** If ALTRAM is present, EmuTOS does not use the Blitter, because the normal Blitter can only access 24Bit addresses. Suska-IV has no restrictions (32Bit addresses). This leads to disabled Blitter with a Standard EmuTOS.
* **Suska-IV has no SCSI**
  This might cause trouble while booting.

---

## Configuration (`localconf.h`)

To have SCSI disabled You need a `localconf.h` file while building EmuTOS Yourself that contains:

```c
#define CONF_WITH_SCSI 0
#define CONF_WITH_SCSI_DRIVER 1
```

To remove the blitter restriction we currently have a patch in:
<https://github.com/umatthe/emutos-suska>

here at least those settings in `localconf.h` are requriered:

```c
#define SUSKA 1
#define UMA 1
#define CONF_WITH_SCSI 0
#define CONF_WITH_SCSI_DRIVER 1
```

There are several useful templates for `localconf.h` in our repository.

---

## How to Build EmuTOS

To build the Emutos Binary call (with MC68k Toolchain installed):

```bash
make 512 UNIQUE=de
```
