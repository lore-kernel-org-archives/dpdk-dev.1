Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58846CD98E4
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 19:28:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D40E4025A;
	Sat, 20 Jun 2026 21:28:46 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9C0AF40151
 for <dev@dpdk.org>; Sat, 20 Jun 2026 21:28:44 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65KIEOAj2299851 for <dev@dpdk.org>; Sat, 20 Jun 2026 12:28:43 -0700
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020076.outbound.protection.outlook.com [52.101.61.76])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ewr7h9094-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sat, 20 Jun 2026 12:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cERgimo3C0WSjlSN+5ZhnIi4QzjRNUyruyXWXROAABWQt/4aE3Fk+EDxUhAsP0nwwqQdOgUNhtBbT6Cxj/+VDe0ViAD49M5CGm8qV0RfUtQlJUeReB6fYkJ3XYcTCu4sjpiz+x3uYzMPJOBQYK7sA+vSixprUmmqHb2WiXTDXgaQ4wXwu0R9schqDTGqf8Y6YQg6jy0q8JrmHAMCFV4oCLdJNlAqZEPwdnwQaFKHU3/hqDDZ346xMEvPj3A2wCN4dzVWNq2vJn5TQcClits7wSAZkLhomty4QNEGCGImCud1C2VmkOxewMtRiAEZsHgBUpkvzW8khKET2pC/vafeLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp6T0paogZl+6zH+ZY7+Q5f+NGWFaKxBon6TRyevWEU=;
 b=bgX0KKf1wgK6mTFByYXYCYdpxzE0YMlwQWrx4NuXQYh7iZ0Ea3xt6zdpveGOAh3UTFLolfwGgeT09rFwVaCf7ssBzFzQYtmsBdNJ7o/EUwmlyEq6vqinZHMvPc/5IIa8wcze0kmlAE9zLeNlLZ8wBDcK3KgrOO+3xLB3XkKayHKUZWIjEC0FcCXTzpXWrT+I1VM5DxheVANxX4r0e7oFixSI4usMDx0Q9Q8de8RBFepmDKV5Q9koZfuXwoQuP0/4XWVsSVa+bE/1kj7SSXRQE0Z32XN5VehFhYQAZEoHfXKrK7acuFTvNmlJTqjr6nZi2CYYtrF9W2jCUK0XxTQD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp6T0paogZl+6zH+ZY7+Q5f+NGWFaKxBon6TRyevWEU=;
 b=o5igRIfS/RSRaMati4VlCCTr9MW/G+mtkTp0o8grX9XpjNS0YSF3RUXbJCMkI8EL3dB6LV6ICFIy+eMo4knYC3yhbk/Y3pSu0UKT0yCccWtsxCtzUv4xVVtl1DAi1ozdhtPqA7KTn8FEWyOG4NmUYEjNKKp8FfU3WQq25OQ7WxY=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH0PR18MB3845.namprd18.prod.outlook.com (2603:10b6:510:27::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Sat, 20 Jun 2026 19:28:40 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 19:28:39 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Rahul Bhansali <rbhansali@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Anoob Joseph <anoobj@marvell.com>
CC: Rahul Bhansali <rbhansali@marvell.com>
Subject: RE: [PATCH] test/security: increase wait time for reassebmly test
Thread-Topic: [PATCH] test/security: increase wait time for reassebmly test
Thread-Index: AQHc+WowVgUz7dPCo0yce9iAOM0737ZH4wgg
Date: Sat, 20 Jun 2026 19:28:39 +0000
Message-ID: <CO6PR18MB44842BD6CFDFC80F0F2D58B3D8E12@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260611061851.3099305-1-rbhansali@marvell.com>
In-Reply-To: <20260611061851.3099305-1-rbhansali@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH0PR18MB3845:EE_
x-ms-office365-filtering-correlation-id: 92bcd403-da56-4e3a-f462-08decf0221aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|11063799006|56012099006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: 5ubRIiFkn5BdHTGZ+y/UlFrwMhZsAw2hdV8yWSXi+d/8PcD1JkmdvAxW7SUksYyWy3qVBdrOiovIuwQfAdPa0086q/qo4+Yvf5xAjAP/TcaUjsP0xjq932cXjAAO/QOrtvS/WNw8bYxVuw1n5H1HXGi5wkoKqUBEqiZLMfgYQkpDYV0eeAq5L88M1Nb4/ZNYz9KdMn38oDTlz+2uHbkVSSUuE1bSKkkaJQrv16o4QSMb32YhRppZYkF1ukG9zxV2ff4RHzYP7w38XJcuU5D3rdaSDzUm56fAgCba9DqzJzHxBWzTW/C7KlgEAPIh+hverEg2rhz3HlKeL7nxQrTYfvTIzZdSbO+/nCoafU2WE0odXBywNH9PjkWSmwq2YGM9epvSriLJv9lPBCicCkmWnC7gl1xIQ+86GCKDX5PgLExbfyydmM55hAlxP9viko0A0ERb0z/D7DuaHdulLhLpR7sMUQeTYVysxZAJ0qxooIxRQXqw8ekW/h3EERlpYI2NBUWPvSucswRoWoyuEUDprmzG6JdgthrYfp7ZFO0a+EFI4OQFtjJ3y2ULI2YDC15lTidsd/vE31oh458nbEvsmqCfmxYt4ltB0jol84vivX0Wsfbk6S9WKMz+EZ/z7sc83OcfZoYRxcxo8z4v3VU2Dh9JJEucBFaR/r195ECX6zBmR4YEuNapgH+DyEi41TQufQbTSGQhj/azT23NoB472/sdUlYzgmrGq9bsqRJreIU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(56012099006)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Xb+wyWDvISMZ385MufEtkrr9npOd/BP9gysPNa0VHdBr5OVHz6ko6FwCC2b?=
 =?us-ascii?Q?O6h8mXeS72RCLCUhEgrpoHDn30SKPj5mkkTm3z6up0jkD70Q7Kk7gLtEuu3Q?=
 =?us-ascii?Q?AdgC3+Wg/Rr50LDq4lcTxDHJzCIWx9UhtIsyXH+4ewf+LCPsfsPadVTukRAo?=
 =?us-ascii?Q?edG/CDv+SN7UD2vtQbywq08C5+Ax2sX+B1pafQXM8IsJywI0V224HnECDfOj?=
 =?us-ascii?Q?3n0eAeN/xVeUPMEL5Khge65GWCOLBmdkkypALJSOe8xmxSqukUUIpp4HCxBk?=
 =?us-ascii?Q?5F8vnatK2dVdNObHzgoq0H+z0y3t/UHpPegxUv+aFj3NBfOCRZrSmKvdliJW?=
 =?us-ascii?Q?9aFnrVlYw89PTkfsxtqnsb198aOXdALQ+U+3J8Oy6wWooGOEK4rwjIhnIvHp?=
 =?us-ascii?Q?GkLk8fOOsSuXUw3UIGOGAAIrJ38cAP4uhbMFjxWZiD2CQNlfTvgENo1Lto71?=
 =?us-ascii?Q?6m4HMtOS1W9bzdc+yGhf/zzOjL8Ut8DkkM3GV3iPkBHOqeSS2P0aydYJAzjW?=
 =?us-ascii?Q?0HwS9CiT8/hxXGoXRnviC7rWYvWgtdiJtBUOwxBr1oLjw3GE/+8rQAHKKJJF?=
 =?us-ascii?Q?xrsvp8NSrATpSTUA94JKEdWfzroUd3vAepUYMSJtsn8gwFusF/LdynVoKSrE?=
 =?us-ascii?Q?yjXy/B5T8qIg697blZUuQAZE09TzT9WV+uH2c6uE3w6oJhT1+toynO9F0gUE?=
 =?us-ascii?Q?IILphMYjnXHfpRAfOeKOTfdL/t2/BH5ZTWw+E+cvK5uVOyzVhN4QsQsFySXp?=
 =?us-ascii?Q?E03kPf6398l880SWP/PxXLy2SOdCm2BKvbIrfQDsKW9r4z4xW3XPJxLZ5b0W?=
 =?us-ascii?Q?05XibR/gRzq7IcU9uzoc7wFBmBEnCzFJ4gAVrUm+9suIsmOA5xQwpQmcXEQ3?=
 =?us-ascii?Q?ZtUNqzWquBmD7YMoFgpKgRU5VjzpQtTtFvvPBwNBoUbl1gkMKPDQUjvJRlKe?=
 =?us-ascii?Q?9QveKBItRH53YGvauWOxjnygeGm53o5wVKEsiokp4KrVJO+neGk+rWkjoAtF?=
 =?us-ascii?Q?ogr4SPFnPyA5iTxe+tYdHiuBJbnwTMPUKOdoKOU/8pFol8BBOD4S37cIfghY?=
 =?us-ascii?Q?A2lU/GCoVH6qS2XSsbctprjLqpl20OyWqzYfae2R1eOeV4jqS+Xxe37eTLc1?=
 =?us-ascii?Q?9qreDFou9gMsAc6cz6xIxURY89gxqgKB4VlKt5g6+FKuu+VoSxieaYas6Qlv?=
 =?us-ascii?Q?5YAK/bkFPUwxaDuBflPNjSytUbekCDt3v+ycjyt4WmayM7d1apeMULGgj+kd?=
 =?us-ascii?Q?CMQ506Z2o3gkr9LaXymiYqcxT0J/ff+PBVU5GC0u778ZBttX3RdeU2hzHS7N?=
 =?us-ascii?Q?7OUBXiGoFcfFZvSimSOQl0ERwQ/wEwn3b9vV6dWixujS4vVONweTYI4pUEWM?=
 =?us-ascii?Q?PVfki0sFlZCYM4XH6ePcNjV9znCQOHl+3uT/JsRmMfntm6Q2LwAMGcFBxVYi?=
 =?us-ascii?Q?kj2GOOegWolx6c0HF8TTcJSTL9lHmBiUmhu3m43jyyZOzMYKhj7Rk4HPOP4E?=
 =?us-ascii?Q?Tm0E6S3Yy0kcsfE8bJfXEDm8EX54xJuz+MmjCMGZDvsDRHGtX5qpZRPQVB1u?=
 =?us-ascii?Q?jss7u9gGcp2zJhcdQOVtOMX+WxoGucV50dj4VfqQVPrANU0LTsaSVY79zzT0?=
 =?us-ascii?Q?pp33GMNZw64JL8c4WeMx68M12gQhjFsmsIQCBwz3X9wGzVKDbnFS6BiFfgx/?=
 =?us-ascii?Q?ibFWc1mhq0TmT7jOPvqKuBjmlXl0sGvvMwSpf6fFTjKbAcgg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bC0HNFNx4G78ahAuWXPQ9qNs5tDu535xBv/b58cJy62qnSneldH1f6SXt4YTMknnPL/1SYRiUP6YqHfgcqlhIH8eR48XHQveT3F51QBpDRMjGPcg7Z4GV1mD+PmQIJCFHBNZDADoczGp7gMJrYcDd+ykYUSHdGFEMspkH8i9xhvYwUxDkiUYYU68GsWmY0HzvTOyzGd+7C7LStg3I7eHYXLP6hw2aIsc0XiqglqrXg4g41jMVNyF/xuNdRQb3KqFfDsPJRPsgJKjYtqzliTEqmgBcajUujTS4Kbysdrn2ppnHYsA+olqiGq9OLcBIT9mZuOnFKS5QfyRRHANGVzrQA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bcd403-da56-4e3a-f462-08decf0221aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2026 19:28:39.4458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYbFVCxN+ex4xByVlGwF48Q30IzvWJlbhlFF7p4N8NY5xpSz4tBIMB6eWFEuHGkhLLbDw0Ul/D9ol2WzFpV9aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3845
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDE5OCBTYWx0ZWRfXyg8ji3JJUtfq
 vWxmyhBo8ayZ/RAj6I5a5R3JOdHhWe2unCtwA9gnXjP5X7Cn5UVBlGecNkCPBZYBsMzDMy/TBCO
 Xlrz6GzuWxjmjAewnw/Rv6IwC56860DahIcQq/1EGzUsRsV7ivc/0SqdLAQ1x3XONd8f4CWUOBM
 HJoFC+N4QZc2MAUtOUHLRf8bX9UIa3F5VAiaqAJV/rB+wvIK4zQUQchCKibyGgp9YuLElQpgDQy
 5sw8Zdn4LRbuNr7r8jgKE/nWazJzISIe/4pBCe0qwnF89CGK1zUe9/hsOfyWXP9KkYvyzkbGzrn
 1FunstjWDpoaSlkM1jyNJ52vdcSFu85KvU4ic3NJE/mVarsaaH50+Sohk5EuR2nqWOhlc6FCD8n
 5MTF+gU76YxI5MQNECDWsOHO8G60aFpCpBKejBoLRjcrpBJrrV6KrV8zdegl8uAScdbXXyduwW7
 TomkAAO3eucpxzEgOIw==
X-Proofpoint-ORIG-GUID: RtLfW-fkB67lyiFahQZOIJwdVab1Y8a_
X-Authority-Analysis: v=2.4 cv=aJTAb79m c=1 sm=1 tr=0 ts=6a36e9eb cx=c_pps
 a=2vyhS9wvvmK9UI+0OhD4Kw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=X7mmUJwo1Seuofc2f_wA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDE5OCBTYWx0ZWRfXwRuTFxYOoHV4
 ML+9PuUsiIF9xnS5pqKab6UgUlrWX17PfpmJ90F+H71tPTKGMEEyfq+VN9mgW+q1wM5Td45mgf5
 h659dVIEvE7YuiUEC3kDKY6jZy9QRXA=
X-Proofpoint-GUID: RtLfW-fkB67lyiFahQZOIJwdVab1Y8a_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_03,2026-06-18_03,2025-10-01_01
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
> From: Rahul Bhansali <rbhansali@marvell.com>
> Sent: Thursday, June 11, 2026 11:49 AM
> To: dev@dpdk.org; Akhil Goyal <gakhil@marvell.com>; Anoob Joseph
> <anoobj@marvell.com>
> Cc: Rahul Bhansali <rbhansali@marvell.com>
> Subject: [PATCH] test/security: increase wait time for reassebmly test
>=20
> In case of multi segment inline IPsec reassembly burst test
> of 4 fragment per packet where each fragment is multi
> segmented ~11k bytes and sometimes few of reassembly fails
> out of 33 such burst.
>=20
> Delay of 1ms after burst Tx is not sufficient in this case,
> hence need to increase to 10ms to avoid random reassembly
> failures in functional tests.
>=20
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
> ---
Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto

