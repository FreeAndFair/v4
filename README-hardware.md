Stage 1: The ballot hardware
=============================

**Title:** The DemTech Kiosk Voting System: Hardware

**Type:** 15 ECTS point special course

**Responsible:** Attila

**Expected Deadline:** April 22

**Expected Outcome:** A hardware capable of replacing the current danish paper-based ballots.

**Assessment:** written report?

**Language:** English


Problem formulation:
--------------------
The current paper ballot solution has been known to have problems with the following:
thousands of “spoiled” ballots due to complex guidelines that people do not follow
the disabled can not vote alone, thus their right to privacy is violated
manual counting of ballots has been know to introduce an error rate anywhere from 0.1% to 1%.

To combat this, an electronic ballot is proposed, which tries to mimic the paper ballot as much as possible, but provides additional features which allows the disabled to vote privately, and also hopefully reduces the number of spoiled ballots.

The aim is to have these electronic ballots produce a paper output, which can be:
visually verified by the voter that their vote has not been manipulated
fits into the existing workflow for counting the ballots
provides an easy way of digitally verifying the correctness of the manually counted ballots

At this stage of the project, the focus is on creating a hardware platform suitable for the research and development of software for the e-ballot, eventually to be used at a test run for e-voting.

Requirements:
-------------
* The device should be able to replace a paper ballot in the voting booth in a secure manner
* It should be possible to use by the disabled without third party help
* It should produce a paper ballot which can fit into the existing workflow
* The device should aim at a simplistic approach
* The (8-bit) MCU should have enough resources to accommodate an embedded JVM (~15-20KB) + application code (~10-100KB)
* The MCU should have enough GPIO to drive a button matrix? and an serial printer
* The device should be cheap and accessible enough to be reproducible by wide audience
* The hardware designs, PCBs, 3D CAD files should all be open sourced
* There should be no RF leakage, which could be used to invalidate the voters’ privacy
* The device should be able to operate on battery for the whole voting session
* The printer in the device should print ASCII text, optionally support printing graphics (such as barcodes, QR code, etc)

Organization:
-------------
Due to the nature of the project, a number of tasks will need to be tackled:
Design and implementation of the physical 3D model for the ballot:
* Accessibility/Usability: User friendly, optimized for disabled too
* Portability
* Robustness
Design and implementation of the electronics for the ballot:
* Security: Tamper proof
* Safety
* Availability: It should operate throughout the election day
* Maintainability

For this, the following competences will be needed:
* Usability/UI expert (Joe, someone at DemTech?)
* Electronics skills (Attila)
* Microcontroller skills (Attila)
* 3D CAD design (maybe Attila)
* Hardware security evaluation (Attila, Joe, SecFault guys?, other DemTech contacts?)

*A rough outline of the steps needed:*
* Investigate the ballot I/O requirements (number of buttons, layout, etc)
* Investigate the software requirements to be able to come up with a suitable MCU
* Find collaborators for missing competences
* Implement
* Implement 
* Document

Deliverables:
------------
Aside from the usual report, design documents, schematics, parts list, etc, (one or more) complete prototypes which can be used as the basis of further development on the software and further revisions to perfect the hardware.

Links:
http://learn.adafruit.com/internet-of-things-printer

