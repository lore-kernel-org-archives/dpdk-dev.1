Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B918C7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 11:48:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2C1B40E01;
	Wed, 25 Jun 2025 13:48:28 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4E09240DF8
 for <dev@dpdk.org>; Wed, 25 Jun 2025 13:48:27 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PAtioO004718;
 Wed, 25 Jun 2025 04:48:26 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2126.outbound.protection.outlook.com [40.107.223.126])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47gfrf8300-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 04:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJkeZB0lPzJbJ7OF//xf6lwB+bp23lVbyZaQ1ydayGrC7p6LeICW1WARN+2NXtGaGnMR9YA9WEepQ9/qNjqsCHBJkT4/Xk6OFuYvyMLK0sTOFhNmwfkWU1+wfSPF9/MExd2+0fk9v5m9kPYQHU3Uy60UWw9p4UzRW4CJ+hFyzp6+2kppD+UOkDck3NTJvKyC6rbgyMZm3Ykpb+Lp5pI8dsp5Eytmxn2P81V/d1/FEsMNl8A3b+vi8XYvK1Ftnz2EmWeeLzIcRLJDEUDntCJlht/hdk3GoLgDqM2eB+GyJKBNbBN30gEPxzZuv5sbGC+nIEiQSk9bPkJrTxy1qJKPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2MKotex+A5gSQAK5kn6YaITWRaoXgG/l7eFVi84vAA=;
 b=JsNLm7ERVufCoGBOB2NlIyOVnTE6x8Y+QW6we7GT4fcOEmdCH8BB0zKC4GJcd/AIVwvH9LFoYwztS0+n0oAFuAy6uOn+4TA1da7s54yt3VvWSiMUUnmoA5I29z3M2sukERdd8iSbaCQY2pV6sxsJRaCU+dUkWIOwKXosWeWxyWjj/B3KNfh/st2Ic/4+cXM0TP3iF0Lm/6L6opaDmpPg+qXUpMepgHqSqRjuLYo6BHwKUr0/QTmjfWeZ2SNMnjLSBAL208Q4qB0QE7qa5v0DkjiZQ6qgcYfoYP4kYVeyiZz2oDC3KgCOwyVlW6PKdRO2wQF0Kn27lVz66g/tldCImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2MKotex+A5gSQAK5kn6YaITWRaoXgG/l7eFVi84vAA=;
 b=V38lXzSYvZI2ueZH2DgMZBKf6psDwwY/rMw9x/Rv3JkGLx+ZSFSlpGj2ajGs7OgRGVTEm0nkZZQNnMPwZEN9mEajq8ip1CrsHg2mqwLkSjqypufbcijsAZapKdwp6GYQHu164akHKeR5kLLyKWXs+kUaRWoGq7s6z5jnz0BJk8Y=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB5051.namprd18.prod.outlook.com (2603:10b6:8:43::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.27; Wed, 25 Jun 2025 11:48:19 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 11:48:19 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>, Shally Verma
 <shallyv@marvell.com>, Ayuj Verma <ayverma@marvell.com>, Arkadiusz Kusztal
 <arkadiuszx.kusztal@intel.com>, Kanaka Durga Kotamarthy
 <kkotamarthy@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 3/3] test/crypto: fix RSA decrypt op validation
Thread-Topic: [PATCH 3/3] test/crypto: fix RSA decrypt op validation
Thread-Index: AQHb4bwVCyMYiBYtk06opj6qkBskD7QTynnA
Date: Wed, 25 Jun 2025 11:48:19 +0000
Message-ID: <CO6PR18MB448484AEBA90EB8329A93E79D87BA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250620081921.2145-1-gmuthukrishn@marvell.com>
 <20250620081921.2145-3-gmuthukrishn@marvell.com>
