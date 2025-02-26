Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F76C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 10:37:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64F854029A;
	Wed, 26 Feb 2025 11:37:35 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by mails.dpdk.org (Postfix) with ESMTP id AA5764027C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 11:37:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYgA6ews1mgTTASSkH1bl8qhcOW/JdWHdk/L/EyX21LWsveTTE++dmZpnBtW+eJ0qW3P7K5NoHilnk8MoBF/neRLpfcB8RCFMudISWtbivQ32zr+wDK3r6ESP0sosLuvqULsNmTk+LEHVgZ+47QH4LiSv85ddbUVhnTge8AJpDTs3pFf5rH1INw03/yWpOgW4gH6kh17pdAGLQ+djiTTtCBN4IVvVONJGAXWaC4jDnum+Mhw82CzOIecyTfTIFOVE9lj9pwbGPV8FQRYWXNQMzKRG6BIm7tMFbvLrW1wZ5JO/F7IHezo6c2T8Sw3Fnqg5F2DhL8cV1LIt3gG9ZbLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oyq4n9QuuFBnhsoeo7I1eBuV387sBjMEjjDVGP4Oao=;
 b=LCJCHJv3usLZ0L8ELuQZ6H0gXwOZlISMD8BegQ9wqPiD8zrsZJ492UCTJc+nWfe5DaiapJWRo/LC59ARRZIYXdqGx3RPxQvVpBABVLDrW7UQlHC1jrpJfENMJOyCG9ZTU72FreMS9fRDg+A/Ksnew2eYYHHchcOS1lRC0is0cuReMdVe5/V23TrBSwOdnI84wCrZvFyx/36Vx526zyDto0Kp+Lq06vEd49OXb495/7t0ZV1RhQ4u+jNzcu45FGFuTsEXOMsZNAoUYJaQeoUqiSwyZdB1yqNS3bJFDjy/pk1IpkVwYsMRxdndnwK80dSCDy3wBm/d6+Z24fUjLl+EHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oyq4n9QuuFBnhsoeo7I1eBuV387sBjMEjjDVGP4Oao=;
 b=M7SSjKkFTaybMMnHoQh/C6eoFJhnuySfyCY8kcsTJdffawRXVXTrvuB9J/zKb0IstmaDzRVu0na6OcJ0KtwIWYVhqN8dVMUPApDkY8wP06R2lTBaDJbxztWAerkw+JV5xX0WcG76dxP4pWP6mOm2Tq7FF9Y3LA+8ht00UFQToYhaWdJwRBhodZkK55QJnOWNe72aGyVeNdUdSLfRd+VRy4d4rlpkKnj82sUYkJN5m64BxtRbbqybGDFLoDnwa5dTEa4vAB5qf+sqWFvFOK7LBEanbFhEsqV5E5SF+GOgQPWXtb5uVGpVtjRR+qbcDTKoOb/3JAEy9sTwp2+A7mnA8A==
Received: from PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Wed, 26 Feb
 2025 10:37:31 +0000
Received: from PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662]) by PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 10:37:31 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Suanming Mou <suanmingm@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH 2/3] net/mlx5: add jump FDB Rx flag
Thread-Topic: [PATCH 2/3] net/mlx5: add jump FDB Rx flag
Thread-Index: AQHbhx6uHPJ9uRJNfke7QVeTHK2DALNZZHBg
Date: Wed, 26 Feb 2025 10:37:31 +0000
Message-ID: <PH7PR12MB6905C9CF4D53ABD23F42D8D9D0C22@PH7PR12MB6905.namprd12.prod.outlook.com>
References: <20250225004527.2066812-1-suanmingm@nvidia.com>
 <20250225004527.2066812-3-suanmingm@nvidia.com>
