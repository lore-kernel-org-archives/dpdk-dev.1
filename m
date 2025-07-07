Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8674EC8303C
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 18:09:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5687940287;
	Mon,  7 Jul 2025 20:09:03 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A7C434025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 20:09:01 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5907D208ED;
 Mon,  7 Jul 2025 20:09:01 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] net: support VLAN stacking packet type parsing
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 7 Jul 2025 20:08:57 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD98@smartserver.smartshare.dk>
In-Reply-To: <aGe7uxORe1V817a2@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net: support VLAN stacking packet type parsing
Thread-Index: Advs11FEa0S3UU1XTzqvhiUtikjkYQCjTijg
References: <20250703093027.1259459-1-huangdengdui@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD8D@smartserver.smartshare.dk>
 <aGe7uxORe1V817a2@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Dengdui Huang" <huangdengdui@huawei.com>, <dev@dpdk.org>,
 <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Friday, 4 July 2025 13.32

> Hi all,
>=20
> this email discussion comes at a bit of a fortunate time for me, as =
I'm
> currently looking at our vlan tag/qinq stripping behaviour in our =
Intel
> NIC
> drivers, and there is some discussion internally as to what our driver
> behaviour should be compared to what it has historically been. :-)
>=20
> The documentation - both in the NIC guide [1] and the testpmd guide =
[2]
> -
> is rather short on detail as to what exactly the behaviour should be
> when
> vlan strip or qinq strip is implemented. Therefore, I'd hope that =
those
> more familiar with networking than me would be able to help clarify
> things
> so we can document the correct behaviour precisely - and hopefully =
test
> our
> drivers against it in future!
>=20
> The simple cases are obvious (looking only at stripping behaviour =
here):
> * no vlan stripping - nothing done to packet
> * no vlan tag in pkg - nothing to do, irrespective of offload
> * Vlan strip enabled and single vlan tag present - HW should strip the
> tag and
>   place it in descriptor for placing in mbuf.
>=20
> Now the questions I have:
> * To handle questions with 2 vlan tags, the QinQ case - do we need to
>   enable both vlan-strip and QinQ strip, or does QinQ strip imply
> stripping
>   both?
>   - one suggested interpretation here, was that QinQ implies stripping
> the
>     tag with id EtherType 0x88a8, and vlan stripping implies taking =
off
> the
>     tag with 0x8100
>   - another interpretation is vlan strip means just to take off one =
tag
> (if
>     present), and qinq strip means to take off both tags (if present).
>=20

First off, consider VLAN stripping...
It strips the VLAN tag if present, but also allows (and parses) untagged =
packets.
A link with a mix of tagged and untagged packets is called a "hybrid =
link", so this scenario is perfectly valid and common.
Referring to this behavior, I would expect something similar for QinQ =
stripping, i.e. with QinQ stripping enabled, two, one or zero tags are =
allowed (and parsed).
This makes the VLAN strip flag superfluous when the QinQ strip flag is =
set.

You could have a QinQ trunk carrying only QinQ tagged packets and =
untagged Layer 2 Control Protocol packets (LACP etc.).
In this case you might want the ability to drop VLAN tagged packets, =
which should not occur on the link.
However, since we don't have such a feature for VLAN trunks, I wouldn't =
expect it for QinQ trunks either.

Another important detail...
Formally, QinQ is EtherType 0x88a8 with two VLAN tags.
However, I think double-tagging with EtherType 0x8100 is still broadly =
in use (in old networks, where it is difficult to upgrade to the =
official QinQ EtherType), so I would also treat packets with two VLAN =
tags (of EtherType 0x8100) as QinQ.
There was also an intermediate unofficial EtherType 0x9100 for QinQ =
tagging, before EtherType 0x88a8 was standardized... but I think we can =
ignore that.

> The question above leads to other consequences:
> * if we enable qinq strip, but get a single-vlan tagged frame, what is
> the
>   behaviour?
> * if we get a qinq packet, but regular vlan strip is enabled, which =
tag,
> if
>   any, is stripped?
> * should it be an error to enable both qinq strip and vlan strip at =
the
>   same time? Should it be an error to enable qinq strip without vlan
> strip?
> * in the mbuf, we have a "vlan_tci" field, and an "vlan_tci_outer"
> field.
>   For single vlan strip, presumably only the vlan_tci field should be
> used,
>   and for qinq traffic stripped, it's obvious which field goes where.
>   However, what if we have QinQ strip and we only receive a single =
vlan
>   tag, where should that be put? Should it go in inner or outer?

From a protocol parsing perspective, a single VLAN tagged packet has no =
"outer" tag.

Also: Consider the link being configured as a "super-hybrid link" =
(probably not an official name for such a link, but expanding on the =
common term "hybrid link"), carrying a mix of untagged, VLAN tagged and =
QinQ tagged packets. In this case, a single VLAN tagged packet is just a =
normal VLAN tagged packet, with the VLAN ID obviously going to the =
ordinary vlan_tci field.

>=20
> Feedback welcome, and suggested doc updates welcome too.
>=20
> Thanks,
> /Bruce
>=20
>=20
> [1] https://doc.dpdk.org/guides/nics/features.html#vlan-offload
> [2] https://doc.dpdk.org/guides/testpmd_app_ug/run_app.html
