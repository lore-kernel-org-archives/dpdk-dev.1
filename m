Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A224C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 13:11:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7591340EDB;
	Mon,  9 Jun 2025 15:11:31 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021091.outbound.protection.outlook.com
 [40.107.130.91]) by mails.dpdk.org (Postfix) with ESMTP id 3010E40ED8
 for <dev@dpdk.org>; Mon,  9 Jun 2025 15:11:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxhFN8VjtwoqlduLVsX33ry+6sLaYOaq1thRSvhrZyY7pID+AJbQ19BNiVpQ8Ty9tQ1++eeWwxTfMoUknzbaeS6gTbCHPaOfxxMN9bcd7cQGEZkuZETqMcazm88BPybqDdP4G36TY75Ynmybf4jMfs+ElQNXGq+kQmYXYjOrFQybDNpjZrul2oFpZGHUr7oXZyK3l/2Yk/eKD0tU6kbskdb9ZHOtDLv/O3GxfR41M/BqX/gFQu4jIdE/9YodPfMgSyxm4vu7ftKVsGPeO5JPvJge6wGncQtmmkemG8IW07cDtsKNbTzjFIc8w11mdzHyQHtHXY0/5jbSxN6UZR3xCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JGv1/mEte4B7c9GhZIN0jyO6z2TNkG+EER6nLQ7EDU=;
 b=fbDZhB0rHsQzW0b4SNweIrYwbVjuXd3zXwX/Fs3+Ln/JeTmZdbCvZDVzjXqusJAdPdw0t+XiKlT/dfZQkGSxQmcAgxRPdD3sVXCLHbLMFHgG3+vQRWxFUfpfNmGRvsAhlDruLTD1G1rqNbyqitVkOjhwA1LIvpRttnsC6zzdRL7CaH2RO22ztTI69WrPvXHEIESXIei/W5aylto7j6t0m2nYTP2lM0HfcyYTw7kISs+PoTOl0a+GiOSxHtjFLse5IHWRB9dnKHwi7BjHx7lZWeG6011QgG+KTjfvitq6Z4o5wAtBOP3lGCXGW9esW4rKI08b1uR7w9yoAFuCJkWC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cgstowernetworks.com; dmarc=pass action=none
 header.from=cgstowernetworks.com; dkim=pass header.d=cgstowernetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cgstowernetworks.onmicrosoft.com;
 s=selector2-cgstowernetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JGv1/mEte4B7c9GhZIN0jyO6z2TNkG+EER6nLQ7EDU=;
 b=e3IskJGNSRFXMzafJVlo8BjdMklG165QBkAjtHfMC6sb5DAAzfqRnF8tDYCE63meIBTSxPNDiO+/VpYpLdaEMZVC+iSRD2z9ZH6fXWIMlmXHYpOmmXDoe4kGlXH/BbMxRNZ5r5O6iUNlb5g0k1MOUb96v+wgsQ5GmMH4mYKtyTM=
