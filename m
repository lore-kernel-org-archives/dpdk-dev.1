Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F187DC5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 12:28:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF29D40E25;
	Wed, 28 May 2025 14:28:46 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8CB6940DFB
 for <dev@dpdk.org>; Wed, 28 May 2025 14:28:45 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5qmgZ021285;
 Wed, 28 May 2025 05:28:44 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2131.outbound.protection.outlook.com [40.107.244.131])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46wq8219q8-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 May 2025 05:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pklrdJkVF99yC5QbS6zTVCMrMDXriLJXp+DgkgLxIxCc6h0gh2Kek7UrAudCXwk7Jy4L4FycbJ7fEogs9+QJ5jGQYBpwMbFla7JLks/54tFo4smf6t3E5/BcIugw0/p7MyslrTIQIYaqaqX87Uk3OLvLuTFHLy2mUQKYGm/VAyFSAJTmq6x8KTvrpx026LhHLPH49BcN9rg4vuAVDYr8Xi35MmINMEXVi4Abx+eokTj67JpFW+C2d+VpJmZPffLZdkiMS04ik1tVkPDpzpJCG91/MmLd6uMr9fDY24bgRfRZ0tSgCU8TjcTmXFLDiSFFGBeouMapTjkqKG6q1vNxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCBAdAQMnekbmHxWzxpl4MyAe97l5XvqFZEcONzY0a4=;
 b=LW72IkCEawRLaZ5UIIJg7ABby37wbYJRwWfKVHqygNvhJWzepLltpvtHpIGR2GlRsNFUWXSWJ7Ke4Lyzj+/2r7UPhcNS5qV4qpW8I6H9zZVcYMQ3eAIyobWBZ8lP5asvkNoMH0r+so9wbQARX1jf3gGHNeKZjDP3c9M5NfULWuc3H/7bJdfDStNLJ/cI4dtHOjRgLxLgmOnN/UToFCMDn5k6vxhxGuG5DDykExycY512lo8362VkuI4zuc+cbOVzv0TSMXbbRXn93I274yevzSumJGuypLw7ubQnCiw+OOoaVYudm+6Qm27tTO6qEcYRXoYJgBcCUBK6uwIiDd1xdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCBAdAQMnekbmHxWzxpl4MyAe97l5XvqFZEcONzY0a4=;
 b=GANHzqOAK+ytDBACL+/9tnBWIrTGUhevDIiGKaNufOAtIT5igtZT8+RNjJGTyfUfAwIA6u2sq/P6mAy/ZInV/EAfFFxyHugt1Iax1cTS4NbrHr1feHh1hkonUj9aVUT3plEc/uHocRjsswGdF/jj/o2L81UtWjpGU9sEwJJIso8=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DS4PPF4C1E661CE.namprd18.prod.outlook.com (2603:10b6:f:fc00::a97)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 28 May
 2025 12:28:40 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8769.029; Wed, 28 May 2025
 12:28:39 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Jay Zhou <jianjay.zhou@huawei.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, dpdk stable <stable@dpdk.org>
