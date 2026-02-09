Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF268EF070C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 04:24:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0E804028F;
	Mon,  9 Feb 2026 05:24:02 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
 by mails.dpdk.org (Postfix) with ESMTP id 72A0F40270
 for <dev@dpdk.org>; Mon,  9 Feb 2026 05:24:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sajs63tvz3QQxg8fRmRlxc/SJPw1P3N7LYve7j4ARqf+6tMHIZVsPClZKrTfFRMTwiE+62Milzk8Gsnr7G5qbhLPEG6vLcCECuMV80fFn8UWsCdYuznIIOK3rI9fkeItpXRKOCvsv2C0ZQPo1E2BVZPUR7iy3X+85gqBIWZbQM5E6c177QJtV4BgBZOZBZYpV0+H76t/VR2AK9OKJc6YXBcg/1+dgqRbU82uV9c8TeE3lQTo7RBMtJ7CrTnGHDrGl7S+t8lnohmSmQGI8NmqwJ/af92eSLfEn2FNEzi3Kw05VZQrWwUab8TyXkqpyt+hH6R603HTCwsBkAKrem3+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3udVYq4wKxyu1t/dw1mN59h6aJL4H3b3ZB8hX71p0Y=;
 b=paWn+M3UA7n/zrmjXpMturRxviY6YXAtA46BN2e/kP2UrBwJq8JyxPlceawjQkGQpJA7hpgutLdbOz3ThdOzBrjhr7wwPF1DMuZZ+FjyASQzj1agUoSc813uRqSv6NaVJ88CFp9yhJVHvJCTqmlDxuVbUPWuFocI5IGMN77WbldTzAM0AKn5ohGW5wRwI9EsHKNva38Z6ynA3n2i3eD5T4z2z3u0uCbf2ne/ANZS/Z6nMd/SpeVWx56FihZYypBx/YH6OzSiL4UMFCW2CzJM2Z4cwhBgYDI1rliZ/EhK0zZaJpbroVX0MMFnSqS93+m23owj5KwGP3yatHRpH3KisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3udVYq4wKxyu1t/dw1mN59h6aJL4H3b3ZB8hX71p0Y=;
 b=LKYg9MS3FhNlLcBYrBk7YT88tDmIgmOW39TUwDiP/F2K2w1Ptmk1H1asWl/TJHNjOkgWzYIn4ynkYw7q12xUEU4xoD0W93RI5V+cR7tzlm/XNRb2BDAeEPGUeh+xZs9Ch0YdPk2flDxaGxjbGi5nbGaUmD0CUmqd+6LsbdN5NmcKFUxUcQOB5cvnhve2ex9mVp+r6NjHHDJdq+6MrqfNoLcsKlAHoW0kI96x+XV3DWOiJYXPEOm1R/AfhS/HFUYRbylXI8ruvF2pYgR1fEYZIs2pjEIT33jp5CdlJHXDkHnlwQ+qORpe/kIKE39quwDveKIlfRtQ9wdnukuDQ0rKZQ==
Received: from IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 04:23:56 +0000
Received: from IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::3d3c:bcd3:d413:7f7b]) by IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::3d3c:bcd3:d413:7f7b%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 04:23:56 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Slava Ovsiienko <viacheslavo@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Raslan Darawsheh <rasland@nvidia.com>, Ori Kam <orika@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan
 Azrad <matan@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>
Subject: RE: [PATCH 1/2] lib/ethdev: support inline calculating masked item
 value
Thread-Topic: [PATCH 1/2] lib/ethdev: support inline calculating masked item
 value
Thread-Index: AQHcV5d2f5lwV3ChikmVEqm/sRDM67V0zcMAgAV6zZA=
Date: Mon, 9 Feb 2026 04:23:56 +0000
Message-ID: <IA4PR12MB9763C7AB75A5B08D1FC30B0DD065A@IA4PR12MB9763.namprd12.prod.outlook.com>
References: <20251117075407.9632-1-bingz@nvidia.com>
 <20260205084254.29f823c9@phoenix.local>
