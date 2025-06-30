Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A0CC8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 09:04:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7644B40264;
	Mon, 30 Jun 2025 11:04:14 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B691F4025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 11:04:12 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TNVPAQ011535;
 Mon, 30 Jun 2025 02:04:11 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2113.outbound.protection.outlook.com [40.107.237.113])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47kf82ryvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 02:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVKTr6YwV7MYk1Sd9pzVr/TIrBXlLAlcqhwcRMl8fdfXah3v5iiFbBtJpi9AVPL6Nmg+9zGuwIDeBxGYKRva5Uf00+Hyp18zDxZZBaAVkY7ae0h5OAJpeDfztQ0LwKgpg0esFVDH8XGIGtO6B4BWY0sZn3R0aOXA2JH9lg9cRCtajJCSPnAq+NQszt3e9IwzbnLDFfPi5AnCBjQg5BuohvEGBa/uSaay1nWfcWVuW/3c8JynnJ+2yK80+NfgJHsmSrKFHhitt/zCZKF3AajEYTzx8dfE+OnSflcHrgFy+3uUGMCSQ3tmcpC4xvxgBzcBUxcDQJX9U4/K2OyL2sEdng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJuh0yoZrb2wpK9aaRql94NzNAU5dtFDNFvub9cRI7Q=;
 b=C3jeROPmj5gIPjeYnYGeAsFfrtzV2S4IURjKbl23ZJTxHp8cSIK9BU+/TzxTAYOO6qTIIuNnraChkHgikxbOFunmHLp/QuVf/wHntdxROY0uJjvNVpFOIrSrbNnVH1pPx1bmFS4k6s6TqoFzeIyMaCV6fHZg7oe2J9nrNyvKOYnK/P2ti1LXYaIlWc04wJBc4kyDOrMJjnZ/Xy9n5x/pKmwzGrwQpinj8nq2HrrYUbQcA6LRakcepYgTX9HHVHfIG6fUcYMPyLREEgtftx6h6JMFIdIm/iIcAZvQ7V84DfNBLTV6K1aohArYcwi0cYQ7umDn0jIAZYy9ryd1so7Hbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJuh0yoZrb2wpK9aaRql94NzNAU5dtFDNFvub9cRI7Q=;
 b=ZyuvmYYMnyMCqXxyyk9uKqSNBNFa/jcxpI/J771FhYzA9XLUoDS4AmoSkdPpFD+82yReFZFWQoFcak65veejHxfxIKErPPvGBarmE0iPcirX9IvtwKUX293VtmBRHLdX4XMN2QUyEMEZRWcn0bivr3cRSXwmA7AY7X8aV3iRs9o=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB5195.namprd18.prod.outlook.com (2603:10b6:8:52::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.21; Mon, 30 Jun 2025 09:04:08 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8880.015; Mon, 30 Jun 2025
 09:04:08 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v3 0/2] uadk: realize async mode
Thread-Topic: [EXTERNAL] [PATCH v3 0/2] uadk: realize async mode
Thread-Index: AQHb4ZRhfJRKGMn3Lku3CJTsGmr9zrQT0b3AgANe+ICAAWI8AIAC5TLg
Date: Mon, 30 Jun 2025 09:04:08 +0000
Message-ID: <CO6PR18MB44841A3176C958FCD75E3AB3D846A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250620033515.86501-1-zhangfei.gao@linaro.org>
 <CO6PR18MB4484B2A6744F73A9196EB034D87BA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9Gg_dxLYg4FJi_J90NJw1F3ky3JwpnHMq-hhNdNfhPR7g@mail.gmail.com>
 <CABQgh9HRAq8ZFfacB3XZoA5QdyfOV-2NUW0Y=rpyxHuivktQEg@mail.gmail.com>
