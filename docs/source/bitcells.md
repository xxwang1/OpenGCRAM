### [Go Back](./index.md#table-of-contents)

# Bitcells
On top of the 6T SRAM bitcells supported by OpenRAM, this page explains the GCRAMs supported by OpenGCRAM.



<!-- ## Table of Contents
1. [6T-SRAM](#6T-SRAM)
1. [Relative Bitcell Sizes](#relative-bitcell-sizes-035um-scmos)
1. [Thin SRAM Bitcells](#thin-sram-bitcells-130nm) -->



## Schematics

* Multiport Bitcells (Based on 6T SRAM cell)
    * Standard read-write
    * Isolated read-only ports
    * Write-only port (not sized for reads)
* Can accommodate foundry bitcells

![Multiport Bitcells](../assets/images/bitcells/multiport_bitcells.png)

* GCRAM 
    * Decoupled read and write paths (WWL, WBL, RWL, RBL)
    * One bitline per port
    * 2T Si-Si (silicon transistors)
    * 2T OS-OS GCRAM (Oxide transistors)

![Schematics](../assets/images/bitcells/gc_schematics.png)


## Layout with Bitcell Sizes
![Schematics](../assets/images/bitcells/gc_layouts.png)

## Relative SRAM Bitcell Sizes (0.35um SCMOS)
| <img height="184" src="../assets/images/bitcells/6t.png"> | <img height="278" src="../assets/images/bitcells/10t.png"> | <img height="424" src="../assets/images/bitcells/dff.png">   |
| :-----------------------------------------------: | :------------------------------------------------: | :--------------------------------------------------: |
| Standard 6T (1rw) 6.8um x 9.2um                   | Isolated Read 10T (1rw, 1r) 10.9um x 13.9um        | DFF 21.9um x 21.2um (from OSU standard cell library) |



## Thin SRAM Bitcells (130nm)
| <img height="158" src="../assets/images/bitcells/thin_single.png"> | <img height="158" src="../assets/images/bitcells/thin_dual.png"> | <img height="158" src="../assets/images/bitcells/thin_single_straps.png">   | <img height="197" src="../assets/images/bitcells/thin_dual_straps.png"> |
| :--------------------------------------------------------: | :------------------------------------------------------: | :-----------------------------------------------------------------: | :-------------------------------------------------------------: |
| Single Port 1.2um x 1.58um                                 | Dual Port 2.40um x 1.58um                                | Single Port (w/ straps & taps) 2.49um x 1.58um                      | Dual Port (w/ straps & taps) 3.12um x 1.97um                    |

| <img height="707" src="../assets/images/bitcells/dff_reference.png"> |
| :----------------------------------------------------------: |
| DFF (for reference) 5.83um x 7.07 um                         |







