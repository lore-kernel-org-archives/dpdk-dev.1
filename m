Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E30C5516D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 08:19:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 560AE40288;
	Fri, 31 Jul 2026 10:19:17 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 3F43C40280;
 Fri, 31 Jul 2026 10:19:15 +0200 (CEST)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V7to642240897; Fri, 31 Jul 2026 04:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=z
 5IcQCqrlBjzH2vQP0Mme+Vscq2OBlWDePN3Lqh5dpA=; b=LeFyvLWwi38PlY0fh
 Q+wgjt5sC4PLEuYIYZJ/yXkZUkxO8nlO63it6svZwR8baOUMDGqYBCKBDwd3Fjy9
 vKcXCPHtjcHOM31/zEBYjsBnJ/T7+QVkJXEySIw3Cx+cr9RKHQefIOWVieFTiJWu
 a72v3c9usB788dOfvlFhT/3jRhfrFBo/U3CQqkg7yZB7RXuO6nzBONFNPH8mNlPB
 t8zgVeRFi9X5d9qAoBEpELBGW7tEf9ALwQgQW+NKQTiJs7JZxkd5T2YqAxvu5aly
 vwGlwgIyM2hlKk4q8QJlCXJRY6EdxVLf2YMFQ3WBjPIB7PUbzKG1rfghaenqJ9S1
 fwxyA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4fmra7t8vq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 31 Jul 2026 04:19:13 -0400 (EDT)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V8FFpi2975032; Fri, 31 Jul 2026 04:19:13 -0400
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4frkf1k3yb-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2026 04:19:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5AZGXzIUelJcR+bivbHCXzl5YpV6yKMrkMq7BbH7mlwOfZR9egTUrCe+3My1VB4rNr1adxTMtFj1Tn3JxpCQ9KquBsrP7aJQJJ5WeSg7yfgVtE15GoVAZ/Qo2kvDdUMMfmC5ZidfEHQCJpo5F/Y2vcBBNzoDPuX+M8aGufKqqMb/x6aZ551/r//aY9XWDYMdgSanDSP/lK9j91vSuO8FFNpTfkLw/eP6WgogiQDeoqH1/k7nyIwPRxzyF9Dl+BIL0CJwl18rRM3scEvK7VGCiTzyuS/L0TgPlpHqeRj1ZcrXS4kUJXKTozcmQ9lWHFmIuDfGYcVfAgVAPRwHtZjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5IcQCqrlBjzH2vQP0Mme+Vscq2OBlWDePN3Lqh5dpA=;
 b=RGzk/kiZcoUrzu0+8W4tN0MOv6s/DsJP/pwDlVVgxxtGVIXt7FLB4o+fjhYkMzigv5WLKBdY84Qij+rc/ak2wp520xHQf5rV0jKNROQ+QXFNd9WKxaZG1kga9F6hU5kc5WuVL6FGwKs/2BD3mhtIGk6z4N5A9sJHqTKdT7yzJ03gYqVU2UxrLxlQK8m1vVTZeZlyWMkUZHtEO/i8rhnKZmBy6nKNOeFWYHskwPmmaxCDQveqkiX1BPGU/jmBI3Bv1q2/RYNRWOtk33CKWQ2k3YsqAJtEb9CTnd/hGjI+yLzxBOoaxy21IcAzgskwzLhwa6edj5eMUf9TaxLORLV8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from IA0PPF659BD4C46.namprd19.prod.outlook.com
 (2603:10b6:20f:fc04::ca9) by PH7PR19MB5515.namprd19.prod.outlook.com
 (2603:10b6:510:13b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 08:19:07 +0000
Received: from IA0PPF659BD4C46.namprd19.prod.outlook.com
 ([fe80::3375:a560:cdb5:4267]) by IA0PPF659BD4C46.namprd19.prod.outlook.com
 ([fe80::3375:a560:cdb5:4267%8]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 08:19:07 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: David Marchand <david.marchand@redhat.com>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>
Subject: RE: [PATCH v2 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
Thread-Topic: [PATCH v2 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
Thread-Index: AQHdIJqmnf1/7bON30W14JW0Wc3J87aHKHoAgAAJu2CAAAjrgIAAC/nA
Date: Fri, 31 Jul 2026 08:19:07 +0000
Message-ID: <IA0PPF659BD4C46C174C843A7FE6C0208C2F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
References: <20260731031355.3578236-1-pravin.bathija@dell.com>
 <20260731031355.3578236-2-pravin.bathija@dell.com>
 <CAJFAV8x137vqFU8bptTFhxjusYG1wYHxkvE46iMRif7+84_w9A@mail.gmail.com>
 <IA0PPF659BD4C466F2C7E46C7DF91081BF6F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
 <CAJFAV8xPCRAerr-goiD5UbxPjmy5ddyb0ew8FK+nZMdu_g1kDQ@mail.gmail.com>
In-Reply-To: <CAJFAV8xPCRAerr-goiD5UbxPjmy5ddyb0ew8FK+nZMdu_g1kDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-07-31T08:11:13.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF659BD4C46:EE_|PH7PR19MB5515:EE_
x-ms-office365-filtering-correlation-id: 74c31a5e-6d0d-4a4a-75b0-08deeedc6437
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|786006|4143699003|11063799006|56012099006|38070700021|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: Q1O7XegP5O03fzaoIX2Aopf/2WHwberX3Uw2+/QojR41aErFf0xitsYIVqxYkqHs2a0EYPkwRJ6oknAeDIZMhvn+1x/b/o99g0MUJNXCKIHcIgpXDI/VOkqpHZvjCNrTLG3BKgl1ik0vjwZmIydlx33ze48QATgRQ/+NqbANpv6uhDLtVkjEuIkczJe+lvkVdA9jNWi1rX1GR/z2GiNXzTlV97H6YpY1aPU5cMZap8PQekB6e+5BpkKKBsMShBDNXcGu1wVgRTgctzZiG3N0qCiCdsXvEJzShKLgO6b+CzddXxXEC4mTRT1G7qjjzrb8eteN0T3iN5MbC7/fC1RxQDw9cpt/bndI3eheMnBm+Ed7mdgheemYiqMqrDA9nCGZjKQsmgy26gIe2vT1vwvIIt0/2nMsA5jj/PCZK2IVxNDVaKRYNgG2RzmSHpHPWmxr53gJXz2XSLytW1erf7ytQRBSYdgfDRPtX3dPoUN3IwijP9bD2NwW5twIi/Tv8ByyDmMWzPQ4b8TUIsbfVDV/dNCyqwSazaylho944utq6Pjba+0gNb6ZdtQCz0MrAbmxEm6y0820/Apn50aoVOXFifjkWXk6pSPKeX+pJ12Pbxi8IgJrjeHDWVPZAoOyX7X1KNHMwgDiZiz2EPjNhCzAI0F4pTqibXFFr1ZkgVTTLqfgZ0a4Nh2CnhZ5nKouUnVPY9nJLzm9Fv/etynKQfZ2s/8ByqpYhQP3o87DwKs2+3A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PPF659BD4C46.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(786006)(4143699003)(11063799006)(56012099006)(38070700021)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?RUJadzhyY0Y5T1JhWVU4VTRDUHJ4cDJPSXI4akEyWEVjdER6bk1KMW9BKy1Q?=
 =?utf-7?B?eHBQakZpUTVKUWhCSFpXTmJxVTJFa1A2Zk91Q2FGYnlPdVJQWTNvS0d5c2hV?=
 =?utf-7?B?YXFGZHA4a3hFWE1EZVlTQkorLUN3MEZGYXJoUlFOZ1FMZHRzdystNjNoT0h2?=
 =?utf-7?B?Vkd4SXpRV3hWRzQ1Vm9RbW1oamxqVTdSYmRuT24xZHQ5UkRvSG9LdlVTM0J1?=
 =?utf-7?B?YWtUOUppYjFabG1JSEJPalBsaGgwSkNxQjIvOG5BN0dsSVR2RDlFdk01VEpt?=
 =?utf-7?B?Yjl3MkpFeTRQdFR4WTVINXhFNFI4ZGhZbVFwUmNWd29MMGwxOXd4Y3F4R2JZ?=
 =?utf-7?B?OVZERy96aXJZS2JLKy1pT1dmTjJqZzVqTE5WYlJoRksyb3oxT083Q3BXaGVL?=
 =?utf-7?B?THlEYjJvMVBpL2NDajRaU1llejRSN2Nhd2JpWHZqMG9hV0Q5d21NZzF6a0M=?=
 =?utf-7?B?Ky04Ym0xRGNxaXlaTDMzd0tRYlloSksrLUVNZlpuaU93Y1VYTGZlV2dUbWRp?=
 =?utf-7?B?T1lsaC81NzVGUUx2Q2kyM29jZ0pZVDYzWUR0RVE0TCstWk5tMnArLXRLWXpB?=
 =?utf-7?B?VFlqV3hja3B3clI2ekVNSEYyeGZlTFd5eFR2TG9XQTZxRlZFQmJCTSstL254?=
 =?utf-7?B?L2RTYWxHNlJucXhFZjQyaUFCaThidEVXWlp5alNTcWVRa2hnZEtueUlERG5U?=
 =?utf-7?B?aHhxcHVRS3VsUGVINmZSVzJKaTYrLVUxT0Q1aGdLUnBNZkx5LzJQQm1Wcjkz?=
 =?utf-7?B?OVZFQXB4VystcHB0U0prVG1uaWczZEFsT1V0RWFucWFUbWtDVVdCTDRGdVh6?=
 =?utf-7?B?Mlo0L3Blb25BbENXa2V0NnY3VkplcmxsOFkwZjk2RXdOQTVVVVlCeXBramFP?=
 =?utf-7?B?Ukpwa0huMkxqN3FHQXJuKy0xbXFtWmRPLzdVZ0xINU9SblZUQ0JrcGpReFlX?=
 =?utf-7?B?amRXQm9aQjA2bEV6NUlBNkZBSXlxdEJtbGh5U0JlOE5DSWJ5emFkdVY3cEhj?=
 =?utf-7?B?ZHVXT2RnaUJjMjB1eER2Y1JoQXlCZ0pIKy0rLU4zT3lSWjFCa1dHb2ZZWjVo?=
 =?utf-7?B?Y2F2YWNweG5OeFcxRGg2VTBrQ2REb21Zc2NoNlJ3Q1lOZ2d4UE0vRkxEY0Rm?=
 =?utf-7?B?SjZKVDk4aEJOY2RnUkdjbWVSSFZ5MnE0U1pPRlJEOGg5ZTgwYXp2ejN0dloy?=
 =?utf-7?B?RHJBaDYxMUFrcGZWWXlNcDhzL1lhZXNNQzhVaC9uY3JzZ3YyYlgrLXlQb1FK?=
 =?utf-7?B?WFV3SG9kL2FucWUzM3RVc1JZT3lsM25QUVIvNEhVbjhuV2lOUE5udk4wWHFt?=
 =?utf-7?B?djNDeUxIZVdrMHZyQVZqeXZXdGlBa2NrUGpKdEhlN3NjUHlVa1ZIcUUyNU9j?=
 =?utf-7?B?M1VXNTJlcG84eXA4MXRRZmdkSHMvVXQ0UTUweGZiN0tmKy1relhNOHlla3lS?=
 =?utf-7?B?eUNLbSstMystd0UyWFB1R25WSWJKdWhGdjcxNlRzVjhJOHZSaWd5YVA2czE4?=
 =?utf-7?B?YkRaUFpsNTZYckVFZTBMVHJ1VFo2UFdWKy1ZYzhGYkpHNDlpWmRuVDdyU3lO?=
 =?utf-7?B?VVVsOHU0U2U0b3lqdWdGa3BnWEltMystU2RzTjFZd05hdmFOVkJETHo0ZWtV?=
 =?utf-7?B?cTNjblZuSXEzTlZ0ODRaeXYzeDRLTlhXbXBWTUNjRlhnMSstV2xtSUl0VEFn?=
 =?utf-7?B?b3VqZWtLdXJCMVdIdDQvWExXZUZjYk16UTBWWHk5S1kxcGJKZ2t0cHhjR3BT?=
 =?utf-7?B?WnZ0RUc5R2o1bjk5TGdLcXVYL2dleVMrLUIxUWhxeUNCRnZqTFdVKy1RMEZS?=
 =?utf-7?B?N1lIZlozdHd1S2NnN0NaVFViYk01cWhKRXNQTFU3UmgrLUgvSVN4YkRkWWg2?=
 =?utf-7?B?V0J5VEtSZWxuSTBWZThGSkFZUnAxKy1hQlR2bUtCVUQ3c0VGVEtQQ0lBSWZF?=
 =?utf-7?B?NDB1WWhnZ2R3QnlsdzE5UjZsQWJzenBoVTVSKy1FYWMzNW5YOGdjMXhMWDVp?=
 =?utf-7?B?QWNWaWo3QVhzaFNYYzNYdHp1WE50UEIvdmNlYTZiOUdsbER2S0ozL1gwS0xJ?=
 =?utf-7?B?Ky05QWQ4YWorLXVaVlM2bFU1ZXFRNlRDVEhXSUw0V0lZdmxxZGJTQlgyRHNP?=
 =?utf-7?B?RW5BWTZqUVV4OGhlOFB3UGp3aGYwZGoyZlNoOURpWXhLU2RGdThGRUVJL1hN?=
 =?utf-7?B?TmxFbi9tcURsNzA3czIxeTZJdkdqUHVqNWR5M3NlQ2N6UXI3a3FYdk1VOWhm?=
 =?utf-7?B?SXNsYmpuYXNudEMvZzZnbGg5MUF0N2JpZ2FLREpESXgxemtKL1BQRHg2RnpI?=
 =?utf-7?B?YU85MEtBZ2Z3bW9PNWcyZ05wNmhab0h0eTRBTm10bEpDblJUT2ZnenozRk1S?=
 =?utf-7?B?a1BVMHFUNjcrLUlvMDFXazlUUFBNKy12UlErQUQwQVBRLQ==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gc5WO/IsNQVFJBa9ARQeM8h7KWsHPDe+RIM71RAmGpwW984nT3mNoGmbT3m2xaNCuZlrYsqrAaGptBC57HgqU2bOtx0HIN8MnJM00pLdlD7LjrG/ObivEV4TISUw3XzXCF3t/0krkoPwJ7K4MhCk8rNGHLpDfNLoCTCK1E/QuG1q5BNZqcLxwnWdSM4z4Cg/Gf1HiQFcTEzHPkrczXRwsk80o+Yd5VkjyXqe3WhWOkj/QhjmQEInK/dwnQxGoYM8UqBwvoZ5YjjPOzzz3k+SmRf65x2yPfOz032DNllHPHY72Oqg2+We8gCGk2vbdPS+3X9C1O+WD3xvWbrcmPIx5Q==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF659BD4C46.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c31a5e-6d0d-4a4a-75b0-08deeedc6437
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 08:19:07.3545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0L1kMWuVKmj2CKY5pxOy2XLIz3BisjFUDObmnO96Vk86TrTVegEWjYStKxtTT3XPTCVTqu7EEESxYYtd/fOY6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1OSBTYWx0ZWRfX3L2M/Ys1baWv
 33d01fFDNMM7/vUyL+sG5SW7mKZXumeSa+K5v9khCf6YgvuLNuXKas7IW534V1SnP+oCqY3XCaX
 7i37ap0lSlw8P/bBMAHO1CmQKHSbJc3pdqYJsgDIDxab3ZQ7OxCoj/oP/Pz8ARQC3/SSsbm9tsq
 EMbaV/UoyawQpQLBb3ZGwD2pAAaew2hRyz7N1zSE+MAS/X9xy6+qrM8q6qeOIe4DrGel+lEfQ+s
 2dyMpvd4aLdwwjGFesEBQkGKGJzWHuQCm8Mq1LoM+7ZHtvLoQ+4yrBy7sA3LDKaVnwEKJUDjPRw
 pAwTfvSkXlrc6s4wBmmuyd9XqUefED6CX5TPdE5UXGPNoCeiWIGb8sGR3ikJ4eBFN5l517nUTj1
 qEUqETTsHaMOXEGYQG3fmxP6lUipPhQ0YRyns+9KrcxFgLGkly2WX8ooepVM4UynuS7gdbcM2yR
 DG0bea9CfLERBuHqlnw==
X-Authority-Analysis: v=2.4 cv=XLAAjwhE c=1 sm=1 tr=0 ts=6a6c5a81 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=m3zZTHMLHbwB7Lmtoed2:22 a=20KFwNOVAAAA:8
 a=iLNU1ar6AAAA:8 a=jZVsG21pAAAA:8 a=8rWy6zfcAAAA:8 a=i0EeH86SAAAA:8
 a=bt5KbKNvAAAA:8 a=XlRjxQ70AAAA:8 a=LfxEVeEBAAAA:8 a=qgO09VQOAAAA:8
 a=eSb-bNSJAAAA:8 a=ytFMdNZ7AAAA:8 a=6-dRa9qSAAAA:8 a=1YnqZlNiYyeQyt5Lj60A:9
 a=avxi3fN6y70A:10 a=gbU3OgOOxF9bX48Letew:22 a=3Sh2lD0sZASs_lUdrUhf:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=a-zEBD5cKgE7DNtTSb7C:22 a=1uMOUU2w0DxzEe95gQqD:22
 a=7k9nRlTqVbDGZ3p5_T00:22 a=r_vHcs92K7WWAI_28FKx:22 a=h7YW-pclpbZRD8svLbQ0:22
 a=oxySFUAvEW1-6AXleBSr:22 a=NZk92sZ4hQKp_Sw8PGvT:22
X-Proofpoint-GUID: GyAW5v9SQK0cdp8zYeHx4O1hJXRWdjHn
X-Proofpoint-ORIG-GUID: GyAW5v9SQK0cdp8zYeHx4O1hJXRWdjHn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1OSBTYWx0ZWRfXxZ+i++cK839M
 xIpQRBOB+9W7k8Fyz9M/v8H+BmyXimGY+R7guyq2/2IGZJWeT2jTUlXnPNybTv5ozJD1VPCDcx7
 edAIheXVWQCR2walC0wtGlV4gcEgveM=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310059
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




Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: David Marchand +ADw-david.marchand+AEA-redhat.com+AD4-
+AD4- Sent: Friday, July 31, 2026 12:28 AM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4-
+AD4- Cc: stephen+AEA-networkplumber.org+ADs- dev+AEA-dpdk.org+ADs-
+AD4- maxime.coquelin+AEA-redhat.com+ADs- fengchengwen+AEA-huawei.com+ADs-
+AD4- stable+AEA-dpdk.org+ADs- thomas+AEA-monjalon.net
+AD4- Subject: Re: +AFs-PATCH v2 1/1+AF0- vhost: tolerate file descriptor i=
n REM+AF8-MEM+AF8-REG
+AD4- msg
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- On Fri, 31 Jul 2026 at 09:08, Bathija, Pravin +ADw-Pravin.Bathija+AEA=
-dell.com+AD4- wrote:
+AD4- +AD4- Internal Use - Confidential
+AD4-
+AD4- It is not.
+AD4-
+AD4- +AD4- +AD4- -----Original Message-----
+AD4- +AD4- +AD4- From: David Marchand +ADw-david.marchand+AEA-redhat.com+A=
D4-
+AD4- +AD4- +AD4- Sent: Thursday, July 30, 2026 11:22 PM
+AD4- +AD4- +AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4A=
Ow-
+AD4- +AD4- +AD4- stephen+AEA-networkplumber.org
+AD4- +AD4- +AD4- Cc: dev+AEA-dpdk.org+ADs- maxime.coquelin+AEA-redhat.com+=
ADs-
+AD4- +AD4- +AD4- fengchengwen+AEA-huawei.com+ADs- stable+AEA-dpdk.org+ADs-=
 thomas+AEA-monjalon.net
+AD4- +AD4- +AD4- Subject: Re: +AFs-PATCH v2 1/1+AF0- vhost: tolerate file =
descriptor in
+AD4- +AD4- +AD4- REM+AF8-MEM+AF8-REG msg
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- On Fri, 31 Jul 2026 at 05:14, +ADw-pravin.bathija+AEA-del=
l.com+AD4- wrote:
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- From: Pravin M Bathija +ADw-pravin.bathija+AEA-dell=
.com+AD4-
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- The vhost-user specification (vhost-user.rst) state=
s that no file
+AD4- +AD4- +AD4- +AD4- descriptors SHOULD be passed with VHOST+AF8-USER+AF=
8-REM+AF8-MEM+AF8-REG.
+AD4- +AD4- +AD4- However, it
+AD4- +AD4- +AD4- +AD4- also says: +ACI-For compatibility with existing inc=
orrect
+AD4- +AD4- +AD4- +AD4- implementations, the back-end MAY accept messages w=
ith one file
+AD4- +AD4- +AD4- +AD4- descriptor.  If a file descriptor is passed, the ba=
ck-end MUST
+AD4- +AD4- +AD4- +AD4- close it without using it otherwise.+ACI-
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- Some front-ends, notably libblkio, reuse the same m=
essage-building
+AD4- +AD4- +AD4- +AD4- helper for both ADD+AF8-MEM+AF8-REG and REM+AF8-MEM=
+AF8-REG and unconditionally
+AD4- +AD4- +AD4- attach
+AD4- +AD4- +AD4- +AD4- the mapping fd.  The previous implementation reject=
ed any
+AD4- +AD4- +AD4- +AD4- REM+AF8-MEM+AF8-REG carrying a file descriptor with=
 the error:
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4-         expect 0 FDs for request VHOST+AF8-USER+AF8=
-REM+AF8-MEM+AF8-REG, received
+AD4- +AD4- +AD4- +AD4- 1
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- This broke teardown and memory region hot-swap with=
 these front-ends.
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- To reproduce, run any libblkio (v1.5.0) application=
 using the
+AD4- +AD4- +AD4- +AD4- virtio-blk-vhost-user driver against a DPDK vhost b=
ack-end.  The
+AD4- +AD4- +AD4- +AD4- connection is dropped during cleanup or whenever a =
memory region
+AD4- +AD4- +AD4- +AD4- is unmapped and remapped.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Is libblkio fixed now?
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- I am not a fan of such compatibility fix, having to accep=
t one buggy client...
+AD4- +AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- Yes, the libblkio fix is ready and will be submitted upstream w=
ithin a day or so.
+AD4- +AD4- It stops sending the fd with REM+AF8-MEM+AF8-REG.
+AD4- +AD4-
+AD4- +AD4- That said, this DPDK fix stands on its own regardless of libblk=
io. The
+AD4- +AD4- vhost-user specification explicitly anticipates this situation =
and requires back-
+AD4- ends to handle it:
+AD4- +AD4-
+AD4- +AD4- +ACI-For compatibility with existing incorrect implementations,=
 the
+AD4- +AD4- back-end MAY accept messages with one file descriptor. If a fil=
e
+AD4- +AD4- descriptor is passed, the back-end MUST close it without using =
it otherwise.+ACI-
+AD4-
+AD4- Well, yes, I understand the specification was updated or written for =
a buggy
+AD4- client :-)
+AD4-
Understood +2D3eCg-. but the clause is in the spec nonetheless, and other i=
mplementations follow it.

+AD4-
+AD4- +AD4- While the immediate motivation was libblkio, the spec's compati=
bility
+AD4- +AD4- clause was written for exactly this situation +IBQ- any front-e=
nd could
+AD4- +AD4- make the same mistake. QEMU's libvhost-user reference implement=
ation
+AD4- already tolerates it (see vu+AF8-rem+AF8-mem+AF8-reg).
+AD4-
+AD4- Which does not change that I dislike such compat.

I couldn't agree with you more.  The libblkio fix is ready and will stop se=
nding the fd.
In an ideal world we'd fix libblkio and move on,  but there are already sev=
eral released versions
of libblkio in the wild that exhibit this behavior.  Users pairing those wi=
th a current DPDK will hit
a broken connection with no obvious workaround.

+AD4-
+AD4-
+AD4- +AD4- The fix is 2 lines with no downside: accept the message, close =
the fd.
+AD4- +AD4- Rejecting it drops the connection entirely, which is a dispropo=
rtionate
+AD4- response to a harmless extra fd.
+AD4-
+AD4- Leaving behind a +ACI-harmless extra fd+ACI- causes exhaustion of a p=
rocess FD.
+AD4- At least, CVE-2019-14818 and CVE-2020-10726 come to mind.
+AD4-
+AD4- So strictly speaking, rejecting is really not disproportionate.

The patch does not leave the fd behind +IBQ- close+AF8-msg+AF8-fds(ctx) clo=
ses it immediately. More
importantly, the fd is already received by the process once recvmsg() deliv=
ers it. The current
code rejects the message and drops the connection, but the fd has already b=
een transferred
into the process's fd table at that point. Without closing it explicitly, r=
ejecting actually
causes the leak those CVEs warn about. This patch prevents that.

+AD4-
+AD4-
+AD4- For now, drop the wrong RN update.
+AD4-

Thank you. Done in V3

+AD4-
+AD4- --
+AD4- David Marchand

