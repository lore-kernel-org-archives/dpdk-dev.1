Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFD7CD13D2
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 08:58:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 682F54065B;
	Wed, 12 Nov 2025 09:58:40 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010006.outbound.protection.outlook.com
 [40.93.198.6]) by mails.dpdk.org (Postfix) with ESMTP id 1654E4014F;
 Wed, 12 Nov 2025 09:58:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5vPHCJO1KFTMDWB0KeQg/8JIVqKM7+/5WEaHV6Dn2ounkMhQkzsF+swBKwd0IFxBhUrIrAXTGThCd31QvtHsco4UEZZOq13N+potIIKS2LZEDf6IQftbyfQRtbqWvkRDAVKSUhSOGhdDkVa8RePV5FpwRUwDYcWbpsF8Wa24ny7CgItU6vGX0tm3OW8DjqOUasR06otGc0u1vxMOL7EfrsIJrVllGv501LH55XhLQCLes3h4C6mnOtC/KjA3D8S4ETRWydAbDZ8HD3LzVIV3R822ohiigbCRS65O0QEw2O7p7jbyWB4ZxpcO12rh3UhGAOom4SRbj8203p+ay2fFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcHBBgW0L8KJatic2289r3V/63wNCGipcSs373ehHko=;
 b=dOe+sllyKtWrK/x8Rg8UZnX03G3+OWjaxaF05b1bSbCRrSg1vL9vOYvYFzXD/sjZdx105EBf4RNpSQWq5e6eNG+ppeOk5kqdXCey5EaNupZXbOgbkeG2CAY9RBh+TivRznNz//u0Xxyj9sf/olUalWqIkuxJqm4MDi0Y3LfZMqJiLZNAJaPEAAzzkZQYKirsI380HZeOBVrUOKqNp108Pv2aLzd/oFnacf2VAs9XfcViJ16cTQe2h07EHATZOh2GznDh6w0mq5INzT7ergp3V62jB52AAnC5NosfLLYQJhTAbzVdvC06AN5s1QXkjlvMh/ZENzDsVOVm/5W4fNMTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcHBBgW0L8KJatic2289r3V/63wNCGipcSs373ehHko=;
 b=q6aBz5ZRQ/RpDLOqmHTl0wcOaShwF3Pkdf1jrM/DEZ/ESsGNcdXejHcZOffgkEfHCG+4m0XlYsv8hAmzziw+ANoe3g+i0FlGWUXu0aOQpxTdFbhelJqzJIXGbq+4JkY6V6MBgc66/3eY7olmt8mYE8GgP2wRtVzqnbEpt6H//HH8m+bs8vqs7i0U0Atax3C6QTVzbmPcvN7vddEQgeXC/MNlIas7L2lwy1KTKZff7Aw7fcFwHS1JEIw0HOc5yXktzbjY2CZXo8cLGannkKMIDjtd4xrdoLs6N+zvT0dQ4SaLMozp9W8Yt6abWX6t7amzXtmo4PT31QqNGKobGyhq6w==
Received: from IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 08:58:35 +0000
Received: from IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7]) by IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7%2]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 08:58:35 +0000
From: Bing Zhao <bingz@nvidia.com>
To: "Minggang(Gavin) Li" <gavinl@nvidia.com>, Matan Azrad <matan@nvidia.com>, 
 Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/mlx5: fix IPv6 DSCP offset in NT HWS API
