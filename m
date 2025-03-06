Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19224C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 16:22:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4186D406B6;
	Thu,  6 Mar 2025 17:22:50 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DB6CC4069F
 for <dev@dpdk.org>; Thu,  6 Mar 2025 17:22:48 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526AJbEA019834;
 Thu, 6 Mar 2025 08:22:48 -0800
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4578y68s63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 08:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGDiJEui3QjOua9UHCuMMNY7VTLC2wo5b9sX87AzkRkISmlJLZIitZXwyNMFR50+kv33S5SHRYN3D9CkaC2Hz2RHktV5xZB3MGdjxY7G3bmdPhkf1/E2D5SWdF6XEwZLHib90kubg9GXa8pM3Nrb9kc7OU8jGjTZ8um6a16uz/xiqQifbtznFMVJy1CLPJ+Qnxj5a7bwtFDX1G6bhyIosQMobS6rjGsN+lODyAY8DE3tl1t5c6Me44BMb10yFxIjSVckz9tdK5TjikdaLSv+2Epz6KyyAqozLf98SEucOVoSQUwmrQ8UQYsGGIqG3CPPhZzoSBKflrBXKeOpkgoDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGly8diYMKLQGHiQHsrsfli8FpA7rq36EG4oBjsaYMA=;
 b=YNUjD/AuTEKzOi/r6V2PP4VVwO9UnJNdod9GimQUZSei6bIJ9Cnmlq5QK/GYqrSe+9LiDtjusgg9e11KSZyXRExCA239jIBZMQ/ZUBHws1WLIfCK3ouuPuEZ6h1w6/6FAJCM6p5osE1g1G1kH6z+6zl6tONW/ctwwN4tCpXWnjM46bS5f2HoRdXvFNmeaYbkKnwMLmm0FhSkF1CRL9h0rMbQhlnkjCNQMOom+jhET6MHG+kg6i8SqxTkNJUcn0g9Y/krioc30sBFwvE4+ok9D84qtcUQGvj1icBciSfkGlFQI/HqFq7crFMXs8UpKb58Ct2kqFo/8oKa04YafMV1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGly8diYMKLQGHiQHsrsfli8FpA7rq36EG4oBjsaYMA=;
 b=MGJSotZYjRFKQCrumZh3Nr/VW1szlZ+Hf2egTWCL7Os0b3X91k2jsgATgwfWuMDdWHq8/d9joFo+Tps5L3nGWVLsHNG8ZI4EZVftHuHKUuG6Q4FdiViInLYGwOUPJfYZK/QoHqDBPuFrsS4h1L68AqP22G2xzLxIrb9/5sQoNiE=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 MN2PR18MB3685.namprd18.prod.outlook.com (2603:10b6:208:26b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 16:22:44 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 16:22:44 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Jerin Jacob <jerinj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH] devtools: fix regex of cnxk skip files
Thread-Topic: [EXTERNAL] Re: [PATCH] devtools: fix regex of cnxk skip files
Thread-Index: AQHbjqv71lKh2WP4fUeX5/gtjd5gkbNmSCYAgAABZSA=
Date: Thu, 6 Mar 2025 16:22:44 +0000
Message-ID: <PH0PR18MB40866C647EC942C165BA723EDECA2@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250306152516.2594-1-pbhagavatula@marvell.com>
 <4055192.n0HT0TaD9V@thomas>
