Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE92BC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 07:38:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B626840299;
	Mon, 29 Jun 2026 09:38:52 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1EDF54021F
 for <dev@dpdk.org>; Mon, 29 Jun 2026 09:38:50 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T6mQSZ1203090; Mon, 29 Jun 2026 00:38:50 -0700
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020099.outbound.protection.outlook.com [52.101.201.99])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f32s6a27y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 00:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmLkQhpbgUgGtA00e3y9BDNmwBRCpFt8V97JAvIbwqlaSxJcYcw1G7I5gmiP5HTDgT3Jg7bbQufewHGuy/jIDmY7NhYg1cQjTT5oCanbj4WCAb/9VdD5Ul10TqLvXgjlSbLFDHTdUgjTBR0sGSGLbmDWlpcKef5YBT2GW2U7dBHI+z/QEsON4ht7YJ8u0mqcA0gftPLsGk///sJswZOg2Exa4OPALgcomEIsYyAeY6qVYHzE9ug15iWedebKa0GIVaDdM8SSmS/jMs9FiRgs8bGvGcpng/wIiIhEsDxMfwm2j1M5HW05Nr3dXN+WCPfE59b/0eyD2rcALB3NzBIC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tFk0kMWZMTJhCYdBrVM4rUhF73BeceLfat/65+EyfU=;
 b=B9nWitxYIZwFM5kRTZHc2f30mi5TA9OsUWTo0GtBhZ3rxLqwIxzENdGMICV8767VmBoACgbXKfeJAsQeMMKKfR/WKkYBwXiTbGYgS5V4AOyZw0jXVm+9gFBHUbsRHljxEV7OUHjHr5qsbMOdoSK8bUhNK/JKACBdpBZFjrfaYRIskTRtwzFN3a0moHc9olqEvsN/yqF7hcKIDfe5/K6vnVSdlDYeBsBkcnGlBoA9Av+r/dIxoIkv8vnrhaAs1DCWcStHSr5q3LyuzEBxFNFG2beFJgm+wzPURENg64pvGICHxns5XdWch1TGIdwBWxwMnHlzLHPSq6va6e0Pt3hh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tFk0kMWZMTJhCYdBrVM4rUhF73BeceLfat/65+EyfU=;
 b=LK+r36zF8c0U37cRGvs+YMx6GFIPlODCBaylKHshku+eaLt4CF3bFihjZzx5ongM5NEz33aH0V9p+iGLn7168N9hBXny03YINSbf87Gu89lT/fTPsARp7ZC4hfom119fy7uY16NrLa4VUvzPe81EqCi6+HllQUpWpgpi2pohMj8=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV3PR18MB6283.namprd18.prod.outlook.com (2603:10b6:408:26a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Mon, 29 Jun 2026 07:38:47 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:38:47 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH 0/5] crypto: use timing-safe digest comparison
