# Howto Compile FPGA

Compiling of the configware works different from compiling software. Please be aware that **VHDL modules are not software**. In the end of the process there is a rule howto connect basic functions like `AND`, `NAND`, `OR`, `NOR`, `XOR`, `XNOR`, `NOT` and D-type flip flops with each other. In this way even the complexest digital system are built.

---

## Compilation Steps

Compiling stands for a process with different steps:

1. **Compiling** means to check syntax and build a netlist with the basic information how to connect the mentioned basic functions. This netlist is not technology dependent.
2. **Place & Route** is the step where, on the basis of the netlist, ressources in a specific FPGA are foreseen and the routing process then connects these reserved ressources.
3. **Assembler:** this step creates the program files for download to the boot device of the FPGA (`.pof`) or to the FPGA directly (`.sof`).
4. **The timing analysis** insures a correct timing of the system, means it takes run times into account and examines the systems for critical pathes.

---

> All in all the building of a configuration is a complex procedure and it is not guaranteed that from a correct syntax a working system will result. It takes some experience to do this. For this reason there are stable releases for Suska-IV-B with the correct syntax and the correct compiling, placmend and fitting. So once again: do not worry about a malfunction in believing it is a failure in the codes. The timing is as important as a correct syntax of all used modules.
