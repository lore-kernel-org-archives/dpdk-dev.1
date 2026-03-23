Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A45F46100
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 13:20:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C269C4066B;
	Mon, 23 Mar 2026 14:20:16 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013008.outbound.protection.outlook.com
 [40.93.201.8]) by mails.dpdk.org (Postfix) with ESMTP id 34DA740268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 14:20:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oq2XtpF4ZVbPCFwLUmXbMz2J/NZa6dlhQ8prPf6Dz8MPH8fgl3uc2FSWQBTxfsSu4rtofYcgnBJpGzYGPW3eOMWJ6fCnK4oeb6YonFga7nPV8UNnMJBz6R+0sTzOrNGtF7SpvP3JzGDL3UAXkpfxdr3JNw5Lmo2Sjt/vYA+fzcdlX++D02iQhG5NtQLojuW2eSXeHvUOjTKJqv4h/T2sx4CvgkQUu48fiP3KI6pnhleCDsae1ICrOEyFLcJ+JkQRN4sepm17UjXnfWRVtB4Hs3MF46nbP1Uwe/fSR3nLwy12+thzDkUJk8sVR32/p1m9/PUVng1tusfyRgCn1N/IhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8Ib6gn0DpqzV3IHTcLvCpy4f089fMxSwkpqYdiCgOY=;
 b=PWAVayEjmC8AJUkjNuLwuYnZ+XOjONpJZOGLTQn91Fz1gXrQedOHE8FVAvzVhWSWnZXC+1WIN+DAbrwDtB1Ft9SW2YgQtA8yNQo71XpJ6Uq1qW3JaUS6a1DF3zD48h8Pj1CXcA9LE+l3+lu0Xq7x8d8gBQ8d/7/dKpsR0Z4RAHYt/D+F5iNYuph3MjCS1m0l+Gy9dcS/vFz6QzbzN+fsysUJb3SHkoLo9rN8SUH/Aq/NoUnq1Dz20CnU9S+jT1237XdkgOph64/gvWhHEMCtSakWadLgTkRSKhoeQlvf8QIXwcNWWtoAgNSHWXgn0CXUM2BbxtekNpbRWuy737VlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8Ib6gn0DpqzV3IHTcLvCpy4f089fMxSwkpqYdiCgOY=;
 b=bvOHXYLXB4uiTo3Zhj1s5Jr15LArl2YzMP/DkuwEUacbvhO746hwA6bzAx0HgrMbG3hLkC81TPapzj/7klxzCueo37U3mItyN8Ik1nBDGF6sIC0/ktgotZfZbTsqZvwGxVNETLrMFB9B00hXsp+3R+XZDXel6H2w9gyvwHjAazAf325wd9bF7G8ONV+K3wKXQaBQvqPyuXh9pe4l4Z4HV7rENO1h4CIkN6J/UFNMkFtMKhU7BEyLK2/isWqD0NSvSf+gxq/LHjyqybkDN54xGcdQuldmV14l0IlTt3V9PydTbejLmlh2ZiVoR9SnMK+5dyMW/RSt+rWuM3NdRPBVXg==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 13:20:12 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%4]) with mapi id 15.20.9745.015; Mon, 23 Mar 2026
 13:20:12 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Vincent Jardin <vjardin@free.fr>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "aman.deep.singh@intel.com" <aman.deep.singh@intel.com>
Subject: RE: [PATCH v4 09/10] net/mlx5: implement per-queue Tx rate limit
 getter
Thread-Topic: [PATCH v4 09/10] net/mlx5: implement per-queue Tx rate limit
 getter
Thread-Index: AQHcugKvj3secjUiVEmOEWXgfkPcyLW8G4XQ
Date: Mon, 23 Mar 2026 13:20:11 +0000
Message-ID: <DM4PR12MB6087F8FDE2E50CCEAB6727E6DF4BA@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260312220120.3256755-1-vjardin@free.fr>
 <20260322134629.94633-1-vjardin@free.fr>
 <20260322134629.94633-10-vjardin@free.fr>