In-Reply-To: <20250225004527.2066812-3-suanmingm@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6905:EE_|DS7PR12MB8417:EE_
x-ms-office365-filtering-correlation-id: cfcb4259-5286-49e9-35da-08dd565192cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?g+IdrdKAQleaVzMpai/SLNWBtzN8ZWX//wJPbccxMxJViN/luRO5K7aWxSxo?=
 =?us-ascii?Q?3yVPDFx+4CRRDZt+YZaqkNXGNp6lKUTUZ7VRnhts10C+aCkPGsFwDKAXajq/?=
 =?us-ascii?Q?irmYcSes5o+GF13Cm+UfHfXCGSNaLMg0YQ4pbm3p+1GTPsEm6hKcDxENlysN?=
 =?us-ascii?Q?V/5mVovreeg0nN9Cabh9Rdc+cD8EBSSGyXMyMAjQqiGTsQPDlalJR7FsjbE+?=
 =?us-ascii?Q?+a3dVGN1EVyLByV9yOzYDNqUmQfabPhQTvdSmlPQJTdUA9mT/q1BDpp4yvY3?=
 =?us-ascii?Q?c7XQ1nP7ELn9g+s363zwEfNP2ouh20z+Rkdx8jmD4CeCV1F9yBxvMYioaK3q?=
 =?us-ascii?Q?whzEYTyBOdtELk0GaX8oWFxIVlJz/0LEsL6wwDQ7Xq6DMVFBwp3OKHgxxPh3?=
 =?us-ascii?Q?96lTt2P61FAezI09Ef7PUBApstQ+83mfqUC8HTftmqj7vVSEqodJPX1K4E+i?=
 =?us-ascii?Q?03KOTP95H7PW5JSwpH+QkrLaz0mLbAEu7unemhS6irkXwZRzC9L1JjggBaGK?=
 =?us-ascii?Q?2dUNTaLNn/DWI92tkg4SzHqsqo5cdBwpMWajUfnMdSF2ut+ZYMjepGP+Sv9M?=
 =?us-ascii?Q?/bT1EFkeqINlq7PQPk4OWK6Fy5r7z+hDWarMFFGtUS34ecj2nB7Po3D1WqVy?=
 =?us-ascii?Q?0x15Au63kV0KQ2VmxYyN04bSL1GNJRSHpJW2fqSZyxsPXFwbc3Cx39kmLb3h?=
 =?us-ascii?Q?eI3z7SmuyP97mX43Bpga46AEqjGm/hvZ8PZij1G5ZMOlsaHviecnhjnmJJqO?=
 =?us-ascii?Q?lx3aR/rXqBfVJazT0SkyJBR4+4sYDYmeenNY4u8EWLHvEqKEholro0X00uk2?=
 =?us-ascii?Q?nQepQ4Q3fHL2WmzOdkzB5Qoz92VFchB6XbWLubpp/gMgjuy5Dd94r9wygW+0?=
 =?us-ascii?Q?iqT+V0jPw8cn+1MWU4o3D+dPK03OPFe1O2jopS/7cq8mazRDWml7h+TbORLn?=
 =?us-ascii?Q?58oYcceW/Q5eSt2cGj485A2dZ8CFV5lfr6k+0nHfOXBFJMXrcV89mO+cviO4?=
 =?us-ascii?Q?HLPADkVEU7M2tFqMh4nSP+pM/9ZFjKSC0GOQGOoKF9A1HDo3xmjeLfnS1by6?=
 =?us-ascii?Q?z1s5TY9sqlwFcb0thpgaIqIFlnfgY/xL8kV58AgMOGNy5GfJrNosY8vo4Bge?=
 =?us-ascii?Q?fhWvD0f3aA3hyhgPoFYVSn33RMuHN/8rFAZ5L9EnTD8Z6A38NLm/XfLop+ZH?=
 =?us-ascii?Q?VKtJ0RAZwGAHaJ4byJUf9L0M79TuZ8MqonK6t9yF6sx4Tvvo8fguBbHHV70c?=
 =?us-ascii?Q?1WjPzK9FnbYJKm/UohXXzbiZBAg4I/LFJTmitipLuheKjB0Rf6qRftGsOvtG?=
 =?us-ascii?Q?4PDRdzFQ+Di6BZBLvpxoN5M0OSYmSpXK3qRaGv+iWMpVcJLKR1Kzfk0R9V3/?=
 =?us-ascii?Q?piLzxPlEXGkZiUVRfJdqva6bdp3Z7OiO/oiOSEfQhnL2tQi4I4MpLLCu6F4E?=
 =?us-ascii?Q?nTpG2S5TzZrAR8IR7DKPcc/adI+48UIl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6905.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BqamWJqXXZx/otdlh0ciJH7ZpkL9ER+QVSGFBZS71qa4O7Pd6+wLnV6FaJ/j?=
 =?us-ascii?Q?zzwez3FcAYbyXQSMMk1e3i/FFWMrpIqrXTO5HGWYBH5KH6Iz49IGHIlzTJ+F?=
 =?us-ascii?Q?AHuBIhAOvWBjjSzc0Q0OTAFBT1TewBT61Ia1vG3lOfJS1JKEoLITy1LGJ1BM?=
 =?us-ascii?Q?Jp03Np6/N3/KbNWXYnIorkM+Zfp6bKisvyXUkuvRPL8ZezmZ0niU5p3x8kSf?=
 =?us-ascii?Q?jhGY3lO7oiEBytpYkyvDhlX7LBVs7hwHBITpEAdOeT9CI6OfoliTSUgPDk8Z?=
 =?us-ascii?Q?ksKvTqnFBRRMICKk7p1e40yG9YvB4c7jCpqtkHdJxsZUv5Sa8ke48gNhd7rm?=
 =?us-ascii?Q?xHc7sPCwUIxfpDDBMcnapUXXfF2MZLbEBhSDKN7wU6TcvLECsRO2foWwG8gD?=
 =?us-ascii?Q?nl47XcivDREWOWoRRn4qBW/O/McFkJmvvYYVl3gfchjssLdueK56L+7xQOYK?=
 =?us-ascii?Q?uhzdUaVAS+bv2rP3Uu5c1WrXU/BQSe+XVY+3EQgHLTLOTo6/iU/niU+ISNrv?=
 =?us-ascii?Q?ldN3zLcrHUxLH9qOrPqcD3ueRo0rTKghgcbMUbzq30wUnPDbUjfTN1zIwP/5?=
 =?us-ascii?Q?tb5ZQB/CU2X+pWNm3Q7WuFNgltlyEFTTgRJPQXpd/GRO/ZNdCW82wKd0aA+i?=
 =?us-ascii?Q?++Ndm6Wb0fOLrjflgKecbn8+09xaloYCSQIOVA/gZ1KquUdiE7mg4wpdpgGQ?=
 =?us-ascii?Q?kq3Seag/T2gTr6huY++gUUPy/N+MsEovfzf4JGH0sl13b7LbeBpeRi8rS3o6?=
 =?us-ascii?Q?uvocVBf3mGysuSAuWicu6R4gmHb7xBKC8jXJS1lX5ZDad09nnRu4+4z6wIE/?=
 =?us-ascii?Q?dOaWAVSsYxn+vZ4hKYvs4WWym92lwQFIocvuGn0XtH3ZEcpywMr9FGuuIvBO?=
 =?us-ascii?Q?jdOwuBBCw0uEVAtrc9vDr/P4Hf1CxRHydoiodO4gGnKs4jWhrmzIKDH2z/n+?=
 =?us-ascii?Q?ssoUvmULs+006Xu4dnbY1gQQtBRSM4oVcXAOEQTcr+dRPzJcxgTfLwAgjdIA?=
 =?us-ascii?Q?SLD2dwuytnIk16s77jnECSxnemthrslBgH3BHb48T6waz7jyTFIWGWwdxta0?=
 =?us-ascii?Q?imszVBEDf9KfPeuqJrFjhknS6S2qkbDVYHoRec43HLXulyNUHmzxRy7cRMS2?=
 =?us-ascii?Q?k+BBq/hXjS7ysU4/IAqRYIetYXkYrTINICjuAjFFpaBKgjS2GwoK1urfrtWV?=
 =?us-ascii?Q?Yj8T6OehXjphlHtFn36xw0SlYrf2MjC0Wb6z+9hrpxK66sFYGJ+MD2jgji8y?=
 =?us-ascii?Q?nZ093tV63ezHx0PWdlo8i/fCVA7yi0GolYREVcf2Ic6tu8EV7fFWjHKTfVX+?=
 =?us-ascii?Q?9WVhxz+hXK/B1CVMtrgZSnqR6QLXxawIaLmIB9reKUMz9f6F3xjase//46i1?=
 =?us-ascii?Q?GYTlmh2l+oxjnOx2qLyybE4w0yK8PA4nocGHyZmCkhpaHxT/+5bE4Bxh9gdc?=
 =?us-ascii?Q?9hf2LurO7PSiXM17ZuvBE5l81LkMtSJdOgzY4Bh4aUubRUQ0PKiFmlZgw9ch?=
 =?us-ascii?Q?nb75vpdZt/wexMU+Qifte8D5gTiwer9GhjmUr6vsqgFgYuGhK9UOqEYADqoG?=
 =?us-ascii?Q?vC/EyTPPglP6eY5w0+c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6905.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcb4259-5286-49e9-35da-08dd565192cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 10:37:31.1840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O725uyR9q80d359XxsCh7yW2C5FCKNyaWLsaFrcigNj2hVK0K5patcctfeyA+gkhWIARgp+I6mvdsr/kQQPm+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417
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

