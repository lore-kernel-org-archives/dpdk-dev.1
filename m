Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F370F46100
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 13:20:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF6504065D;
	Mon, 23 Mar 2026 14:20:33 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013010.outbound.protection.outlook.com
 [40.93.201.10]) by mails.dpdk.org (Postfix) with ESMTP id C2A6B4064E
 for <dev@dpdk.org>; Mon, 23 Mar 2026 14:20:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3yp+qYx3EuFQFuUujV4d80px7GBgS/zHaiR6CH/ZT59qXJti8dhdVQyDcrrkKys8omE8Aw7FT4cN3lZ/jzEdeUSAkHImwa3w5ZT6m3R6usQ6aT8h1a3s47aOAbvR+qFsKOuNOHlqyJ7afd7m/MMabDsq0HrzK8Uv6Wuofz8AowRWh5AzYkMqbUi/dKW1XUoCsaI0cRv1BdXmnMm5kuy92jYFeXWQU0QqYcBGYN6ZVg+/zCKoGsyIMmQz9eWY+IMJ2Jc4j4pKlofafqB/zMseC+FoPGTrT+oevMIVBaKoxq33Ze5453e5mbpV8wUAWajSpKtZn3x1nTw+cVvuJCveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzQYAOeA+FvKJ1rfG9hWH0Dnm6FkxvIfnwSqGV4WEyU=;
 b=diIlpvSsDg7n257pmjoQHPAE97K1rNcvELkPutfzOSn9K/CK4AKD+O8vs0I/k5NT/Ly4zh3lZmMXeuHxClbZumVQEsyUHQopwyDybCAP+ymEFE+Hu8V7AS8Y9pDCMgSXmiqjyrpIzhsy6I3g6yXoPFsp7ZmqHDqLnY41yRs43wZwRLrQZ5coU/PsaXHF0VfTA0J20YASPkspd5bDUYYVf2OC8ObS9EDxsY9eKadmXk6Gj55j93SkhogfH9bb/pgsvEOjl3DF6PsM1VRdko4tn5mdsqqlOQDnglFpTmulfhSI+qvCx2ip0zS+RReD1dXJZ89vW8NB1MEAuJFc6ut90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzQYAOeA+FvKJ1rfG9hWH0Dnm6FkxvIfnwSqGV4WEyU=;
 b=Bhwr03aKX2GbF2tpdw5j44b/M6n7jfpJoZIsXmpGzGELIYzKIMDoJCzhciiiOxCq4LEBhs0P83cu3HiYHJQw5+jebqsP/WIVb6YL5JincIJd7wc6Rp4D2N1p3q+tihGV8E8OECP2y7SwE5RlwyTXJmnRMW8MJOOMrkGABiDICcq/DJM5loJxnG/J2LypJFm2hLg30s3UXEsh4lADaTwH4PgqvIN+IO6117+07qXGnzt4I+bnZ4DNdi6vHMLuMFZcPzBDu3TjNyEoW4HLuJ4SMcHsoRNkj7kaVBRkP4hbET0hSj2YtW3qrTRIRBZICoFXjP8Clycw/QAd48JWmd1C3g==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 13:20:28 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%4]) with mapi id 15.20.9745.015; Mon, 23 Mar 2026
 13:20:28 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Vincent Jardin <vjardin@free.fr>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "aman.deep.singh@intel.com" <aman.deep.singh@intel.com>
Subject: RE: [PATCH v4 10/10] net/mlx5: add rate table capacity query API
Thread-Topic: [PATCH v4 10/10] net/mlx5: add rate table capacity query API
Thread-Index: AQHcugK5UZnzcbFTxUa4eMmGJG0CIbW8G5nw
Date: Mon, 23 Mar 2026 13:20:27 +0000
Message-ID: <DM4PR12MB608793BB56757FBCBE1F13B8DF4BA@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260312220120.3256755-1-vjardin@free.fr>
 <20260322134629.94633-1-vjardin@free.fr>
 <20260322134629.94633-11-vjardin@free.fr>