Subject: RE: [PATCH] crypto/virtio: fix DER encoding of RSA public key
Thread-Topic: [PATCH] crypto/virtio: fix DER encoding of RSA public key
Thread-Index: AQHbwZgQfxzZwjlyLEGkZ8AmKQWLprPoFG7Q
Date: Wed, 28 May 2025 12:28:39 +0000
Message-ID: <CO6PR18MB4484F51E82028936378FA0A3D867A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250510104103.2081-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250510104103.2081-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DS4PPF4C1E661CE:EE_
x-ms-office365-filtering-correlation-id: da330a7a-0b1a-4f0a-b85d-08dd9de32d3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lvTthj8sk0jewbFN5Ng6usDHUBrXAcI1z2sN2cPeDG027c2isAUtORBdxAmb?=
 =?us-ascii?Q?hp5Ee8jFT+dO1UAQLr3DoBELWR2mm/uzx0pjAbs/P5YsxmOpa3M+PvD01TBB?=
 =?us-ascii?Q?EdkxHsVgj8Mw2HJNuMZr7xKUZH4D968iXYBMPgfyzorW/SmwB2mxsx5AecuU?=
 =?us-ascii?Q?j89SzSG2elXlblXWF1DujmMfQXJgZN1IV6fkpHJmsZk1tIFLdGbd1JzsYv/i?=
 =?us-ascii?Q?L/Q9GATnnfWdAe/SK/Zo6YokjXrUbRsR87H1FHHbCMTdoBqDPPfxCg6TVVKN?=
 =?us-ascii?Q?VGlhmoQMpu5Sd4EIJHHZnCK+EU4xLBq20BGPkfx6yjdlkB1RIaKmJRX6e9lJ?=
 =?us-ascii?Q?fPpOZlm+p0pNZtk7ioat7GY/2whhySny7Aq1t7woNvLsUv5ylV7lB2VAhBRW?=
 =?us-ascii?Q?qIUAMJEsmkz3sYctD6YspgNrZMgOJtZA5AfcOxAFjxlfhY1Uo8a7JSCPzlGN?=
 =?us-ascii?Q?7Zek8UbTavmfxsdsoEDRjcvMTf6u70cagvReBBFoNRfwgNAJFDA3iyJMFuwV?=
 =?us-ascii?Q?QbiPt3Sqbm1qhICK1QawRIGy1OuAuZZ3sXENFa/3+Gh9QOdabYomky690p+k?=
 =?us-ascii?Q?OjB+Lhc71YjAqpCRVmPdDKPLC9rJ0thQEt3/NrgMLKGM1E7v/0iCa9ERY8y1?=
 =?us-ascii?Q?X6Qy9IA38NAlFiKi1pPXz6GlqlV4Q20C5tp5NB8IBcpNXCcd0mFwkvb6HoDP?=
 =?us-ascii?Q?oUKY3wqk1IXzjYyuhhaHdvxxk0Pz3Tu4p8QeZzf6wguzYAxY9Iu/Os0ZSskj?=
 =?us-ascii?Q?XijgcxH2OmKLWQ4SErp0IxYBF8qcDH20iZZzXWeaZHAVSQvqNwW217AdFw8p?=
 =?us-ascii?Q?JJmsYUmX0Hx54X57HtrGVo7o0xnQnDicvgHj447DTjXCgCvyrljNoJ9QbJjU?=
 =?us-ascii?Q?wD3cVFa2wg0FmhFhLDacKtYoTMjzCQv6yd6RQgkdlzLdToiR4Sl78C/h0ge1?=
 =?us-ascii?Q?4tVtbBrxRj3shPmjJTi7VS5vh0F6pV+ohhwbDm8sAV1w3jAl+X8ineZz1HVm?=
 =?us-ascii?Q?+GJn/QLDxezoWLEv20fHTUmo/K1OGyWi9EYCtw8JOuUBw6llr653XCdjyseK?=
 =?us-ascii?Q?QJr9zG8v+A+K9UJdjGz04LzlhEfYrkE0q0v/sg587A6hf560VxeDHd2ZTrWV?=
 =?us-ascii?Q?TTuHmTTgGW87R9y7l9bZup4bHxNw8EVe1RMRw+wVfQk/EXi8/FdrEiwvQ68M?=
 =?us-ascii?Q?fVbBOhg8CV2cH8SYuMVVbU/DAgKKYRejbWUO80rn82e7GNDPoSwA2nHjuLXG?=
 =?us-ascii?Q?kWFYCUeao9uzhR8LP+cga1N+Y2mwlxBUobSHU76zum5N7vaeoJaq7RY8AuSU?=
 =?us-ascii?Q?XgQmUeqovZ5PVICpjvPr9r2p0Z0HFgbQCVU3rTaWzWCN6XuoXy3oC8jO4SFN?=
 =?us-ascii?Q?j1qEWpsAkPo6b1sFibyJA7qtX1sCxASt35ec51CV6buvSlpNaZ/G/lZX/Rci?=
 =?us-ascii?Q?UuhywJIDjIQggejmVUpj4e8jU3x7Pvt2QZ74qAMfg+8MN1JyGgTt8QQ1QamC?=
 =?us-ascii?Q?KVkYtUHbOjq3kQM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZmUGZ/ZJsqjJN3WxFukcSaCZFiwKa43deHhCpigeUCJ/95y9YaGi+TUhLPS2?=
 =?us-ascii?Q?dTZyV/fo1C1bdFJ+wkwBbahH9dhCHmE/6aOMy+uMVzNfiyVWPiAL0VZDCXjP?=
 =?us-ascii?Q?CUbgIfNsz6DEJen+kW5/x9Wn8EvuyuhfwPFNfvDd+hWwmDbKpR+HDBBdqngf?=
 =?us-ascii?Q?ARFn+mpWSkJ04uLCF/6qgYXJlsRAeGXxV5aZZAYNLgpoF1WgZfJU9291DQtz?=
 =?us-ascii?Q?rF6bCYQp0+asl/oWX0ieo31woY3szt3JDEqt8vlWeArby0JhrZfVT43cP2NU?=
 =?us-ascii?Q?vyoYS0cSPnmGJxAG8UIzVa415NR8lfAfn8WNKNgfoH/MqEdVWj1buZIVMvMQ?=
 =?us-ascii?Q?F7FjY+2hdDbwSpxbZtBPZhYYFMZk6uloBDmppQsPsCOxz2pZInJR1hvhSY/N?=
 =?us-ascii?Q?dIv2WoxSJtD0QYJKX8DJM+PMyaTsxcP4lwb6r0BA60iLnR+6tXZjZ1/fuxEa?=
 =?us-ascii?Q?CCj9dQY/zaKwRmC5RlhDzTZad1Y2rUZ5hf30k/++D0MA9xIA0qzFv7b5xgbm?=
 =?us-ascii?Q?YI/Ea142jP78+OxJgyDmtKsv/CoXE6JD4YLRlFEDklyYhOdabNthGOMcfjRp?=
 =?us-ascii?Q?ZboTnzl9HPzh2gPclq0bEroJXgsszO4c6W4MyIbOOD1ow4dzK0+eczkYiadp?=
 =?us-ascii?Q?mmeRgUI2p9lH3lW7uE3z94nuzbXBsTBIx3ZK5p8RuSS7I2rU5fLmOOf5N1ut?=
 =?us-ascii?Q?+oT0AK/pq5df4BApr4+ZA92i4EsAYzVGBpBzqUxuQAXlXQwsXCiUZZkboL8u?=
 =?us-ascii?Q?Flyb8Fu0qxMDoLcT9tn0LMCWSIsDqb7bonyQgSJsUYsvLPKq6fH2d2uamykM?=
 =?us-ascii?Q?NkJgkVR2WxCZiAQB7hBzxGEYxyT9EWjZULLqiNsLlTgV365HlFpnuFvQJa/k?=
 =?us-ascii?Q?CXlTGlQOBnmevWry33/v8BWmbY2dtA3ZYmLv2My6hVZGYKl/bfHsTAzZ8P/8?=
 =?us-ascii?Q?6F8If9JW34aNa/gNC7QbOjxHxZv/8aCPq+emfg5B2W8omK8yfK6pBbB5eptp?=
 =?us-ascii?Q?4JU1zuUvLlQOqmfUY6JbgDmUFX+ugnLDm2BPWM1lfEKQfcvxEs+tLicpo0pB?=
 =?us-ascii?Q?4KxttYG4YkIQ3TcebrJW+5uaVgaPgrs61M1E9kEhxL7CpjL/rs6IPXvLY+mK?=
 =?us-ascii?Q?eQsetPOKaTi1eSwTLcyJgJ0ZsZ2nSHFHC17muSKAr5UBNezQ6wonTXsopSLY?=
 =?us-ascii?Q?0+uUl0d5iS+B3KFHnXRcwA3EcirQXloZup5zQHw7rBgaMCgF0x+KZR+TswHC?=
 =?us-ascii?Q?S7lR8Ra5xEiXz9vazEz8O8ai1FD6g0mqvqBmvRGeCZYHOmSnre/Xutev2l0S?=
 =?us-ascii?Q?umBM4BTw+za0GlY5SPoUDgy+0gJy/zj+mmIeeUon5FKy63r+IbXKb5VSaNjS?=
 =?us-ascii?Q?XEciLuxBrsq7108nd4A5hIt1c5x3LWTAarezwTiSKtZtv7G36/9MjQcFwFgA?=
 =?us-ascii?Q?NZLsNy3RS+3SCeiU0SUEegsDYUS5Y3l6DVUbPVCjM/liTu+JzStS/efm6xcq?=
 =?us-ascii?Q?+1uNguR36tz+lHcFZHjCkLxCZqa0kWZOJh6l3sDMg8eEaeQV9qLR91NUKhD9?=
 =?us-ascii?Q?UiZ2gTGRyqKwJeYPGlP41Z7nrXiK7nmSKX0wrRsx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da330a7a-0b1a-4f0a-b85d-08dd9de32d3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 12:28:39.8390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MILWiiIcBAv9Sg5i8AonbHhJcVhKwbb6gnvUq6vjbkK/CRrClTrRqV2DIk6YhLeg5NdA3fE+4d4Kr1BzvqZxyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF4C1E661CE
