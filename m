Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C539C61DB2
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 11:13:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C45CE42ECB;
	Fri, 13 Jun 2025 13:13:43 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by mails.dpdk.org (Postfix) with ESMTP id 3E47D42EC3
 for <dev@dpdk.org>; Fri, 13 Jun 2025 13:13:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIsljVzAJe/CRrkZspYQ0NImD0LBEEpB71yTFnG+Jl9wuHenb1H753NYhoNdcO9Li6msWkWvZTUt04CZFtE5QYdg7fJ9Dgpy+pJtf6eeYFiUwK1k8H2+nWIEtycr5JZlciJBLAarsUHAKIrDla/rK+FAP0qKfYAAHa+ykxZwSBWeMykEqMZ0ddCFTrxX+x/onUj88Exjo3SSQ0lQxQuPusZxJdlOAunm/Egk0nKpQz9Zt7/V3CXG2uLB9yHUzyFY1efFQVLZbxJI3QYz7DkkCPS6+h4qof6KX5J3vTmhmJXU7IV2UYECl8CX5rbk3NX8hfEm5Td+lwG/LwkofXMX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54stbI8tZ6CzXi+kvKkeXm3FHboFmFPPKMhn+/+bbmE=;
 b=nqw8xR/M6waUjIXHWVaDghGl9z7bL/b5nqgw4voU91RqOcAoDpEhu/FaNzGLRORaFv3xkSEw6WUK2HYahVBOvPe5BNKdFGUiRRxYJHWN6E+rekQc3utEeEraJvtgGRRvqhdiFwruF7E5JDFnsv16ueHwSMJk9RqKfH5WAImPe0+S04ceX2mGmPDIAEcgI2DEs0K7sniNeEozV68Q6uVPWPB0ti4ydZpOnNkQ9ejLzTkjEUm4O9YOZqzoWjH3Jy0eRDnWi2baahx48OweiFcW7TKEcU/AxHcQlvu/knX/igcbKxEFlcNd29g1ANxDA/Pn51mcMzdNcmheBGt2HA2O7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54stbI8tZ6CzXi+kvKkeXm3FHboFmFPPKMhn+/+bbmE=;
 b=e/BxcJPxn4In7H9kM/5+TemgustqAQICEp8fNUcMkkDttVHCYv90ITN75pb2QqMooljpEVHK6chGPCs8LFwhGElSaKBBdxvTbr5lyK5BQQW9cKz5nON7MvgPTYfGmg4Cbxn9retmaMpxdOvCDgSPqGueLB2B29PU3TZILPSSaJo=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 11:13:39 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 11:13:39 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 0/2] Latencystat optimization and fix
