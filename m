Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547BAC54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 10:34:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A699742794;
	Wed, 21 May 2025 12:34:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 649574065D
 for <dev@dpdk.org>; Wed, 21 May 2025 12:34:57 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9qnlr001566;
 Wed, 21 May 2025 03:34:56 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46sbxkr4mp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 03:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVY7XxI3YajLLrHEjSN6USwRbxoYES9F4cHgme1JViJ+27FiQoeKdH6YR+f31haP8tngb4k3EQ1R1Jk086aR0+7gE/hunNTAoNIKQ727Kf+Pn3beZcilWaGp1ABz5U/77q2DARLybIo65vvWIIXTF4Elngigrkoh7sS/gowBh64/zx3/b41aKHVzOrd7HVvajAdEHhgifsyZz458XVeh55rjy2MS/kAMAocqggUsGXD73+aWad44vCZWazYbwwDuObviwF28Rpw4E/CpTZvwiDIJYf9EvtA0d3rjgJxAPg84u/zZbIm8Y7rbEteUhBcnwcuqFMcP/hpIlbhelo5G6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Sh2vCIXOaU9Ha9908Ajk2/YgMq9rLaOTWAdGoErAPk=;
 b=o7DVR/dES0nHfljPlwYxVOl1ToORnDlctvbQAax2YcIRDzWpGnS9Tac0IAZpTk/5AGl2gszrHIVG2NVj1S7sSRWBMJEzP2sQWP2w9GUVxc+BrONnjO+fD/33amw7oblyF4tRwPSLy5xQoZqp6+IAPGjpHS/KMbR9s77nMVE/1N2Vhuct7DtKpxn+q/kTp1oXTngVQ660LmEmrLbm+rLkERTSYCk9GqgLJwUGwyhzBV86xyjOUbT2RSQNM/pEL9gBaqWXtp9//F3WJwndF9frwluJYFN/hANufETr1c1D/7Keu/v0uyTR/jFTcmRFx1apcOc99pOXu6JrZtVfunl/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Sh2vCIXOaU9Ha9908Ajk2/YgMq9rLaOTWAdGoErAPk=;
 b=Dy74TcdxcbxZActL9kyaCTtHYsTJdbu4KzHg5ThETDM+kaVr39uG2C9WVwlqh6t6TxnTlZD6xzYamE4lFn7Mbz49OnufJGst0wsUBdC4EluYHiZ01RjH6L6Eo6XS4t2st5jpx1JTk4Xq/hUz5h1DZrGwBKnYrrhLzqRz5Nvgy6M=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV8PR18MB5731.namprd18.prod.outlook.com (2603:10b6:408:1f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 10:34:53 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 10:34:53 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Rupesh Chiluka <rchiluka@marvell.com>, Brian Dooley
 <brian.dooley@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Rupesh Chiluka <rchiluka@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] app/crypto-perf: avoid infinite loop
