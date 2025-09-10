Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960E4CA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 08:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72782402C4;
	Wed, 10 Sep 2025 10:28:11 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 4724D40270;
 Wed, 10 Sep 2025 10:28:10 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id F3F1E20446;
 Wed, 10 Sep 2025 10:28:09 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: DPDK Tech Board meeting minutes 03-September-2025
Date: Wed, 10 Sep 2025 10:28:08 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FED7@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: DPDK Tech Board meeting minutes 03-September-2025
Thread-Index: AdwiLNZSm04CqcyGSZyMtR9IzjxJ4g==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>
Cc: <techboard@dpdk.org>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Members Attending
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Aaron Conole
Bruce Richardson
Hemant Agrawal
Jerin Jacob
Kevin Traynor
Konstantin Ananyev
Maxime Coquelin
Morten Br=F8rup (chair)
Thomas Monjalon

NOTE
=3D=3D=3D=3D
The technical board meetings are on every second Wednesday at 3 pm UTC.
Meetings are public. DPDK community members are welcome to attend on =
Zoom:
https://zoom-lfx.platform.linuxfoundation.org/meeting/96459488340?passwor=
d=3Dd808f1f6-0a28-4165-929e-5a5bcae7efeb
Agenda: https://annuel.framapad.org/p/r.0c3cc4d1e011214183872a98f6b5c7db
Minutes of previous meetings: http://core.dpdk.org/techboard/minutes

Next meeting will be on: Wednesday 17-September-2025 at 3pm UTC,
and will be chaired by: Thomas Monjalon.

Agenda Items
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. DMAdev changes
-----------------
Two API breaking changes to the DMA device were discussed:
- DMAdev breaking change [1a]
- Support for DMA transfers across inter-process and inter-OS domains =
[1b]
The board agreed to accept these changes in 25.11, on the condition that =
they pass ordinary review.

[1a]: https://inbox.dpdk.org/dev/17207459.geO5KgaWL5@thomas
[1b]: =
https://inbox.dpdk.org/dev/20250710085101.1678775-1-vattunuru@marvell.com=
/

2. Drop support for x86-32, or all 32 bit architectures, and/or =
architectures requiring strict alignment
-------------------------------------------------------------------------=
-------------------------------
The purpose of this discussion was to determine if some architectures =
are obsolete, so we can deprecate them and save resources for support =
and testing.
Although 32 bit hardware might not be relevant for DPDK anymore, running =
32 bit mode on 64 bit hardware is still common on memory constrained ARM =
systems.
It was also mentioned that cross compiling to 32 bit ARM implies using =
the "generic_aarch32" architecture, which has strict alignment =
requirements.
The CI system cross compiles and performs unit tests for 32 bit mode on =
64 bit ARM hardware, so the board is satisfied with the level of testing =
for 32 bit architectures.
There was no updated information about usage of the x86-32 architecture, =
and since 32 bit architecture support is still required for ARM, there =
is no big gain by dropping support for the x86-32 architecture, so the =
board decided not to deprecate it with the 25.11 release.

3. Guidelines for AI assisted contributions
-------------------------------------------
Policies for AI assisted contributions were discussed.
The formal signoff, with its purpose described in the Developer's =
Certificate of Origin [3a], places the responsibility on the developer =
to ensure that the developer has the right to contribute the code. The =
board agreed that contributing AI generated code does not change or =
reduce this responsibility.
The board decided to add a link to The Linux Foundation's guidance [3b] =
to the DPDK Contributor's Guidelines documentation [3c] for =
clarification.

The board also discussed adding a special "Generated-by" tag for AI =
assisted code contributions.
Although it might be useful for future purposes, e.g. if AI generated =
code gets different legal treatment than human generated code, we cannot =
rely on contributors adding such a tag. Even so, if we define a =
threshold for the level of AI involvement that requires the tag, that =
threshold may no longer be valid or appropriate in the future, rendering =
the tag ineffective.
The board decided not to mandate such a tag for now, but may revisit =
this, depending on what other projects do.

[3a]: =
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#de=
veloper-s-certificate-of-origin-1-1
[3b]: https://www.linuxfoundation.org/legal/generative-ai
[3c]: =
https://doc.dpdk.org/guides/contributing/patches.html#commit-messages-bod=
y

4. The dpservice project
------------------------
Guvenc Gulce joined the meeting to present "dpservice" (Dataplane =
Service) [4a,4b], the DPDK based Layer 3 Router component of the =
IronCore project [4c], which is part of the EU funded non-profit open =
source NeoNephos Foundation [4d] with the goal of making cloud native =
sovereign.
The board agreed to include this project on the DPDK web page listing of =
open source projects consuming DPDK [4e].

Like Grout [4f], dpservice uses the DPDK Graph framework. With Robin =
Jarry (maintainer of Grout) also participating in the meeting, some of =
the technical similarities between the two projects were discussed.
The board proposed that the two projects could benefit from sharing =
information, design thoughts, and possibly some code.

[4a]: =
https://guvenc.github.io/software%20engineering/2024/10/18/dpservice.html=

[4b]: https://github.com/ironcore-dev/dpservice
[4c]: https://ironcore.dev/
[4d]: https://neonephos.org/
[4e]: https://www.dpdk.org/ecosystem/
[4f]: https://github.com/DPDK/grout

5. Review status of projects on DPDK web site
---------------------------------------------
The status of each of the projects listed on the DPDK web site (Grout, =
Pktgen, DTS, dpdk-burst-replay, NFF-Go, SPP, ...) was discussed, and =
Nathan will proceed to handle the inactive projects as such.


Venlig hilsen / Kind regards,
-Morten Br=F8rup