Hi

> -----Original Message-----
> From: Suanming Mou <suanmingm@nvidia.com>
> Sent: Tuesday, February 25, 2025 8:45 AM
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH 2/3] net/mlx5: add jump FDB Rx flag
>=20
> When jump FDB Rx is supported, flow will be able to jump from FDB Tx to
> FDB Rx, in that case the dest action in FDB Rx table should support FDB T=
x
> as well.
>=20
> Signed-off-by: Suanming Mou <suanmingm@nvidia.com>
> ---
>  drivers/common/mlx5/mlx5_devx_cmds.c | 8 ++++++++
> drivers/common/mlx5/mlx5_devx_cmds.h | 1 +
>  drivers/net/mlx5/linux/mlx5_os.c     | 1 +
>  drivers/net/mlx5/mlx5.h              | 1 +
>  drivers/net/mlx5/mlx5_flow_hw.c      | 8 +++++++-
>  5 files changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c
> b/drivers/common/mlx5/mlx5_devx_cmds.c
> index f504b29f31..eb8553e8ad 100644
> --- a/drivers/common/mlx5/mlx5_devx_cmds.c
> +++ b/drivers/common/mlx5/mlx5_devx_cmds.c
> @@ -924,6 +924,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
>  	uint32_t out[MLX5_ST_SZ_DW(query_hca_cap_out)] =3D {0};
>  	bool hca_cap_2_sup;
>  	uint64_t general_obj_types_supported =3D 0;
> +	uint64_t stc_action_type_127_64;
>  	void *hcattr;
>  	int rc, i;
>=20
> @@ -1352,6 +1353,13 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
>  		attr->fdb_unified_en =3D MLX5_GET(wqe_based_flow_table_cap,
>  						hcattr,
>  						fdb_unified_en);
> +		stc_action_type_127_64 =3D MLX5_GET64(wqe_based_flow_table_cap,
> +						    hcattr,
> +						    stc_action_type_127_64);
> +		if (stc_action_type_127_64 &
> +		   (1 <<
> (MLX5_IFC_STC_ACTION_TYPE_JUMP_FLOW_TABLE_FDB_RX_BIT_INDEX -
> +			  MLX5_IFC_STC_ACTION_TYPE_BIT_64_INDEX)))
> +			attr->jump_fdb_rx_en =3D true;

