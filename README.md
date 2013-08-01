dkvs
====

**The DemTech Kiosk Voting System.**

*The DemTech Project*

Editor: Joseph Kiniry

Contributors: Attila Sukosd, Steffen Dalsgaard

Abstract
--------

The DemTech Kiosk Voting System (DKVS henceforth) is a hardware and
software system for use in supervised elections.  The DKVS is meant to
be a low-cost, mission-critical system that reliably records voter
intent, produces a well-formed digital and paper ballot pair that
captures a voter's intent, securely logs all actions taken by the
hardware and software, and reports on the election and counts all
recorded ballots at the end of an election.  The design and
development of DKVS is conducted according to mission- and
safety-critical standards, thus treating democracy and elections as a
safety- & mission-critical system.  This system may be used as the
foundation for further experimentation in supervised voting systems,
incorporating our research work in logic-based elections,
zero-knowledge proofs, certificates, and more at some future date.

Discussion
----------

To participate in an election in Denmark today, a voter:

1. goes to their assigned polling place,
2. identifies him/herself using a voter card that was mailed to them in the preceding weeks,
3. is handed a paper ballot,
4. goes into a private polling booth,
5. uses a pencil to mark the ballot in a single location to indicate their vote,
6. folds the completed ballot to hide their mark,
7. exits the polling booth,
8. puts their completed ballot into an opaque, sealed ballot box,
9. exits the polling place.

> Steffen: Perhaps add a brief para on the practice of postal voting. Have you considered how postal votes could be integrated in the DKVS?

A ballot in Denmark is a sheet of white or yellow paper printed with
black ink that is at least A3 sized in recent years.  The longest
ballots on record are approximately one meter long.  On it, in a
random order, is a list of every political party certified for the
election, and under every party entry is a list of every certified
candidate from that party.  The ordering of candidates is determined
by their party.

To complete a well-formed "unspoiled" ballot a voter must put a clear
mark next to either the party for which they are voting or next to a
specific candidate for which they are voting.  There are complex rules
about what constitutes an "unspoiled" ballot, particularly in the
presence of multiple consistent and inconsistent markings, smudges,
location of marks, different kinds of marks, etc.

In each election there are several thousand ballots nationwide that
are deemed "spoiled" as they violate these well-formedness guidelines.

At the end of an election, in the presence of witnesses, the ballot
boxes are emptied and the ballots that they contained are manually
collated according to the political party chosen on each ballot.  Then
each pile of ballots is counted by hand by two or more volunteers.
Ballot stacks are counted at least twice to obtain a per-party tally,
known as the "rough count", which is reported to the central electoral
officer by telephone and computer system.

Ballots are then securely bundled following a specific published
procedure and are transported by volunteers in taxis to a central
location.  The bundles are stored in a secure storage facility and
guarded by the police.  All of this happens in a single evening.

The next day, all securely bundled ballots are unpacked in the
presence of witnesses.  Each per-municipality bundle of ballots is
unpacked onto a single table.  At each table, municipality workers
perform another partitioning on the per-party ballot stacks, collating
them according to the individual candidate that received a vote on
each ballot in question.  Thus, if there are K candidates for party P,
party P has at most K+1 stacks of ballots after collation.  The
"extra" stack is for those votes that are assigned to the party,
rather than to a specific individual.

Each per-candidate stack, as well as the candidate-less stack, is then
concurrently counted by hand by two or more municipality workers. Each
stack is counted at least two times and there is a published mechanism
by which a count is deemed "correct enough" that related to the
difference between a tally in any two sequential counts.  This is
knows as the "fine count".

Intermediate results and per-candidate and per-party counting results
are reported to a central table by writing on little slips of paper
and carrying them across the room.  Intermediate results are submitted
to a central authority via a networked computer system and via
telephone and are published to the public via a web site.

Once all tallies at all tables complete their tallying, the election
fine count is deemed complete.

There are several recognized problems with the existing electoral
system in Denmark that are mentioned in the recent proposed change in
law.

> Steffen: Perhaps mention that the intent here is not to discuss the severity of these problems compared to the overall trust etc. in the present system, but to suggest a way in which they can be minimized?

* Many of the disabled do not have the ability to independently vote
  as they require, by law, the help of two electoral assistants to
  complete their ballot.  The participation of assistants violates the
  voter's right to private ballot, and may violate their right to a
  uncoerced ballot.

* Manually counting votes is slow and error-prone, particularly when
  those counting are working long hours in a poor
  environment. Published error rates for manually counting voters
  range from 0.1% to 1%, depending upon the complexity of the ballots,
  the state of those counting, specifics of the counting process, and
  the speed at which they count.

There are some other problems observed by election observers, both
DemTech personnel and others:

* The participation of municipality workers and the lack of
  independent observers at the fine count opens up many opportunities
  or insider attack and fraud.

* The participation of municipality workers in the fine count
  increases the cost of an election significantly.

* The computers and networks used to record and report tallies on both
  election day and during the fine count are not robust, insecure,
  opaque, proprietary software systems and use ad hoc protocols (both
  human and technical).

DemTech has already made a small number of simple recommendations to
the Head of Elections with an aim toward improving the correctness,
improving the security, and lowering the cost of the existing
electoral system with the introduction of no IT technology [citation].