Thread-Topic: [EXTERNAL] [PATCH] app/crypto-perf: avoid infinite loop
Thread-Index: AQHbkzzal8JaDxD/YEqggU19t3dR2rPdUU9Q
Date: Wed, 21 May 2025 10:34:53 +0000
Message-ID: <CO6PR18MB4484C4FE76CA7F1CFA874AD1D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250311155850.1043336-1-rchiluka@marvell.com>
In-Reply-To: <20250311155850.1043336-1-rchiluka@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV8PR18MB5731:EE_
x-ms-office365-filtering-correlation-id: edb4670a-0ea3-47af-13a6-08dd98531f62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?avKHQGE78JSgUuILg+QuUG79d4Ozwv6Pu9j7gIle7RG/RWSeO/BbQbT0ngNj?=
 =?us-ascii?Q?vd10ywW7CyQssbxqkv1BqPP2XvXhr5sjzaEzAuLbakMyybOgwrG+OHpoOPpi?=
 =?us-ascii?Q?CNlpATKFZul9PQDyP6JxWgdxLJwl0GfuBaUHx+YinLlEGrDjgmfAEkCGkaad?=
 =?us-ascii?Q?N9NLJK1Otns4jgK+vDVgDBuge9DN+Z51hADhX5ygdwzygYuarXNP85dAMHdu?=
 =?us-ascii?Q?CDu++7JQ1Bhn60wyz8Ypr/Ut0KkQPBpXcnKlyxkA1teelbJmLS58vlx0PWVP?=
 =?us-ascii?Q?oh1NQU2oVPy1bsr28Xglo5M5uuz0HFZhafb+SbmNegiNmgGKrcu9E1mSYUbm?=
 =?us-ascii?Q?Ow+VJ9GrSIMg19hfhaDLI4xFHlPoZ72ZxcsSjiXlXngfyxo0zRpGJ8BgyO2J?=
 =?us-ascii?Q?TW403W7VycffsbmEE5trkVMVvQMwirq7ZW9LB+O4UL3w2O6W706VNsrzHK66?=
 =?us-ascii?Q?37db7VjZkTWvMiIE5D8jCw9x3vwHrjzYGLsjXR45UcQwfghz/PeB9mNbFWl2?=
 =?us-ascii?Q?4c84YPYccFiLdPDpZpvPpNPAUXmCWLNUdxQCYgqHUlPqDOfQtwu9RM1mMuL2?=
 =?us-ascii?Q?nMDyeB/DqH9tmKWMKoPYoGZ1X3Frm2s8qn0z1xJjZRvUm++PTsum1cActVkG?=
 =?us-ascii?Q?Vx/PDmC0EFp4lruI23K/1lbLMQCG4bR66WutlyPdF71FV/Qn+ZdxnArGUvlt?=
 =?us-ascii?Q?hiVUXSGKjPQsWbJ6U0a7uVeBPNYTVBaqyc6rrwIynHb/Rl3LhuqXdCzDrZ4i?=
 =?us-ascii?Q?jSOYA+UK8jkuNJFcF8zmdi9w9slBNvvVMm+1yiIsUOidhF6PPI6dz2wr6ABP?=
 =?us-ascii?Q?tkrD7Yfq+K0XOqEE5n6jEbMsdgQKP4RQ64CH8UAEGOTzUAc3NNyJ8ZS4gqCp?=
 =?us-ascii?Q?MQ90UFlF9e+dwT2wubHocY4DKOzwWWqfjz3viZeQ0c8hfv2DwIZxdFEfsfMg?=
 =?us-ascii?Q?v0bmDHSlablctlaOCVh0ij39AwTEXqia9kp8JLHHD4WRDUnKo2gG7NIJhozc?=
 =?us-ascii?Q?7xpmYtoyc/16GESlq70964Jn/UUzn/ibN13/Ely67kSUcAC2wPdSS9KzXxOz?=
 =?us-ascii?Q?zLrnKoGPP8lIbwoRiV2MdzUL0W2B4pitc7IW3QV/cR7CRyP3SOxXFdrul4lo?=
 =?us-ascii?Q?tE8ZVwdpzNG+lqF2kaEEPtYgzvssd+OQ1GsnhDr+NMfimaFFjA+i8QZoizuq?=
 =?us-ascii?Q?7JgybrcgtzD6h5OzDH6PQB6NQelTyxm0uLTT3DzT+zGjEWgxwSSqTlK15DIt?=
 =?us-ascii?Q?Lx4lHTXIaZInxb8SnTeX5Z7o8lIinLg9t8ekpjNvh5VU0WBGlrgSoDboeVL5?=
 =?us-ascii?Q?Iu2TQUxWF6TYNbVfzTcVFoqoo0jxpj0PIaZZIOv7L9nJsHGQYKkwEKvKk1g2?=
 =?us-ascii?Q?v6ClodgVXkIQAzx3HLzZM/sVVbOapA1fXyGZT8HLFdyjJWHD5YQuSWjgroUu?=
 =?us-ascii?Q?AYQ6A3IlaIDsmghQmNJQG7pPpecUmOUcEHjVrXe2oFSbNBywtR1XRg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MQFBPojOHBnor7y10ViUhUibG08IEg1FlnGuWm1G0Ux9mMjUuqN0F+IhacC4?=
 =?us-ascii?Q?c8WiBknbJKrsZ5WjwrzyXBYqrBqsXOjr6FJEAYXr0RO1EElAQjVngu+Mx/Pr?=
 =?us-ascii?Q?te9GukOGw33UXej5wa4sraLI4a3ZU0a+EgHKiQQhxv/jNX1GujvbulPGBFQr?=
 =?us-ascii?Q?s2FTV4drAaBwwGAyREf8Cz9OK5Nwo+nZ/J2Iop7VxNk4TY8+TPb/gDJuZFLY?=
 =?us-ascii?Q?pGbyjFq+l9STDP0Ficr339Mg2b+m/iakQwL+cdz8/wWX8Jel/L3wMmFlud3T?=
 =?us-ascii?Q?NX+6JqXBrcP+paN3O91x+KeKqrunPUdymZxM7VYg/euXjW76QilR2GKnnkD5?=
 =?us-ascii?Q?0t+bXp2IudPbesUhp5FON8NH0ot425GuXzw4ksLhKm1PUln7YPSBY67pRUQk?=
 =?us-ascii?Q?jZVFllYzE0fBjAbt6n11a94c6MX3Pnrmdj6U3GrYKnJNFiKta4trAHeuy849?=
 =?us-ascii?Q?Hj0UaXB2Nj/kk7IMZKyNCkZyjFAX/nm66moCIT7QqtL4+gX2/ZX7qzcaOyA3?=
 =?us-ascii?Q?1EyX0iN853IREPW6Kfxp/fD86mq20pS9aVEzNS4AkWyeo5XR+7oVUu1DtZIY?=
 =?us-ascii?Q?xRmVJG7e/AQXbl+SQtFVLPvHqFYO6fzvjUkavLJ4/TYMh1UVXHQ/+UGGkIjk?=
 =?us-ascii?Q?eRXnaFKy+o056iRnl2F8ivcFbDAdeHJRpmMGvR7bLs2dhGOlQMoO8REMg8Vf?=
 =?us-ascii?Q?cp7vMf/9L5GqZ91hy8V8Nxpb8iydOMrF2usrHiNygKyhSorOAYCab/uwCDuB?=
 =?us-ascii?Q?EErQEgckgaoXdJN/7s1ezymBGostHKe6dcLBYBgz5PLMFrKSy2p/rTmkS6LQ?=
 =?us-ascii?Q?cED1yMcD4C0GYSQuH2YMf08EporZG8wScg/tcyOYmq4pZt8YB6i1LV92sGpJ?=
 =?us-ascii?Q?lmw/zJ4gwb7Gc2XFFxPKgaUZg5JHAJTrHiE1vpZKDQnI+ITp1vahlEKP4e7j?=
 =?us-ascii?Q?/+7YGs0X4BZKTsw3vaIftTVpB+uMN9ACDKoeCfkLjy18IuRPelKfUvub6LC3?=
 =?us-ascii?Q?z8dEcBwFeI2Lknby0bVUVwZ5uq6zIJ/GoQhQ4ploT7N4jLMsSPtdRUeWtSJw?=
 =?us-ascii?Q?Zisk8Jj9/4w5k8a3QX/YECCBOQvqWOKMgsoOIODbuz5URk15aKA6nG67O2zR?=
 =?us-ascii?Q?Y+4d8gfEFssD/NmVRzufTwFJelPJbeWuCZ0dKxEM+xR5zXT8FvXMvEiEwqFZ?=
 =?us-ascii?Q?jxAqiOPWs61CsBtDeeK7I/e1BT5E4sKJpaWvC/dbP9vMOve+hbFqR1szpABo?=
 =?us-ascii?Q?YVzWhi6qRROCObXmtRdpkwnsga+lo/P/canZkuEWrSpTfWhrbe4pxTiAbF6w?=
 =?us-ascii?Q?Q7a1oS3aDPJwwBZj6ux+2YXbNiONJKpG0pUTIsSUeZ6TiJyuKvn3P7kUFg7M?=
 =?us-ascii?Q?tdrODDlfV8DEWSrbOrewCFnL33LgY/TIu1E3AFrLBQaAcxJJt2zhkuIUSKwF?=
 =?us-ascii?Q?V4Pnktss45ryGyG3dVFNhTZ/0YwChGJhJbiKlJSMqsZWcUOXjJepEQcjUGtr?=
 =?us-ascii?Q?k0Ah6WvKBnglQV2r4NewEibrUp5RnI8hXo//Q2LLGzM3mmtAfIGA0ywFTvS7?=
 =?us-ascii?Q?XCTPzsZbkVtNNCSD5ug0rofCn6krmuCOjiuIbksg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb4670a-0ea3-47af-13a6-08dd98531f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 10:34:53.2384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mA34YXb/VVd7r1Kln5BaMQpca/sUm23TMkzgCrO9BZHWdLsmR5imroBHDpy8fPbmActURJgG/fhoL95Vr9ZeUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5731
