Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8ECC282D1
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Mar 2025 12:07:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02D9240291;
	Sun,  2 Mar 2025 13:07:49 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2EDFB4027F
 for <dev@dpdk.org>; Sun,  2 Mar 2025 13:07:48 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522C09OL004703;
 Sun, 2 Mar 2025 04:07:47 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4540fu9j38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 02 Mar 2025 04:07:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEmzgHhtUkholXea8nQm7ff3uHuYBVZnCXtV0FMizrzCWkiGefvcaInbrikM0K0NlxUwULTyJ74jAJ6cRGmmbny4agPuEPKm78R6Ap0WDCGobzkf25W1RPs6MRZ0jhpySXTOu9FbeARzaWHyKQSc6n4vBqJeDPQWeV4m8GnaiQ/fIWeuKn0AItIAqKTPKbrutGc81PurSwc6vsxEu81X15J05tv0BEKGYaGiODbLHylWgMbze/2lH46qhLmhAao9XnwehBPgSeozjVsh2uOlslrOWDN+jOU36+DPDXptp0sKBzsZgBmXsFi4m0bPicwRy0nhLWI0Xs1KuPpxGvXg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2hjEjNNw9I9SLIW2E1P11Vziz1kI3EEb/7uvO5odVM=;
 b=t0qmcgb3G5zRNG2aWwU2AU0fBw5lfJ4zmYR5+3RMXPSgaYUAQhKVg96NJyh6YJUFn8cxbHjRBY6z2vkw6HZpr5mm68VtNgYZecOAYmsyDsVG26FXqRe2t7Q222Y4ZrEWLmfo/ClMXMgciLUYojsCE1KELHDhK5Teu8w+qqkk+6MHr8bziwxXgbfILaIbIUFebp9mXasj2xyY2OOoTtRSFd56Sy7pMRtsdurU/4jRMApTIJrLO+k/0a1NoP9RBBHTWx1QW92Mhd1v1eYGkUWPY5aP6xtjT+x8dmkRnHtMq6HfQSjoFYCPduceo297CU3EZoHqEthW4Q3MVHC2XgZ3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2hjEjNNw9I9SLIW2E1P11Vziz1kI3EEb/7uvO5odVM=;
 b=RTCLf3CN+FHSsA7GEjgIxiLRZ8MoUlOpAVm+tOJ2AN1HYa48RTGfBhioIKp5mrJRcCLImaMCjix6VddSIiEuxbm+yODxWT4PjixLvwLhDjS3yOdXmhki6KlZmYWCJXPwDcP6UUIqbu1+bcBZydL0QC7oiKJY29G/FYLz9M9bZdk=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by MW3PR18MB3451.namprd18.prod.outlook.com (2603:10b6:303:54::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Sun, 2 Mar
 2025 12:07:43 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 12:07:43 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>, Shijith Thotton
 <sthotton@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Pavan Nikhilesh Bhagavatula
 <pbhagavatula@marvell.com>, "Pathak, Pravin" <pravin.pathak@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Mattias R_nnblom <mattias.ronnblom@ericsson.com>,
 Liang Ma <liangma@liangbit.com>, "Mccarthy, Peter"
 <peter.mccarthy@intel.com>,
 "Van Haaren, Harry" <harry.van.haaren@intel.com>,
 "Carrillo, Erik G" <erik.g.carrillo@intel.com>, "Gujjar, Abhinandan S"
 <abhinandan.gujjar@intel.com>, Amit Prakash Shukla
 <amitprakashs@marvell.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: RE: [PATCH v3 1/3] eventdev/eth_rx: add API to burst add queues to Rx
 adapter
Thread-Topic: [PATCH v3 1/3] eventdev/eth_rx: add API to burst add queues to
 Rx adapter
Thread-Index: AQHbhpgYWMtmR8Xwb0eRXuGQeewhJLNeC2YAgAG+mpA=
Date: Sun, 2 Mar 2025 12:07:43 +0000
Message-ID: <BY3PR18MB4785CF80BF9F693CEC42B807C8CE2@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250218091543.282270-1-sthotton@marvell.com>
 <cover.1740383918.git.sthotton@marvell.com>
 <445d0930473314311091700bb4b9913c6266ffb2.1740383918.git.sthotton@marvell.com>
 <SN7PR11MB704428213D9E051B0E2FD70BA1CF2@SN7PR11MB7044.namprd11.prod.outlook.com>
In-Reply-To: <SN7PR11MB704428213D9E051B0E2FD70BA1CF2@SN7PR11MB7044.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|MW3PR18MB3451:EE_
x-ms-office365-filtering-correlation-id: 3a005ab9-c874-4527-5abe-08dd5982d63f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TXlZWStwRXBRSXROOWxubTc2bEdSSTlIakt6TC93Q1ZHaDJ6ODk2RXRNT3N6?=
 =?utf-8?B?bHJWY0lrVE9IRjFxWkF1RS9CKzNRckZWdDlPc2R4VlpjbEVQUzFWcG4xL1Z5?=
 =?utf-8?B?bUZxZkZqNjdFRTBzQjFnTC9oa3dpRmk2bVBSRDRBN1RRdzZEbXRVRTNjQVRI?=
 =?utf-8?B?MFV6L3lpMng2Tm1CLzBseUMrUWN4QzZ0ZndCZTN2emkzUzV4UkZReEQ4dFZn?=
 =?utf-8?B?RVdpNjRzcXJGL25TZmI4YVRDNlVONGR2RFhuYlZIOHFBbHN4bVBjSC8vd0l6?=
 =?utf-8?B?dmRJc1k4clZoZjNkdzV2Q29FZEJ4bGxabm8yU1NvNjJ6WkhwVGhEdi85NC81?=
 =?utf-8?B?U0I1anFDQnFIamNwb3NTQVhHWDUwVmYyc3JhK2xnby9uV3pMUW9WZDZiakV2?=
 =?utf-8?B?QTB3U1RYT2xiQjJIRW5yZHMvTzhWV2dkZVB2cEQzclRmaENPWTZyS2ZNN09t?=
 =?utf-8?B?am1SMjM4eFhkV2RDZFZrRzJ6aGlMbHRvU0dmaFhvaFliTHhITVRpZndrcHNS?=
 =?utf-8?B?MlNLanRzR0FabnNaQVUyaGlWYzl2WlM0eDhJWWhKZ3k1ZDBraWE2QStQSHhu?=
 =?utf-8?B?Qk5mYmxNZ0picWJUS3hXVFJqbGtabHBsNVNIK1dSNXpOdGJsSnFiT09INkV3?=
 =?utf-8?B?VCtJOUNyZW5CNkQ3WVRMdTFEZEJhbWp1U1cxK2UxTXI3OGtja1JQVUkrN0FG?=
 =?utf-8?B?TlB2Q0I2dW54NjdyaFlST2V1ZUhYWUwvS2JaWVRPTXdVMU5LQWpCRW5vTEFT?=
 =?utf-8?B?cVgvSGZOem5NMU9neXVOemVSdHkrb2JQMnlmZDdyVHhGNm8wSGdyL3plMGRa?=
 =?utf-8?B?c1BXZk91L09WN0VESUU0cjgrQytqdVFsR1hwbDZIbDJWZW5kWFMwS3JQdnBy?=
 =?utf-8?B?NHdNSWhxakxUbU1EbUQreWdGTDBrNmhGSHdpWDA3WWk5bythMHRRUHZJd0E0?=
 =?utf-8?B?REMyMFlVQU96eGFSdFo2N0gvNkdxNEt3cGxDdTlsTXNTdzdFSmI0WEVWaGhO?=
 =?utf-8?B?TEVmQnROZ3pITU5oOHkrR2tYZmE3cGt0TlZHWFR2dUFiYVhZa0J5SXZVSmhY?=
 =?utf-8?B?ZkZKckhIeVFHRnFoYTRyYXliZ0VJcFVyQVZMK0Z1OUcxUU5Od203QkJPemxy?=
 =?utf-8?B?OTZXMW1EaDhVZ3M4TkVoNGpLd2J3WHloczRyNlNFWlpRK2hyVEl4WXJtNVhy?=
 =?utf-8?B?enYyajBuS0hVRmNmVWtYWFZhL2o2c01zTWp4Y081SEJzUFhIMjNxNnRCdkF6?=
 =?utf-8?B?aE40Rm5CZGVxaEZIeDM4dWdvYXRCaXlPWk5Lb2FnZ0dmcUFJWlR0bzUzQnpo?=
 =?utf-8?B?MGlUMTFZUnFoSkZGTW9Zd1ZkdUh3KzVwN2Y2a0dZNjFoVXFlNVZLTzRzY3h5?=
 =?utf-8?B?YlY4dHpXRENUQ3I0M1RNa01WV0ludjdaS0puNjlGM1NvRjBPM3RrQTlDLytL?=
 =?utf-8?B?T1RaS09kR0FqczBjUS94Y0VJYitBSXkzcWZQTUJrWTNqVkFheU5SeWtJdExt?=
 =?utf-8?B?Mm1Ha0t1RDdnL3F5b2I1dTdCYjlyaHRRZEhtRFIvMDFNRHZJczUxNU1nbTgv?=
 =?utf-8?B?WmtLYXJ6anVUYndJN1NPSUtiWnN4Z1owemRqQXl0WjFrQ0ZDWjJqSDdwVVdF?=
 =?utf-8?B?YTNWT2daTzdscEFuQmN0dkd3TUovNUxHOTEwUUFnUlkzalpNQzIyVVdIMUF6?=
 =?utf-8?B?ai9UTGVOZ3BMRkNRVUxGRXdDK2trY3dISWM5QWhzRGkzU1pWVmFWUUlQUUlr?=
 =?utf-8?B?eGxiN1l3R3grLzF5YmQwQ3RMN01yT2F0eTRRUU5oSXlXNy9VZGdGWkZldjQ5?=
 =?utf-8?B?VkhXSmwrSzFPSXdFSnhuQ3kzaCs1bTk3cWdjVEtBMUNNOXZtZ04wRTVRakZm?=
 =?utf-8?B?am04M0NweUZ6c0pHMmlDczYrR3JUVVRFUU82YVgrQjRvcHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blNMVlBWaksydDZPM01JTUx4WHo4OG55bGdqUTJ3K3NSQXFuVHlFcXcxa3hh?=
 =?utf-8?B?a2w0Tk1QeVJhT2FtK21OMG9GZEFjTENzRC9QQ1VUREphRE4rUlZiSU1nNUJl?=
 =?utf-8?B?R0RaM2tiVFdzMmY3WW80U1RHS05acWYxRTZZeW52Uk40QTFNUVdZZlR4RFlk?=
 =?utf-8?B?NjhDSzZ3OCtSdDBkMlZrWEFWb1o3ODNpNHprUmhxaVBrKzVIU1hGK3pIVXJ6?=
 =?utf-8?B?c3pXVXFBMkI3T0lPSFEraFBkSmVrK201OFFpdXZpaG93emtSeERmdTM0Qjhu?=
 =?utf-8?B?T29qRXpuZ3BuYTB2M0lWWjlPUUQzSUpOUW9VSlVKdDhvd0o0Rmc5NFV3bk1P?=
 =?utf-8?B?bmdZbVVwQ0Z0WDhETCsxZGtjcDU3U2w1TXhFK3UwcVFUQjN0SDdtcncva0tC?=
 =?utf-8?B?OUxyTVNDbTBuOHFCbGprNFRQMUhyY0ZxK0hDN05KaElmRTVyZHVWSXJLMTFC?=
 =?utf-8?B?bkdHQ09QOVN1cjM3YnFNaTNHNWtnTnJXTjN4a2NRUUF1T29KcGxucTVpVDdM?=
 =?utf-8?B?ZFFsUGNhSW8xVXpMaW9RSU9NaWluQTh5VHlYNzR5NmdWZ0FVQ0JXVjFUbzRv?=
 =?utf-8?B?dlZCWERLbWVjN2VFaTNGK0xaaFl0N0xLSnVSQ05YS3IxRmZjckZ5TmpyOVJq?=
 =?utf-8?B?YUZGeFVudmIzbXRJbnp1SmRUK0lWb3dPNy9DQ202THRETG9lSXo0VExvcnQw?=
 =?utf-8?B?VWxyY2JzVzBiUW5haTE3c0hSeWlRZE41TVZldGdhT1YzU1R5UkVKWk9oa1g5?=
 =?utf-8?B?czhwZS9jRlN1TzI1ak5odnZSK3d0enlxRHJXK2RKaEZWbzB5MGlmdkR6bkgy?=
 =?utf-8?B?Q2NWVFhGdXdiazRvam1LK25idjRBUERtbHhJZkdsQ1UwOG5XSUcrYm1USkNi?=
 =?utf-8?B?dzhadDVhWTREcGlOZ21BVmxDMFM1R2cxNmtmT2tmZzkvNklYVG0weVJFM0RW?=
 =?utf-8?B?RjlFMUQ0K3lLOTgxMm1WUkRSdFNOK3MvMkM3MmNHUDFRQmZHM014eTkzdVdi?=
 =?utf-8?B?NldsaVJEbSs3VmhsZXlwbEQ2aE1iS0MxRnM0aCs3RFJwQXZ4RFB4YlBYVXNp?=
 =?utf-8?B?TXdGYlVwVVFPSE9EMXNWQTg3UnVLUjY0b04xdittVGIrQkhIMm9HeFlXOGhJ?=
 =?utf-8?B?cUc4ZHRzWk15cTFYZDVrK2ljelFQb3lVTkl3UGRqOW84WkN5WFI0b0t1UUdK?=
 =?utf-8?B?T1d2clRzYnRTQVhZZmJoR2xDb2F4NmVmbVpiZFlTUk9RYldBeEFPSnk4UkJK?=
 =?utf-8?B?S1A3QXl1M3I0SDFpc1VpRXg2WnJENDN3M0haYUIySXRQWDdYL1BmbmpYdEJ2?=
 =?utf-8?B?VlltNjNNSkhVYldGK0tsa0VYa0t5T1prTmIwTzZ3REdxVy9XNWIveHVZZVVH?=
 =?utf-8?B?YjQxWnFuazlHRWg0UDBIb0U5TXVGMnhEYVc3OGdXNjBWNjlkRVk4allwUlVL?=
 =?utf-8?B?ai9YYTl4dytaa1ZMb2FhMXVPNlhMY0NSMmJkbTlqVFd2QVJONFplMEJEZzhS?=
 =?utf-8?B?bnpsNVAyRVVqNVI2MGtFdXBqMXNod1MrM09rOHpUVVRRUTlwR0xnTS9aNWo4?=
 =?utf-8?B?bC9QSlpMZmp4ajBiQmJGbVVjRmRDQi9ubG9FTzRMSy9BMVRZeVBmU0FLVU0v?=
 =?utf-8?B?Mm0wRThXRGF4Y1VzVytuUG9idlV1U3ZEMjYvemRROUV3Ny82bGVHTEpnT2JZ?=
 =?utf-8?B?UWxxRkJWYVZlWlRVcWRpYXJSTU1id3YxeVU5YnAzL0FPSWw5ajJibzBqNEJn?=
 =?utf-8?B?eEd3RFRTWGxROUFTTnJlVUFEL3Q3RCtsZE41Z2NvcDIzZXN3MHVhcTVGUVpO?=
 =?utf-8?B?UmJnaU5rcXZOVk9TWkxLRE9ybXRQNnFtalRaYkpwZ09ZdzBpL1ZhUGVCOUMv?=
 =?utf-8?B?dkNBN0d6UmJsRG16NEYvcGlWc2pmRkpWb1FqRGxiZlpjTzdoLy82VXJTcEVY?=
 =?utf-8?B?T09TWlg0YUluWWtVTFRIR0QvL0dPR29lQmE1VUtraGZtU2RmSE9RVjcyS1Yv?=
 =?utf-8?B?aHdOTE5zR2tRZXNIWnNGRDFNQ0Fzb1FxcjFIUjF4WGhIZjJXZDErRXlUQitX?=
 =?utf-8?B?WG9HenM1dnlBcjltTVNuQ1hlTmVsZDZML2prelJPZnFqSzE1TzQ1WG1rR2lT?=
 =?utf-8?Q?HNqg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a005ab9-c874-4527-5abe-08dd5982d63f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 12:07:43.1048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAh/xIoNnEgFgFNricSTEmA8nyF8eHP4QMSsT5m+97TZvwBzOrMWZtD/93bWPnTvVK0fRpu5izQpcGdHty76xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3451
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: h-bSE_OMZipw4KqPsqfSOcMFjOg3u_mv
X-Authority-Analysis: v=2.4 cv=e5P8Sbp/ c=1 sm=1 tr=0 ts=67c44a12 cx=c_pps
 a=t4e0UQJdoJrPmzgCWb9hsw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=RpNjiQI2AAAA:8 a=QyXUC8HyAAAA:8
 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=8AirrxEcAAAA:8 a=0FD05c-RAAAA:8
 a=sOK4EvBPAAAA:8 a=nO5J9p798Ol6mqdCbNsA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=ST-jHhOKWsTCqRlWije3:22 a=l1rpMCqCXRGZwUSuRcM3:22 a=GXHpb-1LaAaXpgk_vEKo:22
X-Proofpoint-ORIG-GUID: h-bSE_OMZipw4KqPsqfSOcMFjOg3u_mv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_03,2025-02-28_01,2024-11-22_01
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
> From: Naga Harish K, S V <s.v.naga.harish.k@intel.com>
> Sent: Saturday, March 1, 2025 2:59 PM
> To: Shijith Thotton <sthotton@marvell.com>; Jerin Jacob <jerinj@marvell.c=
om>
> Cc: dev@dpdk.org; Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>;
> Pathak, Pravin <pravin.pathak@intel.com>; Hemant Agrawal
> <hemant.agrawal@nxp.com>; Sachin Saxena <sachin.saxena@nxp.com>;
> Mattias R_nnblom <mattias.ronnblom@ericsson.com>; Liang Ma
> <liangma@liangbit.com>; Mccarthy, Peter <peter.mccarthy@intel.com>; Van
> Haaren, Harry <harry.van.haaren@intel.com>; Carrillo, Erik G
> <erik.g.carrillo@intel.com>; Gujjar, Abhinandan S
> <abhinandan.gujjar@intel.com>; Amit Prakash Shukla
> <amitprakashs@marvell.com>; Burakov, Anatoly <anatoly.burakov@intel.com>
> Subject: [EXTERNAL] RE: [PATCH v3 1/3] eventdev/eth_rx: add API to burst =
add
> queues to Rx adapter
>=20
> > -----Original Message----- > From: Shijith Thotton <sthotton@=E2=80=8Am=
arvell.=E2=80=8A
> > com> > Sent: Monday, February 24, 2025 2:=E2=80=8A12 PM > To: Naga Hari=
sh K, S
> > V <s.=E2=80=8Av.=E2=80=8Anaga.=E2=80=8Aharish.=E2=80=8Ak@=E2=80=8Aintel=
.=E2=80=8Acom>; jerinj@=E2=80=8Amarvell.=E2=80=8Acom > Cc:
> > Shijith Thotton
>=20
>=20
>=20
> > -----Original Message-----
> > From: Shijith Thotton <sthotton@marvell.com>
> > Sent: Monday, February 24, 2025 2:12 PM
> > To: Naga Harish K, S V <s.v.naga.harish.k@intel.com>;
> > jerinj@marvell.com
> > Cc: Shijith Thotton <sthotton@marvell.com>; dev@dpdk.org;
> > pbhagavatula@marvell.com; Pathak, Pravin <pravin.pathak@intel.com>;
> > Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin Saxena
> > <sachin.saxena@nxp.com>; Mattias R_nnblom
> > <mattias.ronnblom@ericsson.com>; Liang Ma <liangma@liangbit.com>;
> > Mccarthy, Peter <peter.mccarthy@intel.com>; Van Haaren, Harry
> > <harry.van.haaren@intel.com>; Carrillo, Erik G
> > <erik.g.carrillo@intel.com>; Gujjar, Abhinandan S
> > <abhinandan.gujjar@intel.com>; Amit Prakash Shukla
> > <amitprakashs@marvell.com>; Burakov, Anatoly
> > <anatoly.burakov@intel.com>
> > Subject: [PATCH v3 1/3] eventdev/eth_rx: add API to burst add queues
> > to Rx adapter
> >
> >
> > This patch introduces a new API,
> > rte_event_eth_rx_adapter_queues_add(),
> > to allow bulk addition of multiple Rx queues in the eventdev Rx adapter.
> >
> > The existing rte_event_eth_rx_adapter_queue_add() API supports adding
> > multiple queues by specifying rx_queue_id =3D -1, but it lacks the
> > ability to apply specific configurations to each of the added queues.
> >
> > A new internal PMD operation, eventdev_eth_rx_adapter_queues_add_t,
> > has been introduced to enable this functionality. It takes an array of
> > receive queue IDs along with their corresponding queue configurations.
> >
> > Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> Acked-by: Naga Harish K S V <s.v.naga.harish.k@intel.com>

Series applied to dpdk-next-net-eventdev/for-main. Thanks
