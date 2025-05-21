Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0CCC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 09:20:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDC5D41109;
	Wed, 21 May 2025 11:20:07 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E200D410F2
 for <dev@dpdk.org>; Wed, 21 May 2025 11:20:05 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KGeoJL026264
 for <dev@dpdk.org>; Wed, 21 May 2025 02:20:05 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46rwfghky1-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 21 May 2025 02:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkLG78x4hvinZaKTlrGf+hAfID+uHUqOWENosaBJOHafsbziby6GFEMS84lEqYYGmDelcYVpE+ar3dKNimychsDufTc042AX4ZE32SbJa8JT/gr7BNAxhFB7geKSEahHr2zglATkCbK/ly0BhElMqua8f4UzSnKqbtd8m1K4weEY8EqLfxnl/u5AsjJCxWX12XD47vwUIZ9ZxUpp43SvgYCZs6iuyeY0Lx/GEUocvQxiDGu22wvVfjfHtcZ8SdK5qZuAxuaPS+175Vo7CxFTzbITzi9wi0+l07a4lea6fGHeEeE0cDoA7V7lDtnz5FJjNygLVJ3JF3bQD5qksNsgoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWa6gEQyX8NgqRzJTrnx4VoiKbwVzghAMYFdcCtyi6Q=;
 b=pp255orw7CuQxDCrmBXFUUagNG5g3tb7tHXJBBdm6iUdx3jcsWU6xcA49AP3kshJ4lB++0HmPsYsz5CxleKsYEZ96OvOiA7d/TIq3GnSPr4BDSrewQ404EeJmYxn9xrT7uzpGckstJkaekoRrV5ImACIdTgLGguGu46Zhm20wwwOg09dhwbSmYQf+qmNQrllm4sS11PmTsAkjv+iDZxDbHVVI0YHGtcGenbMPaQhgws31tv2BJRQuilogD7wFVLNyjveU2AE5Wxq8vZMulP0kAjAasRb6599QYklaZiB38vhiKA58ffF1p91P8eS131/8HSaLqmESA+92eKFY7Sd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWa6gEQyX8NgqRzJTrnx4VoiKbwVzghAMYFdcCtyi6Q=;
 b=o6+fWelI43DANIbEfYCfuiONB+v1rmVakfw+EEOFPjoKj83SyqceCdNU6B3pOpbzAZTtXfIcScFWcba869YhNcUJjOq4O7BSJbuI/ZbTBwC0Pl6QfbBN7gDP1yQGgWv51+f3d3aBmc5SalnKl0L+It+beNrPD0WNCqqeVeY9kRA=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB4319.namprd18.prod.outlook.com (2603:10b6:5:39b::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.19; Wed, 21 May 2025 09:20:00 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 09:20:00 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>, Gowrishankar
 Muthukrishnan <gmuthukrishn@marvell.com>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] crypto/cnxk: fix out-of-bounds access