In-Reply-To: <20260205084254.29f823c9@phoenix.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9763:EE_|PH8PR12MB6817:EE_
x-ms-office365-filtering-correlation-id: 26a2a543-ddb3-43b6-a62d-08de67930a4c
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?NKkke0sFWxdFe26pHLzHVpwL4Id3doqyKNylUA1+foSFcMpLcp76yG87PhcT?=
 =?us-ascii?Q?c2sewLA/yrtAcxz9pAJk7HKRgPjUG+V1Tij8SJM40l9KBO+la0b8qfry6juX?=
 =?us-ascii?Q?fyQfNgnlVLhN84XCuhCNHNRY380Nr3mw4Qs2EoiqKDhLPf2LF+10p8NHWJtj?=
 =?us-ascii?Q?m3N75Ohc0YzPykhq8ZcMtwOcs6CwovnPOQVhCpL5mLtmDR7eHpZH6H0B83lx?=
 =?us-ascii?Q?diteLGTY00xMzmKXt3S4QRRlhcpFLxmGMN8gLkXo/4j8W1I/OZVMjisS5ufp?=
 =?us-ascii?Q?c/ygp45jHNqK3Qloy7dYWG6O3Uv6tc9L4mbd1cohBJGpfMKwx2O/2c7UmbeI?=
 =?us-ascii?Q?qdIM/KBBsvgRRmGQVlhk+ADR1CshWAWjyvpwZiyYh5y5iig6OI2OO9sUVyZ1?=
 =?us-ascii?Q?zFt5TTP9vIi8y2ForbKfI+oUBBX9Efgc2tCWm3sEvJLD4DS9/1kaPz/15Q69?=
 =?us-ascii?Q?uEoflgPBHJAEGf1JslujgET8dZvVikhngKW2bu21LPaajt/bmgoawLc7RXm6?=
 =?us-ascii?Q?8cjhr0cYj27khTvsUywCCs+z3up8C/MscdSjOR574JDqYZTXEkFzhqNQLC1U?=
 =?us-ascii?Q?RC9yh4L684G6N3zO0qXyu0CkYq2BVj69qkYcEfPlCxUmN0k2/s8v6z2gbLyy?=
 =?us-ascii?Q?1KndoHIcZSTwQDM8b+MgUn6aiU0v9eEof+CVRdoqZiyme2iC+v115LhdVRYb?=
 =?us-ascii?Q?6PymE5JI7C9LYmvGC8o49IJZKwLjet1FdM+s+bnygQtS4NR5Z3g4HFquGhLm?=
 =?us-ascii?Q?zmkB5Qld+7XfRNTtb+zBH0dp9kR/sOdfDE0V37InVVSn05uYcKsfjYYdIJuF?=
 =?us-ascii?Q?mZY+qGedBOa06sUvuRc6neklC0JugNjI0cZM31Kmty9JYMVWnQsK5bbVMVDT?=
 =?us-ascii?Q?4MpTlcJODI1TBhPnQfqO601d4HJuESG6WiuEgMMCUes1pSEquEiFeZknY8Ag?=
 =?us-ascii?Q?KOfo0/ilec2xGoTiExzcEzhECLezLe2zT5DbmHtauNk0wDNCOwy4vC3NtJUS?=
 =?us-ascii?Q?JTSe6+v4TQEsVI4UwmEYS6moFJErtHJiUbU5Jryn/oH7fbenH8Et+c8ChA0O?=
 =?us-ascii?Q?T8+fqFABeg3opLxMZzAZJEHppdsTq5d3fs4BPf+Gb9iOBcJ3bGIUizEbvXUw?=
 =?us-ascii?Q?PtCRgFHSY0QE/yLtk+L6she5d+ruK0gHfcJEgbmOWUnqrvxet7A8brFOhgSf?=
 =?us-ascii?Q?ADDe59rDiP+TwUy1sv4dryAFKJRBJnDGwrfznFMFz/Rxjj5PyLD1MX/6HBZY?=
 =?us-ascii?Q?LrW2YewhgtQnn0iMxz3rcbYLfA3kF8A6+xSYrEX5cO/ZDI1mMwo6VjRwm5z4?=
 =?us-ascii?Q?7W+4+migcyCJKhOQdz4UN/yE5R7Tix/vHUFxzPSxhvm6MeHU4ffuz5pw9VGV?=
 =?us-ascii?Q?P2PGUEphHUIOA89SNi4ttguYYYF/U8W8i2fmW4Rb2QgF9/0GeoOiaFgmV47Y?=
 =?us-ascii?Q?L4QX8Nz4rEvOKA1TOOClk4e+Cdnka/hi7/dD0Dy46RS2Njw65pfQiZr2CqgG?=
 =?us-ascii?Q?DeWfgmKICD/ijAtT3cCvgiG6aRnA58Nh/CKiQL7UYkbPjuOfFn4cct349I9h?=
 =?us-ascii?Q?3C99nJ9A0sGt0KJJ1f/PNk756nIYunOC87IYxftTlDkXck9xac0po9N8tJ8U?=
 =?us-ascii?Q?STqSc2zn+CNg7OXp6HFDyZg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WqVBSZWAft3HHJ6n7/+eerpLmnV64Rb39D1hJ5lmHK7tU3Z/Nc8z1akvHJ5t?=
 =?us-ascii?Q?dWTydaWjuWszFbcgXHJ0WIHlbsupSx6ZQcJ9QrjzFpX67ct4/anTEvkdCKgt?=
 =?us-ascii?Q?ynaK1oSCJhRDSG0yoaezUiLxcUPaRO8jiOueU7+qYNY//+dhhNd30X7510+W?=
 =?us-ascii?Q?9Pr+zZcCt/O0SWIRbgtvlIC4dD2cxW0F8TxpgtUxwVpn1BIsqHBGz/g/KeFG?=
 =?us-ascii?Q?e52usINb0q15cuFcUpM6OjAGMEukoz1aUOStsDXRvB5IZ3SarT9XGcR34Yaa?=
 =?us-ascii?Q?xnKtQvZAf+3udWv6PpqS665DVcnLtZTBpUeNFgvHAVlwj80htodBjU80QQqU?=
 =?us-ascii?Q?wClgQQMp+22uaG8rRhdwJ2pe6YZsKG/6VVpV9Afm3PQyAZhautTHmNBVqciY?=
 =?us-ascii?Q?or2KL0bEDkhL1JmkAmBvMHablWm40woXAT1Y5BqgB/slscOGi9vsy9rmFBcC?=
 =?us-ascii?Q?bZ26mCD01yBDHMctRH1gcvHR41/CkldtzP9ACkPtqGEY3jPRHGSyg/jHld5P?=
 =?us-ascii?Q?hH5BexeQyFG1MMYnIGNXdOP2L4yjhu1C0y7CoDwtbV6gWqGuqRRDfaHmf4cC?=
 =?us-ascii?Q?87qfqSEAqrECGIbLI48EVnR6Ksx3WPk1/mHzjhAEf61jKU1NYw7hWSLByIzt?=
 =?us-ascii?Q?pgNGOaBw8OPjyo7seyw6sWD/HmL3Dddj518j3zWbVx8JbH40Tll/aUT00+N6?=
 =?us-ascii?Q?BluHYCn88i0ldVmzeFHuVWs/62XhBRWbBdKPztYRMDN66RpnovZONGZwx4fd?=
 =?us-ascii?Q?py27ncpkmLK09sFzgflKlmof15/QROSGDFVlFDBcUCWMUbd2Oy44URfn3kKZ?=
 =?us-ascii?Q?qCoIh4WzoBm9Po+8UzFt2V0ES0mf9/PWNSfCfTUT+4ZgtT8fmuT6XkKlAyKk?=
 =?us-ascii?Q?yclN7vwhCQcWnOdF4T9Msk/pBX06Q49vysqMhlu38YZnHXp5q62mF1SAQexK?=
 =?us-ascii?Q?AKnh+LUAmozkOnuaNKYoRTM6PURit/UsZLo3g0Smuns6PYGVBjcuMEsEwu7Z?=
 =?us-ascii?Q?v8giWqFFvIJ72nVlKLhRSK9xApkhtC1aGcw5GImmW4fr+FozNEP/4zxqhfkR?=
 =?us-ascii?Q?FcWqQwKzCRndslk2JpZa92ITIpMUyRn0yQvI+TjS/xAncaehyEvYFpqm+K0G?=
 =?us-ascii?Q?p4w7GGuHtlW/+kNwzMjDru2jcv1GMYlU9a9qI7+C5Fwt6p2D5Q4G8/23nR4Z?=
 =?us-ascii?Q?+iE6A0cjR7E8G9b7NAWZgCW0Aagnv+rMIYXHROszO/jaDpBDF1162lakmAqi?=
 =?us-ascii?Q?wGUcLgyAZp2SpY04AB3+9I0+D7xzIbbOhbLN6PY/uylU+8CqhauC2k5CtTKv?=
 =?us-ascii?Q?pfnHW4ql09ZsTyMYG+S88xgFU9x2JyGkdysd8x6yM0XYhodtDbAmkFC1oEqn?=
 =?us-ascii?Q?K7RaLzWX11y1KYbg4XWvTbG2kKze+tDxZt+o2dsncbE7kMe9BEsEMCfVfwZ/?=
 =?us-ascii?Q?3CY0k+D7xxtiMRPicqc0HmzYxoUVu9tQGHbzqbbBCCSIzj1fMhvbfjTrY4qk?=
 =?us-ascii?Q?qLvZgXI+Ee5HPgU2AjDut5bihbpqRtaPYySmKySXXkrWoOXvR6updoRKqeIV?=
 =?us-ascii?Q?eohMfg0dhFdbSJbdiZ29k+SvEHFtbukNL8QFOwp26h+x2F8Yz02pKopPUorP?=
 =?us-ascii?Q?gtLEMgIQ/D+ik/PqyZPDwXFMjXY+iz3xylzGllqi55OMWr2MdlYJOzFD7m1d?=
 =?us-ascii?Q?pVQ8PAOwjaJl/FzFP/Tn2Lb/MQhbuhNA3N85RT+z9Yf87/TL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a2a543-ddb3-43b6-a62d-08de67930a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 04:23:56.3559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNC8mSzGheKUSPcpmK2zn0o3rZmLnL30kNPWMG8hVtSbVSj/jXVnnaQbJ0eTJRwScAb1EQHkoaldV3a7BFVkRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817
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

