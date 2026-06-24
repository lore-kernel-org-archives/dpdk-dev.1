Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5689CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 19:09:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8919C402D1;
	Wed, 24 Jun 2026 21:09:51 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7FD59402C6
 for <dev@dpdk.org>; Wed, 24 Jun 2026 21:09:50 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEgQVl4024533; Wed, 24 Jun 2026 12:09:49 -0700
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023075.outbound.protection.outlook.com
 [40.107.201.75])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eyfr7f39h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 12:09:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eV3Jrriw1K796P4Dp85kVB7uogMYGsvZj7qsNGzFi/EphhACFxDaxxOV2H7jkULcD5YenHe4vEwuIgnI8N1GL8YpjkujiacLD4vaAPteG++9COUVNSjZZFYoCpD6srx8DPpqKeWcUtO7auBqVtWlyDYhF7Rwnn2NDgSJvUD+ofPPxAywXkxDGcGgQsZc8/cVg2ac0c4uhRLMpZMK+/Kc/14GBQQ8zsEe2P1IVY/DzjPREmULcHaiIZpMvr2DCg0cMsBB+0QROlXK5G4l4lGY7Q1nXfRraLTdLkoQb/MF2JpLmDOOa+77Hm2O0BXPejjgWTI4mQLdH0HahNgLLLBFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6gMiqI10vyHmJrgLB7QGe0I0hjSixc2j9e+kdTanAI=;
 b=YJSP7rCyUwMUJF339kwi/ge4CppDo4tX/A3pcIt+3uxZZWMzL5MqXJ/NvDWGCC00rbPqYrHmPkhyt6IsnKPmS7BhbJYPtqnwQqzmNBqa/Ze+/ei2xZPcYlvzp18O3zaklDhpPJ3KEGb9yR3MIjBHJCBqQZxLCnQbOgL8I899FysrIAOBe/q2oT8ysF59OWQXPeCY+yExon7wcXx292kpBnDuLN7ROotC3HZhKt//AOJMEJtNqoVukAaT9pdrEVCiApVYGJIYbhJdJew9NQdRzcZUYst3I8F6ajHv2LaV9320EJ/rG5FGe1kJF77kNwU6C1T6uSOtt4bZPrxt4wN5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6gMiqI10vyHmJrgLB7QGe0I0hjSixc2j9e+kdTanAI=;
 b=MI482vygvhWby1wVpc1OyB8zE6zl8COadc1NrKBDHEw6AVY1RUFevpRPKxDYtTamkCNqH7CpBfX24VDmIN82n3PGD/dB+G+C8AINSLutl3/IcVtICyQrNfzcl9fRxRVtPryOxkETg2jLrCWuvk84FdOXJCCkUrwPyx6q+Kr+08w=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB5075.namprd18.prod.outlook.com (2603:10b6:8:47::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.14; Wed, 24 Jun 2026 19:09:43 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 19:09:43 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH 0/3] Fixes for inline ipsec test cases
