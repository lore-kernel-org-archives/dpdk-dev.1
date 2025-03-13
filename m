Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B001BC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 04:42:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 765F740DFD;
	Thu, 13 Mar 2025 05:42:53 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D2FE740B94
 for <dev@dpdk.org>; Thu, 13 Mar 2025 05:42:51 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CNOC76007150;
 Wed, 12 Mar 2025 21:42:48 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45avuxuj0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 21:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFZCJqe1WjUNm8h+jjmawywOKcXjO6b1TUZeJLel++rYQeSH35WJw3NM2TL3/j1c6hzLgc6EI5skPKCpHDnKMwiCNFz+dZRBEyulYqDCoU6/LQMOiwgr5RVTCOjnR+dZJH8k9G+Mr447Nw9MEb5uF5wb9E0KrWnKCd6YbS/zAS2zPHgGN96a3s/4GaFX29Z4J/OWWR5AYREhvviw5gZ6fKwK13E9sy8BHkiTiyaVrSmxdff9GCx6NeLUYD0ncpQDPOh0KktzW3FjGf/f8AC8Xx+0Uq6g1X6iRrp1No4U2mxnAtrv4onYlz3r7M1Et7pubn3/taAskPoI/6Zl3RBkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkZnKrzkNfX+lJODvWxR7C2LZxeisX0NXXcszfYD7ZI=;
 b=cqXHuyTgppxklvLsVYcfN83pHysk/Vb5u3+AnzvQeq4uJXbteArDAAuvajzkNGZVtGtFa7pmhrf0Yv82oR0JAqw2clUrUQQ5q9LMO/bqmQs14L+ZazQPGkN0OTBiqKkXi16zYVlCW3CmwQiQYNIUOCNubIf8kFXxAs6Thht81+pLV58+uJXH6vR+d0K7cC/OJ/zIWlxfBZURl3ISLu6qIYvfT0AMk0WXAEHMSUojtEwHK/NRvRnJscjQOlna4H1McA2VoykJIC2Z2KFRmjRHzJQGibHqIqB5ZAtT30QszQ6F1nMOe6k1Ro79ijE1fZJxtxOVa99wm0DSkwkkR8xY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkZnKrzkNfX+lJODvWxR7C2LZxeisX0NXXcszfYD7ZI=;
 b=c6OmkI46qAejQR5gzxtyH/sK0V405Dc32r0x9ZE7ioOAVQLW2iFQvjEF97kA/rOSpO9YtBLFoNlx7eq/wNZ10pHLofy7ZNitmVvRVzOKCpWCETI3jZsk3PGFizKWUFHJJUKzNvdCQfNA8XY1hodDWoZ0rEw4W1DUUXk6fHTYDrk=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 LV1PR18MB6427.namprd18.prod.outlook.com (2603:10b6:408:2b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 04:42:45 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 04:42:45 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>, Jerin Jacob
 <jerinj@marvell.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, nd <nd@arm.com>
Subject: RE: [PATCH] config/arm: fix march features not being set
Thread-Topic: [PATCH] config/arm: fix march features not being set
Thread-Index: AQHbkAhb/4JBtuLZDkGe6YHLVXxX57Nv7vcAgACVatA=
Date: Thu, 13 Mar 2025 04:42:45 +0000
Message-ID: <PH0PR18MB4086C2E00481CD1D2AE770D9DED32@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250308085902.4383-1-pbhagavatula@marvell.com>
 <PAWPR08MB89099D7C522EFE6681BBA2EE9FD02@PAWPR08MB8909.eurprd08.prod.outlook.com>
In-Reply-To: <PAWPR08MB89099D7C522EFE6681BBA2EE9FD02@PAWPR08MB8909.eurprd08.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|LV1PR18MB6427:EE_
x-ms-office365-filtering-correlation-id: 0c9a864a-d616-4851-86a1-08dd61e97f86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dHRibEg3dXZCeDBrbmdHY1R4ZXFWRTZtK2NOVWZwZzFWUytsRTV4NjNNV0wz?=
 =?utf-8?B?UE8rZW1kZUM1bkEyNzI5QTJyZUJTOUxycll3cG9mV3duQ2Jkb0lIbm4ydjNQ?=
 =?utf-8?B?K2NHRlo0bzlIQUVXRHdRaW9ONWxwQXBmcENEUW1PY0hUVHZOVktjL3U4UUNu?=
 =?utf-8?B?WGJYVzRZTHlnb2hpRTZZbGpPUktXbDNBTERFWDNuWDFqZmw3SkFHeTRMd1kv?=
 =?utf-8?B?RzJiTjJqaitSNVJxNWtEMVhzRTZ4dzVvM2VXdFI4WTM4K2s5VERlNHNDMHdT?=
 =?utf-8?B?Mk9Da2d3aHFES3JYVU9HZGJMSXJHYjhhUlNHVDlPNDVtWTF0VWhXTnNaVTdv?=
 =?utf-8?B?bHdSUnJyVWUvUHN4RDFwKzVVTldZbi9hZDZ6ajFyWEtpeGt2Rnl4aHFyR2tP?=
 =?utf-8?B?VmhJdm9xTjQ4OHVUdXFqc2N6eVMveGRFYnNIV0FNMWIzTVBqOS9qcW9uNkU4?=
 =?utf-8?B?NzRHKzFFenNsYlcvMFdrbklIdktjZFBHZ1RmRlRQU0locTFTSEVWa0xMN0NI?=
 =?utf-8?B?enhFNVJUWHJXOFN1MmxXcm9meUlNZnRza0dxeXF3aHBkeE5YOEdHZHVaWjJs?=
 =?utf-8?B?Ni8xWDhpTlBvVkZBRHRBanhkTm1sWUMyREpETDdZdVlrL0dldytQczYrTUoy?=
 =?utf-8?B?dSs1KzhrY3REa0J2bk5kTDR2K0lnUTBtRFRKbjNHOVk4Slo0M2hhMzh1MXBG?=
 =?utf-8?B?RTlHaU1zQWM4ZjVLUzFwY1Byd0t6Uy9yNkFCZ0ZpSWcrWFNpeTRWZ2U2OGVH?=
 =?utf-8?B?QUI0T2Q3MUV1YURJVkczbVFaa2h6VEVwWmpLTHprWGVCVTJrQ0VGM09Kc1Ja?=
 =?utf-8?B?SFU1Q2RZbGNaeUNVZDdvWFFYYzlrYWxXdzhyNnQxUTVlTGdYTWIxdUN1SXAz?=
 =?utf-8?B?Zmo2QUVWQ2Y1c2MrSk1xQlliSWNtUTVpbDFhcUhlcnJQSnNadVhINmlhUThw?=
 =?utf-8?B?S09tcDFEbUZ6cDl1K2VwdnorM3ZQMStOaFpCcFFjYVZ6djd1dVZjclNHS0VW?=
 =?utf-8?B?RXRCZysrak50MUF6Rlp6M29XMXlTVmpkSXFDTTlpS1NUNURGeVdGMzZ3NktW?=
 =?utf-8?B?SzhHWXNZNUcwd0h1NkZSdFJBODJqaWZ4N3M5WkkrM2Q5cng2MXBqZ3A3QUI4?=
 =?utf-8?B?c2Zod3UrRkJjT0NtOTVkNUhvNWRKWnFCNk41UGo4RnhkQU92YklObytDUDZo?=
 =?utf-8?B?cjFyWVNTMVFVS2liQXYvWFdWbHQvM2J0RXRMOWdDMkpJUnNkVzlDdmI0S1Y3?=
 =?utf-8?B?bVE0dmJtYWFVVlNyZVBhWXV6bWI0QzRzZDNuRnJaemViOFVCVnFGMnFSa2VX?=
 =?utf-8?B?b1MrcXR6Z3BWL0NOMHZQOHRJYnN0N2kyWUhyWjRLaEt2N1dsYncvMktkVGtO?=
 =?utf-8?B?YTFRS2VqakpUQU5NbUZTM21OVFZVQ0h0b2ZsSDBmVGY4clhoRmtKTGg3VHNJ?=
 =?utf-8?B?eW5vK1lpVVhVL3ZhaFRxblBNRSthNWVTeVlFeEpoYVBOMzh0MzNnZVkzd0J5?=
 =?utf-8?B?bTBwNStkbnV6d0oyOHBsTTRJSjYydFp6RTBOeTVZOTRFTXN5RDBucko2eC8v?=
 =?utf-8?B?eUZvaXpBMVhCWXhmYmhBZGdZN1I4SXdNVGlUNVFDOVh0MU5IdmRQenZhNGpJ?=
 =?utf-8?B?czFRbnpWaXlIYU9oZU5rMnVaT2xHWHp0aE1KeWg5c1VJcVllekY4SkNiYkU0?=
 =?utf-8?B?UmxNdFpWNjNURXEvVHl2bVdPcFpNZUpCNXlBYTVBY2I4bU5kb3ExNjlkQ3g3?=
 =?utf-8?B?WnpNamxleTFuZ2x6SFBMZVFKVVdhMVFCcVhTeGxtSzgxTjJqalA2a3JjeW12?=
 =?utf-8?B?RExBMHhiSEIzd2RiYVVIK3VqZVZha1hUVExrOEZCNE50aVdmT1Bxd2NTMkN0?=
 =?utf-8?B?ZTk4SGtLVHlCVXFRRnA1UnNtbmtHSGZwS2wwVkl3anRtSENRZktNMVBLRHUz?=
 =?utf-8?Q?++3AHbMgoYWvhgzkoQ/b5TSCj8/HAZo2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjRqdzBGOEMreE9PSlQ5Y3R3SUVzUFd1UmtNNmE2Y2I5Slo3QzBVazM1N2t5?=
 =?utf-8?B?WTk2anRpZlU3Q25ubjhLdkhQd01uSUhPZnpUSkV3eFZ6UExSMkRXVDcyb1FM?=
 =?utf-8?B?aElMSHdVN0owYjJib2lBMFJiNHRyekkraThpeFFGTnZLLzBwZjVSUXZtTUZu?=
 =?utf-8?B?YlkyM0haNkdjbU8zOHBRVUFFRkQ5V1lZK0pTblVBWklQWW4zR3hXQ0JwMDZ4?=
 =?utf-8?B?Y0dIUW5wc1E2MHdHenZEWUQ4eTdyZHdQNUlQeTB6VW4weHNscGY5cm5kRENo?=
 =?utf-8?B?T3lQYzNacFF4RElQdDdLSW1qbDUzMVNhZ0tFR0hHR2EwSENaOHdoTWYwZ1VD?=
 =?utf-8?B?RHFKbGNDSjBpTGRZZFVzRXRhOUYzc0wxS0hGc0lGL2NyTWJ0M01QT080Ujlv?=
 =?utf-8?B?N29NekJwbWk4R2hYL0pXWk92WFRNci9uQm5zU29OVUwzUldVYTlGUXZwMm9R?=
 =?utf-8?B?Y2lnN3pEZjJjb3J4N2ZKR3d3ZzlYZVIrdXRZRlMzNGUza0JPN3ZCZzZzU2ha?=
 =?utf-8?B?dmpudkw5NlYvSUVvdEE2Q28yRW5WWFFjU3VmOUtYaDh3U0VwQU5ja0pQMWxo?=
 =?utf-8?B?RHZkK0hOL1l2RVVGNlo0azNFUzVETXNuU1lQN1loZmZuNERvUTM5dU1JcnFo?=
 =?utf-8?B?Y3lOYmppMUhHbG9PdzVBSWJJbWpRdVROckVFT3htUHRFaVI3bWVMWWgxYys2?=
 =?utf-8?B?aWVaSWczTjlNS1VIWWozQzlIVW9pM04yT3ZyTDdvNXJqTTY2TkdxY2NoQ2JF?=
 =?utf-8?B?enNTUXBZRktlK0wrZGxIL1c4QytpOVc4VEFjdE1CQkEvNFJMay9xRnlXMlpy?=
 =?utf-8?B?VEo0MFQzZEtBQlJZTlF1TnRQS3dJOTBFdXdHNnhXNzJJZU9wTDNzU1dUR3FP?=
 =?utf-8?B?a1cwVnhIK3lIek5lci9waWNNNWFrYVZwMUhWVUZtM2c4OVhtaWlMUDk5aldu?=
 =?utf-8?B?NUxLbkkrOE9xUGk3OUFNbHV1Wnc3THZRMnFTeThRakRkNVd5dnNOb1B6Qyto?=
 =?utf-8?B?RVVFa3ZTbXIrekN2bk9iUlRKd1ZaeGRveTMyTG5aN3UrQjFWUmpXMkQzSGhx?=
 =?utf-8?B?YjQva2piZjFscE9KeVVZaFFaV0ppVXpaUFRyVzZOdTROWWoxTzhkQ042Q1pw?=
 =?utf-8?B?UnBOQU9VZXJlK1dqQU5yY3lwaXJMWE9OMU44OFZKaGFtWFlEeWZGYXNEc21X?=
 =?utf-8?B?czVsT2QrdFpQUG95blVPdmVyeTNxcFN2eXdDbkdMQzNJeHJFTG56Q0d6cjBU?=
 =?utf-8?B?MTdhaElJQ0ltSjJzc1Y1RUNMc213UTY4cmVSSElyTWIwR3h3dVdkdi9xQkRs?=
 =?utf-8?B?cXUzRTFTZk5jd3hkQkk0Z3FPdjF1U0c4blVmdVBoZ2RmclE2c0pIUU5tWkQ0?=
 =?utf-8?B?YXlXY3ZHdUdBbWdIMGNLQS9ZSXZHdnIrWHlia1VoR285eUNrSnY5OE5mNDFn?=
 =?utf-8?B?bUhod3llYWR0clBIZ0UzNFBrVnRSem16OGZNa2xoOWo4TVAwMDJFS2RHYjBF?=
 =?utf-8?B?SndjOGJkcTRBZVUzcHlCVi9jUjR5eTE5RUlWUnhIc0gwbGljdFhCOEh3aWVk?=
 =?utf-8?B?QTNlU21NZ21oK3lhNUZSaVRCKzdqOGRJRG5GTnlmbnhGMFdpQy9CZlFsVVBl?=
 =?utf-8?B?cVpBME9ESXRmQXdLOUpZQThnbUZxOHVnQWpCY1hRazlIMTZjWjBtTWFJcDYz?=
 =?utf-8?B?Yk8rMDM2U1pMMzYzWHlkZ2lnZ0YzMStQNmFzQkVQRm5uUjJLa2x2Unh5TFYz?=
 =?utf-8?B?SUdDWjdLdmJkWjBxbGFaQTNHNVFNRVlkL3ZnSUlvakx6dGJUN3FoWk9pcnY4?=
 =?utf-8?B?MVo3NlRyUHZMcldUR1FFNHkzVzNKOUVJSFQwZ0tCUnIrQmlaSW9ZZit6cUMx?=
 =?utf-8?B?K1pqQmN2WEtpem95bHNvaWpnd09ZcEd1VnR4Q1FIWkprNXRWTkdxd0VacGhu?=
 =?utf-8?B?KzhXelJOd2JHdXJSby9QS0xUS2kyNFZMd0NVVzlBUXVSNDBvR0dHdUY0SjNz?=
 =?utf-8?B?T29jYXFqdDNtc2NMRlkvT21QbXRVdEJ3c05NcnpkNkJEU29zN1d1OEFvRnBt?=
 =?utf-8?B?VWVoRkxHeExoYVE3cERsL0dFMkQzZjBSTDF2UkxkNHppMG44QXR3bEw2WTJ2?=
 =?utf-8?Q?7zChPm+k8eVPqJN/ztkhAtirK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9a864a-d616-4851-86a1-08dd61e97f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 04:42:45.0973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /5Tas/ztauFYcJMqsDX4BhvpzZ3Xi6EBmHWQj2s40YvIh6Km7DNyt0NtoAm8gcMzsGctu2jXTDia8+zOswHr40F+yiR+n6mh0pKcfDo7jhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR18MB6427
X-Proofpoint-GUID: R0JMHfHyU-Kzs4BXyrNqOnMv-9BLyF0m
X-Authority-Analysis: v=2.4 cv=VpwjA/2n c=1 sm=1 tr=0 ts=67d26247 cx=c_pps
 a=o9WQ8H7iXVZ6wSn1fOU0uA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=2Ch7MfzoKhtaExgA9VQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: R0JMHfHyU-Kzs4BXyrNqOnMv-9BLyF0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_02,2025-03-11_02,2024-11-22_01
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

PiBIaSBQYXZhbiwNCj4gDQo+IEkgdGhpbmsgdGhpcyBwYXRjaCBkb2VzIHRoZSByaWdodCB0aGlu
Zy4gSSBoYXZlIGEgbWlub3IgY29tbWVudCBvbiB0aGUNCj4gY2MuaGFzX2FyZ3VtZW50IHlvdSBo
YXZlIGFkZGVkLg0KPiANCj4gPiAtLS0NCj4gPiAgY29uZmlnL2FybS9tZXNvbi5idWlsZCB8IDEx
ICsrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvY29uZmlnL2FybS9tZXNvbi5idWlsZCBi
L2NvbmZpZy9hcm0vbWVzb24uYnVpbGQgaW5kZXgNCj4gPiBkZWEzMjljZWI3Li43Zjg1YjA4OGM5
IDEwMDY0NA0KPiA+IC0tLSBhL2NvbmZpZy9hcm0vbWVzb24uYnVpbGQNCj4gPiArKysgYi9jb25m
aWcvYXJtL21lc29uLmJ1aWxkDQo+ID4gQEAgLTg0MSw2ICs4NDEsNyBAQCBpZiB1cGRhdGVfZmxh
Z3MNCj4gPiAgICAgICAgICBpbXBsZW1lbnRlcl9jb25maWcgPSBpbXBsZW1lbnRlcnNbaW1wbGVt
ZW50ZXJfaWRdDQo+ID4gICAgICAgICAgcGFydF9udW1iZXIgPSBzb2NfY29uZmlnWydwYXJ0X251
bWJlciddDQo+ID4gICAgICAgICAgc29jX2ZsYWdzID0gc29jX2NvbmZpZy5nZXQoJ2ZsYWdzJywg
W10pDQo+ID4gKyAgICAgICAgZXh0cmFfZmVhdHVyZXMgPSBzb2NfY29uZmlnLmdldCgnZXh0cmFf
bWFyY2hfZmVhdHVyZXMnLCBbXSkNCj4gPiAgICAgICAgICBpZiBub3Qgc29jX2NvbmZpZy5nZXQo
J251bWEnLCB0cnVlKQ0KPiA+ICAgICAgICAgICAgICBoYXNfbGlibnVtYSA9IGZhbHNlDQo+ID4g
ICAgICAgICAgZW5kaWYNCj4gPiBAQCAtOTA5LDExICs5MTAsMTUgQEAgaWYgdXBkYXRlX2ZsYWdz
DQo+ID4gICAgICAgICAgbWFjaGluZV9hcmdzICs9IG1hcmNoDQo+ID4gICAgICBlbHNlDQo+ID4g
ICAgICAgICAgY2FuZGlkYXRlX21jcHUgPSAnLW1jcHU9JyArIG1jcHUNCj4gPiAtICAgICAgICBp
ZiAoY2MuaGFzX2FyZ3VtZW50KGNhbmRpZGF0ZV9tY3B1KSkNCj4gPiAtICAgICAgICAgICAgbWFj
aGluZV9hcmdzICs9IGNhbmRpZGF0ZV9tY3B1DQo+ID4gLSAgICAgICAgZWxzZQ0KPiA+ICsgICAg
ICAgIGlmIG5vdCBjYy5oYXNfYXJndW1lbnQoY2FuZGlkYXRlX21jcHUpDQo+IA0KPiBUaGlzIGlz
IHRoZSBlbHNlIGJsb2NrIG9mIGNjLmhhc19hcmd1bWVudCwgd2h5IGlzIGl0IGNoZWNrZWQgYWdh
aW4/DQoNClRoZSBlbHNlIGJsb2NrIGlzIHJlbW92ZWQuDQoNCj4gDQo+ID4gICAgICAgICAgICAg
IGVycm9yKCdDb21waWxlciBkb2VzIG5vdCBzdXBwb3J0IC1tY3B1PUAwQC4nLmZvcm1hdChtY3B1
KSkNCj4gPiAgICAgICAgICBlbmRpZg0KPiA+ICsgICAgICAgIGZvcmVhY2ggZmxhZzogZXh0cmFf
ZmVhdHVyZXMNCj4gPiArICAgICAgICAgICAgaWYgY2MuaGFzX2FyZ3VtZW50KCcrJy5qb2luKFtj
YW5kaWRhdGVfbWNwdSwgZmxhZ10pKQ0KPiA+ICsgICAgICAgICAgICAgICAgY2FuZGlkYXRlX21j
cHUgPSAnKycuam9pbihbY2FuZGlkYXRlX21jcHUsIGZsYWddKQ0KPiA+ICsgICAgICAgICAgICBl
bmRpZg0KPiA+ICsgICAgICAgIGVuZGZvcmVhY2gNCj4gPiArICAgICAgICBtYWNoaW5lX2FyZ3Mg
Kz0gY2FuZGlkYXRlX21jcHUNCj4gDQo+IExvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBUaGFua3Mu
DQo+IA0KPiAtLXdhdGhzYWxhDQo+IA0KDQo=
