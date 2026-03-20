Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E800F109879F
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 15:50:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3845E402BB;
	Fri, 20 Mar 2026 16:50:03 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
 by mails.dpdk.org (Postfix) with ESMTP id A4997402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 16:50:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jix+EjkqhcKlqZcWN2RIJBOcqffb/W3+aWrZCbp88bCdOe/wSoQDM1adAx6YyFA06+4SgASg722GlTOo3mjMirosh2qgvFsE8mqcVlcQEsV6SYEdqweu45+Uz3uxdHOH5b2KpLJmdrbSVpn4JEjezwNGinqHj9qCbCmpqB30i3baLgBUUV/SKNcy/AZtSAQadoPUEh+24hcPrOvA+szXuD1XV32nR4bE2TdJ2nDmziS0vRktxKhp3I70Qm8bFGIP3XWKRG7Qo5Yhowm8dUjUFjnjeUqtf/5fz5j2RZ1F9JQ4GfEm2Eu+Uwufs1kgGvME/w4isVkX1fxM5TizIZFGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHVo7NA2GGUAj43kTc9HpWGj0o2oD6mnmtXNecZhpEU=;
 b=jOgV71EV6h18dhUPxcJWb5O2orJ3FNtEe4llm9LEWkDZkxFSjB2ZpbMcwlGSAt/Q69TA4sEyKj7ahTg5qFluy7mm3FczTlYAfNUeEC0m+mRZ7Y/ObP1E00Mg2O7/mcwO+IKoIP1BmazBywpIyWM/gQqI75CSmtTd5AQpbfV16ds+muGQPKV7cq9vM+kCSRDiavHGoqTtYZtZW2/wAmQHHLCeGsiQr58lT8sNarQ6pHU0CsCiJwRpeat+apudfTTjVq/Wq2SajhXFzQiOdegMnZoaRa8mm07uXoAqB6eob2N4IusJ+5a67EHKZxidKcrZb9llhfDzG7FVWRxFYRxNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHVo7NA2GGUAj43kTc9HpWGj0o2oD6mnmtXNecZhpEU=;
 b=tgAqAuHs+1fL3WFwYUMZAVAUcXgfISZpytG9DLzXFfjTk4fbHC7c2cNV0VxygFDkDVv05m37abm5xYEECAdi72uOiOOqSdZOuWdrlswqla4W8nUKmQhw6lsngZtgrE1tuggjj5jhaGKitWEVhRSfB//OV/gH64z9GmmMmesDYfim/Te73a54rejRyY5XWhtvKXcj6ejAeJDbdfiX6IWbyLdQb3G6F7NzbqhBEoK+hWJ1e5eEIEkFHGjvzAZwaoAWBW8FeiJ3/q0WYt1VD7ncZEZ593soOh+SXADXj/75UlGqlR72HFmCThwTDoezfjTcGNpKpjjJzI97DRQD7wk3iw==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 15:49:57 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 15:49:56 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Vincent Jardin <vjardin@free.fr>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Subject: RE: [PATCH v3 09/9] net/mlx5: add rate table capacity query API
Thread-Topic: [PATCH v3 09/9] net/mlx5: add rate table capacity query API
Thread-Index: AQHcsmwj39PixREtIEOOsSU8O9tdnrW3nIMA
Date: Fri, 20 Mar 2026 15:49:56 +0000
Message-ID: <DM4PR12MB6087987E76E32207E5EDDF21DF4CA@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260312220120.3256755-1-vjardin@free.fr>
 <20260312220120.3256755-10-vjardin@free.fr>
