Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8BEC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 07:02:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44C82427A5;
	Wed,  4 Jun 2025 09:02:08 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
 by mails.dpdk.org (Postfix) with ESMTP id 2E90B42797
 for <dev@dpdk.org>; Wed,  4 Jun 2025 09:02:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3AizUNAvU64+/o8Am11w8OfSnWdRsNzVzKToMZIXDvCMjaQnhIUvLzzDSoN69GzyFYBxgEEQdfa31nL4hlPU9wagF06TReZotuxM3FVUNUQ51ovHRkcRDWNbPyapyXEdhWziHvjtPUvT0A3EkrK+f2jOC9GVos2TzLeWM5VCrUyZuJbkUfZ7pYD9WGQuireCS1DwGckVjWPZ95g7re/3OPNWZQiuNYukfjxRyKP3eOOybn2jjpMPFJbHTmAzNwtR0uzFbVqlgSCFvEd5pZaRlJ+Q2IQgJEYVaDsKdFKwbGLjMjMvT+JUGy9x9UCoTLbpTUyQhx9GOT/V14uv9k8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrTHUh/vr1OSQThZ//12bPwkObWB5baVZ84B/F2pbow=;
 b=A489sDlGdoZd/K5g3mMtzjQSNm7yDTwoGssemzQGK3yU403QyG1NU3gtfm+1InauR3zDdq7jyv14HFwq9RZdk0bG+yxUMaVVTaeveTV+kJOPkc6BK+fsN+rXRBSvxXm+0BDFRnyio8Rg5tGRSOW6sSWIsARDUjzkE+hEzFbRqJsFSM6yFvyECUJ/PcT448o5OBWvztIpns2szp+ZSEfNa/Jvl5vJ0Jl1+3IXD2MixCGFiRmwWYNyZPzU3G02vVAf+XBUxdfgDuVqr47PjDvoWetNo7+lfogp4W+AEtmMNH4U29rEML7aH0+9wHhLeeR+L5XDMAIaRUl0Z+TOYemKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrTHUh/vr1OSQThZ//12bPwkObWB5baVZ84B/F2pbow=;
 b=bksEy1ximfuPfhoSbCUdEJ5Pn9my1HsT4idMUm0y6PSN1UH8BF3WUUinbc7+PAWycri+8Xa17d1wmKM5J6Xi0ENKbKo5ZWL801960ui+CvO6uMtAmn1n5ddOz8gCBHJNRAPPOsOMPWU2r19uENx456DEbVAU7nmZ6rvSU1XdAKMgiEeFpfygfIq5MYGaoVqJg0pMQgqf0u6dpfiaevD0uxoBQPacOHMm6LicfbrFLUylbKxARhb4YIDyalVyr8bu4R3AjzfyvljEvU1LnWMDcl9xsITa39UeplC6Kf32pGbAsid2QKmhChvR1H4Pu7TYIBFTed4NlqH7eQQxkXe9gA==
Received: from PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Wed, 4 Jun
 2025 07:02:04 +0000
Received: from PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::5cff:1844:4c17:a0e3]) by PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::5cff:1844:4c17:a0e3%4]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 07:02:03 +0000
From: Maayan Kashani <mkashani@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Yogev Chaimovich
 <yogev@cgstowernetworks.com>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] net/mlx5: fix transceiver warning when not exist
Thread-Topic: [PATCH] net/mlx5: fix transceiver warning when not exist
Thread-Index: AQHbvbYIS6Ux7qfBtUOA8dJvuvvxhbPb9EsAgBbNOlA=
Date: Wed, 4 Jun 2025 07:02:03 +0000
Message-ID: <PH7PR12MB701839586EA3DA18CB3E3D45B26CA@PH7PR12MB7018.namprd12.prod.outlook.com>
References: <DU2PR09MB5486574FE72A43A09A323DCDD68E2@DU2PR09MB5486.eurprd09.prod.outlook.com>
 <20250520114904.6570827f@hermes.local>