I assume integer value 1 is enough, since it is a bit field, no need to use=
 bool type.=20

>  	}
>  	/* Query HCA attribute for ROCE. */
>  	if (attr->roce) {
> diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h
> b/drivers/common/mlx5/mlx5_devx_cmds.h
> index 8de4210fb2..6c726a0d46 100644
> --- a/drivers/common/mlx5/mlx5_devx_cmds.h
> +++ b/drivers/common/mlx5/mlx5_devx_cmds.h
> @@ -326,6 +326,7 @@ struct mlx5_hca_attr {
>  	uint32_t lag_rx_port_affinity:1;
>  	uint32_t wqe_based_flow_table_sup:1;
>  	uint32_t fdb_unified_en:1;
> +	uint32_t jump_fdb_rx_en:1;
>  	uint8_t max_header_modify_pattern_length;
>  	uint64_t system_image_guid;
>  	uint32_t log_max_conn_track_offload:5; diff --git
> a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
> index 9410211e3b..4e64026137 100644
> --- a/drivers/net/mlx5/linux/mlx5_os.c
> +++ b/drivers/net/mlx5/linux/mlx5_os.c
> @@ -1718,6 +1718,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
>  		priv->unified_fdb_en =3D !!priv->master;
>  		DRV_LOG(DEBUG, "port %u: unified FDB %s enabled.",
>  			eth_dev->data->port_id, priv->unified_fdb_en ? "is" :
> "isn't");
> +		priv->jump_fdb_rx_en =3D sh->cdev-
> >config.hca_attr.jump_fdb_rx_en;

Can we add some INFO or DEBUG level log to indicate this to the user?

>  		if (priv->sh->config.dv_esw_en) {
>  			uint32_t usable_bits;
>  			uint32_t required_bits;
> diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h index
> f73f6e63ff..545ba48b3c 100644
> --- a/drivers/net/mlx5/mlx5.h
> +++ b/drivers/net/mlx5/mlx5.h
> @@ -1987,6 +1987,7 @@ struct mlx5_priv {
>  	uint32_t num_lag_ports:4; /* Number of ports can be bonded. */
>  	uint32_t tunnel_enabled:1; /* If tunnel offloading is enabled on
> rxqs. */
>  	uint32_t unified_fdb_en:1; /* Unified FDB flag per port. */
> +	uint32_t jump_fdb_rx_en:1; /* Jump from FDB Tx to FDB Rx flag per
> +port. */
>  	uint16_t domain_id; /* Switch domain identifier. */
>  	uint16_t vport_id; /* Associated VF vport index (if any). */
>  	uint32_t vport_meta_tag; /* Used for vport index match ove VF LAG.
> */ diff --git a/drivers/net/mlx5/mlx5_flow_hw.c
> b/drivers/net/mlx5/mlx5_flow_hw.c index f0888dbf0e..83f55ed3e8 100644
> --- a/drivers/net/mlx5/mlx5_flow_hw.c
> +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> @@ -9322,6 +9322,7 @@ flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx)
>  	struct mlx5_flow_group *grp_data;
>  	struct mlx5dr_table *tbl =3D NULL;
>  	struct mlx5dr_action *jump;
> +	uint32_t hws_flags;
>  	uint32_t idx =3D 0;
>  	MKSTR(matcher_name, "%s_%s_%u_%u_matcher_list",
>  	      attr->transfer ? "FDB" : "NIC", attr->egress ? "egress" :
> "ingress", @@ -9342,10 +9343,15 @@ flow_hw_grp_create_cb(void *tool_ctx,
> void *cb_ctx)
>  		goto error;
>  	grp_data->tbl =3D tbl;
>  	if (attr->group) {
> +		hws_flags =3D mlx5_hw_act_dest_table_flag[dr_tbl_attr.type];
> +		/* For case of jump from FDB Tx to FDB Rx as it is supported
> now. */
> +		if (priv->jump_fdb_rx_en &&
> +		    dr_tbl_attr.type =3D=3D MLX5DR_TABLE_TYPE_FDB_RX)
> +			hws_flags |=3D MLX5DR_ACTION_FLAG_HWS_FDB_TX;
>  		/* Jump action be used by non-root table. */
>  		jump =3D mlx5dr_action_create_dest_table
>  			(priv->dr_ctx, tbl,
> -			 mlx5_hw_act_dest_table_flag[dr_tbl_attr.type]);
> +			 hws_flags);
>  		if (!jump)
>  			goto error;
>  		grp_data->jump.hws_action =3D jump;
> --
> 2.34.1