X-Proofpoint-ORIG-GUID: fBd8TVxobTNAba2XfPpuS3wdVP_H-Jyu
X-Proofpoint-GUID: fBd8TVxobTNAba2XfPpuS3wdVP_H-Jyu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEwNCBTYWx0ZWRfX1xkCVl8S+u50
 NxONzwaAXNsvVKT9oSuGIhBzxtl0F4z8ivaQkWPzeuM9HRsrCtfDeheJGuNp2f7VIFH+Fmk6dy+
 GSPyu5pAwi0Ab4SEh9denS6mLfNqmrsnR5prH27upXHlZyQDjvzuyjv4gLL3Wwl1ACazpw8Fuxk
 7LP4yeaFWYJFNEANG5za9XMsOYb4cWsQpCZWcXMQT8tbmwEl0R4Lhl32v5D0czxySKYEu7dMVoc
 8U9+7Ea0r8wNGVucRO/bRhCJeNm3KDsV5/UHf4A98SIEacRsdcrlz55xjiUKTSpO7NNExsklgiu
 2slltvxR7tqDmABYCQefynkAy6v7xWO8jv/VOmRL6Zyszi513LSWtNrT8Eg4At0QTrLXcOC4NGZ
 kpU6Ozlpdpw2X/NC58/tIo6CD9VBCBlxMvSv4/af1VmKDPPK/dXmaxrmfZW49c7a96XrNiC0
X-Authority-Analysis: v=2.4 cv=U72SDfru c=1 sm=1 tr=0 ts=682dac50 cx=c_pps
 a=mbHLYBybxRkByWxHAZWYkg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=3wptvwIqp3Vr7_USJ6cA:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01
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

> The enqueue/dequeue loop's exit condition is
> (ops_enqd_total >=3D total_ops). If the PMD driver cannot process the
> ops (returns zero), ops_enqd_total won't increase, resulting in an
> infinite loop. A check is added to process one op to determine
> whether PMD can process the packet.
>=20
> Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
> ---
Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
Thanks.
