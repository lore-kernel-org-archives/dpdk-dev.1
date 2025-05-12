Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D889C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 16:04:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E66514026C;
	Mon, 12 May 2025 18:04:28 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B4FFF4025F
 for <dev@dpdk.org>; Mon, 12 May 2025 18:04:27 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 93AB82178D;
 Mon, 12 May 2025 18:04:26 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 1/2] ethdev: remove unnecessary type conversion
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 12 May 2025 18:04:25 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC46@smartserver.smartshare.dk>
In-Reply-To: <20250512150732.65743-1-skori@marvell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 1/2] ethdev: remove unnecessary type conversion
Thread-Index: AdvDT6vjnJfap0mpQXyh7HmowhssTAABs/ww
References: <20250429181132.2544771-1-skori@marvell.com>
 <20250512150732.65743-1-skori@marvell.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <skori@marvell.com>, "Shepard Siegel" <shepard.siegel@atomicrules.com>,
 "Ed Czeck" <ed.czeck@atomicrules.com>,
 "John Miller" <john.miller@atomicrules.com>,
 "Igor Russkikh" <irusskikh@marvell.com>,
 "Ajit Khaparde" <ajit.khaparde@broadcom.com>,
 "Somnath Kotur" <somnath.kotur@broadcom.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Kiran Kumar K" <kirankumark@marvell.com>,
 "Satha Rao" <skoteshwar@marvell.com>, "Harman Kalra" <hkalra@marvell.com>,
 "Hemant Agrawal" <hemant.agrawal@nxp.com>,
 "Sachin Saxena" <sachin.saxena@nxp.com>, "John Daley" <johndale@cisco.com>,
 "Hyong Youb Kim" <hyonkim@cisco.com>, "Jie Hai" <haijie1@huawei.com>,
 "Ian Stokes" <ian.stokes@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Dariusz Sosnowski" <dsosnowski@nvidia.com>,
 "Viacheslav Ovsiienko" <viacheslavo@nvidia.com>,
 "Bing Zhao" <bingz@nvidia.com>, "Ori Kam" <orika@nvidia.com>,
 "Suanming Mou" <suanmingm@nvidia.com>, "Matan Azrad" <matan@nvidia.com>,
 "Long Li" <longli@microsoft.com>, "Wei Hu" <weh@microsoft.com>,
 "Chaoyong He" <chaoyong.he@corigine.com>,
 "Jiawen Wu" <jiawenwu@trustnetic.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Jerin Jacob" <jerinj@marvell.com>, "Maciej Czekaj" <mczekaj@marvell.com>,
 "Jian Wang" <jianwang@trustnetic.com>,
 "Maxime Coquelin" <maxime.coquelin@redhat.com>,
 "Chenbo Xia" <chenbox@nvidia.com>,
 "Jochen Behrens" <jochen.behrens@broadcom.com>,
 "Thomas Monjalon" <thomas@monjalon.net>,
 "Ferruh Yigit" <ferruh.yigit@amd.com>
Cc: <dev@dpdk.org>
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

> From: Sunil Kumar Kori <skori@marvell.com>
> Sent: Monday, 12 May 2025 17.07
>=20
> As rte_eth_rx_queue_count() returns signed value to represent
> the error cases but internally invoked callback is returning
> unsigned value. Hence unnecessary type conversion is done.
>=20
> To avoid this typecasting from signed to unsigned, fixed
> return type of callback functions.
>=20
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>

Note for other reviewers:
The tx_queue_count callback already returns int, and doesn't need to be =
updated.

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index ea7f8c4a1a..b3031ab9e6 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -6401,7 +6401,7 @@ rte_eth_rx_queue_count(uint16_t port_id, =
uint16_t
> queue_id)
>=20
>  	if (p->rx_queue_count =3D=3D NULL)
>  		return -ENOTSUP;
> -	return (int)p->rx_queue_count(qd);
> +	return p->rx_queue_count(qd);
>  }
>=20
>  /**@{@name Rx hardware descriptor states
> diff --git a/lib/ethdev/rte_ethdev_core.h
> b/lib/ethdev/rte_ethdev_core.h
> index e55fb42996..4ffae4921a 100644
> --- a/lib/ethdev/rte_ethdev_core.h
> +++ b/lib/ethdev/rte_ethdev_core.h
> @@ -45,7 +45,7 @@ typedef uint16_t (*eth_tx_prep_t)(void *txq,
>=20
>=20
>  /** @internal Get number of used descriptors on a receive queue. */
> -typedef uint32_t (*eth_rx_queue_count_t)(void *rxq);
> +typedef int (*eth_rx_queue_count_t)(void *rxq);
>=20
>  /** @internal Check the status of a Rx descriptor */
>  typedef int (*eth_rx_descriptor_status_t)(void *rxq, uint16_t =
offset);
> --
> 2.43.0

For the ethdev library changes:
Reviewed-by: Morten Br=F8rup <mb@smartsharesystems.com>

