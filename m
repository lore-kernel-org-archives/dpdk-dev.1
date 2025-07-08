Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93625C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 19:33:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B564040649;
	Tue,  8 Jul 2025 21:33:09 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7608E40292
 for <dev@dpdk.org>; Tue,  8 Jul 2025 21:33:07 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568DrSNp001715;
 Tue, 8 Jul 2025 12:33:06 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2107.outbound.protection.outlook.com [40.107.94.107])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47rqxs2c5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Jul 2025 12:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lW9owjF+w3L+tDtEgKNoMKZOTt44QvBxj33gFRup7b4mTxVkLvUjUdSsfsdBUvReRClMPvL+y/xuIv3mgYf3zyVfpmzzvlRJlAxO5yA6nlkOrk3p+nhIfcR+9sl+JVl+T5LRczNguESU3/87dxdtuHZIf2qEzSmljg73bMvY5aEpRcksiPzIUsZvNRsNsxwbxDvuqZoOgWLRymu8myX8sVgUhvnyKw3cWBVswxJVyytt1ZnWJdslKSM+/Lt0Fq2buzpNPgvnKWcw6ZcaPK7U90N/oUp4fhrUcqGBVtUPDZ4The2MEr2H5Eg1OqmYHIEwWhAU5N9gtazJwqKwTj53Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blsw9fKF4lyuDe/rnl0uZ/pYqjMoHGHaVFXJ6N1rjVE=;
 b=HXgCxgnOlUrezhXd6lsrXx9UOedQ/TmDwgBwjm39aCSas2n5w5uqYLUeNLbzCHs8n6dqjtYgaBTXlNZsSR2rUrDUopBK6GAqQ7BJZXiplpB7CtYhQIbBAGisF7KXGyNaAFhsr30kKu9LP2WDO4icFuKmrsYLJZ2G5wZLgudsEXEHlrZFh7LVhz5wqIAO8ml+ANqtDzDwtcNReKS7yPNWGuN/RefcBseIlZpZ9rmTkfP5vlnO4M4yKW16xHOOdNDzOMMz08Y7A7UtHEab5FFQa90U0mrr/UHCZ176xSHP4fZL9U9So2Etx7M99puZHPshbGptPbpXbegFADiTmJmYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blsw9fKF4lyuDe/rnl0uZ/pYqjMoHGHaVFXJ6N1rjVE=;
 b=c5lVIHfNn1h4hNsT2IhB4IKOrTjYhnBoLVo9CmuEn4GRWxCn1/ZM5jkGVeOGSIx+n53EPU9Dk94wJB87wD+md1ur+23Aic/dupabP6gG4umDhUDRyKGnVCAr+pK4AFRqdVqhX6yRtJdKTFCgR/Z9KGd9w5Qjk1/v0wLTQ/QEi0g=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 IA0PPFBD61E95DF.namprd18.prod.outlook.com (2603:10b6:20f:fc04::c3b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 8 Jul
 2025 19:33:03 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 19:33:03 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>
Subject: RE: [EXTERNAL] [PATCH v4 2/2] crypto/uadk: use async mode to replace
 sync mode
Thread-Topic: [EXTERNAL] [PATCH v4 2/2] crypto/uadk: use async mode to replace
 sync mode
Thread-Index: AQHb6vsDilsYkutyf0OHqdnuf07UyrQop2Gw
Date: Tue, 8 Jul 2025 19:33:03 +0000
Message-ID: <CO6PR18MB44842C3119B81D8486565BDED84EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250702024216.49587-1-zhangfei.gao@linaro.org>
 <20250702024216.49587-3-zhangfei.gao@linaro.org>
In-Reply-To: <20250702024216.49587-3-zhangfei.gao@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|IA0PPFBD61E95DF:EE_
x-ms-office365-filtering-correlation-id: b0b58d33-2913-45a6-7bba-08ddbe5641b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ePyS6GRN5GLdGmLCClprqCDlrbUIfsBnda7dqCYaq9vpel3nEulm5iDVsDKR?=
 =?us-ascii?Q?KOlNlky2i+yrZrXNaxZ+vQt3bMtfcfH2EGhc6PtWBA7mrA0AXnv39kT39tcg?=
 =?us-ascii?Q?RvtyEH+WmZsuCDdKe1wCKFBkJ524lzSK665/8C1lY9d8fYNO1HI/tSTrObxu?=
 =?us-ascii?Q?haceWp3wb94rRxoCy0WONXZKiiXIZcEUvx9hHDbQucPb/GgTBaBWFAPB2z9P?=
 =?us-ascii?Q?QEhXlWEGfYPtKHYTy8Idm4eqj3uknV8UU1aPnaAbZBcPoG+YvqeI65p2srt+?=
 =?us-ascii?Q?A4gTDMROyuqgmzrKVn4jDSDqUR8tCNVcooc1GlYR0V5/HeDqwEqlvNfteH9L?=
 =?us-ascii?Q?b0dYM3Me2lHnbqMjWJYYMSO6dmsqrD1CRzdaADg71smyFIvXhQP5goCrhFof?=
 =?us-ascii?Q?d8RMKNTlb3KmBQCUzHukWgdMx5lfv9DDNlyLVNYQlWh87eTDtYOKOHbNdOuw?=
 =?us-ascii?Q?XsvCbj4PXSgoNrCchqP5QY0C50qwsIROuxHXPC9qJGCWSPd3eRFhNKuELTWW?=
 =?us-ascii?Q?1L1pab9bi++yo8mU615iZ5oCZf2D5JgZnMIAAUKiUuvdygI2C5sNJwsyq8Vy?=
 =?us-ascii?Q?6UMByaOODQVOsjYRlyq371eCLswCq/7aRH1eKunbIzeJMHsyPWCcdH67lLF/?=
 =?us-ascii?Q?bkiSdt3LzKT217IFhfsAVao8mu+TbB0BrL3jQO9IV4UnCHujnCRVxExBAKGP?=
 =?us-ascii?Q?mHLrIwGfjxWtS5ro2/hE36Td6yhHuQ04LKIPyhtUBMS7T4N/IbQOFOEA0br/?=
 =?us-ascii?Q?dEWQMmnF4J2+p17Bo5yIFb44iEih5dXAQgmRBXxqKq+/OVGo+Bq7a8NfAQqx?=
 =?us-ascii?Q?LsXlQuEuVF0o6tFhyrR2nqBlXrUYDfFkaOUUSdz5ytByHOFvIhz+FDR8bmeg?=
 =?us-ascii?Q?450jw3QC6/jpmoa/eebh3xqm6WOlfRb7MxOXtaCR9sw5sOyXJgltwMNSoQXU?=
 =?us-ascii?Q?TZngnHnpXs/JZzdYGusDP2taidLxN1unc4W8c+gyPg/li4/oEdJlIb9Qkuzb?=
 =?us-ascii?Q?KfsyneCqlx0gRf6z/qWC0xAZf6HzUU34mWkThKJgDnpxc++1w4P+pyLlsrRX?=
 =?us-ascii?Q?StGsp9wLf1Nfzp9ZW0xhWFiXb3WnP4FRlFnZZLJRU7jDMnqVPc2DuArCll5q?=
 =?us-ascii?Q?P+KhOjdYMfHaoGC/eXHvZvmz6mck1Gx0d6Ym6ZXs3QtnjjLtOwqs7Yz16Rlh?=
 =?us-ascii?Q?7XNlqVgcX5jfxksoy8mTtjjQ8GXG7pVCL1bv67ZiOifEis7CxGMdnrt9XGL5?=
 =?us-ascii?Q?FZRX5BpQ3gG73XBhnDqFop4fchhSjOZr02rH8Ad+q9m9FqWhwWY3m1rPA+5F?=
 =?us-ascii?Q?RAlwnvqh8rrLw1poG4DbNwFOCJW9NDaYqvNwqH5AMGrbPH3gmTDavkeMESS5?=
 =?us-ascii?Q?ZZZkuFw9iVKEQ9PGb8VvBN1tir3u36V+YZfZU5OjlZd+9ahyrLvevoI1T8Fa?=
 =?us-ascii?Q?hpyBcjNiszbjUtPN4jumgr0PKoSrjBfoM5d+Oy2MPV7hLKOy74wfqg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pcZx2aVtupwzrX+AHLtTE5xRM2T1GOKNzsjyE3o8Um8H1ONINvPklpR9hqrT?=
 =?us-ascii?Q?rcjxczZjwRssQkBuqh9eu7E7mu/Vk1Ema2QiqpPiYsVu3jlQOT7QvWsBBXwf?=
 =?us-ascii?Q?32Xj7ZIJPtW1wRgnLd5ml1uV52XtrYQfKeZtypV6X3VCR1BK4Hci8dmEDkIc?=
 =?us-ascii?Q?bpza3/rjcTOGgv0mkytgS6tZ9m0U1M+nanLsaRQA1Gi2uMMmvcrZOjbjL3dB?=
 =?us-ascii?Q?qSJjGb1xSN50H4a5jrWwyxjzzeOj4/zVyGQ6vCXks/A0jHrA6dxvD6Cr2j5m?=
 =?us-ascii?Q?eWyBaCrQLlN6VPj6a9eKYW/Bkv17tSdyXSkgbfLqa9aZGZmPwFZktVBGCvnn?=
 =?us-ascii?Q?MsebQI5z/26DRiUCZZrzWeSfDkVcsQ23FqTHRsOFPabPmx2F/XkWspOmJTf0?=
 =?us-ascii?Q?ZWeAZA35kBlWPrGI/BQWXgtgpCqY4UYkOhv/zWI5uIjWbnd32YD4UBZWsAO5?=
 =?us-ascii?Q?I0zEpF6lZiYoc53KAHioUcm5lezsFL3Og1H9ps1OzbBqecZR2q7R4MbA6HPV?=
 =?us-ascii?Q?1yMh6Blz5/1JtSGIixXXchHhSNt0j9odj9Z8uD/FFTlRgAhPrK9k6D+9s82B?=
 =?us-ascii?Q?OVdqtJWUpbAmb0gIjecJFmanz7x8rOCY7nR9yzhujtS98ULRIqSKIoN+YH/t?=
 =?us-ascii?Q?6rqWiehNY7YTyZvQAGe33/TGG5Dq1nSG6DV/1/bEqkSsXdl6MLwSxqWG8WeW?=
 =?us-ascii?Q?Cl5mtgk6wpNGVGqmA7M5F2snLHIgBHa7GVAgdyAVODfXhprKKabokGsviZ3Y?=
 =?us-ascii?Q?pjBSFgt3BX7TbbpeFMcpMPXUBZus0p2t32FcntpbgEpnysiCY6OxY4BnYeec?=
 =?us-ascii?Q?5U/3+Zn03FoSD2GMZWSfAqGMnUcRxTO3hspMezvXlFHd2cjj3hhqNbE4oZTz?=
 =?us-ascii?Q?BpFkNPOYGSX9q20Zq6GihaiNcBOp3ykuI579iKXXoztFh5lHj7CZO4RsK8yh?=
 =?us-ascii?Q?uKvodEqbqxQwfnLi8iMRvFab2e5mghd92SMr8EZ7IEOSQHh8G3vieW7i1BMI?=
 =?us-ascii?Q?Yz13B3EWzkuYpwjD8PQ+wghn7NusmJAoWSukaH2TMsz2jMOKOBuLAYNymSyY?=
 =?us-ascii?Q?NqRAHzePyLlyIfPQbFK1pJOhjyL3k1q1AcvYLZOo1iOegm+YNGa3YroseeEf?=
 =?us-ascii?Q?vZ5B9ThG14feBzb1tJKk5Yi2+MIECXkHBVzNAw97WlsYs1n79kQZFZ6fbMtZ?=
 =?us-ascii?Q?3Fu4AwHg7+qmnFvKSp/M61u7B7IPt6F1Hv912+pDgNfsERwr4zEiKg640hmH?=
 =?us-ascii?Q?76rKZ6l+h0Lth6yMmDun6oyxdPj7bfDDrteN+nExHpFAYRMXY0XSubRXm+vn?=
 =?us-ascii?Q?mt7z045FeD9qzfmBaqCIA7M+BM8m0/QaaCL/LKZ/2fs0r4DtKFYlaY3Fv8En?=
 =?us-ascii?Q?sbj+s2ybIOZbsBEXsHypuk0NsSv+kRZCl8VrW+Hp5q5drY23PXaz1Ili/2wj?=
 =?us-ascii?Q?2sXGkh6zZ+B64evX6HrAxDzaAroVjzKXvtPg4/4yfcW1wBVUL7uGDcFXCnUB?=
 =?us-ascii?Q?Pf17LxtqkHMo49WPYwWRlAAW/YPlEedSkgR7Qrmkj44eALZrrRxUiXFAfFGL?=
 =?us-ascii?Q?yvjQfOQLchw6rjHto1c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b58d33-2913-45a6-7bba-08ddbe5641b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 19:33:03.5400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W79eUT9HClPM5LPGBj7IyCBEQdOZ0r3L26ccrpLVlD73VO5iI4RufhVa9bLVILci3Jrpfw68SaD6AnxuJM9Eag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFBD61E95DF
X-Authority-Analysis: v=2.4 cv=JKc7s9Kb c=1 sm=1 tr=0 ts=686d7272 cx=c_pps
 a=3+xmILRzgUfFm8gMNKQ0sw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=KKAkSRfTAAAA:8 a=VI1XoR-D_nf-p6Xr4tgA:9
 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HDcWt6CCpqRkLAMG0EKShzACWc8dlOco
X-Proofpoint-GUID: HDcWt6CCpqRkLAMG0EKShzACWc8dlOco
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE2NCBTYWx0ZWRfXz+C7QeFRxsX0
 7NG2nn+W0Bbhpno12hWvu7u1ta60IW7UsTS+XjzvVaQEU1nmbEqKe6PkyponKD1+F59b39FpRBQ
 9+JdwS3tcalL/2G9yiOfPzU2he8lzw0clynNpF4Wmih1WJsAhK9jAuiPc/2Dgc1Q+hYmfS+H51J
 q6t6EMVZNEFzeq3/q8NVgThJSGYdvbRB7IcuV+5w/T17bDnkCRU3vZRnLsKS/fcAzZ3tbue9MEm
 9L/4oSzzN2G6Uq7k8V67KsyWocHPQMt06cIPqS7r38orv4Yvn4jzWOuPEUFomzmouWOaqvs/wi2
 98aOw5rIZyT3/oJ+5qLmSM/G0I7yO/eErHL3xvN0/15KmAODbwhkQpi77Ri1P5d6T7ljoIVtuS8
 gf0i/QLFJ68xHS9cUa2jruAryiZtZCI1+3OunoySlHi59kIivkHK4/oFPanYfnH0IC3/jULk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
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

> To get better performance, using async mode to replace sync mode
>=20
> However, case UADK_CHAIN_CIPHER_AUTH and UADK_CHAIN_AUTH_CIPHER
> still use sync mode for the first operation and async mode for
> the second operation since the dependence.
>=20
> Also RTE_CRYPTO_AUTH_OP_VERIFY will hold the generated auth in
> qp->temp_digest[idx % BURST_MAX] to verify later.
>=20
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  doc/guides/cryptodevs/uadk.rst                |  15 +
>  doc/guides/rel_notes/release_25_07.rst        |   5 +
>  drivers/crypto/uadk/meson.build               |   4 +-
>  drivers/crypto/uadk/uadk_crypto_pmd.c         | 297 ++++++++++++------
>  drivers/crypto/uadk/uadk_crypto_pmd_private.h |   8 +-
>  5 files changed, 234 insertions(+), 95 deletions(-)
>=20
> diff --git a/doc/guides/cryptodevs/uadk.rst b/doc/guides/cryptodevs/uadk.=
rst
> index d38dffbcd9..7591c0e94b 100644
> --- a/doc/guides/cryptodevs/uadk.rst
> +++ b/doc/guides/cryptodevs/uadk.rst
> @@ -112,6 +112,21 @@ Test steps
>        RTE>>quit
>=20
>=20
> +As a reference, the following table shows a mapping between the past DPD=
K
> versions
> +and the UADK library version supported by them:
> +
> +.. _table_uadk_crypto_pmd_versions:
> +
> +.. table:: DPDK and external UADK library version compatibility
> +
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   DPDK version    UADK library version
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   22.11 - 25.03   2.4  - 2.8
> +   25.07+          2.9.1
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +
>  Initialization
>  --------------
>=20
> diff --git a/doc/guides/rel_notes/release_25_07.rst
> b/doc/guides/rel_notes/release_25_07.rst
> index e57cf546c2..5e8cb0e512 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -98,6 +98,11 @@ New Features
>=20
>    * Added support for AMD Solarflare X45xx adapters.
>=20
> +* **Updated UADK crypto & compress driver.**
> +
> +  * Update to init2 interface which requires v2.9 of the UADK library.
> +  * Update to asynchronous mode for better performance.


This shall be v2.9.1. Right?

> +
>  * **Updated virtio driver.**
>=20
>    * Added support for Rx and Tx burst mode query.
> diff --git a/drivers/crypto/uadk/meson.build b/drivers/crypto/uadk/meson.=
build
> index e46abd21e5..00cd7d1c44 100644
> --- a/drivers/crypto/uadk/meson.build
> +++ b/drivers/crypto/uadk/meson.build
> @@ -13,7 +13,7 @@ sources =3D files(
>  )
>=20
>  deps +=3D 'bus_vdev'
> -dep =3D dependency('libwd_crypto', required: false, method: 'pkg-config'=
)
> +dep =3D dependency('libwd_crypto', version: '>=3D2.9', required: false, =
method: 'pkg-
> config')
>  if not dep.found()
>      build =3D false
>      reason =3D 'missing dependency, "libwd_crypto"'
> @@ -21,7 +21,7 @@ else
>      ext_deps +=3D dep
>  endif
>=20
> -dep =3D dependency('libwd', required: false, method: 'pkg-config')
> +dep =3D dependency('libwd', version: '>=3D2.9', required: false, method:=
 'pkg-config')

Here and in your compress patch also, the dependency version should be >=3D=
2.9.1. Right?
Please fix these mismatches as soon as possible. We are closing RC3 tomorro=
w.=20
If it is not merged in RC3, will be deferred to next release.

>  if not dep.found()
>      build =3D false
>      reason =3D 'missing dependency, "libwd"'
> diff --git a/drivers/crypto/uadk/uadk_crypto_pmd.c
> b/drivers/crypto/uadk/uadk_crypto_pmd.c
> index e4b1a32398..3c4e83e56f 100644
> --- a/drivers/crypto/uadk/uadk_crypto_pmd.c
> +++ b/drivers/crypto/uadk/uadk_crypto_pmd.c
> @@ -15,6 +15,9 @@
>=20
>  #include "uadk_crypto_pmd_private.h"
>=20
> +#define MAX_ALG_NAME 64
> +#define UADK_CIPHER_DEF_CTXS    2
> +
>  static uint8_t uadk_cryptodev_driver_id;
>=20
>  static const struct rte_cryptodev_capabilities uadk_crypto_v2_capabiliti=
es[] =3D {
> @@ -359,12 +362,10 @@ static int
>  uadk_crypto_pmd_config(struct rte_cryptodev *dev __rte_unused,
>  		       struct rte_cryptodev_config *config)
>  {
> -	char env[128];
> +	struct uadk_crypto_priv *priv =3D dev->data->dev_private;
>=20
> -	/* set queue pairs num via env */
> -	sprintf(env, "sync:%d@0", config->nb_queue_pairs);
> -	setenv("WD_CIPHER_CTX_NUM", env, 1);
> -	setenv("WD_DIGEST_CTX_NUM", env, 1);
> +	if (config->nb_queue_pairs !=3D 0)
> +		priv->nb_qpairs =3D config->nb_queue_pairs;
>=20
>  	return 0;
>  }
> @@ -388,14 +389,14 @@ uadk_crypto_pmd_close(struct rte_cryptodev *dev)
>  {
>  	struct uadk_crypto_priv *priv =3D dev->data->dev_private;
>=20
> -	if (priv->env_cipher_init) {
> -		wd_cipher_env_uninit();
> -		priv->env_cipher_init =3D false;
> +	if (priv->cipher_init) {
> +		wd_cipher_uninit2();
> +		priv->cipher_init =3D false;
>  	}
>=20
> -	if (priv->env_auth_init) {
> -		wd_digest_env_uninit();
> -		priv->env_auth_init =3D false;
> +	if (priv->auth_init) {
> +		wd_digest_uninit2();
> +		priv->auth_init =3D false;
>  	}
>=20
>  	return 0;
> @@ -584,15 +585,11 @@ uadk_set_session_cipher_parameters(struct
> rte_cryptodev *dev,
>  	struct rte_crypto_cipher_xform *cipher =3D &xform->cipher;
>  	struct wd_cipher_sess_setup setup =3D {0};
>  	struct sched_params params =3D {0};
> +	struct wd_ctx_params cparams =3D {0};
> +	struct wd_ctx_nums *ctx_set_num;
> +	char alg_name[MAX_ALG_NAME];
>  	int ret;
>=20
> -	if (!priv->env_cipher_init) {
> -		ret =3D wd_cipher_env_init(NULL);
> -		if (ret < 0)
> -			return -EINVAL;
> -		priv->env_cipher_init =3D true;
> -	}
> -
>  	sess->cipher.direction =3D cipher->op;
>  	sess->iv.offset =3D cipher->iv.offset;
>  	sess->iv.length =3D cipher->iv.length;
> @@ -603,15 +600,18 @@ uadk_set_session_cipher_parameters(struct
> rte_cryptodev *dev,
>  		setup.alg =3D WD_CIPHER_AES;
>  		setup.mode =3D WD_CIPHER_CTR;
>  		sess->cipher.req.out_bytes =3D 64;
> +		rte_strscpy(alg_name, "ctr(aes)", sizeof(alg_name));
>  		break;
>  	case RTE_CRYPTO_CIPHER_AES_ECB:
>  		setup.alg =3D WD_CIPHER_AES;
>  		setup.mode =3D WD_CIPHER_ECB;
>  		sess->cipher.req.out_bytes =3D 16;
> +		rte_strscpy(alg_name, "ecb(aes)", sizeof(alg_name));
>  		break;
>  	case RTE_CRYPTO_CIPHER_AES_CBC:
>  		setup.alg =3D WD_CIPHER_AES;
>  		setup.mode =3D WD_CIPHER_CBC;
> +		rte_strscpy(alg_name, "cbc(aes)", sizeof(alg_name));
>  		if (cipher->key.length =3D=3D 16)
>  			sess->cipher.req.out_bytes =3D 16;
>  		else
> @@ -620,14 +620,36 @@ uadk_set_session_cipher_parameters(struct
> rte_cryptodev *dev,
>  	case RTE_CRYPTO_CIPHER_AES_XTS:
>  		setup.alg =3D WD_CIPHER_AES;
>  		setup.mode =3D WD_CIPHER_XTS;
> +		rte_strscpy(alg_name, "xts(aes)", sizeof(alg_name));
>  		if (cipher->key.length =3D=3D 16)
>  			sess->cipher.req.out_bytes =3D 32;
>  		else
>  			sess->cipher.req.out_bytes =3D 512;
>  		break;
>  	default:
> -		ret =3D -ENOTSUP;
> -		goto env_uninit;
> +		return -ENOTSUP;
> +	}
> +
> +	if (!priv->cipher_init) {
> +		ctx_set_num =3D calloc(1, sizeof(*ctx_set_num));
> +		if (!ctx_set_num) {
> +			UADK_LOG(ERR, "failed to alloc ctx_set_size!");
> +			return -WD_ENOMEM;
> +		}
> +
> +		cparams.op_type_num =3D 1;
> +		cparams.ctx_set_num =3D ctx_set_num;
> +		ctx_set_num->sync_ctx_num =3D priv->nb_qpairs;
> +		ctx_set_num->async_ctx_num =3D priv->nb_qpairs;
> +
> +		ret =3D wd_cipher_init2_(alg_name, SCHED_POLICY_RR,
> TASK_MIX, &cparams);
> +		free(ctx_set_num);
> +
> +		if (ret) {
> +			UADK_LOG(ERR, "failed to do cipher init2!");
> +			return ret;
> +		}
> +		priv->cipher_init =3D true;
>  	}
>=20
>  	params.numa_id =3D -1;	/* choose nearby numa node */
> @@ -636,7 +658,7 @@ uadk_set_session_cipher_parameters(struct
> rte_cryptodev *dev,
>  	if (!sess->handle_cipher) {
>  		UADK_LOG(ERR, "uadk failed to alloc session!");
>  		ret =3D -EINVAL;
> -		goto env_uninit;
> +		goto uninit;
>  	}
>=20
>  	ret =3D wd_cipher_set_key(sess->handle_cipher, cipher->key.data, cipher=
-
> >key.length);
> @@ -644,14 +666,14 @@ uadk_set_session_cipher_parameters(struct
> rte_cryptodev *dev,
>  		wd_cipher_free_sess(sess->handle_cipher);
>  		UADK_LOG(ERR, "uadk failed to set key!");
>  		ret =3D -EINVAL;
> -		goto env_uninit;
> +		goto uninit;
>  	}
>=20
>  	return 0;
>=20
> -env_uninit:
> -	wd_cipher_env_uninit();
> -	priv->env_cipher_init =3D false;
> +uninit:
> +	wd_cipher_uninit2();
> +	priv->cipher_init =3D false;
>  	return ret;
>  }
>=20
> @@ -664,15 +686,11 @@ uadk_set_session_auth_parameters(struct
> rte_cryptodev *dev,
>  	struct uadk_crypto_priv *priv =3D dev->data->dev_private;
>  	struct wd_digest_sess_setup setup =3D {0};
>  	struct sched_params params =3D {0};
> +	struct wd_ctx_params cparams =3D {0};
> +	struct wd_ctx_nums *ctx_set_num;
> +	char alg_name[MAX_ALG_NAME];
>  	int ret;
>=20
> -	if (!priv->env_auth_init) {
> -		ret =3D wd_digest_env_init(NULL);
> -		if (ret < 0)
> -			return -EINVAL;
> -		priv->env_auth_init =3D true;
> -	}
> -
>  	sess->auth.operation =3D xform->auth.op;
>  	sess->auth.digest_length =3D xform->auth.digest_length;
>=20
> @@ -684,6 +702,7 @@ uadk_set_session_auth_parameters(struct
> rte_cryptodev *dev,
>  		setup.alg =3D WD_DIGEST_MD5;
>  		sess->auth.req.out_buf_bytes =3D 16;
>  		sess->auth.req.out_bytes =3D 16;
> +		rte_strscpy(alg_name, "md5", sizeof(alg_name));
>  		break;
>  	case RTE_CRYPTO_AUTH_SHA1:
>  	case RTE_CRYPTO_AUTH_SHA1_HMAC:
> @@ -692,6 +711,7 @@ uadk_set_session_auth_parameters(struct
> rte_cryptodev *dev,
>  		setup.alg =3D WD_DIGEST_SHA1;
>  		sess->auth.req.out_buf_bytes =3D 20;
>  		sess->auth.req.out_bytes =3D 20;
> +		rte_strscpy(alg_name, "sha1", sizeof(alg_name));
>  		break;
>  	case RTE_CRYPTO_AUTH_SHA224:
>  	case RTE_CRYPTO_AUTH_SHA224_HMAC:
> @@ -700,6 +720,7 @@ uadk_set_session_auth_parameters(struct
> rte_cryptodev *dev,
>  		setup.alg =3D WD_DIGEST_SHA224;
>  		sess->auth.req.out_buf_bytes =3D 28;
>  		sess->auth.req.out_bytes =3D 28;
> +		rte_strscpy(alg_name, "sha224", sizeof(alg_name));
>  		break;
>  	case RTE_CRYPTO_AUTH_SHA256:
>  	case RTE_CRYPTO_AUTH_SHA256_HMAC:
> @@ -708,6 +729,7 @@ uadk_set_session_auth_parameters(struct
> rte_cryptodev *dev,
>  		setup.alg =3D WD_DIGEST_SHA256;
>  		sess->auth.req.out_buf_bytes =3D 32;
>  		sess->auth.req.out_bytes =3D 32;
> +		rte_strscpy(alg_name, "sha256", sizeof(alg_name));
>  		break;
>  	case RTE_CRYPTO_AUTH_SHA384:
>  	case RTE_CRYPTO_AUTH_SHA384_HMAC:
> @@ -716,6 +738,7 @@ uadk_set_session_auth_parameters(struct
> rte_cryptodev *dev,
>  		setup.alg =3D WD_DIGEST_SHA384;
>  		sess->auth.req.out_buf_bytes =3D 48;
>  		sess->auth.req.out_bytes =3D 48;
> +		rte_strscpy(alg_name, "sha384", sizeof(alg_name));
>  		break;
>  	case RTE_CRYPTO_AUTH_SHA512:
>  	case RTE_CRYPTO_AUTH_SHA512_HMAC:
> @@ -724,10 +747,33 @@ uadk_set_session_auth_parameters(struct
> rte_cryptodev *dev,
>  		setup.alg =3D WD_DIGEST_SHA512;
>  		sess->auth.req.out_buf_bytes =3D 64;
>  		sess->auth.req.out_bytes =3D 64;
> +		rte_strscpy(alg_name, "sha512", sizeof(alg_name));
>  		break;
>  	default:
> -		ret =3D -ENOTSUP;
> -		goto env_uninit;
> +		return -ENOTSUP;
> +	}
> +
> +	if (!priv->auth_init) {
> +		ctx_set_num =3D calloc(1, sizeof(*ctx_set_num));
> +		if (!ctx_set_num) {
> +			UADK_LOG(ERR, "failed to alloc ctx_set_size!");
> +			return -WD_ENOMEM;
> +		}
> +
> +		cparams.op_type_num =3D 1;
> +		cparams.ctx_set_num =3D ctx_set_num;
> +		ctx_set_num->sync_ctx_num =3D priv->nb_qpairs;
> +		ctx_set_num->async_ctx_num =3D priv->nb_qpairs;
> +
> +		ret =3D wd_digest_init2_(alg_name, SCHED_POLICY_RR, TASK_HW,
> &cparams);
> +		free(ctx_set_num);
> +
> +		if (ret) {
> +			UADK_LOG(ERR, "failed to do digest init2!");
> +			return ret;
> +		}
> +
> +		priv->auth_init =3D true;
>  	}
>=20
>  	params.numa_id =3D -1;	/* choose nearby numa node */
> @@ -736,7 +782,7 @@ uadk_set_session_auth_parameters(struct
> rte_cryptodev *dev,
>  	if (!sess->handle_digest) {
>  		UADK_LOG(ERR, "uadk failed to alloc session!");
>  		ret =3D -EINVAL;
> -		goto env_uninit;
> +		goto uninit;
>  	}
>=20
>  	/* if mode is HMAC, should set key */
> @@ -749,15 +795,15 @@ uadk_set_session_auth_parameters(struct
> rte_cryptodev *dev,
>  			wd_digest_free_sess(sess->handle_digest);
>  			sess->handle_digest =3D 0;
>  			ret =3D -EINVAL;
> -			goto env_uninit;
> +			goto uninit;
>  		}
>  	}
>=20
>  	return 0;
>=20
> -env_uninit:
> -	wd_digest_env_uninit();
> -	priv->env_auth_init =3D false;
> +uninit:
> +	wd_digest_uninit2();
> +	priv->auth_init =3D false;
>  	return ret;
>  }
>=20
> @@ -854,78 +900,98 @@ static struct rte_cryptodev_ops uadk_crypto_pmd_ops
> =3D {
>  		.sym_session_clear	=3D uadk_crypto_sym_session_clear,
>  };
>=20
> +static void *uadk_cipher_async_cb(struct wd_cipher_req *req __rte_unused=
,
> +					 void *data __rte_unused)
> +{
> +	struct rte_crypto_op *op =3D req->cb_param;
> +
> +	if (op->status =3D=3D RTE_CRYPTO_OP_STATUS_NOT_PROCESSED)
> +		op->status =3D RTE_CRYPTO_OP_STATUS_SUCCESS;
> +
> +	return NULL;
> +}
> +
>  static void
>  uadk_process_cipher_op(struct rte_crypto_op *op,
>  		       struct uadk_crypto_session *sess,
> -		       struct rte_mbuf *msrc, struct rte_mbuf *mdst)
> +		       struct rte_mbuf *msrc, struct rte_mbuf *mdst,
> +		       bool async)
>  {
>  	uint32_t off =3D op->sym->cipher.data.offset;
> +	struct wd_cipher_req *req =3D &sess->cipher.req;
>  	int ret;
>=20
> -	if (!sess) {
> -		op->status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
> -		return;
> -	}
> +	req->src =3D rte_pktmbuf_mtod_offset(msrc, uint8_t *, off);
> +	req->in_bytes =3D op->sym->cipher.data.length;
> +	req->dst =3D rte_pktmbuf_mtod_offset(mdst, uint8_t *, off);
> +	req->out_buf_bytes =3D sess->cipher.req.in_bytes;
> +	req->iv_bytes =3D sess->iv.length;
> +	req->iv =3D rte_crypto_op_ctod_offset(op, uint8_t *, sess->iv.offset);
> +	req->cb =3D uadk_cipher_async_cb;
> +	req->cb_param =3D op;
>=20
> -	sess->cipher.req.src =3D rte_pktmbuf_mtod_offset(msrc, uint8_t *, off);
> -	sess->cipher.req.in_bytes =3D op->sym->cipher.data.length;
> -	sess->cipher.req.dst =3D rte_pktmbuf_mtod_offset(mdst, uint8_t *, off);
> -	sess->cipher.req.out_buf_bytes =3D sess->cipher.req.in_bytes;
> -	sess->cipher.req.iv_bytes =3D sess->iv.length;
> -	sess->cipher.req.iv =3D rte_crypto_op_ctod_offset(op, uint8_t *,
> -							sess->iv.offset);
>  	if (sess->cipher.direction =3D=3D RTE_CRYPTO_CIPHER_OP_ENCRYPT)
> -		sess->cipher.req.op_type =3D WD_CIPHER_ENCRYPTION;
> +		req->op_type =3D WD_CIPHER_ENCRYPTION;
>  	else
> -		sess->cipher.req.op_type =3D WD_CIPHER_DECRYPTION;
> +		req->op_type =3D WD_CIPHER_DECRYPTION;
>=20
>  	do {
> -		ret =3D wd_do_cipher_sync(sess->handle_cipher, &sess-
> >cipher.req);
> +		if (async)
> +			ret =3D wd_do_cipher_async(sess->handle_cipher, req);
> +		else
> +			ret =3D wd_do_cipher_sync(sess->handle_cipher, req);
>  	} while (ret =3D=3D -WD_EBUSY);
>=20
>  	if (ret)
>  		op->status =3D RTE_CRYPTO_OP_STATUS_ERROR;
>  }
>=20
> +static void *uadk_digest_async_cb(void *param)
> +{
> +	struct wd_digest_req *req =3D param;
> +	struct rte_crypto_op *op =3D req->cb_param;
> +
> +	if (op->status =3D=3D RTE_CRYPTO_OP_STATUS_NOT_PROCESSED)
> +		op->status =3D RTE_CRYPTO_OP_STATUS_SUCCESS;
> +
> +	return NULL;
> +}
> +
>  static void
>  uadk_process_auth_op(struct uadk_qp *qp, struct rte_crypto_op *op,
>  		     struct uadk_crypto_session *sess,
> -		     struct rte_mbuf *msrc, struct rte_mbuf *mdst)
> +		     struct rte_mbuf *msrc, struct rte_mbuf *mdst,
> +		     bool async, int idx)
>  {
> +	struct wd_digest_req *req =3D &sess->auth.req;
>  	uint32_t srclen =3D op->sym->auth.data.length;
>  	uint32_t off =3D op->sym->auth.data.offset;
> -	uint8_t *dst =3D qp->temp_digest;
> +	uint8_t *dst =3D NULL;
>  	int ret;
>=20
> -	if (!sess) {
> -		op->status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
> -		return;
> -	}
> -
> -	sess->auth.req.in =3D rte_pktmbuf_mtod_offset(msrc, uint8_t *, off);
> -	sess->auth.req.in_bytes =3D srclen;
> -	sess->auth.req.out =3D dst;
> -
> -	do {
> -		ret =3D wd_do_digest_sync(sess->handle_digest, &sess->auth.req);
> -	} while (ret =3D=3D -WD_EBUSY);
> -
>  	if (sess->auth.operation =3D=3D RTE_CRYPTO_AUTH_OP_VERIFY) {
> -		if (memcmp(dst, op->sym->auth.digest.data,
> -				sess->auth.digest_length) !=3D 0) {
> -			op->status =3D RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
> -		}
> +		dst =3D qp->temp_digest[idx % BURST_MAX];
>  	} else {
> -		uint8_t *auth_dst;
> -
> -		auth_dst =3D op->sym->auth.digest.data;
> -		if (auth_dst =3D=3D NULL)
> -			auth_dst =3D rte_pktmbuf_mtod_offset(mdst, uint8_t *,
> +		dst =3D op->sym->auth.digest.data;
> +		if (dst =3D=3D NULL)
> +			dst =3D rte_pktmbuf_mtod_offset(mdst, uint8_t *,
>  					op->sym->auth.data.offset +
>  					op->sym->auth.data.length);
> -		memcpy(auth_dst, dst, sess->auth.digest_length);
>  	}
>=20
> +	req->in =3D rte_pktmbuf_mtod_offset(msrc, uint8_t *, off);
> +	req->in_bytes =3D srclen;
> +	req->out =3D dst;
> +	req->cb =3D uadk_digest_async_cb;
> +	req->cb_param =3D op;
> +
> +	do {
> +		if (async)
> +			ret =3D wd_do_digest_async(sess->handle_digest, req);
> +		else
> +			ret =3D wd_do_digest_sync(sess->handle_digest, req);
> +	} while (ret =3D=3D -WD_EBUSY);
> +
>  	if (ret)
>  		op->status =3D RTE_CRYPTO_OP_STATUS_ERROR;
>  }
> @@ -935,13 +1001,14 @@ uadk_crypto_enqueue_burst(void *queue_pair,
> struct rte_crypto_op **ops,
>  			  uint16_t nb_ops)
>  {
>  	struct uadk_qp *qp =3D queue_pair;
> -	struct uadk_crypto_session *sess =3D NULL;
>  	struct rte_mbuf *msrc, *mdst;
>  	struct rte_crypto_op *op;
>  	uint16_t enqd =3D 0;
>  	int i, ret;
>=20
>  	for (i =3D 0; i < nb_ops; i++) {
> +		struct uadk_crypto_session *sess =3D NULL;
> +
>  		op =3D ops[i];
>  		op->status =3D RTE_CRYPTO_OP_STATUS_NOT_PROCESSED;
>  		msrc =3D op->sym->m_src;
> @@ -953,29 +1020,31 @@ uadk_crypto_enqueue_burst(void *queue_pair,
> struct rte_crypto_op **ops,
>  					op->sym->session);
>  		}
>=20
> +		if (!sess) {
> +			op->status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
> +			continue;
> +		}
> +
>  		switch (sess->chain_order) {
>  		case UADK_CHAIN_ONLY_CIPHER:
> -			uadk_process_cipher_op(op, sess, msrc, mdst);
> +			uadk_process_cipher_op(op, sess, msrc, mdst, true);
>  			break;
>  		case UADK_CHAIN_ONLY_AUTH:
> -			uadk_process_auth_op(qp, op, sess, msrc, mdst);
> +			uadk_process_auth_op(qp, op, sess, msrc, mdst, true, i);
>  			break;
>  		case UADK_CHAIN_CIPHER_AUTH:
> -			uadk_process_cipher_op(op, sess, msrc, mdst);
> -			uadk_process_auth_op(qp, op, sess, mdst, mdst);
> +			uadk_process_cipher_op(op, sess, msrc, mdst, false);
> +			uadk_process_auth_op(qp, op, sess, mdst, mdst, true, i);
>  			break;
>  		case UADK_CHAIN_AUTH_CIPHER:
> -			uadk_process_auth_op(qp, op, sess, msrc, mdst);
> -			uadk_process_cipher_op(op, sess, msrc, mdst);
> +			uadk_process_auth_op(qp, op, sess, msrc, mdst, false, i);
> +			uadk_process_cipher_op(op, sess, msrc, mdst, true);
>  			break;
>  		default:
>  			op->status =3D RTE_CRYPTO_OP_STATUS_ERROR;
>  			break;
>  		}
>=20
> -		if (op->status =3D=3D RTE_CRYPTO_OP_STATUS_NOT_PROCESSED)
> -			op->status =3D RTE_CRYPTO_OP_STATUS_SUCCESS;
> -
>  		if (op->status !=3D RTE_CRYPTO_OP_STATUS_ERROR) {
>  			ret =3D rte_ring_enqueue(qp->processed_pkts, (void *)op);
>  			if (ret < 0)
> @@ -1000,13 +1069,60 @@ uadk_crypto_dequeue_burst(void *queue_pair,
> struct rte_crypto_op **ops,
>  			  uint16_t nb_ops)
>  {
>  	struct uadk_qp *qp =3D queue_pair;
> +	struct uadk_crypto_session *sess =3D NULL;
> +	struct rte_crypto_op *op;
>  	unsigned int nb_dequeued;
> +	unsigned int recv =3D 0, count =3D 0, i;
> +	int ret;
>=20
>  	nb_dequeued =3D rte_ring_dequeue_burst(qp->processed_pkts,
>  			(void **)ops, nb_ops, NULL);
> +
> +	for (i =3D 0; i < nb_dequeued; i++) {
> +		op =3D ops[i];
> +		if (op->sess_type !=3D RTE_CRYPTO_OP_WITH_SESSION)
> +			continue;
> +
> +		sess =3D CRYPTODEV_GET_SYM_SESS_PRIV(op->sym->session);
> +
> +		if (!sess) {
> +			op->status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
> +			continue;
> +		}
> +
> +		switch (sess->chain_order) {
> +		case UADK_CHAIN_ONLY_CIPHER:
> +		case UADK_CHAIN_AUTH_CIPHER:
> +			do {
> +				ret =3D wd_cipher_poll(1, &recv);
> +			} while (ret =3D=3D -WD_EAGAIN);
> +			break;
> +		case UADK_CHAIN_ONLY_AUTH:
> +		case UADK_CHAIN_CIPHER_AUTH:
> +			do {
> +				ret =3D wd_digest_poll(1, &recv);
> +			} while (ret =3D=3D -WD_EAGAIN);
> +			break;
> +		default:
> +			op->status =3D RTE_CRYPTO_OP_STATUS_ERROR;
> +			break;
> +		}
> +
> +		if (sess->auth.operation =3D=3D RTE_CRYPTO_AUTH_OP_VERIFY) {
> +			uint8_t *dst =3D qp->temp_digest[i % BURST_MAX];
> +
> +			if (memcmp(dst, op->sym->auth.digest.data,
> +				   sess->auth.digest_length) !=3D 0)
> +				op->status =3D
> RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
> +		}
> +
> +		count +=3D recv;
> +		recv =3D 0;
> +	}
> +
>  	qp->qp_stats.dequeued_count +=3D nb_dequeued;
>=20
> -	return nb_dequeued;
> +	return count;
>  }
>=20
>  static int
> @@ -1056,6 +1172,7 @@ uadk_cryptodev_probe(struct rte_vdev_device *vdev)
>  	priv =3D dev->data->dev_private;
>  	priv->version =3D version;
>  	priv->max_nb_qpairs =3D init_params.max_nb_queue_pairs;
> +	priv->nb_qpairs =3D UADK_CIPHER_DEF_CTXS;
>=20
>  	rte_cryptodev_pmd_probing_finish(dev);
>=20
> diff --git a/drivers/crypto/uadk/uadk_crypto_pmd_private.h
> b/drivers/crypto/uadk/uadk_crypto_pmd_private.h
> index 1f55d09a54..cb60cc2ffa 100644
> --- a/drivers/crypto/uadk/uadk_crypto_pmd_private.h
> +++ b/drivers/crypto/uadk/uadk_crypto_pmd_private.h
> @@ -8,6 +8,7 @@
>=20
>  /* Maximum length for digest (SHA-512 needs 64 bytes) */
>  #define DIGEST_LENGTH_MAX 64
> +#define BURST_MAX 64
>=20
>  struct __rte_cache_aligned uadk_qp {
>  	/* Ring for placing process packets */
> @@ -22,7 +23,7 @@ struct __rte_cache_aligned uadk_qp {
>  	 * by the driver when verifying a digest provided
>  	 * by the user (using authentication verify operation)
>  	 */
> -	uint8_t temp_digest[DIGEST_LENGTH_MAX];
> +	uint8_t temp_digest[BURST_MAX][DIGEST_LENGTH_MAX];
>  };
>=20
>  enum uadk_chain_order {
> @@ -64,10 +65,11 @@ enum uadk_crypto_version {
>  };
>=20
>  struct __rte_cache_aligned uadk_crypto_priv {
> -	bool env_cipher_init;
> -	bool env_auth_init;
> +	bool cipher_init;
> +	bool auth_init;
>  	enum uadk_crypto_version version;
>  	unsigned int max_nb_qpairs;
> +	unsigned int nb_qpairs;
>  };
>=20
>  extern int uadk_crypto_logtype;
> --
> 2.25.1

