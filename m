Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406CDC83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 16:36:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C1594026B;
	Mon, 14 Jul 2025 18:36:15 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3F03C4021F;
 Mon, 14 Jul 2025 18:36:13 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D2CEE20421;
 Mon, 14 Jul 2025 18:36:12 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 14 Jul 2025 18:33:43 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDB4@smartserver.smartshare.dk>
In-Reply-To: <20250714133014.44597-1-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Thread-Index: Adv0w3XFh2hLLG7GTl6thsaisblSbAAEcoRg
References: <20250714133014.44597-1-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>, <dev@dpdk.org>,
 "Dengdui Huang" <huangdengdui@huawei.com>,
 "Vladimir Medvedkin" <medvedkinv@gmail.com>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Monday, 14 July 2025 15.30
>=20
> The behaviour of VLAN tag stripping Rx offloads is unclear in DPDK, =
and
> not very well documented. Even the documentation that does exist =
appears
> contradictory.
>=20
> For example, the doxygen docs for the mbuf flag
> RTE_MBUF_F_RX_QINQ_STRIPPED says:
>=20
>   "If RTE_MBUF_F_RX_QINQ_STRIPPED is set and =
RTE_MBUF_F_RX_VLAN_STRIPPED
>   is unset, only the outer VLAN is removed from packet data,..."
>=20
> but the docs for RTE_MBUF_F_RX_QINQ says:
>=20
>   "If the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs
>   headers have been stripped from mbuf data, ..."
>=20
> Without a good definition of what the correct behaviour is, it's not
> possible to assess and ensure conformance across drivers. Update the
> documentation for NIC features, ethdev and mbuf library to all report
> the same information: that VLAN strip feature is stripping one flag, =
and
> QinQ strip feature is removing two.
>=20
> Summary of VLAN and QinQ stripping behaviour as reported in docs after
> this patch:
>=20
> =
+-------------------+----------------------+----------------------------
> +
> | Input Traffic     | VLAN-strip on        | QinQ strip on
> |
> =
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> | Single VLAN pkts  | Tag in vlan_tci      | Tag in vlan_tci
> |
> =
+-------------------+----------------------+----------------------------
> +
> | Double VLAN pkts  | Outer tag in vlan_tci| Outer tag in
> vlan_tci_outer|
> |                   |                      | Inner tag in vlan_tci
> |
> =
+-------------------+----------------------+----------------------------
> +
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

I think your RFC is not a description of originally intended behavior.
However, I think your last thought in the previous discussion, =
speculating about the original intention, was correct:

The QINQ flag and the VLAN flag are completely independent.

The QINQ flag refers to EtherType 0x88a8 (QinQ) tags, and vlan_tci_outer =
holds the ID of such a tag.
It can be the outer tag of a double-tagged packet (i.e. the S-TAG of a =
packet with a C-TAG (C-TAG =3D Customer's VLAN tag)), or
the only tag of a single EtherType 0x88a8 tagged packet (i.e. the S-TAG =
of a customer packet with no VLAN tag).

The VLAN flag refers to EtherType 0x8100 (VLAN) tags, and vlan_tci holds =
the ID of such a tag.
It can be the only tag of a single EtherType 0x8100 tagged packet (i.e. =
a normal VLAN tag), or
the inner tag (i.e. the C-TAG) of a double-tagged packet with an outer =
EtherType 0x88a8 tag (the S-TAG).

On RX, RTE_MBUF_F_RX_QINQ (and vlan_tci_outer) should be set if the =
packet has an EtherType 0x88a8 tag (as the only tag, or as the outer =
tag).
If it was stripped, RTE_MBUF_F_RX_QINQ_STRIPPED should also be set.
Similarly on RX, RTE_MBUF_F_RX_VLAN (and vlan_tci) should be set if the =
packet has an EtherType 0x8100 tag (as the only tag, or after the QinQ =
tag).
If it was stripped, RTE_MBUF_F_RX_VLAN_STRIPPED should also be set.

Same goes for TX: If RTE_MBUF_F_TX_VLAN_INSERT is set, an EtherType =
0x8100 tag should be inserted with the ID coming from vlan_tci.
Similarly for TX, if RTE_MBUF_F_TX_QINQ_INSERT is set, an EtherType =
0x88a8 tag should be inserted with the ID coming from vlan_tci_outer.
Any HW inserted tags are inserted as the outermost tag, i.e. after the =
MAC addresses in the Ethernet header.
And the VLAN tag insertion (if any) happens before the QinQ tag =
insertion (if any).

Note:
With this behavior, VLAN Stacking (i.e. double-tagged packets using =
EtherType 0x8100 for both inner and outer tag) can only be partially =
hardware offloaded.
On RX, HW VLAN stripping will strip the outer VLAN tag to vlan_tci, and =
the application must move vlan_tci to vlan_tci_outer and manually strip =
the inner VLAN tag to vlan_tci.
On TX, the application must manually insert the inner tag from vlan_tci, =
and move vlan_tci_outer to vlan_tci, and HW VLAN insertion will insert =
the outer VLAN tag from vlan_tci.


Support for VLAN Stacking would be nice, but it should be added as a new =
feature, not through a doc update.

