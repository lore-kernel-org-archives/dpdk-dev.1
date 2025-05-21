Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BE6C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 09:20:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9EFE410F2;
	Wed, 21 May 2025 11:20:43 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B11C840151;
 Wed, 21 May 2025 11:20:41 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KNkp5d016090;
 Wed, 21 May 2025 02:20:40 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3purvg1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 02:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfMX1UP2x4qRT7x0Iai7mTouKsppVbfuureZu6NUCifpDeOceBYNJ8fqsqdtArP54Nb3KXvchxqI4s2HOCXM7s3ZcZU445hNSdXyHfEIwPZLxaSu5nBGvYxonqhbGbs00KQh3btOBevOgGGfih6n/JLydqexlaosBzbILYHaHcky2RF7CdcSNmmMolo3Jeg+ckcb+Uz8q/qW0KJSyFTo4r7fFIRK7R18kq35SsoIjS3MDXadihUiCWrBzRcUfb4dSP5gZKHu1Tu5RcFOzyswRznNTG78AloILd1iYT1Mn8HrECKJq2XhCuK2TyEAi3t17Sn+axAalL2XGbRfK+7qYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCTu8SAY8id8s78pjCVt4GvuBr7OAuGtpvURmdUBsUE=;
 b=hWgs9fCIvDJgZpA6+2n8Z//1SM/YDgYws17omj/OirhKlfjAhn9eCHLVH3N8WG7AvjWdICaQXL1tF6XC/kZomrITmC1zW8k3Pzms81+vdDKdFb7ToFOssu9tNqUNKoVmFQ/5/+YmLXt0572q9G0pxT8ZwJLY20aCPkYk3Pkv+nLD25QOM20hxeL4m9EnZgQkYIyw9Fkvxdshg5qGvGHMZ1pmXp8/Z6ScQO0aIeaJf0y51k7JVgZCjcRGKXvJdpiQzlP42JSzd6X1F2qOvyMKBKOggXm5ZWccQBl1rmvGdCmHughs4l40gQB/sMWj+cjQoRibCCdS1DZ+vgary074LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCTu8SAY8id8s78pjCVt4GvuBr7OAuGtpvURmdUBsUE=;
 b=Fb+tL/A458v9uVWylcbohVNoQFpiHTHoXETza5baNXJ/sKXmAAPVAmxZ6vIyjl084mN5jhaJqqWcVaXUBgu/LN6G1ouHTQDNR06w4gBlNJ8/ULovPGA65jcdLy0R9LKn0n3n07DNmTrKgdnsBOqyoHqidUGbjlCbwWWk77bTl+Y=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB4319.namprd18.prod.outlook.com (2603:10b6:5:39b::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.19; Wed, 21 May 2025 09:20:38 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 09:20:38 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Anoob Joseph <anoobj@marvell.com>
Subject: RE: [PATCH] crypto/cnxk: fix uninitialized scalar variable
Thread-Topic: [PATCH] crypto/cnxk: fix uninitialized scalar variable
Thread-Index: AQHbxXBL6ijKVKPRo0evAxVEtjVtOLPTkTMAgAlHFoA=
Date: Wed, 21 May 2025 09:20:38 +0000
Message-ID: <CO6PR18MB4484E16F556EFFF6A681780BD89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250515080632.1676-1-gmuthukrishn@marvell.com>
 <CO1PR18MB47142E16E26B2C261DA5168BCB90A@CO1PR18MB4714.namprd18.prod.outlook.com>
In-Reply-To: <CO1PR18MB47142E16E26B2C261DA5168BCB90A@CO1PR18MB4714.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB4319:EE_
x-ms-office365-filtering-correlation-id: d79d3119-dfdb-4f38-0163-08dd9848c04e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?LIz2QB9PF+x4oid/OoHCaRmpwQ0M2g5BSG4n3WtyMO+6KiR7owqniYHyr6ib?=
 =?us-ascii?Q?ZFmSS/sL1fCwc+BiHnfG41HY8WVCEIil65oBUYMAMMg8no7EGxeQHrwn9STd?=
 =?us-ascii?Q?BgvHZuKbQB2cWqkG77virwHlS2NetBEMpZMgo6pE9jNHBggyvRCdLh8nnLWi?=
 =?us-ascii?Q?IL6SGwvlSbEiUXF7qBxjMwX3sX5yCA+T9MksR0KHNSXehPFRwusvqdktNwpU?=
 =?us-ascii?Q?dFiVKtCwDxZ1SC5/RauzbVIy41Wi3JqpiWqkcZaCcEkf/yLzlbzLigm3FVy7?=
 =?us-ascii?Q?zFm+U63tFB1+cQzUmOrLcdwKsLJGNzU2z1jwv7o9F7rtYSeZI/TjYKcL4qG2?=
 =?us-ascii?Q?Jfx2VgDCwPJIG6r3uVNWgRqUVOTo9hMo/ZHzxdLMQoeQlAEWrvNSz7iaBFlO?=
 =?us-ascii?Q?V6zGkcu2HRKN8yznFRSPU0GNj7z0mHx4gBGfWJtmPpHrfD3gzuHTpgCedks8?=
 =?us-ascii?Q?KpeyEu5yxQ6f3VYxSs2TLNukv60a+wKDMMn4o0xfes5cmSeG8BZ8YlmEpVjQ?=
 =?us-ascii?Q?4VFYXJSX/GV0OYx1mvXRTJBfvC7myeYyAPd3pwgpAtI3H7t6ZkQosbXyxvF5?=
 =?us-ascii?Q?FHtZ0L0nZfLz7CWS4g2hzFDaN73iaSYA9IGM3Y1Kckc8YF8qSHw0m00efvN7?=
 =?us-ascii?Q?r4sPDyi3UPdAUNZPZLCtam+G9YoWkgOTdJ5jlV3+Y254lA9mG45UHbbxfm3/?=
 =?us-ascii?Q?8aOfZEDgxsUW55Sflyk1+W03TXlg+shXsk1NGryzeuE7p9NBQBh8g2cPeBJ2?=
 =?us-ascii?Q?8EsC9cgYkoFITyMvATB0YQmCeUSu9Ma/tfqMKh7q6LHfVJVm+suH3u5eGOXQ?=
 =?us-ascii?Q?zrBX/suU37k2ZAdmWy35oT3aF/Y8REn2KFjq8MkUDSJk2eVZYUGvu0GFe5wH?=
 =?us-ascii?Q?dxYkmxqQwiYeInAkAWrjQ3v/VH0vqihZ9BUrxLE8MCmg3AdhsovU+OeYJMug?=
 =?us-ascii?Q?JXdVqzmFMvYBNDE9239ipfTg/Q0DXl/7Bol3qxI9vF0nIRZfVuS4u2P2ZVh0?=
 =?us-ascii?Q?HKnk8VcMpnAqqPThaDST4JE/Neq6WmxuX6VqoPQ9QrFjUUzA9y7Fbxtoxgoj?=
 =?us-ascii?Q?Bqdc2uvi/qivxhUUD/KPFOgY7+duy/HPw7s1LmNT8HVodbQj8URaND7Ta1I6?=
 =?us-ascii?Q?OkZ0bKeQbUILEWNSjSPCxy12S0zD3OswLHLf2VwV48dFmaxruRo8L3kWf6Er?=
 =?us-ascii?Q?oz/Tc9gFMUPdBpqAEewjBYcxMDXO7e3FSJeZ0j4uSEbJ9uS2ijJsu3RKOtIn?=
 =?us-ascii?Q?YjQiyNFPk3eoliQSsfAoW/tsgFhueSsWScm2XEqkykIl2mzNjtt9q4TqQO8Q?=
 =?us-ascii?Q?9VkjZm3skxaCLkfD4qB5XYdq0ugFpyTtl+KnvlpWL95B+K7cjoyeG7o6tLwy?=
 =?us-ascii?Q?gCEsbF5xOFUXH6Fq+INqUkB1ZYY4oCYb1LG+3ql0rQrITxp13ZlzbmEPM1Rj?=
 =?us-ascii?Q?27jMGSajAnSQ7obp/7cbyxycuy03Qa4RYpAxgEeUikiTKNWcGM7VRGWUqUMx?=
 =?us-ascii?Q?shhvOasib41KKmU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8R0tiqNkDBGTpg462sXhy9NWebSB4VF5Q+rzdtRwQt+5r4hRrSL0oYX+7bFM?=
 =?us-ascii?Q?EZc8Z881U8nhbaLHozvkxJjcIx+uqkg04AvIQ3PS4YdOxUNuBtOq6t71OPZD?=
 =?us-ascii?Q?+ktxr1PwuVbEJKDZnraHV5LxdIUDxvG9R6T7xQvoiCDXw8hbjuiC2ZzBrmGw?=
 =?us-ascii?Q?QJ60V7ldFy09Iyr4a9GTlWbedBviNSd0GvwTEME+1oWTDBrIosggZ9F0v+gL?=
 =?us-ascii?Q?23FxqC0Jjai9wgzKRwnEsRHNnrmAiGCxgedUPHNX+P52zL/ajgYHRinJOhSF?=
 =?us-ascii?Q?vjqsZTyeyeJMx7e+cOoy10S7KehBa0sFvw+F+mYq/RVCe2APMGzdRKR8eC3v?=
 =?us-ascii?Q?DY5XkBSubBGb3iw9pTID0IL8T/U2XcZYSzHRWuQLhNaZvwY0g0IM8e1VbLdg?=
 =?us-ascii?Q?MPvcWu09/0Xsc5La04V/eBl86NwCzpLC43pY0UEjd+rgTBuc5bNVi5ENUu1n?=
 =?us-ascii?Q?kWS2wWPJ5LMDKrHt4ccx+x2GvDFU8sqOVhy4xct5kBl5ePJobfkDH2+n6Vqa?=
 =?us-ascii?Q?YE6S/aoY5R8FMaG1vb4PhEUWu7un6BWqz1y1Qjtnn/7HmeqqQ1UGmPZaw2W/?=
 =?us-ascii?Q?zYNrNm2MHeAUJD+ySuIcRuRYgARBmLptRawx6n/9MNepDUJp4Sdp2pz9sRpg?=
 =?us-ascii?Q?LhB111FtEkOtp5IEjjwKTF7rsWKXsBEmehNeeQ8XkXGdYQc7SnwrY5Si/yYr?=
 =?us-ascii?Q?12DliDGVkQR2DkyNkMx4ZSidTcWI3i6TH4JB88VOhk8sKERCtBAzDgsiXcvh?=
 =?us-ascii?Q?YR+tOE5sS6cKRWuKo8v14OVnQaBsnF4Zxx+Szx8xErdIpdLZcFrc6+Kf2yZl?=
 =?us-ascii?Q?mgmDrsqWaYIjllsQlVf4OLoqM+OzlboMtkt1euiU0OcMIyS2uHrc7capGfRr?=
 =?us-ascii?Q?a4Kg6Lir73YzSwRC+TJ3InOdnUc/1U9KavqYZklkW4tYKZxLmNtvhmj0zDe4?=
 =?us-ascii?Q?Mdd4GFZRCsf66u9/7lMk20NGN8Uv0JKjnJqmE5rjk23hmKINwVmVnI38O+Ap?=
 =?us-ascii?Q?PO0AK5P+qOUsJI5nZ+OETZHGP6PtExQkPOhPW8jGMTs2ajt/avumxxoEzkYw?=
 =?us-ascii?Q?e5UEL22webZjoTBShfY47VxeUnROvqILzxp/qRGySl1J4llJ7nWaGHbzFHS9?=
 =?us-ascii?Q?i5byRAaKd6NTokSVUVP/dloJpFZqg/i52RrCDVV3njfk0gby1de3LQVlFOTU?=
 =?us-ascii?Q?+SUETUQv0MmUniNrDFB+M+9FSMJG0nE13wlWzl+W4LcoG30HdXSpKtSVJO3G?=
 =?us-ascii?Q?LMfygM1ZYM2zoTwAa7La28XdEBrXN6ZRWvKF0o/F7QSuGfW/MXn13a/Dz8aj?=
 =?us-ascii?Q?e/vtlNB4PL5XP+4EhlB6pmzqTGaMWJi/RQ8GQXW0Vxcx1mT2TTa4M3vTFmWf?=
 =?us-ascii?Q?Lg4Mq/Mlgf1wWzhhke0zUDmK3VLBxatlhGo7jhz/p2y3Haj+3PiAD6MOxczy?=
 =?us-ascii?Q?5JXKhI2TPym8i384P/CG0aRW7e3h80oGElg9uAGWKE7akXGKcYF7nBGTEki3?=
 =?us-ascii?Q?j804MdTjn5xDkE5nbLJ2vZbLYGE6gXmH9pF2eBo9LF86tEPOY9V2U0bMrN6P?=
 =?us-ascii?Q?O7az2AqqVmeTnynGxNUUq8eTuOus7qP6FfwhyJII?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79d3119-dfdb-4f38-0163-08dd9848c04e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 09:20:38.7794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86Y48svs25ls0T0uCAsYJcgtBVaHeKagvmqecNePCj0QK008CfI16cYRbhh8WKM0pgYIDQVvuWo3oOD996frDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4319
X-Authority-Analysis: v=2.4 cv=SMtCVPvH c=1 sm=1 tr=0 ts=682d9ae8 cx=c_pps
 a=mEL9+5ifO1KfKUNINL6WGg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=dfn9aSzsSLYh5oRdclwA:9 a=CjuIK1q_8ugA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: e7tt8_6eqPCNl7zW4rXVgA88z1qRpZzo
X-Proofpoint-GUID: e7tt8_6eqPCNl7zW4rXVgA88z1qRpZzo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5MSBTYWx0ZWRfX3DPPIzR3Wjy0
 EU5+gD/7GV6Z4ehxgECwIqJewlrB8J5yArFuOieUSSxYH6+/BlHUfp8s+sxDdCWbrGT2ZzD+meB
 pG2WtQCci5Q0VXI6pDmthjeexDGlwh+Py0ZWLKZ7uYrbsMtbpRIv+B9n6mWXjXNZ0vkQm3pA19I
 VJPgT7du2esgtBhoSgSPwgK+m7CWoNIqX2tDkI4z4S+PnxN3aHEzN8sLkJWXdipnNBikvz73Lm7
 TW+EbgjjLre4evJQZ1RHeCzasWUHREaMzlFSLRsCLf0sHvFfleNppsCjcF8x90BmDgVz3n+tlSK
 b6mF/Kqg0C4dQR3Xv6HNvxxyYug/y4zmehaosocH2/mp3riE7BMekXvwfKLrF0bjqC8nTvojqYo
 MON2lDyW05MKcYOVYekyzNmCPf08dBdBY6Dcpcv2YAs95k7ErcRiMPg3CHJg7QkhTZ8BhPUM
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

> > This change fixes an uninitialized local variable as reported in coveri=
ty issue
> > 445390.
> >
> > Coverity-issue: 445390
> > Fixes: a8ebe94f8cc ("crypto/cnxk: support EdDSA")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>

Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
Thanks.
