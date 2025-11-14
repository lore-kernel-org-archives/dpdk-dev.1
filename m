Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD21ECE8D50
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:14:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FB9740DCA;
	Fri, 14 Nov 2025 17:14:37 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id F12DB40151;
 Fri, 14 Nov 2025 17:14:35 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E6904214D9;
 Fri, 14 Nov 2025 17:14:34 +0100 (CET)
Subject: RE: [PATCH dpdk] net: ipv6 link local compliance with rfc 4291
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Nov 2025 17:14:32 +0100
Content-class: urn:content-classes:message
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65560@smartserver.smartshare.dk>
In-Reply-To: <20251114080532.1e86d13e@phoenix>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH dpdk] net: ipv6 link local compliance with rfc 4291
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: AdxVgIUjn4qQUJ41Qo6jD5HGfdJiZwAAEDPA
References: <20251114105751.54802-3-rjarry@redhat.com>
 <20251114080532.1e86d13e@phoenix>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Robin Jarry" <rjarry@redhat.com>
Cc: <dev@dpdk.org>, "Christophe Fontaine" <cfontain@redhat.com>,
 <stable@dpdk.org>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Friday, 14 November 2025 17.06
>=20
> On Fri, 14 Nov 2025 11:57:53 +0100
> Robin Jarry <rjarry@redhat.com> wrote:
>=20
> > diff --git a/app/test/test_net_ip6.c b/app/test/test_net_ip6.c
> > index cfc550940306..e4642c9a39d9 100644
> > --- a/app/test/test_net_ip6.c
> > +++ b/app/test/test_net_ip6.c
> > @@ -160,7 +160,7 @@ test_ipv6_llocal_from_ethernet(void)
> >  {
> >  	const struct rte_ether_addr local_mac =3D {{0x04, 0x7b, 0xcb, =
0x5c,
> 0x08, 0x44}};
> >  	const struct rte_ipv6_addr local_ip =3D
> > -		RTE_IPV6(0xfe80, 0, 0, 0, 0x047b, 0xcbff, 0xfe5c, 0x0844);
> > +		RTE_IPV6(0xfe80, 0, 0, 0, 0x067b, 0xcbff, 0xfe5c, 0x0844);
> >  	struct rte_ipv6_addr ip;
>=20
> Reading the kernel source there is also special handling to include
> device
> id into link local address. This is to handle corner case where
> multiple network
> cards have same hardware MAC address.

Multiple physical NICs should never have the same MAC address.
Lots of stuff will break if they do.
E.g. a network switch will forward packets to the NIC that most recently =
sent packets, so its MAC address was learned in the MAC address table in =
the switch.

What is the use case justifying this tweak in the kernel?

>=20
> Perhaps DPDK should roll port id into link local address?
