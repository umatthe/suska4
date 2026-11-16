# TESTOS.PRG

Puts `TESTTOS.IMG` to the ShadowRAM behind the ROM of Your Suska and boots it.

There is a tool (probably already on Your `C:\`) called `TESTTOS.PRG` in case You want to check a 512K TOS-ROM File before putting it to the flash.

Here is what You need to do:

1. Copy the 512K-TOS Binary to `C:\` and name it `TESTTOS.IMG`.
2. execute (double click) `TESTTOS.PRG`.
3. now the new TOS will be booted and stay in Your "ROM" until You power down the Suska.

---

## Very easy in case You have a picoWifi installed.

1. call `C:\UIPWIFI.TOS` and note down the IP-address it reports.
2. to copy the `TESTTOS.IMG` use:
   * **2a.** a webbrowser with `http://Suska-IP-address`
   * **2b.** a Linux Box:
     * execute `pftp Suska-IP-address` on Your Linux box with the testtos.
     * Login and Password are not needed - just hit enter when prompted.
     * `cd c`
     * `bin`
     * `hash`
     * `put TESTTOS.IMG`
     * `by`
3. now You have a `TESTTOS.IMG` on Your Suska. Hit Space to exit UIPWIFI and start `TESTTOS.PRG`
