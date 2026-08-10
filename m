Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDF0C5AC82
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 07:14:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F05540DD8;
	Mon, 10 Aug 2026 09:14:36 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010021.outbound.protection.outlook.com
 [52.101.193.21])
 by mails.dpdk.org (Postfix) with ESMTP id D3EE740DD6;
 Mon, 10 Aug 2026 09:14:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHVIclezxXMk1TyzptbO+0tIhpFkYNBEIduLf/Atddaj33dMtpozAPAUdGzp4BBjKWIDct7qeCKnG8ihxhmcw6mgihW2Z5tco08CDwgftSjRZ5zUuGre9u6BKty26eZYK6rjY3SjHzhJdatp6+5F4iGeb7Weob6c9VBS/peO8sEFuCZRq+8SIga2GE+6TWBPVoj7N68Q1Cm7DP1S9jN2okTgmivFEnwGAFycQUkKCBGbNPtp2t4OLlF1sKxtgbolgImZm5BV+yNmuC3PTEEvTbefAjIuAe2WrLy3dilcKMC+ql6PZwkTVz7HtPGgPXdCaz262A7wEPMwiJ51qZG9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsFW9YpaVNTXX+lcr/dZVJVdOV5Jmb51mgJtkFA7Yms=;
 b=wgGzWCaW9I2Aux1SjIf2Sxy+mFHYPwPczG6wWO2tawKHoiAn/HYLxud+xyWPX/64vop34sP9N2X/ZP8CRjwFbFPXagMzcZ+Af7mNIMnBEBH8IA1ey+ko6lXJUVx4e2i7LA6fAjYWw1pIfv3revkTz1YMXt232VRskXoloaEWaoQZlbZ8AeNTAWnS7slPi44B7TSOoUC787uRaC+95QsnOWXuf1XnEa1fw7YOKS17mPUW7sckOnKUm9TM656aXsa5o2BKTIbJoxvSOOlWP0oHnwbEM69Y+nEU2I5EaRgPxYyjhzx/FOYN5mOCqnsLbPVuOL5QLQlLuKmURaJBsJpvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsFW9YpaVNTXX+lcr/dZVJVdOV5Jmb51mgJtkFA7Yms=;
 b=iYsF/RHhNFpOBDYx9bVymBeXyblj4IZrSNxzRhvTLBcXJjjAqhzkUBF+dVXWdCqOlQBadzhW6bXZEuFyq7PlGmTDWoWUwlOguHR157/JGF8xZS97k3yqKxNuJrWsLembqeKApNbvVjFvIGpceGNc9PjNi2ZKCFWpAVmiNyk2xMImODFF1rMzKJ/NzcdHRqGvD0eeQ5H7/aKSyMYfIFRLiFo/EqaT2GTUJeGbzSP30woGnbmIZWpdCUr9r8r6maAgWlHzq/T0xGKcrpoMXSsDMIhft81pPllye3qzP9HVGT4k+LDptyWjV/On0z4VdSz3PQkyRqFWrF+ec18bvpJpuA==
Received: from BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 by DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 07:14:31 +0000
Received: from BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb]) by BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 07:14:31 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, "NBU-Contact-Thomas
 Monjalon (EXTERNAL)" <thomas@monjalon.net>, Gregory Etelson
 <getelson@nvidia.com>
Subject: RE: [PATCH v2] net/mlx5: fix uint16 underflow on Rx queue error path
Thread-Topic: [PATCH v2] net/mlx5: fix uint16 underflow on Rx queue error path
Thread-Index: AQHdJ+RQhg6jl4U8G0WymFAD4tbi0raW39zw
Date: Mon, 10 Aug 2026 07:14:31 +0000
Message-ID: <BN9PR12MB5338F27D27A818B7C8D2623AD0DE2@BN9PR12MB5338.namprd12.prod.outlook.com>
References: <20260730135620.213682-1-mkashani@nvidia.com>
 <20260809094837.123931-1-mkashani@nvidia.com>
