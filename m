Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5BBC5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 05:12:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F76C41109;
	Tue, 10 Jun 2025 07:12:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CC46F40276
 for <dev@dpdk.org>; Tue, 10 Jun 2025 07:12:02 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A42f5D019254;
 Mon, 9 Jun 2025 22:12:00 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2135.outbound.protection.outlook.com [40.107.236.135])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 476db0r45t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 22:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fO5Y/1zUshKp9JtbqWBJVJCBKByZMuxFdKbxc0QaebpxwTr30ZJDbFDDmyPfbJV++3J4Otp0YmLQnytZ7g2OeHKVyyWyEL+lEluuFZeU/uFEF2OXE/I27zme2nXE5gZAZ0NIf/ITq7Fn4lKkpMn2Q43GijDpPwM5SJLrA7dwb/arVEBpQtQ4tuPQqxA6d75BP5Q/939E3gWSGjLULFIb9OhE/o4GAKsX4WrJs0LOISqwV4c1rqJnsU9I2AER/kiPmul+bCabPMai53jESRoLqwre4KeWL8sjj3S+tcWN0/KSPC1VqDbISfJyWdVKS3qmrvLupXgY85V2yWmFOIxmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+bRFoyyWblMS2bmmtF+SBe1FCYLLaHI6iyKGTwucN4=;
 b=mxejjv51cQkOhGKNBfrCx79vhpq7Ipag57jH9Xpf1IjgVwomcB43G6YZFE4SX208nS0G2sGcDcxB5IetqeIJLdElBI6X44V2t/HN257v22WeHhKEKPsB7BXRvbXJDxyz56Is91N1EjHOtnbVYFy6H2dE4XYLy8rIGByRRTS9cGLH9g1DgHnPzVQHArfbR1fpK9sC1840JQNj1OaLTQhzqBNUSnxGy3dy8w1J0YtG/lK8YSSfWFGJSHe3iaUEuH9CoFU8gtJJz4o3dUTDPmvIIGa3OCTewfN3uKoE74/acFBU54i7tfUZAopn/jf1YvGRQdXIX787V4fWGFdm/plYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+bRFoyyWblMS2bmmtF+SBe1FCYLLaHI6iyKGTwucN4=;
 b=S8YuZm/JiQ/aKiFOzSqQQ40otFyVfqHDLP8JtH12fqSOb45QSujJk5Fphwut62QaZ16L9JczJn1N5lN5o0MMV5cX1OyCWAuJs7oeyObLbA7VfqESSMl0JbU3ulYOin0egV9h2YYGDC5VCNJ8P1i/z+EiOZfglXF28stAcgUHMfE=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by SA1PR18MB6068.namprd18.prod.outlook.com (2603:10b6:806:3eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Tue, 10 Jun
 2025 05:11:58 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%6]) with mapi id 15.20.8792.036; Tue, 10 Jun 2025
 05:11:58 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Konstantin
 Ananyev <konstantin.ananyev@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: RE: [PATCH v2 2/2] ethdev: remove callback checks from fast path
Thread-Topic: [PATCH v2 2/2] ethdev: remove callback checks from fast path
Thread-Index: AQHbw0+l0RHSW4O8306bysHIPKBvWrPn4SoAgBQkLbA=
Date: Tue, 10 Jun 2025 05:11:57 +0000
Message-ID: <CO6PR18MB386002BE3B4FF5646A41404AB46AA@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250429181132.2544771-1-skori@marvell.com>
 <20250512150732.65743-1-skori@marvell.com>
 <20250512150732.65743-2-skori@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC9E@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC9E@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|SA1PR18MB6068:EE_
