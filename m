Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2E8C44521
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 07:44:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 278304028F;
	Mon, 20 Jul 2026 09:44:49 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 114224028C;
 Mon, 20 Jul 2026 09:44:46 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6U7me1137216; Mon, 20 Jul 2026 00:44:45 -0700
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021092.outbound.protection.outlook.com
 [40.93.194.92])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fgwr92c2y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 00:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ls2hYq0ieshEke6ahKNwq2b367uhu0AL2iEZyI61ThOvVYL9mf8LyeghB2+nGYwNvduyJhS1DxNACIachHpymlCL0u3Y+tllFqytTZK/Nj9HaTP8BR1uWIgSDzpuQEX4RqR+A7Wh1Yxs5feABrynDw5R2upGzP+0NVM3rz2apQZVemt0l8ulKxM7c/AY8F4tgxvyNlROI73RcVMiokGnxChDgK1H+8YRPDvxAYNTjx8vFlgWYs1ypOp6fua0IJ2FB7xsSnVr8ME/TZm1a8XVK6/I3Y/ZVajdcjSGxUQN6Lq7xF1WWzS2AiKYiAdqOBVtTdcsABVM9ECEXCq8cHVWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12FD4mP/Zbdw/WlKbqMpMvfJMhovMwL0WP5wNTTDO9Y=;
 b=rpk7nyhLJUd/LrIJE4+wf4DysQQ+cY29x+pHy5DB361zHxP/uYkiKI/yr/mcXS/0CdL64MApv/xITLUHQfk2aHESFpAYPtntDTEi1B2Rcwskw/q4TOKCB0XqfYJZN0WWxMuT5VkVf51FHeP29VfmHQWo/ZXw0eBj/Usk640CqUyQRPnm8Pt7C6UjGMRiO582h3elEjvuhBGAQHiAVH5aS7RxwINLxecUokY0lBFAETGUQf8ilgI/fKKrkPieJibrCnhJNF1sbdW0CYHI2KwoOuNtead1OgD2fKz5ywjEtThzZeydbXmR4av6czTMYSqAfuPWoFVk/MVDncKLjkyS1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12FD4mP/Zbdw/WlKbqMpMvfJMhovMwL0WP5wNTTDO9Y=;
 b=G42bKaO4yqJt3lR6Ta0e1dcKd9xBhPzb5E9EaI6pRtucPDdA7FoZbogWB1YOIZtNJToCPoKS54SqDG8FfLftpnOCzFlE/XIleedQfN+zhV8m0hqWlNbaVeuCw0z0uMnevJD1vls3rPfW/xWQm6Yj7T33YEnrjwmAsNni6ud+4gU=
