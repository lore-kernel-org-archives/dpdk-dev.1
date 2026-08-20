Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711C7C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 16:48:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B6AD4060B;
	Thu, 20 Aug 2026 18:48:22 +0200 (CEST)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by mails.dpdk.org (Postfix) with ESMTP id C93394026D;
 Thu, 20 Aug 2026 18:48:20 +0200 (CEST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KDSehd317162; Thu, 20 Aug 2026 16:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=OL1FHI91LVaZF8HQmq
 1q97LDX5HOJ86GF8RjMm3bWV0=; b=LeU6kYbdm/c4rI4kCSc4+1wKAU40XDaaPr
 ouenitilh0KrKCaVYFOR+ZuMJpVbjPKpPMEl4Iv3YIOdBzzcis58YKpp7REGK9/L
 TB++V2PaJr7SHlTdZOsU8V3zGUS7QdbchSGNNEgzhnB6LmZOqhOWQzzlk1oS6PuH
 I0qItJjej4SA9S4xhwLhkXE8x6COueJNBYEWqIVB5GBGNt9fhTWVaBzMXKgRLYtJ
 I3Ysgd8SMMVriwV545GDGNeTfwpNh7KImz6g2DiNJbutrpsUw3PC6pNTgHj1Psog
 0qRIPXwmzJ8/MJtQQ/H6k6dx8U7kDz1JLxXfORWB75WY+2s0NPNQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4ydgkp6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 16:48:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67KGebYx035025; Thu, 20 Aug 2026 16:48:18 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4g32htek29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Aug 2026 16:48:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlcHfMmVJDH0ukJhiNxvqIUpavjtVG8lw7/5zmNbnmkKWdIJcFXn6ppfPxFb7ojZoLzqtjKqU7c6hscW7mp732YP49Vm5AYFbPR8XnUAet5LRCAZUuPkd+A0MxjV3cOGWqN3Hnu67sYlBXBw8SoHNRiedubwPlfNJ9d9TjU1oIWTJiSTgaygwza4hDBK2UGhYRi9NUkKQdjiwpMUn/pXgk0N0iA/cUfmqcRSM2ZhIC+dKjih+Ed/3WJKbPSJjZaRa0/fpC1wTyZDBNuNFB5UNcFF8nLi5Giyc7B5PQ5UVkUzwvT/TqdFBxhiRsjaDoD5imZnmDJNXTAObOEnozQUfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL1FHI91LVaZF8HQmq1q97LDX5HOJ86GF8RjMm3bWV0=;
 b=vRI6m5Jx+XgWinDUqV2LGHb2be62ykKynuRZeKCyP+o++V2nQTU9KU+MhdcDDXpyBJsgH2QfV2ybkB+/NchTNBCtGjrM5lWL1BCyZHtRziZRE469nXBmqWPnXYTCM6rWh2ePBAHKebSKsfbpfyhAZnBwEQrCGSBkoAusrXlNTka14OBJrBjIjAp5Cl6K0tQ+Pa9yfHLHkOYqIpbT8qbZd5vkftuQTyw26h/LN8EV2kb6RYvjcthhaieZErrqeJUzI9715Tpor0dQG5WQly0xHxGSPbXR7xGoE72loSzxqv7T0tvwgCCTV9wz5KSAuz5cELXa2SBpJO/uWWLuzj82Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OL1FHI91LVaZF8HQmq1q97LDX5HOJ86GF8RjMm3bWV0=;
 b=hClFm8poirZGg2oqfq7hDikuKEt+Vnwb7JftfKUR14Y/7vsL2ZzNnMd/zR4tN5uh4Tg9CysQ7zSG4ai+1Ml7Yk3PTYXoSR30sJtJXzPiObrIea3BXq+ZnAIuTyiRblkdUwCChGaZO/hctAJpzmfEauYVFrp/xUHqZtqhGllslFY=
Received: from CY8PR10MB7219.namprd10.prod.outlook.com (2603:10b6:930:77::8)
 by CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 16:48:08 +0000
Received: from CY8PR10MB7219.namprd10.prod.outlook.com
 ([fe80::89b7:32d6:3ede:185e]) by CY8PR10MB7219.namprd10.prod.outlook.com
 ([fe80::89b7:32d6:3ede:185e%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 16:48:08 +0000
From: Banoth Saikumar <banoth.saikumar@oracle.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
CC: "viacheslavo@nvidia.com" <viacheslavo@nvidia.com>, "bingz@nvidia.com"
 <bingz@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org"
 <stable@dpdk.org>, Banoth Saikumar <banoth.saikumar@oracle.com>
Subject: Re: [External] : Re: [PATCH v2] net/mlx5: fallback to verbs for Tx
 memory allocation if devx unsupported
Thread-Topic: [External] : Re: [PATCH v2] net/mlx5: fallback to verbs for Tx
 memory allocation if devx unsupported
Thread-Index: AQHdCHqMx9spdv6vXE+cWihqlOrYpLZrYNiAgDwVLpQ=
Date: Thu, 20 Aug 2026 16:48:08 +0000
Message-ID: <CY8PR10MB721959A164FE57489EC14C6788A42@CY8PR10MB7219.namprd10.prod.outlook.com>
References: <'20260323113403.1984-1-banoth.saikumar@oracle.com'>
 <20260630102311.1050-1-banoth.saikumar@oracle.com>
 <alpmogwsv3466g33by7pyw4quhbbu27l3ieqgiexjvqj2ebux7@xuevtradpj73>
In-Reply-To: <alpmogwsv3466g33by7pyw4quhbbu27l3ieqgiexjvqj2ebux7@xuevtradpj73>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-08-20T16:48:07.155Z;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Including
 External
 Recipients; MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=1;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard; 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB7219:EE_|CY5PR10MB6261:EE_
x-ms-office365-filtering-correlation-id: 3effdfe8-c25e-4f30-c9cd-08defedad013
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003|8096899003;
x-microsoft-antispam-message-info: XwQnELyxb1K8XOUlK/bAB4nOxXM8Uf3P8z5MnSEkYxSTSIANI9N2Mx/OnkG/cfwLGhXAfezzlO/lujsj9T5d3UZiA7Mr9+fu9fLovzL4All7f3QbZy4vwLSDwmMO/XxXu3laBz3mMb/eEGnxyKk/5IRGf3jDOK0KnCC4UPRHDc5HS15rn9B5snZaOuulLehaEtQjTqoHwNRPusjj3+BgsZw3NWgXHS5nP3PEMNyqtoZ/Uu0yGrIpMufzAS9JyNLG3bqsdD6/uc9cFG8+zlvDQJ5tSf/b2N0ACdJMkFYHO/6k7743gG0Qi1B58a8IwVUXe9PjvIXs0RZk8vC0Yp0MjQSlkEuySw29Dg387hNDP7QFmg9wLCz+USK5A3q9rB+iZHCMPJ2dtWi+e42NlEgh8B56Mki338YrPQOVlwTVaMtHYMCY+oce/OnWOe5ZJdQQFZce0ReqNgS6PTdLx8IiuG1D31MDd3TyQJzKv4iyejqZJrevEJjNoK2zAhAC+2j/y4nsDuvBgTYyVOz3zbGqaEx8ipapYcQ69XM158xY7SSYmijQlbuu4q9z6LtKV2X6tJUA2+5+F79cl84A1bJ3wCByouMzvO5kIbr9VxNVDp75tgv2oJ2ukJBNATisKVWyqJk1SCTY51VFgNyI7viot0n37S+PRsY/yCjBx6PamrlQQW67jUoodUUQrP42OakFDqnNfuJV4iD7yC4gxThY2+fHk/9LJp4Y2jtNW5acSpc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7219.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q+SqKU/C8vuV0F4ImBbFHH5ghYNDeQIGFgb8Ds7sGDsWOpcSr2vBRilDLfsj?=
 =?us-ascii?Q?ZyWoHiXbr46VSF64sUV87Q2gxi7uMF9MDfX8nsr8fJGZJA7q5JTzjQu1Z1qH?=
 =?us-ascii?Q?iagqv3uqQd853pUrDMK/EEkhBICfzuvgZ8tjrudig1XPO2EO7sv2bKPCiPZ5?=
 =?us-ascii?Q?igJRCoDsBQE23qk3LTX8RPvLdndzJidlgdgN5cU5xP2OzPaJClU/e8kOfvwT?=
 =?us-ascii?Q?eP7337+HCU4xQcVKeu7ulgxgIOL15VUtYw5K1kdCivjyRnwpEaBt3APVo82O?=
 =?us-ascii?Q?mDixtzH/WZAwasdaf+MqgGLKfctZfsx7Ahxqfpn58xPWMlK3L2yIdKBU3Ov3?=
 =?us-ascii?Q?6BbEPW927v68rcKr+KYhSvJeq/+QfSf4JHLDCWI6nv/UxzU0Dkn56liZcxCj?=
 =?us-ascii?Q?X+G917BvpIvEiP3EFVZdzOr/9g9F/KcX4UylATzqgvHvNksugIKlCDaoN31Y?=
 =?us-ascii?Q?F+jWTjaTXZTW8NuEETxzBciGysXmchQ5IX0OpspB+PSh6Ksu68u9Yi81gVju?=
 =?us-ascii?Q?ULAVLiZkmBXrjTmHApRCSHrhNjQy7Uvh65TPyv1SHobqY95+KPQQUe1qLUF0?=
 =?us-ascii?Q?j3kw65pcBS49Y51y0Gzylwd9VYCS2h22dKuPj/HCsmQuNGJaEaa/0tz2C9ru?=
 =?us-ascii?Q?zMV+wLhAJ5OX/5B3C7UfQQ+Dqm4eK7OXNrobtcjy7gYNoy3rxq2QcsTPJCJg?=
 =?us-ascii?Q?4pLLxAeKocj8E9ADWrJTXOaXauwSk9zMiczpccpSJ0ACr1hNcInYuy9xcYuP?=
 =?us-ascii?Q?PAovTY2ullCFI6tmPntRKh5AAkg3P/gXvEeuPpUG9StVLHJpYAlxEQu05Qwx?=
 =?us-ascii?Q?2kBGl8U9BtThHOhFsTEoJDlVPcwLX9vPTlB33f3V0gHEAj5qAVWeu6tr4D+z?=
 =?us-ascii?Q?qdNnsHsGmWFB5se+JgUu6FKyqtPUVOqIWmCvVWe1RWNXevCST5vJLZF6ii+9?=
 =?us-ascii?Q?Hxkt+EKBc5juJtqjDouG54YZVMRZrh5jYC7mgelXgEQEraTcrlzTJwvoftJ+?=
 =?us-ascii?Q?aam9iBGqkcWd9fIaTOiahlZSRfPRxEAcswBIJaU9WBLCJ9KQLaqNW5bm7bLe?=
 =?us-ascii?Q?rZJMy1qmI395mwQ6f/gJcFnw+XhKdgquAQUCEBeHNG9ouRf1P0DJto3WvAuW?=
 =?us-ascii?Q?wQFu2mPbbihbEsJpWkrUUAKY/3QK5L0LWdG33/Uqtk48kEY1JC1zzyZC9we0?=
 =?us-ascii?Q?YdgjaYJYJYshXuSYnlaT+LFhl09oBHWLdwIAYLhswmb2Mu2zl9IY/DpjTbCz?=
 =?us-ascii?Q?psWUbse1ftqAAPmWamLSpy4kMbOQMU3Jwz1pgVigRTvwJQFRaRkw8txU/bp3?=
 =?us-ascii?Q?NOvWIBmCoEL2KtKP20+dbO5+GVRXujJMDwN5ijHKJkU5g8HgxHcaBklODO1k?=
 =?us-ascii?Q?284rNhHtZxW4HCwSdZ9MwJ3FWzWz5ET8fzRpWLDNTCGh78wkrpRh9H+xBMfp?=
 =?us-ascii?Q?hn9hGSEtfkqJgEB6whxj7qj3s6Vj9Up1/9T+FV498hF2CeoI3PbXb3X+ACaM?=
 =?us-ascii?Q?j3GorHaoWznRKW+62WyCH8plzgVmomc7MtbKZqvhA2IMqFVzowyMPetbZ0tn?=
 =?us-ascii?Q?bKaF9ImEDyJeswILOp2vl4dm2mGr30VRYww9c++o6dqv51t/sxNT+VdqQ538?=
 =?us-ascii?Q?fSZWQeZ4QQdaezQKIxVF87RKrSMyxssZ6WWdJBbIiP4EZMq/cYIJLhiYGDw9?=
 =?us-ascii?Q?2+v9inaIS3z/tEdIv06bR4n7YGtMg4GFcoKS4Qem1B04BjRawTNfER2/h14B?=
 =?us-ascii?Q?IP9lEX8pGQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY8PR10MB721959A164FE57489EC14C6788A42CY8PR10MB7219namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N904Xj+D4MOjLjRKMhfLA5rvDv5fo6QyyHQJKCNrwQsb3d7gVsZUrxgDMrkhM9SAZZcCsgCQ8tLLV/sPcXGTja+Ad2r1AFj8tDHesPVGVLpO+xieyZpry0qdxMFXVrUt7/2UAM2SMRNmzkmzGzC0eKfW7q2kTzVo4r6UelMSysMNJPz3DslsZvW6TKWRZ8BGAnf5dvqLwm8UeieccYv+mTIAjAJy7w+Vz9uVH3vgpBhOIBqzqcxA7O2xJOOKGjP7uDfkdMXo42U/NDX/VOtYd4IqQ/ZHRi7+Jx+Sd+F4RDBM3UmbEB1cUWcp5FWcv7GtFoM/yftzAjXIjFeVYBfrdg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dw3+B1n0Zk2ms35goqn8v0lYfQ6tUgpb2UxU13/XC5k/zTq0pAkxtratYNujl5GDgwrYdfho/U5iKA/7HUtt3GmSU2GGfdKC8NaqoQFlV6w9nEum0sL37mdiYLPc1cBukXWQ/oYLRyzexXyMIoDhulYhObq32oy5az4rwXk4N+YHtolCOu0bBcgFfLROj+Pfx3a/7eViZh2HuzjAasjGR4EAhPMD9/rgINxvlHpOUslyf2eE6rPpG/B+nKLiMt7mNv/GRpbTAN9OxrSIRyZCT04NY2zMp9eupnMR7noBpeBLsZnEFKjQlgc74kz5lsFQVkINz8Z50+6iIKazGiD6H9oD49DpbfSwGgJgK8CVvIwmda2KsxK6lpASTxi74w1hTa5+ROkubhE5ESV97qhiTJEK08X9vDVQP/agnm41ko6tGT89+vKXebGeoQwViE32gTJNWJn7vfFu2e66cyUH7cYQMZc1fheyCmMSG/VhoFUL9+Jn3Hvo/vicP5f5thNn4Un92aZErfhqtFIKCWJI3g0FOTpjqwBTxFVzdFf5MTK2/g9uB2gQbikX22NLQFWS7ad4wmHqFOGvjbb/hJ5A9UYnXwZGCEyGWh6e2zyZpv0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7219.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3effdfe8-c25e-4f30-c9cd-08defedad013
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 16:48:08.0287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etobu6PP3MoCZnLlOjKxsXkf5ZnBmEeDPwNd5HOHPJH2R/ht/wz1KbaIYguriRNOjtbncHLEwOQNjS3qz7w4H/1dFhZNofq8eM7fP4HvpbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608200126
X-Proofpoint-ORIG-GUID: 1TFtciLuQZR8bW5kSBi4gyZ2etBrsV9k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyNyBTYWx0ZWRfX5rU9VcYSmIdX
 oYPO+nA+uyOZzWb+8gHFR1VoVP0ivNu3x2PqwYYbePnVmjGMgQ/p3Yu8SVTkL/slFQIjQ98huZQ
 THhWjqiaHnr/gsQ76pBAQPmHh/xu+x0iDHIdMQMziKU/Krin0lR3ETfxmuNMjZrzhpOUh/WENiv
 YUTEa4zJ3m7URsitfmzKQtI9SauZQqwnrmYBa16AKKQy19ReXfWTAPgNYGQ0+UmZp+TxL0fr7Oo
 2CP6Cny4xiF9UGePctG7p2YX0i9LPMOFg7jwoSF3IxZwbuij6sfvuf1hRogB4zVtH4YKQ0cedKm
 36B6hWPtSzAzeJqaWIPEyGwjv8hId8eMMnKGe7XEU+2PNmywyo1jyHcGD+waYGm9+JSfLsbSF8f
 UMmFxw+8VJOhuXbgtp+FpuL5wm8HKIM0ZTzeTExi/1AInzPqRHP/cHKljFEctbdCIQamDGNv40s
 VsaM8FYniQb16jKQBzrZfqH1mMpQ7f1AvMR/61Dw=
X-Proofpoint-GUID: 1TFtciLuQZR8bW5kSBi4gyZ2etBrsV9k
X-Authority-Analysis: v=2.4 cv=ZIDnX37b c=1 sm=1 tr=0 ts=6a872fd3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22
 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=8rWy6zfcAAAA:8 a=y8ldvKm-MKo9SYDbi5AA:9
 a=CjuIK1q_8ugA:10 a=BA8cjTSUzlSicA1H:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12102
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEyNyBTYWx0ZWRfX9R7J1Yynw0PD
 4n4mwrNraE789vVdj18xneQ0nCFJSzdMX/jAiOhOfCkkGTUaa2lJEXfiPB0gLlZaGF55zAs+/ux
 8erTiD+gLbxpC8LliWdSq9jTY0WBEJDZWCqCskV49EL9rBc1S2gY
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

--_000_CY8PR10MB721959A164FE57489EC14C6788A42CY8PR10MB7219namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Oracle Confidential

Hi Dariusz,

I noticed that this patch was later reverted by:

> net/mlx5: revert fallback to Verbs Tx allocation

The revert mentions that on Windows, DevX CQ creation was failing due to
a different allocation fallback behavior.

Could you please clarify what specific behavior needs to be addressed
for Windows?

Should the original fallback be reworked to handle the Windows case,
or should the fallback be avoided entirely when running on Windows?

I would like to understand the expected behavior so I can work on a
correct fix.

Thanks,
Banoth Saikumar

Oracle Confidential
________________________________
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
Sent: 13 July 2026 16:45
To: Banoth Saikumar <banoth.saikumar@oracle.com>
Cc: viacheslavo@nvidia.com <viacheslavo@nvidia.com>; bingz@nvidia.com <bing=
z@nvidia.com>; dev@dpdk.org <dev@dpdk.org>; stable@dpdk.org <stable@dpdk.or=
g>
Subject: [External] : Re: [PATCH v2] net/mlx5: fallback to verbs for Tx mem=
ory allocation if devx unsupported

On Tue, Jun 30, 2026 at 03:53:11PM +0530, banoth.saikumar@oracle.com wrote:
> From: Banoth Saikumar <banoth.saikumar@oracle.com>
>
> Previously, the mlx5 PMD attempted to allocate consecutive Tx memory
> using DevX without checking whether the NIC actually supported DevX.
> This led to allocation failures on legacy or unsupported NICs.
>
> This patch adds a fallback mechanism: if DevX is not available, the PMD
> skips DevX-based allocation and allows the verbs path to handle memory
> allocation and registration. This improves compatibility with older
> NICs and ensures Tx queue setup proceeds correctly.
>
> Fixes: bbfab2eb2528 ("net/mlx5: allocate and release unique
> resources for Tx queues")
> Cc: stable@dpdk.org
>
> Signed-off-by: Banoth Saikumar <banoth.saikumar@oracle.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

--_000_CY8PR10MB721959A164FE57489EC14C6788A42CY8PR10MB7219namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 0); =
margin-left: 5pt; font-size: 10pt;">
Oracle Confidential</div>
<br>
</div>
Hi Dariusz,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I noticed that this patch was later reverted by:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; net/mlx5: revert fallback to Verbs Tx allocation</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The revert mentions that on Windows, DevX CQ creation was failing due to</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
a different allocation fallback behavior.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Could you please clarify what specific behavior needs to be addressed</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
for Windows?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Should the original fallback be reworked to handle the Windows case,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
or should the fallback be avoided entirely when running on Windows?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I would like to understand the expected behavior so I can work on a</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
correct fix.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Banoth Saikumar</div>
<div><br>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 0); =
margin-left: 5pt; font-size: 10pt;">
Oracle Confidential</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dariusz Sosnowski &lt=
;dsosnowski@nvidia.com&gt;<br>
<b>Sent:</b> 13 July 2026 16:45<br>
<b>To:</b> Banoth Saikumar &lt;banoth.saikumar@oracle.com&gt;<br>
<b>Cc:</b> viacheslavo@nvidia.com &lt;viacheslavo@nvidia.com&gt;; bingz@nvi=
dia.com &lt;bingz@nvidia.com&gt;; dev@dpdk.org &lt;dev@dpdk.org&gt;; stable=
@dpdk.org &lt;stable@dpdk.org&gt;<br>
<b>Subject:</b> [External] : Re: [PATCH v2] net/mlx5: fallback to verbs for=
 Tx memory allocation if devx unsupported</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Tue, Jun 30, 2026 at 03:53:11PM +0530, banoth.s=
aikumar@oracle.com wrote:<br>
&gt; From: Banoth Saikumar &lt;banoth.saikumar@oracle.com&gt;<br>
&gt; <br>
&gt; Previously, the mlx5 PMD attempted to allocate consecutive Tx memory<b=
r>
&gt; using DevX without checking whether the NIC actually supported DevX.<b=
r>
&gt; This led to allocation failures on legacy or unsupported NICs.<br>
&gt; <br>
&gt; This patch adds a fallback mechanism: if DevX is not available, the PM=
D<br>
&gt; skips DevX-based allocation and allows the verbs path to handle memory=
<br>
&gt; allocation and registration. This improves compatibility with older<br=
>
&gt; NICs and ensures Tx queue setup proceeds correctly.<br>
&gt; <br>
&gt; Fixes: bbfab2eb2528 (&quot;net/mlx5: allocate and release unique<br>
&gt; resources for Tx queues&quot;)<br>
&gt; Cc: stable@dpdk.org<br>
&gt; <br>
&gt; Signed-off-by: Banoth Saikumar &lt;banoth.saikumar@oracle.com&gt;<br>
<br>
Acked-by: Dariusz Sosnowski &lt;dsosnowski@nvidia.com&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY8PR10MB721959A164FE57489EC14C6788A42CY8PR10MB7219namp_--