In-Reply-To: <20260809094837.123931-1-mkashani@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5338:EE_|DS2PR12MB9752:EE_
x-ms-office365-filtering-correlation-id: 63309a4a-d962-454c-d468-08def6af05d8
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|6133799003|11063799006|4143699003|56012099006|10067099003|38070700021;
x-microsoft-antispam-message-info: arhb3ak8o0XTKlbfHwkKjHpKyHXQ0cwypRvgft6qbtguL5cryIIi6RKsCMBLrvMPP2jTdU+ipwBGAL1hR//jffcoTQl2PBHAHA2XyVHlor9suC9qKrkIS5oResBExiSWX9uT+OkM+JkFVdFuHlV2R4Z/suR4yKzqwQ0wZO+eksVPdrzlN5cxvqTB5EbaEsJqr6GZy3cjWX+vSl1sAZE9ykIikNSLT7MKt9PYdJIgsOCHez0+Io8LUmdG80e0+x3RjQH0GDRXX8cVQUqzPalsXlj8zv0UmkqUb4PP4rioVcTPZ9jc6Qml1IuKHe6ZPu+W1Ef0pjPr60qAf/XAp04OCQXYwWZDeoRuma0t4MLOHLt8fJwA+ht7A+dEqlJ5dEFYnXTPLXaSYbD9tyX09qMyBLWpqP1eVIGwpJxyUXZV1cbeY0f4Cq/JNgleLIb2AkIivXTGL09HHr9VdiX/NZJiDGPceSRoi32MGJdw7RaSGgshIbjD5bioZV4H9XdsG5IL9sK2S0DZcvyoXUOnGBM/m17xFsmuGiRIe107TMsDICaBW0spQidh/218K4UUJRXS+RZCw3mA5p3sdhKbzclerKSmLcGDr//jegSZR2i7GuTU97kC/qc6kBphJjM+jPwBC2jH9qTUUlBFvIbbQee3bCoCt+LYB3T4vOnrlBgllQAKbT9b6shivM/uHvTVFrP7m3ogOVTZIIuSWZX81dyZAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5338.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rRd5Nh0ksxykjsQhf0IRSRbWg+HREkma89Bk5oaTqb+ZC+WCde4I1x8k2bwn?=
 =?us-ascii?Q?UloadIiLnkLgKPIXHOiYM20A54VNmzhgwbRwBBGAyIvVL/A+3ajaTtYvdsp8?=
 =?us-ascii?Q?pHJd9X5HTlEBKLHnhbxZjzsbVbXRRcsak5EkjQfF+X4wrw8iAn9ILN1LmbJW?=
 =?us-ascii?Q?B5kAG7VEKoG/4x5EjZUzTNUet4ROTTpc66pYmJ/2UGfbBY8N1rncZSJ5XHp7?=
 =?us-ascii?Q?vN/YxZZ8fkuhj7AlZWOh+jAj8k+cwZ0g/mU22HYiYgJdO38xjOZFDeZU0K8t?=
 =?us-ascii?Q?F+cKCA4i21qFSiM9HpGm7Jd4Yt+YToL9A88cRE0dDkNFdZT7Duto4X3n1V4N?=
 =?us-ascii?Q?C4oWzD4cF+cyTuuAidKqMbFjV38K05VIiT/huoUvkTUTTQ1e+cTRdnXwkDyy?=
 =?us-ascii?Q?GoBznN8z6MazhTPgtPbOq2EWT5O6dKt4jOQTrkFocq6hTwvUTqYVOakhRAPt?=
 =?us-ascii?Q?puiIocB9cCqFg/JHsOboNnyijln5s0WG/t2wZbMlVV8tiHJoXCwa35Cj/npn?=
 =?us-ascii?Q?PtFvB84L/lOSxp4JmU9qiRTlMjs/n0w8IqgIBhi4uUTqUAWGnOI3d7gKBl4t?=
 =?us-ascii?Q?qji0Tmll1jSmcLDojP9UHjx6/VhcKDbF19i5xbVEHfIQkiqQWNe4ZPj3CRSo?=
 =?us-ascii?Q?mudV1+MJf2nZ14WiSszpg2bqIvC5UiEm+gxncgbk0YfHSTmynYAMydYS9AbZ?=
 =?us-ascii?Q?L6XiKCd0x9rnoi23S/6RXv55DiCYbDGi797rh+OXIQzpGuB3Qfg3MEDAblDy?=
 =?us-ascii?Q?28NY+Ge+crslmgbCdyELyugKE7UnAwLVRP/95YCIm4HaUFbsmHcn3SIF0cmb?=
 =?us-ascii?Q?9LnFRaMqIHCTDV/MHdD4jMAnX7UiWF1KjGg/r3c9q1l5A/OEd3jdzweQgbg9?=
 =?us-ascii?Q?+S5q4XdKCv0xg/k0GBjisbsFwjoEIfy358sMi0Pkju5i/tCoTov7yj+McDxP?=
 =?us-ascii?Q?5Tmdk2RvQXT73qlk6uLxvQl/g+BY3aNOFJg6b1vHL0VVFAufcR3G7Kta2/lJ?=
 =?us-ascii?Q?RyAjF7h77FSYJjgQIUu4Q70kp+2hc6ZZWIOfYMp6PNJk8O5422uzCzusto/u?=
 =?us-ascii?Q?uqfsNAWNEhVGYQf750sTUXO1X2XWpp48Wpbx+Z8VWx1kWyFg5GFQRQXSohUe?=
 =?us-ascii?Q?f9+NNWAl7P2n5mNMGAaCLfBFQVtqtIEwRmm+95xUrpuHOrqHQDAgQ0biPET8?=
 =?us-ascii?Q?fV/TisCov54u6mXwOQTOWUt9QsLfKB60T0C+8YNkamVIxvuVQTfFPkDw9DF4?=
 =?us-ascii?Q?f9Ox9C4vUIYlbZJtB8GhnIWhN+7ORKi9/bWizrO6bZtL0PXvuywKg0P3So+h?=
 =?us-ascii?Q?3tFb680c9r2NC3G3V/QsJ9v5wS9RUdq9cgtOSNDG7WbZdBodzdNyGeblbzhi?=
 =?us-ascii?Q?YbbfnioNeNmpJ9cIgmtMs0q2LfYWQkLXZQu3wjlwYf35pXCMrKwb4VjJ28RZ?=
 =?us-ascii?Q?rKpyDBRlVr2iwYDf6ugxahryCz5HIaKHWOpM4LAV0MlQib2E0OyT1iljWp2s?=
 =?us-ascii?Q?IK11xhBj0W8DcEKcqg+2JXG8c4wy8+v7LwpxE3gR9Xa9kynCuNCKRrouU+GC?=
 =?us-ascii?Q?Qm0MO/qTtJE0GNXFrLd9fv3PBD2XrEHBQAyRFTEwS6UJpbjYOBGtmQTkO3EY?=
 =?us-ascii?Q?pgOXfqD5xJ7G8MAYiB8hr9BRvPQepb1HlvF5daR8xCS9i0vjveC7GiMuM55X?=
 =?us-ascii?Q?i3IYqdMTWiWmxEwxVvwK8ESRiHdQVYih63RVt1ZVtM2gfU/3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5338.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63309a4a-d962-454c-d468-08def6af05d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 07:14:31.0624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhpPUtV1NVKvvVPoR2ZpemCLsHCWU0Fy4CZkqvQipupPw9bIPczU+yrj7NDNTbvPompH+XmnsKx+RNYWZqt66w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752
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