x-ms-office365-filtering-correlation-id: ebe845ba-3f5a-4b9d-7257-08dda7dd5319
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bmhlTHZPQWwwZlNCbXIydk1hbHp2TnQ4L3RLSkJYZURKamh6OGUrUG8vVllZ?=
 =?utf-8?B?aktLcG1DT0MxUGpCVXBVL3ZOemRSYy9ERnNoTlFpRWI3MnNidUpkUnlUd3JW?=
 =?utf-8?B?K3ZDRTc2UmF5SUhXNFNwSnVQZGRXbmZacUhRd2pBem5ZWG9oS1N6NzA1NnYr?=
 =?utf-8?B?SURCOGhKenpwaTZ6ZnE2cTVqRjhmcEh4SlAzNFZoSURzMUhYSEUweXl5V0xs?=
 =?utf-8?B?WWJqUGlISXJldy9HTm9iNmdHMG9wWXMzRjF1MC82ZW9WYzVjS0dqOVN3Mzg5?=
 =?utf-8?B?UDV6VHBsejcxeG1UdVVEanFQSFNlVXk2eWoyVzNrMU5nTXpIYy9kNGYyeEcy?=
 =?utf-8?B?eHlYUm9NQ0dDd3dIemd2MjFtWTE2OUtmMXpvZG5LbWtWZHN3UHVmRmxETUJO?=
 =?utf-8?B?am4wZ0RQUklLMUpBMVhGQ2x0WWtOWlhWRFhEQkRoTU1jdUU5Z0pIOVJqdTRB?=
 =?utf-8?B?ZmlOUmZMNWdRS1VGOWJBSUw2OXpJbUFBL1RWbXNjMi9ueC94YTlHWndjSTRL?=
 =?utf-8?B?MmZ0bTBJdXVhUFBmUm13YVRBWUZ6dFBaUHIrMlVHdEdRUXVZUEJoenpOZm9h?=
 =?utf-8?B?amE2bkUyc3ZXSG1JbUNzVUE2b3J5bnZRVElTS1phY0U2Y0JTTWdxTnRTcG4x?=
 =?utf-8?B?TjlYTkpFNmV0c1JWNWRHaEZXbzdnMUhUeUFKS0ltSWNpemttN0puVkFMNU5D?=
 =?utf-8?B?Rng2Y3FUZDQ5YlR6d1hISUoxZWZiWEJFU0R4MldxMGU0bCtlNGlNV09oZzdC?=
 =?utf-8?B?eUp4RjN2UzBqWlc4UFRJODc1bk5IeTRTemFHZURubjZaYWU5QmUrOGJ5Wk5y?=
 =?utf-8?B?QnlKamZ3MTFWRHhUMnJoYmRCNFlQQ2Zpb2cvVktVUmNiUnNPbXE0dStCR2Ny?=
 =?utf-8?B?TnRuUytJV0dyQU1Ed1JFN3poSU8zNW9NUHFTRGpGMWNPa2pud05sRTUyT0Rk?=
 =?utf-8?B?RXZiWHFNSHlPeWtucExad3NybXRiNGZPVXVLaFhtSm1PUzRJZDJHTGoyQ3R1?=
 =?utf-8?B?ZjI3MVA2QXExNFNMWTJkUnh3MUxVd284SnF4UTJjOXFZMk5mM0FQWldYdjZv?=
 =?utf-8?B?YWtyOS8wS1d6S0UyVFF3QkZJR05UckV6S2VxWkFxMVQrTW15SmY2VGxxcmt3?=
 =?utf-8?B?WUdWUC9idEdQdFFLaTBWRXBQaW5JNnlmT014bWhXSTRkVWtRMm4vOS9TYzkr?=
 =?utf-8?B?dkovYkhqamcxTTdxMXdmMnhjN2ZmN05MWmg3ZnlhQTRxbW54bE1rK3ZZZDF1?=
 =?utf-8?B?T0Yyek5iSkdBZi9ieStGYU9YREFyY2I1SFFJL0krcUVwd3VWbHQyd3MybUpz?=
 =?utf-8?B?UVRId0JQbGFscWxNKzNiSG83Qml5L2N3YzVQZk9kYkl2TDdDbnA4d1F2OEN3?=
 =?utf-8?B?YXZuSVZ2QjJaZVNPUkhDVkZIMDRub2l2eFpnUS9pL2RZaHdFWnd6cnZvYk9S?=
 =?utf-8?B?aVRYZ2xYVnJhcXdmWmNHUE1RWGNvdUJHRzdFVjdtWFVjZWZrT2NpVmhLenRr?=
 =?utf-8?B?WTVyWlJjNVVGZ1dhaUZYbUNYRXpjUElKQmQvUjNZNWtCdkpUclBCOGg2c2tT?=
 =?utf-8?B?Sm1HTWMweGdya2w2V09yZmxYa3RGbWNVTjZLUTJUbWNrVGpmeGFJRURMVFFx?=
 =?utf-8?B?N29rVyt3VmtOUTlwdkhlZitLbjBqT2xMZzl5WURid0M5SVFzNkM5TmdmSDMz?=
 =?utf-8?B?RU51SldrZnlWa3Vob3ZOLzlDcTRnVHNnd21WemZpMUp1anZadUpxQk52bURR?=
 =?utf-8?B?UkI4ZDJESU5lRllsQTNKZDNyZk9KSUw2WE5XTGRyZnE1ZHhiL0lScnVqVDZG?=
 =?utf-8?B?Q0k3WjZCeVFKWWhLT0VzeDBVaU5ockRLcWdJRk5hRStUcGR4SVo4S2tvcUZD?=
 =?utf-8?B?YWgwU3pkekhOaWF6UVFDUVM4VjFiTWdIZ21qUDk3QVJ2eFpReDVBeFBjMUl6?=
 =?utf-8?Q?rOQBKIvnr1E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0pQN25kRXA0MkVVUWJjS091SGMvMXFrL1hMQy9iS3hWcGVvcldueFU5Y2dM?=
 =?utf-8?B?Y1g1RWMzQi96YXJlTlBOMU9HOUVIV0Rkb0kvb2I0RUxPZ001Yi9vOStuYkcw?=
 =?utf-8?B?TFppcFhjdjlGWjZ5R09MSWJ3M0t6dUluY2RTTSs1Y3doS1R2QnlHMStzQXNj?=
 =?utf-8?B?MHdOQkJ2T0JYNHlKcm5heUllYjRIOWhBNW44dksxN0s3aVg2OEJDbmk1WEE4?=
 =?utf-8?B?TUl4M0V0bituVmtTay82S09tNk85Y0t4eTBFY0FxWDhwbU5UaWJjYW1ZK3E2?=
 =?utf-8?B?VWZhOGcyM2g5eGozazNKb2NpUEozNjhqRXNTeThIWVRWMUJlS2xZOW9YZEIr?=
 =?utf-8?B?a0RNQjNKeXMzNkZQUEthL083RFBFWWZ2Y0E5T2twcEQ4Zy9ZbU11RkpsMXVi?=
 =?utf-8?B?NEozRlU0MHhCdFBQS3hRS1NDeG9UNWRSanhVQlFxdTRGZWI3OFFBNjArLzEw?=
 =?utf-8?B?TDRleUphQ29peTR2bnVCd0JxN00yNUQvY3B3SCtPZXJ1TFFxZzk3OEhDeHZV?=
 =?utf-8?B?c2l4TVFTUzF4dUlDYm02SkxzdnE5OWdtcW5EN09VdHlrTWZpREFyWGRYODds?=
 =?utf-8?B?dFUxVkRQQWc2TWNLWHVuVEZYWkJhWXBPSUNTZm9UekRKMzZ2N045eDZGZytk?=
 =?utf-8?B?QVF2WFNPMVVxRHhDTUtaMXFqZXV4ejRQcFB6dGlzUUx5WkdYZGVmTXY3MXls?=
 =?utf-8?B?MXZIbEJ2NmtQZmczNXR5SVdEdlY3TEIrNVdrRXhwMGFjeHk1alR1WHh3cnRT?=
 =?utf-8?B?K205eEhLNTdlWkZXOU1nZWFZMVgzTlNuZ2JwYTA2SDRicS93OTVxOWkwM1VQ?=
 =?utf-8?B?cGxDSExhTklqWTkzckZpNWx6cjRTNGZnMnQrWmEwTkt3MWJZWDNxWFlsT1Ft?=
 =?utf-8?B?Ni9yTFJIbk1LS1ZOT2NycjN5S1Baa0RzdDFVZlJHR1ZNbkU1L1JYL2ZicDd3?=
 =?utf-8?B?a3lMR3RVTCszUXRSS1htN2JvbkQxeFFZK21GRFZmZmc2NUVGR0lTU2pJN0pI?=
 =?utf-8?B?dTJhSm9ETWxqaHF6Z1pLc0lqMmhqcWhBN2JrOEYyZHBwN1J5MjJBUmljekFm?=
 =?utf-8?B?WGdUWUlNTnA4dzJ2dHl1TXM2d3VnMnArbEJodDJ6T1I5RFNqZzFkdGsvTVpT?=
 =?utf-8?B?cWs0dTJheEpCT0dYYmVncXY1aFA2OE9HaTMrVWdPTWx3NVA4NjhWRXRJR3lD?=
 =?utf-8?B?YnpEaUJvOU1kTXcrYTJXbXVoMTV0cVdLQWhRMlF5bDN6a255N0NaZTg5eC9o?=
 =?utf-8?B?WWxGVFZOWXJjbnRFRUhBbWxKSW5ZemZhNzJDZkRTb1lLVlptOEdxNWxLVE50?=
 =?utf-8?B?bGthWENBcjJoaGVYMldJUU0xT2g0aUhuTDRHUFdFY1k3UUFBSTlPOWt3MzlZ?=
 =?utf-8?B?NTMxZ2xUK3I1anIxVFdOOEkxazZHeFJIR2pLQUdONCtaaTJMK3JJMTlkUi82?=
 =?utf-8?B?ZHdDeEZDTzBkUFdodUF4ZFpNVElmTXpROGhUYlRmTUtoc0NKNFg1bXNSbmRS?=
 =?utf-8?B?R0x0VnFXVlo1RC9qN0Z0RE5OdkRFb1pCSEdwcnloNndFVXJpMWdIcWFxMXhl?=
 =?utf-8?B?UmVXMTlTUjlnSzRFdkdBUlJiQjdOdktiZ1ZlTFVhanJPMC9CZ1VYbDhONG00?=
 =?utf-8?B?SkhSZkw3MnhGK2swY3B1SGoyd0RobVpobUpGczV4M05ISGdSaDdYeGc3UXBo?=
 =?utf-8?B?QWVyRzk0Q1hPTlFLdkJhL2IyZmFGY1RIZmhMN05WNHZFNXFKSmVRZHVBNjV2?=
 =?utf-8?B?UDhGbk51amQvT1dyV2hJRzZZcSsyMkFvMStQcmtROFNrYjc0VkZsWUM5L3VU?=
 =?utf-8?B?Z0JEemYyanFoZHJ2ZTBKdkVwM3N3dHU5dGMya3JGQzErMDlWWlkvLzd2bnZy?=
 =?utf-8?B?NEVpUUNibnpjc0tHVEhUNldQa2hpOUwxb0JzdEdyMU9DTVNNTG5Selg4WENM?=
 =?utf-8?B?WVRVU1VKYzRuT3ZacjB3OWJ5ZGtJRUJLM3lQckVQQytqZDd6b084bG1Laitt?=
 =?utf-8?B?UmtGdzNreVZYeCtUVklOWGhITGQwenFGSHRtay8rNFVTcWx1K1V3SjNMSWdQ?=
 =?utf-8?B?YmtZZW5KbEdsR09VNVBiQzJuQlA0dmZnbHUxRzF5dDFVdzdKUklSVENUL0NC?=
 =?utf-8?Q?7ei4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe845ba-3f5a-4b9d-7257-08dda7dd5319
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 05:11:57.9817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RuzPUCEZj76yuJjj7gKo5VOFY9mRCD9JfiAX5vanpNhGe6dxPcDx2RVxZZOI+1J1nDbRqRyjxVsgddaPXcJgQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB6068
X-Authority-Analysis: v=2.4 cv=GOgIEvNK c=1 sm=1 tr=0 ts=6847bea0 cx=c_pps
 a=zyo/4fEFTQ0kavnXrlnuAQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=RpNjiQI2AAAA:8 a=M5GUcnROAAAA:8
 a=i0EeH86SAAAA:8 a=RZc8XGOI8Q-zqoBdT_gA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: YlCK3gR9iWE87f2yGrac9PS2S2nqI2dl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDAzNyBTYWx0ZWRfXzVCTGZH8Sj0u
 /S7GTU+yfwxja1pAUl0ceRU5e/QltgIyojGn6kccPKLXe1WV1igDEpgjn+TEwfwD77/kKm80J1J
 gaKQvwCUAgc1/Zlu6KjPOeKZPl9NMYEvHCo0OAkjYflnQyX9OZya4WpRcWlh2w+Rh8OZEpvqhyY
 NTpaAWnA+KODjjrI5nrbB/4ywECWpiOYqQz2XDAHZ+7381s5WGAf1yVMZ3XMuLt0yCMEBWFmz+r
 evW2tXKs6voJW8DDdm6ZkJDTJUqPBedhCFRtSoIzxAjjsR+bEDekOXimspQ2OIVwHp2QuVHJ3OP
 t5jeAr3pbdhRmXkrIfrFzfzawOEvKA6b1rfSU1l+l1KTx/wzdX95VJdj/iNzv6HpyKuuahNNldh
 05eYFbOk8hWufpdzqCQFAbUDYPOrO9GXitJWNGkybpns7SQ9dwjgUVd5OTbJ3bb7BnDDY8OX