Thread-Topic: [PATCH] net/mlx5: fix IPv6 DSCP offset in NT HWS API
Thread-Index: AQHcMdwPlXiMCfGbL0yQolviavktGLTvAOfA
Date: Wed, 12 Nov 2025 08:58:35 +0000
Message-ID: <IA4PR12MB97632C78D2EAF7F0987C75A2D0CCA@IA4PR12MB9763.namprd12.prod.outlook.com>
References: <20250930072827.9630-1-gavinl@nvidia.com>
In-Reply-To: <20250930072827.9630-1-gavinl@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9763:EE_|CH0PR12MB8488:EE_
x-ms-office365-filtering-correlation-id: cdefdc98-84a2-49e8-02d9-08de21c9a9a8
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?cYqt4FMciH/snh7ZsiVoON4MtxujZmN9WqEfdj0ei0+u0cwgyLMW+mRhaD67?=
 =?us-ascii?Q?XThEBVJEKthprNx/HaBfjj8WLPJ+amiUyBKBNAzuusVSy95bjhZOHdHgmQkS?=
 =?us-ascii?Q?RSAnMK4kCY1cvaIXF4XkurOWu7sy3zp0iyycD9SYW8JvMPIGVVPlmp2+coSw?=
 =?us-ascii?Q?IeWCwmoIO21cy2BKv+7K8bXei0KJqdu2SPKKYBTpFVUxVrVLPfpGjmdJCnWT?=
 =?us-ascii?Q?qhGgwf7ayaOQ11laH2TjK/Z9FoH4VpBTrPBZDFWSpB3l6SrvClhRJajYFRgZ?=
 =?us-ascii?Q?ksK5feCVWeCXRX4Otl6wUN3ZwDEAT7QOdWxsuRgCJ6E4xSbkvBg9ZdVvUrhl?=
 =?us-ascii?Q?BM2r6++8DVOUVK/bWZNIZI63PP98LTzDIKvVDCGhARQ00HXesg3/BEOzO/cV?=
 =?us-ascii?Q?vOOB5JPRqmgu1FQe4T6hpGJyw15YRF4nzIkYzEnnaqVAWpdKVifNNosFgzrU?=
 =?us-ascii?Q?EFoc5zN3cytbbdTHoo3HvDbJGjVLBsBnuq0anCwUIhLza/b6ounbzR0/soFq?=
 =?us-ascii?Q?YQBTmgD/9O43DFLdjzyy4845wlKlIZbwxNKTnSOM7FiUG0AQzYnBSPo/UgWy?=
 =?us-ascii?Q?fk7Wd3ljnB8LqXP4wLiwAcuyBFhJglFLZ1SykOjuUvSZ6FIW083eyBNYp1Nn?=
 =?us-ascii?Q?iI/fiAVf/b8Br2uIhNKkJ9NrrQDqU09zBaCCN05wPhEpqzCgcZXsTzU0kr5v?=
 =?us-ascii?Q?Adnxob6Uw5jOvZ7sWoJpxMIxH0iFmTykOKiPH4zMyNODMmb93NnsLXL7+QvM?=
 =?us-ascii?Q?TMRs0rtzwH6u0MmZQpJdDWmuVlw+jwdE2CMLdqg8An9tqwT5iLeVUSflYyZJ?=
 =?us-ascii?Q?g89HZo7lnaWEyYOkVrZdu/k1Nb2XfVH5QkjC/q98UhXQVBAe9Jt0HQuTGHIn?=
 =?us-ascii?Q?1djUyz6Og92Y5eUuAI3zztd5DIti7Ga96KACa6FlBrXIOt7nOespeTff8819?=
 =?us-ascii?Q?Aak519rPEVdVwhppaEiB/Tqzd94lYmIUH6yQow0sHrLKNh2Ufhj4/IGNbBT5?=
 =?us-ascii?Q?LxtG4R9Kqi/0UCsesaDq6TYYZdMflGpsYRv0xJ2eQ4m4fRyHw3iSSWbulv6J?=
 =?us-ascii?Q?tUoUWwdLfryEFRqiKmRDJBgDr0+kESJ3BXQh83DQ8IZSV9d/TFG++Dx0uWty?=
 =?us-ascii?Q?R5r4hn7kTUPKZKfueZauBL2UPwh5Yqt09/UDQMxJXkVkVNZ9zpdX/h65acFw?=
 =?us-ascii?Q?3VjLyR7hqgpFlAhqIFFCwMDf/h9G5xeaxXisynAL1iyCU9YM607jh50Z8a7o?=
 =?us-ascii?Q?VvaUxNcpo+1BwTWk550/buRh1n5eJ2RFqJLOOIPx09tPfhLrrEBYeZ1z3klD?=
 =?us-ascii?Q?h0GziK42Yu1Hm6TJ18DavwBMhqQW4NzBYr0BB1doOcsNJQvjIsSNVKyR0Y0p?=
 =?us-ascii?Q?t6VnsSYl6WMqVHARHKxuGXplHFHj3vxI0UM5gPkQ6kZM2ONRXoZbTi8y6G9l?=
 =?us-ascii?Q?98Wxw/zIhGjHNhZfFyv1ONjFUjauA2lurO52+mEdyPwwcJHKX5IHHI+iJgV/?=
 =?us-ascii?Q?jLlB5/lLp07tXVct9jupd9CseV6t2jHCgOg6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eLIaOPVuwXt96P8B5DihIsS767VUGPrr4XV3X0Gk02SV8xMpTKzxvGGOuj5j?=
 =?us-ascii?Q?c7PAizLi4hbJfAxQB+7OW8oqM+Xp/oObAaV8rYQj2gm98xh53Beej4O8JFI8?=
 =?us-ascii?Q?/J4+N8k/81fr7iLL45xXric97jgeLBPogrYGptGHiRtwg6VJe1pVtsHEVIP2?=
 =?us-ascii?Q?9vfyPWUbPbzkaZ0anDKNI7z74IcQSLQ+hhEkYGYMvWDGnfwhfuJaczaB/oTX?=
 =?us-ascii?Q?8ilGrryPXiEBUZet7tK2gcnfrfOr4AfKFHju9eibwDcY3q8EjYUcNRcJ6SHd?=
 =?us-ascii?Q?YdPUX2L6+mt23jRmEcVClzNYASz9IhzKTrm3PGUfFuWGyFL8lYYPdWHPkVzN?=
 =?us-ascii?Q?viokDVEpWT223k+F6wJ36ygPyTqvjpB2rniV3aFP2FRkNUywYc2BH0fqVcJx?=
 =?us-ascii?Q?GPQtoRn9jjapIRBeV3N25s+LpwCJvFbk3PeOaGu2JUyv7m4RWw9NQcfQBQu3?=
 =?us-ascii?Q?hIgzQ3lWxpi4tFtHHVbr6nTKud13bOqZIl1lpAABqJAp08B4cCQ7wCUvy83Y?=
 =?us-ascii?Q?RZlgR7XjBahpH52lCh0kc6ODg/y2fYGaSR027ZIT6XdUMmW9FKzYA2UAHkuN?=
 =?us-ascii?Q?roSXk+bJE92mJPq/UebZ8zKZcVhS3N2aml/HxfYgHWvABuH/DwjWuwHxtC6o?=
 =?us-ascii?Q?fwNkYKX3oo75EQd4dSJsbwJmWc4unBV4GWcqe+tHojQoMc9+AEgjYJPTlkjC?=
 =?us-ascii?Q?XsOtSDY7PysfcTthwq0MYwHwnhFOUUfALt7qK3lEYxNFR7xphK52/u5vTYQz?=
 =?us-ascii?Q?mh05IrKCLyNwc61rgtoJbbGaWqOWUHeXLjcrSI/HHtYnTgnssWSm6S7hgThI?=
 =?us-ascii?Q?JtUtPw2AinuC4/MUrhjc0n3AbpwVQFpPLG36g5XWt4ZMSoOWcnZ1wrDhA+X6?=
 =?us-ascii?Q?OT7LejQ8grZcGGwEMn9OQ9/+tL7uYrK4deLsJmGrUY/Bge8uMcVQP8LHqZzk?=
 =?us-ascii?Q?JXK6Ca/2ECJA/yIYNzFKMSdMEcqVNoGMXhZMo91kV1EwDvoTjaAalJqraJXF?=
 =?us-ascii?Q?xFsSh8vVKAUi6KqZUqlGAIPijPF3WIZACd/EzJmlZivFRNwp7bgfv+S/MLZ0?=
 =?us-ascii?Q?pDeiElwD9zbcjhIr2JEaJFmfYJe+nRv0hZi6bB5HwUzGgRWyKVPvs9p91jtu?=
 =?us-ascii?Q?PLOa3yX3zx6XznntLnUSr06yOuwN2VE3dxEqYd4JDFLezU+wIBC07/wGa/4f?=
 =?us-ascii?Q?L+lKagVxWEcbJY3zJxDRjocWu03h4kXEPoYSd1QVbhNilKfBmKxI6M4zJgQu?=
 =?us-ascii?Q?01ZZM8hlC5YMxvcZ19YuCYGK5TVaQ8BtFScLm73YNFXrWwiSZrIoOhfJfQKz?=
 =?us-ascii?Q?iWwSjodRtnQA2ue319HAhrN7QLZxadQ/SsNbDqDG+zVOf/vKU7prdiMK/dis?=
 =?us-ascii?Q?Z7vDv4lxJZ5JiCapJuT6K6AD2ExhnsN5a/UrOIJKMc15lChCr0ypQLZiRRKD?=
 =?us-ascii?Q?RXML+gwaCzR7BOnSLaBgcMl3rmGjUKaOZRKjzhKrbq+V/LMhbFeaZI1LRmxf?=
 =?us-ascii?Q?Z5uKULnN+qv9obvCKX/cYdVhEHM089rztiFwT5/92VvKtiNZwZNK2IxBT22L?=
 =?us-ascii?Q?YSx51Dt+wVQGuxCTGByvbAuuDoUxXGF5uXiO5vAs82eDb091APuP2gW4x9jH?=
 =?us-ascii?Q?AqFIDWW9ws9qOuYMgjL6DHs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdefdc98-84a2-49e8-02d9-08de21c9a9a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 08:58:35.1304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRntqRBvfwqHDHsglL56qwy8ntRk0yFb9235p6L3ZTfPZixu23I0YBzgL7La3qe0As2eg21Qo1EG3ndZ+atItg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488
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
> From: Minggang(Gavin) Li <gavinl@nvidia.com>
> Sent: Tuesday, September 30, 2025 3:28 PM
> To: Matan Azrad <matan@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Ori Kam <orika@nvidia.com>; NBU-Contact-Thomas
> Monjalon (EXTERNAL) <thomas@monjalon.net>; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Minggang(Gavin) Li <gavinl@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>; stable@dpdk.org
> Subject: [PATCH] net/mlx5: fix IPv6 DSCP offset in NT HWS API
>=20
> The RTE action process in the HWS non-template API differs from the
> process in SWS. The bit shift handling for IPv6 DSCP was not handled in
> HWS, resulting in incorrect data in the field.
>=20
> To resolve this, bit shift handling should be added to HWS.
>=20
> Fixes: ec1e7a5ceb69 ("net/mlx5: update IPv6 traffic class modification")
> Cc: stable@dpdk.org
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> ---
>  drivers/net/mlx5/mlx5_flow.h    | 5 +++++
>  drivers/net/mlx5/mlx5_flow_dv.c | 6 ------
> drivers/net/mlx5/mlx5_flow_hw.c | 5 +++++
>  3 files changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
> index ff61706054..6ec853f018 100644
> --- a/drivers/net/mlx5/mlx5_flow.h
> +++ b/drivers/net/mlx5/mlx5_flow.h
> @@ -3680,6 +3680,11 @@ void
>  mlx5_indirect_list_handles_release(struct rte_eth_dev *dev);
>=20
>  bool mlx5_flow_is_steering_disabled(void);
> +static inline bool
> +mlx5_dv_modify_ipv6_traffic_class_supported(struct mlx5_priv *priv) {
> +	return priv->sh->phdev->config.ipv6_tc_fallback =3D=3D
> MLX5_IPV6_TC_OK; }
>=20
>  #ifdef HAVE_MLX5_HWS_SUPPORT
>=20
> diff --git a/drivers/net/mlx5/mlx5_flow_dv.c
> b/drivers/net/mlx5/mlx5_flow_dv.c index bcce1597e2..517a5e530d 100644
> --- a/drivers/net/mlx5/mlx5_flow_dv.c
> +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> @@ -1638,12 +1638,6 @@ mlx5_modify_flex_item(const struct rte_eth_dev
> *dev,
>  	}
>  }
>=20
> -static inline bool
> -mlx5_dv_modify_ipv6_traffic_class_supported(struct mlx5_priv *priv) -{
> -	return priv->sh->phdev->config.ipv6_tc_fallback =3D=3D MLX5_IPV6_TC_OK;
> -}
> -
>  void
>  mlx5_flow_field_id_to_modify_info
>  		(const struct rte_flow_field_data *data, diff --git
> a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c index
> 9a0aa1827e..628a47f2ce 100644
> --- a/drivers/net/mlx5/mlx5_flow_hw.c
> +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> @@ -1613,6 +1613,11 @@ flow_hw_modify_field_compile(struct rte_eth_dev
> *dev,
>  			value =3D *(const uint8_t *)item.spec << 24;
>  			value =3D rte_cpu_to_be_32(value);
>  			item.spec =3D &value;
> +		} else if (conf->dst.field =3D=3D RTE_FLOW_FIELD_IPV6_DSCP &&
> +			   !(mask[0] & MLX5_IPV6_HDR_ECN_MASK) &&
> +			   mlx5_dv_modify_ipv6_traffic_class_supported(dev-
> >data->dev_private)) {
> +			value =3D *(const unaligned_uint32_t *)item.spec <<
> MLX5_IPV6_HDR_DSCP_SHIFT;
> +			item.spec =3D &value;
>  		}
>  	} else {
>  		type =3D conf->operation =3D=3D RTE_FLOW_MODIFY_SET ?
> --
> 2.34.1


Maybe the title can be changed to non-template API directly instead of NT H=
WS?

Acked-by: Bing Zhao <bingz@nvidia.com>