In-Reply-To: <4055192.n0HT0TaD9V@thomas>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|MN2PR18MB3685:EE_
x-ms-office365-filtering-correlation-id: 526c6c1c-35ab-4c29-c9d3-08dd5ccb2052
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bFNMcGNJZHlDMTB6RTZydldxZnRqVEF0MnZMNUF0M3F4RUE0UEVzTlFLeXVl?=
 =?utf-8?B?Y2tBMWtscjU4MmZjVjhDVkJGaHRoZXVFMFRiVUI5WnpxYkpXL1VMNm9tZkNO?=
 =?utf-8?B?eG95M0tMOUtVYVFrWHZKKy9hQWcvTVJLaXBqQ2lXNjJ1cHNVY0VFd1J1N3Jh?=
 =?utf-8?B?b2xKbUNNQkR0QVNBcmlBRXh4c21rQVZ1Z21QbWhXbWFuRmhNZTZycEVYcm5n?=
 =?utf-8?B?dVk4RVB6Qml4TVVGYk43U0VlY2xESnY3N09SNkNoRTRZdkxXODZjZTlDL29y?=
 =?utf-8?B?bmRrM2RyaUN2Y3FXTXFHYW9pbXJ1bmRscjFjQ1c4S2l1bGpabUlwRytvWGZP?=
 =?utf-8?B?aDJ2S3lyQk9TQ0FCOXBqQjJHYmZ5Z1hyZmZ5S3dGVG9wQ0NHSmlReXNiUjJF?=
 =?utf-8?B?VVZtWDR4VjhEc3pLelhyMHVld1JmdElFOHZtRGhieW9vMG1xSDU2RDZhVmps?=
 =?utf-8?B?d1A4ZldmZVFpK2h0bUk1aEdVUFBjSEpoUFhNTUZ2ZTY5UVhZSXBJWHN6U1pK?=
 =?utf-8?B?dHN5UHFhTzc1NC85Ym9wM1l1Rm5sdHYwZElRMnFsWlkvdzZ3SjlEMWFMcVR2?=
 =?utf-8?B?U3hSUEMrR3lMMGdFYnpyVkRxVG5ON1ozODFaUVp3YXFIMVh4cEp0ZTU4TktD?=
 =?utf-8?B?dUYzWE1RbWorQWlCQ0RsZ1UwRDRlekRENHk1VnF6YW5xVEFHOHpvU29FN3dV?=
 =?utf-8?B?dDZ0a2Vsa2xleFVYSlhFaE5ZSUxMdVdCQXdrSFpBbXdGVHBMdnJjV1QxZWI0?=
 =?utf-8?B?cWZFWEQwTUhpZlo5VzhlRytXRHhYZUFHQmRRWEN3WTZmMEw0ZXpLODU4elJN?=
 =?utf-8?B?Q0lXT1JIWVZyOUdMSEI1Vk01cUI5WE9YYlgrMUVlWTNtU0I5Y2luNWlEN0ty?=
 =?utf-8?B?Qk1aeWU5bVlLUWt2QTVjQzVXMFdIUzBUMm0vZ1l0KzVaV2s3aGZrZ2xSZmND?=
 =?utf-8?B?RFM5YU56ZiswRmZZbUpudWpoU1ZYdnFZL3Y5NE5IMTF0TDdnVWV1K2NpaTVK?=
 =?utf-8?B?QjF3Snl4YXVtL1E3bGtGMERlSW4wekhhUXU3SVpoM1E1ZW1sMWdKSTBMMVcx?=
 =?utf-8?B?RTVPWW9ubitJMmNUOXBFa2ZmZUxBREVpTjJ5Tkp3c3ArczkxcE9JOGZzc0Jk?=
 =?utf-8?B?c1hQOGRhdERLcG5xck5DRG1xV3o1UFZkT3F3bXQzemI2eHA1WFZDbzE1TjMv?=
 =?utf-8?B?VnFNTkEzU1IvQ2QrK0xSN3MxRGxnenRoR0VTQmVWcmhvVWhwbWNJU2NQK1Y0?=
 =?utf-8?B?YUVOWjdLUFF6TkEzd2FqWG1kdzZYTnZ4bnVVZjYwZmZ0emFSaTlQa1p6aWFW?=
 =?utf-8?B?NEJCMkYxckJnT0gzTHU0cWlndTY5amR4Wk5GTEpiZEc3cEZ1Sm1CNkZVYjVz?=
 =?utf-8?B?dXZzVHpIRzh6NU5KRDArajhDTlVLMlVNYno3bXpFQWhnamVQTVBHYkxZK0J6?=
 =?utf-8?B?ODcxN20zL2ZrRDQ2Y0laVmlGQnQ5N00rKzF4M29Ba29TNnRQVFlncnNuQ211?=
 =?utf-8?B?QlIrdkFwVTlIN29ZcnJTcnVidHBtZStGZGVOaEdpNFY3d2t2d2ZjRWdtUEJt?=
 =?utf-8?B?ZFU2dzd4SmV2dkNGN3BzOWtYcllqamZiY0JBYnZEd0s1UUVwNTFRMk9MWFVi?=
 =?utf-8?B?K3lUT3Q2YzZpb1ZKUVYyWU1hUVUva2N1QVRUeCtnQTR3MUQrb1daRG5oT2Jq?=
 =?utf-8?B?M0ZOd1JYd3R6czJ5TDBaT1dYdXhTdVNabUt2VnhiU29XUkZDYUpiVEE1S2wr?=
 =?utf-8?B?UTB1akxTUmY4dnhDNzRFNVhLb0kwQU5mRmVGMVlqWXVDM3Y5S3YvSjRkL21y?=
 =?utf-8?B?bVNrbGxqSUhBdDBXUFgwc0xjSlpZMUNveEFJMUIwamF0QzU5ZjJ4dTl4ZVZt?=
 =?utf-8?B?QjZPZVZjaTZSVS9HWmVMdEhGR0VKMkJiYWVTc3g0c1R4RmtnWnhjSWNrT2hx?=
 =?utf-8?Q?W9ZvIX4vco+J5r3wtzs0dLuWT0QP3Duh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlZ0SUVhbGtSaU56dGNzdnkrTkFDQXEvTVlNUFp0UWlJTC9GUmMzNEEvNjR3?=
 =?utf-8?B?TnZJWnM5b0ZJMWVjOFFJc2xCa2tUZytRblZnVTlWbXQxSWFrTHdVU3VsT1c3?=
 =?utf-8?B?eVRIU0VQRzBiK3VYdFR1aER0Z2FwbWxBbm1GcTdBejdFbWxEU0h2Um9iMEVP?=
 =?utf-8?B?M29zV0ducG45MHVtZ3FUamZKNWYwSzZxMTJib0YzcGdKQ0pZR29kS0prNm5j?=
 =?utf-8?B?d3haVUFlWldOL2Z3Y0hlZnkzdy94TU40VmEvWk5mZlo2WFhVMTRkM0I0azVk?=
 =?utf-8?B?dHpVT1ppNSs3NElBVHhaY2tqOHphVHRaSnhnVk9maGp4UDFqUktVV1ZNd2Fj?=
 =?utf-8?B?QUVEbzkzS1BjUHBWT2p4am1GbUlFSXdMa2I5OU1xWU9uK3lXMmhYWE9LVlRj?=
 =?utf-8?B?YVdldG56N1EybEs1Z0ZrbUY3UlpzL2F3NUxLVy9kVFBSQ05xYnllcU5iZWp6?=
 =?utf-8?B?cG03NmdrV2lNSzFUTmhIdWdkVHRuekFsRmJBdmRXQ3ZCd2VJeUtTWXVjTVBN?=
 =?utf-8?B?SHNYTzk5cE5zVDVxNVJYSmlhMmZpQmRTZXBrSFgySXArUkJSaHM5ZzdIRHhT?=
 =?utf-8?B?TjNlalVqU2VRemJoNXhRblU0cnBIYjVQVWtRdEg5ZWhIL1VtSCtFakRJcXY5?=
 =?utf-8?B?R1ErcjRtdDJXSHlocW1Pa0FTbHFKV0dqakpnQzZ1bHZocFJuQ09kczZFdkZO?=
 =?utf-8?B?emNlSk5jd1U3aFVXdlJxSDE0S0lCT09WSEQzdUcvNjJ6bElSbkhaU0VwYUgw?=
 =?utf-8?B?dWJaOTNuUTY3TGhDcEhlTjhUa3JLZlVtcFVJK3ZuWTA2TkErNVk2bk9PNFV3?=
 =?utf-8?B?VkVvazQ5aDBNeVBCZDRNaXZXazJVNHc0d0RVVUw3eGl0Smd4NTNycVZYMTJo?=
 =?utf-8?B?cThpSkU4OW5ZRFZBYjRkUDhxRWFVOXdLdTlaUEFxdEJ2d0hSS1hSaFcxd0U5?=
 =?utf-8?B?YVVYaWI2V3dOVVJ4ejRlVEtOdVVIRERxdTdKaml6cXRmbWFvblUvMGU0TWZ2?=
 =?utf-8?B?TWJLWW50T1M4Vml5TmRPbzFhMHVKUWZYY0RXZm9QTjJRWnJyVHdJVXQ4VUZh?=
 =?utf-8?B?MWRELytoRm9RekpYWFZFVldKbmRGS1ovNXF6RjBzLzROZnEwWEJxdlVuNFd4?=
 =?utf-8?B?N0ZxZlZ1MkpNemZVdVk4alZYU3B0NWJOOWFncWE4Qm1weXk4bUtOSDJlY2w4?=
 =?utf-8?B?ZW9DQnJ6NW1RV2tFRzFIVTRnTUZRUzN4Z081cldvQzM0dWE0Q0xXUGgxZGU5?=
 =?utf-8?B?WExwT1RLdWcrTTZiWHo5a1c4MjhUK2h6dDg5WUVLR05WVXBON3Z6SlU1YThu?=
 =?utf-8?B?QVZSL0pOSW5jdU9NN2dQeTRiTDF4ZE5mN3YvQkUyQ0d1aElvWlhoWWNWRUJv?=
 =?utf-8?B?bVBVRTRQNFRnUC9lU1hmd3NGQmtwNFNKdHNkSWN6L2hWemorbFVaTHIrdWNT?=
 =?utf-8?B?YjVIVUsrbEtTMklXNTlMMTBFMzlUTFZBemJWdDNEK2phaVJZQ01TeVlxWjcv?=
 =?utf-8?B?SHNHZXNKTGhLdDBlQ1AxK3hobTNVRVAyeHVQbnJ0MHdaMC9wcE5wUkpYMHZa?=
 =?utf-8?B?V2V3QWFCcHEyemp6ZlJvVzcvZFBwRkQ0WTgrSEJ4TUhjc2ZQYjkrSEVxc1RR?=
 =?utf-8?B?emVtZmk5VGFSLzY5aVdaR3Y0VEZtZ2hHV1J0SHI3aTBFZkcyRzNLa3VqcUNs?=
 =?utf-8?B?V09TKy9WamJ2dDZyNCt0VWRVZGc1d3hydTJ1M3JkbFpOM1l4eEJJWWRGdkVO?=
 =?utf-8?B?M2liWWxwRS9BVy81WDVLSEJZSWx4T3QyQ3poN0RoaDdGVk5Ud25SVTZPdnpH?=
 =?utf-8?B?TXNTUVRvL3hyNmhHTVozTHMxWTdwMnBnVTQyZ0RzMUVVeWlIUDZSVE1XelNy?=
 =?utf-8?B?Tk50OU5mTGxicWM5SEowVkdxVVROYTMrNjFKbEVNM2NJQVczanlWOXRMQXZr?=
 =?utf-8?B?amlkWGFXYzllQkVZWlRTZXpLaEdReHVZM2R2cXpIbHpUWGJ6OEpKTUQzTElv?=
 =?utf-8?B?c1dPbm1Ub3M0ekRBSkdmVTBZeHh3MUl2MFg5ZmxoOTlMOSs3QmpGTWc2SWhj?=
 =?utf-8?B?ejgvVkZ6TkdpalRxTlB4VHZQeHgwTG9CeFNaNGtSR2JlOXhUdEFlb0I2ZU44?=
 =?utf-8?Q?IYqn38nHQoaCSyOrPz0e7SMSh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526c6c1c-35ab-4c29-c9d3-08dd5ccb2052
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 16:22:44.6649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgbhE6GW/vny0k2JsS6U2vbu9i+9iPuv65EwVMkrowrvQ05b0zeFkmsIHtGAx0LY0ZqpcSgEn62OErbjOqAa37rwXBB9WurYN2mHXnu8dOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3685
X-Authority-Analysis: v=2.4 cv=cesormDM c=1 sm=1 tr=0 ts=67c9cbd7 cx=c_pps
 a=l5p8UTqLmUd1ApN92JXWiQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=_kfMFh6fMaGj4AvF5NgA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: 4G_Ksi06zV0w9Fg1FQ_b9_4ri3JZPhkm
