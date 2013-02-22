Stage 2: JVM 
============

**Title:** The DemTech Kiosk Voting System: Software

**Type:** MSC thesis

**Responsible:** Attila

**Expected Deadline:** October 1-ish...

**Expected Outcome:** A formally verified, safety critical JVM implementation running on the e-ballot

**Assessment:** written report, defence

**Language:** English


Problem formulation:
--------------------
The current paper ballot solution has been known to have problems with the following:
thousands of “spoiled” ballots due to complex guidelines that people do not follow
the disabled can not vote alone, thus their right to privacy is violated
manual counting of ballots has been know to introduce an error rate anywhere from 0.1% to 1%

To combat this, an electronic ballot is proposed, which tries to mimic the paper ballot as much as possible, but provides additional features which allows the disabled to vote privately, and also hopefully reduces the number of spoiled ballots.

The aim is to have these electronic ballots produce a paper output, which can be:
visually verified by the voter that their vote has not been manipulated
fits into the existing workflow for counting the ballots
provides an easy way of digitally verifying the correctness of the manually counted ballots

At this stage of the project, the focus is on creating a formally verified, safety critical JVM implementation for the chosen MCU, which can then be used to run the verified Java ballot software.

The choice of Java is justified by the fact that most automated tools revolve around Java as well as a number of existing (formally verified) modules which could be easily reused.

Requirements:
-------------

TBD by Attila and Joe

Organization:
-------------

TBD by Attila and Joe

Deliverables:
-------------

TBD by Attila and Joe
