Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8FEC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 11:25:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 006F0427C3;
	Wed,  4 Jun 2025 13:24:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 393684029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 13:24:57 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553KRwla021391;
 Wed, 4 Jun 2025 04:24:49 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2109.outbound.protection.outlook.com [40.107.236.109])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47283r9hf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 04:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RU/l/bAd/Tp3erlaUPeRTkXZXXjvQ4Ni+0oU7cbqlBNwBE+jeNUwDYTJ8+Az4/l6qYbjvJYfBohM9LW/BdntA5kmGtMvhhTHFty9SbnyfWkJaEFn5bBfsJ+WFKa1HhY53p/J/gqR8CYzaP0iecc072ojiFuEfMi6k9wjgUBvmpiJbHKtSz+QYf60UqjxiJpHwsv6WzgPnPfF92odFyJXFF1gLxgmGYl94G8K1iljsZUUrblVcWOG1skUfYar3kqdkjdXqExwsGJJEByYE3RF6+X71vyyer9QMGV0DQgIElNQT4zXstCSBuk1upn0gA8hLOoKdNY5OjbZPI4MlsChvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5QP4fJETgk91Bzl8dSaF83RPDKad0MH0SjM4uzKAXw=;
 b=ozq6lekybiWLqIrE2YxoGalUPqdblFrI3anYD5sT5ecnV/3hKYlVeImmm24Zuk8NE/BUA42QPlNuVuP90gDW63bXmgtxintjyEI6ydESqqTETLU3Qmc/X7IaAmaF8Tcf0byoufSdfurgobkNj08Gkc0uxq8lmwwlYUU3ZuSA1lAnbX7W/ZNYklU92gFgjqKt3PvvnkcWzo3p4sk79Fv6Vwqx4t4MEoyMZmgxtdfCeR9PJIag8zh0QuVjGhhRxLDraHak99LFeEH7LJxkSl7ueYLWh1Re/RvLFcdzcfpKEh1hXBwAOeQ3xYlmMcg64tZN/MVR2sOf3dk377f+hPcgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5QP4fJETgk91Bzl8dSaF83RPDKad0MH0SjM4uzKAXw=;
 b=gnxThljrTxgtw++VtMITn2tvjBXho8qS8iZPQmBRUAshjurmnvQPQw/OVO3FmIcSCFkKnfnq1Zt8l3OUbJxOedHDHAVDPQmeRJ3Rgc7Tqo8CtUCQygGt5UgjqaB1+KJW9+U3ey1FMHVh5UARkyuwmn5Syyxel4fCzDrXdxJkuzQ=