X-Proofpoint-ORIG-GUID: 4G_Ksi06zV0w9Fg1FQ_b9_4ri3JZPhkm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
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

PiAwNi8wMy8yMDI1IDE2OjI1LCBwYmhhZ2F2YXR1bGFAbWFydmVsbC5jb206DQo+ID4gRnJvbTog
UGF2YW4gTmlraGlsZXNoIDxwYmhhZ2F2YXR1bGFAbWFydmVsbC5jb20+DQo+ID4NCj4gPiBTS0lQ
X0ZJTEVTIHNob3VsZCBpbmNsdWRlIHRoZSBwYXRoIG9mIHRoZSBmaWxlLg0KPiA+IFVwZGF0ZSB0
aGUgcmVnZXggdG8gbWF0Y2ggdGhlIHBhdGguDQo+ID4NCj4gPiBGaXhlczogZGQ4OGY1MWE1NzI1
ICgiZGV2dG9vbHM6IGZvcmJpZCBEUERLIEFQSSBpbiBjbnhrIGJhc2UgZHJpdmVyIikNCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFBhdmFuIE5pa2hpbGVzaCA8cGJoYWdhdmF0dWxhQG1hcnZlbGwu
Y29tPg0KPiA+IC0tLQ0KPiA+IC0JCS12IFNLSVBfRklMRVM9J3JvY19wbGF0Zm9ybSonIFwNCj4g
PiArCQktdiBTS0lQX0ZJTEVTPScuKnJvY19wbGF0Zm9ybSonIFwNCj4gDQo+IEkgZG9uJ3QgdGhp
bmsgaXQgaXMgd2hhdCB5b3Ugd2FudC4NCj4gVGhlIGxhc3QgcGFydCBzaG91bGQgYmUgLioNCj4g
DQoNCkkgdGVzdGVkIHdpdGggMDAwMS1jb21tb24tY254ay1zdXBwb3J0LWZvci1pbmxpbmUtaW5i
b3VuZC1xdWV1ZS5wYXRjaA0Kd2l0aCBTS0lQX0ZJTEVTPSdyb2NfcGxhdGZvcm0uKicgYW5kIEl0
IGRvZXNu4oCZdCB3b3JrLg0KDQpkaWZmIC0tZ2l0IGEvZGV2dG9vbHMvY2hlY2twYXRjaGVzLnNo
IGIvZGV2dG9vbHMvY2hlY2twYXRjaGVzLnNoDQppbmRleCA2MzYzOGJjN2ZhMzUuLjY0ZjdiMzE2
ZWEwYSAxMDA3NTUNCi0tLSBhL2RldnRvb2xzL2NoZWNrcGF0Y2hlcy5zaA0KKysrIGIvZGV2dG9v
bHMvY2hlY2twYXRjaGVzLnNoDQpAQCAtMjM2LDcgKzIzNiw3IEBAIGNoZWNrX2ZvcmJpZGRlbl9h
ZGRpdGlvbnMoKSB7ICMgPHBhdGNoPg0KIA0KICAgICAgICAjIGZvcmJpZCBydGVfIHN5bWJvbHMg
aW4gY254ayBiYXNlIGRyaXZlcg0KICAgICAgICBhd2sgLXYgRk9MREVSUz0nZHJpdmVycy9jb21t
b24vY254ay9yb2NfKicgXA0KLSAgICAgICAgICAgICAgIC12IFNLSVBfRklMRVM9Jy4qcm9jX3Bs
YXRmb3JtKicgXA0KKyAgICAgICAgICAgICAgIC12IFNLSVBfRklMRVM9J3JvY19wbGF0Zm9ybS4q
JyBcDQogICAgICAgICAgICAgICAgLXYgRVhQUkVTU0lPTlM9InJ0ZV8gUlRFXyIgXA0KICAgICAg
ICAgICAgICAgIC12IFJFVF9PTl9GQUlMPTEgXA0KICAgICAgICAgICAgICAgIC12IE1FU1NBR0U9
J1VzZSBwbHRfIHN5bWJvbHMgaW5zdGVhZCBvZiBydGVfIEFQSSBpbiBjbnhrIGJhc2UgZHJpdmVy
JyBcDQoocHl0aG9uLXZlbnYpICBsYWJfcHZuQGxhYi1wdm4g7oKwIGRwZGsub3JnIO6CsCDugqAg
bWFpbiDCsSDugrAgLi9kZXZ0b29scy9jaGVja3BhdGNoZXMuc2ggMDAwMS1jb21tb24tY254ay1z
dXBwb3J0LWZvci1pbmxpbmUtaW5ib3VuZC1xdWV1ZS5wYXRjaA0KDQojIyMgW1BBVENIXSBjb21t
b24vY254azogc3VwcG9ydCBmb3IgaW5saW5lIGluYm91bmQgcXVldWUNCg0KdG90YWw6IDAgZXJy
b3JzLCAwIHdhcm5pbmdzLCAxIGNoZWNrcywgMTE3MyBsaW5lcyBjaGVja2VkDQpXYXJuaW5nIGlu
IGRyaXZlcnMvY29tbW9uL2NueGsvcm9jX3BsYXRmb3JtLmg6DQpVc2UgcGx0XyBzeW1ib2xzIGlu
c3RlYWQgb2YgcnRlXyBBUEkgaW4gY254ayBiYXNlIGRyaXZlcg0KDQoNCg==