In-Reply-To: <20250620081921.2145-3-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB5051:EE_
x-ms-office365-filtering-correlation-id: df603be6-091e-42fd-11c2-08ddb3de2e0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8taOuWGA4cXcjbMtLTNOxq0SZ3Y+owFiZKNjI2wxBfao/RcBA5XSLc+8Bzk/?=
 =?us-ascii?Q?q2orXb14sFUtKcSKfb8EN92NOAwLs7gAt4T/UqOvAOGy1YBWuHjFsgAYTOd/?=
 =?us-ascii?Q?7/ta8BAZW50wRDWmdaBnzyzk/In90hXLxannkaGksXNVfyPpXtLolaZIIZV/?=
 =?us-ascii?Q?a17FLM6S0NUHa7aLwp9vwty2ws58x3On52DejZr0Btf2sK6crdBUUw5uKfnH?=
 =?us-ascii?Q?8IYYQbfIXMTuqvjAK0C2R3WPjRdDGGS6taDAQ5VuAvkiacsxvK2O+NkjcE2h?=
 =?us-ascii?Q?40/Y/RWygQ5+dB4QEc+QYH8+cEm3Wg5Wa2rFkw+gVw68mSkSdzuYBiLrQgY3?=
 =?us-ascii?Q?R4VLy89Mvn5nNicGtZ9T6MbB3K3N6OSlWBIIaV6zs75tN/inCgR32gmXbt9/?=
 =?us-ascii?Q?nbHa0go9Fz4M2JNpBUTa51+A9DcXxyvYWKOaynleuRVrEDhKFEoJXdb+hIvE?=
 =?us-ascii?Q?/SCi9HC2GiYySiYelSmKWnnvBBRGbpP41othloRY8drkVYWMiesLFlh3Cswf?=
 =?us-ascii?Q?8dvBSwU8cJFAqGLvOthFXKZsKx1fgMPjHhfqIG7tun7rHQbW4dVXwpQBkzQs?=
 =?us-ascii?Q?1bQnJpqHfZVRezfL377QMxmI4r4pjlzhkA+hZ7O8xQI1Tyw7jHBTz29j5V/x?=
 =?us-ascii?Q?O7c1i5gDr24m8OJeLMa0ahB4tVyl5nnS9IL9zQniqcoREtXGFX6ns7iWDR0a?=
 =?us-ascii?Q?5ouf7htdKgG56eZnFRJaPbLMqfcjI0WmU9zej+v8l6mN/zWysAgKxRj83N9B?=
 =?us-ascii?Q?kc+tPBcrYREQ11mBz704aiQmkhO7Ms7eUCqkNZ19g++lj1QKoBhfA876u/e8?=
 =?us-ascii?Q?qcMsfmxqc1ufof8xjm9aj5Ye7O5gQ65eVJ31TMzPbXEaaGWUB92qVc7+VPFr?=
 =?us-ascii?Q?glwa63h1iy+Wg7s5pIN7tZ5ShzDC92Xri4SsvlGQ84xRYKg0I7APhbDGYNLI?=
 =?us-ascii?Q?pH7D1rBSUqPbtVBF7jOciHX1oJFTWfxW79bd5Yx826VNCE3Cs86ZQP4tSKOv?=
 =?us-ascii?Q?Q5iyJfhDp991lv3rHGggnRgOuWAQy1x4xLMCiNC0OwUKlfM5f6aHuEsLZfgG?=
 =?us-ascii?Q?uK2dedeKrOWx2r5U0cxFU6cCu2uo+bycTQivQPEUjQvyFqMtacv5otxYx0NS?=
 =?us-ascii?Q?wCE0EFskH0blkKwbhENMlIlleQeNvkx9B19W6SgS4H9uaMrMe4eFrYiMyU15?=
 =?us-ascii?Q?w89uJRNVLXGcBMr/BY3ShxdKkKF1zX4EvqJn/6N+gGT+F7XoMXQ5uKhgWN96?=
 =?us-ascii?Q?3O3Ny7bSteIdmXdcN3v5/WOj+VUHAZh1FaXYXMTOB0Bo4NQ9/t0Xsf4H+oPP?=
 =?us-ascii?Q?Zx2AmTMO+DHgbbrnT2YmcmIBo2jxIHTipDi7tEfehr5R2dCmG2kYisUsXukU?=
 =?us-ascii?Q?nTEJQ/z5E15lmpwvTtlFqmcP3MiayFmas31cyVGfFIaqamv8Kh+2rYQsbJoO?=
 =?us-ascii?Q?CcgSLO0QO5p4IdoZQhvsjHHyYGNTt0ohR7TfsIpoXedmpETAIbHSvg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SORmPd5boC+d8CxsPu9cIkG+aI/dDlO6MA3+dFdFtS6lrcP693x52qcYe6MH?=
 =?us-ascii?Q?MIPPeYz1hogjChfA7Ef168hPEvoCNela3cXu79lm4WFLu7KSB8NdN6bHYYVz?=
 =?us-ascii?Q?K3eFmG8yaeo+wV27+wlZetWlCO9xhWorwoai5+WL1txfhnZC2iRDF7J47XEc?=
 =?us-ascii?Q?0Q04plXalq+X5ULe5N0LoaZn9GUx9+xG16m/ee0XbWRXIyAWQjWXwDDfaj5C?=
 =?us-ascii?Q?MpjJKkm8iUrIoqTnXEZZxZ3ICY47LqOOyKisViynBx+K2iWJUi8zJE9TEEy+?=
 =?us-ascii?Q?7nP6vrJZtIlW33NxsWLAmBiyB1nWVqu+DzWLrq+ITuNEO8LH1lcrbtgEbd4x?=
 =?us-ascii?Q?1FZjTc1rqL0+ky3utRkCde8JAzEnI2Ykv4uBA3rfZYCPvoCF5ZUWPL9B72Hq?=
 =?us-ascii?Q?QWGnLMZBZwYKUPRNhpSgvMqE+gFy537ohSaqM2uHq3i4LavQg2EtFFKZ8f39?=
 =?us-ascii?Q?lCjpbKEybpJrE3+609lbjTlUqsy/BvJU8cKLb7C6H4zWDLOTDTJQmwxsaCHO?=
 =?us-ascii?Q?nIXzDy70b6YCzyrYzyZtAQQVrFIDvm7OVKiPHkuXfHWP7G/qV/X2ds6wgsfh?=
 =?us-ascii?Q?ofECDjM4QbEOBFjnXILoZat3tqLkddy+DZzYMkUvbtHgNVxLDPkQGcJKjTAt?=
 =?us-ascii?Q?watT9TJZqoWwvQSua34hqI0F8Tq1XKb/G32xAuFLdjOFInxRmzPMaU0mq/UV?=
 =?us-ascii?Q?pephR+O75xcCEDUEoSUzd1FAfgvVnfXIXRFXxT8I2Myl43PjjyTXgB0FOroE?=
 =?us-ascii?Q?BpVcLni9hyhzQ6FtNYyHrPONkxwfUieI1C78sEwJgVE8QxB2/4Z/aoP/RDLK?=
 =?us-ascii?Q?j0a6bVh+ps/eYtEDxA6OZSHZ5jeGxu4RczPD+H8oLHMEwTthV7qXsUEejTr5?=
 =?us-ascii?Q?SO21yyLgKELy9H+yQU9SMfaVSrYXInLYF6ZyLurmEY/0rwq1kA4Gt+o2hoJb?=
 =?us-ascii?Q?x5+NIB5Tcpeec+rIzkxZ8seQP9x+LG+nOHKlEHwdA3klPco5pXxZhOUgPzqo?=
 =?us-ascii?Q?Z75kH/k/p4VLvVmmXrRHZh5QOP2mpVkrOYTtB9vERgRrPQaZATyUZR00Hn8J?=
 =?us-ascii?Q?zwcPf7isKBs/XKQ0GCy30FPWzRrp+m1q/HGjCC7kinqirHSQrZ0qSfMm+TA8?=
 =?us-ascii?Q?1O7WQe6tLZdFiJBE/v2O3LpeA3Gd0p/5TPDyzf0uC2DjKZF1+Z/cWXNxVnMq?=
 =?us-ascii?Q?7XVj+eTP2FTAzg4uoXHV4t8BCslk32nl9r56mX/yqtrUExLoYs9mnY6xtoFt?=
 =?us-ascii?Q?ws5IZuGpPODUISRVTv3zsvbqlW2+8g4dgk4Sy1Tn2sgUcJSPJq80W3GiMevf?=
 =?us-ascii?Q?0NFbpGp60qcrlZNLKoNA49DdVeMgW+VDZxZ+r/YgEeiVHgqboyVKE+aVhMDK?=
 =?us-ascii?Q?4VyCea/+qK7wvkQMtTTOGCda4Zo6fGJntjGFDmNVD7esde8dSTZwtgUAYEzf?=
 =?us-ascii?Q?UCyG+r123kbunfXhP0+HTKd4sQnCD+f2EsIYi56YFV+tKWwZj9SUIZL4Ijvs?=
 =?us-ascii?Q?O6/VrVmHw4N6H9l0hEOJovc/ZJ7sRwSqYB9HrcPW3RBkJpW8TH+QKMqXyzFB?=
 =?us-ascii?Q?jxtCvfJYJj75SCudcqPv7BsLubUvvFYN1Jb7mZ6J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df603be6-091e-42fd-11c2-08ddb3de2e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:48:19.2623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nX1XZdqQxFsbfC2ykUoBxZZ30oyV706jcRvXJ9jGbx1G2LY8vwrZeH2MUBXTrJHCALm9Kv8Xt0WTyM0NGBVQmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5051
