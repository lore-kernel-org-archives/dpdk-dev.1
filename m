Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B2FC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 08:05:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7659E402D8;
	Wed, 26 Feb 2025 09:05:46 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
 by mails.dpdk.org (Postfix) with ESMTP id DBCFF4027C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 09:05:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xdvz1k0MlAix9hUywqbpaDbSLE3LSUo+TOItPKdjDznifn2C/9jT2xjavGgMYllpo+ojnO2CdSQ2O7Dmri3lhGklU6RjQ34BNLx1MhaAS6a3f5fLdNkS8XsDDSm+vJPcsekLtiU0B6sYvirC3wUUu7VtqcBDTXEZX/pNv/on+WttGoZ73RLhwRRVqfjsQV4TDZZJODtAW2xi2xTNyPQAr8r2INjPLPQML1VO23RVC3e1yi9QnQeKGy0ZkayM0Af7opyQ62RNzgiISc9YEjbBqw7dnWzeQHkwJh6vIALDyHlWd53fqShD5sLhfMiccqsv6FscfmuMpBU1ghXnBqTvyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1FIUqBiWxBZ2uSIgkhxwK+VEwJjrqsMNHWTZ0uaZ9g=;
 b=j8l+G0N9RyKC2xVEMpmsH4F2fUn46EuJ/IwdsA2NLF8t3Se0iL9z3Lw7Nes9KQumRmh25q19tZznuBc9/aqnjk+iaGnIPL8Fvd9a0C0mGyQiRXWbqOjK03StJTf4b0xwVkgFYP9zDGCAOYQVjhGSAe4vckiYrvYASpGqo4d8qfrbfKwkzEpdOGA9Ux4lbPhonc47cV9/fMyIYnqAq5y/Cq33fkxb3uQShrjDm+RucBN+13/2HzQeHOO4CC1gCB64H4dEyipcCtl4y5TDghiyfMZUjYerkD/dpZR8+rYgHZr37qgEX1ADABvGlZ+lzKAyNcVFcazuxxCyI1Me+VTmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1FIUqBiWxBZ2uSIgkhxwK+VEwJjrqsMNHWTZ0uaZ9g=;
 b=b66L6V61QW5+4McpN+/UiZJDwVnce9yl1R2a/WDvCaARPDl7DX03oQxZOASXqFzP29fLOSHH7L39CfHLzHz57FaeIJpWopy8Q9NlfICG60F4Yx+sXPZ8zAShE3rQbQNObu/YGvuk6NvwBR2cj4KR2VQ9fEnw+esi+cUmoA5UvbIIS+Tk9ASQzaizkG9yOy67UwV6Yp7hhTRa/foDWiGGdiUsoIbZY++ykGUeq4tixF3XUGMb4cQzZPylefagNoEf9fPhRkKCzfM6k09hNnJF4foZIZekhlH7A/geKcniHnl9c6z64NJB2m109ZqFqGFGvUcfg6nDFp8caP80TKbIrg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Wed, 26 Feb
 2025 08:05:40 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 08:05:40 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Shani Peretz <shperetz@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix queue counter error check