Received: from DU2PR09MB5486.eurprd09.prod.outlook.com (2603:10a6:10:27b::22)
 by PA2PR09MB7708.eurprd09.prod.outlook.com (2603:10a6:102:414::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Mon, 9 Jun
 2025 13:11:28 +0000
Received: from DU2PR09MB5486.eurprd09.prod.outlook.com
 ([fe80::a8b7:d0b7:ce2a:24fc]) by DU2PR09MB5486.eurprd09.prod.outlook.com
 ([fe80::a8b7:d0b7:ce2a:24fc%7]) with mapi id 15.20.8792.035; Mon, 9 Jun 2025
 13:11:28 +0000
From: Yogev Chaimovich <yogev@cgstowernetworks.com>
To: Maayan Kashani <mkashani@nvidia.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix transceiver warning when not exist
Thread-Topic: [PATCH] net/mlx5: fix transceiver warning when not exist
Thread-Index: AQHbvbYIS6Ux7qfBtUOA8dJvuvvxhbPb9EsAgBbNOlCACEK3Nw==
Date: Mon, 9 Jun 2025 13:11:27 +0000
Message-ID: <DU2PR09MB54860A76C9E7A1CFF4A00AF0D66BA@DU2PR09MB5486.eurprd09.prod.outlook.com>
References: <DU2PR09MB5486574FE72A43A09A323DCDD68E2@DU2PR09MB5486.eurprd09.prod.outlook.com>
 <20250520114904.6570827f@hermes.local>
 <PH7PR12MB701839586EA3DA18CB3E3D45B26CA@PH7PR12MB7018.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB701839586EA3DA18CB3E3D45B26CA@PH7PR12MB7018.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cgstowernetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR09MB5486:EE_|PA2PR09MB7708:EE_
x-ms-office365-filtering-correlation-id: ed609eb3-2e2e-4ed8-b6dc-08dda75724f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|13003099007|7053199007|38070700018|8096899003;
x-microsoft-antispam-message-info: =?us-ascii?Q?5h7rLbE0gaNMbhmLyjV45SRjN+MesxQiQlRe1y35mGCRtwV4+3pmXWcy/+X8?=
 =?us-ascii?Q?Pi7Nq8iWNJ+UGORTIuzA/gMf31OMTwmDb6/8zvC/grTCUz5mK1TJsTyS9J23?=
 =?us-ascii?Q?VNJMGL+IZpXsNaCvMOH647zQjKBgO6p9UdlXWuHT1Kjs3/7YTIWL/h4byfL1?=
 =?us-ascii?Q?I2Qv4CbCur5TDfOpnvriBHHABv/82TQeGjQbJ5LIoPXsMws9DYRHATqZP7B7?=
 =?us-ascii?Q?SFgUiS00Nym6Bb7I1GY4cYbuqe7O23NSGUWYmNUvDGpKadXYH0YN6Sl1DMBC?=
 =?us-ascii?Q?zTdnwVRL4fkxOyGH2Qe3EFRhQnBH7/H4d4452bqEXqm0IHpiJgmrWviOJq7i?=
 =?us-ascii?Q?FdkJfgTKQFhch9F544JVWMtyfqU/tn0qvWItHr08cuwcT95KYFw/h1RgnMsC?=
 =?us-ascii?Q?l8KzyKQG+93TxSKzyWoWrlVbXLuZv8JI4Az/dbYsRG7Ot1G6aruu2yBGY8aY?=
 =?us-ascii?Q?kRyUWfEqdogqoK5Yg1p2O1EydwKT9BUScRe/CdtuoTJczEo5zTBSAJmBJEgD?=
 =?us-ascii?Q?Wf5PMBBrkJTATilJ1ZE9zv8AZCMdtLZEdNV7GM4sjSdLkJHxRvQKzp/n/nA1?=
 =?us-ascii?Q?bTwjAKO0AAnYvDBGQhXM4dJdDNMdwXQy6bJL9xeoRCZnFugh+oZmEY9Wte7X?=
 =?us-ascii?Q?UoassSDbwtB8mzl6TZyj7WFXG4++WYDZaqYlhN8BwWmXeyDLSpzvU9apxhBy?=
 =?us-ascii?Q?a7a7winkqQNAJR4f+qz8UCmbD32NFiAmBvyKY0khgLiR+4uVxADntbJq8MTM?=
 =?us-ascii?Q?vfV0wd1v28DcKjhmynCzlnPDXUV19yvJDEfAjOAvSG7eBrOcNsVw1okQ55JZ?=
 =?us-ascii?Q?grTHuhOAbOxHTjl0WfnV8bZsE6Uc8ceLIoRTDzMZw1dan+THVXXMHJhX6CK8?=
 =?us-ascii?Q?OZuaah8g6SIBFIh3yfhEhjNqh8y1I6wl5VdDfxjBEHLEropbQvXiuWuLvKx3?=
 =?us-ascii?Q?0I0gMh+QF7ogK/REQ/waSEI0BHDrXXID7srleHTV+FEpQXDY2lh4bJ3UPJTp?=
 =?us-ascii?Q?6fFQbmRwk4zvYMEX+BMBlcjjP7gby47wGXgil2TsfDIJ9o+jRORpEyfL5ZWS?=
 =?us-ascii?Q?hVn8KvomNejM8pnZo/eiyJhm7XyhpCAy3dY1Ih5syPI+xw0X0giF5wYUQkVv?=
 =?us-ascii?Q?pYN3bix1BaALZRfyFPXRORZ+xVCatMgn/D78aIFS9IGnrpZ8fg1MYhIWSWsg?=
 =?us-ascii?Q?NsCqE9Htdo3+hOeynrf4ctgUEJxlW9eOGd1GA7xv0NvybX3+MQW1/L2gdwfX?=
 =?us-ascii?Q?CfOC3HVPQq09YWxttaKfN3WfgOHz6dJWqpP04XaqRam8J6L/ia9bXIR8vQDK?=
 =?us-ascii?Q?y62UfhTkEg0bJDiD+72SZ/EfSKOoA5xPDIYe7efK/dfol7lXa2F6ASpJBYhk?=
 =?us-ascii?Q?T65yQyEZEwYhXokGolwy6D1Io0wVeHW/aKN1vHnPGnSGEwvsUeGAixRNxtd5?=
 =?us-ascii?Q?XssLv8fAmTM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR09MB5486.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(7053199007)(38070700018)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7gWgXpBIf+gbSTAwC/Ulr9/OjkKldKDyHHabMZADXZFjqiwsU7S9/X8xb+1K?=
 =?us-ascii?Q?6ScWvp5lKtIpZvTyjEi9bWvUAkWoCCGpszrh+ocJjp+QvTuzz+U8Byo8DPww?=
 =?us-ascii?Q?oAQW+3nhrD9WG5DbjLoH/s1MFwfuD1r5jZTKP9JDxDejVP2DlFiRZ05q76jj?=
 =?us-ascii?Q?LAdpGYL3u4tcmPVY2e5CEvCDDVTiCZNHTQG6HBqzaBzlbGnM4nCv0gf7S1cW?=
 =?us-ascii?Q?RI3LYR3zOJ/lmZs7q3vnDG3afVSrH0Tv9kg5zVLaHM93zdX4W+5LCu6lBq91?=
 =?us-ascii?Q?QmpD4ijcW5oS5M90JrgCnqYi8u39R6ZsKVWxf4T7utQQ+jlEdkzB73wB0leg?=
 =?us-ascii?Q?xakYy5R5xE129dbNxaCDnVHl/8JlbNddE40h5jzRgPHebrCLNr2cJ4dooP3v?=
 =?us-ascii?Q?X9ooy5KfDXV1uExpUfnzbWzcmGFBmxSg+wuiDVQKNG46pihgAy0GhZVr6dzI?=
 =?us-ascii?Q?xH4dsSIOzisIvMudrlGbxjwY8q34uRvdb9YwDDUoPdZ9F8//cJq13nxCm1k8?=
 =?us-ascii?Q?IaxuurBXfU+ZFlgLgp56LkgJUmW8iA7DxR3Y1QA4AHOK2w+XleHts9BkSEwt?=
 =?us-ascii?Q?pbkwu3/TrkHi0WP3dhmN4MeooiOVzfhpkwuowCkpR+y6gbQS21YBzRAPb7hE?=
 =?us-ascii?Q?iPJDGJEsO3EAMz9yU6EQMGXxquUj91GfprAUgFXgoHnNPXMW9TVvS8XuBKZ9?=
 =?us-ascii?Q?lyN0tq6EyGgCDtjyXfX2W4Wpm7HNE7uIZkv+tGwKlgRXQuaWmaVJRF/+Vmva?=
 =?us-ascii?Q?asWQMW2YkedFUhy7uF9gUQCRWimJIyo6YYqLJY9DJnjhYKngKRPDZyvWzjIT?=
 =?us-ascii?Q?donYcd0N6iOKJsRqMk7jUgjXUUzz1RImDFX4ano+ZLuoRfVBWtd3J4rNgVhk?=
 =?us-ascii?Q?w6xhvHaWAiYrFmkRMaPqtbthHS86iXiLHv9/EC7EDmKSRKDh4T4Z6FIfQPQZ?=
 =?us-ascii?Q?ODx4tAvK+c/kI2KRJrtZ6mFoNLcYYpHuHGCxej2CJ3RdkUR63qe8u89a+u+0?=
 =?us-ascii?Q?zxxPIgDCURbw6QiswW69BHTBfXl2rq4T8IuPgyuQ431HP+pI5gQ5ELS3eOsB?=
 =?us-ascii?Q?HO6XPAU7chPuyQkNu3T2As5+1Zj2ifS+zQ+4AXVvFsa5+hFHsonN0w31KT4P?=
 =?us-ascii?Q?WwC245o947CV1QO03vP3O2LOID9i9HcB10+hIp67EgSFcrNS/H/iCeuGKVev?=
 =?us-ascii?Q?msQlfhg81dxQ8v3/1ngq4UVisRyHWmLuCxP8pzaJ9SJiTfKfTWtfOhdIEvO/?=
 =?us-ascii?Q?sPTdfKAmIpPEufxq/QwAXB2RSez4AzVb2DSbJ3ywMypLsU/VTRD2kYHeiJGf?=
 =?us-ascii?Q?k0y1u3Y5XGj7xMs+toTSmn+kw7b7BJALbyxvb/YYfdP20uH0zp70le5wdT5m?=
 =?us-ascii?Q?/32WXBQQ6UWM6DNuO7r64U9D6XtXzIOdhsc+AXSGbcyXtDz6/Go4GETe7WcB?=
 =?us-ascii?Q?qW0ZxgEcj39PXiF7dzRsz/6bkgP4h9lYIv/NVILuW+lZ9LgY836r0P3PauNW?=
 =?us-ascii?Q?JGHGecZN5/5GqP21mKuVkmvF0PrJMtgHd7MimQbH6mIfLgFv0YhcKWuPeuGo?=
 =?us-ascii?Q?SQmpH3f86Vu60mRLzatBfsniZQqbWjksR3E/5Z37?=
Content-Type: multipart/alternative;
 boundary="_000_DU2PR09MB54860A76C9E7A1CFF4A00AF0D66BADU2PR09MB5486eurp_"
MIME-Version: 1.0
X-OriginatorOrg: cgstowernetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR09MB5486.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed609eb3-2e2e-4ed8-b6dc-08dda75724f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 13:11:28.0120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fc9e9498-07e8-4b82-b4cf-365bba23cbbf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hb93oCd76RMxXJNslb6e76SyfrA1treeQAyo4aC/B3rsGVClqsHSM10noYxU04ayCOWGhkiK+IZ5/VvYSndteA6z03EgygqEjbt31dZP08k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7708
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

--_000_DU2PR09MB54860A76C9E7A1CFF4A00AF0D66BADU2PR09MB5486eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
Actually looks like we're going with another workaround, so I might not be =
needing my original patch.
Also, I do not understand how my patch (not printing a log) makes a test fa=
il - I couldn't find that test in DPDK to verify. I'm not that familiar tho=
ugh..

Yogev
________________________________
From: Maayan Kashani <mkashani@nvidia.com>
Sent: Wednesday, June 4, 2025 10:02
To: Stephen Hemminger <stephen@networkplumber.org>; Yogev Chaimovich <yogev=
@cgstowernetworks.com>
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko <viacheslavo=
@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Sua=
nming Mou <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>; dev@dpdk.=
org <dev@dpdk.org>
Subject: RE: [PATCH] net/mlx5: fix transceiver warning when not exist

Hi, Yogev,
Thank you for contributing,
Can you fix the failing CI TEST?
https://patches.dpdk.org/project/dpdk/patch/20250506133107.4432-1-yogev@cgs=
towernetworks.com/

Regards,
Maayan Kashani

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday, 20 May 2025 21:49
> To: Yogev Chaimovich <yogev@cgstowernetworks.com>
> Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan
> Azrad <matan@nvidia.com>; dev@dpdk.org
> Subject: Re: [PATCH] net/mlx5: fix transceiver warning when not exist
>
> External email: Use caution opening links or attachments
>
>
> On Mon, 5 May 2025 12:14:51 +0000
> Yogev Chaimovich <yogev@cgstowernetworks.com> wrote:
>
> > From ffe666291bc531b89620cc28a7b45fa209700f35 Mon Sep 17 00:00:00
> 2001
> > From: yogev <yogev@cgstowernetworks.com>
> > Date: Sun, 4 May 2025 23:11:46 +0300
> > Subject: [PATCH] net/mlx5: fix transceiver warning when not exist
> >
> > In case no transceiver exist when trying to get the transceiver's info
> > There should not be an error message from the library.
> > The caller may print an appropriate error message using the relevant
> rte_errno if required.
> >
> > Signed-off-by: yogev <yogev@cgstowernetworks.com>
>
> Signed off by is a legal requirement and must use your full name.
> As in:
>    Signed-off-by: Yogev Chaimovich <yogev@cgstowernetworks.com>

--_000_DU2PR09MB54860A76C9E7A1CFF4A00AF0D66BADU2PR09MB5486eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Hi,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Actually looks like we're going with another workaround, so I might not be =
needing my original patch.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Also, I do not understand how my patch (not printing a log) makes a test fa=
il - I couldn't find that test in DPDK to verify. I'm not that familiar tho=
ugh..</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Yogev</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Maayan Kashani &lt;mk=
ashani@nvidia.com&gt;<br>
<b>Sent:</b> Wednesday, June 4, 2025 10:02<br>
<b>To:</b> Stephen Hemminger &lt;stephen@networkplumber.org&gt;; Yogev Chai=
movich &lt;yogev@cgstowernetworks.com&gt;<br>
<b>Cc:</b> Dariusz Sosnowski &lt;dsosnowski@nvidia.com&gt;; Slava Ovsiienko=
 &lt;viacheslavo@nvidia.com&gt;; Bing Zhao &lt;bingz@nvidia.com&gt;; Ori Ka=
m &lt;orika@nvidia.com&gt;; Suanming Mou &lt;suanmingm@nvidia.com&gt;; Mata=
n Azrad &lt;matan@nvidia.com&gt;; dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b> RE: [PATCH] net/mlx5: fix transceiver warning when not exis=
t</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi, Yogev,<br>
Thank you for contributing,<br>
Can you fix the failing CI TEST?<br>
<a href=3D"https://patches.dpdk.org/project/dpdk/patch/20250506133107.4432-=
1-yogev@cgstowernetworks.com/">https://patches.dpdk.org/project/dpdk/patch/=
20250506133107.4432-1-yogev@cgstowernetworks.com/</a><br>
<br>
Regards,<br>
Maayan Kashani<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Stephen Hemminger &lt;stephen@networkplumber.org&gt;<br>
&gt; Sent: Tuesday, 20 May 2025 21:49<br>
&gt; To: Yogev Chaimovich &lt;yogev@cgstowernetworks.com&gt;<br>
&gt; Cc: Dariusz Sosnowski &lt;dsosnowski@nvidia.com&gt;; Slava Ovsiienko<b=
r>
&gt; &lt;viacheslavo@nvidia.com&gt;; Bing Zhao &lt;bingz@nvidia.com&gt;; Or=
i Kam<br>
&gt; &lt;orika@nvidia.com&gt;; Suanming Mou &lt;suanmingm@nvidia.com&gt;; M=
atan<br>
&gt; Azrad &lt;matan@nvidia.com&gt;; dev@dpdk.org<br>
&gt; Subject: Re: [PATCH] net/mlx5: fix transceiver warning when not exist<=
br>
&gt; <br>
&gt; External email: Use caution opening links or attachments<br>
&gt; <br>
&gt; <br>
&gt; On Mon, 5 May 2025 12:14:51 +0000<br>
&gt; Yogev Chaimovich &lt;yogev@cgstowernetworks.com&gt; wrote:<br>
&gt; <br>
&gt; &gt; From ffe666291bc531b89620cc28a7b45fa209700f35 Mon Sep 17 00:00:00=
<br>
&gt; 2001<br>
&gt; &gt; From: yogev &lt;yogev@cgstowernetworks.com&gt;<br>
&gt; &gt; Date: Sun, 4 May 2025 23:11:46 +0300<br>
&gt; &gt; Subject: [PATCH] net/mlx5: fix transceiver warning when not exist=
<br>
&gt; &gt;<br>
&gt; &gt; In case no transceiver exist when trying to get the transceiver's=
 info<br>
&gt; &gt; There should not be an error message from the library.<br>
&gt; &gt; The caller may print an appropriate error message using the relev=
ant<br>
&gt; rte_errno if required.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: yogev &lt;yogev@cgstowernetworks.com&gt;<br>
&gt; <br>
&gt; Signed off by is a legal requirement and must use your full name.<br>
&gt; As in:<br>
&gt;&nbsp;&nbsp;&nbsp; Signed-off-by: Yogev Chaimovich &lt;yogev@cgstowerne=
tworks.com&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_DU2PR09MB54860A76C9E7A1CFF4A00AF0D66BADU2PR09MB5486eurp_--