In-Reply-To: <20250520114904.6570827f@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7018:EE_|MN6PR12MB8471:EE_
x-ms-office365-filtering-correlation-id: b77594ac-8dd3-4cdb-75d9-08dda335b5e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SzFZMktGcG95VzhjbGxFUXAwTnlRWVZTOE9lRzEwQnJZV1NhQW9SMmpSb1FE?=
 =?utf-8?B?Y1lNMU1OVEVxK3gxeUVPOVNjK3N0bzJ6ck5nM2pIbXU5SndCbVBQZHFCTitm?=
 =?utf-8?B?SythSGZXWTgwZDFXRGFkTzBldUFFVklBYlpHS0dEeTB5MkllV0l6VHhySmFj?=
 =?utf-8?B?NVcyUloxQWNjRjhIK3l3Z3pxQ3V6TGU1MXNZeStYOFdUUHlLR0w1eHFIc0Nr?=
 =?utf-8?B?M2R3bmpNVWVab3NFdUFJckpHckwzN1l2WmZrcVVhZjVPYnZpM3lSekZJWTE5?=
 =?utf-8?B?ZEVnQlFxRHJLUUgxN0RkYVVEcEw3Ti9yU0toaU5DMXBLT0hDeXRxWW4wbmgw?=
 =?utf-8?B?ajR5L2xPdzh4aDZoTnQyQVpVQVpDN2Q4V3U3a203NzRhcUpqbnVFOXVBR0Uv?=
 =?utf-8?B?ODNNVllKQkFhLzdzZzE4VnpUZGtiWkh4aUFIMW1ORkY3NTlLMEpuZzNJOUZo?=
 =?utf-8?B?RllsUmJpZTlFU0V4OHlPZ1FZMjBaNmlzMjF6MXV1ZFdmR0kyTGdHNUtBSkJ6?=
 =?utf-8?B?RE55NTVCRno0NHowemxJblZ5cjlIVGZ1VFkzYVY3aG4xbExVZXlvbmFDS0xo?=
 =?utf-8?B?eVFUU0F1MG1uRlRwYmlhOEJzTTFxamRubTJ1Uk1FU0hrdW9OZHVTUFlOZGZR?=
 =?utf-8?B?VTFENitQSEp3Mk9XcEVsZmFXSFN5RlhGekpwU2lHRkxweUt5aUt5TzFEY1Nm?=
 =?utf-8?B?UzV6clRxbzhMcjZWNmU5RXhENUEwSlJMcUJPZ3IzczNNT0VMSVk4a3UxNmhS?=
 =?utf-8?B?MjNvVk9wcjY5NGVRaGljMHdwMlhnNysrb09zUy96S2R5N25NR1JPSTZ3aXpJ?=
 =?utf-8?B?bmwydGhkZFh3NStxL2dQcXpwR0JhbTF0aTZHWW44Y05xT2lCL1JhR1hDdzhM?=
 =?utf-8?B?Q0VzT1lUVURiVGZRZXNWQlZrTU5CWms3ZWhqZUdKQ1JwcmxpL0xlMmFLTSt6?=
 =?utf-8?B?eUl0MG1lMUZlYzVNNURHUHJORm44Z0I5WkxiTGNjWVNpOUQ3aWRRQ3lxN0pp?=
 =?utf-8?B?MUx2RVZNMWcxS0hQR21QUVB3NmVaRzVKVVljYjgvYXFheHJWM1ZMb0ZCNmJK?=
 =?utf-8?B?SHFrS3EvM1piemJJTkxaVktRRGd4Ty9yTE1KSkpOeisyT0g0NlZzVEVNL1RF?=
 =?utf-8?B?UmNmTU5PRDJGOVhTTUR4SDFwRDlkWXc3b09leW5XeG5SRWlWSkJ3ckUzKys5?=
 =?utf-8?B?V3FCaEJSbllKUE1MaGgzdFJoT2lSVUt2T0JGTDJaZTBzV2NianhNZzIrMVNS?=
 =?utf-8?B?clliTVArQlBpY0ZSeUkwTDFrbVBGSWlNWlVxTjJ5aHY2OUV2S2NLQXBQOXlP?=
 =?utf-8?B?c3hHaFFYVm5TTWt0Q0xnTWo2aFBiZWtKdjBwNERiTUNWN0tWaGxnQkJiQWtx?=
 =?utf-8?B?YXlMNno4N1RoaHc4eDhrWko1aFJhS0FBb252Y3dMaVgvYWE0SGZWM0NPblVv?=
 =?utf-8?B?SE45RE9qVVBmb1JwSzlrZmtTbkQ1R1ZYei9NdGozNHJ2QzFIYXNIVEQwcXJS?=
 =?utf-8?B?VFhhdEVGd09EMGhCbFVjRWN3T015RmdiQWYwOWRSbytOT3NYdHk1Z2phc1dv?=
 =?utf-8?B?azRiVFhJN0l6RGVKMkJvaWh4Vm1JWjNqZmMzeEkvRVJRb2greXBkRXNkcVhS?=
 =?utf-8?B?akNsRng3VUh3Q2YvWUtSTVQyN2FxcHRla1pMZXo2eThacjZjQTd1YVF0MkpK?=
 =?utf-8?B?bmdzdGZXcU9DVDBQT2ZIVERRTzlBdDlZOHhmTmZCVGk2M0FtWjkrbjZzUDBH?=
 =?utf-8?B?UDVScVo3M3F0blRpYXVOckN2WEhVa2dWMnVRZ1lwTkVickZSMlovOHV1UGpO?=
 =?utf-8?B?bC81ejQwTzZCTWpiNE85UmEwUFRSNnBGVXV4cWNjMW5WM1BBbU40RmVaUW54?=
 =?utf-8?B?dEladzhXRXpLYVNmMFpVWEFJeWJwbEllbzc4UVFEei9xYXA5dkRLQjE2UGd3?=
 =?utf-8?B?Rmdsc3pqRlNWZnZKMHpTc1N4U3REU2JNYWZac0FER0xLcUZEU1EyL0h1ZkFq?=
 =?utf-8?Q?T4g3CRn59CnDYXND7jbab3PexGXGOI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7018.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejNvNVJ5a3g3a0prcUpUVzQxTTlucVNVaWlPM0xtelk4TFB2VHRuYldzZHRE?=
 =?utf-8?B?S3RHMkswMkhMbGh2YnBucUJVU3plOHowVUtJdzJvOEZ6ZUhPMjFpeUpnMUpr?=
 =?utf-8?B?TG5nL3Q1eGJsb0VJVThyUEZzeW5KQjlTd1lDdGpvaG0xenZtN0xsYUVOOFI0?=
 =?utf-8?B?M29qd1o3d05rUVZrZjN1QXFwNEtqZjkzWTFocmlydy9jRXcxYjd6Vlg2aDhk?=
 =?utf-8?B?L1kxb3JmazBiSHl3K1FJUFdNTDFWM3RwVGtnUElsc2srRUFGTGNNM0NRWFM2?=
 =?utf-8?B?NU8yUzBhYkdHRTZQbmNIeEZ0cTRaVGFhS3JzbkdLbUNDeGpiRWNESXB0c0tx?=
 =?utf-8?B?YlJTZnh3MFAzRXI0KzFvNnRydDFscldIcnZSSk1ScFlya0V1a28vYmZVa0Yw?=
 =?utf-8?B?YTRLTkpieWRIMUpWcWRkQWQ1MnU0cUV6dlR4cUp0VEkzSVdmdWVJZzNPTDhh?=
 =?utf-8?B?RjZKL2JvL0tLK1NEME40WjJPMXkvckZ5aWVydjNqaExwTHJEZXd1SGw3WC9D?=
 =?utf-8?B?RCtUM3U4UHRoeUdvTFI5WjBYWGhxUzBpZzNwL0Z1SHNvVUdScjZ4NTRoNlZo?=
 =?utf-8?B?cCszclVHeGNnb01tYkFxUGhZTEpSMjhCbndTRDlYREtJOUZGajJJeisvTEJv?=
 =?utf-8?B?TzlCNDU5MUdKQzVTQytQbXR1K2pQNWhjcTdhOTI1Y3JTdVFFRUN4UkNtcEdj?=
 =?utf-8?B?bnhLL2lRTnRoeERBTy9NZlh0MDI3blh1RDJMaGs1THM3TnZYL1pSTzErRXNU?=
 =?utf-8?B?R1NwYlB1S3ZqaFY4Rkh4azFYR1Z4dVVBSEticHFYMmM0eEMvblJhN0FmMHU3?=
 =?utf-8?B?QnVWVlN2QXFkTnAxcGdzZFpqMm1Bb0JzV0hwUHkrL1NSL3NxaGw5YkphTjVw?=
 =?utf-8?B?T1YwK2V3VVNZNVpPdkMxYkxJSzNUdUdha3VUYnNxUDFmaWdsdUlTRmc5N1ZQ?=
 =?utf-8?B?a0M5K2R0cE9TQXZab2hCS2FBZlhiVWxPQVo1SjdHVjc2RnhHVmhSUTZGL1Nx?=
 =?utf-8?B?aDhqWUZySVpQN2ZDekJ0QzE4YkFRdzk1VmpWQkQ0UkUyNGFoVC9JZnpCWVZ3?=
 =?utf-8?B?ZWYrMVdxWTZEVGV4MmpmTmpVMVRVYkhrTk5PY0piWSsvRnM4ZjlFV1dlc2ZQ?=
 =?utf-8?B?Tm9IRDEwZFhsNnZBRU0veG8zd01OcUoyejNLMDhqdTFlb1JXUW8wMlNWd3d5?=
 =?utf-8?B?aUFhN1RQSmI1TVBWNHJ2bVIyZUF3b1FDbmZDU3pzV1AzN2I4ejVkbkJrZ0dY?=
 =?utf-8?B?dHYvcGNqampzeXV6eElDWmhYQWhOb1VmajlUUmhpZmthMTNwaGt5S0wycnJD?=
 =?utf-8?B?MUY2SWppM0JoWTRSb0lRU2swclcrakhHNENHOEZ4ckFjMkI3N2VkUDd6eFNj?=
 =?utf-8?B?M3NZYS9Ca2lZV0hBK2Q1d2JiZmFoc1NGUjlaZjhOcXlpUS93cTNwbVJFbFNz?=
 =?utf-8?B?V2J0ZStnMTczejNNV3Z6YUE4TXFzZUZXd1FKT1hjbVFpcHVaLzgyUmpRVTBR?=
 =?utf-8?B?ZDZWLy9oK1JNQzBNVjlMUDlmWVBFZVZGUFJBbXIyUFRUcGJ5d1E3bmt4amxq?=
 =?utf-8?B?NTluZlN5RGJQTjlDeHBMY01GQWN5RXgwWVppUXdMYmdFcWhkOWpISERwRmRI?=
 =?utf-8?B?L1BDUEJPd2gwYmwwaWtzWnV0RHg5VEtlK2c3K09GUWY5Z2locUY0UHR1QjhM?=
 =?utf-8?B?QjJ6Y1QwQnNSQVNKemFwa25US2UxeWJUT21jdUhmclRKREZYMENZMmRhMkpX?=
 =?utf-8?B?TmIwOFdQTTFlRndtYkFYM2FWTzZVam1CUWYvTWwvNENReldHMU1sa1k0dU0y?=
 =?utf-8?B?OHdPVkNWUS9Ha3pVZGx2QkFJdkNCK2hQNTBCdkU4RVFsWVo4WUlIdzhWcUZW?=
 =?utf-8?B?UWpSYlA2MjgwSjY3anZUb21nUUpEblJISzA5SFVoSy84bGJVaFFjWjFKV2Ur?=
 =?utf-8?B?TCtwNzJHQWVURWNKOEpVMi9VaTVzWWU0N1BrS1kyUGIxdytoU1Y1WTY0WGZ6?=
 =?utf-8?B?RzBRUXFYQ1Fma0x1aW9ZMG1sc2hCNlBKNnRhaWx4aWhIZDFadGJqdjE0NEpk?=
 =?utf-8?B?bFd3emlpWnRxRlg2SWhabkdGZVJxMWZHdTk1ZVVXZFY2ZlZXTDBLcGhMcDlh?=
 =?utf-8?Q?bJMy0h9tViDe9HVtrb14q0sz9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77594ac-8dd3-4cdb-75d9-08dda335b5e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 07:02:03.6603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fmCehJwiatCQ/n7dIGJDuBrUCrIJoY9y4YZcDvBlMnzx09qPc+AHIJmo4JIfpJKkV/Jrphf1kdcevstiFGwtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
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