Received: from IA0PPF0A466555A.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::c09) by EAYPR18MB988325.namprd18.prod.outlook.com
 (2603:10b6:303:2be::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Mon, 20 Jul
 2026 07:44:42 +0000
Received: from IA0PPF0A466555A.namprd18.prod.outlook.com
 ([fe80::963d:16b4:7cb2:6c36]) by IA0PPF0A466555A.namprd18.prod.outlook.com
 ([fe80::963d:16b4:7cb2:6c36%3]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 07:44:41 +0000
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: Gagandeep Singh <g.singh@nxp.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] app/test-crypto-perf: reset mbuf state for
 IPsec outbound iterations
Thread-Topic: [EXTERNAL] [PATCH] app/test-crypto-perf: reset mbuf state for
 IPsec outbound iterations
Thread-Index: AQHdFPNZiLOUlD7vHEuYPpNTdUkr6rZ2DQBw
Date: Mon, 20 Jul 2026 07:44:41 +0000
Message-ID: <IA0PPF0A466555AC4AD40E85F8FC1BA7CC8C9C32@IA0PPF0A466555A.namprd18.prod.outlook.com>
References: <20260716071620.1550810-1-g.singh@nxp.com>
In-Reply-To: <20260716071620.1550810-1-g.singh@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF0A466555A:EE_|EAYPR18MB988325:EE_
x-ms-office365-filtering-correlation-id: c8ed2af8-5ed0-4f62-70de-08dee632c25d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|56012099006|10067099003|11063799006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: c1+eLajGmP1JVJFIbPbnQFC+Uyt/O0JQBDiGoVrZepUp/sFYyi3G3/efBPo2l1IImIt+zWwo3P/CGyULspNPYwS7dupnqtIJVxykcNjAvK/DHNFX8dS7d5bmYjKAbLktfsXUCuPRRPz2BgpBpeBJ0grzKqfpSWsYkq0iiBDe7liCRQbFrkQJqAJVBiqgIK2kg3IuqV3h2wBlWzyuj6KJNZ04vYydd8gWuxyVM6rYDksBb+CEJZny7XiX9poz6oAhoWGvLqMS5iPbmt+e0ugpRHg922skEQqKWMZiwHDc3/ycesFb0rYE4xH4KFiQ8EUi0Lnt+i6b/DgWyc5JcdY6HF9fTGRlQlLE8rdivTCCLW0ZAdwfDPwyAWfdXhpRHtoq6tq7DdgYa0ruwdW7QH0zYiX8xpdOiAb6+X0Ak50UFFM16OqzOfOoZpXA+ac63R/nQACEkOvrExIZssAWccYZnOcB4YqPgu6ck9yhxgYREqIJZn11qibV5v/OtidOoHWP+nw28WiIkmChsowify1MNb/IW7YyDM4EqNLdH3iIKwsR0QSpYKMJ8KYnUglqo/9E3HUegc+Jdwlcnwf7NM+4tcKjKfx9G8WQMy+oVRz0YAOWOB66P4k69MYawntUMdF7egTkHbDQ16MyPt8bqQPPfBmgdDKzRfdZxh3iLebGLL50H1GZOYf8ya4o00dxp+QhhyDiHkPqfqwLsh70zuLyK3paHWzahp1KDhAEOU3G9/0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PPF0A466555A.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xZ3Wcf1pjhcXeZMMFKQJD5N+3qeN/VGGoSyJR+X7sBtJbaxATzMJ03qTbadp?=
 =?us-ascii?Q?Hm1PXR/SQyUt9I8TG2iwjDKZWqmML6ey1Jva+UHzyaOT2e/gFUoP0+l2D9cn?=
 =?us-ascii?Q?4mX+I+yv8+r3Npj/MnskMgxcm1tVk/7nqR20Crrt+6HGeZSJnG2c0iz9OA1W?=
 =?us-ascii?Q?Sm8UL3exmuKH80GI6tSCWbRyFNABwZPo3z98KW3GQgT6pNzVU1kPDKDEEFze?=
 =?us-ascii?Q?4NO/3sgZwD2LqIf3G77+SE8O8Yax9ONw4JdzunRy9dXLyxAz5VYxd5kJTK4s?=
 =?us-ascii?Q?RassQZet5EWC1g+RVi3NYh7BQPTFf1puYP3lgraMuhTRg575Fhgv3gJLeYYD?=
 =?us-ascii?Q?KZBIs8SQYr5LiMcNhyhzRP94gWeY6yjeWc2YTiN0R1ViJBVEV8CiNO5omfRu?=
 =?us-ascii?Q?VXQZ+xKUmTHFVh46J2uDp+VTwuIsTTFFsh6D/pcAvcqKN7uc9tjHbBMr2TH+?=
 =?us-ascii?Q?fM8bqwbaAcU1/Zd28fAqtI1U3R2ar/O4N6lfzi8ljXpYFyUosw4msgbBru/9?=
 =?us-ascii?Q?mIEsqzKo/YWDWC2P2bi6MjUOICLsMUqvdprUhExu9cMcK1m2aOewOXJaB5qM?=
 =?us-ascii?Q?m91fsu3bxL6Fx5FaBozTEhqtAfYxME2EbeGEPSKmap1ZPq487y11H8Z2vX33?=
 =?us-ascii?Q?IOgks0DfbNLIgeGLSYwjRmTMM3SyDI5//vlrVbvWVvusMKzRyL2nedKvwk+B?=
 =?us-ascii?Q?dnGIioCZfvvSHc/XnGoFNfYMQS+q03hbEfUrDKgIHKxDfNdIsRM6XDWJunEm?=
 =?us-ascii?Q?0k0qoe1z7RpTpRdCS8mQy+4qu10KRaSB9gVdPOtqQxSfKUY8n9nQsVndmaQo?=
 =?us-ascii?Q?VeN5kq4We+y12atVmLVNRAIgebotyw9w6M+bTNLNV2B00725NerrRUN6UazF?=
 =?us-ascii?Q?xJmqZhXNzwpuqlgRgs8KilAiVvKtJXjfIRZW4bNfwRLjjTEgeZ5Fi/jRwCmj?=
 =?us-ascii?Q?RsJWeiXn+2h+VkDiDCMBE5m72dRkyzTkPGSU4t9wQc4/D70PStkKwb6bHgKs?=
 =?us-ascii?Q?EboK+FZoV/ouCxpcUlEDDUbBgv4GkyQSOT36zM5dBXrT5WPgugkOsSZLpD9P?=
 =?us-ascii?Q?J3sVt9umcpK4e894I6TDlIDGutO7l4U7MKxJzwR44rE/b8ISjnSpPWt6/ZhG?=
 =?us-ascii?Q?W/TG832B9T12r4F2wXyCrfjFl60K9NUqdGAG/9n2AGWXJ+I0ednjujWWhEQq?=
 =?us-ascii?Q?QFVTa0LzX0BXUiihvhBACuN1lEBcBBpgTJLZXTOykeOtLJy9MdCv+4sOIPiI?=
 =?us-ascii?Q?p+x3xr8hXISNxtIdayPj4m1xLQmctiFnjXPUOp4HcM6Hitc/ilL6A78XVCny?=
 =?us-ascii?Q?LSxSzW3LDIAwQLM0VIx6KPyNLc6dd//NlD60P56RwJbQS3VBeDYz7OeUUVoZ?=
 =?us-ascii?Q?ksJ8/LeojqK6bYcLV1oHTR0h+srOcJ8+Ytr1CPOZzzO94bL0Jma+RIMZmH9L?=
 =?us-ascii?Q?+AdAr2qerQpHkUcUpj7/9M2TV6iRWdwC08zNIvnUzw7HLwq3mY8k8QfBn1AR?=
 =?us-ascii?Q?IxEW+A/Ke10Av/hpD697TGNsgP7eeZ4kJ/qD9hEZUEveoJSkVHnrhd6z5AHB?=
 =?us-ascii?Q?ZdXpFEa175cpLeuLXyXSINJkopyEoBxZVakWu42U1n0Dd+VH5s6Nnfod342S?=
 =?us-ascii?Q?23vJxcXUhwTPtKTxYHWu6/rtZWgWY3JhMFQXp0pP9RfofhfBxRaZLOnWBZWc?=
 =?us-ascii?Q?geD/TTQIwmjOxuq4EpqvcKysrXZ5BskeFFS8sK91UFtzszRpoq7ZQrlqrS/G?=
 =?us-ascii?Q?VvuMLt/yOQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UjZwVhECJRVfrWYXY75DQ+9tblRfIZUXnASkroasvIQZbY8egzG48Skg0LJlaq32RvhV6ukiXPs6kDiPzp4v/pTREObcmCIjV3BWUiN2K3rOEkAsTVgEYtkjQPYczDGI+oKLoJC11zbsPsq2KXsbXl69LJVW1k/A1SNr1BFAANavB9SLSV5iNSkVN+7T/+9iqwKKBqA5GW7BwaouE0XRyErdQCF8NP7YTdVDiIW8tBU6MV8l+A7rQ5AKo6NEScOY76ZDWlc14yc+B9/B0aNGyqZ51RYu6tlPw1rvOBXeVGpAPZOdJPJhvCzpubPxdbCAwTUw8dzWXlEpdakUDAqwdQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF0A466555A.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ed2af8-5ed0-4f62-70de-08dee632c25d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 07:44:41.6307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rONndzzvMgazOGpLkaPdyST7oGKw4FZ6zcyTCHWXnnWXchKP7OsO/XhLxaw/XO9IDeGvLpSxJpLLf8VQ0Un6LZM4BvlggmMPcHaeAgwPyqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR18MB988325
X-Proofpoint-ORIG-GUID: Mu1jobgHzKZATnQfR_CWsEVpSyfuoC39
X-Authority-Analysis: v=2.4 cv=d97FDxjE c=1 sm=1 tr=0 ts=6a5dd1ed cx=c_pps
 a=FqDfg28UJuADJc1XZx4kXg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=8rWy6zfcAAAA:8
 a=8AirrxEcAAAA:8 a=M5GUcnROAAAA:8 a=Hq9FnUaM6QnkRQtr7swA:9 a=CjuIK1q_8ugA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=ST-jHhOKWsTCqRlWije3:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4NSBTYWx0ZWRfX0SHjFWrBZVz+
 i6uZKjUFXuQB4vQMLPcYkMUdjXv6aqSmpfYa7adT6sud/1rlzaPgSdVbeqNh0PKZs48/QiIifV0
 26YUyAnfijCQRKFTBfI2hoeGkprAg/GM/GVK+fMXt22UAjqe6D8A/wnAs5p/F8Fw8+7Qa79kCln
 0dSc70cIbgNE5repJEtqGT81Qteb+HLViODjJUnFLE5+DplFeUAPBgv31rE7N3KUQN3UA6KfahQ
 F0GViL3kgi0KcDYUy5v2C8qkl/xAxDePNmOtPaXnJFER1B6KIraE1+Jv4HvjGkvsJHZmvISHC9N
 fNgxVXU3b5Hatb5qs5coVcBNEEQkIknBfctt82E+ymXN6oMxPwj8BTEu5yig43fDHhZvNiNYRuC
 iaBVwKbwSvcYhVg3iijoTF8sqUj8Ms/1i7h9S3wzxDSQe/tmx+7gwX6XVhYU5PXLXnh2Qs1QAnC
 QVJVJ/7RKu8rp2sIkOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4NSBTYWx0ZWRfX895RA8Um3Yxc
 IVi5CJQzdewQioEVfv7n537zTOjYSGzKLsE4nR51vJz+pKMvJJ5AgwtPLyo9c092fgMeU1MEOXx
 cOlG9dqS2bnq6ZljPHvSfCH7QD9Z8QQ=
X-Proofpoint-GUID: Mu1jobgHzKZATnQfR_CWsEVpSyfuoC39
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
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



> In cperf_set_ops_security_ipsec(), the same mbuf is reused across multipl=
e
> throughput iterations.  For outbound (encap) IPsec the PMD may modify
> mbuf metadata such as data_off, data_len and pkt_len as part of in-place
> protocol processing.  When the mbuf is recycled for the next burst those
> modifications must be undone so the PMD always sees a clean, freshly-
> allocated-like buffer.
>=20
> Use rte_pktmbuf_reset() to restore the mbuf to its post-alloc state in a =
PMD-
> agnostic manner, rather than patching individual fields with driver-speci=
fic
> knowledge of the expected offset values.
>=20
> Without this reset, drivers that back-adjust data_off after encap (e.g. D=
PAA2
> SEC, which advances data_off by SEC_FLC_DHR_OUTBOUND on each
> dequeue) will receive a buffer with insufficient headroom on the second a=
nd
> subsequent enqueues, causing hardware errors such as:
>=20
>   DPAA2_SEC: SEC encap returned Error - 50000045
>     (QI error 0x45: DHR correction underflow, reuse mode)
>   DPAA2_SEC: SEC returned Error - 50000020
>     (QI error 0x20: FD format error)
>=20
> Fixes: 3b7d9f2bc6 ("app/test-crypto-perf: add ipsec lookaside support")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> ---


Acked-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