In-Reply-To: <20260312220120.3256755-10-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|CH3PR12MB8354:EE_
x-ms-office365-filtering-correlation-id: 61359602-5b2f-4bf0-80ac-08de869855f8
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003|15866825006|41080700001;
x-microsoft-antispam-message-info: MLkOXqVaDnS7u59DRUqt+I8gKJo7AezrqWk9jI23SsG4FbuetDYIb3v75zCkBmexiy0LCtrydnwRPlaWleTrUkMdUelH9c/9LErCG/4jkAKp64qmPTM7y/447V5ORwfiwfl5C1KtIMeNg+AA/xOJxTYjZjzHDyEhJxbCLt1CRliEV80wkYwjbs9usYA+qpr8SzoOO4UTm5wtD37QiSN1SIhiQK1QK2dusMpaCLFR77glsVQVWuANPOkzydhRJEA9cMml0+mvVtQJPpdf/KL4a/a7x88sVIP5Oo8SmPKcVGRuUXLnviUIczi5T/fgbx8OpxKf7xTRThaPFJPv2OrIfe982DGzI6Bk8oLS0xa+ctCdRlnnA2SAO0JY/fxkEF1tfttzIkVFjxLmnDjUhZIhjktyToAIPHrqb3NvgM3y/a6omqtQiIO4Mro5cjqc2BTMZ8cgWlM8ghw6rlvTZy/AEFZGAPFchbUYa+gxSG06uQmxa1H7qiIvzIYLR2cyuvFeq/Oi9lmtc9oNuZ1QcxloGwXMqNSsKHCpMkksy62QUqGvcD/XrPkNcVzcti4jaqt9oeauF0t5NnDO0uTnsaCk0eJT08Lvh2uXdti4JX8MlVPbV4eDKVvYaAna95y6DlB8Z14RvXVvIr0cyKaqKM6+oE3yuiDMsxd9QsaMyF5pbwVnv1HZl6tYVG6TXO73FrkDWxfMxhjXd2N6HzA3xMKKzRXLc03n3AAH7ka/xDP4A1mAOKpvDw54uElm1eDYCnJrtYYMW99ud1v5JkO9p300sxpULfs/Lm6S37orosD8N+Y30u4RkOhBZHRh99jVmz6OE3yaX0pv5QeLlQrodtulU+HpzGoIP+GCvi8Su62wnu8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3xzN3nezYXNmnsKJN7PnM4+aLGq6M49pZXwkw1ecV+LaBBpLZBeA48kg2n2o?=
 =?us-ascii?Q?OwZR9bNF9GA0jUP34yj/HW0PXlInt3ZU0+Fp1A9hRDS/8dT05okXXRJ0Rvb9?=
 =?us-ascii?Q?nWrsG+ETV24i4gZ9QkwoWjZEzsCd1rfTK0ck8Mv2hPl2SwF6xZVOaVNBPdSq?=
 =?us-ascii?Q?/K74BWTjM/JloHRyAnBqc5S7TRY1AInI7fSDYU0QjcGl+4Dt01Fk1kpLS+FY?=
 =?us-ascii?Q?gdr129TRkNVIP0ZiSssMFg+RWEBFQaxRsfiftLyNwMElHuR9ex4C70YHdPNG?=
 =?us-ascii?Q?O9B8MktFmHLvS3KNyWgCl9ivicLuNcz1Xcs6T/n4OOT5lfJLAlPChGmCt69u?=
 =?us-ascii?Q?u1adkIcXet3H0/bLZPNsJqpjk52m1ggUcCeZhs6v4XtgROwyy9kNtT/iHBCT?=
 =?us-ascii?Q?G0+KV4LEo+1nQ1zoAfYFCqbulqkY40rU6O9LRts1MnM2ozatRi5NlI5HQobO?=
 =?us-ascii?Q?cazY/qyPYmfGxxiv3Ml31gR+WWtpigNInVr/rLOL6awxWjASjD29uLpAFM2E?=
 =?us-ascii?Q?m7k8qCaCJBJfPDVtJ5SrLem8TLcm5vImjT0jQAtF6OM5fm/d7sGn4YMuiD6w?=
 =?us-ascii?Q?UvapGess7WB+RSwA3itcHRZUAmX7hoKBy5ExhX7ckkjQMYulc+vMEfXlHzvo?=
 =?us-ascii?Q?IzAbRVRSc438Ew5kTCR+q6cCwFhthL7rmy7C6plKNKrSdn03O5dn9U8uPT65?=
 =?us-ascii?Q?2F+/2t//V07j3PkLYjS/e5Xrbvkq1tEjIKLLESdgYDmLRNqKhcLjWvAZHm8n?=
 =?us-ascii?Q?VvTJPtHfw3weCBPGUX2NeAuUglahWS2YkIdyxW3WqYxngMW4h1RfUqXAaUOc?=
 =?us-ascii?Q?gHTOiXs9B/EeyjA1RBxoP0B8tGLv8YhbeOM/h7o4z42zjHVyc7ZMzFTPA7Vs?=
 =?us-ascii?Q?2t7KclyL6i/J78rQZDX0XFNI72/8oRpqfrHvkwSwCfp3g96hL6HIqx4Qq25/?=
 =?us-ascii?Q?kdX1wq8s7hD7IwP6KPjtxG+42JqSNcQWzAc9oQVqLIp66uCy31LGh/o1giee?=
 =?us-ascii?Q?z0G/wsOszQtoMdEn27M/GqjOtTO2TL4+das04qK8S/2/z+EIK8vJglviDM+M?=
 =?us-ascii?Q?/h685nnkKLOYiZPNNX1IW90q6DLgHgrXVR7RcWeouhyOgEqLCXNfQGV2+ljF?=
 =?us-ascii?Q?q2NRqsfZ+Czy5zjHJXrl8L6a6qqLZBmK9lj0wUZkg/yqoxloV2JMpR+MVb4r?=
 =?us-ascii?Q?uVnMiyzM8fNv0IiBOn0iMU58g2qtUFqB1iGU+/Q+3xAOH9HTT4PWGuXi/XSn?=
 =?us-ascii?Q?9HXLUcTw1b8fA/A7V6qhavn442olYsfyDYsIoLrMjp/Llizgzjl7iAsJ3aRU?=
 =?us-ascii?Q?cF4V/zfdyKwgZ4gZOC7ZZAGyOg/Q8hgJkHYiXjd1WqFAYqikMpF2T62+lgiJ?=
 =?us-ascii?Q?7fahc4Q+7AYvZQXqIdGFawFJHxYJP5lPzy2/Q1x3+iTjGab77grgCLJdu8kw?=
 =?us-ascii?Q?HHcc5fGrnC5ma1qsVz1skuK/XPV0OFHINBV1O2u8WM725M6fuJi7zmzK5qvZ?=
 =?us-ascii?Q?w4S1O15sCoUtZ9v4LUgx1oJUlfxFQnPwztaKTYgu4Jkza2rIvcxIOathum9/?=
 =?us-ascii?Q?TS9KZuaRrd4ljLL7gqQb3d06889LxlnMevn9j0+CWI4k23eLey3fg5aIOpbG?=
 =?us-ascii?Q?gDmG0khkqEcvrZzO/KctEOPot5ImHeluInV3FKlln7uQEBNZp8s4+YdsbSck?=
 =?us-ascii?Q?eYrqecP6bTMNgg3nvaGzCo1N3d+ZCrZ+0Rq/GTQlKYLib7rwjSxwtJvJEkDU?=
 =?us-ascii?Q?riHOiIgLzg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61359602-5b2f-4bf0-80ac-08de869855f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 15:49:56.8183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U2KN3HZDD1sU5hXJrnWJePqyRFigzQkY9D8kuTv9YPHv9lTuUtPjDcpyDnnDC8eH2h8HugWLyYq1Q3IEPcV5og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354
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