Sure. I will add some tests.

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, February 6, 2026 12:43 AM
> To: Bing Zhao <bingz@nvidia.com>
> Cc: Slava Ovsiienko <viacheslavo@nvidia.com>; dev@dpdk.org; Raslan
> Darawsheh <rasland@nvidia.com>; Ori Kam <orika@nvidia.com>; Dariusz
> Sosnowski <dsosnowski@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>;
> Matan Azrad <matan@nvidia.com>; NBU-Contact-Thomas Monjalon (EXTERNAL)
> <thomas@monjalon.net>
> Subject: Re: [PATCH 1/2] lib/ethdev: support inline calculating masked
> item value
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Mon, 17 Nov 2025 09:54:07 +0200
> Bing Zhao <bingz@nvidia.com> wrote:
>=20
> > In the asynchronous API definition and some drivers, the rte_flow_item
> > spec value may not be calculated by the driver due to the reason of
> > speed of light rule insertion rate and sometimes the input parameters
> > will be copied and changed internally.
> >
> > After copying, the spec and last will be protected by the keyword
> > const and cannot be changed in the code itself. And also the driver
> > needs some extra memory to do the calculation and extra conditions to
> > understand the length of each item spec. This is not efficient.
> >
> > To solve the issue and support usage of the following fix, a new OP
> > was introduced to calculate the spec and last values after applying
> > the mask inline.
> >
> > Signed-off-by: Bing Zhao <bingz@nvidia.com>
> > ---
>=20
> Looked at this patch again:
>   1. No API/ABI breakage adding a single flow type is going
>      to work great. rte_flow_conv_pattern is internal so changing is no
> problem.
>   2. No need for release note for single flow change.
>=20
>   3. Do need a test to cover the new code. I know rte_flow is way under
> tested
>      right now. Maybe a chance to use AI to generate a unit test for
> rte_flow.
>      This is important because it is a bug trap to add code that is not
> covered.