SGksIFlvZ2V2LA0KVGhhbmsgeW91IGZvciBjb250cmlidXRpbmcsDQpDYW4geW91IGZpeCB0aGUg
ZmFpbGluZyBDSSBURVNUPw0KaHR0cHM6Ly9wYXRjaGVzLmRwZGsub3JnL3Byb2plY3QvZHBkay9w
YXRjaC8yMDI1MDUwNjEzMzEwNy40NDMyLTEteW9nZXZAY2dzdG93ZXJuZXR3b3Jrcy5jb20vDQoN
ClJlZ2FyZHMsDQpNYWF5YW4gS2FzaGFuaQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4N
Cj4gU2VudDogVHVlc2RheSwgMjAgTWF5IDIwMjUgMjE6NDkNCj4gVG86IFlvZ2V2IENoYWltb3Zp
Y2ggPHlvZ2V2QGNnc3Rvd2VybmV0d29ya3MuY29tPg0KPiBDYzogRGFyaXVzeiBTb3Nub3dza2kg
PGRzb3Nub3dza2lAbnZpZGlhLmNvbT47IFNsYXZhIE92c2lpZW5rbw0KPiA8dmlhY2hlc2xhdm9A
bnZpZGlhLmNvbT47IEJpbmcgWmhhbyA8YmluZ3pAbnZpZGlhLmNvbT47IE9yaSBLYW0NCj4gPG9y
aWthQG52aWRpYS5jb20+OyBTdWFubWluZyBNb3UgPHN1YW5taW5nbUBudmlkaWEuY29tPjsgTWF0
YW4NCj4gQXpyYWQgPG1hdGFuQG52aWRpYS5jb20+OyBkZXZAZHBkay5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gbmV0L21seDU6IGZpeCB0cmFuc2NlaXZlciB3YXJuaW5nIHdoZW4gbm90IGV4
aXN0DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBh
dHRhY2htZW50cw0KPiANCj4gDQo+IE9uIE1vbiwgNSBNYXkgMjAyNSAxMjoxNDo1MSArMDAwMA0K
PiBZb2dldiBDaGFpbW92aWNoIDx5b2dldkBjZ3N0b3dlcm5ldHdvcmtzLmNvbT4gd3JvdGU6DQo+
IA0KPiA+IEZyb20gZmZlNjY2MjkxYmM1MzFiODk2MjBjYzI4YTdiNDVmYTIwOTcwMGYzNSBNb24g
U2VwIDE3IDAwOjAwOjAwDQo+IDIwMDENCj4gPiBGcm9tOiB5b2dldiA8eW9nZXZAY2dzdG93ZXJu
ZXR3b3Jrcy5jb20+DQo+ID4gRGF0ZTogU3VuLCA0IE1heSAyMDI1IDIzOjExOjQ2ICswMzAwDQo+
ID4gU3ViamVjdDogW1BBVENIXSBuZXQvbWx4NTogZml4IHRyYW5zY2VpdmVyIHdhcm5pbmcgd2hl
biBub3QgZXhpc3QNCj4gPg0KPiA+IEluIGNhc2Ugbm8gdHJhbnNjZWl2ZXIgZXhpc3Qgd2hlbiB0
cnlpbmcgdG8gZ2V0IHRoZSB0cmFuc2NlaXZlcidzIGluZm8NCj4gPiBUaGVyZSBzaG91bGQgbm90
IGJlIGFuIGVycm9yIG1lc3NhZ2UgZnJvbSB0aGUgbGlicmFyeS4NCj4gPiBUaGUgY2FsbGVyIG1h
eSBwcmludCBhbiBhcHByb3ByaWF0ZSBlcnJvciBtZXNzYWdlIHVzaW5nIHRoZSByZWxldmFudA0K
PiBydGVfZXJybm8gaWYgcmVxdWlyZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiB5b2dldiA8
eW9nZXZAY2dzdG93ZXJuZXR3b3Jrcy5jb20+DQo+IA0KPiBTaWduZWQgb2ZmIGJ5IGlzIGEgbGVn
YWwgcmVxdWlyZW1lbnQgYW5kIG11c3QgdXNlIHlvdXIgZnVsbCBuYW1lLg0KPiBBcyBpbjoNCj4g
ICAgU2lnbmVkLW9mZi1ieTogWW9nZXYgQ2hhaW1vdmljaCA8eW9nZXZAY2dzdG93ZXJuZXR3b3Jr
cy5jb20+DQo=