Thread-Topic: [EXTERNAL] [PATCH 0/3] Fixes for inline ipsec test cases
Thread-Index: AQHdAjjoSIp6iiJo/ESXIcj4CpwvgrZOFWVQ
Date: Wed, 24 Jun 2026 19:09:43 +0000
Message-ID: <CO6PR18MB4484EB282B56F0988D451B28D8ED2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260622111835.233554-1-bruce.richardson@intel.com>
In-Reply-To: <20260622111835.233554-1-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB5075:EE_
x-ms-office365-filtering-correlation-id: 7b49cce0-1987-4ae8-58d1-08ded224263e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|38070700021|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: u+ZBpQdUUbM5c9dgcb/9ki7L/fXPpvY1t4nC8Wpz1yYm+oFqUV3cMOgiNcndZR6Etj/jXhEXHrm65W63TFTWEkvLJOmNDfHN0+t+NWP7g9NgDQSRZ341B43RBmQvaz8pN6jR/ydcNpuBUGEqPMHaenxgWSA3pTcPSaLKPDm/3y5HngnX1k1fbag55ML5YeEz7NG6zhJwYmuMh8ZLV57ISEd5X1Cq0CutGQykKxHPmEN7HEdRQfW3Lk1gIEwLL4Kqij/XkQRvvQxWU4ECnFQp/s1waoJjzziJD9ZvahlxemhlRrttL2a/JQp96VD818ek1mN660qa7IMrrAmV8YPMGb55C/a8qb3AKklnnjzqhI97zEj4o5x0JhO9gtm9N1vDn/pPhXGE2g/2iGHg5SNFW9nVcFBNAE8JCMFHK8rPmDKG4NnwMkMRP9WtsjHwN51WfFGkfuuZjNWqoBcdkZNjrtPLnJcpC7SSyWllEweTIQfElZXVtiqBCUk8PoOMnLvwJwUdJCWecF409833c9bUxeK/1dJnpXeLPGOcuYaSbWAgpYtQ7fj0kzCfyrAT35Jd/Vx8ZOseosdXDRR3wN2Q6cMF8UjrTbNq6PPXMozwB/q6PY0dCwt9EQZn2ubJ6veMjVHAWTIrVKoYoyIXEpdogkuv+64RqyQzvKdSOuct1lWVePVC6/sZnHYsrijsWVvValWC4cZat9YMms/3jTegYU9KMkhu5Z3ZnnbTpN5lv+c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8QmH65K168tMbEtD4lQNvHcMTn6dnyrxfAq0pZTc6ZCsI3Ve07CFTNSEzcK7?=
 =?us-ascii?Q?0GMqlGSZjFzZYYgBVRIPoiuP71eaRxWeFTwvhtUXbh8YNUagDA6CHplDyPZX?=
 =?us-ascii?Q?oRR6RHaA0Exnb1m9xN9iY/9O1OhrLE0KvkYp4MB9hQ8lr7sityi1zDjatiRA?=
 =?us-ascii?Q?gUd1221nuIWaspegcCoU+nBseO3a7wmGixaWIQPShlRxu/G01Y+M6CahWEB6?=
 =?us-ascii?Q?YLYrXBm30jBSPcAOXfdDCmzZ9xJLFVXRPKI9vKd0pzSuuHoM8AtnwImNm1Yo?=
 =?us-ascii?Q?aztmgyJAg1v0CzYbh4TsQn0uYo/gwu1+PxpHc99sTQrFqqL82vb57URkkqam?=
 =?us-ascii?Q?AbHutwmEeIKhH/c3b7G6ha67sBbC9I0gzrBLbbiKxJeRqdWtsU/PcEULbt98?=
 =?us-ascii?Q?L8vGFMszsFXswMzXd0UFguB6k1eE28sUhkk5AJNT0qtTo4ZHXsdnvKypcq6K?=
 =?us-ascii?Q?/plOr8tchiBaf2PIxM3NUUM2WeghX8+BzUNJDJNWKkB/E9UOvtGrJbaf9hYY?=
 =?us-ascii?Q?ZkapB94vxJ4i/C6V11Vy3naHSLt9l0yKh8mUDwP0xfqp9/GnTtWPVeTVNAeb?=
 =?us-ascii?Q?DOGsHCzNBx83bYhGZZDHkeioVPO2bhAd3JtizzCf+rCYeQ96HbebbcrBsX0a?=
 =?us-ascii?Q?SWml/bBMIaG/6E0ukR088XoNfDYNl08zDCCZ30c2UkeMIyGgyjWNT0TXWPoD?=
 =?us-ascii?Q?TcAj6LW+tc9xmRB5HbjVuMq8dHczOOlBDp0zgWwYHz0acEpJyrezAui2ZtFZ?=
 =?us-ascii?Q?FMSJmggQBFoJsCy3w8pT6EvfDUY9i/vBZxof4DSF3eK1blv5MyXourQ0O4ko?=
 =?us-ascii?Q?UMmK2IzTgOxvTo1ofg19cd6gEh82bvrkscJhxEvQ/mCZsha93QNO0oLzeQmE?=
 =?us-ascii?Q?zCxwH+4ZYHmaCnTkteZwuekRqvYpDcW8CbmifObwXAKbwtYEQBBbXncalOK0?=
 =?us-ascii?Q?vCdMr2L9zQ62sJcY3fO02IILCext7LjCTD3Z2QyoC9HrhD7FNYnvOmfXb0Zi?=
 =?us-ascii?Q?wXaTL8jLzBQAVu3MGxGCPS6PmMcxkZzc1zWezmCxhimbUpJWzeWIzmXgQixk?=
 =?us-ascii?Q?uq1uTcm3c5E+YqARxl7kwno/Zv6LijDbmOKJl4PUO+6yEQJcouv0SWoJM7FV?=
 =?us-ascii?Q?h+XrSP8ozKBO0y0WuL+wB3zVTAJTZLYTWiCYXavz/649ljqzC3YEuKzFYZRH?=
 =?us-ascii?Q?mm7fR61RxjRxhsTaUoxblYk/DvdHKiI1pQ/6TwbtVC+zf3N28zjEKKSlprTY?=
 =?us-ascii?Q?s+clbfhJK1Sw8fsfHejiPzrIw61BJGtTqY2ITVDvcZOdkWKe6wzyHR/jDCgE?=
 =?us-ascii?Q?zJyyVH+di7pfuzYlBbsibIwPqHM5peIZTOUlWiAp89hgd+mU1+fGXW8TwLIr?=
 =?us-ascii?Q?Oj9XwlSaY1SEmOCPUmhVwtK/Kh877xTnLvHXCKamopp0E+wvfWHW1faW0n5s?=
 =?us-ascii?Q?ZwkhSd0qMe/g75wuFx3UtoqRhBNzb8Pm8Q3S56UZ6kZKd6PjqGCNpQGoAVjs?=
 =?us-ascii?Q?aHBrVhMl29Haclq9c15rdR243+C1HOmotOdBfPtrR3qYnAhzrCmRV2nHa28A?=
 =?us-ascii?Q?AbPDTcZnYJ8OmoAo5jXktVqudBmi8rtvYXYJK9IA7z3NiNB7rXg7SY/hzFpv?=
 =?us-ascii?Q?zBEYWu8rLZKPIQ9QHHMGpKNuQTRViyVbJpdAsPeFT8VwTK2eZzZhN8ueehn3?=
 =?us-ascii?Q?eYyViOOBFBUH/5RcavFeZrbRSkm+RKElY1rqhFZO/J0NyUgI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qI7/kUZa3F+mRyswfhHWx2tdquducxRyhMFZcePtTBFsfTsuhHRpJGHDh9igp46RgO7ZJhOWwfKA8AoU1p+azENEwyqze2vxLoQ1GtRflmr+NyW8g0wK9Q8nHVoY/0XpisKaje3f+bSOvhseFBT0UCB5cLPtlOYzXXwoBnRCS9o2CpYvVD1jKnAq5pUM4B+8/xsICh0yG5eD0y5X+hpOee75KYjts/c1vinrOfu8erfuAvyPUucPLeNb7oRF9Q6KelO9AxQcVz5aBonaybPev0RqzhXs+2PZum1G7QZjXPWlCzkHRHIOz6Le0Ld0qGfgtYtLnhss5BFHxH/P4Tx6ow==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b49cce0-1987-4ae8-58d1-08ded224263e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 19:09:43.5118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7svnIVlW5lZl9WC6iT4ejHWdgOy5qWHEbTgW8BtESfBsaIY1t5kHZkTb98a+KrBBPUctOG2/nGCY8nD2DXrtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5075
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2MCBTYWx0ZWRfXxehKhXb0HMKc
 D7KIjdjTCxWoVjK6bNHtF9fUSO9v6AX+GCENV/jDIRSyam6g6mMbuEIEPeJqweTwadhvlh0yCmg
 QKNAVIkbfQIfccaKVurmIZ8xiJ+efv0=