Hi,

Please, note - the pacing table is global shared HW resource.
It can be used by multiple entities - by firmware, by kernel, by multiple D=
PDK application instances.
So, the returned value of the "how many entries are currently in use" can b=
e wrong.

And, did you try to set the same limits on several queues ? Does FW check f=
or the parameters and
provide pacing table entry sharing ? If we have two (or more) queues, with =
the same limits, do they
use the same pp_id ?=20
With best regards,
Slava

> -----Original Message-----
> From: Vincent Jardin <vjardin@free.fr>
> Sent: Friday, March 13, 2026 12:01 AM
> To: dev@dpdk.org
> Cc: Raslan Darawsheh <rasland@nvidia.com>; NBU-Contact-Thomas Monjalon
> (EXTERNAL) <thomas@monjalon.net>; andrew.rybchenko@oktetlabs.ru;
> Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>; stephen@networkplumber.org; Vincent Jardin
> <vjardin@free.fr>
> Subject: [PATCH v3 09/9] net/mlx5: add rate table capacity query API
>=20
> Add rte_pmd_mlx5_pp_rate_table_query() to report the HW packet pacing
> rate table size and how many entries are currently in use.
>=20
> The total comes from the HCA QoS capability packet_pacing_rate_table_size=
.
> The used count is derived by collecting unique non-zero PP indices across=
 all TX
> queues.
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  drivers/net/mlx5/mlx5_tx.c      | 64 +++++++++++++++++++++++++++++++++
>  drivers/net/mlx5/rte_pmd_mlx5.h | 32 +++++++++++++++++
>  2 files changed, 96 insertions(+)
>=20
> diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c inde=
x
> fa57d3ef98..968aceb24f 100644
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
> +		info->used =3D 0;
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
> +		pp_id =3D txq_ctrl->rl.pp_id;
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
> +	info->used =3D used;
> +	return 0;
> +}
> diff --git a/drivers/net/mlx5/rte_pmd_mlx5.h
> b/drivers/net/mlx5/rte_pmd_mlx5.h index 698d7d2032..f7970dd7fb 100644
> --- a/drivers/net/mlx5/rte_pmd_mlx5.h
> +++ b/drivers/net/mlx5/rte_pmd_mlx5.h
> @@ -450,6 +450,38 @@ int
>  rte_pmd_mlx5_txq_rate_limit_query(uint16_t port_id, uint16_t queue_id,
>  				  struct rte_pmd_mlx5_txq_rate_limit_info
> *info);
>=20
> +/**
> + * Packet pacing rate table capacity information.
> + */
> +struct rte_pmd_mlx5_pp_rate_table_info {
> +	uint16_t total;		/**< Total HW rate table entries. */
> +	uint16_t used;		/**< Currently allocated entries. */
> +};
> +
> +/**
> + * Query packet pacing rate table capacity.
> + *
> + * The ``used`` count reflects only the queried port's TX queues.
> + * Other ports sharing the same physical device may also consume
> + * rate table entries that are not included in this count.
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