X-Authority-Analysis: v=2.4 cv=avGyCTZV c=1 sm=1 tr=0 ts=685be20a cx=c_pps
 a=Dk5bMbaT25Dkt+m1nh8p1w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=4sd4ybeBf4zsemf9TiwA:9 a=CjuIK1q_8ugA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: BLkWms8dufLgwpZspyflGF2a2UOgkNM2
X-Proofpoint-GUID: BLkWms8dufLgwpZspyflGF2a2UOgkNM2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4NyBTYWx0ZWRfX1Ei8UPCWNZRZ
 5flBDuuUW4JKKGLX745nsJR/VDFh5Pceic4ee6YaWDujjL1FBF5QU7bBK0GQbflXtx/sdaQhLR3
 +86ZarzcJsi7Uw0M4pa139EPRBv38L099Gb8P39qNfYyY7kjhgAFkZYl1wJegTYGteu2ySEjneG
 zrW6tcu7O4suY5Nh8uEDD9piV4Iq6GnbnKWzXUYMmVe9um1O2z1a2UZ5EcHY66jGs5gwDyzHGvM
 rVq5SSYnfgb8svlZF1IzZ2vPKp19tCGLO7EFDGb+WgPHx+N4Yod4yrAbfuELcz7CLTK0PYji/A9
 9//hvAtu3XHL8NPOEPhgYi5YPeYqk5k5g8cfcVpSpHSr5LE3Ig87l+piMk9xWY0OgI8WxfwmONW
 7N8EznFSfIQRJvNw/o2sv3Oe/2xF1zv9Tk04iGTWxPywb73cegeK5m16mNnEHrbKm2CteRLd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
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

> Subject: [PATCH 3/3] test/crypto: fix RSA decrypt op validation
>=20
> Following RSA encrypt op, same plaintext buffer is used as output
> buffer for decrypt op, hence comparing plaintext buffer against
> same buffer pointer in crypto op always succeed irrespective of
> whether decrypt op succeeds or not. This patch fixes this issue
> with a local buffer for crypto op.
>=20
> Fixes: 5ae36995f10f ("test/crypto: move RSA enqueue/dequeue into function=
s")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Series Applied to dpdk-next-crypto
Thanks.
