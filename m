Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FBDC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 08:34:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A1774025E;
	Mon,  2 Jun 2025 10:34:56 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 973564025A
 for <dev@dpdk.org>; Mon,  2 Jun 2025 10:34:54 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5F8CA20102;
 Mon,  2 Jun 2025 10:34:54 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 00/14] add lookup fib nodes in graph library
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 2 Jun 2025 10:34:53 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCA9@smartserver.smartshare.dk>
In-Reply-To: <20250602063639.198550-1-adwivedi@marvell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 00/14] add lookup fib nodes in graph library
Thread-Index: AdvTiL2abht1YrvAQsu5mo/bBxok9gADakZQ
References: <20250509064448.724019-1-adwivedi@marvell.com>
 <20250602063639.198550-1-adwivedi@marvell.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Ankur Dwivedi" <adwivedi@marvell.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "Jerin Jacob" <jerinj@marvell.com>, "Robin Jarry" <rjarry@redhat.com>
Cc: <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>, <skori@marvell.com>,
 <rkudurumalla@marvell.com>, <nsaxena@marvell.com>, <dev@dpdk.org>
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

+TO: Robin Jarry, might have relevant feedback for such a node

> From: Ankur Dwivedi [mailto:adwivedi@marvell.com]
> Sent: Monday, 2 June 2025 08.36
>=20
> This patch series adds two inbuilt nodes ip4_lookup_fib and
> ip6_lookup_fib in graph library. These nodes uses the existing
> Forwarding Information Base (FIB) library to create FIB, to do
> route addition and route lookup.
>=20
> Two new commands (for ipv4 and ipv6) for providing the lookup mode
> is added in the dpdk-graph application. fib or lpm can be given as
> lookup mode. If these new lookup mode commands are not given, the
> dpdk-graph uses lpm (Longest Prefix Match) or lpm6 by default.
> If fib is given as lookup mode then the ip4_lookup_fib or
> ip6_lookup_fib
> nodes are used by the application.

@Ankur, @Vladimir, @Jerin,

A couple of high level questions...

1. Thread safety:
I'm not familiar with the thread safety models of the FIB and Graph =
libraries.
Is the FIB library thread safe, so one thread can invoke the FIB modify =
operation while other threads invoke the FIB lookup operation?
If it isn't, how does the Graph library make its use of the FIB library =
thread safe?

2. VRF support:
This looks like a global route table for the entire graph.
Shouldn't there be a route table per FIB node?
Or how are VRFs supported by the Graph library?
Or is there no requirement to support VRFs in the Graph library?

-Morten