DemTech has also submitted a formal response to the proposed changes
in electoral law to permit trials in evoting [citation].  This system
is meant to fulfill all of the suggested recommendations put forth in
that response (e.g., conformance to various ISO standards for software
quality and security).

The DemTech project, by virtue of its original grant proposal,
promised to experiment with non-binding digital elections during
national elections in Denmark in 2013 and beyond.  Thus, developing
open technology like this project is directly within our plan and
mandate.

Now that the Ministry responsible for elections has proposed a change
in electoral law in order to experiment with digital technologies in
the recording of voter intent, the DemTech research project has an
even stronger incentive to develop new technology fit for this
purpose.  Moreover, if we develop open source, unencumbered technology
that fulfills the requirements set forth by law, then municipalities
can decide to use our technology in their own binding trials if they
wish.

Requirements
------------

The requirements we impose on the design and development of this
system come directly from, or are directly derived from, existing
national and international laws, guidelines, and recognized best
practices in elections (digital or traditional).

There are also a number of technical requirements that we stipulate
that derive from best practices in rigorous software engineering and
information security.

All standards, laws, guidelines and the like mentioned herein are
cited at the end of this document.

Mandatory Requirements
----------------------

TBD by Joe and Attila

Optional Requirements
---------------------

TBD by Joe and Attila

Goals
-----

This system is designed and developed to:

* be one of the systems demonstrated to the Danish government in 2013,
* be one of the systems demonstrated and evaluated by Danish voters in the 2013 elections,
* be exhibited to the world as the best evoting system ever produced,
* be used as a model for best-in-industry systems development in election equipment,
* be a case-study in our early ideas in the Trust-by-Design methodology,
* and fulfill the evaluation requirements injected by DemTech members, partners, the government, and the electorate.

Open Questions
--------------

* stateful vs. stateless kiosk
* voter identification to machine via token
* digital vote storage
* digital vote encoding and encryption
* should digital technology be used to sort ballots

Project Planning
----------------

TBD by Joe and Attila, including summary of timeline and milestones

Gantt chart, milestones, tasks, responsibilities, all with
cross-references to public tracking of project in Trac will be in the
DKVS Planning document, mentioned below

Other Related Documents
-----------------------

To best understand the design and development of this system, please
refer to the following documents.  We suggest reading them in the
stipulated order.  Note that each of these documents is short,
focused, and to-the-point.  We do not avoid formalism when required.
Recall that DKVS means “DemTech Kiosk Voting System”.

* DKVS Project Planning
* DKVS Process
* DKVS Methodology
* The Trust-by-Design Methodology
* DKVS Domain Analysis
* DKVS Formal Requirements
* DKVS Risk Analysis
* DKVS Hardware Foundation
* DKVS Software Foundation
* DKVS Architecture
* DKVS Formal Design
* DKVS Cryptography
* DKVS Implementation
* DKVS Security
* DKVS Validation
* DKVS Verification
* DKVS Traceability

References
----------

* Folketingsvalget den 15. september 2011. (2011).

* Recommendations to the Danish Government to Improve the Accuracy,
  Secrecy, and Cost of Modern Danish Elections (ed. Joseph Kiniry)

* DemTech. Consultation response during the public hearing on the
  proposal to change the Danish election laws on elections for the
  Danish Parliament, of Danish members to the European Parliament, and
  for municipalities and regions (in order to experiment with digital
  voting and tallying). January, 2013.

* Council of Europe. (2004a). Reflections on the future of democracy in Europe.

* Council of Europe. (2004b). Legal, operational and technical
  standards for e-voting (Rec(2004)11).

* Council of Europe. (2010). E-voting handbook - key steps in the
  implementation of e-enabled elections.

* Council of Europe. (2011). Guidelines on transparency of e-enabled
  elections (GGIS (2010) 5 fin. E).

* European Parliament. (2008). E-public, e-participation and e-voting
  in Europe - prospects and challenges.

* Federal Election Commission. (2002). Voting Systems Performance and
  Test Standards : An Overview (Vol. I).

* IEEE Computer Society. (2012). IEEE Standard for Electronic
  Distribution of Blank Ballots for Voting Systems (IEEE Std 1622).

* Jones, D. W., & Simons, B. (2012). Broken Ballots. University
  of Chicago Press. Retrieved from
  http://www.amazon.co.uk/Broken-Ballots-Center-Language-Information/dp/1575866366


* Harris, B. (2004). Black Box Voting - Ballot Tampering in the 21st
  Century. Retrieved from http://amerivote.com/ibip/docs/bbv_Part1.pdf

* Herrnson, P. S., Niemi, R. G., Hanmer, M. J., Bederson, B. B.,
  Conrad, F. G., & Traugott, M. W. (2008). Voting Technology: The
  Not-so-simple Act of Casting a Ballot. Brookings Institution
  Press. Retrieved from
  http://www.amazon.co.uk/Voting-Technology-Not-so-simple-Casting-Ballot/dp/0815735634

* Rubin, A. D. (2006). Brave New Ballot: The Battle to Safeguard
  Democracy in the Age of Electronic Voting. Morgan Road
  Books. Retrieved from
  http://www.amazon.co.uk/Brave-New-Ballot-Safeguard-Electronic/dp/0767922107

* Shamos, M. I. (2011). Electronic Voting Glossary.

* Goldsmith, B. (2011). Electronic Voting & Counting Technologies.

Appendices
----------

Domain Dictionary
-----------------

Risk Analysis
-------------