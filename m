Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA0AC83F03
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 10:18:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26F1E4028B;
	Fri,  4 Jul 2025 12:18:47 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9F83440267
 for <dev@dpdk.org>; Fri,  4 Jul 2025 12:18:45 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6D65720544;
 Fri,  4 Jul 2025 12:18:45 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] net: support VLAN stacking packet type parsing
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 4 Jul 2025 12:18:45 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD8D@smartserver.smartshare.dk>
In-Reply-To: <20250703093027.1259459-1-huangdengdui@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net: support VLAN stacking packet type parsing
Thread-Index: Advr/SEc6yib2bIfSdmKhP6WtFOZwwAy5m9Q
References: <20250703093027.1259459-1-huangdengdui@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Dengdui Huang" <huangdengdui@huawei.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
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

> From: Dengdui Huang [mailto:huangdengdui@huawei.com]
> Sent: Thursday, 3 July 2025 11.30
>=20
> The current rte_net_get_ptype() only supports parsing packets with
> one 0x8100 VLAN tag or two 0x88a8 VLAN tags. This patch extends it
> to support parsing packets with two 0x8100 VLAN tags.
>=20
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---
>  lib/net/rte_net.c | 34 ++++++++++++++++++++++------------
>  lib/net/rte_net.h |  2 ++
>  2 files changed, 24 insertions(+), 12 deletions(-)
>=20
> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
> index 44fb6c0f51..fa8d023ca7 100644
> --- a/lib/net/rte_net.c
> +++ b/lib/net/rte_net.c
> @@ -352,14 +352,19 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf
> *m,
>  	if (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
>  		const struct rte_vlan_hdr *vh;
>  		struct rte_vlan_hdr vh_copy;
> +		uint8_t vlan_num =3D 1;
>=20
>  		pkt_type =3D RTE_PTYPE_L2_ETHER_VLAN;
> -		vh =3D rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
> -		if (unlikely(vh =3D=3D NULL))
> -			return pkt_type;
> -		off +=3D sizeof(*vh);
> -		hdr_lens->l2_len +=3D sizeof(*vh);
> -		proto =3D vh->eth_proto;
> +		while (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) &&
> +		       vlan_num <=3D MAX_VLAN_STACKING_TAGS) {
> +			vh =3D rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
> +			if (unlikely(vh =3D=3D NULL))
> +				return pkt_type;
> +			off +=3D sizeof(*vh);
> +			hdr_lens->l2_len +=3D sizeof(*vh);
> +			proto =3D vh->eth_proto;
> +			vlan_num++;
> +		}

It's not that simple.

VLAN tags are not like MPLS labels.
With the MPLS packet type, we expect a stack of labels.
But with VLAN tagged packets, we expect exactly one VLAN tag at each =
outer/inner layer of headers. (Or no VLAN tag at the inner layer.)

This function already supports packets with 2 VLAN tags:
A stack of 2 VLAN tags is currently detected as 1 outer VLAN tag, =
adjusting hdr_lens->l2_len accordingly, and 1 inner VLAN tag, adjusting =
hdr_lens->inner_l2_len accordingly.
This behavior should not be changed.

I don't have a firm idea about how to better represent packets with a =
stack of 3+ VLAN tags than what we do today, so suggestions are welcome.

Which use case is this patch addressing?
Maybe information about the use case could guide us in some direction.

>  	} else if (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
>  		const struct rte_vlan_hdr *vh;
>  		struct rte_vlan_hdr vh_copy;
> @@ -504,15 +509,20 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf
> *m,
>  	if (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
>  		const struct rte_vlan_hdr *vh;
>  		struct rte_vlan_hdr vh_copy;
> +		uint8_t vlan_num =3D 1;
>=20
>  		pkt_type &=3D ~RTE_PTYPE_INNER_L2_MASK;
>  		pkt_type |=3D RTE_PTYPE_INNER_L2_ETHER_VLAN;
> -		vh =3D rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
> -		if (unlikely(vh =3D=3D NULL))
> -			return pkt_type;
> -		off +=3D sizeof(*vh);
> -		hdr_lens->inner_l2_len +=3D sizeof(*vh);
> -		proto =3D vh->eth_proto;
> +		while (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) &&
> +		       vlan_num <=3D MAX_VLAN_STACKING_TAGS) {
> +			vh =3D rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
> +			if (unlikely(vh =3D=3D NULL))
> +				return pkt_type;
> +			off +=3D sizeof(*vh);
> +			hdr_lens->inner_l2_len +=3D sizeof(*vh);
> +			proto =3D vh->eth_proto;
> +			vlan_num++;
> +		}
>  	} else if (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
>  		const struct rte_vlan_hdr *vh;
>  		struct rte_vlan_hdr vh_copy;
> diff --git a/lib/net/rte_net.h b/lib/net/rte_net.h
> index 65d724b84b..fdd55d57c8 100644
> --- a/lib/net/rte_net.h
> +++ b/lib/net/rte_net.h
> @@ -13,6 +13,8 @@
>  extern "C" {
>  #endif
>=20
> +#define MAX_VLAN_STACKING_TAGS	2
> +
>  /**
>   * Structure containing header lengths associated to a packet, filled
>   * by rte_net_get_ptype().
> --
> 2.33.0

