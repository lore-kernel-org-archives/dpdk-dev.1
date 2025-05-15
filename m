Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FAEC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 18:20:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED90240EDC;
	Thu, 15 May 2025 20:20:54 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1521E40E03
 for <dev@dpdk.org>; Thu, 15 May 2025 20:20:53 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54ENSkif004809
 for <dev@dpdk.org>; Thu, 15 May 2025 11:20:53 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46n4vtj8jh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 15 May 2025 11:20:53 -0700 (PDT)
Received: from m0431384.ppops.net (m0431384.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FIK5wJ004866
 for <dev@dpdk.org>; Thu, 15 May 2025 11:20:52 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46n4vtj8je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 11:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rovA8AS+StmehodiKmTVxKorHXUnPaWolCFgJ+NfCGvsTjHwgRVxGLQHsCOgoTZd7EHyCqoTX0jESK3rWH3uWW770pegkHQ8lPcaRC3gXmyjUsGgceO2vikhW9iv9mbE9xyOoQP8tI5ZhvVxkEJKrKAoggXOvgyK+MaODx1AOK5xk2aGUkQAw2jOpW3jo+YA77rDbd11upkf7EPOCnwgI6km15rTWqHKYl6BIKU12ilQMOEU9PfamrqF51ZXDc9+U3JEICvjKEQtF2dKT1jpwQmmNmaXbO6pte1wSZn939BxmOo050dwB036qLL23QoFZxYuwwJj7SWTUc5ZYY67iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nN2+CHgb0SM9qY3tZD+sKBlGkeu5QVxp5qo4OQCrYM=;
 b=xpmPWBX18Rtc/rZvEcWk/CDb9zUelGhv8uswndGjLn+gTHFoubi5/q79cHzaoGRhTlO3LIvVS8XjHoRZB2HThv3wMi8QD8TayXM52EoPCqDz2ByhT130speHSQ9ZM/icZOzMeD63fUeQh5dBmA0VkDHCtnE/7HmT6oiRIjWgdrpH0vf7z2100oGHCR975KLOpfmhdmWZL6DLE0BULasGtCztnGjcZwySTtyRx8r4hvUAlHnswTcaiG9Iya6z9CemyRv7jQnfh1xkeopxVtG4/SvTrplU5/dIDr7qYC9NTSmuB9P67NC9Z/pm4+sAoqMN64BZ3j8AXQyllYyzNJslDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nN2+CHgb0SM9qY3tZD+sKBlGkeu5QVxp5qo4OQCrYM=;
 b=T7gO1e8v+yDwMVzMsWZ/PVAwIGMu/bwPkk6bAVexFlOdyJQysdskXl3iBHDhwTBOIT0aWkAKsJGoYrhYTxXm0kzBVb3+qFEaYOXb+NUUEFO4sKmibo2otytWANc6xpxho/idsccn0ThlSEYWcO8ISEvIrZ+5Mvz4+lHJarR0w2s=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH4PR18MB6237.namprd18.prod.outlook.com (2603:10b6:610:22d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 18:20:47 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 18:20:47 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Hanxiao Li <li.hanxiao@zte.com.cn>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v3 0/9] crypto/zsda: add zsda cryptodev driver
Thread-Topic: [EXTERNAL] [PATCH v3 0/9] crypto/zsda: add zsda cryptodev driver
Thread-Index: AQHbxYORTDmPnmfwYUabPEDO+E3T67PUAPUg
Date: Thu, 15 May 2025 18:20:47 +0000
Message-ID: <CO6PR18MB4484AA40540817FA10BE25A3D890A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250303082751.1053432-2-li.hanxiao@zte.com.cn>
 <20250515101927.1926502-1-li.hanxiao@zte.com.cn>
In-Reply-To: <20250515101927.1926502-1-li.hanxiao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH4PR18MB6237:EE_
x-ms-office365-filtering-correlation-id: 0241ca08-30e0-40bb-1fc9-08dd93dd3701
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cyt2NG1KNnVIOUVIY3RydDk1NGlxc0hnN24xK0FPYUJ4TnVJd2JzWlpkZnpI?=
 =?utf-8?B?Qnd6bEx4QW1kbjl4QlNJY0tzMUJRQUpYSGFlMEJYMGpOcVFBTkw0TUZKOXoy?=
 =?utf-8?B?cE9WYWlmeFJaUHlxUzZOSDdBM2dVQkRyb00wVjAyUHJoWXp1N0RaeExXL1Jp?=
 =?utf-8?B?RXY3K1JwVHZtZURkV29DbU14RXBCMFFWUG1DOEsydHNyM2dLWWJYM2NtbDVF?=
 =?utf-8?B?ZmpMVSsyencrS1hPMWdnZDYzWmdEdHEwZm83YzhPNTFEbWdvL05QdkRPQkt5?=
 =?utf-8?B?YnYxVXZnbXZ5d3JlSVNtbHVvZCtIbWtIa0pPdFNlTTFwNVdhbUNIaXVneGE3?=
 =?utf-8?B?MHJJdjZvaVQvRnZjVlIwKzVGMFdVcWNFcWZJbTk5eUpEZk9vMGFKeG9jaTM4?=
 =?utf-8?B?b00zMzhFQWZNRU9VcnFtUEErUUpac1ZLRDkzUTlyK1l1VzhZdEZzK0QrWGZk?=
 =?utf-8?B?K2JrOElQUTVZSE95b0lMK3VkNk1FVzgrZG9PWDVOSkp2NWt0V3dqUXJqN2x2?=
 =?utf-8?B?R3lyK3FyeVkva2dWeHN1NWFmOFhsNkR3WkhlWXFNbzdBUWxSRTNoaHU5bWxP?=
 =?utf-8?B?MzRoamkvVEZ5bW1sWWludWo0S3pCZkN5QVF5cnJJdkloYURwU1gzLy9PZGNx?=
 =?utf-8?B?S1JqREJoSU51Wk9SaGttNnZXb2VwdVVzUExpVE1wWEthUU9GdEpPZ2JGMnk2?=
 =?utf-8?B?dUtrUWYwaE10VlFWOHhKQ1FPVVg0TldneFpNdmFlb1RvNFhwdU50dWlmblpo?=
 =?utf-8?B?bWU2QllLK2tKOU5RalJ4cmY5YmtUaEY0dmFZWGNzVlFRUGR0SHlSaDRGS0Vt?=
 =?utf-8?B?UTZZVUFybzdDVlFyaU16ZjFmZU9kT1c4bGdlK3JCNC9peUpENU1RU2JyelJy?=
 =?utf-8?B?dWRYcURucUZrSFlWK3RtZkJwczlWNUFkRHFKSklaL2g5WElOUHI5S1U3RSth?=
 =?utf-8?B?bHBycnJkVXl2NFhPRWEwV3RMSE1pUlFhYVQxVlVvNU95eWxJdzlrakU4dWph?=
 =?utf-8?B?b0NXVVZnSEM5S0hjRk1DNUFRQWg3clQ0QUphSDdZQnl3c3RFMU5haXlqOVRz?=
 =?utf-8?B?VWJpZUVQeElYNVI5RE4rbUI4ZklmRVVGaklNY1dxeHgwZytMVVg1ZFl5ZUlZ?=
 =?utf-8?B?ZUFqdEoxT3ZPTlo0UWZCRWVXMmt4K3dhQSthWGI1WGN2R1Y5OXFaOXJYdXBn?=
 =?utf-8?B?SDQyK0tldFE5cW5PV0dhWCtqNzgzK0xnOC81M2lqMkJ3cTVqUzRyU0J3dEha?=
 =?utf-8?B?ZDh3emVWOCtLd25kTTQ4NVpRbWxiWGFHNlBSTDdGbUFoc2tRQmZ0MUo2Z2VT?=
 =?utf-8?B?Um81M3VSZ2FvZW5jZDBQUUsxOTdMWXo0cExLb0hnR09XV1dKMUlNSWJqeElI?=
 =?utf-8?B?d3RTOEJiUmdYc2JSRUFzcm9MUnYyUDREWlc3Ky8zbi9uSVVJOVd1anpBa2ZN?=
 =?utf-8?B?ck40Z1lxTVhoUEU2V1Y0ajIwbGxHS01oN1ZhR0NneS9Sak5rZXN2UnpEZFRm?=
 =?utf-8?B?QnV3M051ME5JejByaTFyNGdDUUx4eklGS1NoOFl5ZEdXTGpONnVxcUFqMkJI?=
 =?utf-8?B?dzRZdUlVdEJyOVZhdnZTOE0zMkZneE53MGo2V3NoV2dDZVFZWUYwMytGQmov?=
 =?utf-8?B?aUhYNlRKZmJHM2JlMEJkOFBwN3o0N09PeVRFQS90b3liWENFZ08rTDUzWC9R?=
 =?utf-8?B?S1ZjYUZRaXcvb1M3emRRbVhrbnJSUTMrM09OWFhxMEVJM3hUVGtUblF1cHRm?=
 =?utf-8?B?M2swMUtUYzNEaFZCazdmdHFLejVpNE9NVndjaWFkNWVkREU1aHNtVCthSXBN?=
 =?utf-8?B?dFlqWHB1N0hkR0NOMk9FT05hL1ZaUjhLa0pQY2FyY3VoQUVsMW5Lb1lxeFM2?=
 =?utf-8?B?Mnc2eG90K2hKaW9wZHBnVmZtdmtJczlMamM1QUVtVVJCd2l1MlVpNloxK3Q1?=
 =?utf-8?B?QzlZRG5KYndXYlkyZUxCZDI5UmV5RHlOZkFqeGVJMmV3cG4ydjEwSWx3VldQ?=
 =?utf-8?Q?X6um869vgTeWWwTk7VlgtfcvIZR8eI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1JUc0Q1THJsaVJ5TUNPaXlQUmQ3V2pQSklhc1lHZ3VUVTZENzZXNG1uVFhq?=
 =?utf-8?B?aThTLzh1NUlJVlhZYWE5N0YyYjhuNXZUWDRxMWVrcDFXRjAvUkVSZkRLTlZq?=
 =?utf-8?B?cHY3d3h2QitLUm5mL1JONTZ4MnBPbXM3Q3E3bm1UOFBTT09RK3RBNnlkaE55?=
 =?utf-8?B?dzdGR3Nlcis5NnppcEJzdDRBblVad2NCWnJ2eWswWkdCYXhWZ0pZN3VDUHhE?=
 =?utf-8?B?S2N3dS8zRTlNdHE4MVpYNlYveGd5S0NRUnE5cTZLWmN6L1Qwc0l6bHJWNFdo?=
 =?utf-8?B?MEwrQ1J6WHRTaGJoRG4zMWRXb0NsVWROWVlMYjNSMFErYktUV1FSMnRQbGZY?=
 =?utf-8?B?Um84R2lpbStzejZqcU4wYmJraXhOMzJUYjI5emV6QSt2R1hiV29UcWdlZXBR?=
 =?utf-8?B?NFlvUGttS3V0SDUweXpVOTdoRkRoaW1DR1RqbEdTejk5VWJJWkdVbzhJQjVp?=
 =?utf-8?B?dHM4aERnc2dSdjFYMXNqRFhNWGNLWFhNcGcxVFoySUV3ZXFPcm1BSWphaXpi?=
 =?utf-8?B?S2NJZHh5eTlGM3pTbHBVUmRjZm5SdVZEY0hQM200d2psSmxIVU9uMWc5Vyt2?=
 =?utf-8?B?cm80Y0J1T3NTTnBKaXFkYnJoYXk5VzZhbkd3ZXNidUZYK1pVOWJ0cit5ekpq?=
 =?utf-8?B?NVE3ZkZUVlhQbElhbnhSZTliWkN4VnR6ZFFkd2QxaFR3MUNzOHZWNGdVSmhy?=
 =?utf-8?B?SmcvbXVJaEZkOWJsMnpybU00SWt1dUk5MXV5RjA5bUlXQVc0S0FLSFhTR3l4?=
 =?utf-8?B?cGZNN3lDN0pkSXVQeU4xdlowdVpIbzVjV3RiMG10TVlxMjdsY1M4emdIaVh5?=
 =?utf-8?B?OXFKMG93RHdWVjdXWnBIRkJQR2YrbE5XL3VJOFcyOHFqQW82OC94L1phQWVH?=
 =?utf-8?B?VDRFbzJVNEJlemhRdnZ0SDZRQ0VQTlJ0NXhwQ1JIUklPR29CUFVDRWdpak1v?=
 =?utf-8?B?N1ZvWGJ6WmFSa2V5OXBOT1U5VUlWRnRsaEd5QkVINTBWdTArUXp0RDQ0UkNJ?=
 =?utf-8?B?cTZWeGRMOE5uMnUwZlZHZzFMYkNoYnBpbS9rdUNpMmQ0OEhJY3BFbGEvQ3kx?=
 =?utf-8?B?YU1zNmVHSFl3TitTQWE5SjN5K0loRXQxT0NzcjM5MDF0RENEMmZNVWxwLzd1?=
 =?utf-8?B?aVhWTThGb2g4MkR0WXZwV1ZSbHVZNVJMWDZZQy9XNFNPbGRWNFdsY2tPOGNT?=
 =?utf-8?B?NlFaS3pMTE5OTVVoMjJaSjdVbldIeUNsNTJiU3ZBNHFNMFg3QmRVRmI4OTZB?=
 =?utf-8?B?c3hlY3dyNnpyTkZtekV4TWhLcjRXT2gxMjNSZ2YzUGEyQXFuT0hzektrdmty?=
 =?utf-8?B?dVVibU1LRUZ2b0VjM1hRcGZwdmFIRURwcmY2dGtuOVJZcDVrYmFTcVhLSmJi?=
 =?utf-8?B?d0poQmVIcDFoVDQ2STNsUEkvcEU4R25NcXp1cHpzWDc2SWNIVUQ0Z0lsSjJV?=
 =?utf-8?B?Y1NlZFZTMjZvbWhRUjRtYnR3RlRnb0l4aU0rSjZ1M2ovdFYvYlBWdEhoaE42?=
 =?utf-8?B?dXlGQXJmUG9pV3UySzdydzNmSlIzb3RQYWFrQ0EzczUrV1E2b3RLM0pvQkZZ?=
 =?utf-8?B?b0gvSXYxSWZURjE1TUxmNVpva04xaHVMOGtYY2MxU1NQQnIwa3RUeTZiUGV1?=
 =?utf-8?B?OUdBWUszaHpQbnB0ZnlHMXIyUEFsNERRVXhvNGJOVW5mVlA1Y0FKdnVjbDNk?=
 =?utf-8?B?dE5VT01ONEZvYk5YYU5qK2htVXZzR0JFalVZQk5DQzdaUTdYZy9reU43TUIy?=
 =?utf-8?B?NUQyeVY1bXh4YUdocFB4aDNaUDFGUXFQMU03VVhGUDFsVWtUZDJHV0dueWtv?=
 =?utf-8?B?ZWI3VGtLMHhWTU8vUVdUbmJMRVZ2SzM1ckRCbHRhbUFXL1hXdDkyQ3lMUEpF?=
 =?utf-8?B?ZXJMYU9tb3UzUkhNT20yNVVMZU56b09ndU9yUFBLK2NyWlpXdyt1OXBZaU91?=
 =?utf-8?B?SnY4V1dzdW5PamZqRnNnaC9HaU1LbkFmVGtNa3RmQTZnUkpvY2tKNGZOTEVZ?=
 =?utf-8?B?aGhRZndmNFVaTTh3OE5IR2k1eFRVLzVlRVFUMEJXSFRKYSsyS0JhdWFJeVg1?=
 =?utf-8?B?S0pHbjFYeTUzTlJZYS9BaGNaTjNXZENjbUxHVHU4RTM1S3BzMWZkYzlkOHNK?=
 =?utf-8?Q?Kmdk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0241ca08-30e0-40bb-1fc9-08dd93dd3701
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 18:20:47.5889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52bUtMWQeA+1HrL6f6v1eR6sw6jrRc5zjv1B51udKCSpdfh8B1Yu+OL9YnBjBNkD7GbCCQ9CiuaWwfdS0TgRVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6237
X-Proofpoint-ORIG-GUID: tVI3s5dL4ieos2Wqh6wmKvYJCdnH1tj6
X-Authority-Analysis: v=2.4 cv=RMCzH5i+ c=1 sm=1 tr=0 ts=68263085 cx=c_pps
 a=6L7f6dt9FWfToKUQdDsCmg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=bSWFUU4MR0HJr6LtqKkA:9
 a=QEXdDO2ut3YA:10 a=NFfghV5juZcA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: I_Db-0Pr935OFIMSSiBQopFe-0f_qRKq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE4MSBTYWx0ZWRfX1eaGaZ6iMCgN
 E2RR43cAFqWRBHa3Kw+212zka+j5b3yziqEPC1rJCRYJKzMFCddhhSSv5sZQ23MNZMtfVIso5Sv
 WW9qmXuIrBdH4q+VcTyZfOjxva9tfjt3g2vBUeBb0QiIinA7a6G9S6DOYRb8nplwf374UuBYJcA
 FJ/4efEz1+1+ogqUkRdjRi2ux3QrrZvhaGhOcOEYZWeW6frhWm3evnoPKvupf8VDnN8pxNf1Lh/
 yHEwyL/9iEVB8dDbq9BT/flD6fXfxr5yLFO1tW/h3FhBTNB/1U5zER9xDsIKsW9la7c0j0lJSk4
 gx6P9TQlzKcA30sb5wegVHrop5dsu6Gaoh8sv+epRh9ld+vd0wC2ofsfl7OIkJV6kfUKd1xzmvM
 oeHxUSXPTTM/ubFTNuFjmnp4BonVwpSPe+bUQF/l7TRfM2tZ7q6EoxLv5M5abDbZk2Hqkgdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_08,2025-05-15_01,2025-03-28_01
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

UGxlYXNlIGZpeCBDSS4NCmh0dHBzOi8vbWFpbHMuZHBkay5vcmcvYXJjaGl2ZXMvdGVzdC1yZXBv
cnQvMjAyNS1NYXkvODc3OTA3Lmh0bWwNCj4gDQo+IHYzOg0KPiAtIE1vZGlmeSB0aGUgY29kZSBh
Y2NvcmRpbmcgdG8gdGhlIGFkdmlzZQ0KPiANCj4gdjI6DQo+IC0gTW9kaWZ5IHRoZSBlcnJvcnMg
YWJvdXQgY3J5cHRvZGV2cy96c2RhLnJzdC4NCj4gLSBNb2RpZnkgdGhlIGVycm9ycyBhYm91dCBh
dXRob3IuDQo+IA0KPiB2MToNCj4gLSBBZGQgenNkYSBjcnlwdG9kZXYgZHJpdmVyLg0KPiANCj4g
DQo+IEhhbnhpYW8gTGkgKDkpOg0KPiAgIGNyeXB0by96c2RhOiBhZGQgc2tlbGV0b24NCj4gICBj
cnlwdG8venNkYTogYWRkIGRldmljZSBvcGVyYXRpb25zDQo+ICAgY3J5cHRvL3pzZGE6IGFkZCBz
dGF0aXN0aWNzDQo+ICAgY3J5cHRvL3pzZGE6IGFkZCBxdWV1ZSBwYWlyIGNvbmZpZ3VyYXRpb24N
Cj4gICBjcnlwdG8venNkYTogYWRkIHNlc3Npb24gY29uZmlndXJhdGlvbg0KPiAgIGNyeXB0by96
c2RhOiBhZGQgZW5xdWV1ZSBkYXRhcGF0aA0KPiAgIGNyeXB0by96c2RhOiBhZGQgZGVxdWV1ZSBk
YXRhcGF0aA0KPiAgIGNyeXB0by96c2RhOiBhZGQgY2FwYWJpbGl0aWVzDQo+ICAgYXBwL3Rlc3Q6
IGFkZCB6c2RhIGNyeXB0b2RldiB0ZXN0DQo+IA0KPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgNiArDQo+ICBhcHAvdGVzdC90ZXN0X2NyeXB0b2Rldi5j
ICAgICAgICAgICAgICAgICAgIHwgICA3ICsNCj4gIGFwcC90ZXN0L3Rlc3RfY3J5cHRvZGV2Lmgg
ICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgZG9jL2d1aWRlcy9jcnlwdG9kZXZzL2ZlYXR1
cmVzL3pzZGEuaW5pICAgICB8ICA1MSArKw0KPiAgZG9jL2d1aWRlcy9jcnlwdG9kZXZzL2luZGV4
LnJzdCAgICAgICAgICAgICB8ICAgMSArDQo+ICBkb2MvZ3VpZGVzL2NyeXB0b2RldnMvenNkYS5y
c3QgICAgICAgICAgICAgIHwgIDU4ICsrKw0KPiAgZG9jL2d1aWRlcy9yZWxfbm90ZXMvcmVsZWFz
ZV8yNV8wNy5yc3QgICAgICB8ICAgOCArDQo+ICBkcml2ZXJzL2NvbW1vbi96c2RhL21lc29uLmJ1
aWxkICAgICAgICAgICAgIHwgIDEyICstDQo+ICBkcml2ZXJzL2NvbW1vbi96c2RhL3pzZGFfZGV2
aWNlLmMgICAgICAgICAgIHwgIDE0ICstDQo+ICBkcml2ZXJzL2NvbW1vbi96c2RhL3pzZGFfZGV2
aWNlLmggICAgICAgICAgIHwgIDEwICsNCj4gIGRyaXZlcnMvY29tbW9uL3pzZGEvenNkYV9xcC5j
ICAgICAgICAgICAgICAgfCAgIDkgKw0KPiAgZHJpdmVycy9jb21tb24venNkYS96c2RhX3FwX2Nv
bW1vbi5oICAgICAgICB8ICAgNSArLQ0KPiAgZHJpdmVycy9jcnlwdG8venNkYS96c2RhX3N5bS5j
ICAgICAgICAgICAgICB8IDI3MiArKysrKysrKysrKw0KPiAgZHJpdmVycy9jcnlwdG8venNkYS96
c2RhX3N5bS5oICAgICAgICAgICAgICB8ICA0NyArKw0KPiAgZHJpdmVycy9jcnlwdG8venNkYS96
c2RhX3N5bV9jYXBhYmlsaXRpZXMuaCB8IDExMSArKysrKw0KPiAgZHJpdmVycy9jcnlwdG8venNk
YS96c2RhX3N5bV9wbWQuYyAgICAgICAgICB8IDM2NSArKysrKysrKysrKysrKw0KPiAgZHJpdmVy
cy9jcnlwdG8venNkYS96c2RhX3N5bV9wbWQuaCAgICAgICAgICB8ICA0OSArKw0KPiAgZHJpdmVy
cy9jcnlwdG8venNkYS96c2RhX3N5bV9zZXNzaW9uLmMgICAgICB8IDQ5OCArKysrKysrKysrKysr
KysrKysrKw0KPiAgZHJpdmVycy9jcnlwdG8venNkYS96c2RhX3N5bV9zZXNzaW9uLmggICAgICB8
ICA4MSArKysrDQo+ICAxOSBmaWxlcyBjaGFuZ2VkLCAxNjAyIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jL2d1aWRlcy9jcnlwdG9kZXZzL2Zl
YXR1cmVzL3pzZGEuaW5pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jL2d1aWRlcy9jcnlwdG9k
ZXZzL3pzZGEucnN0DQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jcnlwdG8venNkYS96
c2RhX3N5bS5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jcnlwdG8venNkYS96c2Rh
X3N5bS5oDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jcnlwdG8venNkYS96c2RhX3N5
bV9jYXBhYmlsaXRpZXMuaA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY3J5cHRvL3pz
ZGEvenNkYV9zeW1fcG1kLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2NyeXB0by96
c2RhL3pzZGFfc3ltX3BtZC5oDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jcnlwdG8v
enNkYS96c2RhX3N5bV9zZXNzaW9uLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Ny
eXB0by96c2RhL3pzZGFfc3ltX3Nlc3Npb24uaA0KPiANCj4gLS0NCj4gMi4yNy4wDQoNCg==