Thread-Topic: [PATCH 0/2] Latencystat optimization and fix
Thread-Index: AQHb2/shAeQa9NcNV0SZK/J9wVs3wrQA7UZQ
Date: Fri, 13 Jun 2025 11:13:39 +0000
Message-ID: <PH7PR12MB85963A0EDD5D16984F7A64BB8277A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250613003547.39239-1-stephen@networkplumber.org>
In-Reply-To: <20250613003547.39239-1-stephen@networkplumber.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-13T11:02:22.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|PH7PR12MB7306:EE_
x-ms-office365-filtering-correlation-id: 5ece6345-6a97-489d-db91-08ddaa6b594f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VDUnBo0hiLohJ2wIasuamzRmqnc4TzPuNLxNZ12Plyutl3jJFlD52nSF1ZTY?=
 =?us-ascii?Q?kdKugW5W23p5DoMbO75lvvXwzZlGK3zbdV3QlTnQMenPUtmL06R142Dyz/ZV?=
 =?us-ascii?Q?cIvWfIb4gjHpPecjXa8gcW3GqClUXFR7CB5dcrlWe9KdRE8Ab2dtd6QXYLrZ?=
 =?us-ascii?Q?o7MWg2guB6aey+DfboPvYHg4tzH40LJNdrKx11IY5TY9g2Gy692EpbBl0J6g?=
 =?us-ascii?Q?VEtYnjDTg3433AGoGV1fvn78XrQ8/O32x8W1aI+0iFxXwpiFfkspJs3qJZSH?=
 =?us-ascii?Q?KWpWW3Ikrs37AHx/veRYoRTVBzgjFcQ0GpbVObJqUzQz2mVQiWILPHiLTv6D?=
 =?us-ascii?Q?IGLQwGqoz+VkWhABJffoLY/0+sxl42p8t6uuW6XF8oA1uJWcr/yolzXt2apH?=
 =?us-ascii?Q?XkQblzFtJ5gNSsOk7oEYYpBB9ZpKWqt1s3sXUXcJOewQoGy9lhQO6BHHZ7CT?=
 =?us-ascii?Q?QK7cWIRHyxgWVQsmNs4J78Cevf1WVf4yr8oxd6jvfSzoSOOnn3GeDStfyvTF?=
 =?us-ascii?Q?uIkBL/KSQO0ekNiNBIodbF1Xr2O+rxkt2jlN4JaS8xnsqYV3SPPkjzkJm1L6?=
 =?us-ascii?Q?zl/N2djT4QFkuW/dHnkEMl5zAxrcnrZftYZJPgyhnOaWmMVfm3+fWdSVnzl4?=
 =?us-ascii?Q?Qp0GR5jG5ZabQsVz7QK04qt9kkar74f+st4cPlkFtoO+jBMeHffdDrAuXiLc?=
 =?us-ascii?Q?viZ1SkY1HcmCnh3rmPWWcb6SlYpXXBW3GnbORtYGSefM+J5XPOJ2wdi7j/Ln?=
 =?us-ascii?Q?v7fnxrH+Lqf3Br4XjB2vcUoWzPhRvdQ8hZ0PPpW43WoMKZcJqSOa572odXIQ?=
 =?us-ascii?Q?X5WNiG4vNFeRc6jndHnWDqHpRR/Z0GZ5odDTsXL+KfbSgr9ipF3p0NUBK9eK?=
 =?us-ascii?Q?ZNXzXiibfJDXLE/1PRv01JSjUD9WUYFQQayfvYVIqFIMeo0nhjNGFF1qKj66?=
 =?us-ascii?Q?3De55vy1/uo2WMiyLeM9pnil0xJXp1GMna+K85mJiXxWa8GtG/ahQqEhW+R4?=
 =?us-ascii?Q?oQXkJZSV/MsypdXaR4oA3Lhih4yAZDJUttErOAS2R0L2FYUrtcXzsBR1+tGX?=
 =?us-ascii?Q?s0Chjgq7t39YGVnLYKWzBuu4D20sBQwAHA2wmyPY51SZNZxCP9dH07DPezKu?=
 =?us-ascii?Q?H8sM6UmeMJD5KkGfog//7k77xSiMHdedVKjSwVq+sQGlpfNsJDeFRXPIhjt4?=
 =?us-ascii?Q?HAxFG+9KeFxeTsFxa6m6mTn2fKGatWk7MJN1o+J1AA/sMpLMzuM+i8EMK+RG?=
 =?us-ascii?Q?1aBLcwxiPheJyiHUa1XHCQVEJwNFf33yLQgY09qOWDBQ2n8mSThtpJYaq6vm?=
 =?us-ascii?Q?Ryq8zRYyuID60wj358cFNUr3iYyBLRXHuXVZML6HSDPk4T8IdAs1FzzAJedE?=
 =?us-ascii?Q?AC65f7qANl9VfHuAoDnVLnl0PK+beJdnb9dEjm7DTcyG26e7hqaJjuq9e89S?=
 =?us-ascii?Q?42jxyjwFgYwT+8gofMBx5yO9IN/pLiRJpB4QDOLW5rvAzSeIxpb6n5QN5qHl?=
 =?us-ascii?Q?BGOj0Ea2ARQnm3c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XNTWGR17Uxz2NGGNYnnSUfIkYmgwjACfscFpJoD+a/Th41dD0pUn39FKsaG/?=
 =?us-ascii?Q?Iaj8rsgwkOBzb/QOBKBjtTNyjf+GtIoov3P0BkkF97BAjCYboLWIbEwjN6I1?=
 =?us-ascii?Q?ZV5J0dSF6lGcfmcjJGseJPhnEPL3xsYWDavb7kQdIeJT2tT810I6lBuPxsxy?=
 =?us-ascii?Q?xr3IonB5do7moYkYqnfzyJqvYeYzqkbpWcsmqNjhco2pOewYSCx3jgHxmekU?=
 =?us-ascii?Q?DxglH6gEXEeMjLDGMZ2XAeyZWv5qIGeoTLRySYsQ0Y//Yz31lMkD1slIobsO?=
 =?us-ascii?Q?kkimEmP/qAIYwUQeZQIlR+HPIRomiTcKa9MiLtLDQt5GdaHwAFRCxK02dPxj?=
 =?us-ascii?Q?H2x/lrYKqG2hoGopu1u/Fzk5G5lyRK8HrEZtg7onFS7KY+ysq9+nTU431tiq?=
 =?us-ascii?Q?nbyKpnSVNLCbWaf/93c3joHakYumdbVlaYoLPW1/65TnSnRMgCpKZCuRgmp3?=
 =?us-ascii?Q?GcJEVbqhZw7oA+u4GewDpXWk82KPAScPsJw0YE5pSP2iw5AmkJOmkOG5a5iu?=
 =?us-ascii?Q?W8aWH7gyNgPapd4UgcMjP130XmPmHI2fyza/ZciextcKfuzxEVqjUiuwh4Bu?=
 =?us-ascii?Q?En4EoFQIcOx+8IZA6Y0RYbpM3zC7/nDLQjkr6Wuvwspx7CWCpVNCCZRsXvud?=
 =?us-ascii?Q?deXAzfnM2NvXWOLFUplG1Jih4uLYRyp3Qw9oit5CsBVnKTCGSetHin1VVwHX?=
 =?us-ascii?Q?G0npqiUiRMOL2X+cbv/wLA2SqDVrzsHrMZGXqKELT/DpYJXWdHyHaYlAf4y3?=
 =?us-ascii?Q?47Nktxkz5CWEdv5dMs2NOK2fsw1k//PDzpoq7i4utrU7CYO4PVEuZZHGx4ON?=
 =?us-ascii?Q?fuRDvtQHlR5iMQUiNfOkCllfclHZc6e3N24jLRKsUKyaiS0PXs+LFSrddqm2?=
 =?us-ascii?Q?ibPlvaIAmfsylJkOsoIaJMNUBFbHkdXlWj6fhZ8BC7891KzS0Zgql7L0veIT?=
 =?us-ascii?Q?7ixXuRzmv8dGc4QdG4aCP66hUkVt9Yaip6XWVNsPztfEzrGBqHxRReI/JsTt?=
 =?us-ascii?Q?bxr4L1k26ClMnDLa8U11Gja9MMhSn1oqeABqvq8HVkov9hy8+W4vqKPwStUT?=
 =?us-ascii?Q?kPPwsaLPqSCh8Qkol88DnX54W5ymM9AFlOa2SACuLffkb1Ab2F7FMhOdd3le?=
 =?us-ascii?Q?0aQdKS+ls8RKwlM4vGE2KhYkHh8S0/8lb4p2RtXG9nhxiLQzlUya3NS5XHal?=
 =?us-ascii?Q?3O13qWT2WCAlQVxUDFOrJM5D5ldUIR1fb7FLUhxyFEXXHQoX9U1GyLx2bmCC?=
 =?us-ascii?Q?iV8MoG489YIP+S4GSRxgNX+gBrcWyvtCqzmWwHEn+aZZHW0B59C6KpNN/we9?=
 =?us-ascii?Q?22jInVKz7QmuvlGd2zqyB68ZdS2hFAxCmbvF+PKNFSzw/zXcohkUaCBg7BDd?=
 =?us-ascii?Q?9clFXu+sWdswKEXw7r33r0U78pagXUU5jkJ4zCP8fCjc8kHt4yuFk0n6BYyX?=
 =?us-ascii?Q?j9Ioq9Cl4IHodWNQDK251BnXdeJH5oTPMmzNPgSck6CTgZyj/yNSTOwh9Mvf?=
 =?us-ascii?Q?ahwvP+eyb5rPWo91IGCV6bVJ9BIYppyrCvx1FCEs8Fk2D2i7UF7v2ApfF3MM?=
 =?us-ascii?Q?MqnxsqNO9UBoJxyjPa4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ece6345-6a97-489d-db91-08ddaa6b594f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 11:13:39.2941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: twp2+kkJhOSKCfwiphpnY8bYvdPST9Yxmx2GnEuHZl6sB8LshkWLhsW4wBykJjigELsMq5p6dk2Ojcm4cTkBnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
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

