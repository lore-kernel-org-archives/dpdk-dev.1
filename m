Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282ABC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 20:08:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F8544028C;
	Fri, 21 Aug 2026 22:08:38 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11020127.outbound.protection.outlook.com
 [52.101.193.127])
 by mails.dpdk.org (Postfix) with ESMTP id A7F1140274
 for <dev@dpdk.org>; Fri, 21 Aug 2026 22:08:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJ5Bogwdrrx/UXV44tc0bAubrOJ6JNFSg7G7mkHGdS3haNDdG05N1r5Tp9pr8a8Ylc8svclqO4gl3c94rkFEE7pPQ9XFVtBQ4SoWvFMKHCB3MFg5A8sWBVsNZRzJtn5JPkNxDDbEPVyTJkkoYV5Sh6vHtzSoQdZ88KuK18TbjmFvKd6kohInefWEeRz5hqVdYSkbNFHYKwBAzGsKa3lo9KBdZqNxB0mRPn/0jwOqQOugoc0Yhlg3c88erupxUrHXXTqtGRfUl0K81+pO64AVvv0uwHR1YYDx7TJ4NSWTZEa80GUl790kf5BG2PgzKJ7e1MG2Tl4+gXBsUzsWehjAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4f50pAjIPVS8TXLtrCZMpxn7yg1WBBeM8Tp32EUeuTc=;
 b=O0v445HOzhbmyRXjF7eT6ZfueHeb9+Kfk6ph1exr/tTkTx12o0thIkhOkUUp5deg/Kjt1qqYjiFw6GoB7eceExMAl2+7q0jUaZ0Q0dFi04r12PNV7Ce7PYzrlZlYkZFv1mF2aZmdripqpRIWEtaVFYUEhsP6EOxv/zt+pCIbgpeYOgkH+AOkRLO1u7l2W2JN47SKfW9uLypG/+p16PbLM+23BQ1zdwhXlZYXMxamBZLCqaoM3+f4D0cG2DY30rrVbJBcqHOqgCTk3+IA42r2Vq/iDyuLdmPYC5/GiEGIBCjOb6bS5Pg4v3PAur8ZBWAu+Z5wZk4SQK0rSuyUmvMPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f50pAjIPVS8TXLtrCZMpxn7yg1WBBeM8Tp32EUeuTc=;
 b=a7KxQ/Swh5+VwAXMcxD+qPG9SdmSQ0F7pdDxT0e/QDw6eZkI8fXrZpTmm5ofThddXdXokKrLQmYlYI6TL+XV+ueuiJRVlBksNmRbGHQ8tMKMOZ+XYb/hkUc//clJVrquzsjkPhv+j7YvhRD7RwrsX7zEUIgSx6in+kIB4CSPM2M=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5696.namprd21.prod.outlook.com (2603:10b6:806:493::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.1; Fri, 21 Aug
 2026 20:08:33 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Fri, 21 Aug 2026
 20:08:33 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v2 40/68] net/netvsc: replace use of rte_memcpy