In-Reply-To: <CABQgh9HRAq8ZFfacB3XZoA5QdyfOV-2NUW0Y=rpyxHuivktQEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB5195:EE_
x-ms-office365-filtering-correlation-id: 0dd89e76-1fe1-4a67-5535-08ddb7b51270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VHpIQUczbUdOTEQ5aHk5UmdPWEp4Zkp1bXlWQnVjMUY2WWgvUUpvWUthaFJC?=
 =?utf-8?B?VDJXdm5YTXRPc21vSzB5c0pKY0NJTS81eDUyTyt6SGxNS0h4TTN5MmdnUGVj?=
 =?utf-8?B?RDdOZjlDNDFzSTJYa3huakE0ZVdtbXhzbjJaRHhwaEhqOHFwRXBoeWdzc1M1?=
 =?utf-8?B?MnQrRHhVdlc2dVJlek5ia3NYNVQzQ2VHTVRGWm15RXE4RGlWV0hHRGNSZjZS?=
 =?utf-8?B?T1ZKWnFpR0QxR0dDdGltekVyNk02TFBHcXFoUU9MY1Bvd3hWZWhiTkhKUW9w?=
 =?utf-8?B?N2VKYkxaemw5dnFlaUtlNzJQemRoMWpRSW9NeWl3ZHh0T1IyRXExUjJ1V1Ey?=
 =?utf-8?B?Z0pmbUFxYUNrUnp5bnMyNElSVUF4ZjV3VjVkN2xvZmlZT1hjUXBxTVVVVVNn?=
 =?utf-8?B?ay9NSVdYY1U4dloyeUFqTExoYXhwRFdHRlRRb0NEM3Z3TzAwTytrWEZXWkRW?=
 =?utf-8?B?NG9VOFRZbEZHK0tDSjhrckZGYjVISjk4ZFo4SjBrdERET09TWUtzMDZnczZ3?=
 =?utf-8?B?dDY1b3RNRlNDN2QybWpxRG04ZUZGZHdsWmZZUE9rR1BMNzVkbFNmd3MzVGN5?=
 =?utf-8?B?YVlJZHlBQ0pXZm92UVZFb01xNmFZSUxYM3VHQmI3Z1pVSFVocXd3SXdkUXhB?=
 =?utf-8?B?WjVxQmFhTlQwcUxNbU41bzVJbFNTUHJ2YmdTUGN4KzJoZitUdEdWNWg4akZs?=
 =?utf-8?B?UXlrRHVNdzgzY3piY1pLRXkvYWJxdFdabjNXWi8vSGxkdStlbnZpblZqZnNB?=
 =?utf-8?B?c2hxRXhMenJFUFJtR3l4STBlMGhwejl1YzFDUG1RZGc2aXhCbE1xSWgyK1Zs?=
 =?utf-8?B?cDV0N20zSjFveXZhbHhYQyszTXlKcmJGN1BqL0srNHRTMERmVjdrN0hKSTZD?=
 =?utf-8?B?VUF1M2R3RmlmNU5lTThDdGtRcmo1QmM5MkdyVTBSZ3lTK3FVb2V5ZjA3V1py?=
 =?utf-8?B?c2dBNHdnM1BtZ0Y5NkZlM0xVcTQ2djBxZ1ZwclZqcWhPbHJuZzhFN25hRGFS?=
 =?utf-8?B?eXUzOFdVMDNLY0pnYzJOem9naHhUeFY1ZEV3YVhqQU1OTDkzWWRDOG5yaHVz?=
 =?utf-8?B?YWNqeFl0UE1uTk00ZnI4NG9SQ3FVUVdKOWtVLzlJem0vRFBMRWxWcUNGc0Uw?=
 =?utf-8?B?eFBzNkxsY0lHRVNVUjNTS0E5dno1dVc3TkM0aCttS3hJR2o3Qnl3bm4rcks1?=
 =?utf-8?B?N3ZyS3dKZkxIb1hWNGZhYUh3bWNGRU05R0k0UDczVmpudkNqOGRSOE9PMGQ1?=
 =?utf-8?B?OVdQUUQ1UHRsMncxUWljV2pJWDZ1N09mQ0h2Y3F1YmpWbDhWSzZIZUpIYmN2?=
 =?utf-8?B?WndlK2t0Z3dKMHBDbGlBOHFpbnp5Yk1MUlA4RzdHMWJpTHFpVXlhRnhwNVRV?=
 =?utf-8?B?REVkRzlNMXYvV1ZHMmRZSFc3ak94djcrZFY5Wmd1Y240QSthWFJ4THZsQ241?=
 =?utf-8?B?amJxWEhPc2YvamJCRU5QMXAwc3daRkxhc1hjdThYS3RXMGlYRE1YeldTRUF2?=
 =?utf-8?B?UG8wQ20zQVpLMGV2NXI3TndpbmtmRGtlT3Rid1JYakVTYTZhOEFVRXAyc2NO?=
 =?utf-8?B?dHJMKytyQ0hUMzR6azV4OCsvQXppWXVNa3BQTFJSTGJKdzNRZitjTS92ZmpI?=
 =?utf-8?B?S1JwR1VQSHVJYWpFaU5ENS9VYjlvbTZJbFFmN0tBM1hIYU84TllCQjEvaHRr?=
 =?utf-8?B?VWdEd2NtL3hrci9KR1B2SkFnMmhFOHVnN3ZDbnNaMUF4Ymh0ZnpKMGtrODRL?=
 =?utf-8?B?cUR2ZzVHNldTWFNCUlJJTUl0RzVCR2U1QVRpSWpvdnB0UzRxaUMwaHUzS0dl?=
 =?utf-8?B?ZlN0RmJnei9vQlBXakNWb0R3cGlrYjBFTFF5dmY1MFcwVVZ5QStxWnFQQS9D?=
 =?utf-8?B?Tllzc082QzZhVWRpZ1d6cHpWYlZaNjd0WmlqUm43OVg3bkVyK05ZeTYyc2hH?=
 =?utf-8?B?a0ZhYkVubDFBcWYxVDNyS2dQY2Y3SGlOc0hDSDhpQnNjclZ5THZZa3dER1Np?=
 =?utf-8?Q?p3YcrS1B2vmX/xxZu0pjiz//p6Yrq8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVI3ak5peEUvUUNJTXJ6dkVqeU5WOVNXeTRsSkI2KzJFREp6Z1p3VXk3VFV0?=
 =?utf-8?B?NUVWOGMrbXJzR3FWbDltSXg4Y3FxTk9Wd25KSWFoU3VtTUR2OG5maDk0dk04?=
 =?utf-8?B?V3QybTZoYW5JNklaQnRwdE5oZHF2ZUVPVG5kMkdBa2xGNlNQNG13WFgrKysx?=
 =?utf-8?B?UndENlZwVE5zbzBmMnMrWWcrMmE0dVVwNE1rWXIwQVh5akFCSWJHNDBJNWZs?=
 =?utf-8?B?MjA5M3RxaXE2bmRDYVI0ZVhPYkJRK1BiUUR0TzI3cGc1UkVWS0FENWxpeUpj?=
 =?utf-8?B?bWJKZ3V3eUMwZFd1MXRaTCtnOWZmN1FCWHEvcUNYcGdOd0FJVVJuRkgySUZl?=
 =?utf-8?B?WlRteE5KSkVxTDJWUU1tZmxYTzZLVFBxRjhOSWtPVSs3WDZaT1FrODhUU0g1?=
 =?utf-8?B?V0h3MzlFM3pxeEt3RjFha2drdml2NVZHT1Rvcmxxdm4zbWVLM0xwRUxqQ0Vj?=
 =?utf-8?B?RUp5WG04SXNhUlFlWVMyUGIrclFldEJXeVNUdnExczRlM2ZpUi9qR01HeHVU?=
 =?utf-8?B?RGZYbzd5Ym1BVXl3SWJFMjdKUkpBdEorUHlXRTNkd3BRelA4bVFJYkdBbGhD?=
 =?utf-8?B?aXh4Si9pTVE3NlBTdmtteDE4QXRnOC9CODFDYVpzWTlFOERpa3BjZFRiU3Zu?=
 =?utf-8?B?U2xKM0ZNbE1uS1YxUWVZSGo4WnhWem8xZnNWNVlNR2E3ZHpvYTdxcjBmOG91?=
 =?utf-8?B?SHA0NS9JRXhVbXZiNWVPNmt4N3BqdzYvOHJUUUlWRWhFOUNxQ0xOYzQwYmNl?=
 =?utf-8?B?dFJ3WDM2TnBuZlFEbkd5Y3hpWVBmdlYxL3dGaktLaGcyWmN3NTJlS25tekh5?=
 =?utf-8?B?emlzTy9ibVpHeVE1d2RnTExLdTN0dFJyRmxIaWJScDJiTkw2SHNRZk1TTGRm?=
 =?utf-8?B?Zmo4OUoyV0l2VEUvOVFFNXh6YnFnUUpVN3dVVTlUaW9hbUJYREZhOHVzQnIy?=
 =?utf-8?B?Y3NGajRJTlNqckM2bVgxWGZMTzlINTZxdi8wVnl6T1lCaHZVSWRwMFR4RHJl?=
 =?utf-8?B?VjByM2EwRmk2Z3h4K2pkbURIY2ZFY29Ub2Yrdk1iZmh4RmNjZ3F5b2U3aFcw?=
 =?utf-8?B?MkF4Q1NxT3NKbmhvWjkrOUJqRnBiVldVNU9yUzNMd3YxN0RUZXZxSitjeGJQ?=
 =?utf-8?B?blNNNHBSQVorRlgyN2lEOWFGTk9IdWVvenhxOUROVXpROURuS28raW9Xbjc3?=
 =?utf-8?B?dC94RndPb0dpZVR1MmhiamRZbm9Zb2dnOUU4dXR5WWkxbDJXclhLUTBVYXVI?=
 =?utf-8?B?K1YrMFIvSHhndWFZdTl1UkZ3YVMzazJvM05mREhiY2VOU21BSWN6aUdtTDUz?=
 =?utf-8?B?WFB0NllOMG10S25JTjBIbWl4czYzUjB4MS91UDNsNHRsMU90RncwM2V1bTdI?=
 =?utf-8?B?Y3ByakhXSFN0V2xPS2Q1Mk9vRFJxazQ5NjAzSDMyTmZmelJNSGlSZU0yZnZt?=
 =?utf-8?B?a2ZTSHhJSGwxNHpOdjhOdS9XNzBIU24yT1YzdmxYdmFxM1B5WlJBTlQ1UCtT?=
 =?utf-8?B?Yjg0K0hyNWhKSzFzYVNoN1djSGh3TDdkb2dGR09TTURKNmJiTkxIZ1BkbWN1?=
 =?utf-8?B?Rk5zZ3dlbllVeU9mY250dTVUYkthZFd6dnNYU2JobkhuNlZkOG9SS2R3RGF0?=
 =?utf-8?B?d3RjdHBDNlV3c1ZFM2cwdnRHSlZweFNMVWVzNW9kLzI5K3U1OG0zNHB5eTIz?=
 =?utf-8?B?UFUzUFlEZy81RXJkcU9Va29yeG9RVHdHQkRTa0hJVWZKNnA3R1gyaG9BM1Ay?=
 =?utf-8?B?a2tGL2tMRHFjR1NEblliWlBxV0RmTys3c2Y4MmY5Wi9YRk5iVHA2RDRXRUF5?=
 =?utf-8?B?ZUNvdEdWSUpraDkyM2Z3ZUF2bXhoZXBKQm02QmVsbVBDYUcwNFhKSTNESS9W?=
 =?utf-8?B?aHJxU0VGYXBUbUJoMm05a01lbkRNQ3VaTHI0VWtoallIT2ozbEZVRytuNTI4?=
 =?utf-8?B?OWxSN0M1QS9MOTluaG5tekdZRjloS3laa1hEQ0tad1BIVzAvRXh1aEVXZ3Ru?=
 =?utf-8?B?MUgvTFVFalFQaEFxektCWmhPQWI1REZGNDQ1ajZEa08yRnYrbU1zbWNkZUJs?=
 =?utf-8?B?YW5ORlVkMG5LUDYyWlBxR0Z0QnZUY2x3Zkt5QkU3cVE4Q01FZk02U3VNZWYv?=
 =?utf-8?Q?ZjXo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd89e76-1fe1-4a67-5535-08ddb7b51270
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 09:04:08.2429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p47HJHrmAy9BJdxJfzEcBgNbrlYUZ0NlO4r3wR0XsJabRf2ZJPQt1MhxDMm8LZDVzcADBqbfcvM0zIf9eW657A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5195
X-Proofpoint-GUID: 9-7CvafkH-psI0gVjirgHtEShRsy7tmB
X-Authority-Analysis: v=2.4 cv=K8oiHzWI c=1 sm=1 tr=0 ts=6862530b cx=c_pps
 a=8pvF1+Jk5vGtK47n9Xt15A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=NEAV23lmAAAA:8 a=la4Y4K59_9OsDHaIHqwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA3NCBTYWx0ZWRfXzkald5zvEhBf
 FFRwU3ECwcN7kdBQ0PhXQkMOhXnZpvqSs7512OAosG0X/PKD7gA+HyCK9fMV9rT9efGnXCpWD2d
 qmynBFyYs5qcIHcGWm0RpwD47WYZddT6jlEiU3NIZTDH6ebyAAJr0mBTVQM97rzMEDre2WkyOzn
 dVH1TuUmuJpyICxHto26CZT4OL9FhG9EF2f1i6LImThLiVEuLn3Sms7vWa0wAqsvLDlVv5sb3TI
 IKhmS8zw9R1PW5ThbbJdUYmAEOH60s2878nsj9N1Fr3suct4Vj6Lpdp3ReuI4+PyJZJM5JzBI7A
 zBXnhy8Gq1FFe8+aV78tt7Huy+jDrp1Kn27Y4sw8GLP8WglaoJCml4Ma2/Uc3NcW3LJGPKWR4Gh
 AJMfM7cshGnQo93ZKXh/nVjYfbulGhtymj3dsDJn/Ut0d7VVZO/YvvpAmUB2Niu0OjQdhAWI
