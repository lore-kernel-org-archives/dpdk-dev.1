Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B75CD3436
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 11:02:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2159340285;
	Wed,  6 May 2026 13:02:52 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1DAAB40275
 for <dev@dpdk.org>; Wed,  6 May 2026 13:02:51 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C7B34205C8;
 Wed,  6 May 2026 13:02:50 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC v5 1/6] ptp: introduce PTP protocol library
Date: Wed, 6 May 2026 13:02:47 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65849@smartserver.smartshare.dk>
In-Reply-To: <20260506154131.2496072-2-rajesh3.kumar@intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC v5 1/6] ptp: introduce PTP protocol library
Thread-Index: AdzdQVveMWEiTaxRQISF50J3MkptNgAANtrg
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260506154131.2496072-1-rajesh3.kumar@intel.com>
 <20260506154131.2496072-2-rajesh3.kumar@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Rajesh Kumar" <rajesh3.kumar@intel.com>,
	<dev@dpdk.org>
Cc: <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>,
 <stephen@networkplumber.org>
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

> From: Rajesh Kumar [mailto:rajesh3.kumar@intel.com]
> Sent: Wednesday, 6 May 2026 17.41
>=20
> Add IEEE 1588-2019 Precision Time Protocol (PTP) processing library.
>=20
> The library provides packet classification, header structures, and
> helper functions for PTP packet processing in DPDK. This avoids
> duplicate PTP header definitions across multiple applications and
> drivers.
>=20
> Supported transports:
> 1. L2 PTP (EtherType 0x88F7)
> 2. VLAN-tagged L2 PTP (single and QinQ)
> 3. PTP over UDP/IPv4 (ports 319/320)
> 4. PTP over UDP/IPv6 (ports 319/320)
>=20
> Public APIs:
> 1. rte_ptp_classify()
> 2. rte_ptp_hdr_get()
> 3. rte_ptp_msg_type_str()
>=20
> Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
> ---

Improved PTP support seems like a good addition to DPDK.

Here's some high level feedback to the library:

I think much of this belongs into /lib/net/, which holds similar =
protocol structure definitions and helper functions for many other =
protocols.
Please familiarize yourself with the code conventions in that directory, =
and move the relevant parts of the PTP library there (following the code =
conventions there).

Remember to define the packet structures with endianness in mind; e.g. =
use rte_be32_t instead of uint32_t where appropriate.

Don't define simple aliases, just use RTE_ETHER_TYPE_1588 directly.

Your DPI (deep packet inspection) parser function that can parse all =
kinds of PTP encapsulation does not belong in the library.
Applications would rely on a layered packet parser, such as =
rte_net_get_ptype().

If you need a DPI parser for the examples, feel free to add it there.

