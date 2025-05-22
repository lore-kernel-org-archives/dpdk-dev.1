Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B4EC54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 08:31:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6824B402C2;
	Thu, 22 May 2025 10:31:47 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C5155402B9
 for <dev@dpdk.org>; Thu, 22 May 2025 10:31:45 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LM5XAC008367
 for <dev@dpdk.org>; Thu, 22 May 2025 01:31:45 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46sqap8ys1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 22 May 2025 01:31:44 -0700 (PDT)
Received: from m0431384.ppops.net (m0431384.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54M8TsX0005388
 for <dev@dpdk.org>; Thu, 22 May 2025 01:31:44 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46sqap8ys0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 01:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOHLCl9LI1ucA1nzDBdB5iYDoiSf25AOcYV3vfekpVz7jk/HSv6gRgJji8QCjdZffG3E1UbdDIaybD0/TOn3k1sh2Xm0mudUA5EKJODV3ZhYSrHtoaY0q5wbsyroc75Fx0awDzyAZt56b+8pOXUBp8njEqAzfVFWvOAE990IZsAM59Oot0Gb/GYhdn5iJ2j/hhOFExeaXreXBLAA26okf6UyUyNpbonhq+wMo/rmUpz8/hTKlCEXGuj7b2Sw/aG7/AWWnivD7zzEzJFvRYUwmwdTWnjWCG3o/tsV1745VmkwgrLIjJS14/w/65Bx36BcOHQ0JiyMBQrFgQAGDuShsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbjdEJgitfBGLyc1hLsK3F/6Q50lkzecCW9a4qtUpQ0=;
 b=daC3SIDpj8EBWtsccyPD0c4FWKPhd984H/IQi4gBlDBcceaz8PoRQMwFL59XFyaTuMWl3MYdgQPtjmbB6R6QDRd8zRuCuJBUziOiCmi534kqQUQImBz6LENSwLW6xXRytQX4ELJfx/FfB01VRplO5/txKeSHdx0HJoFeZzWEKnL55wGDYF69sgSv1kehrZKPguxOTLJUaRp7svu5S1WxcIhlM1yOs+3RFP/MEJiLDApejEOO5TVYQMQfzc24omXunqgVEYdvBMD6ST0064HkLlHcZV+2r7L64GcpYgnLZS/GY9XUeFtBv/krqjC7WdRLfiZzGLGXT+UZh9zrzviS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbjdEJgitfBGLyc1hLsK3F/6Q50lkzecCW9a4qtUpQ0=;
 b=NH1MlZYp8yJ4Z467bVRW27kf5n7g4dPCH4tFHP3S8YNX+UDjJfskxjnNoHLmBJnwdf7UGVcVR+reNgKlkCbtXabz1rB9kFTIW0OUKlroM/BhcoijLa/Wer+5qtx0VkSPeXaGuv33uUoo1kprZfahye5DSIAFzzGFL/yHd1qwJIY=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 IA3PR18MB6234.namprd18.prod.outlook.com (2603:10b6:208:51f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 08:31:40 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 08:31:39 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Hanxiao Li <li.hanxiao@zte.com.cn>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [v5,1/9] crypto/zsda: add skeleton
Thread-Topic: [EXTERNAL] Re: [v5,1/9] crypto/zsda: add skeleton
Thread-Index: AQHbyvKGNizyMoJFqUez9e1o/oRmXbPeUROA
Date: Thu, 22 May 2025 08:31:39 +0000
Message-ID: <CO6PR18MB448451DAC2F04EC1EB5A6584D899A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250522064616.2267636-2-li.hanxiao@zte.com.cn>
 <20250522081712.2270938-1-li.hanxiao@zte.com.cn>
In-Reply-To: <20250522081712.2270938-1-li.hanxiao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|IA3PR18MB6234:EE_
x-ms-office365-filtering-correlation-id: b3e9300f-95a0-427a-a44c-08dd990b12c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?T0l6ZXorR2pJWGYzWlFvVEpLYlhPQlV4OXJENFBXdWxkTmN3UjFzSzNad3J2?=
 =?utf-8?B?YzJMbEpOcHBvTFFmdlRIVzBJWSs0QjhUSDVUTGJsTmVteUE2NU5yQVVYU2NO?=
 =?utf-8?B?cDI0L3BvNXBnVDBWQzNhejMwc1FGcytMbjVKS3p5WmtjWFVtYUtQNWw4SkJw?=
 =?utf-8?B?TWFrQ3NSMFlPQ25henJ2NDJ3N1FRN2tPdjZweVpyclNwMkpnVGR0VEdtNXdM?=
 =?utf-8?B?dXdKTTdVN3hMOUEvSkhFcE8raWRCczlLcDhORktSa25tR1hIcGxza2RLUDlw?=
 =?utf-8?B?NVRvZTJadXRSK3lIU3JlcXUrVGlXRWJTNVB3Nzl2OWdtc0MrLzZkUmRNUWpD?=
 =?utf-8?B?b1dxQmtJN1hvRTBHeGdoWnFLcGVpdHUrM2Fvd2tsMTl1R1JON1NyaXFOM1hU?=
 =?utf-8?B?aW9XSDBFTDM1UkoxcThvUjFadi8xOEx0OUdFNjQ4YXd1cmF3Y0xmVjRlUmpK?=
 =?utf-8?B?bjcxUzA0K0tyZWJJdUFOWkdBSGFsdkovN1ZHRjV2a0RTV09zZ1MraE9ianZK?=
 =?utf-8?B?dWhFVTFkSENvbE94ajM0Q2diS0lGcVZDMTVmOVFjWGVPTk9ncHpJc2dGSkhv?=
 =?utf-8?B?NUtiUUl1bW5wZitOMkpjVmp5eGtBanBxNW9BUWxDTFlqbzgxbmpoV0ZLNXl1?=
 =?utf-8?B?aDd6M1hxKzRjWXRPUDk3RWpzaUN5OExidU1rbE1rUnRMdVRCRkQ3bURWdExD?=
 =?utf-8?B?VkMxVkdsb0VleGJlYzBxdE9yNmdnZmM3THdsbmRZamNsbWxMU3RRVFQ1VHQ1?=
 =?utf-8?B?VW5kS0htMTVRU3c3QXBJbURHKzVQZWNnbUx2eTY3NFVJeVJ6YmVxZ0ZYbkNy?=
 =?utf-8?B?NjlZUXp5N2N1cmdVQUVSYURWekZPRlBYRlVpdVoxd1JRaUpPOEYwYVRjVno5?=
 =?utf-8?B?TWJDcHRVb1JpL1U4eEFVVXhTcGxRY2hZLzR2R3VnS2FmaHdHRXR3bCt4Z3F5?=
 =?utf-8?B?ZXh5UG41Wi9YYlVWL1lSWmNLczg2YnVUWm1aaGYwalE3WXVrcG14QmRLT3hD?=
 =?utf-8?B?emFvZnNRQnhlSkM0a0RyQjQ1QXNGQld0TEVmRHZjVy9VOWEyTkxyeXp5ZkZl?=
 =?utf-8?B?TmFzQjJleWpkQkNyOU1pOUlXaTFYWmhTT0Jtd215QW9PdW9ubVpMcmdVN1B0?=
 =?utf-8?B?aG9oK0NEV1NFWFJzT3l1Vk9oY2NQMWpHMVZxemE1MUNaOGFKZGlVM211ekZS?=
 =?utf-8?B?OVo2TnFuUE5LQ25wb2QwaU5iMXZ3Ty9Ybm90dWRYL201dk9iSzNjRFlSQmhl?=
 =?utf-8?B?MFNQcUJJNGJvOGlnU1BhTXV6NGpSQWlpc3I2bUs4RGk4NkZueFRXNjJlUlZQ?=
 =?utf-8?B?MWg4UTZWYjd3dXkwcHRLRGN3NjRicW51YXVjTkZzVEI1YVc4VnNXbEMzUTht?=
 =?utf-8?B?WUxYOTRmREhZM2xMQlhzVGdKZEFLWWJ5S2k5R2k1RDVQOVdVZXJsdU9sQlBj?=
 =?utf-8?B?TU9BYi9PaTRIZzAzQ1VxQUgxYkluUzBjT1I1TEdBdCs2TlZCalFiOC9VeWRC?=
 =?utf-8?B?NGJ1aU93WFRocWlRYWVnZDl3emwzRHJkakR4ZWFwUnFOd2ZvM0xpY2hNV2lN?=
 =?utf-8?B?UFNVRHJEU2JVTjVSd2FSL1ZaZWdsUURpaU05S1dHeDBaSzBqbkVIZWIrTld5?=
 =?utf-8?B?d015aW1PVExUQUp3UlV4Zytxa1oxYjhzSG5rbzhnYzBiM3g3enBMRVdDVkdB?=
 =?utf-8?B?ODBMd3FMejdvWGtzL1hpNlVzV1d3bCtYQkR2NHFCT3h1Rk1TZUg3bmhDYXZO?=
 =?utf-8?B?SnFVMXhjK2VQdWVPem53Z3Nyc3dhQjNQVXExTlRwRWFwcUVoNTY1TGRjSzk1?=
 =?utf-8?B?Nlc4MU03RFM1YnpvQXJ3RGl5Uk1aN3JZZ1RGSGtOY0tDRWU1RThPRStCUnoy?=
 =?utf-8?B?alRVV2N3MmtFTEFCbU5XN2lURDVuallaQUdxczZ0NmppcXozcWlXZVhmdWxM?=
 =?utf-8?Q?P9ChQwTO97o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUtTTlNXSG84MkFsbkszcm5Td0ZsNFp1QlJmR0Y2N2tSY1dtTmFBNzBKQ2Nm?=
 =?utf-8?B?bXk5c3B4U3BHMmYzamhRei9oTDB4RGZpaFFVUk44a1N0M0hGUmRpVU0wV0FD?=
 =?utf-8?B?V1kzbFJsakZVOHozN2xKdmZPU0tYS0ZQdUt3U09xNEV6U3pQK1dFdjZoUy9p?=
 =?utf-8?B?cXkyYXB6ZnluWW1LT0dtSXh5RXFZTFJSa3lqcXV1T3pycEpsVFpWY0xrQTFL?=
 =?utf-8?B?eERmUlZFZXFNUGFPUmhEekhVZHp0aFN5ejgvMTNwakdHQmdXbU40VVdWMU81?=
 =?utf-8?B?ejEvc1crY2V5N2M3V1huRUE3S0RGdUwwTnpWaDB2bFNHdHhCOHlFbzJnaHNX?=
 =?utf-8?B?U01jdGZFR0V4aUdmS2xpT0pzOEJRZnEzSzFWOXVqcGxveTI3UWVxa29OV1dm?=
 =?utf-8?B?Ymo3K3YvTzlrY2dnVFpyTTgrQUtSVGwxNTc2TmZWK3p2bW8vUDhIM1RETXR5?=
 =?utf-8?B?dlZPdXlCOVBEWmg3dG16QldmeVVSWXNYdlJYWXdQbTZNYlc2WU9DSXRLak04?=
 =?utf-8?B?WVU0K2FVRTdyUW0wYkErMHBSOFVGVDhJQUZQNk8wY0trS0pHVTJlOGRkWkpZ?=
 =?utf-8?B?RDRycGlPa1NzcmJSQ21MSWtTOU9jbTArRUxIUENxMGJ4R2tOc2t2aGk5M0dT?=
 =?utf-8?B?N2ViMnNLMS9TUDV5Qk9sdFpRZFZ0a3dOMXBVczRodnRyYzFVanB1NkVDUTdw?=
 =?utf-8?B?WUlTQnpYamw5RXNPbngxeTh1bmplMGF1d2JONUNKSzNjUURwNC9DcGhkYmQ2?=
 =?utf-8?B?MGk3dGZ6VVBOMUx1WXpuZFlKTTB6YkRrYkZlVUZocGlLY3EzMnY3VTk1TUYr?=
 =?utf-8?B?UGhyZVVpc3M5cFplSzB5TFBicC9kM295dkdqWjZ2YytENmxOUnA5cVQ4NmU4?=
 =?utf-8?B?UmNzV084bFBUc3NHem5vNVhza1hBRkF4Q0xwWDk0N2dveXRpVkZzUEtLVkFh?=
 =?utf-8?B?OEFuZzZ2djJDR2VncnFxSklwUk5CLzkvN1U3Lzg2aHRwcnVsUzB1VCtvZE56?=
 =?utf-8?B?TVVNQ0tCQ3JxUlJCdzg2amF6bVpkRDFkdE1GZEJWdkhVSmYwbkcrYmEwSmFY?=
 =?utf-8?B?UTFkcVduM2QveE1tZS9acS80enVmSjRMOTdZWGJqZUZrYnBHeDN4MFBSdW9Q?=
 =?utf-8?B?R0NOVFVLOE5zUHBDdWNDVU9hcmt2VWFSSllaaU5pdUQzN0JHN0hOc09wSEg5?=
 =?utf-8?B?TkNMeWx6b3dCL0pHVlA1RmlhQnFQTUpWNllEZENKeHJwNWE1MkxtVFhRTG8w?=
 =?utf-8?B?RkZpbG9WOS9yNXpqK3JTV29UM25EQ1VYSE5neEU1Q1piRjVuTjZTMjlyQXlr?=
 =?utf-8?B?SWZQVGwrSzI4L1diK3FBOHBOOEJCb1dqNm1oYzVqaHoxaXlMVEVWMUVwR3oz?=
 =?utf-8?B?Z1NxVC9hTjNHQkk1emFUNERvQkR4aVUvcmxQVk5waVpPVVJoYjU0R1EyWXBJ?=
 =?utf-8?B?OEM4emtXZnNXcU1MRUZ3L1JmWndyUGVwNWFBSUVZYTRKSHlkMmt6MVhLT0ow?=
 =?utf-8?B?OWh4SDB1SlhjbUg1UHF3YTUvZGZ2RFcwMEoxdmx6ZVJPVGlsRDVyZTJ0eEFu?=
 =?utf-8?B?MTJYdFA4bE5Senp4amFZSndQQmpPL1h0V2VuQVlpbytLS0ZQUGQxdTc2TmMw?=
 =?utf-8?B?OHpHL1BaUkE2WjdRTlJrenlvZGM4dkc2OWNwcE5BcWdjMTNhcjNweFdpZ3BE?=
 =?utf-8?B?c2NBMEVRKzB0YWt0WW4zcW1oSzJrajJ0ejhjandPMVpKUHFTemNCVW13MFVZ?=
 =?utf-8?B?NENtZWxsc0pvU25XTEJrM2Qxejdyc1d1UUNFNHVKdFVIaXlqRzBKaE5xd2pi?=
 =?utf-8?B?YkRHOHhnZkR0cEVRdVFlQk1HMXhTT0JlNWVOeVgrcFAvOW5QY0tYaVhoTkwy?=
 =?utf-8?B?VmpIVU8vb2VMWVpxZVNQQ1BQM3dyUmlrRktZaW5JWU5JdHc0N2x6Vi92YnIx?=
 =?utf-8?B?RFA5eHpWK0Foc2hzZWR2UGZDL3JObTBuUzhZcjhNaTVTNkoraEZnQk1vejNZ?=
 =?utf-8?B?aXUvTmpkVGRXY1M2YlhEQjJCWUFWVkpjcVJ3TUdlaEdvdGZSOTZHenVNSWlB?=
 =?utf-8?B?eTMrVldWbnRGTTM1WW51M09kZ2JhaU5xQ0ZteHo2MldZOFRvY01DdFBMbDFl?=
 =?utf-8?Q?+YGffG96lV51M9b2dJcuxkvjD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e9300f-95a0-427a-a44c-08dd990b12c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 08:31:39.4698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYw/uHabUhidaxVNBlkySZg589NV74Kk9fM9ypN784E7m47z+JfD1q4+iwN2vhUSKtbJiy6wc5/xrPPo8BWgRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6234
X-Proofpoint-GUID: f16ZWb1AjrHatkiBXVoLzgm9bXi-tHol
X-Authority-Analysis: v=2.4 cv=HfgUTjE8 c=1 sm=1 tr=0 ts=682ee0f0 cx=c_pps
 a=bqH6H/OQt14Rv/FmpY1ebg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=1RTuLK3dAAAA:8
 a=1yMDrSKrginVT93NV3oA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-ORIG-GUID: 7eLwxbbkpZW_91TKDeou67xfWDiYUdV8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4NSBTYWx0ZWRfX23bOK5TDVo89
 B7japeGLZE6HnPtcHYBpuBpL/lh8lXJ5WvTeeaoh5z0Jto6SgwV6d2gx2dFoVDQ3XSMZFsg3QCW
 dQFnkPRwQlmn6f+H5kHEGpohymYQYpftaJM6rFcAjX9vjAzQGFohtX4qaeOPkn7mokHDrD9mRZI
 ALOawcqer8XEC/0y44qE+bwrzuz1r5i1P8Do+4DhsBPWP4hsuPFANsPHc+wLrvhrtIvs1kSKxzT
 YiUOhtY/ITxyX7utXahILYI08Fc7asa0dqZNIl7czRyBWHhTUBrJut27QDj+WOCAbCTilHxKU39
 kn+6aLDqiKAajc+zxIsrWJxZSTs2b6pnlpiDyzF/dqV0UjpuSQlbcJhDanYQUPcxAvKkmoyxpMj
 KiWfYNyugpXG8E3vNCYLto0RFwfmcclOp8gpWO82ITbJW0SHl6XzoL50KvzMfW88HAhTVHFs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-20_03,2025-03-28_01
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

PiBIaSBha2hpbDoNCj4gDQo+IFRoZXJlIGlzIGEgY3JpdGljYWwgd2FybmluZywgbWF5YmUgY2Fu
IGNhbGxlZCBlcnJvciwgdGhhdCB0aGUgcGF0Y2hlcyBjYW4ndCBiZQ0KPiBhcHBsaWVkLg0KPiAN
Cj4gQmVjYXVzZSBJIGZvcm1hdHRlZCBzb21lIGZpbGVzIGluIHBhdGNoICJbdjFdIGNvbXByZXNz
L3pzZGE6IGNvZGUgZm9ybWF0dGluZyIsDQo+IHdob3NlIGxpbmsgaXMNCj4gaHR0cHM6Ly9wYXRj
aGVzLmRwZGsub3JnL3Byb2plY3QvZHBkay9wYXRjaC8yMDI1MDUyMjA2MjM1MS4yMjY2Nzc2LTEt
DQo+IGxpLmhhbnhpYW9AenRlLmNvbS5jbi8gDQo+DQo+IA0KPiBUaGUgY3J5cHRvIHBhdGNoZXMg
d2VyZSBjaGFuZ2VkIGJhc2VkIG9uIHRoZSBbdjFdIHBhdGNoLg0KPiANCj4gU28gZG8gSSBuZWVk
IHRvIHJlc3VibWl0IHRoZSBjcnlwdG8gcGF0Y2hlcyBhZnRlciB5b3UgYWNjZXB0ZWQgdGhlIFt2
MV0gcGF0Y2g/DQoNCkkgd2FudGVkIHRvIHRha2UgeW91ciBjcnlwdG8gUE1EIGZpcnN0LiBBbmQg
dGhlbiB5b3UgY2FuIHN1Ym1pdCB5b3VyIGNvbXByZXNzIGNsZWFudXAgYWZ0ZXJ3YXJkcy4NCg0K
VGhlIGNyeXB0byBwbWQgd2FzIGFsbW9zdCByZWFkeSBmb3IgbWVyZ2UuIFlvdSBqdXN0IG5lZWQg
dG8gZml4IHRoZSB0eXBvIGFuZCBjb21tZW50cy4NCg==
