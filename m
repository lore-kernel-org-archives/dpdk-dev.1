Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA93CD343B
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 06:03:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 853554026D;
	Thu,  7 May 2026 08:03:28 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A2C7E40265;
 Thu,  7 May 2026 08:03:26 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 9317920628;
 Thu,  7 May 2026 08:03:25 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: DPDK Tech Board meeting minutes 29-April-2026
Date: Thu, 7 May 2026 08:03:23 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65850@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: DPDK Tech Board meeting minutes 29-April-2026
Thread-Index: Adzd5zZ8xVAum0T3RfSOiE9AkLEsGw==
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
Bruce Richardson
Hemant Agrawal
Jerin Jacob
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

Next meeting will be on: Wednesday 27-May-2026 at 3pm UTC, and will be =
chaired by: Konstantin Ananyev.

Agenda Items
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. Patch backlog and lack of reviews
------------------------------------
The patch backlog has grown from 300 to 500 items.
Although the backlog isn't worse than usual, it still needs addressing.
Currently, Thomas is the only person reviewing and merging patches for =
many directories, which sometimes leads to delays in merging.
The board agreed to merge patches without full consensus during the =
early release cycle, as issues could be addressed in later release =
candidates.
It was noted that simple comments and informal feedback on patches is =
also valuable when considering merging patches without Acked-by or =
Reviewed-by tags.
The board discussed various incentives to get more reviews: =
gamification, recognition of top reviewers, requiring code contributors =
to also contribute reviews.
To proceed experimenting with some of this, we will try making a =
dashboard showing the balance of code contributed vs. reviews =
contributed per contributor.

Many of the patches in the backlog lacking review are documentation =
updates from January.
The board discussed creating a documentation maintainer role as a =
webmaster-like role: responsible for collecting and consolidating =
content, but not for the content itself. We will seek candidates on the =
announcement mailing list.

2. Wish List review
-------------------
The board reviewed the list of new wishes in Bugzilla: =
https://issues.dpdk.org/reports?component=3Dwishes&status=3DUNCONFIRMED
The board decided on a process where wishes accepted (possibly for =
further consideration) by the tech board would be marked with status =
Confirmed, with a reference to the tech board minutes where discussed.

#1905: Reduce memory footprint by using rte_max_lcore instead of =
RTE_MAX_LCORE
Some build-time constants have a large effect on how much memory is =
allocated by DPDK.
The board noted that the max number of lcores is not the only one; e.g. =
the max number of queues per port has a high effect on memory usage.
Getting completely rid of these, and making arrays etc. fully dynamic =
would be the optimal solution. But replacing them by startup-time =
variables may be easier to implement.
There is no need for individual wishes per build-time constant affecting =
memory usage. This wish will be considered in broad context, covering =
all the relevant build-time constants, with flexibility on =
implementation order, also considering the impact of getting rid of each =
one.
This wish was accepted for the roadmap.

#1906: Use DPDK memory for lcore variables
The board identified some disadavantages with this proposal; mainly that =
it would probably consume an additional hugepage TLB entry per thread, =
instead of a number of ordinary TLB entries.
This wish was kept on the wish list for further investigation.

#1912: free mbufs should not have next and nb_segs initialized
The concept of not requiring any non-constant mbuf fields to be =
initialized when freeing an mbuf into its mempool, and instead leave =
initialization to the Rx path of the drivers was discussed.
The board was concerned about how such a change would affect =
performance.
The store buffers in many CPUs can handle up to 32 (consecutive) bytes =
each. So, if the Rx path needs to write more than 32 bytes into the =
mbuf, it requires more store buffers, which may then become a =
bottleneck.
In the context of performance, an alternative was discussed: The =
"nb_segs" field (residing in the mbuf's first cache line) can be used as =
a gate to determine if the "next" field (residing in the mbuf's second =
cache line) is valid or not.
Jerin also emphasized that hardware implementations typically handle =
memory pooling differently, with automatic freeing on the TX side.
This wish was kept on the wish list for further investigation.

#1913: Introduce RTE_EAL_INIT_PRIO() alternative to RTE_INIT_PRIO()
Introducing a macro to allow libraries (and applications and drivers) to =
install their initialization functions into hooks at various stages =
during EAL initialization may help decorrelate library dependencies.
This wish was accepted for the roadmap.

#1929: Ethdev Tx Completion API
Adding a Tx completion capability - with separate transmit stages for =
descriptor setup and cleanup phases - would be useful for =
post-processing features, such as packet capture and time stamping.
The board was concerned about performance, particularly regarding =
per-packet completions versus bulk completions.
Enabling per-packet notifications would require additional PCI bandwidth =
and thus impact throughput.
Bruce suggested adding a per-packet flag as a potential implementation =
approach.
This wish was kept on the wish list for further investigation.


Venlig hilsen / Kind regards,
-Morten Br=F8rup

