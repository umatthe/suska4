           TTL       ROMINIT
*--------------------------------------------------------------------*
* ROMDISK-Initialisierungsprogramm für ATARI ST   Version II         *
* mit Disk-Treiberprogramm als Autostartmodul im Bootsektor          *
* (c) M.Friese 9.1986  --  AS68 alte Version                         *
* (BB, Nov '89 Version III für 256K-ROM-Disk)                        *
* (UMA, 3.2026 -- 512k-ROM-Disk Adaption for Suska4 HW)              *
*--------------------------------------------------------------------*
  
*--------------------------------------------------------------------*
* Definition der Konstanten                                          *

HDVBPB   =         $472      * Adresse des BPB-Vektors
HDVRW    =         $476      * Adresse des RW-Vektors
HDVMED   =         $47e      * Adresse des MEDIACH-Vektors
DRVBITS  =         $4c2      * Bitmaske der angeschlossenen Laufwerke
BOOTDEV  =         $446      * Bootdrivenummer

RDNUM    =         0         * Laufwerksnummer  ( 0/1=A: 4/16=E: )
RDBIT    =         1         * Bitwert des Laufwerks (= 2^RDNUM)
RAMDNUM  =         5         * RAM-Disk andere Nummer
RAMDBIT  =         32        * "   -Bitwert

GEMDOS   =         1         * GEMDOS Trapnummer
XBIOS    =         14        * XBIOS Trapnummer
SUPER    =         38        * GEMDOS 38, Routine im Supervisor ausf.

RDSIZE   =         512       * 4x128 K-Byte Modulspeicherplatz

SHADOWREG=         $F82000   * Suska - Register

MAGIC    =         $ABCDEF42 * MAGIC für Anwendermodulerkennung
MODUL    =         $FA0000   * Basisadresse des Moduls
AUTO     =         $8FA0000  * AUTO-Kennzeichnung & MODUL Basisadresse
START    =         $2FA0000  * Start der Kennzeichnung & MODUL Basis
 
*--------------------------------------------------------------------*
* Hauptprogramm                                                      *
*--------------------------------------------------------------------*
         TEXT
S:       MOVEA.L 4(SP),A0    * Speicherbedarf des Programms berechnen
         MOVE.L  #$100,D6    * 256 Byte für Base-Page
         ADD.l   12(A0),D6   * + Größe des TEXT-Bereichs
         ADD.L   20(A0),D6   * + Größe des DATA-Bereichs
         ADD.L   28(A0),D6   * + Größe des BSS-Bereichs
         PEA     FRAGE(PC)   * "Disk ist Bootdev." ausgeben
         MOVE    #9,-(SP)
         TRAP    #GEMDOS
         ADDQ.L  #6,SP
JANEIN:  MOVE    #7,-(SP)    * Ein Zeichen einlesen
         TRAP    #GEMDOS
         ADDQ.L  #2,SP
         SWAP    D0          * Scancode testen
         CMP     #$24,D0     * Taste 'J' ?
         BEQ     JA          * dann fertig
         CMP     #$31,D0     * Taste 'N' ?
         BNE     JANEIN      * nein, dann neue Taste einlesen
         CLR.B   BOOT        * Auto-Flagge von Modul1 löschen
JA:      PEA     INIT(PC)    * Ramdisk-Initialisierungsroutine ..
         MOVE    #SUPER,-(SP) * .. im Supervisormodus ausführen
         TRAP    #XBIOS
         ADDQ.L  #6,SP       * Stackpointer korrigieren
         CLR     -(SP)       * ohne Fehlermeldung ..
         MOVE.L  D6,-(SP)    * .. und mit residenten Programm ..
         MOVE    #$31,-(SP)  * .. zurück zum GEM
         TRAP    #GEMDOS

FRAGE:   DC.B    27,"E","ROM-Disk als Boot-Disk (j/n) ?",0
         EVEN

*--------------------------------------------------------------------*
* INIT - Ramdisk Initialisierungs-Routine                            *
*--------------------------------------------------------------------*
INIT:    MOVE.L HDVBPB,OLDBPB * Alten BPB-Vektor speichern
         MOVE.L HDVRW,OLDRW   * Alten RW-Vektor speichern
         MOVE.L HDVMED,OLDMED * Alten MEDIACH-Vektor speichern
         MOVE.L #BPB,HDVBPB   * Neuen BPB-Vektor setzen
         MOVE.L #RW,HDVRW     * Neuen RW-Vektor setzen
         MOVE.L #MED,HDVMED   * Neuen MEDIACH-Vektor setzen
         LEA    RAMDS+512,A0  * Directory und FAT's löschen
         LEA    BPBTAB,A1     * BPB-Basis
         MOVE.W 12(A1),D0     * Start der Datensektoren
         MULU   #128,D0       * mal 512/4 - in Langworten
         SUB.W  #516,D0       * -1 Sekt. -1 Langwort
DELETE:  CLR.L  (A0)+         * löschen
         DBRA   D0,DELETE
         OR.L   #RAMDBIT,DRVBITS * Disk C: anmelden
         RTS

*--------------------------------------------------------------------*
* Ramdisk Bios-Parameter-Block Routine                               *
*--------------------------------------------------------------------*
BPB:     MOVEA.L OLDBPB,A0        * Alten Vektor in A0 bringen
         CMP     #RAMDNUM,4(SP)   * Ist RAM-Disk angesprochen?
         BEQ     ISROM            * Weiter in der ROM-DISK Routine
         JMP     (A0)             * nein, dann zur alten Routine

*--------------------------------------------------------------------*
* Ramdisk Schreib/Leseroutine                                        *
*--------------------------------------------------------------------*
RW:      CMP     #RAMDNUM,14(SP) * Wird die RAM-Disk angesprochen?
         BEQ     RAMRW         * Ja
         MOVEA.L OLDRW,A0      * Sonst zur alten Routine springen
         JMP     (A0)
RAMRW:   MOVE    12(SP),D0     * Logische Sektornummer holen
         MULU    #512,D0       * mit Sektorlänge (512) multiplizieren
         MOVEA.L 6(SP),A0      * Adresse des Puffers holen
         MOVE    10(SP),D1     * Anzahl der zu lesenden Sektoren
         SUBQ    #1,D1         * Minus 1 für DBRA-Schleife
         LEA     RAMDS,A1      * Adresse der Ram-Disk holen
         ADD.L   D0,A1         * und Offset addieren
         TST     4(SP)         * Schreib/Lese-Flage testen
         BEQ     LESEN         * 0, dann lesen
         EXG     A0,A1         * Quelle und Ziel vertauschen
LESEN:   MOVE    #511,D0       * Sektorgröße
COPY:    MOVE.B  (a1)+,(a0)+   * Sektor kopieren
         DBRA    D0,COPY       * bis alle Byte ..
         DBRA    D1,LESEN      * und alle Sektoren kopiert sind
         CLR.L   D0            * Aktion war erfolgreich
         RTS

*--------------------------------------------------------------------*
* Ramdisk Media-Change Routine                                       *
*--------------------------------------------------------------------*
MED:     MOVEA.L OLDMED,A0      * Alten Vektor in A0 bringen
         CMP     #RAMDNUM,4(SP) * Ist RAM-Disk angesprochen?
         BEQ     FERTIG         * Weiter in der ROM-DISK Routine
         JMP     (A0)

*--------------------------------------------------------------------*
* Modulkopf für die ROM-Disk. Ab hier beginnt die RAM-Disk bzw. ROM- *
* Disk mit dem BOOT-Sektor !!!                                       *
*--------------------------------------------------------------------*

RAMDS:   DC.L    MAGIC         * Modul Kennzeichnung
*--------------------------------------------------------------------*
* Moduleintrag ROMSTART. Macht die ROM-Disk zur BOOT-Diskette        *
*--------------------------------------------------------------------*
         DC.L    MODUL2-RAMDS+MODUL     * Nachfolger ist Modul2
BOOT:    DC.L    START+ROM1-RAMDS       * Startadresse des Eintrags
         DC.L    0                      * Kein normaler Aufruf möglich
         DC.L    $D39                   * Uhrzeit & Datum
         DC.L    0                      * Modulgröße (Dummy)
         DC.B    "ROMSTART",0,0         * Modulname
ROM1:    MOVE    #RDNUM,BOOTDEV         * Bootdrive E: setzen
         OR.L    #RDBIT,DRVBITS         * Drive E: anmelden
         RTS                            * und fertig

*--------------------------------------------------------------------*
* Moduleintrag ROMDISK. Startet den ROM-Disk Treiber.                *
*--------------------------------------------------------------------*
MODUL2:  DC.L    0             * Das Modul hat keinen Nachfolger
         DC.L    AUTO+ROM-RAMDS  * Startadresse der ROM-Routine
*                               und Kennzeichnung als AUTO-Start-Modul
         DC.L    0             * Kein normaler Aufruf vorgesehen
         DC.L    $D39          * Uhrzeit & Datum der Erstellung
         DC.L    $20000        * Modulgröße immer 128 KB!
         DC.B    "ROMDISK",0   * Modulname

*--------------------------------------------------------------------*
* Einbinden der ROM-Disk in das Betriebssystem                       *
*--------------------------------------------------------------------*
ROM:     OR.L    #RDBIT,DRVBITS       * Drive E anmelden
         MOVE.L  #SYSEND-SYSANF,-(SP) * Byte für Puffer anfordern
         MOVE    #$48,-(SP)
         TRAP    #GEMDOS
         ADDQ.L  #6,SP                * Stackpointer korrigieren
         MOVEA.L D0,A6                * Adresse des Puffers in D6

         LEA     SYSANF(PC),A0        * Systemroutine in Puffer 
         MOVEA.L A6,A1                * kopieren
         MOVE    #SYSEND-SYSANF-1,D0  * Zahl der zu kopierenden Bytes
COPYSYS: MOVE.B  (A0)+,(A1)+
         DBRA    D0,COPYSYS

         MOVE.L  HDVBPB,OLDBPB-SYSANF(A6) * Alte Vektoren in Puffer
         MOVE.L  HDVRW,OLDRW-SYSANF(A6)   * übertragen
         MOVE.L  HDVMED,OLDMED-SYSANF(A6)

         LEA     IN1-SYSANF(A6),A0     * HDVBPB-Vektor neu setzen
         MOVE.L  A0,HDVBPB
         LEA     IN2-SYSANF(A6),A0     * HDVRW-Vektor neu setzen
         MOVE.L  A0,HDVRW
         LEA     IN3-SYSANF(A6),A0     * HDVMEDCH-Vektor neu setzen
         MOVE.L  A0,HDVMED

         LEA     NEWBPB(PC),A0         * Sprungvektor im Puffer
         MOVE.L  A0,2+JUMP1-SYSANF(A6) * .. für BPB eintragen
         LEA     NEWRW(PC),A0
         MOVE.L  A0,2+JUMP2-SYSANF(A6) * .. für RW eintragen
         LEA     NEWMED(PC),A0
         MOVE.L  A0,2+JUMP3-SYSANF(A6) * .. und für MEDIA eintragen

         PEA     MELDUNG(PC)           * 'ROM-DISK installiert' ..
         MOVE    #9,-(SP)              * ausgeben.
         TRAP    #GEMDOS
         ADDQ.L  #6,SP
         RTS                           * und fertig !

MELDUNG: DC.B    13,10,"ROM-DISK E: installiert.",13,10,0
         EVEN

*--------------------------------------------------------------------*
* BPB-Routine der ROM-Disk                                           *
*--------------------------------------------------------------------*
NEWBPB:  CMP     #RDNUM,4(SP)  * Ist die ROM-Disk angesprochen ?
         BEQ     ISROM
OLD:     JMP     (A0)          * nein, dann zur alten Routine
ISROM:   LEA     BPBTAB(PC),A0 * sonst Adresse des BPB in D0 ..
         MOVE.L  A0,D0         * .. zurückgeben
         RTS

*--------------------------------------------------------------------*
* RW-Routine der ROM-Disk                                            *
*--------------------------------------------------------------------*
NEWRW:   CMP     #RDNUM,14(SP) * Ist die Rom-Disk angesprochen ?
         BNE     OLD           * nein, dann zur alten Routine
         MOVE    12(SP),D0     * Logischen Sektor holen
         MULU    #512,D0       * mit Byte pro Sektor multiplizieren
         MOVE.L  6(SP),A0      * Adresse des Puffer's holen
         MOVE    10(SP),D1     * Anzahl der zu lesenden Sektoren holen
         LEA     MODUL,A1      * Adresse der ROM-Disk in A1
         ADDA.L  D0,A1         * + Offset zum Sektor
         TST     4(SP)         * Schreib/Leseflag testen
         BEQ     READ          * Lesen
         MOVEQ   #-13,D0       * sonst Fehler melden (altes TOS: #-1)
         RTS

READ:    SUBQ.L  #1,D1         * minus 1 für DBRA-Schleife
SEKT:    MOVEQ.L #15,D0        * 16 mal Schleife = 1 Sekt.
         MOVE.L  A1,D2         * Adresse ins Datenreg. zum Test
         BSET    #17,D2         * Bit 17 = 0 -> FC-FD oder 100-101
         BNE     AB_EF          * Bit 17 = 1 -> FA-FB oder  FE-FF
         BSET.B    #4,SHADOWREG
         BCLR    #18,D2         * Bit 18 = 0 -> 100-101
         BNE     FC_D           * Bit 18 = 1 -> FC-FD
         EOR.L   #$1F80000,D2   * 100-101: clear Bit 24, set 19-23
         BRA     B_HIGH
AB_EF:   BCLR    #18,D2         * Bit 18 = 1 -> FE-FF
         BEQ     TLONG          * Bit 18 = 0 -> FA-FB
B_HIGH:  BSET.B  #5,SHADOWREG
FC_D:    MOVEA.L D2,A1          * korrigierte Adresse zurueck

TLONG:   MOVE.L  (A1)+,(A0)+   * 8*4=32 Byte übertragen
         MOVE.L  (A1)+,(A0)+
         MOVE.L  (A1)+,(A0)+
         MOVE.L  (A1)+,(A0)+
         MOVE.L  (A1)+,(A0)+
         MOVE.L  (A1)+,(A0)+
         MOVE.L  (A1)+,(A0)+
         MOVE.L  (A1)+,(A0)+
         DBRA    D0,TLONG      * bis ein Sektor übertragen
         DBRA    D1,SEKT       * bis alle Sektoren übertragen
         BCLR.B  #4,SHADOWREG
         BCLR.B  #5,SHADOWREG
FERTIG:  CLR.L   D0            * kein Fehler
         RTS                   * und fertig

*--------------------------------------------------------------------*
* MEDIACH-Routine der ROM-Disk                                       *
*--------------------------------------------------------------------*
NEWMED:  CMP     #RDNUM,4(SP)  * Ist die ROM-Disk angesprochen ?
         BEQ     FERTIG        * Ja, Medium wird nie gewechselt
         JMP     (A0)          * nein, zur alten Routine

*--------------------------------------------------------------------*
* Bios Parameter Block der ROM-Disk                                  *
*--------------------------------------------------------------------*
BPBTAB:  DC.W    512           * Bytes pro Sektor
         DC.W    1             * Sektoren pro Cluster
         DC.W    512           * Bytes pro Cluster
         DC.W    1             * Sektoren der Directory
         DC.W    3             * Sektoren pro FAT
         DC.W    4             * Start von FAT 2
         DC.W    8             * Start der Datensektoren
         DC.W    RDSIZE*2-8+2  * Anzahl der Datensektoren
*                                (+2, um TOS auszutricksen)

*--------------------------------------------------------------------*
* Hilfsroutine, wird in den Puffer übertragen                        *
* Sprungziel hinter den JMP-Befehlen wird überschrieben !            *
*--------------------------------------------------------------------*
SYSANF   =       *
IN1:     MOVEA.L OLDBPB(PC),A0 * Alten BPB-Vektor in A0 bringen
JUMP1:   JMP     JUMP1         * und zu NEWBPB
IN2:     MOVEA.L OLDRW(PC),A0  * Alten RW-Vektor in A0 bringen
JUMP2:   JMP     JUMP1         * und zu NEWRW
IN3:     MOVEA.L OLDMED(PC),A0 * Alten MED-Vektor in A0 bringen
JUMP3:   JMP     JUMP1         * und zu NEWMED
OLDBPB:  DC.L    0             * Speicher für den alten BPB-Vektor
OLDRW:   DC.L    0             * Speicher für den alten RW-Vektor
OLDMED   DC.L    0             * Speicher für den alten MD-Vektor
SYSEND   =       *

*--------------------------------------------------------------------*
* Speicherbereich für den Rest der RAM-Disk                          *
*--------------------------------------------------------------------*
         BSS
         DS.B    RDSIZE*1024-(SYSEND-RAMDS)+4     *! +4 Korrektur