Thread-Topic: [EXTERNAL] [PATCH v2 40/68] net/netvsc: replace use of rte_memcpy
Thread-Index: AQHdMaOD4xBWY5pAGEq2Xsfnd24+Orao7kcw
Date: Fri, 21 Aug 2026 20:08:33 +0000
Message-ID: <SA1PR21MB66835A682DDE11668B9E13CACEA32@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-41-stephen@networkplumber.org>
In-Reply-To: <20260821192646.146382-41-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e988c9d9-6b56-44d5-a534-2c424e7190c9;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-21T20:08:05Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5696:EE_
x-ms-office365-filtering-correlation-id: d2529fdb-6348-48cc-97f0-08deffbffa1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|10067099003|56012099006|7146999003|18002099003|11063799006|4143699003|22082099003;
x-microsoft-antispam-message-info: Q+LfZcwAOzPrkSlO6s3SBjqyQjizJzNwIGcEiqPNe2me+g3u8rq4s6YbCnz1u8bvlNP6DzqQvLDYlDibofKjPJKGDquXuDgktviwGNJbIS/TGxYU/Bc74uY1A46ni8vWGpTrwD2c/Y4wTZhnU/jhkbp/rILosM+d+J2YAqiFi+VOocn9+K55Vk5TCUVEioWf5uzlxtLe+unSaTBi/1xrF8rtc+VVUDsnecQ0fYiw1CAusj0dQvFsH0WJYu4Xp2U0vAwV0Kh27Ii2dtdxpO7fKPviy04ZpJMkOUTvIqtl5IaWrWP2b+ATi9Qm9ymaLkNWSOgDzRksO5QPDcF3ZepFG3mz4vLRg85Xe3JFME8HI4qFbzufI8s539xEhBU68vVzvhMDRQ2zEsadtwFe4VXuC2jrfJsqPTktgXaWBunZvH3qlH9TDgi6Pk2d9a6bxSJ1DrsRlWfPxdX40JUCPAEBhghlcpJzPXlHVfplu/EeKMXj1P+VdYpeKIKDsDpx1Lvo2CwHBg92HvFxkaludnin47WxN6fGzBI4GcM7/ToMxQNNlBDa3CVvAuju1sxCd1AOkCDabk8jcdFzYwNNrXJEirDEzMrJAyyA848CURjQQTI4QJXJ/TLX7Uqhm0MGZhN1I7y6H8NmGI78UgFsXEFquoB9wwJRwZFaFACmaDwd+mAUXSQ0eOshK0c9uETINzHxMx6mosoBtTYpzNan/mcNdGtIQ9gMG/ygNa5d8ONz/aM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(10067099003)(56012099006)(7146999003)(18002099003)(11063799006)(4143699003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S9DxiBtQWzmMPyuU2qrIPmDPsMBwh6dVvRcwaW8DeuLfWjiihwwXLoMZzdYp?=
 =?us-ascii?Q?8zDRAELkn7k8zH4yUSQQ3Xs/hhbft3KSH+okQw/gOM2xPBYRTtgoDBoKjUuU?=
 =?us-ascii?Q?sXoIxzBxUoUgmmKXn2KNjZLr2X2Uomr/IEBYeIWT3slIUM0Ht0AfLZ01IvHb?=
 =?us-ascii?Q?GuCNqOklln5F3Vg9Uwf+4TnJlcP8JhoDAY4a/xprIHJM42qW/ep7sd0Ty/01?=
 =?us-ascii?Q?WnwqzhLrLr4yr3q2AlFxxdIh/7z2YqBM72F9XFzH84NnUphCMAn8c2ieaow/?=
 =?us-ascii?Q?2XHGJbq3S3GStTWZ8snhqzya5cnkqX4TLPPAmbxxhl73UE9TJRXxYXslpWKE?=
 =?us-ascii?Q?JZYhoC+0ljZxlYD3o913e/Z4TDXrvtgMi5WTn1i31xIiDzpPq8/qnMB3/Z6i?=
 =?us-ascii?Q?NqChb4SpHF02+3VKT97EXD585tuiULYW5VTYKLoRDc5OSJn4bQHymT75nS19?=
 =?us-ascii?Q?q0w+nO2NWLWGT4S1rGQz3u/HJ/qPKiqcllnLQ1nq4CEPI7mn5Y6cuC2kzGzx?=
 =?us-ascii?Q?S9WxX54e0aAkM9j7JQNDG3MoS46CGaPifAArZAO0Z3djRxkxV0U650rZ2UCw?=
 =?us-ascii?Q?zT2Na2fCBK5AtBHeqozOKilExYHERnACQnsUqCf7z0JVQUXyTrWp0732ZYGq?=
 =?us-ascii?Q?BI1a4luPZArTrltdXCRxSfHsHoGt7Qmw3biND1pxXc9eOwwIEgBvDY/rSjUf?=
 =?us-ascii?Q?KMl1LuZM9t7NHbSMzsBSKWsW2GRyJ4u+Haq+qmugIJsC1ssr7gml6RiXqsqA?=
 =?us-ascii?Q?h+OBcbD4d1PTGKEcWVeQE4YcQCtJeHvPv646iZphniIHbTcXX4vs3L+foAa/?=
 =?us-ascii?Q?qnjAy9slYNeMkSf6SgFJvnWXj+C+kTvbkxi3QY4DfFssZv+jPmOSM4Spol9s?=
 =?us-ascii?Q?UqjhyX+cfRoQ3lQGbq9FvP5f+EWOdM5tPgToqFK3dLTGMbOgLatnN22Ee2oO?=
 =?us-ascii?Q?l6EVkI2O58/ZtgTNEQxR6921IjXD6yyYby+ZYu92jR+CG/zgJce7cL+ilyUS?=
 =?us-ascii?Q?YrNw4DK7Ael6QOTJrKnwMr8F3jMV4br2z4Tv2HluXwS/lRFERpHdyC4OyMKS?=
 =?us-ascii?Q?9VHHqzTeao0vqUJlhKdR5/NOLj+3h/fZj1PzoU3ZF1ywXWDUfTckDKF2LDbO?=
 =?us-ascii?Q?/h0yNmgCAqbUqHbUuD1TXUhGZdAUfVwTQFqQAx2VxLvzoe/YrvnDQ4KFecqR?=
 =?us-ascii?Q?oUDiytTUIldJi4M3O7iDnOfRy8EqLwlo34M7yjSTMxxiG+yV3Dk74MV8Z94d?=
 =?us-ascii?Q?yxdM+op8qUziusXd4bj9AqJuTksfOSKuBf5wITb/MQwoGIPuXsK7N+oCZ75h?=
 =?us-ascii?Q?jVuliOOFRb/7FLtNDGO9S4HEwvd1VmF0G/B0Ue5ofL4WrYgY6nX5Up5u/hlF?=
 =?us-ascii?Q?UNEYqC+UjlIbwTdJwDH9HTEa1hrB7FwToG+bIlCRKilDKGs5XLFu5SRdp7KA?=
 =?us-ascii?Q?7luonLkD2bkLgj6XkzMOCVB0jDW+uXr0yvL8yvDo1oiGiHoLBPVmJS7o54z+?=
 =?us-ascii?Q?Tv1LDbRiFCEj2AaADoDqyslqGABs3uqSqEkwbcv5LZvpr30AnB+tIdKjIwJ/?=
 =?us-ascii?Q?kyRUSMBF5VBFGRtFMPPxJRjAc3qCpQLxj03gMdruHM7iF7DDSk6ndqJuAhn5?=
 =?us-ascii?Q?11KyT9p8V6nBn0kSxe4dOuZlj3vHRa5PU2suhDYFv5bnuq9CGwdGSAuQ/WDS?=
 =?us-ascii?Q?5vtwh1v9HXOYM+uDMxcNP7gTkBuEyjU27ONfMflWENootRUP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2529fdb-6348-48cc-97f0-08deffbffa1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 20:08:33.3151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8hOPW5qjbB38Tkw7Te+WMsgd+NmRCQN/8g0NAOtR0MqCrwxdDaTbH4tblRJYNlKfZhWpxCZSRiEGdu4C1DPECA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5696
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

> Don't need rte_memcpy for fixed size value.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/net/netvsc/hn_ethdev.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethde=
v.c
> index 9a193e4a7a..c1bd55e6b5 100644
> --- a/drivers/net/netvsc/hn_ethdev.c
> +++ b/drivers/net/netvsc/hn_ethdev.c
> @@ -16,7 +16,6 @@
>  #include <sys/ioctl.h>
>=20
>  #include <rte_ethdev.h>
> -#include <rte_memcpy.h>
>  #include <rte_string_fns.h>
>  #include <rte_memzone.h>
>  #include <rte_devargs.h>
> --
> 2.53.0