In-Reply-To: <20260322134629.94633-11-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|PH7PR12MB7257:EE_
x-ms-office365-filtering-correlation-id: 582b6f68-ada1-4f59-8525-08de88def364
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003|15866825006|41080700001;
x-microsoft-antispam-message-info: EV0VJNDdZwzpieY4vWpVoXvvXQT/pJMS+GU0gMu+7pq4reYw953GKrfY7WIyGk3SPVmvnkO9G1mtBC8UXPCIIuszOC/zG+fwyIM87s/ffyLLqHHmHNJLmTO5ujwbt8bjmnuPSECF7ge4CF6Z+YjZLAKIB42B89tIfEfp8iJAtguiQmOR8klNMve9qlILYDCIE/pdJNDf9v/Jxu5/mL437U2wBXQiTv6xLDlh8TMl0HPChLAe1G+/+jkEwFKxojzQnKv02wyZ1/qZlRbnghDeVpBMk5bQrK/mwTCuinOJF5XCaAnK2lfmu6886BGX2vOr1SP5eP8PX56L7Cz3hbHC5ECVepG7eT+yRDzxshk3Sok8PJSWPt429ZWgoTM+GzQd3NTCldugEc3tqPCSUWV/+xQQRuFoGC3vtpIahPOOrDzeSrNC3bsERftj7Mcf5nPU15/EGAWV7eo+Ec5ZHLivwwJ+TQqerqg/jsX1uzBJyin9ee68gzQj/JnBQTkCbdEs9RBdSyeN8qb/HnMXNSKBozZnMo8K1JI4RyVnVu/VKx/PyQWmvvR2uphwt9BOmlVqN9pl4yETg2aNSbjiktzUm3yra4crBM+MF9MFao2cMblJudmhwDP2DfkqNNBzRG+DfruTRepQVciSg5wTAp2Nl7WOSCp4IoC0VLEdfYnVs2YWEB1kOKhyMXhMyqNwayxqiFTUQn2uC3uERbmAs8w3+5nrr4WJMmS4de4NmuMIlxF+oIN54MOvnlEpw66STmcy7RdhoIh215eeuaOAt3jPRvPuf/yysNI2wyra+eKyCbsGb+DwU+IiIlecH4KWAq7d2GQXSxYpIdd9pFBqSFKQJZwNFODzcZHoFzJZ0zAaPOw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y6D6OT2gwAvGETQaxW/Uhoa/HEZ1+8LdOuyBWGHe3yuYpdZOFpaO/sgd4hY/?=
 =?us-ascii?Q?bt5tLeWygcXtMdSHZM+ldFEPhUrGEJVbGTytcNILVw93x8oMcXIkbYoQMMpO?=
 =?us-ascii?Q?wgJeirrHj3iyEwmdAL4PKKjlfKeb0WfjrenNiFCdmlF8bS9nnFc7bp4sS4RA?=
 =?us-ascii?Q?07h71lRvrqUbP4fOppPYageGY0KIpNUpojL/Jo2gQEp081yw/QaiHlb4eNIF?=
 =?us-ascii?Q?Va58Le+pM8Zz5pFIO6cbZ/TfEPlsdtF03hx2ZvoSWEkWnMXpQaHgAoQf51wP?=
 =?us-ascii?Q?b8AxwGboGnNrGr+6loM5eoT9nGDp8SDGgJV2CKkthKxPYluEQK7DR46BdSr1?=
 =?us-ascii?Q?1e9/dHFsz6+MCy8rGtVWAGMUP88lF1Uj9e5PFyifMqYZ4w6CLGPSpiFIJP1m?=
 =?us-ascii?Q?IPCLj1Ch4VE8Tba2nHEnUahjE5PcEKVcaF3WhGIh1N6cbtARf0flPj+FsySi?=
 =?us-ascii?Q?WROl5IxV5P15LbD9f/owa21yi2ewqtEFYEmtB0PsYDs+NTRg4cKWf20fUjGf?=
 =?us-ascii?Q?DM0L6NMcnm66/5car5mSbqmjs/E2j/zVvUo1BlIeWkeOQ7ElI0+kYIB33pNx?=
 =?us-ascii?Q?KgMN6Qyt9CU4ESREaaDymx9drlNF5+VnAWJyLkBvDsuC2F43w6Vf60ZdcDu5?=
 =?us-ascii?Q?Rv3FXcmkAX8c1nE5XSxPM7VjoxycWA0emDRxJWJxngtPhEd0+KO9BOacehzD?=
 =?us-ascii?Q?H5CKZkfI0GKzm2O+oE6xh55ggQtOeZS1II777giM4hpRO2s1Bx6KNcJaM1iS?=
 =?us-ascii?Q?cPQsOTRlnHgqQTf20QC2AoQPHSbEMCHE8f2InkpZ5SWw7xLHl7Pyq62KucB0?=
 =?us-ascii?Q?RqCKGc73YgJhKyfoJZaNJtbQvn0675Vedqv8qyPlfGXa3Rd8M74lNOdjIOOk?=
 =?us-ascii?Q?osF176AM5gWYPwZxfqqBosTiEP2lbd1SSihw4HoK0jOIiPM3sA3H+ucVILZU?=
 =?us-ascii?Q?rwUo+9F+DyoJ+cpJji/mDuLhmoBPLT/BTuzeMMhHmrcZvafagJgGRkg0NVVD?=
 =?us-ascii?Q?BHyBUOJFyBuvVStIdabMJ/D1GDf+pDSCETFzGFL7/eb9sG9T8b59dzh/n7dY?=
 =?us-ascii?Q?r4PfloRXZKCopse2AAX8VzVNWC9mkywmfRQtiDqUTRlzXPm2lN8o7480WU6U?=
 =?us-ascii?Q?wIFMxtGVZmAn1eM4IfXNuxvyBt7pFnZ3LcaUVVCEdEzAn+HkYTsQ73/aK3J3?=
 =?us-ascii?Q?23Y0YWV2YMbTPelRIcEoPhh9szfYp5cdDXsxdeC/TMiqMFgYZljsAlKYkX71?=
 =?us-ascii?Q?jfxIBw1Y2jfEk24fWxQWvLMQkSexets4S/ZDwPycXYJtKC5enULrvELTyG4u?=
 =?us-ascii?Q?gwNYYHrWUlCUEZkrovAb/UFHFLvU6JA3cxvkTBS7UTqDlok+GGGvs90IHLHs?=
 =?us-ascii?Q?yXBmgL1HpZl6Oc89L4OXXzfefMXDAwcy/6+IZkhpmGvA1pAYT+XGvjVxWZ0T?=
 =?us-ascii?Q?pL0hqsvlyox1NWcqn/SmZcIoj6gmb7scNFuGRWxoVhFeFimGmYRZBcbMn8nm?=
 =?us-ascii?Q?kJ8izKh30MyEVILvaAvJsMtduWIJfHFy+XZ05YlyvfqmgP2Or85RhOY34wsU?=
 =?us-ascii?Q?D4mJGvOjYAuCvIKurwl0ZIYXSucJ/X4PZLJzPysNyOFa1+fCDFVYee9sEUas?=
 =?us-ascii?Q?fW4FZn0Im9MndEA+Zwg64xir6b+GSVP/LFxpHore8df6CyUEyFLoi8HmCWOh?=
 =?us-ascii?Q?mHrjOD8lsC8RxPDaKkf3t6gqCWRFZYg/BqLj8sS7y+McfmfKvnDi/R5ZqoVQ?=
 =?us-ascii?Q?2YC6yeAJVw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582b6f68-ada1-4f59-8525-08de88def364
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 13:20:28.0089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pt9lfN2um7WPqpXD5ZTSvd60idgjLuwxz0+iigVdg922dnEdgfw4OR4I8OxwhW+q73ggpw8V2sz7sVwih8pkOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
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

Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

