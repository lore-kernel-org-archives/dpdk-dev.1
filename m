Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2244BE73158
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 11:16:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E225C409FA;
	Mon,  2 Feb 2026 12:16:34 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 79A6D402D8;
 Mon,  2 Feb 2026 12:16:33 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BCEBC206EC;
 Mon,  2 Feb 2026 12:16:31 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: DPDK Tech Board meeting minutes 21-January-2025
Date: Mon, 2 Feb 2026 12:16:30 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656DC@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: DPDK Tech Board meeting minutes 21-January-2025
Thread-Index: AdyUNWFAZ8jq31skQaien7gajDr+nA==
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
Stephen Hemminger
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

Next meeting will be on: Wednesday 4-February-2026 at 3pm UTC, and will =
be chaired by: Stephen Hemminger.

Agenda Items
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. Automated AI review in the CI
--------------------------------
Aaron has estimated the cost for LLM tokens.
The Governing Board was presented with this cost, and promptly approved =
a budget for it.
The Governing Board requested safeguards to prevent sudden rapid =
spending or exceeding the budget, e.g. in the event of a runaway system =
or malicious attack.
Linux Foundation had been asked about any existing LF projects which =
have already implemented automated AI reviews so that we can learn from =
their experiences, and replied that multiple projects use GitHub =
Copilot, and get good results for reviews.
Copilot is primarily a developer tool; and it is a frontend, so it does =
not tie us to one specific LLM.
Aaron was tasked to get this set up in the CI. Bruce will assist as =
needed.

2. Maintainer update
--------------------
Honnappa Nagarahalli will move to other responsibilities within ARM.
Wathsala Vithanage has agreed to replace Honnappa as maintainer of the =
Ring, MCSlock RCU libraries currently maintained by Honnappa.
The board (including Ring library co-maintainer Konstantin Ananyev) =
agreed, and thanks Honnappa for his work as maintainer.

3. New features in DPDK 26.03
-----------------------------
The board confirmed that no major features are coming in DPDK 26.03.


Venlig hilsen / Kind regards,
-Morten Br=F8rup

