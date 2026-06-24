Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E408ACDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 19:47:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A43D402C6;
	Wed, 24 Jun 2026 21:47:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A500B4027C;
 Wed, 24 Jun 2026 21:47:03 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEglA44100680; Wed, 24 Jun 2026 12:47:02 -0700
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020137.outbound.protection.outlook.com [52.101.61.137])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eyqqhx5td-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 12:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHRcS0e8sRT0pDgD9araxspAVc88KMqkxMTu0D2yh6UDtmAtZZ8xbNmTdNB7ksGAV2C82SbH5jhxour6bVozFO0yze0Y6RgxKjKTxLE0EcHTi9ZzLFkZHeIlC8dOJ/V65NNNdk8EZWWwGM77Snt6lQAOaCQSaL2sM5yBT6LUV69wukfZgmS4ZAfrPLZeCUoUHmI6LID98vlZ9bbit/GxMCLWO8AU1H47I/COOaU4i649A8UOQ1UdVvhdHraQDxfgO48dO860ohIoC1eo1cPFuePk76PnSuk8ctTjkxCO8+R4ZonOmtHRQyVUI/cOEumGOcSlxHMeIoh6ZmdEhsFrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQuZl/0P4x0n+QKSv3LxNJr2a1eGMQMSDTSnUkL8Me0=;
 b=Vm92lD5fkr/m6uBCEiTXRD9GhaFKmPf8/8MfcQDxW5f13wFIQJ8Vx6q/ccstTHA6NR1THCG6ldYa+CMAGGtWqC4R738/WHGAkB61Xmuf25DP07IVv88x0Ikq8/9kfhJ0yI8tuhatdAhhX43PzE+Q+pe/nS493VFtS2v+UI98Oc2/W2d2TTfZCLfyRqj4Am1ovEXaxJ4r0FWa8rSpIgjijMdmKTnwYb2fK+nuIc3+1xLA5cCh2p865vi2Ve1i0cvVMdBpbpFlMDLGLd9ZGJQqtk0igYEO5//N4kJ3u8PlCjbfgsI9yAsYOamY6tAVXUvkLZAxx9oSOrQHK9S8MlVlCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQuZl/0P4x0n+QKSv3LxNJr2a1eGMQMSDTSnUkL8Me0=;
 b=JioNWb2UPFNDy4j4SC4YfjnWlhFD3o6kOCWdjXXNbQS8K2813E7clpS3ku2uxD+YprWGs8G6vbivFtn4JtDvdfzkr9S7qgbZnPbolXeke5+/9aCyvdjEsPmEOp28rUySrYqUE9vhgTkPX/e6KT1Eo9J3eZZorCTxmOHV2O4xRQQ=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 IA3PR18MB6235.namprd18.prod.outlook.com (2603:10b6:208:51f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 19:46:59 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 19:46:59 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Tejasree Kondoj <ktejasree@marvell.com>, Daphne Priscilla F
 <df@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Anoob Joseph <anoobj@marvell.com>,
 Daphne Priscilla F <df@marvell.com>
Subject: RE: [PATCH] crypto/cnxk: fix out of place AES GCM
Thread-Topic: [PATCH] crypto/cnxk: fix out of place AES GCM
Thread-Index: AQHc+jOWEXm/H9z2Hka5b1a6bh87j7ZIwHSAgAVvbdA=
Date: Wed, 24 Jun 2026 19:46:59 +0000
Message-ID: <CO6PR18MB448437A9FDD0DC35DAFD6297D8ED2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260612062009.3587783-1-df@marvell.com>
 <PH7PR18MB5177F3AA522F8CEAF8B25253A8E02@PH7PR18MB5177.namprd18.prod.outlook.com>
In-Reply-To: <PH7PR18MB5177F3AA522F8CEAF8B25253A8E02@PH7PR18MB5177.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|IA3PR18MB6235:EE_
x-ms-office365-filtering-correlation-id: 80d9b407-9827-444f-db7c-08ded2295afc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: vygeUAG/C68765WV4s/v4hhToDukqJBKzRRPnrb8jvfylYKVVg2ZjHFZZkQbnXMOms+hvq+u3lAczC3oRWp2Z96GrfLSOj4XZ4TYTOzDH0CHLDWTD2JEYvj/NtucmHJqlFoM/AJvowa4wtVtDVSBGzNKXSBGlLA6EYNRd4YaJ9iV9nJWzrwTjcMLqE7q1Kb+g4p6A1TbnztJwHd9SVE1eWBEaU2lKcu6yYCRwz3QwYKfIHNYrG+gxoASsObghvVVK44PDHcL/sAR09SzqcABO0Pn30r45jCRHWMOAIw6PlqYjy6ex7+SxaAokX2HcpM3ia50g3E0sSOb3+QJjjPfaaNkVcoyKRyJi468oEGiYnyDJ4jmTtduPWXnRO8DIemHqryY6jclJ0S39Iv0YE8A6AGVutm5tFQTC2K6rma6bddfZQTl9KInQwti9C/5VkuU2hNRbHidnMonb8QUaWsBBeaHSuohXB5KnGkkEIimI1QxFhKVSdZwvlI1MysLj0mBdPACQ+EPCiNs/x++r7833maFylr1wjwmF1Iix2FuKSiOweuhTbWG3XjLWOCCxJVx4Izt+xuSMqwU1QjmjOX8DNdqtfXl0djjher9rJxm3Inde9k5yOeLhLbm4MaTG3R9+2K23GCw78U9IWB1XRqTnpoFs3tP1GAEr7t6DKS5YFilifZyfswWRPCHzpGhAxLskuNk6DE/KBBVcoDym2f4TUro29BU5Wqqz4iTQARUp9o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1WGVcV8qWpVlT6YYEArWW67m59SZqUmbigYPtBt1p0RPVVfREVEEwXdJv3XQ?=
 =?us-ascii?Q?exSmn/LDj0LuUf3s7I2IBg5y4Dc7bYeuzfFvyRgyzChCVRiFi499OXC/t4ES?=
 =?us-ascii?Q?gNNIUExJLztsqfqDKRBUiktwifQiH2L3j3etNlJNUJY1QUCnwlE9BdGQbKE3?=
 =?us-ascii?Q?PXvlJ8vR4JZfn8tR1MiEDQxdPqxIkC9+baqKY03wjDOWKF5debjqg3U/bTxp?=
 =?us-ascii?Q?6XTI7MePyTGLUCZXY/X6EXYNg35mURabLTt7XvHALhzT1RfCwHarP7uRAvd6?=
 =?us-ascii?Q?7UyOwB0lPsE7uLWcwDegzSFFvohLDOZd+C8WLwYKGWtzmy7pxqnaE8fnX+MB?=
 =?us-ascii?Q?qiYvwAZBYVnWiYESl3yuypKdQi0eHLJQXOEZ19AuJrKiGlpU1tSyHcj966dZ?=
 =?us-ascii?Q?dXi4qYYdjbwSKp9lkT3tkPKV0R8V+UYqmFOZOIK1aylTHCNfLhhdad1pxJRp?=
 =?us-ascii?Q?HLXhB6rLGW8grE0PTLoMt89ehPB7o9IpW8L15RYXPQIVh+sJSIYGyZy6/j2K?=
 =?us-ascii?Q?NvEIvQXDvru+J0g+9AF1C1w6XzcxOYuNObGfh//iaUDfZvsofwhooIuX47jJ?=
 =?us-ascii?Q?rsk5Tr3NVB3eSboctxfb42eW84tTVAoU2cUJ9hutaEt2sfvQFcXAXW6MxKlY?=
 =?us-ascii?Q?xfp8jsb1B1jwCgCFWN4CQTrY56+GDmaqYusgCbJbWs13uS00FX+gWTOr+ZlQ?=
 =?us-ascii?Q?cvIxlpnCi26xUu2jZsYG5l5goqPoWnGWd+ZZExnbOSYjXWoqoHzUSXLaNZWI?=
 =?us-ascii?Q?JO+3KGjqwa7AP0qBhyVkheQ5msWH9aCcvy+99WPh2z9vStDMiThPMfq/yXe8?=
 =?us-ascii?Q?lzkQUXpHm4tkVOOAKYLGsDR399MA5Aqo8q0xH1N3dWJZQEHsiSZWqI2VxMAR?=
 =?us-ascii?Q?j3vbm63LRckkUuCQIU1eD6aKsCvHFSvBziaqeoqSgR3M3SqLo6KMFjAaHfk4?=
 =?us-ascii?Q?2Sve2oaTh5eh2yNkSNFs8Izbm7c3tsHWfb5jeXZkPnCx9Jlk+t2h94i0btUX?=
 =?us-ascii?Q?T3ggkmLYJADC8VQQyzfbzDWF8lwlCi1PndCytygbN4LnqLOPwSOw2VXh5ivG?=
 =?us-ascii?Q?pTdNcwl9G1XfD40ISV5rLi8vi3mqjWw+uQKAm4CkZ7ETvQhd9sSax7rXBswj?=
 =?us-ascii?Q?kplxGQJP2wL3MnjI7912hYDm6yP9WVB3VwNPMLYTjGM7UH3uxprNIWCezOgn?=
 =?us-ascii?Q?B8VYPn+CFXIk6AQsRZMsnaROJCdL7qsGD9tQaPtBRQ7NuE0MX9wfKS1S0rRD?=
 =?us-ascii?Q?8IUkSJdkAj02YfvhgS8ST15lR36dqg/JKUxv5P1oh7k/PUydlDaq9ChXDDnz?=
 =?us-ascii?Q?3Mz5eO9b3D0qxSUqi0BljAvdohsuqGMdghijeaaUBSufpMdJsQ2sBeEbrB+S?=
 =?us-ascii?Q?UEej5c7MYyABABRyT5SQWmJffTpj09KEqy4PYsM6RLUgV1tNamVIe8MnAAbH?=
 =?us-ascii?Q?yU925dl9iywnIHV0MylfukKvrudRKmEi0xe5JuEUxZQJCUr+dk/afiughyu3?=
 =?us-ascii?Q?CxpARw8D4lnpo/X1AzSZoXAztxSlz6tVea7hIWaiQ79m+mF3PJFXK11OUhgA?=
 =?us-ascii?Q?fToUle4g2r+2+XSGOr4W8kufZlD6AiV7pGJaD1B2ELHP7HFWMUzj7k3m3zAi?=
 =?us-ascii?Q?8T46CFAty2UrczyinWPcqCEHFB6gDTIXE76bL0Tzx6buJB6zEcaV4b6Yh5Oz?=
 =?us-ascii?Q?HRdDag9bdtcXGPJUlH/uuTmFUPuCmovxzO6pfC+3UelMKcFC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nSf5q9wGlm5rJsbJYCg0w8aGYfhrcqjG1rtZJitJjV8PJmXLZX8BtE+Dmn/mITG39bDcE2vPoLGFP46oGoyLFy7faVEKfsv/zTbq6Uj5ZcxDeEQRCOD6LUtP151Hm5lm+Ls0nBNXtqEhRo9PCKR/y0XwlDhH1VX/p5RuSOwgCnXkTuYGKkTEKJTFUzPQibIi6N5UDTctfa4m7sAGC1Du9+THg2pGzDuSWh27Ncg9gmEB8sYp8wMdOG2pCvGRPAuGMy0PAq7HV/phDUe8IxUvZLCPrMwwavio3etanfxEwW4jv8BOnfogJ4UrCON7G9BP9IUXW5vO1azE/KIlhUmGkg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d9b407-9827-444f-db7c-08ded2295afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 19:46:59.4766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fz7ok9zs/iIPQPAq5l4+EPODpV8jKNWoQeMAacnKNOA7ZHhTyAZri+D7XPLexIPY/YH2JHZ0Mn3j1DqC9Ow1UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6235
X-Proofpoint-GUID: yP7XQ_OEzNispRkHWD8jt7LpNtZyZliT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NSBTYWx0ZWRfX1n5qQhD+/Uir
 wHO0025+17i0XMZ2vjsmRCldpd7Dy+1wTu5+EKlnIYYY1stq4Upyt4RkS72kyfjl1cG7ZAYQcsF
 a+sho+8y90iWPzu+9HyEF0bDJ8qWJXw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NSBTYWx0ZWRfXyfDM/My83oAG
 cp2cP+hg1dVL0Xo31X39978uItHC691acnyhSlsSPIcd/B1yuq49p2jJpLGUohv4z+dS422xbTr
 laiuDji/X0i9Ez5YPk91e/xWti0GZVXP8H2W9t9TyoF1NwMyjFRR5Drkcys26u5LFrKLubxIcTS
 rzm6KnDptePA7pYwJxpxE1XUsmcJ+TKeWslAZm/npoCQRc9IvD4QbWiHE5uW17JeWEoZjgrOwuR
 hP6PBzyQ0JUTZYXcj6r/+QDMJdI6qudpUuHOyHe94jzFf9jIXsaunUsmUvAPVyb9G4otjAHIXn+
 B3nM0JInbnglQytr1df6WOrcRrFLmqg3h0hldZuto8QNmUF1kkGfOJjmxqSXN0jctspo5y9nUoV
 kFGqcbIgSki78J6UJdqXXfYh7o+aO+8xJDNcdU60sDoWXj5edytG1ZIW3w+3SKapH90K4ytGLT2
 C7DKzmdUgqkRz9hMCJQ==
X-Proofpoint-ORIG-GUID: yP7XQ_OEzNispRkHWD8jt7LpNtZyZliT
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a3c3435 cx=c_pps
 a=IXfcYWxja++gTjxmAJNAjQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=KJ9r1o3YaBOkuqyJtUQA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
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

> Acked-by: Tejasree Kondoj <ktejasree@marvell.com>
>=20
> > -----Original Message-----
> > From: Daphne Priscilla <df@marvell.com>
> > Sent: Friday, June 12, 2026 11:50 AM
> > To: dev@dpdk.org
> > Cc: stable@dpdk.org; Akhil Goyal <gakhil@marvell.com>; Tejasree Kondoj
> > <ktejasree@marvell.com>; Anoob Joseph <anoobj@marvell.com>; Daphne
> > Priscilla F <df@marvell.com>
> > Subject: [PATCH] crypto/cnxk: fix out of place AES GCM
> >
> > For AES-GCM out of place, when AAD is present in inbuf before the data,=
 it is
> > treated as passthrough data. This results in AAD being present in outbu=
f
> > header, but test expects outbuf header to remain zero. Passthrough data=
 is
> > now diverted to metabuf so outbuf header remains zero.
> >
> > Fixes: 7c19abdd0cf1 ("common/cnxk: support 103XX CPT")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Daphne Priscilla <df@marvell.com>
> > ---
> >  .mailmap                                 |  1 +
> >  drivers/common/cnxk/roc_se.h             |  2 +-
> >  drivers/crypto/cnxk/cnxk_cryptodev_ops.c |  3 +
> >  drivers/crypto/cnxk/cnxk_se.h            | 96 ++++++++++++++++++++++--
> >  4 files changed, 93 insertions(+), 9 deletions(-)
Applied to dpdk-next-crypto