X-Proofpoint-ORIG-GUID: 9-7CvafkH-psI0gVjirgHtEShRsy7tmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_02,2025-06-27_01,2025-03-28_01
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

PiA+ID4gbWFrZVsyXTogRW50ZXJpbmcgZGlyZWN0b3J5ICcvaG9tZS9nYWtoaWwvdXAvdWFkaycN
Cj4gPiA+IGRlcGJhc2U9YGVjaG8gd2RfYWxnLmxvIHwgc2VkICdzfFteL10qJHwuZGVwcy8mfDtz
fFwubG8kfHwnYDtcDQo+ID4gPiAvYmluL2Jhc2ggLi9saWJ0b29sICAtLXRhZz1DQyAgIC0tbW9k
ZT1jb21waWxlIGdjYyAtREhBVkVfQ09ORklHX0ggLUkuICAgIC0NCj4gV2FsbCAtV2Vycm9yIC1m
bm8tc3RyaWN0LWFsaWFzaW5nIC1JLi9pbmNsdWRlIC1mUElDIC1mUElFIC1waWUgLWZzdGFjay1w
cm90ZWN0b3ItDQo+IHN0cm9uZyAtRF9GT1JUSUZZX1NPVVJDRT0yIC1PMiAtZnRyYXB2IC1XbCwt
eixyZWxybywteixub3cgLVdsLC1zICAtDQo+IERVQURLX1ZFUlNJT05fTlVNQkVSPSJcIlVBREsg
dmVyc2lvbjogMi45LjBcIiIgLQ0KPiBEVUFES19SRUxFQVNFRF9USU1FPSJcIlJlbGVhc2VkIEp1
bmUgNiwgMjAyNVwiIiAgLWcgLU8yIC1NVCB3ZF9hbGcubG8gLQ0KPiBNRCAtTVAgLU1GICRkZXBi
YXNlLlRwbyAtYyAtbyB3ZF9hbGcubG8gd2RfYWxnLmMgJiZcDQo+ID4gPiBtdiAtZiAkZGVwYmFz
ZS5UcG8gJGRlcGJhc2UuUGxvDQo+ID4gPiBsaWJ0b29sOiBjb21waWxlOiAgZ2NjIC1ESEFWRV9D
T05GSUdfSCAtSS4gLVdhbGwgLVdlcnJvciAtZm5vLXN0cmljdC1hbGlhc2luZw0KPiAtSS4vaW5j
bHVkZSAtZlBJQyAtZnN0YWNrLXByb3RlY3Rvci1zdHJvbmcgLURfRk9SVElGWV9TT1VSQ0U9MiAt
TzIgLWZ0cmFwdiAtDQo+IFdsLC16LHJlbHJvLC16LG5vdyAtV2wsLXMgIi1EVUFES19WRVJTSU9O
X05VTUJFUj1cIlVBREsgdmVyc2lvbjogMi45LjBcIiINCj4gIi1EVUFES19SRUxFQVNFRF9USU1F
PVwiUmVsZWFzZWQgSnVuZSA2LCAyMDI1XCIiIC1nIC1PMiAtTVQgd2RfYWxnLmxvIC0NCj4gTUQg
LU1QIC1NRiAuZGVwcy93ZF9hbGcuVHBvIC1jIHdkX2FsZy5jICAtZlBJQyAtRFBJQyAtbyAubGli
cy93ZF9hbGcubw0KPiA+ID4gd2RfYWxnLmM6IEluIGZ1bmN0aW9uIOKAmHdkX2NoZWNrX2NlX3N1
cHBvcnTigJk6DQo+ID4gPiB3ZF9hbGcuYzoxMDY6NDQ6IGVycm9yOiDigJhIV0NBUF9DRV9TTTPi
gJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMNCj4gZnVuY3Rpb24pDQo+ID4gPiAgIDEw
NiB8ICBpZiAoIXN0cmNtcCgic20zIiwgYWxnX25hbWUpICYmIChod2NhcHMgJiBIV0NBUF9DRV9T
TTMpKQ0KPiA+ID4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXn5+fn5+fn5+fn5+DQo+ID4gPiB3ZF9hbGcuYzoxMDY6NDQ6IG5vdGU6IGVhY2ggdW5k
ZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3INCj4gZWFjaCBmdW5j
dGlvbiBpdCBhcHBlYXJzIGluDQo+ID4gPiB3ZF9hbGcuYzoxMTU6NDY6IGVycm9yOiDigJhIV0NB
UF9DRV9TTTTigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMNCj4gZnVuY3Rpb24pDQo+
ID4gPiAgIDExNSB8ICBpZiAoIXN0cmNtcCgiKHNtNCkiLCBhbGdfdGFpbCkgJiYgKGh3Y2FwcyAm
IEhXQ0FQX0NFX1NNNCkpDQo+ID4gPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fg0KPiA+ID4gd2RfYWxnLmM6IEluIGZ1bmN0
aW9uIOKAmHdkX2NoZWNrX3N2ZV9zdXBwb3J04oCZOg0KPiA+ID4gd2RfYWxnLmM6MTI4OjE1OiBl
cnJvcjog4oCYSFdDQVBfU1ZF4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0
aW9uKQ0KPiA+ID4gICAxMjggfCAgaWYgKGh3Y2FwcyAmIEhXQ0FQX1NWRSkNCj4gPiA+ICAgICAg
IHwgICAgICAgICAgICAgICBefn5+fn5+fn4NCj4gPiA+IG1ha2VbMl06ICoqKiBbTWFrZWZpbGU6
MTA1NTogd2RfYWxnLmxvXSBFcnJvciAxDQo+IA0KPiBUaGlzIGlzIHNvbHZlZCBieSBodHRwczov
L2dpdGh1Yi5jb20vTGluYXJvL3VhZGsvcHVsbC82NzkNCj4gV2lsbCBiZSBtZXJnZWQgbmV4dCB3
ZWVrLg0KDQpTbyBhcmUgeW91IGdvaW5nIHRvIHVwZGF0ZSB0aGlzIHBhdGNoc2V0IHdpdGggbmV3
ZXIgdmVyc2lvbiBvZiB1YWRrPw0K
