# First Time Attachment to Suska-IV-B

## Deutsch

dies ist das erste Dokument, welches erläutern soll, wie die Dokumentation zu Suska-IV-B aufgebaut ist und welche Überlegungen dahinter stehen. Zu Suska-IV-B gibt es kein blumiges Handbuch. Der Grund hierfür liegt in der FPGA-Konfiguration sowie der Firmware des System-Mikrocontrollers, die stetigen Änderungen / Erweiterungen unterliegen. Die Suska-IV-B Hardware ist bezüglich der implementierten Schnittstellen selbsterklärend und / oder eindeutig bezeichnet und benötigt daher ebenfalls keine ausführliche Beschreibung.

Es exisitieren zu verschiedenen Themen Howtos, die als Kurzanleitung zu verstehen sind. Diese sind in englischer Sprache verfasst. Wir sind bemüht diese Dokumente so vollständig und verständlich wie möglich zu gestalten. Falls Informationen fehlen oder unverständlich sind nehmen wir gerne Hinweise dazu auf. Wir freuen uns natürlich umso mehr, wenn uns aus der Community Dokumente zu Themen zugespielt werden, die wir dann gerne in die Sammlung aufnehmen.

Suska-IV-B wird über USB-C mit Spannung (5V) versorgt. Die Stromaufnahme liegt derzeit (das ist implementierungsabhängig) unter 500mA. Es kann daher jedes handelsübliche USB Netzteil verwendet werden. Empfehlenswert sind Netzteile mit Ausgangsströmen von 1,5A oder mehr.

Das Gerät ist betriebsbereit mit aktuellem Atari Falcon kompatiblen IP-Core (FPGA) und mit aktuellem EmuTOS im Betriebssyste-Flash konfiguriert. Die Front- und Rückblende sind aus Kunststoff gefertigt. Dadurch ist ein gegebenenfalls montiertes Pi Pico W funktechnisch funktionsfähig. Um Konfigurationen am Firmware-Mikrocontroller, dem Betriebssystem-Flash oder der FPGA-Konfiguration vorzumehmen ist es notwendig, das Gehäuse zu öffnen. Dies geschieht durch Entfernen der Rückseite, der Rändelschraube der Klinkenbuchse und herausziehen der Leiterplatte nach hinten.

Frontseitig sind für die Optische Signalisierung 4 LEDs montiert. Die blaue und die gelbe LED signalisieren Zugriffe auf die SD-Karte. Blinken beide LEDs im Wechsel liegt ein Zugriffsfehler auf die Karte vor.

* **Die blaue LED** signalisiert beim Einlegen den Typ der erkannten SD-Karte. Langsames Blinken = SDSC, mittelschnelles Blinken = SDHC, schnelles blinken = SDXC. Die blaue LED wechselt nach der Erkennung auf Dauergblau und signalisiert so Betriebsbereitschaft.
* **Die gelbe LED** leuchtet bei Zugriff auf die SD-Karte.
* **Die grüne LED** leuchtet bei Fehlern, die auf den IP-Core zurückzuführen sind, im speziellen deutet sie auf ein fehlerhaftes Einrasten der Phase Locked Loops hin.
* **Die rote LED** ist eine Betriebsanzeige und leuchtet daher dauerhaft.

> **Hinweis:** in zukünftigen Versionen des FPGA Cores 2K25B... werden die Funktionen der grünen und der roten LED vertauscht.

Suska-IV-B verfügt über zwei Tasten.

* **Die rechte Taste** hat eine Doppelfunktion: längeres Drücken (ca. 2s) schaltet das Gerät ein bzw. aus. Kurzes betätigen ist löst einen Reset des Falcon aus.
* **Die Taste mit dem kurzen Betätiger** resettiert das FPGA. Sie wird im Normalfall nicht benötigt.

Suska-IV-B ist mit einem batteriegepufferten Uhrenchip ausgestattet. Der typ der Batterie (Knopfzelle) ist Renata 364, Varta 364 oder kompatible.

**Schlusswort:** Suska-IV-B ist ein sehr sorgfältig entwickeltes Board mit einem, bezogen auf das sehr große FPGA, exzellenten Preis-Leistungsverhältnis.

---

## English

this is the first document intended to explain how the documentation for Suska-IV-B is structured and the considerations behind it. There is no elaborate manual for Suska-IV-B. The reason for this lies in the FPGA configuration and the firmware of the system microcontroller, which are subject to continuous changes and extensions. The Suska-IV-B hardware is largely self-explanatory regarding the implemented interfaces and/or clearly labeled, and therefore does not require extensive descriptions.

There are various how-to guides on different topics, which are meant to serve as brief instructions. These are written in English. We strive to make these documents as complete and understandable as possible. If information is missing or unclear, we welcome feedback and suggestions. Of course, we are especially pleased when we receive documents from the community on relevant topics, which we are happy to include in the collection.

Suska-IV-B is powered via USB-C (5V). The current consumption is currently (depending on the implementation) below 500mA. Therefore, any standard USB power supply can be used. We recommend power supplies with output currents of 1.5A or more.

The device is operational with a current Atari Falcon-compatible IP core (FPGA) and is configured with the latest EmuTOS in the operating system flash. The front and rear panels are made of plastic. This ensures that a potentially installed Pi Pico W remains fully functional in terms of wireless communication. To make configurations to the firmware microcontroller, the operating system flash, or the FPGA configuration, it is necessary to open the enclosure. This is done by removing the back panel, unscrewing the knurled screw on the jack socket, and pulling the circuit board out towards the rear.

On the front side, four LEDs are mounted for optical signaling. The green and red LEDs indicate access to the SD card. If both LEDs blink alternately, an access error to the card has occurred.

* **The green LED** indicates the type of SD card detected when it is inserted: slow blinking = SDSC, medium-speed blinking = SDHC, fast blinking = SDXC. After detection, the green LED switches to a steady green light to indicate operational readiness.
* **The red LED** lights up when there is access to the SD card.
* **The blue LED** lights up in the event of errors related to the IP core — specifically, it indicates a failure in the locking of the phase-locked loops.
* **The yellow LED** serves as a power indicator and is therefore permanently lit.

The Suska-IV-B has two buttons.

* **The right button** has a dual function: pressing and holding it (for approx. 2 seconds) turns the device on or off. A short press triggers a reset of the Falcon.
* **The button with the short actuator** resets the FPGA. It is generally not needed under normal circumstances.

Suska-IV-B is equipped with a battery backuped real time clock chip. The type of the battery (round cell) is Renata 364, Varta 364 oder compatible.

**Conclusion:** Suska-IV-B is a very carefully developed board with an excellent price-performance ratio, especially considering the very large FPGA.

---

Wolfgang für das Suska-IV-B Projekt im August 2025
