# Shadow TOS

---

## 0. What is Shadow TOS

Shadow Tos is a feature of all Suska Board that allows the user to load a TOS-ROM without flashing it permanently. It will stay active until the Suska Board is switched off.

---

## 1. Installation

Copy the Directories `SHADOW`, `CART` and `TOS` including its contents to `C:\`

---

## 2. Usage

### 2.1 Load and Activate TOS

in `SHADOW` You will find several prebuild files starting with `"SH-"`
The Name of the File specifies which TOS will be loaded and activated.
Example: `SH-ET121.PRG` will load and start Emutos1.2.1
Just start the desired `SH-` File by double klicking or use a CLI.
Files which are not compatible with Your core will probably crash Your System. Example: Do not try to load a TOS404 to a STE-Suska. It will crash.
But just a powerdown will bring You back to Your flashed OS.

### 2.2. Switch to another Shadow TOS from Shadow Tos

nothing special to do here. Go to the `SHADOW` directory and start the desired `SH-` File.

### 2.3. Switch Back to Flash TOS

goto the `SHADOW` directory and start `COLDROM.PRG`
This will deactivate the ShadowTos and perform a Coldstart.

---

## 3. Notes

* **3.1.** To switch back to Flash TOS You may poweroff the Suska Board and power it up again
  Especially the Suska-C Board needs a long time to loose its contents. So if You power it down please wait a minute or two before powering it up again.
* **3.2.** The Souces of the Tools are in the `SRC` directory. In case You want to generate Your own binaries, those are Assembler Files compatible with the DEVPACK Assembler.