X-Proofpoint-ORIG-GUID: YlCK3gR9iWE87f2yGrac9PS2S2nqI2dl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_01,2025-06-09_02,2025-03-28_01
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

PiA+IEZyb206IFN1bmlsIEt1bWFyIEtvcmkgPHNrb3JpQG1hcnZlbGwuY29tPg0KPiA+IFNlbnQ6
IE1vbmRheSwgMTIgTWF5IDIwMjUgMTcuMDcNCj4gPg0KPiA+IHJ0ZV9ldGhfZnBfb3BzIGNvbnRh
aW5zIG9wcyBmb3IgZmFzdCBwYXRoIEFQSXMuIEVhY2ggQVBJIHZhbGlkYXRlcw0KPiA+IGF2YWls
YWJpbGl0eSBvZiBjYWxsYmFjayBhbmQgdGhlbiBpbnZva2UgaXQuDQo+ID4gVGhlc2UgY2hlY2tz
IGltcGFjdCBkYXRhIHBhdGggcGVyZm9ybWFjZS4NCj4gDQo+IFBpY2tpbmcgdXAgdGhlIGRpc2N1
c3Npb24gZnJvbSBhbm90aGVyIHRocmVhZCBbMV06DQo+IA0KPiA+IEZyb206IEtvbnN0YW50aW4g
QW5hbnlldiBbbWFpbHRvOmtvbnN0YW50aW4uYW5hbnlldkBodWF3ZWkuY29tXQ0KPiA+IFNlbnQ6
IFdlZG5lc2RheSwgMjggTWF5IDIwMjUgMTEuMTQNCj4gPg0KPiA+IFNvIHdoYXQgd2UgYXJlIHNh
dmluZyB3aXRoIHRoYXQgcGF0Y2g6IG9uZSBjbXAgYW5kIG9uZSB1bi10YWtlbiBicmFuY2g6DQo+
ID4gQEAgLTYzOTksOCArNjM5OSw2IEBAIHJ0ZV9ldGhfcnhfcXVldWVfY291bnQodWludDE2X3Qg
cG9ydF9pZCwNCj4gPiB1aW50MTZfdA0KPiA+IHF1ZXVlX2lkKQ0KPiA+ICAJCXJldHVybiAtRUlO
VkFMOw0KPiA+ICAjZW5kaWYNCj4gPg0KPiA+IC0JaWYgKHAtPnJ4X3F1ZXVlX2NvdW50ID09IE5V
TEwpDQo+ID4gLQkJcmV0dXJuIC1FTk9UU1VQOw0KPiA+ICAJcmV0dXJuIHAtPnJ4X3F1ZXVlX2Nv
dW50KHFkKTsNCj4gPiAgfQ0KPiANCj4gVGhlc2UgYXJlIGlubGluZSBmdW5jdGlvbnMsIHNvIHdl
IGFsc28gc2F2ZSBzb21lIGNvZGUgc3BhY2UsIGluc3RydWN0aW9uIGNhY2hlLA0KPiBhbmQgcG9z
c2libHkgYW4gZW50cnkgaW4gdGhlIGJyYW5jaCBwcmVkaWN0b3IgLSBldmVyeXdoZXJlIHRoZXNl
IGZ1bmN0aW9ucyBhcmUNCj4gaW5zdGFudGlhdGVkIGJ5IHRoZSBjb21waWxlci4NCj4gDQo+ID4N
Cj4gPiBJIHdvbmRlciBpcyBob3cgcmVhbGlzdGljIChhbmQgbWVhc3VyYWJsZSkgaXMgdGhlIGdh
aW4/DQo+IA0KPiBUaGUgcGVyZm9ybWFuY2Ugb3B0aW1pemF0aW9uIGlzIG1haW5seSB0YXJnZXRp
bmcgdGhlIG1idWYgcmVjeWNsZSBvcGVyYXRpb25zLA0KPiBpLmUuIHRoZSBob3QgZmFzdCBwYXRo
LCB3aGVyZSBldmVyeSBjeWNsZSBjb3VudHMuDQo+IEFuZCB3aGlsZSBvcHRpbWl6aW5nIHRob3Nl
LCB0aGUgb3RoZXIgZXRoZGV2IGZhc3QgcGF0aCBjYWxsYmFja3MgYXJlIGFsc28NCj4gb3B0aW1p
emVkLg0KPiANCj4gWWVzLCBhbHRob3VnaCB3ZSBhbGwgYWdyZWUgdGhhdCB0aGVyZSBpcyBubyBk
b3duc2lkZSB0byB0aGlzIG9wdGltaXphdGlvbiwgaXQNCj4gd291bGQgYmUgbmljZSB0byBzZWUg
c29tZSBwZXJmb3JtYW5jZSBudW1iZXJzLg0KPiANClN1cmUsIEkgd2lsbCBnZXQgcGVyZm9ybWFu
Y2UgbnVtYmVycyBmb3IgTWFydmVsbCBwbGF0Zm9ybSBhbmQgd2lsbCBzaGFyZS4NCg0KPiBbMV06
IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0NCj4gM0Ff
X2luYm94LmRwZGsub3JnX2Rldl81ODFlN2E1Mzg5Zjg0MmE5ODI0YTM2NWE0NmM0NzBhZC0NCj4g
NDBodWF3ZWkuY29tXyZkPUR3SUZBdyZjPW5LaldlYzJiNlIwbU95UGF6N3h0ZlEmcj1kWGVYYUFN
a1A1Q09nbjF6eA0KPiBITXlhRjFfZDlJSXVxNnZIUU82TnJJUGphRSZtPWtDY0hTZjY5N1pHQWxt
anRPWEdKZTloN1ZOelFnN3l4aFUyYVlSYmYNCj4gLQ0KPiAzZkROYm5uS2piZVpVcWdNcHZoTDhY
ZSZzPWVvYl9UWlpzZWtBZURER3pEMTVRTU9oaHBiZTdQUVNjSkxMUDZJTXJxZw0KPiA0JmU9DQo+
IA0K