X-Proofpoint-ORIG-GUID: qFg7TEHarbNuR4L5R03QUwJX2acHPW3U
X-Authority-Analysis: v=2.4 cv=EfnIQOmC c=1 sm=1 tr=0 ts=6837017c cx=c_pps
 a=OlAd6myHLz+OteJZ2xboiA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=i0EeH86SAAAA:8 a=AhpBqj2FFR0NHEKakbkA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEwOCBTYWx0ZWRfX4Gxx7I5cMxIl
 QzSxllyA4V+jvZn5B2XvqJuvModMTA2jcAQrvJ7SU6GLGX0F0+OVgYUJxQq2Wt0/YTF7PT88pyp
 29mooFuYOlYDT7VfQq/1IyKiIBUFEIRwBHWzugDSYVF6h2qUyV++QtOt+KIjvFCsndQgUf91Gsc
 kWf2T6dK9flMl7Jd3O4QplHcRKaLZGsmOFJt4F1MTsV0GtshFbHtQgrrXgkpHLrGrE0B9vB7y7h
 8LF13cppHw0xLYmFDHaVr+9LD/CIcCU7bwLFoulusWKGpL6zgNJpzy8JOJPZK7+duh1ezRTlnLX
 5g3l0l0ZivAzYLXlZjoKYktBgNmCDtM+gCO3vaRDpSOGbYPzFsjPF3cW182jhKBbXA3c+DlLpec
 UH1MyVaUetSXu8KTN6JExMTT5ruGUY5yZliKZmDhQL6H+wsv7wHiz98dCjhlGi1jSe9IacU2
X-Proofpoint-GUID: qFg7TEHarbNuR4L5R03QUwJX2acHPW3U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
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



> -----Original Message-----
> From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> Sent: Saturday, May 10, 2025 4:11 PM
> To: dev@dpdk.org; Jay Zhou <jianjay.zhou@huawei.com>
> Cc: Anoob Joseph <anoobj@marvell.com>; Akhil Goyal <gakhil@marvell.com>;
> Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> Subject: [PATCH] crypto/virtio: fix DER encoding of RSA public key
>=20
> As per RFC 8017, RSA public key in ASN.1 should have only
> modulus and exponent values. Add a separate encoding function
> to follow this standard.
>=20
> Fixes: 6fe6a7f7bcf ("crypto/virtio: add asymmetric RSA support")
Updated the Fixes tag=20
Fixes: 10702138f1a1 ("crypto/virtio: support asymmetric RSA")
    Cc: stable@dpdk.org
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
Thanks.