> -----Original Message-----
> From: Maayan Kashani <mkashani@nvidia.com>
> Sent: Sunday, August 9, 2026 5:49 PM
> To: dev@dpdk.org
> Cc: Maayan Kashani <mkashani@nvidia.com>; Raslan Darawsheh
> <rasland@nvidia.com>; stable@dpdk.org; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Slava Ovsiienko <viacheslavo@nvidia.com>; Bing
> Zhao <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>; NBU-Contact-Thoma=
s
> Monjalon (EXTERNAL) <thomas@monjalon.net>; Gregory Etelson
> <getelson@nvidia.com>
> Subject: [PATCH v2] net/mlx5: fix uint16 underflow on Rx queue error path
>=20
> Avoid post-decrementing the segment index when it is zero in the error
> cleanup path of mlx5_rxq_mempool_register().
>=20
> Coverity issue: 503770
> Fixes: 8d1cb02da5b7 ("net/mlx5: support selective Rx")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> ---
>  drivers/net/mlx5/mlx5_trigger.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/mlx5/mlx5_trigger.c
> b/drivers/net/mlx5/mlx5_trigger.c index 25847c8ba2e..25bb448a708 100644
> --- a/drivers/net/mlx5/mlx5_trigger.c
> +++ b/drivers/net/mlx5/mlx5_trigger.c
> @@ -187,10 +187,13 @@ mlx5_rxq_mempool_register(struct mlx5_rxq_ctrl
> *rxq_ctrl)
>  	return 0;
>=20
>  error:
> -	while (s-- > 0) {
> +	while (s > 0) {
> +		s--;
>  		seg =3D &rxq_ctrl->rxq.rxseg[s];
> -		mlx5_free(seg->null_mbuf);
> -		seg->null_mbuf =3D NULL;
> +		if (seg->mp =3D=3D NULL) {
> +			mlx5_free(seg->null_mbuf);
> +			seg->null_mbuf =3D NULL;
> +		}
>  	}
>  	return ret;
>  }
> --
> 2.21.0

Acked-by: Bing Zhao <bingz@nvidia.com>