[Public]

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, June 13, 2025 6:04 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Subject: [PATCH 0/2] Latencystat optimization and fix
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> After investigating latencystat test failures, discovered it poorly desig=
ned to handle
> bursts and multiple queues.

Acked-by: Vipin.Varghese@amd.com
Reviewed-by: Vipin.Varghese@amd.com
Tested-by: Thiyagarajan.P@amd.com

We tested the changes using DPDK-TestPmd, following is the summary of the t=
est shared below

1. before vs after patch with 1Q: min: -10ns, max: -5000ns, avg: -10ns, jit=
ter: +5ns
2. before vs after patch with 4Q: min: -10ns, max: -7000ns, avg: +5ns, jitt=
er: +80ns

Since we see a greater variation with multiple queues compared to single qu=
eue, we also collect HW Traffic Generator before vs after.
Values we got are ` min: -50000ns, max: -62000ns, avg: -5300ns, jitter: 6ns=
 `.

NIC: Intel E810 2CQ-DA2 (used 1 100Gbps port), firmware: 4.7, DDP: default
Processor: AMD EPYC 8534P 64-Core Processor
Traffic Rate: 100Gbps

Application CMD:
1. DPDK: ` sudo build/app/dpdk-testpmd -l 11,16,17,18,19 -a 42:00.0 --file-=
prefix tr01 --proc-type=3Dprimary --force-max-simd-bitwidth=3D512 -- --nb-c=
ores=3D4 --nb-ports=3D1 --txq=3D4 --rxq=3D4 --txd=3D2048 --rxd=3D2048 --bur=
st=3D64 --rss-udp --latencystats=3D16  -i -a `
2. Proc-Info: ` sudo build/app/dpdk-proc-info --file-prefix=3Dtr01 --proc-t=
ype=3Dsecondary -a 42:00.0 -- --metrics `

>
> Stephen Hemminger (2):
>   latencystats: fix receive sample MP issues
>   latencystats: optimize locking on transmit
>
>  lib/latencystats/rte_latencystats.c | 64 +++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 22 deletions(-)
>
> --
> 2.47.2