Received: from DM3PPF17CE793AB.namprd18.prod.outlook.com
 (2603:10b6:f:fc00::68d) by MN0PR18MB5847.namprd18.prod.outlook.com
 (2603:10b6:208:4c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 4 Jun
 2025 11:24:45 +0000
Received: from DM3PPF17CE793AB.namprd18.prod.outlook.com
 ([fe80::3c32:7740:d3ba:3052]) by DM3PPF17CE793AB.namprd18.prod.outlook.com
 ([fe80::3c32:7740:d3ba:3052%4]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 11:24:45 +0000
From: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
To: Nitin Saxena <nsaxena@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: RE: [PATCH v10 3/7] graph: add feature arc init APIs
Thread-Topic: [PATCH v10 3/7] graph: add feature arc init APIs
Thread-Index: AQHb1TlNpKX83x3xcUmQJ4flg3GHkrPy0pcA
Date: Wed, 4 Jun 2025 11:24:44 +0000
Message-ID: <DM3PPF17CE793ABE46D170841F018BCE2E1AC6CA@DM3PPF17CE793AB.namprd18.prod.outlook.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250604101259.4181992-1-nsaxena@marvell.com>
 <20250604101259.4181992-4-nsaxena@marvell.com>
In-Reply-To: <20250604101259.4181992-4-nsaxena@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF17CE793AB:EE_|MN0PR18MB5847:EE_
x-ms-office365-filtering-correlation-id: 014c3ffa-9256-49be-1231-08dda35a6855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?6iHHsAs+wO13JXYqUjE17p433QdGlvfRYIi6zSh1lVDRo0l+Z0LnbU6xNgem?=
 =?us-ascii?Q?6PJmsXBlSg8CYWetlgK454WphhuemtcFcTuaJYWegMvKXpkKCWTA5hJ2vERT?=
 =?us-ascii?Q?XvGuNw7GTsRGF4RxxsELcFPWgKYeWAwqbNa2P2BDmLM79K1M493bqa/EhR35?=
 =?us-ascii?Q?ZKgAvmBNw3OK/TFgGWAyth42teueEY3GlKf8i/BvS1lcAwEs3ciJGjx2Ub26?=
 =?us-ascii?Q?WSgZjaxyv0D/+eM1ThOQp9c4FKwHDBBX0lwq1FO6oBUZ2bsDiUrPSCdmmm+b?=
 =?us-ascii?Q?h6mgjDXFcwQDp351QlIBhO/J13gLXtgBVq4ZsFFnzGDqnzmeql/iL9xGMlO8?=
 =?us-ascii?Q?gcBWGG6IZeeItL61xlG34+VewFjr0X4koKww8Wau/Vn4cT7PGOG7s/JLubq7?=
 =?us-ascii?Q?5ukuOdbyOm78ARWCKV5lMCo5jYxIPd8ZQRConVzaPmXv+9H+H5i7d+ZTvSjM?=
 =?us-ascii?Q?IIzw3s/nyhC4odAlYhnY0RnvHZafYAGHY+Xw4F10AR/K6McVgivo380YiOw/?=
 =?us-ascii?Q?PapjsGOHPCgKdeV8lVBoA90HLg5MGlN6FCt6f0lbL0NWIZ9UUC5k82KMDY+r?=
 =?us-ascii?Q?9QMPWUcd5aBqXpLVOIzMcoJmqJirax2xj5Ojdou403v1EmdztPw9H11LpuH1?=
 =?us-ascii?Q?SolJa850pFb6CubbKySiBmOh1vBmf93s38Zf0hBojxMWxt60BmSYoLoZj8z5?=
 =?us-ascii?Q?ARcPQhTnWaEOkixf4fHdhLIdcujmPs7JWRHSlyIru9leQeirKQy9k54Ey+ho?=
 =?us-ascii?Q?5nNUzBCPB3JCMnNBT4Mvb2xNI9FrEStNzrf3hjmvm9LoynOHPkbcp19HjUS3?=
 =?us-ascii?Q?qxqzkAXotM1ZHxlEtbDCPf7B5J9aGtMwV67IX7cxom7VuEh4FC797+ZKN8HA?=
 =?us-ascii?Q?hS35QvgxeJA0ahVVQVqvp2EupsRfyEmmfMjAsENUiSCc6YQ7K3vN1fSg4frw?=
 =?us-ascii?Q?cLEe7YUhcBLnM7yHhW7XcbI1392jhA4WpemQScU5garulSIHkv2glPVWBTnZ?=
 =?us-ascii?Q?aK7T+HZqDe4Nze21gU0NeJt9303gvKyMDmn9m/WCLWQGnNTs+AlZiia5R0z5?=
 =?us-ascii?Q?fIJOf9Vc/UEC8F3aMeMSntK5U5nY04BrDJjhh0NdRNKwwxb/cMxJoEpCskmw?=
 =?us-ascii?Q?YUsVwMW8oYfnUjrrsFR1wXpJJLh8D1Ukkglx3UxkBZZZDtTh6Ew0Dv4ahNIE?=
 =?us-ascii?Q?PaWqN4usnFjFic/zK7lWl8SadPbx6zr1eiBsdLWmefhtzr2h4KFU64Fa3j0Y?=
 =?us-ascii?Q?FfzHzI+AvKC/+HJwtr/oM2FD51Wfr2GEoG2Rksul7f1oMM6ZGFO8ln4sR/zi?=
 =?us-ascii?Q?2CWztDolbGD/02wIEsiL8ChH4OhmLj3VJpR9iYofUot96qlVijlS8e4nBy6X?=
 =?us-ascii?Q?N+z16G4hqIiunlva1hjcp98L0PbnvNvoWl+p5azhH/Cr+NRU+goaeQlUaAIL?=
 =?us-ascii?Q?DuD6GhHg88oa719Y6O06+cIithTCsKPS6VkWh9rOHb4y138nAM9rwg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF17CE793AB.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wknQtRa7aYR3rr6A3IVwzLrknMNmoWZBUTlVOl4wUxbyBsWaI57YIQEOLzR3?=
 =?us-ascii?Q?Mey/ew6SHEUJAP+NrhtR+nmrUteKCjFQIqU8ltjnJI7Hp/auGSEbr/NGZ3M1?=
 =?us-ascii?Q?J4a5hqOkDYVBpmwUbMXKdG6d63L426P+NDk8o5l5b+g6lPscrxTgmeG+qBBo?=
 =?us-ascii?Q?9hPycd7jfnVDd6pSMlelk1WasCgep8kYBBb2i8bDFG33eRTBy6IIy52gzQWo?=
 =?us-ascii?Q?9SZjbGeDulDtT0ShMp4Wm+WjTmyXEH1gYTWqz/2VCzcYLA/CI7XcNsUqg+Oc?=
 =?us-ascii?Q?AKKWwYnbNcvBVHxdT45ijmCzFyx8juEe3ej5PPCyW7EI2CmNbf/rDWZGFMNp?=
 =?us-ascii?Q?3eqsZZau4k4kXyK7RCool1muMm/bGwNBji8jKCaNbI1NZnLAhHApQYPVtcdJ?=
 =?us-ascii?Q?OqNs4e5iiYhq7ABwxyeg2iBU4FJCZBasdzl0EmghCm1oC88DZgxrfb+ld0Nx?=
 =?us-ascii?Q?qPRXZFQ89yPm/1u4NBHRex5cflbFdGCi6r0YLd/LEjv32Nx48PynxbWRBQ/Y?=
 =?us-ascii?Q?pg0eEBu77a7GBVaqpHFd32S+XmoE1Ghp+KnXioAdhVxwLB+ILSRTaDQ9vCid?=
 =?us-ascii?Q?Z07LAymcqnjKyvTyymlFdFCWOVl3p6jg70ixluYyuIVfDMDY7HvqnVpKdbSp?=
 =?us-ascii?Q?nCh0dVsESE+GNLW84hmKw0CIsbxSY2sR5e5lI9lxBZnzHD6yCdbr2/UDNqfA?=
 =?us-ascii?Q?x5fSSamk895V8cHgwbbmw9mzoTzoiXIf++D0Pe3NDn2dcG44gcEKhCWzfMJF?=
 =?us-ascii?Q?dna810uM3f5Rs7twzBPPtAYqR1Bnzl5Vy/qE6VYB/XZinE9MlH3+oi5weFSL?=
 =?us-ascii?Q?5kQn1zyAnh1pe+smhAil+xHiVHtfBC+pqm5d59hhke/bnAZ3PXKU5zoVlfah?=
 =?us-ascii?Q?017erc2MLJY2FmBWT/whN5dLLeMe73mhUh4Jiz5SEPHn7fJ93ie5aFvp6Ywm?=
 =?us-ascii?Q?RSjvBddEN6KlNjBY+tv0R4pYg7cYN9BIrYN7CwT1x8DqNDOR9SxvwEGvu8zv?=
 =?us-ascii?Q?Y7YnuteNF3/PDD1098wvOaX0M/hOygUSnHGQO0svofuy1aY+vHxi8twk6vqi?=
 =?us-ascii?Q?RQPhuwqmbJrMilWP9o9BtJKkAl3Dz/Tg6XhJnVI/xtfgZe5VUWmm3V33q9Xe?=
 =?us-ascii?Q?F+ZXl2bYaHLJSKy3i6H1I5f4LpNLp+DsiSY5R+7VKm+4UFZZ2B6IUdzlegoL?=
 =?us-ascii?Q?t/7rkpIlIiQ1J2a4aGtxjpDu6kjTQWQjqxzNd3spCdGZtEySgMhaNrqoEtpj?=
 =?us-ascii?Q?2sx/MK4yoLlxyPStpMQt/WnWgxkoIYvGehEZOe7MuH5on2lkfFCnEgurg+vi?=
 =?us-ascii?Q?m5nGZzIt81+VRjczdkBDdV1OrPs0TbSOY+egDqdFDLBQuKmHSH1fmXJxaz3D?=
 =?us-ascii?Q?oClBxhOD+MFw0sij+0qp3f0gd1uHiVbmRHxyhHSXWSwq0YsGBElghpsA5Pxg?=
 =?us-ascii?Q?MLBNLrRNUVeBRmPWhoAfTpNTTOPtfvo322P099yI7/MGj7c2ztkIuc75v1gG?=
 =?us-ascii?Q?7uCMk4GZKAf9x56GNyu8YLwRL7/aPAH/uh+4vGuT+y1kHj2HzbXNOdA/79NL?=
 =?us-ascii?Q?ENLmKNMq4790aynESX3ZphTYRisGxQD/s1uhtpSX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF17CE793AB.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014c3ffa-9256-49be-1231-08dda35a6855
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 11:24:44.9176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4NR/W7ynUyyIlYPvPtBpferW4EPHPxCi9IR17YL5fAAFBCc5NtrUN9wQfJxydQLyfyetYCBm7/cX25JZraL7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5847
X-Proofpoint-ORIG-GUID: hvq-iDsRqx98u1bcI7OyNQ0v5S1nf9eg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA4NyBTYWx0ZWRfXxLVXOHltw7x2
 iiUgbCvd/ZeQAmHRcVDFjAvPLxnA4vwS0N38aloMvXINeEbauS2po3OGpShustOwOEcFwv6yhXd
 KPd7wm22yV1ztE8yAaev4ri/n7al7O+WkQe1vQ+54xJKbl91Uibc4OY3Lc0Z4hnW2Is+f7Ul3tP
 dryawxaMD/Xd0YhMIpSoWL09PUMrnTeLILfTBfAG8fl1CBPD3bi/UYGwa+I9CnjiAOV3UDpYqu7
 KtZR5/Iz1F8edyG5+DKBt7fskM/W9Kik+i7r45oY/mW957zsx/eSXxaKr826r5lzIVeFZXIy8lV
 2n36fV4EVqaUIbpsbsrUtdz2lTNk4Tb+Ilob4k4LYeKGLX+hA7JkfSd5xX/uDFVGqpfuASa3+zp
 6t2RZTqdGViRjOZTd2pzF7IS2t6J+5bpVAZwKJEginaIFcW17c8Fl3QlHGac3++7Q8pbswZn
X-Authority-Analysis: v=2.4 cv=E7HNpbdl c=1 sm=1 tr=0 ts=68402d01 cx=c_pps
 a=+wvPo2SBDV19RUAmjpb+EA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=Byx-y9mGAAAA:8
 a=20KFwNOVAAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=qJWt4JDjc9ObuScJPfoA:9
 a=CSGGGR-vdv1nGKxz:21 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: hvq-iDsRqx98u1bcI7OyNQ0v5S1nf9eg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
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
> From: Nitin Saxena <nsaxena@marvell.com>
> Sent: Wednesday, June 4, 2025 3:43 PM
> To: Jerin Jacob <jerinj@marvell.com>; Kiran Kumar Kokkilagadda
> <kirankumark@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>; Robin
> Jarry <rjarry@redhat.com>; Christophe Fontaine <cfontain@redhat.com>
> Cc: dev@dpdk.org; Nitin Saxena <nsaxena16@gmail.com>
> Subject: [PATCH v10 3/7] graph: add feature arc init APIs
>=20
> This patch adds feature arc init()/create()/destroy() APIs. It also add
> APIs for adding feature node to an arc.
>=20
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
> ---
>  doc/api/doxy-api-index.md                |    1 +
>  doc/guides/prog_guide/graph_lib.rst      |   23 +-
>  lib/graph/graph_feature_arc.c            | 1329 +++++++++++++++++++++-
>  lib/graph/graph_private.h                |    4 +
>  lib/graph/meson.build                    |    2 +-
>  lib/graph/rte_graph_feature_arc.h        |  248 +++-
>  lib/graph/rte_graph_feature_arc_worker.h |  303 +++++
>  7 files changed, 1902 insertions(+), 8 deletions(-)
>  create mode 100644 lib/graph/rte_graph_feature_arc_worker.h
>=20
> diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
> index a7bdbf892c..6d8b531344 100644
> --- a/doc/api/doxy-api-index.md
> +++ b/doc/api/doxy-api-index.md
> @@ -215,6 +215,7 @@ The public API headers are grouped by topics:
>    * [graph](@ref rte_graph.h):
>      [graph_worker](@ref rte_graph_worker.h)
>      [graph_feature_arc](@ref rte_graph_feature_arc.h)
> +    [graph_feature_arc_worker](@ref rte_graph_feature_arc_worker.h)
>    * graph_nodes:
>      [eth_node](@ref rte_node_eth_api.h),
>      [ip4_node](@ref rte_node_ip4_api.h),
> diff --git a/doc/guides/prog_guide/graph_lib.rst
> b/doc/guides/prog_guide/graph_lib.rst
> index 191c8e8a0b..c9ac9e7ae0 100644
> --- a/doc/guides/prog_guide/graph_lib.rst
> +++ b/doc/guides/prog_guide/graph_lib.rst
> @@ -815,7 +815,7 @@ added to existing arc as follows:
>              ...
>              ...
>              ...
> -        .override_index_cb =3D Feature-3_override_index_cb(),
> +        .override_index_cb =3D Feature-2_override_index_cb(),
>          .runs_after =3D "Feature-1",
>          .runs_before =3D "Custom-Feature",
>      };
> @@ -848,3 +848,24 @@ this callback. In case of multiple features, largest
> value returned by any
>  feature would be selected for creating feature arc.
>=20
>  .. _Feature_Arc_Initialization:
> +
> +Initializing Feature arc
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +Following code shows how to initialize feature arc sub-system.
> +``rte_graph_feature_arc_init()`` API is used to initialize a feature arc
> +sub-system. If not called, feature arc has no impact on application.
> +
> +.. code-block:: c
> +
> +    struct rte_graph_param *graph_param =3D app_get_graph_param();
> +
> +    /* Initialize feature arc before graph create */
> +    rte_graph_feature_arc_init(0);
> +
> +    rte_graph_create(graph_param);
> +
> +.. note::
> +
> +   ``rte_graph_feature_arc_init()`` API should be called before
> +   ``rte_graph_create()``. If not called, feature arc is a ``NOP`` to
> +   application.
> diff --git a/lib/graph/graph_feature_arc.c b/lib/graph/graph_feature_arc.=
c
> index 6135b262d5..b28f0ec321 100644
> --- a/lib/graph/graph_feature_arc.c
> +++ b/lib/graph/graph_feature_arc.c
> @@ -2,10 +2,57 @@
>   * Copyright(C) 2025 Marvell International Ltd.
>   */
>=20
> -#include <rte_graph_feature_arc.h>
> +#include <rte_graph_feature_arc_worker.h>
> +#include <rte_malloc.h>
> +#include <rte_string_fns.h>
>  #include <eal_export.h>
>  #include "graph_private.h"
>=20
> +#define GRAPH_FEATURE_MAX_NUM_PER_ARC  (64)
> +
> +#define connect_graph_nodes(node1, node2, edge, arc_name) \
> +	__connect_graph_nodes(node1, node2, edge, arc_name, __LINE__)
> +
> +#define FEATURE_ARC_MEMZONE_NAME "__rte_feature_arc_main_mz"
> +
> +#define NUM_EXTRA_FEATURE_DATA   (2)
> +
> +#define graph_uint_cast(f)		((unsigned int)f)

Not used anywhere in the patch.



> +
> +#define feat_dbg graph_dbg
> +
> +#define FEAT_COND_ERR(cond, ...)                                        =
   \
> +	do {                                                               \
> +		if (cond)                                                  \
> +			graph_err(__VA_ARGS__);                            \
> +	} while (0)
> +
> +#define FEAT_ERR(fn, ln, ...)                                           =
   \
> +		GRAPH_LOG2(ERR, fn, ln, __VA_ARGS__)
> +
> +#define FEAT_ERR_JMP(_err, fn, ln, ...)                                 =
   \
> +	do {                                                               \
> +		FEAT_ERR(fn, ln, __VA_ARGS__);                             \
> +		rte_errno =3D _err;                                          \
> +	} while (0)
> +
> +#define COND_ERR_JMP(_err, cond, fn, ln, ...)                           =
   \
> +	do {                                                               \
> +		if (cond)                                                  \
> +			FEAT_ERR(fn, ln, __VA_ARGS__);                     \
> +		rte_errno =3D _err;                                          \
> +	} while (0)
> +
> +
> +static struct rte_mbuf_dynfield rte_graph_feature_arc_mbuf_desc =3D {
> +	.name =3D RTE_GRAPH_FEATURE_ARC_DYNFIELD_NAME,
> +	.size =3D sizeof(struct rte_graph_feature_arc_mbuf_dynfields),
> +	.align =3D alignof(struct rte_graph_feature_arc_mbuf_dynfields),
> +};
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_arc_main,
> 25.07);
> +rte_graph_feature_arc_main_t *__rte_graph_feature_arc_main;
> +
>  /* global feature arc list */
>  static STAILQ_HEAD(, rte_graph_feature_arc_register) feature_arc_list =
=3D
>=20
> 	STAILQ_HEAD_INITIALIZER(feature_arc_list);
> @@ -14,6 +61,1251 @@ static STAILQ_HEAD(,
> rte_graph_feature_arc_register) feature_arc_list =3D
>  static STAILQ_HEAD(, rte_graph_feature_register) feature_list =3D
>=20
> 	STAILQ_HEAD_INITIALIZER(feature_list);
>=20
> +/* feature registration validate */
> +static int
> +feature_registration_validate(struct rte_graph_feature_register *feat_en=
try,
> +			      const char *caller_name, int lineno,
> +			      int check_node_reg_id, /* check feature_node->id
> */
> +			      int check_feat_reg_id, /* check feature-
> >feature_node_id */
> +			      bool verbose /* print error */)
> +{
> +	if (!feat_entry) {
> +		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno, "NULL
> feature reg");
> +		return -1;
> +	}
> +
> +	if (!feat_entry->feature_name) {
> +		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
> +			     "%p: NULL feature name", feat_entry);
> +		return -1;
> +	}
> +
> +	if (!feat_entry->arc_name) {
> +		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
> +			     "feature-\"%s\": No associated arc provided",
> +			     feat_entry->feature_name);
> +		return -1;
> +	}
> +
> +	if (!feat_entry->feature_process_fn) {
> +		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
> +			     "feature-\"%s\": No process function provided",
> +			     feat_entry->feature_name);
> +		return -1;
> +	}
> +
> +	if (!feat_entry->feature_node) {
> +		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
> +			     "feature-\"%s\": No feature_node provided",
> +			     feat_entry->feature_name);
> +		return -1;
> +	}
> +
> +	if (check_node_reg_id && (feat_entry->feature_node->id =3D=3D
> RTE_NODE_ID_INVALID)) {
> +		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
> +			     "feature-\"%s\": feature_node with invalid node-id
> found",
> +			     feat_entry->feature_name);
> +		return -1;
> +	}
> +
> +	if (check_feat_reg_id && (feat_entry->feature_node_id =3D=3D
> RTE_NODE_ID_INVALID)) {
> +		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
> +			     "feature-\"%s\": feature_node_id found invalid",
> +			     feat_entry->feature_name);
> +		return -1;
> +	}
> +	if (check_feat_reg_id && feat_entry->feature_node) {
> +		if (feat_entry->feature_node_id !=3D feat_entry->feature_node-
> >id) {
> +			COND_ERR_JMP(EINVAL, verbose, caller_name,
> lineno,
> +				     "feature-\"%s\": feature_node_id(%u) not
> corresponding to %s->id(%u)",
> +				     feat_entry->feature_name, feat_entry-
> >feature_node_id,
> +				     feat_entry->feature_node->name,
> feat_entry->feature_node->id);
> +			return -1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/* validate arc registration */
> +static int
> +arc_registration_validate(struct rte_graph_feature_arc_register *reg,
> +			  const char *caller_name, int lineno,
> +			  bool verbose)
> +{
> +
> +	if (reg =3D=3D NULL) {
> +		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
> +			     "arc registration cannot be NULL");
> +		return -1;
> +	}
> +
> +	if (!reg->arc_name) {
> +		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
> +			     "feature_arc name cannot be NULL");
> +		return -1;
> +	}
> +
> +	if (reg->max_features > GRAPH_FEATURE_MAX_NUM_PER_ARC) {
> +		COND_ERR_JMP(EAGAIN, verbose, caller_name, lineno,
> +			     "arc-\"%s\", invalid number of features (found: %u,
> exp: %u)",
> +			     reg->arc_name, reg->max_features,
> GRAPH_FEATURE_MAX_NUM_PER_ARC);
> +		return -1;
> +	}
> +
> +	if (!reg->max_indexes) {
> +		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
> +			     "arc-\"%s\": Zero max_indexes found",
> +			     reg->arc_name);
> +		return -1;
> +	}
> +
> +	if (!reg->start_node) {
> +		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
> +			     "arc-\"%s\": start node cannot be NULL",
> +			     reg->arc_name);
> +		return -1;
> +	}
> +
> +	if (!reg->start_node_feature_process_fn) {
> +		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
> +			     "arc-\"%s\": start node feature_process_fn()
> cannot be NULL",
> +			     reg->arc_name);
> +		return -1;
> +	}
> +
> +	if (!reg->end_feature) {
> +		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
> +			     "arc-\"%s\": end_feature cannot be NULL",
> +			     reg->arc_name);
> +		return -1;
> +	}
> +
> +	if (feature_registration_validate(reg->end_feature, caller_name,
> lineno, 1, 0, verbose))
> +		return -1;
> +
> +	if (strncmp(reg->arc_name, reg->end_feature->arc_name,
> +		    RTE_GRAPH_FEATURE_ARC_NAMELEN)) {
> +		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
> +			     "arc-\"%s\"/feature-\"%s\": mismatch in arc_name
> in end_feature",
> +			     reg->arc_name, reg->end_feature->feature_name);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +/* lookup arc registration by name */
> +static int arc_registration_num(void)
> +{
> +	struct rte_graph_feature_arc_register *entry =3D NULL;
> +	int num =3D 0;
> +
> +	STAILQ_FOREACH(entry, &feature_arc_list, next_arc)
> +		num++;
> +
> +	return num;
> +}
> +
> +
> +/* lookup arc registration by name */
> +static int arc_registration_lookup(const char *arc_name,
> +				   struct rte_graph_feature_arc_register
> **arc_entry,
> +				   bool verbose /* print error */)
> +{
> +	struct rte_graph_feature_arc_register *entry =3D NULL;
> +
> +	STAILQ_FOREACH(entry, &feature_arc_list, next_arc) {
> +		if (arc_registration_validate(entry, __func__, __LINE__,
> verbose) < 0)
> +			continue;
> +
> +		if (!strncmp(entry->arc_name, arc_name,
> RTE_GRAPH_FEATURE_ARC_NAMELEN)) {
> +			if (arc_entry)
> +				*arc_entry =3D entry;
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +
> +/* Number of features registered for an ARC
> + *
> + * i.e number of RTE_GRAPH_FEATURE_REGISTER() for an arc
> + */
> +static int
> +arc_registered_features_num(const char *arc_name, uint16_t
> *num_features)
> +{
> +	struct rte_graph_feature_arc_register *arc_reg =3D NULL;
> +	struct rte_graph_feature_register *feat_entry =3D NULL;
> +	uint16_t num =3D 0;
> +
> +	/* Check if arc is registered with end_feature */
> +	if (!arc_registration_lookup(arc_name, &arc_reg, false))
> +		return -1;
> +
> +	if (arc_reg->end_feature)
> +		num++;
> +
> +	/* Calculate features other than end_feature added in arc */
> +	STAILQ_FOREACH(feat_entry, &feature_list, next_feature) {
> +		if (feature_registration_validate(feat_entry, __func__,
> __LINE__, 1, 0, false) < 0)
> +			continue;
> +
> +		if (!strncmp(feat_entry->arc_name, arc_name,
> strlen(feat_entry->arc_name)))
> +			num++;
> +	}
> +
> +	if (num_features)
> +		*num_features =3D num;
> +
> +	return 0;
> +}
> +
> +static int
> +arc_max_index_get(const char *arc_name, uint16_t *max_indexes)
> +{
> +	struct rte_graph_feature_arc_register *arc_reg =3D NULL;
> +	struct rte_graph_feature_register *feat_entry =3D NULL;
> +	uint16_t index;
> +
> +	if (!max_indexes)
> +		return -1;
> +
> +	/* Check if arc is registered with end_feature */
> +	if (!arc_registration_lookup(arc_name, &arc_reg, false))
> +		return -1;
> +
> +	index =3D *max_indexes;
> +
> +	/* Call features override_index_cb(), if set */
> +	STAILQ_FOREACH(feat_entry, &feature_list, next_feature) {
> +		if (!feat_entry->override_index_cb)
> +			continue;
> +
> +		if (feature_registration_validate(feat_entry, __func__,
> __LINE__, 1, 0, false) < 0)
> +			continue;
> +
> +		index =3D RTE_MAX(index, feat_entry->override_index_cb());
> +	}
> +
> +	*max_indexes =3D index;
> +
> +	return 0;
> +}
> +
> +/* calculate arc size to be allocated */
> +static int
> +feature_arc_reg_calc_size(struct rte_graph_feature_arc_register *reg, si=
ze_t
> *sz,
> +			  uint16_t *feat_off, uint16_t *fdata_off, uint32_t *fsz,
> +			  uint16_t *num_index)
> +{
> +	size_t ff_size =3D 0, fdata_size =3D 0;
> +
> +	/* first feature array per index */
> +	ff_size =3D RTE_ALIGN_CEIL(sizeof(rte_graph_feature_data_t) * reg-
> >max_indexes,
> +				 RTE_CACHE_LINE_SIZE);
> +
> +
> +	/* fdata size per feature */
> +	*fsz =3D (uint32_t)RTE_ALIGN_CEIL(sizeof(struct
> rte_graph_feature_data) * reg->max_indexes,
> +					RTE_CACHE_LINE_SIZE);
> +
> +	*num_index =3D (*fsz)/sizeof(struct rte_graph_feature_data);
> +
> +	/* Allocate feature_data extra by 2.
> +	 * 0th index is used for first feature data from start_node
> +	 * Last feature data is used for extra_fdata for end_feature
> +	 */
> +	fdata_size =3D (*fsz) * (reg->max_features +
> NUM_EXTRA_FEATURE_DATA);
> +
> +	if (sz)
> +		*sz =3D fdata_size + ff_size + sizeof(struct
> rte_graph_feature_arc);
> +	if (feat_off)
> +		*feat_off =3D sizeof(struct rte_graph_feature_arc);
> +	if (fdata_off)
> +		*fdata_off =3D ff_size + sizeof(struct rte_graph_feature_arc);
> +
> +	return 0;
> +}
> +
> +static rte_graph_feature_data_t *
> +graph_first_feature_data_ptr_get(struct rte_graph_feature_arc *arc,
> +				 uint32_t index)
> +{
> +	return (rte_graph_feature_data_t *)((uint8_t *)arc + arc-
> >fp_first_feature_offset +
> +					    (sizeof(rte_graph_feature_data_t) *
> index));
> +}
> +
> +static int
> +feature_arc_data_reset(struct rte_graph_feature_arc *arc)
> +{
> +	rte_graph_feature_data_t *f =3D NULL;
> +	uint16_t index;
> +
> +	arc->runtime_enabled_features =3D 0;
> +
> +	for (index =3D 0; index < arc->max_indexes; index++) {
> +		f =3D graph_first_feature_data_ptr_get(arc, index);
> +		*f =3D RTE_GRAPH_FEATURE_DATA_INVALID;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * lookup feature name and get control path node_list as well as feature=
 index
> + * at which it is inserted
> + */
> +static int
> +nodeinfo_lkup_by_name(struct rte_graph_feature_arc *arc, const char
> *feat_name,
> +		      struct rte_graph_feature_node_list **ffinfo, uint32_t *slot)
> +{
> +	struct rte_graph_feature_node_list *finfo =3D NULL;
> +	uint32_t fi =3D 0;
> +
> +	if (!feat_name)
> +		return -1;
> +
> +	if (slot)
> +		*slot =3D UINT32_MAX;
> +
> +	STAILQ_FOREACH(finfo, &arc->all_features, next_feature) {
> +		RTE_VERIFY(finfo->feature_arc =3D=3D arc);
> +		if (!strncmp(finfo->feature_name, feat_name, strlen(finfo-
> >feature_name))) {
> +			if (ffinfo)
> +				*ffinfo =3D finfo;
> +			if (slot)
> +				*slot =3D fi;
> +			return 0;
> +		}
> +		fi++;
> +	}
> +	return -1;
> +}
> +
> +/* Lookup used only during rte_graph_feature_add() */
> +static int
> +nodeinfo_add_lookup(struct rte_graph_feature_arc *arc, const char
> *feat_node_name,
> +		    struct rte_graph_feature_node_list **ffinfo, uint32_t *slot)
> +{
> +	struct rte_graph_feature_node_list *finfo =3D NULL;
> +	uint32_t fi =3D 0;
> +
> +	if (!feat_node_name)
> +		return -1;
> +
> +	if (slot)
> +		*slot =3D 0;
> +
> +	STAILQ_FOREACH(finfo, &arc->all_features, next_feature) {
> +		RTE_VERIFY(finfo->feature_arc =3D=3D arc);
> +		if (!strncmp(finfo->feature_name, feat_node_name,
> strlen(finfo->feature_name))) {
> +			if (ffinfo)
> +				*ffinfo =3D finfo;
> +			if (slot)
> +				*slot =3D fi;
> +			return 0;
> +		}
> +		/* Update slot where new feature can be added */
> +		if (slot)
> +			*slot =3D fi;
> +		fi++;
> +	}
> +
> +	return -1;
> +}
> +
> +/* Get control path node info from provided input feature_index */
> +static int
> +nodeinfo_lkup_by_index(struct rte_graph_feature_arc *arc, uint32_t
> feature_index,
> +		       struct rte_graph_feature_node_list **ppfinfo,
> +		       const int do_sanity_check)
> +{
> +	struct rte_graph_feature_node_list *finfo =3D NULL;
> +	uint32_t index =3D 0;
> +
> +	if (!ppfinfo)
> +		return -1;
> +
> +	*ppfinfo =3D NULL;
> +	STAILQ_FOREACH(finfo, &arc->all_features, next_feature) {
> +		/* Check sanity */
> +		if (do_sanity_check)
> +			if (finfo->finfo_index !=3D index)
> +				RTE_VERIFY(0);
> +		if (index =3D=3D feature_index) {
> +			*ppfinfo =3D finfo;
> +			return 0;
> +		}
> +		index++;
> +	}
> +	return -1;
> +}
> +
> +/* get existing edge from parent_node -> child_node */
> +static int
> +get_existing_edge(const char *arc_name, rte_node_t parent_node,
> +		  rte_node_t child_node, rte_edge_t *_edge)
> +{
> +	char **next_edges =3D NULL;
> +	uint32_t i, count =3D 0;
> +
> +	RTE_SET_USED(arc_name);
> +
> +	count =3D rte_node_edge_get(parent_node, NULL);
> +
> +	if (!count)
> +		return -1;
> +
> +	next_edges =3D malloc(count);
> +
> +	if (!next_edges)
> +		return -1;
> +
> +	count =3D rte_node_edge_get(parent_node, next_edges);
> +	for (i =3D 0; i < count; i++) {
> +		if (strstr(rte_node_id_to_name(child_node), next_edges[i])) {
> +			if (_edge)
> +				*_edge =3D (rte_edge_t)i;
> +
> +			free(next_edges);
> +			return 0;
> +		}
> +	}
> +	free(next_edges);
> +
> +	return -1;
> +}
> +
> +/* feature arc sanity */
> +static int
> +feature_arc_sanity(rte_graph_feature_arc_t _arc)
> +{
> +	struct rte_graph_feature_arc *arc =3D rte_graph_feature_arc_get(_arc);
> +	rte_graph_feature_arc_main_t *dm =3D __rte_graph_feature_arc_main;
> +	uint16_t iter;
> +
> +	if (!__rte_graph_feature_arc_main)
> +		return -1;
> +
> +	if (!arc)
> +		return -1;
> +
> +	for (iter =3D 0; iter < dm->max_feature_arcs; iter++) {
> +		if (arc =3D=3D rte_graph_feature_arc_get(iter)) {
> +			if (arc->feature_arc_index !=3D iter)
> +				return -1;
> +			if (arc->feature_arc_main !=3D dm)
> +				return -1;
> +
> +			return 0;
> +		}
> +	}
> +	return -1;
> +}
> +
> +/* create or retrieve already existing edge from parent_node -> child_no=
de */
> +static int
> +__connect_graph_nodes(rte_node_t parent_node, rte_node_t child_node,
> +		    rte_edge_t *_edge, char *arc_name, int lineno)
> +{
> +	const char *next_node =3D NULL;
> +	rte_edge_t edge;
> +
> +	if (!get_existing_edge(arc_name, parent_node, child_node, &edge)) {
> +		feat_dbg("\t%s/%d: %s[%u]: \"%s\", edge reused", arc_name,
> lineno,
> +			 rte_node_id_to_name(parent_node), edge,
> rte_node_id_to_name(child_node));
> +
> +		if (_edge)
> +			*_edge =3D edge;
> +
> +		return 0;
> +	}
> +
> +	/* Node to be added */
> +	next_node =3D rte_node_id_to_name(child_node);
> +
> +	edge =3D rte_node_edge_update(parent_node, RTE_EDGE_ID_INVALID,
> &next_node, 1);
> +
> +	if (edge =3D=3D RTE_EDGE_ID_INVALID) {
> +		graph_err("edge invalid");
> +		return -1;
> +	}
> +	edge =3D rte_node_edge_count(parent_node) - 1;
> +
> +	feat_dbg("\t%s/%d: %s[%u]: \"%s\", new edge added", arc_name,
> lineno,
> +		 rte_node_id_to_name(parent_node), edge,
> rte_node_id_to_name(child_node));
> +
> +	if (_edge)
> +		*_edge =3D edge;
> +
> +	return 0;
> +}
> +
> +/* feature arc initialization */
> +static int
> +feature_arc_main_init(rte_graph_feature_arc_main_t **pfl, uint32_t
> max_feature_arcs)
> +{
> +	rte_graph_feature_arc_main_t *pm =3D NULL;
> +	const struct rte_memzone *mz =3D NULL;
> +	uint32_t i;
> +	size_t sz;
> +
> +	if (!pfl) {
> +		graph_err("Invalid input");
> +		return -1;
> +	}
> +
> +	sz =3D sizeof(rte_graph_feature_arc_main_t) +
> +		(sizeof(pm->feature_arcs[0]) * max_feature_arcs);
> +
> +	mz =3D rte_memzone_reserve(FEATURE_ARC_MEMZONE_NAME, sz,
> SOCKET_ID_ANY, 0);
> +	if (!mz) {
> +		graph_err("memzone reserve failed for feature arc main");
> +		return -1;
> +	}
> +
> +	pm =3D mz->addr;
> +	memset(pm, 0, sz);
> +
> +	pm->arc_mbuf_dyn_offset =3D -1;
> +	pm->arc_mbuf_dyn_offset =3D
> rte_mbuf_dynfield_register(&rte_graph_feature_arc_mbuf_desc);
> +
> +	if (pm->arc_mbuf_dyn_offset < 0) {
> +		graph_err("rte_graph_feature_arc_dynfield_register failed");
> +		rte_memzone_free(mz);
> +		return -1;
> +	}
> +	for (i =3D 0; i < max_feature_arcs; i++)
> +		pm->feature_arcs[i] =3D
> GRAPH_FEATURE_ARC_PTR_INITIALIZER;
> +
> +	pm->max_feature_arcs =3D max_feature_arcs;
> +
> +	*pfl =3D pm;
> +
> +	return 0;
> +}
> +
> +/* feature arc initialization, public API */
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_init, 25.07);
> +int
> +rte_graph_feature_arc_init(uint16_t num_feature_arcs)
> +{
> +	struct rte_graph_feature_arc_register *arc_reg =3D NULL;
> +	struct rte_graph_feature_register *feat_reg =3D NULL;
> +	const struct rte_memzone *mz =3D NULL;
> +	int max_feature_arcs;
> +	int rc =3D -1;
> +
> +	if (!__rte_graph_feature_arc_main) {
> +		mz =3D
> rte_memzone_lookup(FEATURE_ARC_MEMZONE_NAME);
> +		if (mz) {
> +			__rte_graph_feature_arc_main =3D mz->addr;
> +			return 0;
> +		}
> +		max_feature_arcs =3D num_feature_arcs +
> arc_registration_num();
> +		if (!max_feature_arcs) {
> +			graph_err("No feature arcs registered");
> +			return -1;
> +		}
> +		rc =3D feature_arc_main_init(&__rte_graph_feature_arc_main,
> max_feature_arcs);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	STAILQ_FOREACH(arc_reg, &feature_arc_list, next_arc) {
> +		if (arc_registration_validate(arc_reg, __func__, __LINE__, true)
> < 0)
> +			continue;
> +
> +		/* arc lookup validates feature and arc both*/
> +		if (!arc_registration_lookup(arc_reg->arc_name, NULL, false))
> +			continue;
> +
> +		/* If feature name not set, use node name as feature */
> +		if (!arc_reg->end_feature->feature_name)
> +			arc_reg->end_feature->feature_name =3D
> +				rte_node_id_to_name(arc_reg->end_feature-
> >feature_node_id);
> +
> +		/* Compute number of max_features if not provided */
> +		if (!arc_reg->max_features)
> +			arc_registered_features_num(arc_reg->arc_name,
> &arc_reg->max_features);
> +
> +		rc =3D arc_max_index_get(arc_reg->arc_name, &arc_reg-
> >max_indexes);
> +		if (rc < 0) {
> +			graph_err("arc_max_index_get failed for arc: %s",
> +				  arc_reg->arc_name);
> +			continue;
> +		}
> +
> +		arc_reg->end_feature->feature_node_id =3D arc_reg-
> >end_feature->feature_node->id;
> +
> +		rc =3D rte_graph_feature_arc_create(arc_reg, NULL);
> +
> +		if (rc < 0)
> +			goto arc_cleanup;
> +	}
> +
> +	/* First add those features which has no runs_after and runs_before
> restriction */
> +	STAILQ_FOREACH(feat_reg, &feature_list, next_feature) {
> +		/* Skip if arc not registered yet */
> +		if (!arc_registration_lookup(feat_reg->arc_name, NULL, false))
> +			continue;
> +
> +		if (feat_reg->runs_after || feat_reg->runs_before)
> +			continue;
> +
> +		if (feature_registration_validate(feat_reg, __func__, __LINE__,
> 1, 0, false) < 0)
> +			continue;
> +
> +		feat_reg->feature_node_id =3D feat_reg->feature_node->id;
> +
> +		rc =3D rte_graph_feature_add(feat_reg);
> +
> +		if (rc < 0)
> +			goto arc_cleanup;
> +	}
> +	/* Add those features which has either runs_after or runs_before
> restrictions */
> +	STAILQ_FOREACH(feat_reg, &feature_list, next_feature) {
> +		/* Skip if arc not registered yet */
> +		if (!arc_registration_lookup(feat_reg->arc_name, NULL, false))
> +			continue;
> +
> +		if (!feat_reg->runs_after && !feat_reg->runs_before)
> +			continue;
> +
> +		if (feat_reg->runs_after && feat_reg->runs_before)
> +			continue;
> +
> +		if (feature_registration_validate(feat_reg, __func__, __LINE__,
> 1, 0, false) < 0)
> +			continue;
> +
> +		feat_reg->feature_node_id =3D feat_reg->feature_node->id;
> +
> +		rc =3D rte_graph_feature_add(feat_reg);
> +
> +		if (rc < 0)
> +			goto arc_cleanup;
> +	}
> +	/* Add those features with both runs_after and runs_before
> restrictions */
> +	STAILQ_FOREACH(feat_reg, &feature_list, next_feature) {
> +		/* Skip if arc not registered yet */
> +		if (!arc_registration_lookup(feat_reg->arc_name, NULL, false))
> +			continue;
> +
> +		if (!feat_reg->runs_after && !feat_reg->runs_before)
> +			continue;
> +
> +		if ((feat_reg->runs_after && !feat_reg->runs_before) ||
> +		    (!feat_reg->runs_after && feat_reg->runs_before))
> +			continue;
> +
> +		if (feature_registration_validate(feat_reg, __func__, __LINE__,
> 1, 0, false) < 0)
> +			continue;
> +
> +		feat_reg->feature_node_id =3D feat_reg->feature_node->id;
> +
> +		rc =3D rte_graph_feature_add(feat_reg);
> +
> +		if (rc < 0)
> +			goto arc_cleanup;
> +	}
> +
> +	return 0;
> +
> +arc_cleanup:
> +	rte_graph_feature_arc_cleanup();
> +
> +	return rc;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_create,
> 25.07);
> +int
> +rte_graph_feature_arc_create(struct rte_graph_feature_arc_register *reg,
> +			     rte_graph_feature_arc_t *_arc)
> +{
> +	rte_graph_feature_arc_main_t *dfm =3D NULL;
> +	struct rte_graph_feature_arc *arc =3D NULL;
> +	uint16_t first_feat_off, fdata_off;
> +	const struct rte_memzone *mz =3D NULL;
> +	uint16_t iter, arc_index, num_index;
> +	uint32_t feat_sz =3D 0;
> +	size_t sz;
> +
> +	if (arc_registration_validate(reg, __func__, __LINE__, true) < 0)
> +		return -1;
> +
> +	if (!reg->end_feature ||
> +	    (feature_registration_validate(reg->end_feature, __func__,
> __LINE__, 0, 1, true) < 0))
> +		return -1;
> +
> +	if (!reg->max_features)
> +		graph_err("Zero features found for arc \"%s\" create",
> +			  reg->arc_name);
> +
> +	if (!__rte_graph_feature_arc_main) {
> +		graph_err("Call to rte_graph_feature_arc_init() API missing");
> +		return -1;
> +	}
> +
> +	/* See if arc memory is already created */
> +	mz =3D rte_memzone_lookup(reg->arc_name);
> +	if (mz) {
> +		graph_err("Feature arc %s already created", reg->arc_name);
> +		arc =3D mz->addr;
> +		return -1;
> +	}
> +
> +	dfm =3D __rte_graph_feature_arc_main;
> +
> +	/* threshold check */
> +	if (dfm->num_feature_arcs > (dfm->max_feature_arcs - 1))
> +		SET_ERR_JMP(EAGAIN, arc_create_err,
> +			    "%s: max number (%u) of feature arcs reached",
> +			    reg->arc_name, dfm->max_feature_arcs);
> +
> +	/* Find the free slot for feature arc */
> +	for (iter =3D 0; iter < dfm->max_feature_arcs; iter++) {
> +		if (dfm->feature_arcs[iter] =3D=3D
> GRAPH_FEATURE_ARC_PTR_INITIALIZER)
> +			break;
> +	}
> +	arc_index =3D iter;
> +
> +	if (arc_index >=3D dfm->max_feature_arcs) {
> +		graph_err("No free slot found for num_feature_arc");
> +		return -1;
> +	}
> +
> +	/* This should not happen */
> +	if (dfm->feature_arcs[arc_index] !=3D
> GRAPH_FEATURE_ARC_PTR_INITIALIZER) {
> +		graph_err("Free arc_index: %u is not found free: %p",
> +			  arc_index, (void *)dfm->feature_arcs[arc_index]);
> +		return -1;
> +	}
> +
> +	/* Calculate size of feature arc */
> +	feature_arc_reg_calc_size(reg, &sz, &first_feat_off, &fdata_off,
> &feat_sz, &num_index);
> +
> +	mz =3D rte_memzone_reserve(reg->arc_name, sz, SOCKET_ID_ANY, 0);
> +
> +	if (!mz) {
> +		graph_err("memzone reserve failed for arc: %s of size:
> %"PRIu64,
> +			  reg->arc_name, (uint64_t)sz);
> +		return -1;
> +	}
> +
> +	arc =3D mz->addr;
> +
> +	memset(arc, 0, sz);
> +
> +	arc->feature_bit_mask_by_index =3D rte_malloc(reg->arc_name,
> +						    sizeof(uint64_t) *
> num_index, 0);
> +
> +	if (!arc->feature_bit_mask_by_index) {
> +		graph_err("%s: rte_malloc failed for feature_bit_mask_alloc",
> reg->arc_name);
> +		goto mz_free;
> +	}
> +
> +	memset(arc->feature_bit_mask_by_index, 0, sizeof(uint64_t) *
> num_index);
> +
> +	/* override process function with start_node */
> +	if (node_override_process_func(reg->start_node->id, reg-
> >start_node_feature_process_fn)) {
> +		graph_err("node_override_process_func failed for %s", reg-
> >start_node->name);
> +		goto feat_bitmask_free;
> +	}
> +	feat_dbg("arc-%s: node-%s process() overridden with %p",
> +		  reg->arc_name, reg->start_node->name,
> +		  reg->start_node_feature_process_fn);
> +
> +	/* Initialize rte_graph port group fixed variables */
> +	STAILQ_INIT(&arc->all_features);
> +	rte_strscpy(arc->feature_arc_name, reg->arc_name,
> RTE_GRAPH_FEATURE_ARC_NAMELEN - 1);
> +	arc->feature_arc_main =3D (void *)dfm;
> +	arc->start_node =3D reg->start_node;
> +	memcpy(&arc->end_feature, reg->end_feature, sizeof(arc-
> >end_feature));
> +	arc->arc_start_process =3D reg->start_node_feature_process_fn;
> +	arc->feature_arc_index =3D arc_index;
> +	arc->arc_size =3D sz;
> +
> +	/* reset fast path arc variables */
> +	arc->max_features =3D reg->max_features;
> +	arc->max_indexes =3D num_index;
> +	arc->fp_first_feature_offset =3D first_feat_off;
> +	arc->fp_feature_data_offset =3D fdata_off;
> +	arc->feature_size =3D feat_sz;
> +	arc->mbuf_dyn_offset =3D dfm->arc_mbuf_dyn_offset;
> +
> +	feature_arc_data_reset(arc);
> +
> +	dfm->feature_arcs[arc->feature_arc_index] =3D (uintptr_t)arc;
> +	dfm->num_feature_arcs++;
> +
> +	if (rte_graph_feature_add(reg->end_feature) < 0)
> +		goto arc_destroy;
> +
> +	if (_arc)
> +		*_arc =3D (rte_graph_feature_arc_t)arc_index;
> +
> +	feat_dbg("Feature arc %s[%p] created with max_features: %u and
> indexes: %u",
> +		 arc->feature_arc_name, (void *)arc, arc->max_features, arc-
> >max_indexes);
> +
> +	return 0;
> +
> +arc_destroy:
> +	rte_graph_feature_arc_destroy(arc_index);
> +feat_bitmask_free:
> +	rte_free(arc->feature_bit_mask_by_index);
> +mz_free:
> +	rte_memzone_free(mz);
> +arc_create_err:
> +	return -1;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_add, 25.07);
> +int
> +rte_graph_feature_add(struct rte_graph_feature_register *freg)
> +{
> +	struct rte_graph_feature_node_list *after_finfo =3D NULL, *before_finfo
> =3D NULL;
> +	struct rte_graph_feature_node_list *temp =3D NULL, *finfo =3D NULL;
> +	char feature_name[3 * RTE_GRAPH_FEATURE_ARC_NAMELEN];
> +	const char *runs_after =3D NULL, *runs_before =3D NULL;
> +	struct rte_graph_feature_arc *arc =3D NULL;
> +	uint32_t slot =3D UINT32_MAX, add_flag;
> +	rte_graph_feature_arc_t _arc;
> +	uint32_t num_features =3D 0;
> +	const char *nodename =3D NULL;
> +	rte_edge_t edge =3D -1;
> +	int rc =3D 0;
> +
> +	if (feature_registration_validate(freg, __func__, __LINE__, 0, 1, true)=
 <
> 0)
> +		return -1;
> +
> +	/* arc is valid */
> +	if (rte_graph_feature_arc_lookup_by_name(freg->arc_name, &_arc)) {
> +		graph_err("%s_add: feature arc %s not found",
> +			  freg->feature_name, freg->arc_name);
> +		return -1;
> +	}
> +
> +	if (feature_arc_sanity(_arc)) {
> +		graph_err("invalid feature arc: 0x%x", _arc);
> +		return -1;
> +	}
> +
> +	arc =3D rte_graph_feature_arc_get(_arc);
> +
> +	if (arc->runtime_enabled_features) {
> +		graph_err("adding features after enabling any one of them is
> not supported");
> +		return -1;
> +	}
> +
> +	/* When application calls rte_graph_feature_add() directly*/
> +	if (freg->feature_node_id =3D=3D RTE_NODE_ID_INVALID) {
> +		graph_err("%s/%s: Invalid feature_node_id set for %s",
> +			  freg->arc_name, freg->feature_name, __func__);
> +		return -1;
> +	}
> +
> +	if ((freg->runs_after !=3D NULL) && (freg->runs_before !=3D NULL) &&
> +	    (freg->runs_after =3D=3D freg->runs_before)) {
> +		graph_err("runs_after and runs_before cannot be same
> '%s:%s]", freg->runs_after,
> +			  freg->runs_before);
> +		return -1;
> +	}
> +
> +	num_features =3D rte_graph_feature_arc_num_features(_arc);
> +	if (num_features) {
> +		nodeinfo_lkup_by_index(arc, num_features - 1, &temp, 0);
> +		/* Check if feature is not added after end_feature */
> +		if ((freg->runs_after !=3D NULL) &&
> +		    (strncmp(freg->runs_after, temp->feature_name,
> +			     RTE_GRAPH_FEATURE_ARC_NAMELEN) =3D=3D 0)) {
> +			graph_err("Feature %s cannot be added after
> end_feature %s",
> +				  freg->feature_name, freg->runs_after);
> +			return -1;
> +		}
> +	}
> +
> +	if (!nodeinfo_add_lookup(arc, freg->feature_name, &finfo, &slot)) {
> +		graph_err("%s/%s feature already added", arc-
> >feature_arc_name, freg->feature_name);
> +		return -1;
> +	}
> +
> +	if (slot >=3D arc->max_features) {
> +		graph_err("%s: Max features %u added to feature arc",
> +			  arc->feature_arc_name, slot);
> +		return -1;
> +	}
> +
> +	if (freg->feature_node_id =3D=3D arc->start_node->id) {
> +		graph_err("%s/%s: Feature node and start node are same
> %u",
> +			  freg->arc_name, freg->feature_name, freg-
> >feature_node_id);
> +		return -1;
> +	}
> +
> +	nodename =3D rte_node_id_to_name(freg->feature_node_id);
> +
> +	feat_dbg("%s: adding feature node: %s at feature index: %u", arc-
> >feature_arc_name,
> +		 nodename, slot);
> +
> +	if (connect_graph_nodes(arc->start_node->id, freg->feature_node_id,
> &edge,
> +				arc->feature_arc_name)) {
> +		graph_err("unable to connect %s -> %s", arc->start_node-
> >name, nodename);
> +		return -1;
> +	}
> +
> +	snprintf(feature_name, sizeof(feature_name), "%s-%s-finfo",
> +		 arc->feature_arc_name, freg->feature_name);
> +
> +	finfo =3D rte_malloc(feature_name, sizeof(*finfo), 0);
> +	if (!finfo) {
> +		graph_err("%s/%s: rte_malloc failed", arc->feature_arc_name,
> freg->feature_name);
> +		return -1;
> +	}
> +
> +	memset(finfo, 0, sizeof(*finfo));
> +
> +	rte_strscpy(finfo->feature_name, freg->feature_name,
> RTE_GRAPH_FEATURE_ARC_NAMELEN - 1);
> +	finfo->feature_arc =3D (void *)arc;
> +	finfo->feature_node_id =3D freg->feature_node_id;
> +	finfo->feature_node_process_fn =3D freg->feature_process_fn;
> +	finfo->edge_to_this_feature =3D RTE_EDGE_ID_INVALID;
> +	finfo->edge_to_last_feature =3D RTE_EDGE_ID_INVALID;
> +	finfo->notifier_cb =3D freg->notifier_cb;
> +
> +	runs_before =3D freg->runs_before;
> +	runs_after =3D freg->runs_after;
> +
> +	/*
> +	 * if no constraints given and provided feature is not the first featur=
e,
> +	 * explicitly set "runs_before" as end_feature.
> +	 *
> +	 * Handles the case:
> +	 * arc_create(f1);
> +	 * add(f2, NULL, NULL);
> +	 */
> +	if (!runs_after && !runs_before && num_features)
> +		runs_before =3D rte_graph_feature_arc_feature_to_name(_arc,
> num_features - 1);
> +
> +	/* Check for before and after constraints */
> +	if (runs_before) {
> +		/* runs_before sanity */
> +		if (nodeinfo_lkup_by_name(arc, runs_before, &before_finfo,
> NULL))
> +			SET_ERR_JMP(EINVAL, finfo_free,
> +				     "runs_before feature name: %s does not
> exist", runs_before);
> +
> +		if (!before_finfo)
> +			SET_ERR_JMP(EINVAL, finfo_free,
> +				     "runs_before %s does not exist",
> runs_before);
> +
> +		/*
> +		 * Starting from 0 to runs_before, continue connecting edges
> +		 */
> +		add_flag =3D 1;
> +		STAILQ_FOREACH(temp, &arc->all_features, next_feature) {
> +			if (!add_flag)
> +				/* Nodes after seeing "runs_before", finfo
> connects to temp*/
> +				connect_graph_nodes(finfo-
> >feature_node_id, temp->feature_node_id,
> +						    NULL, arc-
> >feature_arc_name);
> +			/*
> +			 * As soon as we see runs_before. stop adding edges
> +			 */
> +			if (!strncmp(temp->feature_name, runs_before,
> RTE_GRAPH_NAMESIZE)) {
> +				if (!connect_graph_nodes(finfo-
> >feature_node_id,
> +							 temp-
> >feature_node_id,
> +							 &edge, arc-
> >feature_arc_name))
> +					add_flag =3D 0;
> +			}
> +
> +			if (add_flag)
> +				/* Nodes before seeing "run_before" are
> connected to finfo */
> +				connect_graph_nodes(temp-
> >feature_node_id, finfo->feature_node_id,
> +						    NULL, arc-
> >feature_arc_name);
> +		}
> +	}
> +
> +	if (runs_after) {
> +		if (nodeinfo_lkup_by_name(arc, runs_after, &after_finfo,
> NULL))
> +			SET_ERR_JMP(EINVAL, finfo_free,
> +				     "Invalid after feature_name %s",
> runs_after);
> +
> +		if (!after_finfo)
> +			SET_ERR_JMP(EINVAL, finfo_free,
> +				     "runs_after %s does not exist", runs_after);
> +
> +		/* Starting from runs_after to end continue connecting edges
> */
> +		add_flag =3D 0;
> +		STAILQ_FOREACH(temp, &arc->all_features, next_feature) {
> +			if (add_flag)
> +				/* We have already seen runs_after now */
> +				/* Add all features as next node to current
> feature*/
> +				connect_graph_nodes(finfo-
> >feature_node_id, temp->feature_node_id,
> +						    NULL, arc-
> >feature_arc_name);
> +			else
> +				/* Connect initial nodes to newly added
> node*/
> +				connect_graph_nodes(temp-
> >feature_node_id, finfo->feature_node_id,
> +						    NULL, arc-
> >feature_arc_name);
> +
> +			/* as soon as we see runs_after. start adding edges
> +			 * from next iteration
> +			 */
> +			if (!strncmp(temp->feature_name, runs_after,
> RTE_GRAPH_NAMESIZE))
> +				add_flag =3D 1;
> +		}
> +
> +		/* add feature next to runs_after */
> +		STAILQ_INSERT_AFTER(&arc->all_features, after_finfo, finfo,
> next_feature);
> +	} else {
> +		if (before_finfo) {
> +			/* add finfo before "before_finfo" element in the list */
> +			after_finfo =3D NULL;
> +			STAILQ_FOREACH(temp, &arc->all_features,
> next_feature) {
> +				if (before_finfo =3D=3D temp) {
> +					if (after_finfo)
> +						STAILQ_INSERT_AFTER(&arc-
> >all_features, after_finfo,
> +								    finfo,
> next_feature);
> +					else
> +						STAILQ_INSERT_HEAD(&arc-
> >all_features, finfo,
> +
> next_feature);
> +
> +					/* override node process fn */
> +					rc =3D
> node_override_process_func(finfo->feature_node_id,
> +									freg-
> >feature_process_fn);
> +
> +					if (rc < 0) {
> +
> 	graph_err("node_override_process_func failed for %s",
> +							  freg-
> >feature_name);
> +						goto finfo_free;
> +					}
> +					return 0;
> +				}
> +				after_finfo =3D temp;
> +			}
> +		} else {
> +			/* Very first feature just needs to be added to list */
> +			STAILQ_INSERT_TAIL(&arc->all_features, finfo,
> next_feature);
> +		}
> +	}
> +	/* override node_process_fn */
> +	rc =3D node_override_process_func(finfo->feature_node_id, freg-
> >feature_process_fn);
> +	if (rc < 0) {
> +		graph_err("node_override_process_func failed for %s", freg-
> >feature_name);
> +		goto finfo_free;
> +	}
> +
> +	if (freg->feature_node)
> +		feat_dbg("arc-%s: feature %s node %s process() overridden
> with %p",
> +			  freg->arc_name, freg->feature_name, freg-
> >feature_node->name,
> +			  freg->feature_process_fn);
> +	else
> +		feat_dbg("arc-%s: feature %s nodeid %u process() overriding
> with %p",
> +			  freg->arc_name, freg->feature_name,
> +			  freg->feature_node_id, freg->feature_process_fn);
> +
> +	return 0;
> +finfo_free:
> +	rte_free(finfo);
> +
> +	return -1;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_lookup, 25.07);
> +int
> +rte_graph_feature_lookup(rte_graph_feature_arc_t _arc, const char
> *feature_name,
> +			 rte_graph_feature_t *feat)
> +{
> +	struct rte_graph_feature_arc *arc =3D rte_graph_feature_arc_get(_arc);
> +	struct rte_graph_feature_node_list *finfo =3D NULL;
> +	uint32_t slot;
> +
> +	if (!arc)
> +		return -1;
> +
> +	if (!nodeinfo_lkup_by_name(arc, feature_name, &finfo, &slot)) {
> +		*feat =3D (rte_graph_feature_t) slot;
> +		return 0;
> +	}
> +
> +	return -1;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_destroy,
> 25.07);
> +int
> +rte_graph_feature_arc_destroy(rte_graph_feature_arc_t _arc)
> +{
> +	struct rte_graph_feature_arc *arc =3D rte_graph_feature_arc_get(_arc);
> +	rte_graph_feature_arc_main_t *dm =3D __rte_graph_feature_arc_main;
> +	struct rte_graph_feature_node_list *node_info =3D NULL;
> +	int iter;
> +
> +	if (!arc) {
> +		graph_err("Invalid feature arc: 0x%x", _arc);
> +		return -1;
> +	}
> +
> +	while (!STAILQ_EMPTY(&arc->all_features)) {
> +		node_info =3D STAILQ_FIRST(&arc->all_features);
> +		STAILQ_REMOVE_HEAD(&arc->all_features, next_feature);
> +		/* Notify application */
> +		if (node_info->notifier_cb) {
> +			for (iter =3D 0; iter < arc->max_indexes; iter++) {
> +				/* If feature is not enabled on this index, skip
> */
> +				if (!(arc->feature_bit_mask_by_index[iter] &
> +				    RTE_BIT64(node_info->finfo_index)))
> +					continue;
> +
> +				node_info->notifier_cb(arc-
> >feature_arc_name,
> +						       node_info->feature_name,
> +						       node_info-
> >feature_node_id,
> +						       iter, false /* disable */,
> +						       UINT16_MAX /* invalid
> cookie */);
> +			}
> +		}
> +		rte_free(node_info);
> +	}
> +
> +	dm->feature_arcs[arc->feature_arc_index] =3D
> GRAPH_FEATURE_ARC_PTR_INITIALIZER;
> +
> +	rte_free(arc->feature_data_by_index);
> +
> +	rte_free(arc->feature_bit_mask_by_index);
> +
> +	rte_memzone_free(rte_memzone_lookup(arc->feature_arc_name));
> +
> +	return 0;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_cleanup,
> 25.07);
> +int
> +rte_graph_feature_arc_cleanup(void)
> +{
> +	rte_graph_feature_arc_main_t *dm =3D __rte_graph_feature_arc_main;
> +	struct rte_graph_feature_arc *arc =3D NULL;
> +	uint32_t iter;
> +
> +	if (!__rte_graph_feature_arc_main)
> +		return -1;
> +
> +	for (iter =3D 0; iter < dm->max_feature_arcs; iter++) {
> +		arc =3D rte_graph_feature_arc_get(iter);
> +
> +		if (!arc)
> +			continue;
> +
> +		rte_graph_feature_arc_destroy(arc->feature_arc_index);
> +	}
> +
> 	rte_memzone_free(rte_memzone_lookup(FEATURE_ARC_MEMZONE
> _NAME));
> +	__rte_graph_feature_arc_main =3D NULL;
> +
> +	return 0;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_lookup_by_n
> ame, 25.07);
> +int
> +rte_graph_feature_arc_lookup_by_name(const char *arc_name,
> rte_graph_feature_arc_t *_arc)
> +{
> +	struct rte_graph_feature_arc *arc =3D NULL;
> +	const struct rte_memzone *mz =3D NULL;
> +	rte_graph_feature_arc_main_t *dm;
> +	uint32_t iter;
> +
> +	if (_arc)
> +		*_arc =3D RTE_GRAPH_FEATURE_ARC_INITIALIZER;
> +
> +	if (!__rte_graph_feature_arc_main) {
> +		mz =3D
> rte_memzone_lookup(FEATURE_ARC_MEMZONE_NAME);
> +		if (mz)
> +			__rte_graph_feature_arc_main =3D mz->addr;
> +		else
> +			return -1;
> +	}
> +
> +	dm =3D __rte_graph_feature_arc_main;
> +
> +	for (iter =3D 0; iter < dm->max_feature_arcs; iter++) {
> +		arc =3D rte_graph_feature_arc_get(iter);
> +		if (!arc)
> +			continue;
> +
> +		if ((strstr(arc->feature_arc_name, arc_name)) &&
> +		    (strlen(arc->feature_arc_name) =3D=3D strlen(arc_name))) {
> +			if (_arc)
> +				*_arc =3D arc->feature_arc_index;
> +			return 0;
> +		}
> +	}
> +
> +	return -1;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_num_feature
> s, 25.07);
> +uint32_t
> +rte_graph_feature_arc_num_features(rte_graph_feature_arc_t _arc)
> +{
> +	struct rte_graph_feature_arc *arc =3D rte_graph_feature_arc_get(_arc);
> +	struct rte_graph_feature_node_list *finfo =3D NULL;
> +	uint32_t count =3D 0;
> +
> +	if (!arc) {
> +		graph_err("Invalid feature arc: 0x%x", _arc);
> +		return 0;
> +	}
> +
> +	STAILQ_FOREACH(finfo, &arc->all_features, next_feature)
> +		count++;
> +
> +	return count;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_feature_to_n
> ame, 25.07);
> +char *
> +rte_graph_feature_arc_feature_to_name(rte_graph_feature_arc_t _arc,
> rte_graph_feature_t feat)
> +{
> +	struct rte_graph_feature_arc *arc =3D rte_graph_feature_arc_get(_arc);
> +	struct rte_graph_feature_node_list *finfo =3D NULL;
> +	uint32_t slot =3D feat;
> +
> +	if (!arc)
> +		return NULL;
> +
> +	if (feat >=3D rte_graph_feature_arc_num_features(_arc)) {
> +		graph_err("%s: feature %u does not exist", arc-
> >feature_arc_name, feat);
> +		return NULL;
> +	}
> +	if (!nodeinfo_lkup_by_index(arc, slot, &finfo, 0/* ignore sanity*/))
> +		return finfo->feature_name;
> +
> +	return NULL;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_feature_to_n
> ode, 25.07);
> +int
> +rte_graph_feature_arc_feature_to_node(rte_graph_feature_arc_t _arc,
> rte_graph_feature_t feat,
> +				      rte_node_t *node)
> +{
> +	struct rte_graph_feature_arc *arc =3D rte_graph_feature_arc_get(_arc);
> +	struct rte_graph_feature_node_list *finfo =3D NULL;
> +	uint32_t slot =3D feat;
> +
> +	if (!arc)
> +		return -1;
> +
> +	if (node)
> +		*node =3D RTE_NODE_ID_INVALID;
> +
> +	if (feat >=3D rte_graph_feature_arc_num_features(_arc)) {
> +		graph_err("%s: feature %u does not exist", arc-
> >feature_arc_name, feat);
> +		return -1;
> +	}
> +	if (!nodeinfo_lkup_by_index(arc, slot, &finfo, 0/* ignore sanity*/)) {
> +		if (node)
> +			*node =3D finfo->feature_node_id;
> +		return 0;
> +	}
> +	return -1;
> +}
> +
>  RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_arc_register,
> 25.07);
>  void __rte_graph_feature_arc_register(struct rte_graph_feature_arc_regis=
ter
> *reg,
>  				      const char *caller_name, int lineno)
> @@ -28,9 +1320,40 @@
> RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_register, 25.07);
>  void __rte_graph_feature_register(struct rte_graph_feature_register *reg=
,
>  				  const char *caller_name, int lineno)
>  {
> -	RTE_SET_USED(caller_name);
> -	RTE_SET_USED(lineno);
> +	if (feature_registration_validate(reg, caller_name, lineno, 0, 0, true)=
 <
> 0)
> +		return;
>=20
>  	/* Add to the feature_list*/
>  	STAILQ_INSERT_TAIL(&feature_list, reg, next_feature);
>  }
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_names_get,
> 25.07);
> +uint32_t
> +rte_graph_feature_arc_names_get(char *arc_names[])
> +{
> +	rte_graph_feature_arc_main_t *dm =3D __rte_graph_feature_arc_main;
> +	struct rte_graph_feature_arc *arc =3D NULL;
> +	uint32_t count, num_arcs;
> +
> +	if (!__rte_graph_feature_arc_main)
> +		return 0;
> +
> +	for (count =3D 0, num_arcs =3D 0; count < dm->max_feature_arcs;
> count++)
> +		if (dm->feature_arcs[count] !=3D
> GRAPH_FEATURE_ARC_PTR_INITIALIZER)
> +			num_arcs++;
> +
> +	if (!num_arcs)
> +		return 0;
> +
> +	if (!arc_names)
> +		return sizeof(char *) * num_arcs;
> +
> +	for (count =3D 0, num_arcs =3D 0; count < dm->max_feature_arcs;
> count++) {
> +		if (dm->feature_arcs[count] !=3D
> GRAPH_FEATURE_ARC_PTR_INITIALIZER) {
> +			arc =3D rte_graph_feature_arc_get(count);
> +			arc_names[num_arcs] =3D arc->feature_arc_name;
> +			num_arcs++;
> +		}
> +	}
> +	return num_arcs;
> +}
> diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h
> index 579546e658..5728933a88 100644
> --- a/lib/graph/graph_private.h
> +++ b/lib/graph/graph_private.h
> @@ -24,6 +24,10 @@ extern int rte_graph_logtype;
>  	RTE_LOG_LINE_PREFIX(level, GRAPH,                                      =
\
>  		"%s():%u ", __func__ RTE_LOG_COMMA __LINE__,
> __VA_ARGS__)
>=20
> +#define GRAPH_LOG2(level, _fname, _linenum, ...)                        =
       \
> +	RTE_LOG_LINE_PREFIX(level, GRAPH,                                      =
\
> +		"%s():%u ", _fname RTE_LOG_COMMA _linenum,
> __VA_ARGS__)
> +
>  #define graph_err(...) GRAPH_LOG(ERR, __VA_ARGS__)
>  #define graph_warn(...) GRAPH_LOG(WARNING, __VA_ARGS__)
>  #define graph_info(...) GRAPH_LOG(INFO, __VA_ARGS__)
> diff --git a/lib/graph/meson.build b/lib/graph/meson.build
> index 1b2f493037..6a6d570290 100644
> --- a/lib/graph/meson.build
> +++ b/lib/graph/meson.build
> @@ -20,7 +20,7 @@ sources =3D files(
>          'graph_feature_arc.c',
>  )
>  headers =3D files('rte_graph.h', 'rte_graph_worker.h')
> -headers +=3D files('rte_graph_feature_arc.h')
> +headers +=3D files('rte_graph_feature_arc.h', 'rte_graph_feature_arc_wor=
ker.h')
>  indirect_headers +=3D files(
>          'rte_graph_model_mcore_dispatch.h',
>          'rte_graph_model_rtc.h',
> diff --git a/lib/graph/rte_graph_feature_arc.h
> b/lib/graph/rte_graph_feature_arc.h
> index 56d8f2f34c..f25f77df3c 100644
> --- a/lib/graph/rte_graph_feature_arc.h
> +++ b/lib/graph/rte_graph_feature_arc.h
> @@ -87,16 +87,70 @@ extern "C" {
>   *
>   * A feature arc in a graph is represented via *start_node* and *end_nod=
e*.
>   * Feature nodes are added between start_node and end_node. Packets ente=
r
> - * feature arc traversal via start_node while they exits from end_node. =
Packets
> - * steering from start_node to feature nodes are controlled in control p=
lane
> - * via rte_graph_feature_enable()/rte_graph_feature_disable().
> + * feature arc traversal via start_node while they exits from end_node.
>   *
>   * This library facilitates rte graph based applications to implement st=
ack
>   * functionalities described above by providing "edge" to the next enabl=
ed
>   * feature node in fast path
>   *
> + * In order to use feature-arc APIs, applications needs to do following =
in
> + * control plane:
> + * - Create feature arc object using RTE_GRAPH_FEATURE_ARC_REGISTER()
> + * - New feature nodes (In-built/Out-of-tree) can be added to an arc via
> + *   RTE_GRAPH_FEATURE_REGISTER(). RTE_GRAPH_FEATURE_REGISTER()
> has
> + *   "runs_after" and "runs_before" fields to specify protocol ordering
> + *   constraints.
> + * - Before calling rte_graph_create(), rte_graph_feature_arc_init() API=
 must
> + *   be called. If rte_graph_feature_arc_init() is not called by applica=
tion,
> + *   feature arc library has no affect.
> + * - Feature arc can be destroyed via rte_graph_feature_arc_destroy()
> + *
> + * If a given feature likes to control number of indexes (which is highe=
r than
> + * RTE_GRAPH_FEATURE_ARC_REGISTER::max_indexes) it can do so by using
> + * RTE_GRAPH_FEATURE_REGISTER():override_index_cb(). As part of
> + * rte_graph_feature_arc_init(), all feature's override_index_cb(), if s=
et, are
> + * called and with maximum value returned by any of the feature is used =
for
> + * rte_graph_feature_arc_create()
> + *
> + * Constraints
> + * -----------
> + *  - rte_graph_feature_arc_init(), rte_graph_feature_create() and
> + *  rte_graph_feature_add() must be called before rte_graph_create().
> + *  - Not more than 63 features can be added to a feature arc. There is =
no
> + *  limit to number of feature arcs i.e. number of
> + *  RTE_GRAPH_FEATURE_ARC_REGISTER()
> + *  - There is also no limit for number of indexes
> (RTE_GRAPH_FEATURE_ARC_REGISTER():
> + *  max_indexes). There is also a provision for each
> + *  RTE_GRAPH_FEATURE_REGISTER() to override number of indexes via
> + *  override_index_cb()
> + *  - A feature node cannot be part of more than one arc due to
> + *  performance reason.
> + *
> + * Optional Usage
> + * --------------
> + * Feature arc is added as an optional functionality to the graph librar=
y hence
> + * an application may choose not to use it by skipping explicit call to
> + * rte_graph_feature_arc_init(). In that case feature arc would be a no-=
op for
> + * application.
>   */
>=20
> +/** Length of feature arc name */
> +#define RTE_GRAPH_FEATURE_ARC_NAMELEN RTE_NODE_NAMESIZE
> +
> +/** Initializer values for ARC, Feature, Feature data */
> +#define RTE_GRAPH_FEATURE_ARC_INITIALIZER
> ((rte_graph_feature_arc_t)UINT16_MAX)
> +#define RTE_GRAPH_FEATURE_DATA_INVALID
> ((rte_graph_feature_data_t)UINT32_MAX)
> +#define RTE_GRAPH_FEATURE_INVALID  ((rte_graph_feature_t)UINT8_MAX)
> +
> +/** rte_graph feature arc object */
> +typedef uint16_t rte_graph_feature_arc_t;
> +
> +/** rte_graph feature object */
> +typedef uint8_t rte_graph_feature_t;
> +
> +/** rte_graph feature data object */
> +typedef uint32_t rte_graph_feature_data_t;
> +
>  /** feature notifier callback called when feature is enabled/disabled */
>  typedef void (*rte_graph_feature_change_notifier_cb_t)(const char
> *arc_name,
>  						       const char *feature_name,
> @@ -230,6 +284,194 @@ struct rte_graph_feature_arc_register {
>  	{                                                                      =
         \
>  		__rte_graph_feature_arc_register(&reg, __func__, __LINE__);
> \
>  	}
> +/**
> + * Initialize feature arc subsystem
> + *
> + * This API
> + * - Initializes feature arc module and alloc associated memory
> + * - creates feature arc for every RTE_GRAPH_FEATURE_ARC_REGISTER()
> + * - Add feature node to a feature arc for every
> RTE_GRAPH_FEATURE_REGISTER()
> + * - Replaces all RTE_NODE_REGISTER()->process() functions for
> + *   - Every start_node/end_node provided in arc registration
> + *   - Every feature node provided in feature registration
> + *
> + * @param num_feature_arcs
> + *  Number of feature arcs that application wants to create by explicitl=
y using
> + *  "rte_graph_feature_arc_create()" API.
> + *
> + *  Number of RTE_GRAPH_FEATURE_ARC_REGISTER() should be excluded
> from this
> + *  count as API internally calculates number of
> + *  RTE_GRAPH_FEATURE_ARC_REGISTER().
> + *
> + *  So,
> + *  total number of supported arcs =3D num_feature_arcs +
> + *                                   NUMBER_OF(RTE_GRAPH_FEATURE_ARC_REG=
ISTER())
> + *
> + *  @return
> + *   0: Success
> + *   <0: Failure
> + *
> + *  rte_graph_feature_arc_init(0) is valid call which will accommodates
> + *  constructor based arc registration
> + */
> +__rte_experimental
> +int rte_graph_feature_arc_init(uint16_t num_feature_arcs);
> +
> +/**
> + * Create a feature arc.
> + *
> + * This API can be skipped if RTE_GRAPH_FEATURE_ARC_REGISTER() is used
> + *
> + * @param reg
> + *   Pointer to struct rte_graph_feature_arc_register
> + * @param[out] _arc
> + *  Feature arc object
> + *
> + * @return
> + *  0: Success
> + * <0: Failure
> + */
> +__rte_experimental
> +int rte_graph_feature_arc_create(struct rte_graph_feature_arc_register *=
reg,
> +				 rte_graph_feature_arc_t *_arc);
> +
> +/**
> + * Get feature arc object with name
> + *
> + * @param arc_name
> + *   Feature arc name provided to successful @ref
> rte_graph_feature_arc_create
> + * @param[out] _arc
> + *   Feature arc object returned. Valid only when API returns SUCCESS
> + *
> + * @return
> + *  0: Success
> + * <0: Failure.
> + */
> +__rte_experimental
> +int rte_graph_feature_arc_lookup_by_name(const char *arc_name,
> rte_graph_feature_arc_t *_arc);
> +
> +/**
> + * Add a feature to already created feature arc.
> + *
> + * This API is not required in case RTE_GRAPH_FEATURE_REGISTER() is used
> + *
> + * @param feat_reg
> + * Pointer to struct rte_graph_feature_register
> + *
> + * <I> Must be called before rte_graph_create() </I>
> + * <I> When called by application, then feature_node_id should be
> appropriately set as
> + *     freg->feature_node_id =3D freg->feature_node->id;
> + * </I>
> + *
> + * @return
> + *  0: Success
> + * <0: Failure
> + */
> +__rte_experimental
> +int rte_graph_feature_add(struct rte_graph_feature_register *feat_reg);
> +
> +/**
> + * Get rte_graph_feature_t object from feature name
> + *
> + * @param arc
> + *   Feature arc object returned by @ref rte_graph_feature_arc_create or
> @ref
> + *   rte_graph_feature_arc_lookup_by_name
> + * @param feature_name
> + *   Feature name provided to @ref rte_graph_feature_add
> + * @param[out] feature
> + *   Feature object
> + *
> + * @return
> + *  0: Success
> + * <0: Failure
> + */
> +__rte_experimental
> +int rte_graph_feature_lookup(rte_graph_feature_arc_t arc, const char
> *feature_name,
> +			     rte_graph_feature_t *feature);
> +
> +/**
> + * Delete feature_arc object
> + *
> + * @param _arc
> + *   Feature arc object returned by @ref rte_graph_feature_arc_create or
> @ref
> + *   rte_graph_feature_arc_lookup_by_name
> + *
> + * @return
> + *  0: Success
> + * <0: Failure
> + */
> +__rte_experimental
> +int rte_graph_feature_arc_destroy(rte_graph_feature_arc_t _arc);
> +
> +/**
> + * Cleanup all feature arcs
> + *
> + * @return
> + *  0: Success
> + * <0: Failure
> + */
> +__rte_experimental
> +int rte_graph_feature_arc_cleanup(void);
> +
> +/**
> + * Slow path API to know how many features are added (NOT enabled)
> within a
> + * feature arc
> + *
> + * @param _arc
> + *  Feature arc object
> + *
> + * @return: Number of added features to arc
> + */
> +__rte_experimental
> +uint32_t rte_graph_feature_arc_num_features(rte_graph_feature_arc_t
> _arc);
> +
> +/**
> + * Slow path API to get feature node name from rte_graph_feature_t objec=
t
> + *
> + * @param _arc
> + *   Feature arc object
> + * @param feature
> + *   Feature object
> + *
> + * @return: Name of the feature node
> + */
> +__rte_experimental
> +char *rte_graph_feature_arc_feature_to_name(rte_graph_feature_arc_t
> _arc,
> +					    rte_graph_feature_t feature);
> +
> +/**
> + * Slow path API to get corresponding rte_node_t from
> + * rte_graph_feature_t
> + *
> + * @param _arc
> + *   Feature arc object
> + * @param feature
> + *   Feature object
> + * @param[out] node
> + *   rte_node_t of feature node, Valid only when API returns SUCCESS
> + *
> + * @return: 0 on success, < 0 on failure
> + */
> +__rte_experimental
> +int
> +rte_graph_feature_arc_feature_to_node(rte_graph_feature_arc_t _arc,
> +				      rte_graph_feature_t feature,
> +				      rte_node_t *node);
> +
> +/**
> + * Slow path API to dump valid feature arc names
> + *
> + *  @param[out] arc_names
> + *   Buffer to copy the arc names. The NULL value is allowed in that cas=
e,
> + * the function returns the size of the array that needs to be allocated=
.
> + *
> + * @return
> + *   When next_nodes =3D=3D NULL, it returns the size of the array else
> + *  number of item copied.
> + */
> +__rte_experimental
> +uint32_t
> +rte_graph_feature_arc_names_get(char *arc_names[]);
>=20
>  /**
>   * @internal
> diff --git a/lib/graph/rte_graph_feature_arc_worker.h
> b/lib/graph/rte_graph_feature_arc_worker.h
> new file mode 100644
> index 0000000000..b2fc539402
> --- /dev/null
> +++ b/lib/graph/rte_graph_feature_arc_worker.h
> @@ -0,0 +1,303 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Marvell International Ltd.
> + */
> +
> +#ifndef _RTE_GRAPH_FEATURE_ARC_WORKER_H_
> +#define _RTE_GRAPH_FEATURE_ARC_WORKER_H_
> +
> +#include <stddef.h>
> +#include <rte_graph_feature_arc.h>
> +#include <rte_bitops.h>
> +#include <rte_mbuf.h>
> +#include <rte_mbuf_dyn.h>
> +
> +/**
> + * @file
> + *
> + * rte_graph_feature_arc_worker.h
> + *
> + * Defines fast path structure for feature arc
> + */
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/**
> + * @internal
> + *
> + * Slow path feature node info list
> + */
> +struct rte_graph_feature_node_list {
> +	/** Next feature */
> +	STAILQ_ENTRY(rte_graph_feature_node_list) next_feature;
> +
> +	char feature_name[RTE_GRAPH_FEATURE_ARC_NAMELEN];
> +
> +	/** node id representing feature */
> +	rte_node_t feature_node_id;
> +
> +	/** How many indexes/interfaces using this feature */
> +	int32_t ref_count;
> +
> +	/**
> +	 * feature arc process function overrides to feature node's original
> +	 * process function
> +	 */
> +	rte_node_process_t feature_node_process_fn;
> +
> +	/** Callback for freeing application resources when */
> +	rte_graph_feature_change_notifier_cb_t notifier_cb;
> +
> +	/** finfo_index in list. same as rte_graph_feature_t */
> +	uint32_t finfo_index;
> +
> +	/** Back pointer to feature arc */
> +	void *feature_arc;
> +
> +	/** rte_edge_t to this feature node from feature_arc->start_node */
> +	rte_edge_t edge_to_this_feature;
> +
> +	/** rte_edge_t from this feature node to last feature node */
> +	rte_edge_t edge_to_last_feature;
> +};
> +
> +/**
> + * rte_graph Feature arc object
> + *
> + * Feature arc object holds control plane and fast path information for =
all
> + * features and all interface index information for steering packets acr=
oss
> + * feature nodes
> + *
> + * Within a feature arc, only RTE_GRAPH_FEATURE_MAX_PER_ARC features
> can be
> + * added. If more features needs to be added, another feature arc can be
> + * created
> + *
> + * In fast path, rte_graph_feature_arc_t can be translated to (struct
> + * rte_graph_feature_arc *) via rte_graph_feature_arc_get(). Later is ne=
eded
> to
> + * add as an input argument to all fast path feature arc APIs
> + */
> +struct __rte_cache_aligned rte_graph_feature_arc {
> +	/** Slow path variables follows*/
> +	RTE_MARKER slow_path_variables;
> +
> +	/** All feature lists */
> +	STAILQ_HEAD(, rte_graph_feature_node_list) all_features;
> +
> +	/** feature arc name */
> +	char feature_arc_name[RTE_GRAPH_FEATURE_ARC_NAMELEN];
> +
> +	/** control plane counter to track enabled features */
> +	uint32_t runtime_enabled_features;
> +
> +	/** maximum number of features supported by this arc
> +	 *  Immutable during fast path
> +	 */
> +	uint16_t max_features;
> +
> +	/** index in feature_arc_main */
> +	rte_graph_feature_arc_t feature_arc_index;
> +
> +	/** Back pointer to feature_arc_main */
> +	void *feature_arc_main;
> +
> +	/** Arc's start/end node */
> +	struct rte_node_register *start_node;
> +	struct rte_graph_feature_register end_feature;
> +
> +	/** arc start process function */
> +	rte_node_process_t arc_start_process;
> +
> +	/** total arc_size allocated */
> +	size_t arc_size;
> +
> +	/** slow path: feature data array maintained per [feature, index] */
> +	rte_graph_feature_data_t *feature_data_by_index;
> +
> +	/**
> +	 * Size of all feature data for each feature
> +	 * ALIGN(sizeof(struct rte_graph_feature_data) * arc->max_indexes)
> +	 * Not used in fastpath
> +	 */
> +	uint32_t feature_size;
> +
> +	/** Slow path bit mask per feature per index */
> +	uint64_t *feature_bit_mask_by_index;
> +
> +	/** Cache aligned fast path variables */
> +	alignas(RTE_CACHE_LINE_SIZE) RTE_MARKER fast_path_variables;
> +
> +	/**
> +	 * Quick fast path bitmask indicating if any feature enabled. Each bit
> +	 * corresponds to single feature. Helps in optimally process packets fo=
r
> +	 * the case when features are added but not enabled
> +	 */
> +	RTE_ATOMIC(uint64_t) fp_feature_enable_bitmask;
> +
> +	/**
> +	 * Number of added features. <=3D max_features
> +	 */
> +	uint16_t num_added_features;
> +	/** maximum number of index supported by this arc
> +	 *  Immutable during fast path
> +	 */
> +	uint16_t max_indexes;
> +
> +	/** first feature offset in fast path
> +	 * Immutable during fast path
> +	 */
> +	uint16_t fp_first_feature_offset;
> +
> +	/** arc + fp_feature_data_arr_offset
> +	 * Immutable during fast path
> +	 */
> +	uint16_t fp_feature_data_offset;
> +
> +	/**
> +	 * mbuf dynamic offset saved for faster access
> +	 * See rte_graph_feature_arc_mbuf_dynfields_get() for more details
> +	 */
> +	int mbuf_dyn_offset;
> +
> +	RTE_MARKER8 fp_arc_data;
> +};
> +
> +/**
> + * Feature arc main object
> + *
> + * Holds all feature arcs created by application
> + */
> +typedef struct rte_feature_arc_main {
> +	/** number of feature arcs created by application */
> +	uint32_t num_feature_arcs;
> +
> +	/** max features arcs allowed */
> +	uint32_t max_feature_arcs;
> +
> +	/** arc_mbuf_dyn_offset for saving feature arc specific
> +	 * mbuf dynfield offset.
> +	 *
> +	 * See rte_graph_feature_arc_mbuf_dynfields_get() for more details
> +	 */
> +	int arc_mbuf_dyn_offset;
> +
> +	/** Pointer to all feature arcs */
> +	uintptr_t feature_arcs[];
> +} rte_graph_feature_arc_main_t;
> +
> +/**
> + *  Fast path feature data object
> + *
> + *  Used by fast path inline feature arc APIs
> + *  Corresponding to rte_graph_feature_data_t
> + *  It holds
> + *  - edge to reach to next feature node
> + *  - next_feature_data corresponding to next enabled feature
> + */
> +struct rte_graph_feature_data {
> +	/** edge from this feature node to next enabled feature node */
> +	RTE_ATOMIC(rte_edge_t) next_edge;
> +
> +	/**
> +	 * app_cookie
> +	 */
> +	RTE_ATOMIC(uint16_t) app_cookie;
> +
> +	/** Next feature data from this feature data */
> +	RTE_ATOMIC(rte_graph_feature_data_t) next_feature_data;
> +};
> +
> +/** feature arc specific mbuf dynfield structure. */
> +struct rte_graph_feature_arc_mbuf_dynfields {
> +	/** each mbuf carries feature data */
> +	rte_graph_feature_data_t feature_data;
> +};
> +
> +/** Name of dynamic mbuf field offset registered in
> rte_graph_feature_arc_init() */
> +#define RTE_GRAPH_FEATURE_ARC_DYNFIELD_NAME
> "__rte_graph_feature_arc_mbuf_dynfield"
> +
> +/**
> + * @internal macro
> + */
> +#define GRAPH_FEATURE_ARC_PTR_INITIALIZER  ((uintptr_t)UINTPTR_MAX)
> +
> +/** extern variables */
> +extern rte_graph_feature_arc_main_t *__rte_graph_feature_arc_main;
> +
> +/**
> + * Get dynfield offset to feature arc specific fields in mbuf
> + *
> + * Feature arc mbuf dynamic field is separate to utilize mbuf->dynfield2
> + * instead of dynfield1
> + *
> + * This arc specific dynamic offset is registered as part of
> + * rte_graph_feature_arc_init() and copied in each arc for fast path acc=
ess.
> + * This avoids node maintaining dynamic offset for feature arc and if we=
 are
> + * lucky, field would be allocated from mbuf->dynfield2. Otherwise each
> node
> + * has to maintain at least two dynamic offset in fast path
> + *
> + * @param mbuf
> + *  Pointer to mbuf
> + * @param dyn_offset
> + *  Retrieved from arc->mbuf_dyn_offset
> + *
> + * @return
> + *  NULL: On Failure
> + *  Non-NULL pointer on Success
> + */
> +__rte_experimental
> +static __rte_always_inline struct rte_graph_feature_arc_mbuf_dynfields *
> +rte_graph_feature_arc_mbuf_dynfields_get(struct rte_mbuf *mbuf,
> +					 const int dyn_offset)
> +{
> +	return RTE_MBUF_DYNFIELD(mbuf, dyn_offset,
> +				 struct rte_graph_feature_arc_mbuf_dynfields
> *);
> +}
> +
> +/**
> + * API to know if feature is valid or not
> + *
> + * @param feature
> + *  rte_graph_feature_t
> + *
> + * @return
> + *  1: If feature is valid
> + *  0: If feature is invalid
> + */
> +__rte_experimental
> +static __rte_always_inline int
> +rte_graph_feature_is_valid(rte_graph_feature_t feature)
> +{
> +	return (feature !=3D RTE_GRAPH_FEATURE_INVALID);
> +}
> +
> +/**
> + * Get pointer to feature arc object from rte_graph_feature_arc_t
> + *
> + * @param arc
> + *  feature arc
> + *
> + * @return
> + *  NULL: On Failure
> + *  Non-NULL pointer on Success
> + */
> +__rte_experimental
> +static __rte_always_inline struct rte_graph_feature_arc *
> +rte_graph_feature_arc_get(rte_graph_feature_arc_t arc)
> +{
> +	uintptr_t fa =3D GRAPH_FEATURE_ARC_PTR_INITIALIZER;
> +	rte_graph_feature_arc_main_t *fm =3D NULL;
> +
> +	fm =3D __rte_graph_feature_arc_main;
> +
> +	if (likely((fm !=3D NULL) && (arc < fm->max_feature_arcs)))
> +		fa =3D fm->feature_arcs[arc];
> +
> +	return (fa =3D=3D GRAPH_FEATURE_ARC_PTR_INITIALIZER) ?
> +		NULL : (struct rte_graph_feature_arc *)fa;
> +}
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +#endif
> --
> 2.43.0

