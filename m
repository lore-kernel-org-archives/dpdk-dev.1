Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE07D103E179
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 13:39:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 803F94026F;
	Wed, 18 Mar 2026 14:39:41 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2A7E340150
 for <dev@dpdk.org>; Wed, 18 Mar 2026 14:39:40 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D594520849;
 Wed, 18 Mar 2026 14:39:39 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] bpf/arm64: support packet data load instructions
Date: Wed, 18 Mar 2026 14:39:38 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657A0@smartserver.smartshare.dk>
In-Reply-To: <4942136acefe4fc3b5157191749fe3d5@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [PATCH] bpf/arm64: support packet data load instructions
Thread-Index: AQHctXjoFxWXyTh3g0OC9SlGIQcTMrW0I+zwgAAX+/CAAAZ24IAABL0g
References: <20260310122045.4057836-1-cfontain@redhat.com><b10d0edcdaac4fd9a4f5a0261205670c@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579F@smartserver.smartshare.dk>
 <4942136acefe4fc3b5157191749fe3d5@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Marat Khalili" <marat.khalili@huawei.com>,
 "Christophe Fontaine" <cfontain@redhat.com>, <dev@dpdk.org>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>
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

> From: Marat Khalili [mailto:marat.khalili@huawei.com]
> Sent: Wednesday, 18 March 2026 14.07
>=20
> > > Handling immediate as unsigned is questionable, especially in the
> > > BPF_IND case
> > > it may produce incorrect results.
> >
> > In Classic BPF (cBPF), when the immediate "k" is negative (when cast
> to signed integer), it is used
> > for getting packet metadata (e.g. SKF_AD_VLAN_TAG gets the VLAN ID);
> otherwise it is considered
> > unsigned.
>=20
> Yes. Since we don't support it, we should probably consider these
> offsets invalid.

+1

>=20
> And in the BPF_IND case one might be tempted to load end of some =
packet
> area in
> the register and use negative offsets, we probably should handle it
> correctly.

In Classic BPF, negative "k" has special meaning for both BPF_ABS and =
BPF_IND.
So we should consider it invalid for both cases.

That prevents applications from using it the way you describe.
And it will allow us to add BPF library support for Linux-compatible =
special meanings later, without breaking the ABI.

>=20
> > > To make things worse, `__rte_pktmbuf_read` is also buggy when
> passed
> > > very large
> > > lengths (again, technically not ARM eBPF fault).
> >
> > Are you referring to the potential integer wraparound in the off+len
> > rte_pktmbuf_pkt_len(m)
> > comparison?
> > [BZ1724]
> > Or some other bug in __rte_pktmbuf_read()?
> >
> > [BZ1724]: https://bugs.dpdk.org/show_bug.cgi?id=3D1724
>=20
> Technically that one manifested itself in rte_pktmbuf_read (without
> underscores), but essentially the root cause is the same. In the eBPF
> BPF_ABS
> case we could potentially rely on `__rte_pktmbuf_read` for refusing to
> accept
> negative values converted to large integers, but due to overflows we
> cannot.

Agree.

The off+len wraparound in rte_pktmbuf_read() and __rte_pktmbuf_read() is =
clearly a bug, and not intentional.
Reading the function documentation supports the conclusion that the =
wraparound is a bug; the off and len parameters are unsigned, and the =
documentation says nothing about an ability to make them behave as =
signed.

