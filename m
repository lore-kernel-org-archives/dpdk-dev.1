Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8DBC54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 16:09:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD66F402B3;
	Tue, 27 May 2025 18:09:18 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by mails.dpdk.org (Postfix) with ESMTP id 331DA402A0;
 Tue, 27 May 2025 18:09:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucJO7k8xGHFwEaNsGjoyF/Oq/Q0ckoVERiu0WDc9KlmjOHgX3YVpMmUcjYpfKW1il+aR3aN6pGSHmPsPEPTiVt7kCWMHmOHB2mdrtjH3v7rFT5VcAE/YkgaSoKgxgkH7hn9/vcp6HUFOaCiW75dWWdcos6vFzofyxO+KtNznlu0tcbUclp1dZaojUDyMFxTx7csE3jGy609wT+CS2FMNmOAwFNEfAwphSAOHx8U+5c+nOy8tkptgzax2GrBuvhKfg/uNP+l9+9onpTPzW6skxlO+JBBBMwhrHy3ctt5nDm0Lqk6W6fI07BrlIKPPsX1GltrtIjB2W3jisr6mNeGazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVuafvS0NO9Be2WHKA/4ly1CeqADIcDZCebdC5ntbkQ=;
 b=nec6AURssmUG8lUFwYUSGP+mvmWdcBi9uQoHq99Go7sK666gWqeX5hmTsHnahxw6M1qbPdi6TFAykTLGzwqQoKOwYpLoGLS+mJf9Sc3JCBrRgg2MExj23HV8t+kf+ictvUC6TtfkNihxDjm8UTImcZEoe98DVayJyEZjXOoAwLGlYG1d2EK1Fjfa9GVVy/y6EH525XUec431+enUK9b2+ooJk1ja2NEAVsSTXbgzaI0eO0ldwy9s3x9CZ+oRtkbP76z5Won6T21vDaFelqXIvnx0G1dMDEliprjsqEnuVWR+b7njZ1ZK4fVTeDxWRwb79S/Khmo7fhmFX23iYRAQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVuafvS0NO9Be2WHKA/4ly1CeqADIcDZCebdC5ntbkQ=;
 b=Yk7f1FLKp3Wln8KrG6f5nEGc5PkH9zuLZhCklaZitZMhlCwFm1uHTpnTHFQZit2GY4+jcN/0cVj/RDrJvBt5XbpBkvnM4wStsXk4G/e9+DpgHW+Wk35YOUiKwzIRzO9OSC7wetWzC/1SupR0KTtkCOHzMnJZ4ct3Rfz67POhWEwOWt45OJvrQEPjFSeHIYBGS90pi3T2SAIxJhs0kf0qc3W4uRgGCVwPTC3/9B51ZTbr/zd+UNf9kSEtbmMjm+xXnezYZQz5W7rGhSgcpZJ0mkOtRtIPuDj3Y+AO2XDMEwNain2vsHPrVVnDNxEjSJKVk0yXn8Fl8cpsNXogevQT4Q==
