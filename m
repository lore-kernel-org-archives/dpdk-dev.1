Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB90C28B30
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Mar 2025 13:14:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53F334064A;
	Sun, 23 Mar 2025 14:14:50 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 28B6D40277
 for <dev@dpdk.org>; Sun, 23 Mar 2025 14:14:49 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E1FA0204FE;
 Sun, 23 Mar 2025 14:14:48 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] app/testpmd: fix VLAN header parsing
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sun, 23 Mar 2025 14:14:47 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FB3D@smartserver.smartshare.dk>
In-Reply-To: <20250323122822.90407-1-rasland@nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] app/testpmd: fix VLAN header parsing
Thread-Index: Adub7ychN6qp7eAbQ9WlHC+vhidkVwABZcsg
References: <20250323122822.90407-1-rasland@nvidia.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Raslan Darawsheh" <rasland@nvidia.com>,
	<thomas@monjalon.net>
Cc: <dev@dpdk.org>,
	<haijie1@huawei.com>
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

> From: Raslan Darawsheh [mailto:rasland@nvidia.com]
> Sent: Sunday, 23 March 2025 13.28
>=20
> Updated the `get_ethertype_by_ptype` function to correctly parse VLAN
> headers.
>=20
> Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
> Cc: haijie1@huawei.com
>=20
> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
> ---
>  app/test-pmd/csumonly.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
> index 5b906eaa53..302cc4cc66 100644
> --- a/app/test-pmd/csumonly.c
> +++ b/app/test-pmd/csumonly.c
> @@ -468,6 +468,7 @@ get_ethertype_by_ptype(struct rte_ether_hdr
> *eth_hdr, uint32_t ptype)
>  {
>  	struct rte_vlan_hdr *vlan_hdr;
>  	uint16_t ethertype;
> +	uint32_t i =3D 0;
>=20
>  	switch (ptype) {
>  	case RTE_PTYPE_L3_IPV4:
> @@ -486,10 +487,11 @@ get_ethertype_by_ptype(struct rte_ether_hdr
> *eth_hdr, uint32_t ptype)
>  		return _htons(RTE_ETHER_TYPE_IPV6);
>  	default:
>  		ethertype =3D eth_hdr->ether_type;
> -		while (eth_hdr->ether_type =3D=3D _htons(RTE_ETHER_TYPE_VLAN)
> ||
> -			eth_hdr->ether_type =3D=3D _htons(RTE_ETHER_TYPE_QINQ)) {
> +		while (ethertype =3D=3D _htons(RTE_ETHER_TYPE_VLAN) ||
> +			ethertype =3D=3D _htons(RTE_ETHER_TYPE_QINQ)) {
>  			vlan_hdr =3D (struct rte_vlan_hdr *)
> -				((char *)eth_hdr + sizeof(*eth_hdr));
> +				((char *)eth_hdr + sizeof(*eth_hdr) +
> +				(i * sizeof(struct rte_vlan_hdr)));

Doesn't work; "i" is not incremented, and remains 0.
Instead do this: Initialize (struct rte_vlan_hdr =
*)vlan_hdr=3DRTE_PTR_ADD(eth_hdr, offsetof(rte_ether_hdr, ether_type)) =
before the loop, and move vlan_hdr+=3DRTE_VLAN_HLEN inside the loop.

>  			ethertype =3D vlan_hdr->eth_proto;
>  		}
>  		return ethertype;
> --
> 2.39.5 (Apple Git-154)