Thread-Topic: [EXTERNAL] [PATCH 0/5] crypto: use timing-safe digest comparison
Thread-Index: AQHdBLv/cMZcWufeIky2h2T6bVQfj7ZVJ+3g
Date: Mon, 29 Jun 2026 07:38:47 +0000
Message-ID: <CO6PR18MB44847D731A66FF470CDDA996D8E82@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260625160200.24170-1-stephen@networkplumber.org>
In-Reply-To: <20260625160200.24170-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV3PR18MB6283:EE_
x-ms-office365-filtering-correlation-id: 0cf36f4d-d60d-4e1b-7462-08ded5b1749e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: hsk+R/tbO9aqes9JJ35w3vNEZOfak9nJQxIm2fPH7yDAN7p001Zc99U17pQWX3YLV5dlu05LwN8Dd6YBlLsVhBMOL6SbSE+EiPyVk83AQLLa/OIkxwF3s91U2C1OY4ZYJMfyUU1URXAl9Icl0tQ0RsqIaEa2RiJEDb1Dvb2coC8KNh82Zhrra6yzy4SR2KAnQbHVyJRFM6STPjy4VrbJ0ky0zML9EPQsf+14PGNmzb9t6sswpU39S+4ZvxcMRGQn/fARVuvEXMb+/Yi8MQboMahzbtiFGpbR+CuGkbFijHlUypnt7kDvehNuSXivVIIGR54Z6lid9fcrJcxwQ+hyAW2oBm5MVZQjcIEL3yfpFbAb7meaBVss74Kb46Wo65olO3Iix3Z4bI8ErvKkYkxwFI0lyO1NK+88Ns8ZARDaHq5GYfRPWjqPHFJtmZxoBS3noMHmnqdRpTUuE9UW6pHa744YTxekyN7a9jX5w7+9jGe0NgChYAZPyHBdsWrCztsmK3YI3p6VUsAVGVlmAohX39/4+tuJC4Qer9FOjdxFGKi6hv3WLVE9/DqW3qWf2orlwJmb0E5Lz1ehY9g1gvtDBH61nFKyH9gfR2NzakRNQCaDtHhGaKMNpp3wuqS6XethRlMabGFLWwGEgyF8O3hqOvzV6qjRyKe1hGucA4JcBmBIvhW2GSZeofXZYScmDPsEoNlpYS5ueSubGQ65eUcrbQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wWbQlK8ryqWSkZMESp91azljTCfcJ8cP6wGSM8RxayVgsZhZye7rTFCoP0Mx?=
 =?us-ascii?Q?o9e2+AHKbNbEhoNdEbBfut7sp36yn5Sawft72V2hCDNx0Qvvk/I0ymBzr6YW?=
 =?us-ascii?Q?D3imxHl8XqyC/aREZrITIJQ2JI6wDbJdB1YoGzBQYx3vs2qbPQllU1LQ+m3M?=
 =?us-ascii?Q?ejxYFH//yr/+pgO/rOMB2QMy+/r3VHcxMvO0Kd7iX39qRfpQDtuBGu4dN4Re?=
 =?us-ascii?Q?tcCzipItihpzt/SwhxLy4yG/shHypojUuTPdzVsYmsp3hehfBVqNv7zoMuq2?=
 =?us-ascii?Q?ug/+KNL4yqMoPwEhLFSnWF5UkUl9vic1XMEgu4vmIZiAvmFFcHNIWmJXlcSr?=
 =?us-ascii?Q?X2Ir/fn9XLRaDpYmhXWMLKkR0bbKJz5fZGhluZHfS5QbxdDemIeuBGQ/XOyP?=
 =?us-ascii?Q?g83u8jJyAsV7ZG6wcd49QMT2r4eFMrmuHPcNN6paANMHYk0vdvILyVHdOkE2?=
 =?us-ascii?Q?ZtNlVe0GrLt4OSWLHVpd1LOhmNnQuB0Tl7QiHdX+gZxtljz9sd9Re2MAjC2V?=
 =?us-ascii?Q?HKLDyZdRej8KIcvlTyxF+E4KrNRsZ23InMTsM6dWwh0mlhH1hlX6mhZxkwlD?=
 =?us-ascii?Q?qAl/aRkwylsuk82tdbsaNqyWb6li/OZcF34Csdd/xyzJp4I2PsLwt5ne++gI?=
 =?us-ascii?Q?6VAH+5pidtglK//+EGXbVNwAsHomvEh+UkyrolFCf+P8Hq0Q1+dngRYCIKhy?=
 =?us-ascii?Q?UZNO0/iOWdDYGIAnCg3VTGmIxlIwAx8T/PIARv9x/cZkanNZYlvqJFy7q4DO?=
 =?us-ascii?Q?lW/0nsS2GqbNqcuE6eW7ctKLlxkVR324kWYDiAH1PFwD6P5t8X60ozDJjjzd?=
 =?us-ascii?Q?Lf6VDZ5/q4t6u2fdgF/OcHYch1jUw4UluzjAswLCyhJjAZzKQ2Y8CVxXPV0G?=
 =?us-ascii?Q?LJXg9M4q28ym/Cu1Kugslu+6QlJRLafP7TYsRI1/aWIvjNQSRukNOAIFE8yM?=
 =?us-ascii?Q?+0ErsHy8n3uPYgu6Xk+wN1QJCTxPfNhZ22+V2nutn4xPhVkojYDsKmrjX1q1?=
 =?us-ascii?Q?lYQV9NCXDgKRmKLS2WB/y0k7avR50HqLQJbKJG3d8VqUxee2jCFERnX+CSvX?=
 =?us-ascii?Q?Zxzczs6vMV5Ux1pgOSLVnHB43gva9ZYbJCYisZ2c6Vjgs3xfriX3q8lLJv4T?=
 =?us-ascii?Q?rVZ1DMfHKvpoBgvyZW8y9yPvKH+rTx/WpCosDH7kM7btcdqxbjktl8qtzxrT?=
 =?us-ascii?Q?9XG2g/IC2pUiK2700mxZraaGhYaAv/j+2YLA2omWmzUMYx3HSIMcLutySvjs?=
 =?us-ascii?Q?atn9cDNYA8hFPImAYO9qHZUsdSLVjv801NtR7wVZL0UV1cAYIuQ09XAWOIx8?=
 =?us-ascii?Q?5StEMJ3aOj25j7LmjEYziF9iwvEheMdGANQszQcdKiaxFQG/JiVbAxQT0drm?=
 =?us-ascii?Q?lvZI9BImbNzRfyu0aNzWgQBXAuPHa16d7OTH55DfsJfyKrEmOSpZ5YGS8rGP?=
 =?us-ascii?Q?eVaIijS1H1zVTvjcchlujDKaoDIUQ6pMs0jiJPtCeJjMOnsrbqBPN2G05ngz?=
 =?us-ascii?Q?1YIV3otUHw55gT3OqP7nJ/N5RUXrYtjy8mZ/hnC+o9GU5APlr/tqiqR7g2v6?=
 =?us-ascii?Q?J8KDVJ8ozg9AVa/kUSnrKwgDHEVwDHj58bGBozm/E3JdNHria2AHfJl5eLzW?=
 =?us-ascii?Q?oRivmWBogooMk4m+EHjYnXw4jg4aCpniwT9WWsA2FuIRbnqjDKVVTGpfI401?=
 =?us-ascii?Q?D/UlxY9OG3HS/ZW8dqcgYLRKL0v/s4sJ8ohxUZHT6NA9vE5m?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h+XvYkdwwVtx5hgpvY9ObUxOx4vn2K3NGIjt3e4GG3ZLuHg9AxId3kklU2PvFDGfTeGWXf3hkrERnhYZR1kpfTZRM1n5uM+AsaEjouChOR082HvUyDU4PteJmxKTH2u7eRoydC2h824AYRMvMZ4aZS/YqeYNjrB69HQjNFIxeA8aV09qar8cDT6pdYxTWvkP9uNsZNK0aGRZTpcjbEJiS6eHMXvZPFy9qHMu41sIISZ+1u7MSg1xqjHdQUCger2SMBzUTab5GXLAZUBOnzrT2YahLWVj4/4cKACTYU9f0FpftDTFah6lD3HqlaoHDz8E5w1W4/bp+l8BxwJY1JJS8g==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf36f4d-d60d-4e1b-7462-08ded5b1749e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 07:38:47.5154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2IqRKPEwZr99FOcSEoiZU7eULXgnSKzmtHr0yjcDkGbj3N4l027z/jYuS9llfAkfwGu8UyKPRr6SW5KHhNQew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6283
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2MSBTYWx0ZWRfX3Ch+VQoo+BmY
 PVLUo1EujZEdMeP1BEhD+oxAahfhzXm5uMIPLN3bMXPpNxvzhDu4Lq3roTDs8qf0MXZfYrel0HH
 I1eGJYmsgW1PUoNDz2B63F46qGfLiVJb02cJht/cq35YoaYXvSfqlP4qtzbzRHDpZPxPRQMGA24
 EEN2KuSnRVCbmTbOF+D/OHMnIs1GbCzM9psf1qxI4W9fL5tcZ2jDzU/MgfC4vskkg1ow0Rs0uBi
 9qxCnDkwqlakOKX0t9tl5iihnj75x1a6I6YzjNaZetkNBP4iHJ3Izu+V/jb+Gl2UzeeBDCTpWLB
 +YJaw4Aa7WaoAwOF6Qq4QprUXie/pID79Ycy9v83ov7HgwJv+szF4HGUtDcZGNQH9vWsdWf841M
 9r4OICTlLPGprd303c78l06HvgLo6Z/pb1i9vvyY1SyOQTRp+9kggiFgT6L/d65qty43kE47kqn
 GnLkiNLhy6iJDFqW1DQ==
