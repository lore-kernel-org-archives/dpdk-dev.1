Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D3EC7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 15:15:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8316A40A70;
	Tue, 24 Jun 2025 17:15:44 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id 89FE34026B
 for <dev@dpdk.org>; Tue, 24 Jun 2025 17:15:43 +0200 (CEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O8wjMX021903;
 Tue, 24 Jun 2025 15:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=w3VTQ+poNeKOgWN8B4zQa3Nd
 CO6z/0UX3c3y+gS4aLA=; b=N+nuXDAg/xP4FGqidMXWq/404Hmk6CjCji6UpGwJ
 jwVnCeoHV1f4TmA25m/Uokh6ZhjHiGafP19Xe45wSm6dQpztZqRI9tlCtayf2e5T
 gByWC80h7XIUlTW4XTZChB66i3i8taJAXZ3YAWbcyG6/fidIHT1HffmTfQZadUSx
 tsinr12M8/kWnRKWmcgdheSPf5Ab497ajiN29heY9tNFibHOJDGC3iLqUTF+/BRS
 Op9kg4WdHCqVjrgeAxu1S0Gc92tPt7TfgQljpoUIqxt6wKvskCQz6a11r3oNIU+K
 Ru/R8aHdHBkIeQSmEJfPgyjWgVCDOgyXvwFs9I88pcAZxA==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bgcm6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 15:15:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJ6zUOXcKhXNV35O7L+BafCEYQQSbgxm+2QIN38BRqDpSJJD8eJc9QNLbi4kdFFdv9DvWyiTL0YAxj8+EHCMjfMjZrkYpQrPgKh93Tb07lswIY4Bjy2GWPyt3ifBg3HjGrtfCnd+JkBEGpMlYJKjP0aesjSWrmpZvdfz6ptrJIh9NAziexz1yDHymBXj+s6TtBzBPKKMY84j79zl+DOw+UrQx72duKASwu5cX1cAZKyBdxPUBYhqWTiLT6psNBxsI7TGQ+GwxuJSsXyzXYfzldDRCFLb8oEpiEpp7n09pGxJfWjtHJlo2xtbhV+yIExNi6ywiUc2KFueDdrYXM8InQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3VTQ+poNeKOgWN8B4zQa3NdCO6z/0UX3c3y+gS4aLA=;
 b=IrX1zS5D8Kg2sIXZb0vVeJfVQZyJkMEWQwFcUJ6/R3CZ/BM147xhPd61GMSZKCoHJQ06LVQsFd44YFrUW+oVmGIbA4OY6HlEY0ETqkdDFkGuLTqEhgyl7R9tESWiG8t5TIgKgyWdjKY8iFkJecx0LEdtOd85TcODxMwXPGxt67ZoiIjyEragWuP5D1mQ2kUS9wcqGCvsdZ4yzVwwEaYffU+Ey6yzz1oC42bIN8BlL/g4pjR1OO5y6RnT48UcMTHDO1Dk71Ncl9F2rSAaEGdTF5uZRKBjNrVz3jbCJ1hwWO0Ro5L9cRc2wjpqrVflm9p7viF4NWTTAIbp62XnkpQJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM8PR02MB8171.namprd02.prod.outlook.com (2603:10b6:8:1c::6) by
 BN0PR02MB7920.namprd02.prod.outlook.com (2603:10b6:408:165::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 15:15:33 +0000
Received: from DM8PR02MB8171.namprd02.prod.outlook.com
 ([fe80::949f:ad63:50e3:e830]) by DM8PR02MB8171.namprd02.prod.outlook.com
 ([fe80::949f:ad63:50e3:e830%2]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 15:15:32 +0000
From: Dylan Schneider <schneide@qti.qualcomm.com>
To: "dev@dpdk.org" <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface
 block
Thread-Topic: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Thread-Index: AQHb1y1EXfgSn9oKJ0KB1C7sKMwlUbQF53E4gAyfigg=
Date: Tue, 24 Jun 2025 15:15:32 +0000
Message-ID: <DM8PR02MB8171B1AA60CEB8C0D4B2B3E9E978A@DM8PR02MB8171.namprd02.prod.outlook.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <20250606215208.389096-1-schneide@qti.qualcomm.com>
 <DM8PR02MB8171B66D67908BBC34433C9FE970A@DM8PR02MB8171.namprd02.prod.outlook.com>
In-Reply-To: <DM8PR02MB8171B66D67908BBC34433C9FE970A@DM8PR02MB8171.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8171:EE_|BN0PR02MB7920:EE_
x-ms-office365-filtering-correlation-id: f9e90170-2585-4e0d-0b33-08ddb331f69e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?pa0EugQrqz/3E5kF99Cih1i+Ufjr3EmAGZ06GsYjxSpSH3iv/CORGqhlBYPs?=
 =?us-ascii?Q?4+K17QNykq7h/eePxqqBDOmNuYFcQngu4KBaqln3CWeQqE3Cre0s+/E6xYUi?=
 =?us-ascii?Q?mTtODdLsjZHPD6YvKFKU7DoZg61EkXVDbJ7ikg0BnPsvktnFbOyzIGINX6h1?=
 =?us-ascii?Q?l/z58bjlRfoHNiOzyEFsj2HGmpK3DgEW/SlqQlH8DCxwT7riqn5et75JqtjQ?=
 =?us-ascii?Q?Z6tCateKs7Ap0rH2U9++NwTsli0Q76GaDEWpD9SlyquPOBtQsS7/cvgscRqz?=
 =?us-ascii?Q?F92GtHHfK+NCSz5oBrqTK/srH95Npcs6Gk0+Fm2PwfQoDAee6mAWrPOuzM6m?=
 =?us-ascii?Q?IycA/f8ZdZtolSrtHEitNDZeih2ItjPdBAleW1lZ6IYEcyZSMziIRb9rQhKy?=
 =?us-ascii?Q?jfcxjEEgj29y84v2AclqxCNhCbSTUBa4GZju7FVlDDH9Z2WAUlEI0LQXEnnT?=
 =?us-ascii?Q?neJAPJn48EwSfserg/q+f6ksdDTF6KoX5rU+00YZNV3wU6kAmH2Jca8TsyyP?=
 =?us-ascii?Q?kvoCc1lnFxm8a74qZGTYDdy26PgyjZ4SqOtaeUFoj4BVLY+R3oZmzrbRRY/l?=
 =?us-ascii?Q?sAiF8xqouADd5ujdrXuxucqJCh6dBoQB5vP16rctjp0fd5RxUm0hOMUdq5PK?=
 =?us-ascii?Q?UJ6LISG8fVUbUFWhuYrCtFA75Pm5oxUcQi6t3qUVIfk69R2+izP/Ma9QoC5D?=
 =?us-ascii?Q?HnMBUSo7YJ00kGs+eWkReOcdYcUnvzJ3ROat4rL8rYoJpeyHuOqPmv2uQ/er?=
 =?us-ascii?Q?UJsjMcG7a3R4XwUrMLiHZWAzbmUVaTsjAOkgZqyT+JpBt1wqPEPiyRXGlLdC?=
 =?us-ascii?Q?1jcpKKO73pVUP/XcbIsfWTuC84HCWKNFu0+lKblE1NMfGPGAgS9MNtWg94Ai?=
 =?us-ascii?Q?f69hG88MgRRtT9Hhg2vcq1Ry/tBu9hzyN5udFDX9IS1jobz6N0CDMWFmsXuk?=
 =?us-ascii?Q?5EgvtHkObghfGSKX2NJ3rtI8fJ8euQjDtjt3kBGRDu6/MpRzEwAV38A7CDEy?=
 =?us-ascii?Q?6PSh+WcjZ5iWJcqWn41QP1Ogd/1bNdPyyTRVVHskfq2znIJOU1YIM0H7PKKo?=
 =?us-ascii?Q?tXGKYFOPFsCKgbPHSgilx4qLvGJASnEQKXQbz9vWyo6xAPAt5ux8AcJpwTMC?=
 =?us-ascii?Q?enooxRLxqxF7/oanqA2YGX/nmUopM5yk1gTPnMMw4Q9/gk0Xapxn90l0jlL3?=
 =?us-ascii?Q?1CJRYHdqXmQv7pcqacY1JqE+Ub+soR5lN8fQTDqGZdsJgQJivdwauQpeS+AL?=
 =?us-ascii?Q?H9WYeYUHTOam3gSTJH2bP0WaJRTVRRyMpKZKpv9VeEPEdpJNFpwVXi91/uD+?=
 =?us-ascii?Q?8c0lJh+4PsNILAv/olxKwp70efoWuIFBFCO38xuddpmqJhsZJ/hVaNCeIubv?=
 =?us-ascii?Q?rXjoFw2NvnmJuKV8nNnu8YHURAvYMWJw7q84VYudReMeX8BVnO6TAhNryI/q?=
 =?us-ascii?Q?+ILQgVtcXJZhCBRDvW/G3N+smkKa/bXXd/YyVT0DyDjstoqOF+2CH+5KeYVP?=
 =?us-ascii?Q?YVfa9o26s6uKjUA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8171.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SnN1nK5H0fIPC/MdeKFqrAs3dFqASzdTuCDKAdgG4y6If4o/l4y1L8YEc+Ox?=
 =?us-ascii?Q?m9s/mbYfjYrQjhmpcMTQ1d+bWMVoxsVT8YjxY5OmNYkHy2WQgPl1Jmkxs86B?=
 =?us-ascii?Q?uEUJSi9VM3cU3e5mk+RvvUVyj/VxwqpFPt563VJq48c4vqFNTAfq4VEpp7UU?=
 =?us-ascii?Q?xuJGAh0WxUuguS7SwsBKMDEQFg0isJduUJE0kCB8y9NWCRB2yknBa42yktp7?=
 =?us-ascii?Q?DEEd9ly85SLpjlRGkxTK+P+j9xlHo9E7oMm/dc0n0U6+0lkLwjE2gHjCqJnZ?=
 =?us-ascii?Q?MaJGaGLQa01Nc1/MhPG8i8T+0IRGo1OEcPyVQQVTkt5DsGan+2FtKgB/QaAN?=
 =?us-ascii?Q?GyIRtZKHnac5HZ/qY0k1edvHNQRbYoRIHTzUAfrJVBr5UXCS9GgshvJqC4nI?=
 =?us-ascii?Q?HBK14bUx82Yqzz3cpMFNeDJ6uPxpx3kzYtYXSiLNk7EonMC738N4rhw2mQS9?=
 =?us-ascii?Q?Jdgfk+esw09R6wFJbKERBQUDtWtdMw07u9dKzQoVBtHYXgM7YEXlE0u96aWn?=
 =?us-ascii?Q?2f4fJXiw+AkK0nOs4SYHmgR+svgF57gXoOljaY4RqcdJW+GgweqbocbreVFj?=
 =?us-ascii?Q?mL9eW2K8bmeJAw7SB8/yLl9apRN7ucbY3EiYi7tRrfRusXVew84L9YRvxYJz?=
 =?us-ascii?Q?P6PI1ZkZW1Iy4O4T1E6sZjhF+xfyCdvbIsL10eZgf1Cfin7KPit2re3KQBud?=
 =?us-ascii?Q?7qDvvJg/dMgcz+UVS2O7gknZ9B/ncVgLcdkfWR+ZGq9nnpDKBUn/sL8y1XqM?=
 =?us-ascii?Q?RNspZ8Sg7/g7e2Ni8J6gY4r9YWcm9i2hejqT04SnVNwNeIeOT5eA0bp2T72O?=
 =?us-ascii?Q?LRpUYtvSPA+p/AAs1aeVGZuoOE8KuXlBISdriJUtyvn8Wat6BSAT4/Ujb5r/?=
 =?us-ascii?Q?fPJGFgNcUVIUqRfAMhedC3WoO9jx5f6n8Kt+Vq7c2Mt5IXbo3uW6U7EKEaeX?=
 =?us-ascii?Q?h5kHBjhLZY9qvIKeUWR4nh0mBtrCmD1YhxRSLQEViX+Wx12SkK08R7d2bDct?=
 =?us-ascii?Q?mmF2X85OunEyDsNZUp1EOZBuytYSoN7VqbVK47FncMJoWwzz8gQmTjrXyRY6?=
 =?us-ascii?Q?DxsaFoLorxBxhjZifndqc+Bp6nna+MC1L1ctW3RpXZIZiHI6U0xOw2MMMdmF?=
 =?us-ascii?Q?NNawcYmhmkp4Q3SoEEefN5lZOag8Z/h7bV9ZD1wfLLB7r8XNaPfSKRZatiwt?=
 =?us-ascii?Q?+3DYtIGdXxQGHiYO77BjEluyiGx4IqzIpIdEyOZEoGysMr2g5yvCtlpzEYOz?=
 =?us-ascii?Q?yz8GIpVGAVuzPQo/VtzZ7BQOf5yQgc7iOBYgf4vVSk8cdmf4/+nyiUPClrL7?=
 =?us-ascii?Q?lTvidizIdjIPnTkX8fmRkFf2Ran9GVIg7JnCbHghPptc4KkPo5yP8cE5gkhz?=
 =?us-ascii?Q?+aP53hzkgdcYpuG/beqQAkHS3HrHgn8IaCsbAwDqX7iqehg5EMrUsDVwA+Gz?=
 =?us-ascii?Q?WByrHIapozFy2VX9cHORpCqXxUk3GrO0XrCMg4PZWg9x1u1pjFKxao+mZ0SL?=
 =?us-ascii?Q?rmP3TAbvhXfK/nkBMCy5+SF719NH5bw/7imTdYbDrquLVJp5NT4mNtpLSCyS?=
 =?us-ascii?Q?sTvMD4hng0TWCD120nYiEtisLZsIjID0OrysnWkc?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR02MB8171B1AA60CEB8C0D4B2B3E9E978ADM8PR02MB8171namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D2Vwg3IvUX9ORADctCqINUveeyLucaaAVzaaiT/GN+OcUngEMf5rQPa9EkeQMYANa8ZzHB6X9A6md5bJ1XEWmvMsOzfaUYYulU+zaQt+wdyGIJ9GPZLbAlEo1f+8stOcifGl0ObIrBukd7WJUwH4cUIwlJwZxW4JF8DZMWYTbYspndcI8oYOlzNJ2Y6NiOC0uZ7Lzq+TpSw1t5cvCemNN0Ts9baqNnDd4qkj+W2ZL2Wd13Z2ZOKZC1FIQXnMCkyUgOSjx6CGnM4jH0iDovKXtWzoFxuU3IXKgxu3rDFWRu2fkaZQEUCncrFP7559zS5HGAE75tHVUgBDTF4FBDQnNfuginDOLw5j7TBmfdjhli0MHf1hluuLv8sB5us4CAf8f4lBgjawlpYE6BsFb+N/aM95LmdIxZiX9tX3XOQDdYjVO2LfF/dtkdRZByg1yvE9vpvOKE/7oLlHowCDJ6JlSlviI3YSnEkcsNtn3bVAz4GJZNmFfcxKctjO6CgtQl6UnEB7epK3ZFmbXWa9ADoYYzXKSeB98zQzxxuwJwBc65SyElhkDBGx0pGrPb3gGum+Ze8+qpG6BwBF60GuIzI1XfIZXyv4tTVNKRRr8KteMPoCHgD9auNV32RSiUlcHnNd
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8171.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e90170-2585-4e0d-0b33-08ddb331f69e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 15:15:32.8144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: upcHzDgmCp6VbTuSTWE0Sa/Kwr535zmXOSGPgGNCLKQampgPMlurzfBTcDKUzBYZ49QY/nv22EWHT7LZqiQobByLPQc/g3TrmGejR3PbgEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7920
X-Proofpoint-ORIG-GUID: HWze7GOS8gSqVZCAu7kbgrh8892NHu3c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEyOCBTYWx0ZWRfX4KdwmfUSpN46
 J1UWnezO+VJANlAR1+oe/zWIBFvNJKwCe0Q6fkBLPyNZkBtvDK/lpoza7/yxv6qTrJUrMOANdDK
 Tu6rKN6Oo38saOSnljkCYbULDUHEb8EyMHqaEFEQDWekCm/sWwXTdICZC/ioPahBxFrKEq1u4H0
 eYHe1sCWRvorWeJQOBOooSvOVJDc3AANq3v+x5wNzqXgrwZ8BAMSUkM2IcqOiKJSjotQ2t8jqTk
 AR3DrCplZuvZ/CJkEAg/Ql2ekiXUb6hCUPxlL4CUMSKBNqCrM2CClneY9kKBTYBB76ejsMDlVL6
 2Ysvh6BUCb6Krp750xkM64ddRIVB5hX9RHi5/8eUBhCAw2NfbhRCnj498S4efw74Yb3n507qdQI
 RG/+VuHcZ6tG+fhl+phKvH9OeOISYjYzjGPkR8INRFUfHlwYvP8PMVC7Al3ZWUk2P0qgUuLq
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685ac119 cx=c_pps
 a=BUR/PSeFfUFfX8a0VQYRdg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=8rWy6zfcAAAA:8
 a=bt5KbKNvAAAA:8 a=QyXUC8HyAAAA:8 a=jZVsG21pAAAA:8 a=M5GUcnROAAAA:8
 a=Byx-y9mGAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=GRf2JX_IAAAA:8
 a=VYDjIKVHAAAA:8 a=_gsV02HDAAAA:8 a=eh1Yez-EAAAA:8 a=639UslnWXDo2Z4EPGTYA:9
 a=CjuIK1q_8ugA:10 a=K_4ya2Z9wl7Qp1vangIA:9 a=WXXq_Eih8jTM1BO-:21
 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=a-zEBD5cKgE7DNtTSb7C:22 a=3Sh2lD0sZASs_lUdrUhf:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=uRw8vnb707Rr89TYUhP5:22 a=-sS9_DeNG7cEylvMdImQ:22 a=GzKgaEE0kT068tgm3IUS:22
X-Proofpoint-GUID: HWze7GOS8gSqVZCAu7kbgrh8892NHu3c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240128
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

--_000_DM8PR02MB8171B1AA60CEB8C0D4B2B3E9E978ADM8PR02MB8171namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey Stephen, I saw the comment you made to re-run UTs but I cant distinguis=
h if anything actually happened, the report still says everything is passin=
g.
________________________________
From: Dylan Schneider <schneide@qti.qualcomm.com>
Sent: Monday, June 16, 2025 8:29 AM
To: dev@dpdk.org <dev@dpdk.org>; Thomas Monjalon <thomas@monjalon.net>; Res=
hma Pattan <reshma.pattan@intel.com>; Stephen Hemminger <stephen@networkplu=
mber.org>; Jerin Jacob <jerinj@marvell.com>; Kiran Kumar K <kirankumark@mar=
vell.com>; Nithin Dabilpuram <ndabilpuram@marvell.com>; Zhirun Yan <yanzhir=
un_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interf=
ace block


WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

Hello Stephen and Thomas,
I uploaded this patch which says it has UT failures, but upon closer inspec=
tion, there aren't any signs of any tests failing. Can you please take a lo=
ok?
________________________________
From: Schneide <schneide@qti.qualcomm.com>
Sent: Friday, June 6, 2025 3:52 PM
To: dev@dpdk.org <dev@dpdk.org>; Thomas Monjalon <thomas@monjalon.net>; Res=
hma Pattan <reshma.pattan@intel.com>; Stephen Hemminger <stephen@networkplu=
mber.org>; Jerin Jacob <jerinj@marvell.com>; Kiran Kumar K <kirankumark@mar=
vell.com>; Nithin Dabilpuram <ndabilpuram@marvell.com>; Zhirun Yan <yanzhir=
un_163@163.com>
Cc: Dylan Schneider <schneide@qti.qualcomm.com>
Subject: [PATCH v2] pcapng: allow any protocol link type for the interface =
block

From: Dylan Schneider <schneide@qti.qualcomm.com>

Allow the user to specify protocol link type when creating pcapng files.
This change is needed to specify the protocol type in the pcapng file,
DLT_EN10MB specifies ethernet packets only. This will allow dissectors
for other protocols to be used on files generated by pcapng.

Includes a breaking change to rte_pcapng_add_interface to add link_type
parameter. Existing calls to the function have been updated to pass
DLT_EN10MB for the link type argument.

Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
Cc: stephen@networkplumber.org
---
 .mailmap                               |  1 +
 app/dumpcap/main.c                     |  4 ++--
 app/test/test_pcapng.c                 |  8 ++++----
 doc/guides/rel_notes/release_25_07.rst |  5 ++++-
 lib/graph/graph_pcap.c                 |  4 +++-
 lib/pcapng/meson.build                 |  2 ++
 lib/pcapng/rte_pcapng.c                | 21 +++++++++++++++------
 lib/pcapng/rte_pcapng.h                |  4 +++-
 8 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/.mailmap b/.mailmap
index 91e08f4a1f..a585124832 100644
--- a/.mailmap
+++ b/.mailmap
@@ -390,6 +390,7 @@ Dukai Yuan <dukaix.yuan@intel.com>
 Dumitru Ceara <dceara@redhat.com> <dumitru.ceara@gmail.com>
 Duncan Bellamy <dunk@denkimushi.com>
 Dustin Lundquist <dustin@null-ptr.net>
+Dylan Schneider <schneide@qti.qualcomm.com>
 Dzmitry Sautsa <dzmitryx.sautsa@intel.com>
 Ed Czeck <ed.czeck@atomicrules.com>
 Eduard Serra <eserra@vmware.com>
diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3d3c0dbc66..e0e2b26269 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -800,8 +800,8 @@ static dumpcap_out_t create_output(void)
                 free(os);

                 TAILQ_FOREACH(intf, &interfaces, next) {
-                       if (rte_pcapng_add_interface(ret.pcapng, intf->port=
, intf->ifname,
-                                                    intf->ifdescr, intf->o=
pts.filter) < 0)
+                       if (rte_pcapng_add_interface(ret.pcapng, intf->port=
, DLT_EN10MB,
+                               intf->ifname, intf->ifdescr, intf->opts.fil=
ter) < 0)
                                 rte_exit(EXIT_FAILURE, "rte_pcapng_add_int=
erface %u failed\n",
                                         intf->port);
                 }
diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index 8f2cff36c3..bcf99724fa 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -345,7 +345,7 @@ test_add_interface(void)
         }

         /* Add interface to the file */
-       ret =3D rte_pcapng_add_interface(pcapng, port_id,
+       ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
                                        NULL, NULL, NULL);
         if (ret < 0) {
                 fprintf(stderr, "can not add port %u\n", port_id);
@@ -353,7 +353,7 @@ test_add_interface(void)
         }

         /* Add interface with ifname and ifdescr */
-       ret =3D rte_pcapng_add_interface(pcapng, port_id,
+       ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
                                        "myeth", "Some long description", N=
ULL);
         if (ret < 0) {
                 fprintf(stderr, "can not add port %u with ifname\n", port_=
id);
@@ -361,7 +361,7 @@ test_add_interface(void)
         }

         /* Add interface with filter */
-       ret =3D rte_pcapng_add_interface(pcapng, port_id,
+       ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
                                        NULL, NULL, "tcp port 8080");
         if (ret < 0) {
                 fprintf(stderr, "can not add port %u with filter\n", port_=
id);
@@ -406,7 +406,7 @@ test_write_packets(void)
         }

         /* Add interface to the file */
-       ret =3D rte_pcapng_add_interface(pcapng, port_id,
+       ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
                                        NULL, NULL, NULL);
         if (ret < 0) {
                 fprintf(stderr, "can not add port %u\n", port_id);
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/=
release_25_07.rst
index 6b070801de..2396c7b014 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -108,7 +108,10 @@ API Changes
    This section is a comment. Do not overwrite or remove it.
    Also, make sure to start the actual text at the margin.
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
-
+* pcapng: Changed the API for adding interfaces to include a link type arg=
ument.
+  The link type was previously hardcoded to the ethernet link type in the =
API.
+  This argument is added to ``rte_pcapng_add_interface``.
+  These functions are versioned to retain binary compatibility until the n=
ext LTS release.

 ABI Changes
 -----------
diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c
index 89525f1220..13d86b7a18 100644
--- a/lib/graph/graph_pcap.c
+++ b/lib/graph/graph_pcap.c
@@ -11,6 +11,8 @@
 #include <rte_mbuf.h>
 #include <rte_pcapng.h>

+#include <pcap/pcap.h>
+
 #include "rte_graph_worker.h"

 #include "graph_pcap_private.h"
@@ -117,7 +119,7 @@ graph_pcap_file_open(const char *filename)

         /* Add the configured interfaces as possible capture ports */
         RTE_ETH_FOREACH_DEV(portid) {
-               ret =3D rte_pcapng_add_interface(pcapng_fd, portid,
+               ret =3D rte_pcapng_add_interface(pcapng_fd, portid, DLT_EN1=
0MB,
                                                NULL, NULL, NULL);
                 if (ret < 0) {
                         graph_err("Graph rte_pcapng_add_interface port %u =
failed: %d",
diff --git a/lib/pcapng/meson.build b/lib/pcapng/meson.build
index 4549925d41..3aa7ba5155 100644
--- a/lib/pcapng/meson.build
+++ b/lib/pcapng/meson.build
@@ -5,3 +5,5 @@ sources =3D files('rte_pcapng.c')
 headers =3D files('rte_pcapng.h')

 deps +=3D ['ethdev']
+
+use_function_versioning =3D true
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index cacbefdc50..f18af25983 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -200,11 +200,10 @@ pcapng_section_block(rte_pcapng_t *self,
 }

 /* Write an interface block for a DPDK port */
-RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)
-int
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
-                        const char *ifname, const char *ifdescr,
-                        const char *filter)
+RTE_DEFAULT_SYMBOL(26, int, rte_pcapng_add_interface,
+                       (rte_pcapng_t *self, uint16_t port, uint16_t link_t=
ype,
+                       const char *ifname, const char *ifdescr,
+                       const char *filter))
 {
         struct pcapng_interface_block *hdr;
         struct rte_eth_dev_info dev_info;
@@ -274,7 +273,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t p=
ort,
         hdr =3D (struct pcapng_interface_block *)buf;
         *hdr =3D (struct pcapng_interface_block) {
                 .block_type =3D PCAPNG_INTERFACE_BLOCK,
-               .link_type =3D 1,         /* DLT_EN10MB - Ethernet */
+               .link_type =3D link_type,
                 .block_length =3D len,
         };

@@ -319,6 +318,16 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t =
port,
         return write(self->outfd, buf, len);
 }

+RTE_VERSION_SYMBOL(25, int, rte_pcapng_add_interface,
+                                 (rte_pcapng_t *self, uint16_t port,
+                                  const char *ifname, const char *ifdescr,
+                                  const char *filter))
+{
+       /* Call the new version with a default link_type (Ethernet) */
+       return rte_pcapng_add_interface(self, port, DLT_EN10MB,
+                                                                       ifn=
ame, ifdescr, filter);
+}
+
 /*
  * Write an Interface statistics block at the end of capture.
  */
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index 48f2b57564..9880d415c4 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -71,6 +71,8 @@ rte_pcapng_close(rte_pcapng_t *self);
  *  The handle to the packet capture file
  * @param port
  *  The Ethernet port to report stats on.
+ * @param link_type
+ *   The link type (e.g., DLT_EN10MB).
  * @param ifname (optional)
  *  Interface name to record in the file.
  *  If not specified, name will be constructed from port
@@ -84,7 +86,7 @@ rte_pcapng_close(rte_pcapng_t *self);
  * must be added.
  */
 int
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
+rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_=
type,
                          const char *ifname, const char *ifdescr,
                          const char *filter);

--
2.27.0


--_000_DM8PR02MB8171B1AA60CEB8C0D4B2B3E9E978ADM8PR02MB8171namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hey Stephen, I saw the comment you made to re-run UTs but I cant distinguis=
h if anything actually happened, the report still says everything is passin=
g.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dylan Schneider &lt;s=
chneide@qti.qualcomm.com&gt;<br>
<b>Sent:</b> Monday, June 16, 2025 8:29 AM<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Thomas Monjalon &lt;thomas@mo=
njalon.net&gt;; Reshma Pattan &lt;reshma.pattan@intel.com&gt;; Stephen Hemm=
inger &lt;stephen@networkplumber.org&gt;; Jerin Jacob &lt;jerinj@marvell.co=
m&gt;; Kiran Kumar K &lt;kirankumark@marvell.com&gt;; Nithin Dabilpuram
 &lt;ndabilpuram@marvell.com&gt;; Zhirun Yan &lt;yanzhirun_163@163.com&gt;<=
br>
<b>Subject:</b> Re: [PATCH v2] pcapng: allow any protocol link type for the=
 interface block</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p style=3D"text-align:center"><span style=3D"background-color:#ffff00; fon=
t-size:14px; font-family:sans-serif; color:#000000"><strong>WARNING:</stron=
g> This email originated from outside of Qualcomm. Please be wary of any li=
nks or attachments, and do not enable
 macros.</span></p>
<div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
Hello Stephen and Thomas,</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
I uploaded this patch which says it has UT failures, but upon closer inspec=
tion, there aren't any signs of any tests failing. Can you please take a lo=
ok?&nbsp;</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Schneide &lt;schnei=
de@qti.qualcomm.com&gt;<br>
<b>Sent:</b> Friday, June 6, 2025 3:52 PM<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Thomas Monjalon &lt;thomas@mo=
njalon.net&gt;; Reshma Pattan &lt;reshma.pattan@intel.com&gt;; Stephen Hemm=
inger &lt;stephen@networkplumber.org&gt;; Jerin Jacob &lt;jerinj@marvell.co=
m&gt;; Kiran Kumar K &lt;kirankumark@marvell.com&gt;; Nithin Dabilpuram
 &lt;ndabilpuram@marvell.com&gt;; Zhirun Yan &lt;yanzhirun_163@163.com&gt;<=
br>
<b>Cc:</b> Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
<b>Subject:</b> [PATCH v2] pcapng: allow any protocol link type for the int=
erface block</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">From: Dylan Schneider &lt;schneide@qti.qualcomm.=
com&gt;<br>
<br>
Allow the user to specify protocol link type when creating pcapng files.<br=
>
This change is needed to specify the protocol type in the pcapng file,<br>
DLT_EN10MB specifies ethernet packets only. This will allow dissectors<br>
for other protocols to be used on files generated by pcapng.<br>
<br>
Includes a breaking change to rte_pcapng_add_interface to add link_type<br>
parameter. Existing calls to the function have been updated to pass<br>
DLT_EN10MB for the link type argument.<br>
<br>
Fixes: d1da6d0d04c7 (&quot;pcapng: require per-interface information&quot;)=
<br>
Signed-off-by: Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
Cc: stephen@networkplumber.org<br>
---<br>
&nbsp;.mailmap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;app/dumpcap/main.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 4 ++--<br>
&nbsp;app/test/test_pcapng.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8 ++++----<br>
&nbsp;doc/guides/rel_notes/release_25_07.rst |&nbsp; 5 ++++-<br>
&nbsp;lib/graph/graph_pcap.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +++-<br>
&nbsp;lib/pcapng/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 ++<br>
&nbsp;lib/pcapng/rte_pcapng.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 21 +++++++++++++++------<br>
&nbsp;lib/pcapng/rte_pcapng.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +++-<br>
&nbsp;8 files changed, 34 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index 91e08f4a1f..a585124832 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -390,6 +390,7 @@ Dukai Yuan &lt;dukaix.yuan@intel.com&gt;<br>
&nbsp;Dumitru Ceara &lt;dceara@redhat.com&gt; &lt;dumitru.ceara@gmail.com&g=
t;<br>
&nbsp;Duncan Bellamy &lt;dunk@denkimushi.com&gt;<br>
&nbsp;Dustin Lundquist &lt;dustin@null-ptr.net&gt;<br>
+Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
&nbsp;Dzmitry Sautsa &lt;dzmitryx.sautsa@intel.com&gt;<br>
&nbsp;Ed Czeck &lt;ed.czeck@atomicrules.com&gt;<br>
&nbsp;Eduard Serra &lt;eserra@vmware.com&gt;<br>
diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c<br>
index 3d3c0dbc66..e0e2b26269 100644<br>
--- a/app/dumpcap/main.c<br>
+++ b/app/dumpcap/main.c<br>
@@ -800,8 +800,8 @@ static dumpcap_out_t create_output(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; free(os);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; TAILQ_FOREACH(intf, &amp;interfaces, next) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rte_pcapng_a=
dd_interface(ret.pcapng, intf-&gt;port, intf-&gt;ifname,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; intf-&gt;ifdescr, intf-&gt;opts.filter) &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rte_pcapng_a=
dd_interface(ret.pcapng, intf-&gt;port, DLT_EN10MB,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; intf-&gt;ifname, intf-&gt;ifdescr, intf-&gt=
;opts.filter) &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_exit(EXIT_FAILURE, &quot;rte=
_pcapng_add_interface %u failed\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; intf-&gt;port);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c<br>
index 8f2cff36c3..bcf99724fa 100644<br>
--- a/app/test/test_pcapng.c<br>
+++ b/app/test/test_pcapng.c<br>
@@ -345,7 +345,7 @@ test_add_interface(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add interface to the fi=
le */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id, DLT_EN10MB,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; NULL, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;can not add port %u\n&quot;, po=
rt_id);<br>
@@ -353,7 +353,7 @@ test_add_interface(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add interface with ifna=
me and ifdescr */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id, DLT_EN10MB,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &quot;myeth&quot;, &quot;Some long description&quot;, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;can not add port %u with ifname=
\n&quot;, port_id);<br>
@@ -361,7 +361,7 @@ test_add_interface(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add interface with filt=
er */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id, DLT_EN10MB,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; NULL, NULL, &quot;tcp port 8080&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;can not add port %u with filter=
\n&quot;, port_id);<br>
@@ -406,7 +406,7 @@ test_write_packets(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add interface to the fi=
le */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id, DLT_EN10MB,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; NULL, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;can not add port %u\n&quot;, po=
rt_id);<br>
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/=
release_25_07.rst<br>
index 6b070801de..2396c7b014 100644<br>
--- a/doc/guides/rel_notes/release_25_07.rst<br>
+++ b/doc/guides/rel_notes/release_25_07.rst<br>
@@ -108,7 +108,10 @@ API Changes<br>
&nbsp;&nbsp;&nbsp; This section is a comment. Do not overwrite or remove it=
.<br>
&nbsp;&nbsp;&nbsp; Also, make sure to start the actual text at the margin.<=
br>
&nbsp;&nbsp;&nbsp; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
+* pcapng: Changed the API for adding interfaces to include a link type arg=
ument.<br>
+&nbsp; The link type was previously hardcoded to the ethernet link type in=
 the API.<br>
+&nbsp; This argument is added to ``rte_pcapng_add_interface``.<br>
+&nbsp; These functions are versioned to retain binary compatibility until =
the next LTS release.<br>
&nbsp;<br>
&nbsp;ABI Changes<br>
&nbsp;-----------<br>
diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c<br>
index 89525f1220..13d86b7a18 100644<br>
--- a/lib/graph/graph_pcap.c<br>
+++ b/lib/graph/graph_pcap.c<br>
@@ -11,6 +11,8 @@<br>
&nbsp;#include &lt;rte_mbuf.h&gt;<br>
&nbsp;#include &lt;rte_pcapng.h&gt;<br>
&nbsp;<br>
+#include &lt;pcap/pcap.h&gt;<br>
+<br>
&nbsp;#include &quot;rte_graph_worker.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;graph_pcap_private.h&quot;<br>
@@ -117,7 +119,7 @@ graph_pcap_file_open(const char *filename)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add the configured inte=
rfaces as possible capture ports */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ETH_FOREACH_DEV(portid=
) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D rte_pcapng_add_interface(pcapng_fd, portid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D rte_pcapng_add_interface(pcapng_fd, portid, DLT_EN10MB,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL, NULL)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; graph=
_err(&quot;Graph rte_pcapng_add_interface port %u failed: %d&quot;,<br>
diff --git a/lib/pcapng/meson.build b/lib/pcapng/meson.build<br>
index 4549925d41..3aa7ba5155 100644<br>
--- a/lib/pcapng/meson.build<br>
+++ b/lib/pcapng/meson.build<br>
@@ -5,3 +5,5 @@ sources =3D files('rte_pcapng.c')<br>
&nbsp;headers =3D files('rte_pcapng.h')<br>
&nbsp;<br>
&nbsp;deps +=3D ['ethdev']<br>
+<br>
+use_function_versioning =3D true<br>
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c<br>
index cacbefdc50..f18af25983 100644<br>
--- a/lib/pcapng/rte_pcapng.c<br>
+++ b/lib/pcapng/rte_pcapng.c<br>
@@ -200,11 +200,10 @@ pcapng_section_block(rte_pcapng_t *self,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/* Write an interface block for a DPDK port */<br>
-RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)<br>
-int<br>
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char=
 *ifname, const char *ifdescr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char=
 *filter)<br>
+RTE_DEFAULT_SYMBOL(26, int, rte_pcapng_add_interface,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rte_pcapng_t *s=
elf, uint16_t port, uint16_t link_type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *ifna=
me, const char *ifdescr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *filt=
er))<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pcapng_interface_bl=
ock *hdr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_dev_info de=
v_info;<br>
@@ -274,7 +273,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t p=
ort,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr =3D (struct pcapng_int=
erface_block *)buf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *hdr =3D (struct pcapng_in=
terface_block) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .block_type =3D PCAPNG_INTERFACE_BLOCK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .link_type =3D 1,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* DLT_EN10MB - Ethernet */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .link_type =3D link_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .block_length =3D len,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;<br>
@@ -319,6 +318,16 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t =
port,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return write(self-&gt;outf=
d, buf, len);<br>
&nbsp;}<br>
&nbsp;<br>
+RTE_VERSION_SYMBOL(25, int, rte_pcapng_add_interface,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rte_pcapng_t *self, uint16_t p=
ort,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *ifname, const=
 char *ifdescr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *filter))<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Call the new version with a defaul=
t link_type (Ethernet) */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return rte_pcapng_add_interface(self,=
 port, DLT_EN10MB,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ifname, ifdescr, filter);<br=
>
+}<br>
+<br>
&nbsp;/*<br>
&nbsp; * Write an Interface statistics block at the end of capture.<br>
&nbsp; */<br>
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h<br>
index 48f2b57564..9880d415c4 100644<br>
--- a/lib/pcapng/rte_pcapng.h<br>
+++ b/lib/pcapng/rte_pcapng.h<br>
@@ -71,6 +71,8 @@ rte_pcapng_close(rte_pcapng_t *self);<br>
&nbsp; *&nbsp; The handle to the packet capture file<br>
&nbsp; * @param port<br>
&nbsp; *&nbsp; The Ethernet port to report stats on.<br>
+ * @param link_type<br>
+ *&nbsp;&nbsp; The link type (e.g., DLT_EN10MB).<br>
&nbsp; * @param ifname (optional)<br>
&nbsp; *&nbsp; Interface name to record in the file.<br>
&nbsp; *&nbsp; If not specified, name will be constructed from port<br>
@@ -84,7 +86,7 @@ rte_pcapng_close(rte_pcapng_t *self);<br>
&nbsp; * must be added.<br>
&nbsp; */<br>
&nbsp;int<br>
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,<br>
+rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_=
type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 const char *ifname, const char *ifdescr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 const char *filter);<br>
&nbsp;<br>
-- <br>
2.27.0<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_DM8PR02MB8171B1AA60CEB8C0D4B2B3E9E978ADM8PR02MB8171namp_--