> -----Original Message-----
> From: Vincent Jardin <vjardin@free.fr>
> Sent: Sunday, March 22, 2026 3:46 PM
> To: dev@dpdk.org
> Cc: Raslan Darawsheh <rasland@nvidia.com>; NBU-Contact-Thomas Monjalon
> (EXTERNAL) <thomas@monjalon.net>; andrew.rybchenko@oktetlabs.ru;
> Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>; stephen@networkplumber.org;
> aman.deep.singh@intel.com; Vincent Jardin <vjardin@free.fr>
> Subject: [PATCH v4 10/10] net/mlx5: add rate table capacity query API
>=20
> Add rte_pmd_mlx5_pp_rate_table_query() to report the HW packet pacing
> rate table size and how many entries are used by this port.
>=20
> The total comes from the HCA QoS capability packet_pacing_rate_table_size=
.
> The port_used count is derived by collecting unique non-zero PP indices a=
cross
> this port's TX queues.
>=20
> The rate table is a global shared HW resource: firmware, kernel, other DP=
DK
> ports on the same device, and other application instances may all consume
> entries. The port_used count is therefore a lower bound of actual HW usag=
e.
>=20
> With shared PP allocation (flags=3D0), the kernel mlx5 driver reuses a si=
ngle rate
> table entry for all PP contexts with identical parameters (rate, burst, p=
acket
> size). Multiple queues configured with the same rate share one pp_id, so
> port_used counts unique entries, not the number of queues with rate limit=
ing
> enabled.
>=20
> Applications that need device-wide visibility should query all ports on t=
he same
> physical device and aggregate the results, similar to how the kernel mlx5=
 driver