Thread-Topic: [PATCH] crypto/cnxk: fix out-of-bounds access
Thread-Index: AQHbxXApTqvlOWf0hEi7A6vutTtl87Pc1/yA
Date: Wed, 21 May 2025 09:20:00 +0000
Message-ID: <CO6PR18MB448470486B3066001DF883E6D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250515080528.1644-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250515080528.1644-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB4319:EE_
x-ms-office365-filtering-correlation-id: 5c48a9b4-f54b-494a-269d-08dd9848a98d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0DJmUuOjmQjU4gQcYBg96lq9H1P5ZW0VzKF8Dork6q86Vt3bt5ty8CrMKhD1?=
 =?us-ascii?Q?gf1ex0r7wFts1eXIvjCNDsmjMt8MH2rAF859sT9OHlYS3f9ZpmTzfTNFGlaj?=
 =?us-ascii?Q?v0GoUjn066j2dDvadZ2A2j4fepH4/taZ5Q5/sWSUG1X7dXWcLNjRf0VBxhz9?=
 =?us-ascii?Q?uHSCN0z2KFeUsN/Y54/wDJ5z2hIVxgURVszkJJm/lDy5/bLJD6YxzF8ARI70?=
 =?us-ascii?Q?4I7Xstz0wi4xQQey3wXnsZWqjMa0psbajFGn184RPEAzHFDWKoHi0f1CNtQX?=
 =?us-ascii?Q?JlIRG+7t2VkcCiafP9SB1dAySe+MzjmLlNByHSihfnwr5TJUM03phV0vi3KZ?=
 =?us-ascii?Q?Y/xjAo57ufkR6tFt8KCZfPaatVI0tC6pt8kfth71xLnGWDWkjo8bwmSJSPsp?=
 =?us-ascii?Q?00vo81OgbZAU1nDA+ARSNnf2sA4byj52FeANe5wr8/RoqohOjZUywconQAt0?=
 =?us-ascii?Q?SHfgm+AjJtxXkw5xzq8g3+4NHdT25biO/xjD+7Cx5dpsaXWzDKaI+Tz2Xr5I?=
 =?us-ascii?Q?fVixed3Q8T8L5vcGm+Esc7u5QRcgvXoUUOLdMtF1sd3zW/lVdwUVho3PGWsS?=
 =?us-ascii?Q?XAEkTQnRVIEDOkc4fnZnn2yfnP81kNCrdt/dA0as4odAOef1TJUOBn2fDQu6?=
 =?us-ascii?Q?CzKAjUPI8g7jz9Fa9i+War4g2D6OtzcOkJ8yPTZusOx/UBDqBTtatJwwjaqs?=
 =?us-ascii?Q?nAO6pr1joJY3ZDpK5Pfn5K2xA7wFM21dUy9UzvsgJQkADKkOe5Hih/VzcKJ8?=
 =?us-ascii?Q?tZDV3NWO1gYPdmpd3OdO+sxed9n23LDkTUjGJfjCCTaFNiamz54ABvDyjCvb?=
 =?us-ascii?Q?Tl6TwsyPpVaFxEwCUfBWy7Vsiju5sOpg+GcyOeHSPorAn7ReXTQsqM2AQE2S?=
 =?us-ascii?Q?wPOeBDusaFguOmhX4tuw9x+GFurPiC2m9+Joh3QfaCHHwq6MGWT7Bnlswk0M?=
 =?us-ascii?Q?D3zXjQxwjIZ4JIYipXsnifFHRa3tX/EzJyBx6dSaOLDbnSLl0OPyIhvH5d2M?=
 =?us-ascii?Q?4RfyWh1C5w9ozqQ3mp/ytniKihCL9PHO9dMIA0sXARCAJGQTzj+R3moweMGh?=
 =?us-ascii?Q?P6sJsBtxOfSemEoOWIAOCTqYNxQMopiqZVXEYDH4Hw3QKvxY3lxosH7pkPt+?=
 =?us-ascii?Q?yNlf6owUygkTCeh4ZCbeLbJcvuLLH1uSM1DJIhdVwVDlHg4+8QvlMWdUlONo?=
 =?us-ascii?Q?J1AOH2MUxpBqQQoysD4uZOvmLaRCOK9FOYejVpv2UcsENerOq4MOsdQv3MgA?=
 =?us-ascii?Q?23TnK3urXCuJjroG4B5ott8Inzv5f3Pbpg+EVlV5H1TA93+kR7qYw8kU/JjI?=
 =?us-ascii?Q?X4FFNwlrb2C5d98QZqQ/WeNtVx8W+CU74C227OKTHKjZ/zdwG4dvI6raDtHe?=
 =?us-ascii?Q?3r0Gxdxuf5QGI6qBoWT/9cPYhNCHjM8QqgBIvEA9j4ltlhCxwD5CkDELg6CE?=
 =?us-ascii?Q?AvEyksYBuCj2pf4Z9+mR1vxg+RtKJZrLoAEY4BhJ/DgEKhFRSRJ+C4aOUofp?=
 =?us-ascii?Q?GDf4xa0YnMk3Org=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ndh6TWR+N3NERcO4eNhXgqMZHwjJr3cWR1K5UT3kRo1YTwJbFOBaRGIgKhy4?=
 =?us-ascii?Q?99i+JbuYiOHU9cqUtAgJp/+Sj3O7Fjffcp6x8T7ZGbw6pygIn+re50PclXP8?=
 =?us-ascii?Q?ItMFlJnGf83B2Md4OS2ON8T0d/AnV1TnQLB+ir7TOvobjM1KfAUG/Z4qD2nz?=
 =?us-ascii?Q?kHo50CQXZkaXB/Jjwo+zIhyPx1hoxvV9sqNxwFyv/Rx/zsbOTLGeO5G3tC4/?=
 =?us-ascii?Q?uwgfYVDVu80kgeYoqHx2LAecemLMGh7kjHK+ha5md8HmQET5GLQyMvaVHsR/?=
 =?us-ascii?Q?9AMnOlAa/7kgyQELUVI1gmFLl/GaBTKS3zzmjYOg8X1P/Jn5IgF+uAIa6v2S?=
 =?us-ascii?Q?R/OFuY9FdAyiwaiKkSgjwXsnHmQtFQ0zYNKM/tJQGkKIqHhUysYwfbwpXgv9?=
 =?us-ascii?Q?19OAFBMP/Cs364ZPRuO1afZL8SgVqIgpaNNBtHI9n4inIWpis+l9/2plQtmS?=
 =?us-ascii?Q?XNZl6MtCTbM/n0qBF8t2KLs7ErhEGsl9eR+RyNu2QF0JJLP9+uV52Prt0UEH?=
 =?us-ascii?Q?zQ5wTPs0f+ozS0y1BjK2br5RUSFpzhsE53FANc2zeS1tQwhuJBadv7XC7hIf?=
 =?us-ascii?Q?NUEFnXljGVuRH25gCv42zFp+w1kdfYkSGfXWGJme0xX5jjOpctHZvIChFs0w?=
 =?us-ascii?Q?q/h0fJdFV1mwiwd/SW6IfQGnbiaNBw/p/v9BoKD9RVoKhxcrU71JHcM38EoY?=
 =?us-ascii?Q?cCd/zjqSpU1nKlDmX2rF9pOevfSaeIFKAus02+sl4tPt3BuimKrw5/iGym9R?=
 =?us-ascii?Q?+6/4LholXQVuWk4q4kShpN+y12uulVedKTlM+TNd15UBb6X0HinpY3JCFfxE?=
 =?us-ascii?Q?b2CrpjBXNUq37f5Gds1bXQ1+wZI3PQn+WsGTwqbhrO6TznSG+dgdvuYF9C0l?=
 =?us-ascii?Q?k76rXPK/r1ZsVSXetEyHRPMpZX1eX6bBPUnfQEzTLV/RegT3kSqDrnLPBg5V?=
 =?us-ascii?Q?kSwmR15bhWoneVreqwSTBzq50qZ9qvbA4FdGmA9S2f1eHoMXtCdgctPMvfsT?=
 =?us-ascii?Q?2bUxVtNw/z3jE446ccZlDqwqEl8KL0PNTYtVW0KlPWpSvfwGf9txd9HF2IzR?=
 =?us-ascii?Q?hxKqlAmza1RlZJXC6b/xb29nqN/Uw2TkI3ON4TRJw/gXaeg3FqezaattfYXg?=
 =?us-ascii?Q?eXdyeD53kWe16O33CCGl2TXeHXsPV4HCtTLJtA/6xy3T3z48GwhjL35gDOLi?=
 =?us-ascii?Q?qzVO4Xt+rTb2hk6qfhhxyg6DuLwJa54M3rVg3Dm9Rp/eT6Q1axDlV+xpnBW6?=
 =?us-ascii?Q?kveLL0LKcz/BALzoj8CtWAx3Jk/JqyFSIuVZTrj0nQ39mFwwzuZwdlrGAHoQ?=
 =?us-ascii?Q?Nlu2lhzcUcBoCFR2Y7LIws4hx9jmvdVZXhtxZkJJFS7SibIwFacXA6rC/mOK?=
 =?us-ascii?Q?omJqcxLS+ADVOc8k/aU7VO4LgSu5s++N/3V88wA5ztU4Gwvq1mJ5K10MbOg9?=
 =?us-ascii?Q?KjfR055iyLxhW8sicpFfGcl5QRyhs3CSq4Dl7yKFvDGcyzoTiviiWVkVw3tJ?=
 =?us-ascii?Q?IoziJ7i3CAQRflLqVC9iQZryMfFHeERJJoEBoPAPd7QSwWCB5qd431FqAade?=
 =?us-ascii?Q?tGeAMJ5QppfxSQq7IFFwJ7Q7oZQgNaTYVqPg+uhc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c48a9b4-f54b-494a-269d-08dd9848a98d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 09:20:00.6093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5lCM1Zgfu4RVVg5jxX7CL30p0SHNHDqEqqJwpoIP3Y0j0At/yObysXDejXgkEDQ8I6LsYnzlvzZHrepjvCemQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4319
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5MSBTYWx0ZWRfX8rTRKcfg4TrL
 05CCgzOGPdb/+HGTHNFSKmBHjwRsHYLwwJc1w+QrwOM50sPPz/knxZfJfiXypaEr9nmNBPWsFD+
 VBDifKZueo8KuQtxf8sNX+gTUhtgu+9jATop7vi6QxRBRpt4pFU654mYmOfB+mhvB9tUEK02wXJ
 Z04G/pFQ8asZDA1zSX1VBG9FaFsMRyeDobTyvgjeffda+vSXZSU5gMuEQAfwyPLUlIs78Faivme
 ijW1aHgJBCemxo1Ht62TW1/SwMffPE5J2WUPi2Q3uzP0r3MwNKAjfnaP6oTokGSGOxp5P+n+kGO
 pdhYW6WqXSu578w8PxyJCUOg2656SYOIBXJLwJ0PyeVzIpg8kMqRAm1Wg2XB2Zt8EloXxJuo5ah
 G/rJB8KpozRehl+kIfyjlYGX1WBX9F/3KTGHajVXGJgzeUD+oB/c8EAvlAHstflaiHu9Uo9c
X-Proofpoint-GUID: s9ixGz4Rs0oY-A__M3xeJ0036J0QrSV5
X-Authority-Analysis: v=2.4 cv=T6OMT+KQ c=1 sm=1 tr=0 ts=682d9ac5 cx=c_pps
 a=OxY2RB2sa7x8oI2LU21LDQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=Vb67w2sNFfI9l5vuy0MA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: s9ixGz4Rs0oY-A__M3xeJ0036J0QrSV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
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

>=20
> Fix coverity issue on out-of-bounds access.
>=20
> Coverity-issue: 403166, 403171, 403172
> Fixes: 5686b573e4b ("crypto/cnxk: support SM2")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
Thanks.
