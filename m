Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BF8C71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 08:36:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B1B8402BC;
	Mon, 16 Jun 2025 10:36:31 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2285340292
 for <dev@dpdk.org>; Mon, 16 Jun 2025 10:36:30 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNVWAo028242;
 Mon, 16 Jun 2025 01:36:27 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2128.outbound.protection.outlook.com [40.107.220.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47a7w70tfn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 01:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ts3irq+i1RzsETqO0bEG8PJ65NyToeQNf6yjb3e1T9qY6mir0aSkfpQv961Yx+afMe90EZXIvDCbnYbsnigVRGQbTwP50ICtYQVRDSuPb9kHCDDNkUHB4q1HDWEFFHrz9leKLwzyzj5DAW2s3UUo62W/QhSO47+71hDY8CtcWTcP8cLanJo3lBIBri6BJuSrGl2Isodx28vlb7FOOTZFQyqC8aaCQuKKApkachBjPHSXaZrHFnkGL6gJx8wGL+o8eeelZNFs8rWFPo/uh/X1mhQ6Tqhcr6/n3fc/sukDf2FYTSbLe1Qya/E+mO33+I4z+JH8x/7UJa9AAwlGZ33PTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6LP1RFbx8AVcWGYUeueNdJ0KX2YRFDUPlzh7HV5Ud4=;
 b=CSMKW5VZ6nFjcwKCQrAm4VV6vaEG/9Fi6sbTylyT8prm4zryW9aJVcpj4usBM9BPqez2avnpW9+ZwPqQfj+PUoCoU4UM0yIL/U1PZYEIO7SWWxn/VR3mrbiL+hlQvE2w0HEjX8nLt3wKzCwqdMpBE6/NlieRpoA7+alqshJsiAxBjM21fifC/Ci4Z8O8CNdIykNsAV8gwiq2aR22Uj2sVLRMrdKAZnh8L/KsQ2JEeg5JdoBggLzFREDLIaET3HaTgOS2aoNqerxWZZAIU/lbnRORTUzAiqSmlL3LjhnV8koCDyOku2Z9oIDqX5HUN0sC+y/zZbivPg3bF/5HFl1o8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6LP1RFbx8AVcWGYUeueNdJ0KX2YRFDUPlzh7HV5Ud4=;
 b=rg+HLQDKpFLRCYPwiDwlaFFeQopIJJOORyZoJan+8PAhS0r0bLcJiHRXpkN3fPtqkhHFBcbtnQ1c3wAojoD1+xm8l2OjN6qOaAisIJlJcZoocsQxfziwY3ppQyMVFzxbEF2IF8J6MwQBR3QCCZ4iIeS+i9FOcUo1/Cyeo6wD8WU=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by MN2PR18MB3671.namprd18.prod.outlook.com (2603:10b6:208:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 16 Jun
 2025 08:36:23 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%6]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 08:36:23 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Sunil Kumar Kori <skori@marvell.com>, =?utf-8?B?TW9ydGVuIEJyw7hydXA=?=
 <mb@smartsharesystems.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: RE: [PATCH v2 2/2] ethdev: remove callback checks from fast path
Thread-Topic: [PATCH v2 2/2] ethdev: remove callback checks from fast path
Thread-Index: AQHbw0+l0RHSW4O8306bysHIPKBvWrPn4SoAgBQkLbCACab9cA==
Date: Mon, 16 Jun 2025 08:36:22 +0000
Message-ID: <CO6PR18MB3860D388FFE168A3ED50D5F4B470A@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250429181132.2544771-1-skori@marvell.com>
 <20250512150732.65743-1-skori@marvell.com>
 <20250512150732.65743-2-skori@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC9E@smartserver.smartshare.dk>
 <CO6PR18MB386002BE3B4FF5646A41404AB46AA@CO6PR18MB3860.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB386002BE3B4FF5646A41404AB46AA@CO6PR18MB3860.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|MN2PR18MB3671:EE_
x-ms-office365-filtering-correlation-id: eb3a280b-2f6a-41e6-ab5e-08ddacb0e018
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MFN2OXc0VHZCVUVnZElNR0d3dEsrNnBoWWdUYTBOeHlnWUk3bzFmVEpvbGwr?=
 =?utf-8?B?bFN2Q0tXYkI3Y0Y3SEZlb3hJOVk3bThCOFdoYlg3STByRU1FZE1xZnRlR01l?=
 =?utf-8?B?ZGJPWG5aK1JkTTZ1eCs5SDZEU2ZJY0dqeng3eFdsSTJzUlliOFZNSVZ5VE12?=
 =?utf-8?B?YmE2ZFFPdVk5NkJqclU2cXBEaEZPNG5WaXowZDZEdHNuTk53Yks2Tmh1N3JD?=
 =?utf-8?B?MXEwUXF5NStpbmNza2graXg1eFRMbTBOVDFOSzlhOEprcm0xVXhRS01LVjFW?=
 =?utf-8?B?VEw5Q2VPQ3U5QWU2c1ZRZmpSK1ZkNy9naFhmUldQR0c5VjF0RjRpUWdqajlB?=
 =?utf-8?B?TDhWeld0U0luM2NGU1hETkFZbFEzb0h3QSt1R251dk52eXRhL3VCNFQ0bEtP?=
 =?utf-8?B?bnFmWGNka1RNb3dWd2JERXdUSWp2dTNESmdIN0FCdldUSGNic1ZZQ3ltQXhS?=
 =?utf-8?B?engwVWQ1Q1FneTFKZzZTa2FWRTZGeFFoOWYzR1BHdWdIaU55M0xRcU5lT21M?=
 =?utf-8?B?YytyZ1llYnFWM0lCTlVLSGFxelVvNzJYWWFWSDlFTXpsdTZIdkg2d0h5elZO?=
 =?utf-8?B?amRtbVY2bXpndTI2aVFVK0RFRGpDZk1jbXNQbEQvTy9QWlVKZ1I3SDZJeWVP?=
 =?utf-8?B?dVBTak9RY2J1d1daVEtMWldZSGFaRjM1aVZncGV1N0hTRnJ3WHVnTlJPamJV?=
 =?utf-8?B?ME5XTlJITTZwd09vY09zbW5yc25UcWNSbEQ0cGNWL0ZuV2w1V3FJRWNhbU1T?=
 =?utf-8?B?OWc0Zi9veGltY1JoTEFQWFJOMFZRSElaM3E1OC8rZlp1MERWWlZBM29yendM?=
 =?utf-8?B?NmxJeEMwRjBDbmgrYW9ndWt1SWduV2s0YzZXeGNKaDlBbHBXYkQ3SkxSUE1Y?=
 =?utf-8?B?K3hFRTh3ZXhpa0QzUll4ZGgrY2lvSkZUSEh2ZnhBeTRMcmNFK1EwRDVTak5q?=
 =?utf-8?B?cTQ3MlJrSktxbGJ0ZHNRcXNQK2t1OUJaZm9xS2lIeHl4b0VCMk0xU1B3NXFW?=
 =?utf-8?B?VlhqZU9qZXBYUXlxVWdES3hBR3RjVmtmdXBLSlNUcGp6d3VqdytRa0g2MW8y?=
 =?utf-8?B?UGJveWJtY2NmdUFObDBLZFhtdzRLYjhFQmpNSFNUVU5OT0pMcmRKYjg5UEJQ?=
 =?utf-8?B?SXhJOGkxcmdsSjMycWo5VkdOeU05MHd6TStMRERhdzJNMkZ4ZkIxczhMNWw4?=
 =?utf-8?B?SHRjVS9OWEpvall1alBjQUhkUjk2dXk0Z09rbEdZOTQycmd3SDlyUE5MSTgx?=
 =?utf-8?B?NUtJZ2ZsVDZSb3hQTU8vMU94VEtLTzhHL25xb3psVjl2TEM5L1YyMmhRbG5o?=
 =?utf-8?B?S2F4NUFQN28rQXlGeS9xOXBlY3J1WkJtanNhdjhJRkx2eER1YkZpbVAyU09U?=
 =?utf-8?B?bVQ4M2VnU2RqNG5PUXVqK2VlMXZBMkpkOGRBcWtmdUhXdWpDWkZaeUVzQW12?=
 =?utf-8?B?RGt5MTVaYWMzVEh6cmlzOWRPN3pKRStHcEY2YVZPaG1ia3cxbU9xZVpRVTVt?=
 =?utf-8?B?SUJHNC83MWh5TEwwYUdkd2VpOUdleEpiYXpweUJWdllob3FmTDVvejhydW9T?=
 =?utf-8?B?TUdZckRMS0JSL1F0ak1xMkcxR1FoR05Ta014SHBmK0FialBZYVk1bGJWVnVL?=
 =?utf-8?B?Q3pVeCtzTC82NDJ5YWoyaDdTZExheDRYdUh2Z1NCNjdGN0k1NVZBZWJ4Y21T?=
 =?utf-8?B?UXZGTDZ3VzhkMjg5MHB4akJyVmhYeGFCRzUyN3hDMUNCNkd5ZndMZ0ZqZUJC?=
 =?utf-8?B?T1paRm9OREhFeTY5WUdjaFRxNjQrMGI2MW5aVUwzTTdZd2JoNkNTRXdJSjJl?=
 =?utf-8?B?NVFKcFE3cEgxbTA2TGcwZjdvakRuYkdwMy9DTytQWUFKaTVUNHptSVlEY2pl?=
 =?utf-8?B?cDN3d2MxY3VPd3lxUkx0c21zMXJMZm5lTWE5bnFqL1Vya2pIalFnUm5udkha?=
 =?utf-8?B?TWVYSmtINmdiRGhKQ2NFak01cElUU0tleVRDSzVZNkFHRXVzanhLeXlUK2o3?=
 =?utf-8?B?TDd2MGhOdENnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a21hUGFjL29VTW1XZjFrVndkdlNpZzVqUFgvTGVKVUQvZEFEdVRVdGwyVTFn?=
 =?utf-8?B?MUNWcEhhL1JJeExINWhKSitFc1JMMGZLbnNHc2w0MmErUFNBdHRyenFJdmlE?=
 =?utf-8?B?Z2t5L3BOR1FsZGpXM0xGZ25vNFJHcGFhUEtISk1GY05qaWUrUzBsc1FkQ3g5?=
 =?utf-8?B?ODl3RTJCcjZCQzRWQmFURW9WZkorUUJndW0xaXF6UzF1RmRUNXZlR0UxY01I?=
 =?utf-8?B?Q1RLRUt5aDB2UE05Vk5wZjlOV3h4dWJxUGtiaWJ6ek81dG1uQ3N4RUYwZjNV?=
 =?utf-8?B?QmM0VVJ3eUFRNmNvQU1jUExKVU9pVU1OZ0xHaS9kaTNnUlZxMUJTWldIRzRz?=
 =?utf-8?B?N3JkTjFZMmJFNXBhOWwwazVMMlk5QWFNSWJjRHZtSlJZeWtLVCtHOFUvV3No?=
 =?utf-8?B?SFIwMUIxclZZbjVzWGo2K2g3bGhEN2J5d01raWNSSjJvcG1qZjB6V1Q2TmN4?=
 =?utf-8?B?RUUwS2tEOURTaWs3Q0pSWlpuWkh1Z0trcDc2d04vTlpQYVN5Nk5yc0pROTVy?=
 =?utf-8?B?TVlBRFh0UDBqeDFlYVoxNStGRGxRL1ZReC9aZkdwbERGVEZaSEdwNlA5cFNh?=
 =?utf-8?B?WDM0Qk10dWpyRm9HdDFpc1lyM0R2Vk9qbTlweXZTQmFObWUxV0ZSYlpWVXFT?=
 =?utf-8?B?R1JVTzFZY3MxMW1mVzJIYS9jM0tHaW9mNGpVdHQ4ZWd2S0cwWG5xOWpmeDRF?=
 =?utf-8?B?R3lXT0xKMDh3OHpqTzNCbUN6OUVJdklzQnZBSFA5V1VqdDJ0OGFRR0JIM1l2?=
 =?utf-8?B?UUlyZ25KZ3hnV3FoWUVLYUFock1VRWU3ZlRKL1dhWWRzOUFmdmlwUzdTYWlx?=
 =?utf-8?B?akx4TWlsdzB6U2RQbUFmNDlmeFUxZkFZRUJqQW1INm9jQVJHWTRSNHo1Sm00?=
 =?utf-8?B?MFN6NHd1R3lYWGNqcW9rVXNRV2tCdG1JR2xNb2lXaTVBdXdnMHlrVWZuQVVV?=
 =?utf-8?B?WXdYQ2pNbW5saFFtdWVLNlpieGZVQXJZUGhvbFBYWDNXcUs3VFl0cWliSGdm?=
 =?utf-8?B?S1RnekVXdVVXd3lyeHlaaHZzaXhqTVN0TEo1TEVMcWpZOXVqSXhKUEpCaW1K?=
 =?utf-8?B?K05qT2FiSmZmMjVYYzc5K2lTbGpzblVoV0xPS3gvdFhUUlpFWGxYOHBDT2pC?=
 =?utf-8?B?dEViRDFSaDFVRWtVRFVReklQMU1CQUg0YStZOVhNTjJhQjdFVEE0MzdsYzZj?=
 =?utf-8?B?ZzZFOHZIUVZmWlBkUjV0eVQyTHJ4OTFlaGM0bDVqUjNqd24xd0M3WnR5Vnls?=
 =?utf-8?B?Zk0zai81SzVKOWZWWUNrWFRKbmE1Wm1YK0dEVVlVUnNYbXpnTjBVdkpUNUJL?=
 =?utf-8?B?aXM0a0NSeVlVellZZGQzVm5PS1o1MEhiblhwWk5xaXBoOElGSmZjdndXaXcx?=
 =?utf-8?B?NDBkalIrTEt3Z1ZJMEtPalQ2cjIrd1ViT2k4dXpXWkVqTUd2MWFBa1p6cGY5?=
 =?utf-8?B?aVk0eDVlY0ZDUWNGbXgxZUc0dkh4a24rOXYrKzBqbEdzTzB4cUxPdlNUa0Zx?=
 =?utf-8?B?MmhabmJzbjB0WXBkUkkzbnpCUjQ3UUtkMFJOd1RCRlBaMENFVE5oa1VlRm51?=
 =?utf-8?B?T0NzcXdLbmJIRjg0ZU83T2VVK2piNFRUVGVPSUhiaWw2SVZyTUZiUzh1MWxC?=
 =?utf-8?B?Q21NNkwrRkRoSkpueWpMVkM3cE1wZkcxbDcyTDVSL1B5K09XaTN4aW1mdXQ5?=
 =?utf-8?B?czd5VnBYOWxCRVViQXpKZnU5bE96NUh4QWJiNG9ZeDBETHRTNHQ5KzZ2NVdS?=
 =?utf-8?B?a1ZqS2d2R0w4Y2pydTd5azk2WkRoZ2ZuUGNSN3N2NENHWUQ2a2hpZ29DOEF5?=
 =?utf-8?B?MDFlc3R1Qkk4QUYxVTdLeHFGZDM0UVl1RXJoMDFMYkxrQzd5V01zb3cybWxs?=
 =?utf-8?B?MUxoVnVuQkZrTkp3MFRnaHcyT2VPUFlEQ1o4RU9HWHFrUVJJWHV1NTh0ZS8v?=
 =?utf-8?B?TWNyM1ZtamQ0dGNsN2czemIrdmVKbEE1WUlZWUtYTUJBSnJqTnVldGlrdWVN?=
 =?utf-8?B?NkZmK0ZVUlJselVxSTROWEJvUVo5Tjk4WjV4WEVTOWpQb3gxVW5XUmpXVHJU?=
 =?utf-8?B?dEJjRWZ0MFBGR0ZJMW9EYjJIWmxPcENyRXA1YVJHR2Y4RS95aUJKd1UrUW0x?=
 =?utf-8?Q?nq2k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3a280b-2f6a-41e6-ab5e-08ddacb0e018
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 08:36:22.9817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1Bjq+IRnKCCJJJA5O9C9Cd5HAJeFOEda+gbMsr7KNniY8bFrdEpbaS7uifp9XtBByNXSPlWK/5rZgLuZavdZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3671
X-Authority-Analysis: v=2.4 cv=BIyzrEQG c=1 sm=1 tr=0 ts=684fd78b cx=c_pps
 a=JpZts7cEBrfcwmRlVwBwFQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=i0EeH86SAAAA:8
 a=0YJlqkhQ_8J9A9UnhVQA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA1NiBTYWx0ZWRfX+vKn4Bp4Tslf
 NxVtNXJ8oFqBAtJ9irWpCxi+EoRo694iMC8VLbXGnKY/sl8HuodZqlEMQ7HtPmEcy9I9mLhsXX0
 9FVbzEtxJtt/wLxn0DlCajBVNB0gEskvXOVoF+JXifYqwRhgfTv1rQZ4xXpfLmyyjlsWDpmCAVL
 6tnzY4CYO/dRCdLkC9X6e0B3qouILVPMW3zcuEjSjTT+CE9qhk0xnfi1zECmqnCKz6H5e52IVMG
 EXAN4ANGwXr1qqcGsq6OJjxNdFQAWpz5s8ypezwvMgWrUDGmV3eKAISNFKjLwNHghxGX5Nncj+f
 aFuGLZHurPy6jGdhx28Q8I09JEsMR/3f/WmzUX/J/OF33Pj7XhVajR0hp9bsoSWr8Qko5RH93l8
 mhYJ6+gDKayBD1R2GWho5D2hr/yJUcsvwrJzOABbylKoMcrN9uo8KSxeGdDxvcEbhC07eT//
X-Proofpoint-ORIG-GUID: u_uvqWq4BPJ8Fny_TQZ78qc4LTIGHv_e
X-Proofpoint-GUID: u_uvqWq4BPJ8Fny_TQZ78qc4LTIGHv_e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_03,2025-06-13_01,2025-03-28_01
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

PiA+ID4gRnJvbTogU3VuaWwgS3VtYXIgS29yaSA8c2tvcmlAbWFydmVsbC5jb20+DQo+ID4gPiBT
ZW50OiBNb25kYXksIDEyIE1heSAyMDI1IDE3LjA3DQo+ID4gPg0KPiA+ID4gcnRlX2V0aF9mcF9v
cHMgY29udGFpbnMgb3BzIGZvciBmYXN0IHBhdGggQVBJcy4gRWFjaCBBUEkgdmFsaWRhdGVzDQo+
ID4gPiBhdmFpbGFiaWxpdHkgb2YgY2FsbGJhY2sgYW5kIHRoZW4gaW52b2tlIGl0Lg0KPiA+ID4g
VGhlc2UgY2hlY2tzIGltcGFjdCBkYXRhIHBhdGggcGVyZm9ybWFjZS4NCj4gPg0KPiA+IFBpY2tp
bmcgdXAgdGhlIGRpc2N1c3Npb24gZnJvbSBhbm90aGVyIHRocmVhZCBbMV06DQo+ID4NCj4gPiA+
IEZyb206IEtvbnN0YW50aW4gQW5hbnlldiBbbWFpbHRvOmtvbnN0YW50aW4uYW5hbnlldkBodWF3
ZWkuY29tXQ0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCAyOCBNYXkgMjAyNSAxMS4xNA0KPiA+ID4N
Cj4gPiA+IFNvIHdoYXQgd2UgYXJlIHNhdmluZyB3aXRoIHRoYXQgcGF0Y2g6IG9uZSBjbXAgYW5k
IG9uZSB1bi10YWtlbiBicmFuY2g6DQo+ID4gPiBAQCAtNjM5OSw4ICs2Mzk5LDYgQEAgcnRlX2V0
aF9yeF9xdWV1ZV9jb3VudCh1aW50MTZfdCBwb3J0X2lkLA0KPiA+ID4gdWludDE2X3QNCj4gPiA+
IHF1ZXVlX2lkKQ0KPiA+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiAgI2VuZGlmDQo+ID4g
Pg0KPiA+ID4gLQlpZiAocC0+cnhfcXVldWVfY291bnQgPT0gTlVMTCkNCj4gPiA+IC0JCXJldHVy
biAtRU5PVFNVUDsNCj4gPiA+ICAJcmV0dXJuIHAtPnJ4X3F1ZXVlX2NvdW50KHFkKTsNCj4gPiA+
ICB9DQo+ID4NCj4gPiBUaGVzZSBhcmUgaW5saW5lIGZ1bmN0aW9ucywgc28gd2UgYWxzbyBzYXZl
IHNvbWUgY29kZSBzcGFjZSwNCj4gPiBpbnN0cnVjdGlvbiBjYWNoZSwgYW5kIHBvc3NpYmx5IGFu
IGVudHJ5IGluIHRoZSBicmFuY2ggcHJlZGljdG9yIC0NCj4gPiBldmVyeXdoZXJlIHRoZXNlIGZ1
bmN0aW9ucyBhcmUgaW5zdGFudGlhdGVkIGJ5IHRoZSBjb21waWxlci4NCj4gPg0KPiA+ID4NCj4g
PiA+IEkgd29uZGVyIGlzIGhvdyByZWFsaXN0aWMgKGFuZCBtZWFzdXJhYmxlKSBpcyB0aGUgZ2Fp
bj8NCj4gPg0KPiA+IFRoZSBwZXJmb3JtYW5jZSBvcHRpbWl6YXRpb24gaXMgbWFpbmx5IHRhcmdl
dGluZyB0aGUgbWJ1ZiByZWN5Y2xlDQo+ID4gb3BlcmF0aW9ucywgaS5lLiB0aGUgaG90IGZhc3Qg
cGF0aCwgd2hlcmUgZXZlcnkgY3ljbGUgY291bnRzLg0KPiA+IEFuZCB3aGlsZSBvcHRpbWl6aW5n
IHRob3NlLCB0aGUgb3RoZXIgZXRoZGV2IGZhc3QgcGF0aCBjYWxsYmFja3MgYXJlDQo+ID4gYWxz
byBvcHRpbWl6ZWQuDQo+ID4NCj4gPiBZZXMsIGFsdGhvdWdoIHdlIGFsbCBhZ3JlZSB0aGF0IHRo
ZXJlIGlzIG5vIGRvd25zaWRlIHRvIHRoaXMNCj4gPiBvcHRpbWl6YXRpb24sIGl0IHdvdWxkIGJl
IG5pY2UgdG8gc2VlIHNvbWUgcGVyZm9ybWFuY2UgbnVtYmVycy4NCj4gPg0KPiBTdXJlLCBJIHdp
bGwgZ2V0IHBlcmZvcm1hbmNlIG51bWJlcnMgZm9yIE1hcnZlbGwgcGxhdGZvcm0gYW5kIHdpbGwg
c2hhcmUuDQo+IA0KDQpIaSBNb3J0ZW4sDQpJIGdvdCBwZXJmb3JtYW5jZSBudW1iZXJzIG9uIG11
bHRpcGxlIE1hcnZlbGwncyBwbGF0Zm9ybXMgYW5kIG9ic2VydmVkIGdhaW4gYXJvdW5kIDAuMSUg
KH4yMEsgcHBzKSB3aXRoIHRoaXMgcGF0Y2guIE90aGVyIHRoYW4gdGhpcywgdGhlcmUgYXJlIG90
aGVyIGZhc3QgcGF0aCBjYWxsYmFja3MgKHJ4X3BrdF9idXJzdCBhbmQgdHhfcGt0X2J1cnN0KSB3
aGljaCBhdm9pZCB0aGlzIGNoZWNrLg0KDQpJTU8sIHRoaXMgcGF0Y2ggaGFzIG5vIG5lZ2F0aXZl
IGltcGFjdCBhbmQgc2xpZ2h0IGltcHJvdmVtZW50ICYgY2xlYW51cCB0aGUgZmFzdCBwYXRoLiBQ
bGVhc2Ugc3VnZ2VzdC4NCg==