Received: from PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 16:09:13 +0000
Received: from PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662]) by PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662%6]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 16:09:13 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/mlx5: fix VLAN stripping on hairpin queues
Thread-Topic: [PATCH] net/mlx5: fix VLAN stripping on hairpin queues
Thread-Index: AQHbths0Qxu9OhWw10qsHr2bcvzOlLPm1v9Q
Date: Tue, 27 May 2025 16:09:13 +0000
Message-ID: <PH7PR12MB69057B73DF682B97CCB3DD8AD064A@PH7PR12MB6905.namprd12.prod.outlook.com>
References: <20250425194913.70742-1-dsosnowski@nvidia.com>
In-Reply-To: <20250425194913.70742-1-dsosnowski@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6905:EE_|SA0PR12MB7463:EE_
x-ms-office365-filtering-correlation-id: 36e764d9-a164-42ae-a9a9-08dd9d38d289
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rTwgtaq1uZZTb5FEYpnRH9thhEg+JirPc2oQ0jN6FPPvUOOTlYqqM/Pne1if?=
 =?us-ascii?Q?nXD6TQboCkI326Uxx89PScQVECUG9FZv/Ml1I/h/+33zjZhSeC5W7IpjUtn/?=
 =?us-ascii?Q?GZPTnMsZUMnKXZ15qlupthCsVGYItE84IPZazPYEy/wFdDF9kEg/9/8gI1v2?=
 =?us-ascii?Q?vR0h8js6jJTM9RhTdYn5JhK2deVjiyHifd0uxitrTczYCErp5GcD5f23L76a?=
 =?us-ascii?Q?pGhQ2l+GtZJvIYvGj+jBe3HEVDes7CJg8Um81WzVTDuSCqPchA7bGycU5TLn?=
 =?us-ascii?Q?rRSwluYW5irQ6tnY6m9b729X3HNkm6p+oby0g0hmJ+kNunA9qtdmKDUpRNFC?=
 =?us-ascii?Q?qb7hK4PYN0E9styQf+UHosfLOO2spYsZRCpOMBd35mWNMfr3DCMIslctZBGs?=
 =?us-ascii?Q?x9HwRCSj8SYIC/Xki8gllCwjUtuay+fjh3E6S+TcR4P5eyi9YiHtTT36br6t?=
 =?us-ascii?Q?+ExcPvS755/DI62hugA96S7pGzYf4g6UOZvbI0JJHILNNRxp+W3iLG61zNm5?=
 =?us-ascii?Q?4vex9YJ2aFs3NXpSG2kAT/0pTD+HY+uh5AzEwbWUqEn2Cdc1bOecO+FKAbyF?=
 =?us-ascii?Q?JMkXXr/KYeL137G8ahacmSoafapkzPZUZrJiGrtybJKYJyYyI69L3U95eAa9?=
 =?us-ascii?Q?xjluWXwePsyxnj1nIfV8hmLuA5cm8HfZro9y+fC2/VPnhQq2iky8/XeJCPV6?=
 =?us-ascii?Q?gqw1tk8qXuFN8TNtqQdvjEgm1v5uQ4pDU/BqOcsIPz0BG3f09jWYuBRj0FZw?=
 =?us-ascii?Q?8oDgQGuGtSs2ieDoCkUhpT64XwyDouaANohwmd8WkSavJx3BlH8fB9tfASu+?=
 =?us-ascii?Q?9CcQ9O+MZiRhdzQ8AB6sdQBDYqPq8U4Zuq3jGK7/x3rWFb7Ysb98QDNGtvKJ?=
 =?us-ascii?Q?M99kvQseQ0r3vIrlTmnBi1BdKsIob2HPcwkcnW+YsDhykiNwvVIYxUf+pixE?=
 =?us-ascii?Q?L/k4F2Pk5G8Q/4FqpCz/SkNTKxczJesMsPD8qGExpuI9gFnRMbx+FM2cDUe/?=
 =?us-ascii?Q?lLfAMmzRXGfHglpVBKABWwmjOv//BFHex6qjFlydd2tztOc0FVcqkl2R76NB?=
 =?us-ascii?Q?7hPn4MOvR0eVP6jjjj/8mzM8i7QD0aiby59BWitF3M+3d/vEetYsCCVyiJ2K?=
 =?us-ascii?Q?uwQ9NJl3TbRJyktmCQevBq+8f1uFMSMCSdRYIRN81T2gt/IHeKuBR2Sb7zX5?=
 =?us-ascii?Q?ybxkUDRLguy9moU4sbfUab7pbIY9k1UUpd7kYHhlgY/Sh+d8/DOuBmv5AD5P?=
 =?us-ascii?Q?cDQB77Gu1kYMJxaHQJI8esRIQ/ne0PwaefjeHC3rLCUxkq2wb6iiflufYXW2?=
 =?us-ascii?Q?xbHV/9xfvxTywmiLMjQFkinSv58F4eLNdTBWA7ve0RmFApgVc0b8/+oVmm1U?=
 =?us-ascii?Q?TsD6eQflzP1YjsQaKUIlBWR1eYYtwjctkEBkhqBR5WmONZNPW+/MBQ/pDB/H?=
 =?us-ascii?Q?1fnazUeOg6Ar676XtxvyXVgGw+jEi2almOl3bYYnDiaG+5gAJeC6+0irCs9z?=
 =?us-ascii?Q?SUktOFM+4Ha4JNY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6905.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dLmifmTVlOqZLDPkUD/8vmAD92/bgcMHjF2RsFLqRBow/eEsdlwGwAlnuYTa?=
 =?us-ascii?Q?Jd/L3H8uSS5UIA1FuNyFnGzXuSTp+6ga8mEEELnBCUnXS1FdM/H+RlXs73zJ?=
 =?us-ascii?Q?jONkVCQp786x+MqrBIiUuGnItGYQ+4wdm71XdaVhd6Kk1GjmAluEt0vXMunJ?=
 =?us-ascii?Q?yZAd3HHbXGSu0p9ANeNbaK0rSSgzjhF7PiwubYOZjerAeOGerZ+vRPInIVsJ?=
 =?us-ascii?Q?qV2iVn5+LrxySO/t9+77LhOAvOBn1Ar4bls+SzClctrG5nSR7YxeGUXUNBEq?=
 =?us-ascii?Q?80X0VHHkY2vKtybFFPPrQB4VsXAE4vVS2k3HPE4poKXaolNsj43ob4pbKI6U?=
 =?us-ascii?Q?t93FR2dpkLBleAP/PszuHpCoZ1KNifHQAwnVzle6jWges6lWTJgULvlu8/98?=
 =?us-ascii?Q?t5qdDsWp58gCoUkrt2aY0M1m4Is0dtLaNTJDpH9uD/u4LmkK4Lwxf7VL4XDC?=
 =?us-ascii?Q?QZj9bcxNXCghKL4LC+h3zEOVEKr1YVdUdLzloZzwH5tjt01uZKeKoH6wJZBb?=
 =?us-ascii?Q?eclK+FTyJAV7USdhpAqCuJhV1lsy96oxAlECu9+5q28DARlNr73FXGoON3qn?=
 =?us-ascii?Q?w6NUncHDye4Qbaz4ewBPInHU2uXuKONOYKCqYsIh+8y+nIdwW5ApG+cu97il?=
 =?us-ascii?Q?Z8d7QFp1coycBpM3nR74XEWsg9THoXjBaxxX8/LQyEWPCrdmxpuPXDtmovIr?=
 =?us-ascii?Q?MN7kKnvw9h4GAC62ZtJHBDo2n/rJxoCREhKMzFc/oXym+Av7aHR0jTeI1U/A?=
 =?us-ascii?Q?+9lWsTSl/wXjhI+jvgkXxsn46Ax6ap93rf33bwwdFY6yc1ADXmNtPxUljYjL?=
 =?us-ascii?Q?aPGfbTzsK0UJ9Ma+wyIl7KjRPkm3glaaDO9A7Zw6SvF9ZNR64xtdvtt8fmJc?=
 =?us-ascii?Q?RsltSg+Vk9TdDeNx4py01chZdU+4BuP1d4sM2PrN9vyf8rf4BdZvMbpcGSES?=
 =?us-ascii?Q?w8Mb5XAoP8n3Ltpe+Zss06VgqLD7Odq6gXocC32UmOESZfjGtVND/zskRwse?=
 =?us-ascii?Q?ATFL7QhOtbYLZ22PCNcQZX1WFjmMeywnjnAz+yxydPH9q+TOyqVH6w+nc7V/?=
 =?us-ascii?Q?WDR1L4LpfDqePNGH5+zkpB7vyiOlwFst19hTxTTSmRH4BBspPtolZPSlX/oO?=
 =?us-ascii?Q?O4BPqhgHdJbvy3TwLhYeVlW9oCU/wCBUyCWTi6TKSs/aL7r7l/Ae/YUcLBdD?=
 =?us-ascii?Q?fYplhZfpItGXBXtMx81t1Bb2c9j+sDaEwMdrNgN82KkVeXQIQqtNm6EhlmHY?=
 =?us-ascii?Q?bXnCkOezbJo2DBI8nydfwiyT4BN1fd4ycM5sMTTZ1OWyapnXIpSyPa6RBUYy?=
 =?us-ascii?Q?Dq2ruwv3IbSbget3mwGgvCU4Y1mtJHH/j8jBQNot40kjYIqXGyLYmTyMsNSC?=
 =?us-ascii?Q?CTIMNqK++vtkUy9K8EMSOTSxx/rxh1qSf86XhXpcDfThHVuUPJqsUJ5zTVF6?=
 =?us-ascii?Q?0H3MiisAIyOg/d1nkzk6f8ha+quEdy+50qBQAs9xHTX7qGa70Iqq+vJw+KmT?=
 =?us-ascii?Q?aQYqlMYjceG7GfQTCy/k3sLxJhfgufJveVvK8hoY3M9NaAoDiOPskc3AzBvs?=
 =?us-ascii?Q?DeJGG3p4yWN1oLlfRWc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6905.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e764d9-a164-42ae-a9a9-08dd9d38d289
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 16:09:13.2398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/V+tMv5Dz4LmYNzbIaI4eZG7+6JEZ2/I5tX1DvAT5FAiz5KeOcTj6R8EomKSwQK97yQPSUAOtiN5AZLgD30FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463
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
> From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Sent: Saturday, April 26, 2025 3:49 AM
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org; stable@dpdk.org
> Subject: [PATCH] net/mlx5: fix VLAN stripping on hairpin queues
>=20
> Rx hairpin queues support VLAN stripping, but if port was started and
> application attempted to configure stripping on hairpin queue, segfault
> was triggered because of NULL dereference.
> Underlying function, which was updating the RQ was passing wrong object
> handle for hairpin queues.
> This patch fixes that.
>=20
> Fixes: e79c9be91515 ("net/mlx5: support Rx hairpin queues")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
>  drivers/net/mlx5/mlx5_devx.c | 2 ++
>  drivers/net/mlx5/mlx5_vlan.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
> index a12891a983..ed1826a612 100644
> --- a/drivers/net/mlx5/mlx5_devx.c
> +++ b/drivers/net/mlx5/mlx5_devx.c
> @@ -88,6 +88,8 @@ mlx5_rxq_obj_modify_rq_vlan_strip(struct mlx5_rxq_priv
> *rxq, int on)
>  	rq_attr.state =3D MLX5_RQC_STATE_RDY;
>  	rq_attr.vsd =3D (on ? 0 : 1);
>  	rq_attr.modify_bitmask =3D MLX5_MODIFY_RQ_IN_MODIFY_BITMASK_VSD;
> +	if (rxq->ctrl->is_hairpin)
> +		return mlx5_devx_cmd_modify_rq(rxq->ctrl->obj->rq, &rq_attr);
>  	return mlx5_devx_cmd_modify_rq(rxq->devx_rq.rq, &rq_attr);  }
>=20
> diff --git a/drivers/net/mlx5/mlx5_vlan.c b/drivers/net/mlx5/mlx5_vlan.c
> index 43a314a679..7c7ac78dfe 100644
> --- a/drivers/net/mlx5/mlx5_vlan.c
> +++ b/drivers/net/mlx5/mlx5_vlan.c
> @@ -107,7 +107,7 @@ mlx5_vlan_strip_queue_set(struct rte_eth_dev *dev,
> uint16_t queue, int on)
>  			dev->data->port_id, queue);
>  		return;
>  	}
> -	DRV_LOG(DEBUG, "port %u set VLAN stripping offloads %d for
> port %uqueue %d",
> +	DRV_LOG(DEBUG, "port %u set VLAN stripping offloads %d for port %u
> +queue %d",
>  		dev->data->port_id, on, rxq_data->port_id, queue);
>  	if (rxq->ctrl->obj =3D=3D NULL) {
>  		/* Update related bits in RX queue. */
> --
> 2.39.5

Acked-by: Bing Zhao <bingz@nvidia.com>

Thanks