Thread-Topic: [PATCH] net/mlx5: fix queue counter error check
Thread-Index: AQHbh2TzjncJZu/7b0mke1z74nPVR7NZO4qz
Date: Wed, 26 Feb 2025 08:05:40 +0000
Message-ID: <CH3PR12MB84603C59CCB8DEDB05BDE067CFC22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250225090845.136968-1-dsosnowski@nvidia.com>
In-Reply-To: <20250225090845.136968-1-dsosnowski@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|SJ2PR12MB9191:EE_
x-ms-office365-filtering-correlation-id: e30dd0f0-1725-431a-5732-08dd563c5c65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rt7xvo1ZWCAbYGHNVuV+5/IuPK4EXHKjp/ZSh81+0GApUIQdQuRpM+rIQQ?=
 =?iso-8859-1?Q?vUuemaZmwB8q/oHy2HmV2JJNsikPTHkmIp6DjwWcBJXPx8CG/hjZvoSAIi?=
 =?iso-8859-1?Q?hCdKXqz2/u7+45+CEYHV1PVPPpS18MY4jFX7dDa8Y14/ZUhaLoIJ3hBu+S?=
 =?iso-8859-1?Q?bv4uLHU2XH04H+5jP4VuwheTA26U3NOc6rvn3+xjnn5Ya9bJ8LniDpR0zO?=
 =?iso-8859-1?Q?odobCfDsDV3vCH2k6v7H+JcHwL+HLWLzE5zFG7CJzNT0wFpsBNQOau8lnn?=
 =?iso-8859-1?Q?KGXydtXzDiNI9Upa6OtFIAYaPu6MRmuIU6lt80iysM/fX7jIIzt+dSZIdf?=
 =?iso-8859-1?Q?OhLMa+8a6zRclGm03GeitjzYz20SjF1/8anr+lEfIjx3AAFU+IcVOsPsAm?=
 =?iso-8859-1?Q?Vi530OHNKz9JThpAQzVkQ4h2KFN342rIQxurJf8dQU7vbl7Um7X2zJByD/?=
 =?iso-8859-1?Q?iCBMA2iGTe2Iwlea4UYIfmJp7C99no7xCl3Joe0iljE5i+4psXhmbBFL7w?=
 =?iso-8859-1?Q?nNaLDnToY/W1BY9TD5s8iT96hEdPxnv3sdhlOnt2ENshXIlWGGxXP28yEN?=
 =?iso-8859-1?Q?A+BV/wxZZCK9jExKMPXBaa1zt0GyD7Is5qzz27VEpKXZU7u5N8g7Qi2xjF?=
 =?iso-8859-1?Q?TTk6q1XKRQO47sb7bd/Z1w7WX8DuJyvBZamgJOu84hz4usZ496hfDVDqS9?=
 =?iso-8859-1?Q?m+70LlB30NFwO1+4MRXYPR+aVwbN6o0g1J63pVpw6qCoDN0Vx238vG7cF9?=
 =?iso-8859-1?Q?xc7pUeilqgz1CW9lwXtrRuhzIfa9GlPkViFps9n5CyfjTyuh/0wXnPdavU?=
 =?iso-8859-1?Q?E1axVg95v0jFDBczQjV387sfsmD4q3QQdj285XKbKPRdsdZH53d6NSWvCr?=
 =?iso-8859-1?Q?BpByoqqq3o/IJaUMo1FPEpoClxqpakRnzZYYrsXqGvcL3JLhQSNsejLIrQ?=
 =?iso-8859-1?Q?rAVy+Dt8zDZQEf8Mfn3DxghiZS21SkLql3KyqSQ7EXwsGTkA4XFWWfexnH?=
 =?iso-8859-1?Q?708YxP7wEvkU0ySAxASYWBccWXnWvTw6TD/tjItry5kisTT6mteZ+8UBLn?=
 =?iso-8859-1?Q?lyh01n7N5AtzWTikpt/yreYfGjR+aBhgTC3DVzIsw/KW1P/0/WA9qgV/4/?=
 =?iso-8859-1?Q?WSv/0mz7ZeWL61kw1jjuOF0rNvQ1OkwP9i1x/D2iZEwqUNNE1q8n3VqLav?=
 =?iso-8859-1?Q?lDs4rlrzhYlnOL1luXEYFvF+2AJas32SUE3Mu7AtmCz8QEhrs36i1DDGrv?=
 =?iso-8859-1?Q?vpubPpERTx5PCk2SjJ75k9Rvc4cX52q8piUynP8UfA/7wGSnIFbpFZbMgb?=
 =?iso-8859-1?Q?kJh+Pt3pof0r8uNxKQJOUa4LW7HwVfoWArk/GzxEEMQKAG6998Gw52TEY+?=
 =?iso-8859-1?Q?LEiaNGZjt/PXDFTl/ayVQ7Z5X0e+UvmQE6uKmEUh515ECG1dTTRkc2p/gL?=
 =?iso-8859-1?Q?9StKA9XAAS1Zm2CJiNKocuJk9/NKprlfb6mDuuBwrAfyLmWtuMdOS0fcuC?=
 =?iso-8859-1?Q?/5K+KlN5hy8j1W4MLiY0Z9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3SUxbGSG77TpNOuoc1DeGaPJ0k0OWFzGDQOYgATYfzO+lCMU1n+XOO91/h?=
 =?iso-8859-1?Q?yKjkmfnSKsg4k7irbwmQ/DSKmG5arEQxRK0Zb8TEHTUS0dSm7iT6F1uVUt?=
 =?iso-8859-1?Q?8p//miznlmIuHaDVfdsX0Bo9SDzjUpNshkU/y+meORyEudjmmeW2DHPa0H?=
 =?iso-8859-1?Q?9nw3On3ZeYJxCqlDrNGFdUjhpVA0opuNaAZY8bbyaeicP7m8t9xmC1JaaW?=
 =?iso-8859-1?Q?1U+qbnhpuI7X+nYJlPtO0HQ87cdpXGf+7KvbvbmnaPxOg6fRgr9AKOSLdy?=
 =?iso-8859-1?Q?6NW3zosG2DM1CaWal1m0KIFvg5Xb46t0Mjhbb+d/r96GOJ+xtngH0LzKW8?=
 =?iso-8859-1?Q?YqI0+D72coucFnBASXet583d8rFHfcW52+oYb/gFQO6jLVx48ZPL4NDriC?=
 =?iso-8859-1?Q?3mWpbovABpbikIh2OCOtS+8Q48UZYorEHi/gCEXUSoJdA59ghmQATtD7HY?=
 =?iso-8859-1?Q?eZA9niJY+GMI4JRBE8/ZBcANIMz+4t7j54IfQmgdLgl4Q8dcFGSVtX/KYU?=
 =?iso-8859-1?Q?3nRDk4MkCcL6MyGSLZIKgZZftKsKdGB03t2sqAdqDlj2jn+zNY4IDfccM7?=
 =?iso-8859-1?Q?5FPZg/OxWp9YgUnTtfz2uvE6HmLs3elMuVnK1pvoS/IwxMO+20h5bx7M2/?=
 =?iso-8859-1?Q?VE84B1oGBWa8C3/oo2FQRNJh3Z9CLmLp8jVigmeP7ALhUMi4ZXrBGyCgjW?=
 =?iso-8859-1?Q?mq1secxMNdFfW5g0J/7R3AUlDPdyr7M66H8ZwYIfTOjrEX0ANLD8zWRr2q?=
 =?iso-8859-1?Q?vBiDlnUM5tJPXz7vOeacMGrVjsGXCTiSdgUmwCfMOw3yIAHZP6XO1IOhgX?=
 =?iso-8859-1?Q?XlJyjuQWtnJQOhP0fpfuh1H8yccPNHx6Z3W0r//g3m+8qA4bw9RgpEjnti?=
 =?iso-8859-1?Q?N4SjlWMdP5eem3trP6o4AFX+VtKF6ytFd7nst8kJto5/J1jAkFPSuF4+lo?=
 =?iso-8859-1?Q?ukB+6YwdFfZfxe8XUsfd5A6dLi27OPaU5YkWLtHjw7ROl8ots2D+Mq/5Ye?=
 =?iso-8859-1?Q?aoDWzHzi+CatMQyqY+J2bGPDoG8Dq19/0//UVddFKTYfN11pMBOm/KEzo4?=
 =?iso-8859-1?Q?TLVRF8saWmUJT0iain7weCwBjDvRV9iVQGgHYh+ionaU2gRu7HLrJHhmCq?=
 =?iso-8859-1?Q?IqnmPjP2XkgR2jJceQXGs++ARclH3CbBAomjAmOR9q6WmoCJfUjAmWKqIN?=
 =?iso-8859-1?Q?22kmzQ5DTYS/xRVwVtr36NvRlY2qqY61YHCX1/r1HVzaw36U9eJ5g8FEUa?=
 =?iso-8859-1?Q?skpNLvDJiI4SeD2o6E0+sSXXciCz0MVC9FHiWvvtVVESEPGvj1bSMLWmSO?=
 =?iso-8859-1?Q?9Al4SC30yh2JBYx/7zEkKYP51Umg26zUvirTCoB7nsmo76CXoQ552kA+xg?=
 =?iso-8859-1?Q?OCLJOVAbGEmfLeg8Kyt8GURYTVAy1xhIhb3FqETQLPhyHvpwCh2qcciwWQ?=
 =?iso-8859-1?Q?rhtQrOdkHdqMgv97A9x72FpBemhg/ytyzjzOXtkxMw3L2zekDx4T0kvu/M?=
 =?iso-8859-1?Q?0FjPElWuWAmaovXa/kX+D4m3HEmISPnIDxqSMeVZLowW0gkWvFFJd4/Lfo?=
 =?iso-8859-1?Q?tA6K3EFLJ9S2r+jcTmb1xVLt2qN8lgKdrgQ+OXS+huxS3LC8uMrTl/0eB7?=
 =?iso-8859-1?Q?v9tBcck5u9h7E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30dd0f0-1725-431a-5732-08dd563c5c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 08:05:40.4369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EtImRlh6eGzy5lgbCCmpZcCV5gBglGvvQczktfaVe99noes3nx6ziToWUXq9EgLq5iL1etwNw9QNAEep+RdTbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
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

Hi,=0A=
=0A=
From: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
Sent: Tuesday, February 25, 2025 11:08 AM=0A=
To: Slava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; Matan Azrad; Shani P=
eretz=0A=
Cc: dev@dpdk.org; Raslan Darawsheh=0A=
Subject: [PATCH] net/mlx5: fix queue counter error check=0A=
=0A=
Whenever queue counter allocation fails, the FW syndrome error=0A=
should be checked to determine if maximum number of queue counters=0A=
was reached.=0A=
=0A=
Fixes: f0c0731b6d40 ("net/mlx5: add counters for hairpin drop")=0A=
Cc: shperetz@nvidia.com=0A=
=0A=
Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
Acked-by: Bing Zhao <bingz@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
=0A=