In-Reply-To: <20260322134629.94633-10-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|PH7PR12MB7257:EE_
x-ms-office365-filtering-correlation-id: ec0a982c-fc95-4673-49c9-08de88dee9b5
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003|15866825006|41080700001;
x-microsoft-antispam-message-info: T8sAGPVx0D7YiS2+PxVSZbBCwwe795unMWgLkZrOX/2d5q7ziJya7Z4ss8aJZmmPzKNYbs1DpvnwoKpYSftNLvuhU/aDvScJRtSULr4g5Pgf9YeHZcAPpnMjmGcAl5KflXkhJOKZJ8QX3yL85ldsneXC8hzbUawwyRnbDoUSt4U3Co74oh18P1LftwdjdtCfUpEuErYR97ZWALV6Lka91HhYNf+3IEA2oClTsX4uy0sZd7grLzTVNvvVsD1JCW5csx1e5FemF8uc64n3Qwg4+LY1CZ3ZnoklniZUdmnAp35msbELqdMaZwP2ljYUpNlCfXx9lzMvNBL8AY6L5+9c5CuC8aNe958GQ6aMRx8jwU+oN/AK+bDQjS7l5yYPRqLPawFXdX7le+NJeDvVKQj340PVlowDJOuX3Mjq8Yv8rU9NwyXkUiXeaLwEUV/hwqw26E/91R+n7+WozE6LOoUEqJJJvaXJp0voPOGVGCuwN9hgxMshiERvxYYEnIVEZZCNCeE3/WGZT14foBt4y3Ze6vG8Anfv4WVauB2jwXdz6eudrmLDmIAudrI3s9WY1gj5y6Z7tYOQ4CnPD04vaI0j9KLVv1524gMvyQyvFhBXGPUNpBao8AqqmYgisg4/u5pdceicIiEpyRPw+G3M0hVya6vaxXmFkMWNiyyTcgIu6uEmzYo6KAWBx3IcOHlzHuBVccGaZI47ONFvA+zdkofulsxDc/OhlaWr7tIb/krbcRXLx2mvVElenM9ppccjthskAfJeVjzBcgpGAV+YqfeRmvFBNczGHIe5/kqGq9ZeZAAeIS0onIF80WB24aGnGmd2/8vXcr41aTJpxnLzkbJ+y6pEfA1TB8OY60VOJi0ppWo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mhnnlPVYC75XUGzJxjxrbNlE/oxfMbPIZRTyhG+mzVRBl8rfwFvTAZwAiMbB?=
 =?us-ascii?Q?JoDevW8F2mDRZVH61/cBauebcGIesQU9KN16dENvlK8xUqDe8/WcIWW0v9Ni?=
 =?us-ascii?Q?vz9YQ9e5W3TfjpYKhOmZHoefkL7hgIhwkXoOQkFAXjgq1ughMDlf4binyiVz?=
 =?us-ascii?Q?gRj+4TO49UyZ0TQqXmsd/LwiOEnxQzJO5bRFbnPodWABXAnQCygmDGayPK2B?=
 =?us-ascii?Q?LB/OnRVFChnwWBzoyWuDF5MfRYM6z/J0ckkum0TjbmYYngYVpCJEnNN4RAtU?=
 =?us-ascii?Q?ep5ZAnFO1yhzzHPhZ1CPufHLRRU6ITBofuRqx3DrdFO5Vq/6bYzAoEnlJJkG?=
 =?us-ascii?Q?n9iqQ6/gu0tRQaAbatEtWBIT4xNY/jiTSmZaTMnG6oAUUMWfcd55BN7JKllY?=
 =?us-ascii?Q?ws17l3UYXJ2VSpgWQAZhosG+PADeYZgVqCELD28K4BXxlIrDhYAVs8hXQOJ0?=
 =?us-ascii?Q?3JnVOhfm/mBz5JaJUsXlcZYpKwzOqBAECmVD2dbcHtXXxb18QZBnSdzlvrgL?=
 =?us-ascii?Q?dNkQwuz1Ek4nt8a7Ra9TY8YOTk9ONCRn8AWanDSkkfhuzU5vqmiUqj8OCalV?=
 =?us-ascii?Q?ySWO8IOnh2ZW1C4pgD9Mfms6i/ceWakvTJm1qd40MzbNOdp9PPyIH3JEoJ1a?=
 =?us-ascii?Q?VKDzZspweSYyw1IDZGjOhRiCvpPtNUmsFWUpVwLKkpOL9AONtzTngSbm4EIU?=
 =?us-ascii?Q?sj7mLgMC0nm0CJGzOLihkmKhqTL82BIh7FCBp+Sd4GbgagJ2I+LLlC6XGAej?=
 =?us-ascii?Q?57VyU9D64++BPkUrMXJR9ymOForiy3H5uDRIFqZC53Ieb6YUJA0a9iyXXz0W?=
 =?us-ascii?Q?PLDPABb5oBwy6aGUUPeFaWbD9YzF70oANyN37qlllrsx16me+R8jlsh7i81E?=
 =?us-ascii?Q?JOqsciGcGwo69LMlZiM44Hq5gsux7nOvMx1qBT+U2+Y3ud6e57p8Ezba0HXP?=
 =?us-ascii?Q?HRnjbJEe+1oAMHgN/SVwkuAFCFDvVBt4BmqIcd7Qhb51zVcKi8Z4Hh+nXqWC?=
 =?us-ascii?Q?782ZG0EKiHfBRa9ucMb/Pnc7YzHELhKgrSJ0aIpt4VBKK2a6N0uADvRhHQoK?=
 =?us-ascii?Q?jGLMGtSorf9uJgWZxNrGbQzL00rq2dej9N7rjhYLOG7+W6hWX1uOSKzEP0y3?=
 =?us-ascii?Q?EtiGOpY30xoIJTfXlOVjYbGWn2j+5O2WkcHf2rLa/tnZARLsuIB1VxhFJrVT?=
 =?us-ascii?Q?+TNwWgba/frVX+qiY2WEUTg5ZnQkR26erNREz+EH+o8LY/oUTQ/BaeG7D+vz?=
 =?us-ascii?Q?hgTaS09zyblKsTynaZJY+CtZ5Ck2NhCaxRvfPpCgEzBES1jsCLQjjTBhexwC?=
 =?us-ascii?Q?Z+KOHoPBufKoe2xYRBN8S+sVnggoZDtS5g3pAMSktCZU/+AmgjcjmvgIyEPh?=
 =?us-ascii?Q?o6wO5CTkRr2ZgRS9FdwTmcis8h4UIScRUUXyd8+TSLhKPHR9jAJjgaJFAeyS?=
 =?us-ascii?Q?x0E5g6zozOOwgYq0ud0OKN/3tA9q1DtZtS7J+65kXuY4X3cWAFnhg35eP5Zv?=
 =?us-ascii?Q?izROFK5JXGGjtjOTZQOkpk59Sns0KX1PQe4CTsISJKNf2BdF3OCpxdOk2aDd?=
 =?us-ascii?Q?uy/AmX2Hpz74dU1scpV3SN/4qUKH0cZUOXzIsOisBH1lwSqR6VDrBeQVCwCH?=
 =?us-ascii?Q?9Idxmd/tBNyzxwHTKymYbyuTKsDFnyU13sAL9YC5SqipekhH9K3gCUnQS8/z?=
 =?us-ascii?Q?rGUfJ43ktm1VT4RKmjNOoECddVfiYcVWrDT4s3Ju3WyiYTB+gJaxEG04MBbl?=
 =?us-ascii?Q?xW3Pq/X3Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0a982c-fc95-4673-49c9-08de88dee9b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 13:20:11.7089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yPZYrh8EBdMZAuNQz8A1155U18CU1vvDdpJV2HrMgiUHlcda6dZ3Xu5u/XHD6F9nm2Pxza78NP61obSjgEZCAQ==
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
> Subject: [PATCH v4 09/10] net/mlx5: implement per-queue Tx rate limit get=
ter
>=20
> Wire the mlx5 PMD to the new rte_eth_get_queue_rate_limit() ethdev callba=
ck.
> The implementation reads the per-queue rate_mbps tracking field from the
> txq_ctrl structure.
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  drivers/net/mlx5/mlx5.c     |  2 ++
>  drivers/net/mlx5/mlx5_tx.h  |  2 ++
>  drivers/net/mlx5/mlx5_txq.c | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 34 insertions(+)
>=20
> diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c index
> 7d08d7886b..f5784761f9 100644
> --- a/drivers/net/mlx5/mlx5.c
> +++ b/drivers/net/mlx5/mlx5.c
> @@ -2652,6 +2652,7 @@ const struct eth_dev_ops mlx5_dev_ops =3D {
>  	.rx_metadata_negotiate =3D mlx5_flow_rx_metadata_negotiate,
>  	.get_restore_flags =3D mlx5_get_restore_flags,
>  	.set_queue_rate_limit =3D mlx5_set_queue_rate_limit,
> +	.get_queue_rate_limit =3D mlx5_get_queue_rate_limit,
>  };
>=20
>  /* Available operations from secondary process. */ @@ -2746,6 +2747,7 @@
> const struct eth_dev_ops mlx5_dev_ops_isolate =3D {
>  	.map_aggr_tx_affinity =3D mlx5_map_aggr_tx_affinity,
>  	.get_restore_flags =3D mlx5_get_restore_flags,
>  	.set_queue_rate_limit =3D mlx5_set_queue_rate_limit,
> +	.get_queue_rate_limit =3D mlx5_get_queue_rate_limit,
>  };
>=20
>  /**
> diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h inde=
x
> 975ff57acd..02feb9e6fd 100644
> --- a/drivers/net/mlx5/mlx5_tx.h
> +++ b/drivers/net/mlx5/mlx5_tx.h
> @@ -224,6 +224,8 @@ int mlx5_txq_releasable(struct rte_eth_dev *dev,
> uint16_t idx);  int mlx5_txq_verify(struct rte_eth_dev *dev);  int
> mlx5_set_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
>  			      uint32_t tx_rate);
> +int mlx5_get_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_id=
x,
> +			      uint32_t *tx_rate);
>  int mlx5_txq_get_sqn(struct mlx5_txq_ctrl *txq);  void
> mlx5_txq_alloc_elts(struct mlx5_txq_ctrl *txq_ctrl);  void
> mlx5_txq_free_elts(struct mlx5_txq_ctrl *txq_ctrl); diff --git
> a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c index
> ce08363ca9..867ea4b994 100644
> --- a/drivers/net/mlx5/mlx5_txq.c
> +++ b/drivers/net/mlx5/mlx5_txq.c
> @@ -1481,6 +1481,36 @@ mlx5_set_queue_rate_limit(struct rte_eth_dev
> *dev, uint16_t queue_idx,
>  	return 0;
>  }
>=20
> +/**
> + * Get per-queue packet pacing rate limit.
> + *
> + * @param dev
> + *   Pointer to Ethernet device.
> + * @param queue_idx
> + *   TX queue index.
> + * @param[out] tx_rate
> + *   Pointer to store the TX rate in Mbps, 0 if rate limiting is disable=
d.
> + *
> + * @return
> + *   0 on success, a negative errno value otherwise and rte_errno is set=
.
> + */
> +int
> +mlx5_get_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
> +			  uint32_t *tx_rate)
> +{
> +	struct mlx5_priv *priv =3D dev->data->dev_private;
> +	struct mlx5_txq_ctrl *txq_ctrl;
> +
> +	if (priv->txqs =3D=3D NULL || (*priv->txqs)[queue_idx] =3D=3D NULL) {
> +		rte_errno =3D EINVAL;
> +		return -rte_errno;
> +	}
> +	txq_ctrl =3D container_of((*priv->txqs)[queue_idx],
> +				struct mlx5_txq_ctrl, txq);
> +	*tx_rate =3D txq_ctrl->rate_limit.rate_mbps;
> +	return 0;
> +}
> +
>  /**
>   * Verify if the queue can be released.
>   *
> --
> 2.43.0

