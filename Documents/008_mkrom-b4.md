# Create TOS Flash Image (`mkrom-b4`)

This `cat` command is an example which can be used in a linux bash to catenate several TOS operating systems to one programming file.

---

## Command Example

> **Important:** all the files must have a size of 512k. The result is a hex file once downloaded to the Suska-IV-B operating system flash which then works like described in `"tos_suska-iv-b.txt"`.

```bash
cat leer512k.img leer512k.img tos162de.img tos162uk.img tos206de.img tos206uk.img tos306bf.img tos404bf.img etos140.img tos404bf-68k30l.img leer512k.img leer512k.img leer512k.img etoscurr.img etosdebug.img etoscli.img >r-b4.img
```
