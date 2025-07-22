Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B215C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 10:15:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F10BD40283;
	Tue, 22 Jul 2025 12:15:19 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E0A7C40265;
 Tue, 22 Jul 2025 12:15:18 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id AF44F20446;
 Tue, 22 Jul 2025 12:15:18 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2] ethdev: Align enable logic handling with disable
 functions
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 22 Jul 2025 12:15:16 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDBE@smartserver.smartshare.dk>
In-Reply-To: <20250721130545.38200-1-sunyang.wu@jaguarmicro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2] ethdev: Align enable logic handling with disable
 functions
Thread-Index: Adv6QD1bMSwgAHtJTHGonSqa8nXdyQAsS9xw
References: <20250721130545.38200-1-sunyang.wu@jaguarmicro.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Sunyang Wu" <sunyang.wu@jaguarmicro.com>,
	<dev@dpdk.org>
Cc: <thomas@monjalon.net>, <ferruh.yigit@amd.com>,
 <andrew.rybchenko@oktetlabs.ru>, <stable@dpdk.org>
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

> From: Sunyang Wu [mailto:sunyang.wu@jaguarmicro.com]
> Sent: Monday, 21 July 2025 15.06
>=20
> This patch modifies the handling logic of the "enable" related
> operations. The key intention is to align it with the processing
> approach of the "disable" functions.
> Previously, there was an inconsistency in how failure scenarios were
> dealt with between the "enable" and "disable" logic. Now, after
> adjustment, their behaviors in exceptional cases are made more =
uniform.
> Importantly, this change does not introduce any alteration to the =
actual
> runtime behavior of the functions; it only serves to enhance code
> consistency and maintainability, making the overall logic easier to
> understand and maintain in the long run.
> In this way, we ensure the codebase follows a more cohesive pattern,
> reducing potential confusion during future development and maintenance
> efforts that could stem from logical disparities.
>=20
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
> ---
>  lib/ethdev/rte_ethdev.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index dd7c00bc94..41f96071e2 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -3018,7 +3018,8 @@ rte_eth_promiscuous_enable(uint16_t port_id)
>  		return -ENOTSUP;
>=20
>  	diag =3D dev->dev_ops->promiscuous_enable(dev);
> -	dev->data->promiscuous =3D (diag =3D=3D 0) ? 1 : 0;
> +	if (diag =3D=3D 0)
> +		dev->data->promiscuous =3D 1;
>=20
>  	diag =3D eth_err(port_id, diag);
>=20
> @@ -3086,7 +3087,8 @@ rte_eth_allmulticast_enable(uint16_t port_id)
>  	if (dev->dev_ops->allmulticast_enable =3D=3D NULL)
>  		return -ENOTSUP;
>  	diag =3D dev->dev_ops->allmulticast_enable(dev);
> -	dev->data->all_multicast =3D (diag =3D=3D 0) ? 1 : 0;
> +	if (diag =3D=3D 0)
> +		dev->data->all_multicast =3D 1;
>=20
>  	diag =3D eth_err(port_id, diag);
>=20
> --
> 2.19.0.rc0.windows.1

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