> tracks usage internally.
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  drivers/net/mlx5/mlx5_tx.c      | 64 +++++++++++++++++++++++++++++++++
>  drivers/net/mlx5/rte_pmd_mlx5.h | 44 +++++++++++++++++++++++
>  2 files changed, 108 insertions(+)
>=20
> diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c inde=
x
> 7d71782d33..615b792836 100644
> --- a/drivers/net/mlx5/mlx5_tx.c
> +++ b/drivers/net/mlx5/mlx5_tx.c
> @@ -19,6 +19,7 @@
>=20
>  #include <mlx5_prm.h>
>  #include <mlx5_common.h>
> +#include <mlx5_malloc.h>
>=20
>  #include "mlx5_autoconf.h"
>  #include "mlx5_defs.h"
> @@ -886,3 +887,66 @@ int rte_pmd_mlx5_txq_rate_limit_query(uint16_t
> port_id, uint16_t queue_id,
>  				     packet_pacing_rate_limit_index);
>  	return 0;
>  }
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_pp_rate_table_query,
> 26.07)
> +int rte_pmd_mlx5_pp_rate_table_query(uint16_t port_id,
> +				     struct rte_pmd_mlx5_pp_rate_table_info
> *info) {
> +	struct rte_eth_dev *dev;
> +	struct mlx5_priv *priv;
> +	uint16_t used =3D 0;
> +	uint16_t *seen;
> +	unsigned int i;
> +
> +	if (info =3D=3D NULL)
> +		return -EINVAL;
> +	if (!rte_eth_dev_is_valid_port(port_id))
> +		return -ENODEV;
> +	dev =3D &rte_eth_devices[port_id];
> +	priv =3D dev->data->dev_private;
> +	if (!priv->sh->cdev->config.hca_attr.qos.packet_pacing) {
> +		rte_errno =3D ENOTSUP;
> +		return -ENOTSUP;
> +	}
> +	info->total =3D priv->sh->cdev-
> >config.hca_attr.qos.packet_pacing_rate_table_size;
> +	if (priv->txqs =3D=3D NULL || priv->txqs_n =3D=3D 0) {
> +		info->port_used =3D 0;
> +		return 0;
> +	}
> +	seen =3D mlx5_malloc(MLX5_MEM_SYS | MLX5_MEM_ZERO,
> +			   priv->txqs_n * sizeof(*seen), 0, SOCKET_ID_ANY);
> +	if (seen =3D=3D NULL)
> +		return -ENOMEM;
> +	/*
> +	 * Count unique non-zero PP indices across this port's TX queues.
> +	 * Note: the count reflects only queues on this port; other ports
> +	 * sharing the same device may also consume rate table entries.
> +	 */
> +	for (i =3D 0; i < priv->txqs_n; i++) {
> +		struct mlx5_txq_data *txq_data;
> +		struct mlx5_txq_ctrl *txq_ctrl;
> +		uint16_t pp_id;
> +		uint16_t j;
> +		bool dup;
> +
> +		if ((*priv->txqs)[i] =3D=3D NULL)
> +			continue;
> +		txq_data =3D (*priv->txqs)[i];
> +		txq_ctrl =3D container_of(txq_data, struct mlx5_txq_ctrl, txq);
> +		pp_id =3D txq_ctrl->rate_limit.pp_id;
> +		if (pp_id =3D=3D 0)
> +			continue;
> +		dup =3D false;
> +		for (j =3D 0; j < used; j++) {
> +			if (seen[j] =3D=3D pp_id) {
> +				dup =3D true;
> +				break;
> +			}
> +		}
> +		if (!dup)
> +			seen[used++] =3D pp_id;
> +	}
> +	mlx5_free(seen);
> +	info->port_used =3D used;
> +	return 0;
> +}
> diff --git a/drivers/net/mlx5/rte_pmd_mlx5.h
> b/drivers/net/mlx5/rte_pmd_mlx5.h index 698d7d2032..621d8c2b15 100644
> --- a/drivers/net/mlx5/rte_pmd_mlx5.h
> +++ b/drivers/net/mlx5/rte_pmd_mlx5.h
> @@ -450,6 +450,50 @@ int
>  rte_pmd_mlx5_txq_rate_limit_query(uint16_t port_id, uint16_t queue_id,
>  				  struct rte_pmd_mlx5_txq_rate_limit_info
> *info);
>=20
> +/**
> + * Packet pacing rate table capacity information.
> + */
> +struct rte_pmd_mlx5_pp_rate_table_info {
> +	uint16_t total;		/**< Total HW rate table entries. */
> +	uint16_t port_used;	/**< Entries used by this port's TX queues. */
> +};
> +
> +/**
> + * Query packet pacing rate table capacity.
> + *
> + * The ``port_used`` count reflects only unique PP indices allocated
> + * by the queried port's TX queues. It is a lower bound of actual HW
> + * usage because the rate table is a global shared resource:
> + * - Other DPDK ports on the same physical device may hold entries.
> + * - The kernel mlx5 driver and firmware may also consume entries.
> + * - Multiple DPDK application instances may share the device.
> + *
> + * When multiple queues on the same port are configured with identical
> + * rate parameters, the kernel shares a single rate table entry across
> + * them (with flags=3D0 allocation), so ``port_used`` counts unique
> + * entries, not the number of queues with rate limiting enabled.
> + *
> + * Applications that need device-wide visibility should query all
> + * ports on the same physical device and aggregate the results,
> + * similar to how the kernel mlx5 driver tracks usage internally.
> + *
> + * @param[in] port_id
> + *   Port ID.
> + * @param[out] info
> + *   Rate table capacity information.
> + *
> + * @return
> + *   0 on success, negative errno on failure:
> + *   - -ENODEV: invalid port_id.
> + *   - -EINVAL: info is NULL.
> + *   - -ENOTSUP: packet pacing not supported.
> + *   - -ENOMEM: allocation failure.
> + */
> +__rte_experimental
> +int
> +rte_pmd_mlx5_pp_rate_table_query(uint16_t port_id,
> +				 struct rte_pmd_mlx5_pp_rate_table_info
> *info);
> +
>  /** Type of mlx5 driver event for which custom callback is called. */  e=
num
> rte_pmd_mlx5_driver_event_cb_type {
>  	/** Called after HW Rx queue is created. */
> --
> 2.43.0