X-Proofpoint-ORIG-GUID: IMxSEVujg69m0rc85Gh3UjJ7PBlF6w55
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2MCBTYWx0ZWRfXwsSsZ16moezA
 Cgv0fsotAZVf6axPCiW5jghYeO5+GVn0OsWL726W2VGuVm0esSWzxhIhihmI90mPc/O0SbII6ue
 7tFcBUvhjTk9ZJVOCChX6sr1K9t/nqkx/TMTXA513dbrGLIlccySDvQBsWf0OemWfDNO1Bgj1w3
 TUWDdh/6/Q6k7FTBs07PexMO+ed3iwo/xVLiKyQdmWViaD0IbH4JUeFLCre7j3blGOC/Q01K8n6
 Q7QcDenVE06ZzLER9IaPgzK8NUH67OCmNjT0QCCDZWJH1GSLVB8YZfzd113ZCkZS4qxAGqqxqIe
 oPpp0amI8JUrOlal+2UC8SC8KLGGBTa9f+vwnk71u/bNUldfivF+7Ud2woVx8GzNaOeaX8phwUb
 xRAwz1wLGRpp7mX6M6scAkP8ZwAVfg==
X-Proofpoint-GUID: IMxSEVujg69m0rc85Gh3UjJ7PBlF6w55
X-Authority-Analysis: v=2.4 cv=UIvt2ify c=1 sm=1 tr=0 ts=6a3c2b7d cx=c_pps
 a=CMChTFI+x3L+VPqXLnm0rg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=CKE_VZQQiQvl0YVBdb0A:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
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

> A series of small fixes for the inline ipsec test cases, with the third
> patch being the most significant - skipping tests where we don't have the
> necessary HW support to run the tests. Previously this was leading to tes=
t
> failures when the tests should never have been run due to missing HW
> capabilities.
>=20
> Bruce Richardson (3):
>   test/security_inline_proto: remove fast-free Tx flag
>   test/security_inline_proto: fix MTU calculation underflow
>   test/security_inline_proto: check for capabilities
>=20
>  app/test/test_security_inline_proto.c | 75 +++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 5 deletions(-)
>=20
Series Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