X-Proofpoint-ORIG-GUID: -ibiG-1tCUKTU-7fi5kKWn1NIPi9B4Z5
X-Authority-Analysis: v=2.4 cv=e6Y2j6p/ c=1 sm=1 tr=0 ts=6a42210a cx=c_pps
 a=kJh41/vVy0mmRivLipeQDA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=OC9a5Y6VWr7jzATkZHsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2MSBTYWx0ZWRfX4la0V4i+9X+P
 gjG3WwYakCHqwXNfCerXoS3cziL7bE2TfJyro4saPN1PXmZyKPjgqq9uZFWfDJV0H5il0Ed/Z/5
 M+F1KQ0X8n5I9z5KNat2FJ2+ig7t9dA=
X-Proofpoint-GUID: -ibiG-1tCUKTU-7fi5kKWn1NIPi9B4Z5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
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

> Timing attacks in DPDK crypto were fixed earlier but
> several drivers did not use the new timing safe comparison
> operation.
>=20
> First patch drops the experimental flag off rte_memeq_timingsafe().
> The function is a static inline with no exported symbol, no ABI change.
> This avoids having to turn on experimental flag in other drivers.
>=20
> The rest convert the digest verify comparisons in the uadk, ccp,
> armv8 and cnxk PMDs.
>=20
> This problem was reported for several drivers and for those
> the Reported-by was added.
>=20
> Stephen Hemminger (5):
>   eal: take experimental flag off of rte_memeq_timingsafe
>   crypto/uadk: use timing-safe digest comparison
>   crypto/ccp: use timing-safe digest comparison
>   crypto/armv8: use timing-safe digest comparison
>   crypto/cnxk: use timing-safe digest comparison
>=20
>  doc/guides/rel_notes/release_26_07.rst | 4 ++++
>  drivers/crypto/armv8/rte_armv8_pmd.c   | 4 ++--
>  drivers/crypto/ccp/ccp_crypto.c        | 8 ++++----
>  drivers/crypto/cnxk/cnxk_se.h          | 2 +-
>  drivers/crypto/uadk/uadk_crypto_pmd.c  | 4 ++--
>  lib/eal/include/rte_memory.h           | 4 ----
>  6 files changed, 13 insertions(+), 13 deletions(-)
>=20
A couple of more instances which can be fixed for asym crypto.
drivers/crypto/octeontx/otx_cryptodev_ops.c:742:                if (memcmp(=
rsa->sign.data, rsa->message.data,
drivers/crypto/cnxk/cnxk_ae.h:1924:                     if (memcmp(rptr + 2=
, rsa->message.data, rsa->message.length))

