Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80537C7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 12:14:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBBC540665;
	Wed, 25 Jun 2025 14:14:16 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C53A5402AB
 for <dev@dpdk.org>; Wed, 25 Jun 2025 14:14:14 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P9jpv2011118;
 Wed, 25 Jun 2025 05:14:14 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2139.outbound.protection.outlook.com [40.107.243.139])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47geryg88w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 05:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0SgV5y9Nfjk8FvyuCMfzc/ZAHRvwP0q/JhBIxYY57X9IyIeCX9h15oEvXtBO9k5da5RtwvhuU60TeFTWMtIjJ87eaNJoRxgQpho86kYw6ohKzL/PhEqncyGvWcYbfclqKh7s5YHqjjKxwmV1gmV2Pn/OFCScXTH7busOK26z2dFjpEf1sJEK9h3dP60pF3hWyS1h0h+I7Hsu/xnx5HGIM9KFVgdFHC9ri41Zfm8wkeQ3nB5vxD3IFXNadSQznJ9FivrYfrOFodIJAd3tW43dz1tLQfL88qnL92Diuzh7mfmpw0yNoBiTrweZQdVMSF/f7bk+gBy20HYtV7UHGcfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ceytrp/UGHKhjf7OJQqB5pTo0j9pETdPJYHbyygiDw=;
 b=qezrgWAhe6y1yRQGYWj6N9YNDLRTwNxeBbEms/JnpncDxU8NKlAZM85xJQnlCGJQnXei4EG6X0BrEdWut6UtX1jTZYicSLNDX7qmz1oVEGYNt/Gi0tO7tDvcdEiQpfjYQ7SxE7q+6d4IxYeZIaa8mqbJfhJOehCtF3GGsARdFpZZTRgtr4GRjLzTHfvPq1cJK2e9LmTQbi614leG+dMwKMxcrEl8jvLkKvQiFCvBcdMt59d+jRjq+oToxuk4C5UF4DA1dQK94Ivc8GvMJ4MTHMCQ34OTytBw6INlWgHkTtExf6miWQXoeIhLWjMK6iagF7Xmr5DexBKZ7P7LwxftxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ceytrp/UGHKhjf7OJQqB5pTo0j9pETdPJYHbyygiDw=;
 b=JD20l5mVATVoGDG/I1n26Q56lp2lyhFRvbw56Y4WfcEhcaobZ+g+6L22UQOvVJSp0K6eYLhnA/j6LnXUq7IMIvWPyvmfSgNuC/kXggVg/ZZfn8rYkv5sM9OPW9yIpbaIDH2N0QJXZLX3p9W3Sk99Hd3eBkJbWWerI8Q/N/0EOKI=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH7PR18MB5377.namprd18.prod.outlook.com (2603:10b6:510:234::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 12:14:10 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 12:14:10 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v3 0/2] uadk: realize async mode
Thread-Topic: [EXTERNAL] [PATCH v3 0/2] uadk: realize async mode
Thread-Index: AQHb4ZRhfJRKGMn3Lku3CJTsGmr9zrQT0b3A
Date: Wed, 25 Jun 2025 12:14:09 +0000
Message-ID: <CO6PR18MB4484B2A6744F73A9196EB034D87BA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250620033515.86501-1-zhangfei.gao@linaro.org>
In-Reply-To: <20250620033515.86501-1-zhangfei.gao@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH7PR18MB5377:EE_
x-ms-office365-filtering-correlation-id: b72b1a90-c5ea-413f-0059-08ddb3e1ca5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZGpsQlk1MTNKOTR3a3BEa21jVkJOOGVrRjhCWnVaQmFRWWxNZ2ExUGdPOEM0?=
 =?utf-8?B?Zkx2NGFWUzZRWnBlZnVEcjlNdzlSYXMxWVBKTk1ibmY1bThnNmZkdHEwQXVu?=
 =?utf-8?B?a1dPUGJvZGFicCtBcm02aFdwMHF1Yi9UZmJXZzdyUkJDNUVEVDNWakNVVnFQ?=
 =?utf-8?B?K1NrZi9kd1J4aVZzekpENDloS1RKYW9McjV3UVNpTFZvMWZDMU5DTEFkZ3JB?=
 =?utf-8?B?S3JLZDF1YUlxdkZKYTZWVnRMZnEzRzQ3bWZPc3R6OWl6SDVsbGFlZHBmTE5p?=
 =?utf-8?B?UE04ZEJueWh1dmV4eVpDK3RJdU5WWS9ZeWJPTXE2V1VENlhEU0h3ZytYUHdK?=
 =?utf-8?B?VVAveCs2M0liL3QwT1RTUE1jUHBNSXVuSUhqbm9Gd096ZGk5Q2Z6T2UyRTNl?=
 =?utf-8?B?TjdrL2pVT3BINk5vQUx0amdndUE4R3c1WkJ3VnhrcTFjVDVwT0VzQlk0SFN3?=
 =?utf-8?B?bU5QTjVjU1ZoaTlHRmJJU1VRbnJUcFNseVJIdDFJQ0xjc0JYYnNJZ2h5NEUr?=
 =?utf-8?B?SDVZZUZlbUZ1c2M5d1ZuUWhQcU9VaW5KTzhnSlk5aWJ3Y1FNY2ZhT3cwekJx?=
 =?utf-8?B?QzRhSDFHY1R6aU5EbjZ4Vlc2eTFxRUtPZHA2TGNOeksrNHFGZ0Mxd3BWVEZ4?=
 =?utf-8?B?T3F0Q0VtYjNpRzRwa0ZwZzBSTEtydnErQndLRzd1RnQ0U2FMSlpMd1dPTDNE?=
 =?utf-8?B?aG0zMEdPMytsWWZZVDhQdnlMbE9yVEVGNzFzTURZcEZyR3RpSGdRWjNLcDV1?=
 =?utf-8?B?R1F2ZzE1cGJwRS9nVThCU1ZoZUdKNzVDdlVVdG00Y1QrTFhrOW9RV0hVQWoz?=
 =?utf-8?B?a2xjSXVQMDJmM2t2MjVrMXpINGdvMlB5UXE2VmxzaDFMQ3Z0d0Zha3dsYVRq?=
 =?utf-8?B?V1R6cnAzcFk1SFVRNWtOWFhCWWQyZG82eVZ3bWRkekdKaXAycVYzQlZPQWxJ?=
 =?utf-8?B?THRNNmtMYnh0VW1udlRpRHh5ZlA4VlBwYlN4YmozbWxDYTBnVjhxeXcwUDJz?=
 =?utf-8?B?aVB6Z3ViOWVDRWFtWVRibFdJMTcwZDQvakIvYWZINFR6SDN6bmxId1o1bnk1?=
 =?utf-8?B?OG54cDBram1nczVPUGhtYndRNEhFVWtCN1JtdlJwRzNxM2d1RVJFcmJLU294?=
 =?utf-8?B?bFZGRUEwa1E0SFRQRkNwZDdiM2pkNDBEZFRGQ2ZHUmsxUXNrcWx2d09ReDRX?=
 =?utf-8?B?UitxMWhCeXdabnB2SHVyUDdURHVWOHFkK3gzZXFTVndkdGxkRU9ybFd5VVNq?=
 =?utf-8?B?V3d2RmlDVFU0TU41L09HS3c2cm5KN0xWeldyREx5M0dwd0FXUHNYcGZhWDFU?=
 =?utf-8?B?R3hnbCtCcy9GV2VDL2dobmdDSk5ia3l2Z09HQkMxcGNQWlpUUUgvNldLNlJa?=
 =?utf-8?B?cERXVWhHZHFTd3VuRis5akJFRmV2SHFtMkV5NjMrako5NDMyQlVwc2RDdWNz?=
 =?utf-8?B?aFhqMjRuYkhES0xRM0dNZ0ZPNVZSc29QdW1OL2QxSXlHcWEzQmJsN0ZFTExW?=
 =?utf-8?B?WnJDRmRWTGQzcmZGTTA0bEQ3aWxhOVppa00zNlMxcCtFQzBSVitSR2doaUJ3?=
 =?utf-8?B?M1VZNmtJNExpekduRUY0Rk85Rm5ueVpGWUpHcUhPdjNKY2hoSGxLWVY0WWRt?=
 =?utf-8?B?NVJaSWlidXMxWUNDcWE3OFB5RmEySHhJNktSRHFVZi91L3ZET1loVGRhaHBK?=
 =?utf-8?B?LzlyUDdrWE1ZWVZsVlFBVExxNGxlOG1jSEhxclhnS0xIUm9aOFNseGNLVTBz?=
 =?utf-8?B?YWZNVXdxNUVwTkpYSzBVY1BMOS90cEpna0JkVlhDVDZiWW9ZOGRpRWNOOThr?=
 =?utf-8?B?VnV3eFFRM1hvU0VZMW9KTUkzYWpjTngxSWt4cy9pa0pkZzRrSlhDd2d5Wks1?=
 =?utf-8?B?bEN3a2htUlRnMU1YT0Q5NXkrRi9rYW5EdmJjZW95U3hpRDI1eEZXMWIrN244?=
 =?utf-8?B?V0dPajl6WTVielpwN3F0Z29DNVdIM1FJQnNlSitha1pNRmEySzRVcGFKZDBu?=
 =?utf-8?Q?hZONmsiJTF7pKIUxbVbbYzWCqjUpq0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWJzN0ZBWko5eWV4VEtOWVI2QUhRUkdHZTlvN3F2SCtaS3g3MWVhbHVrV3BF?=
 =?utf-8?B?cm5kbEZvK05WTTFWeVhnTENoN2xQU2xSaVVwZ3BFdXo3c2pxTDJvWllVUkx2?=
 =?utf-8?B?Z1NRMDNSZ0hRZ05maTY0aHp2dVdoRWJrOE5TbEhkdDJsS1dlZ2RWaWMrTmpE?=
 =?utf-8?B?eHkxV1pWaUJrSUgwQXVwWVlpQ1NQSnRNbmdMMHVwNndXUVVTSzVXNWZhcExU?=
 =?utf-8?B?bFVVR2k1dFZrRWxacGZuTXhrQ1NuelpHMHo4UG5TdW1peExxVzRZVEdNZUVh?=
 =?utf-8?B?eVN6S0tTQTdpdDJJcG9JNFBuUTNibWNpeU1hVUpMRDJoamYzRGwrdWd2aXVO?=
 =?utf-8?B?Q0ZON2ZnbVJBeXhtTjdqYjRCdHNvaXh1aWFuS0twNEdzRnJwNjhTWnZWcWI5?=
 =?utf-8?B?djdYMU1sak9qQS96d3VzL2VaMmxPUGhGdWdUcGtmWEczNmRuREFmbE1VUTJZ?=
 =?utf-8?B?ZVBpc3NrSVJpY0VlY3h4SEJvN1B5Ynl5WG9MbXhPaHZ6Q3FQYklDY3luWENa?=
 =?utf-8?B?MHk3dnByWGFPZ3BrLzVGS2h4TjlDMkRrbTZSSWEvRlBJRlFTbTFrUHBKOTI4?=
 =?utf-8?B?dEkyT0dxZjVxYmhxZS9XM1dienk5azdJSTVFMWpLbWNTZ3A4VzVYdkZXd2VV?=
 =?utf-8?B?aWIvUE1xNExYQ0FRK29RUVBoeXRuU2ZmTzR4Zk1LMGNVK0RrV0QxbmtyOEtv?=
 =?utf-8?B?aUUwSVEvYUhQcWp2RWJqbjlJb09FKzZMSGZyQlgyZVJNeVdqTmpSVGdqajVi?=
 =?utf-8?B?TDZ1enlRL016NHdSWi9JbmswZldvRzdNOGpWVWxDdnFObXpwSmdFVEppb3Jq?=
 =?utf-8?B?a1VuOXlIV0VKK2pNN3M0Znk4SzRQRVRFOG9jNDNnRTREWkkrbU8vSENKdTR3?=
 =?utf-8?B?UCsxU1JBVlpwU0MzVVlMS1RmTC9qa3VSbjlwMFBiMlhkRWt1ODA4cjhpNDNp?=
 =?utf-8?B?TkVaTDNVYWVOV2tVQnlHODJLVGloc0tnS25IblpVcUxQbDFLLzQ0R2x1RWJL?=
 =?utf-8?B?ay9LTVErWHF5aVg4dldPNG5SL1ZSNllpOWhEK3B1RDdmL0tXSG8zMENvTmVC?=
 =?utf-8?B?Y2hyZjgyRW9zbWhIWmthZnZBdzNrRm9kdzdWeEZNWTNHTDBzYUZWRlNKQjN0?=
 =?utf-8?B?Tk5ZVWhOZy9aUWZDSUpqSC9kWE9rOXNyZVQ0ZGxZNy9XZGlPamI0Znpwb2Ux?=
 =?utf-8?B?UmN4SHhyNUJUck5yQTVSZmhjMzVKcHpFcHBzTEJDY1kzc0xYUlBCOHVKQTNC?=
 =?utf-8?B?bFVNOE44cmpMaWY0d2NGOXc0cU9jRE5ncXFxTVhsS2NyMjM2ZVBIenVmVlVq?=
 =?utf-8?B?TXYwVEM3SGNYeWEyRVg0VVhZRHY5STBEa1NtQk01SFoxaklnK3VScmNCN3A3?=
 =?utf-8?B?amNyUVBCeVFTNHUxU0EwZU5sRjhCZEgvYnFub29aVnl6V3BQOCtqNlQwOUFr?=
 =?utf-8?B?eE8raXBPV1Q3Q2lycnlJQ3Z2NG42UVQwSzJGWEJzcWNZcjhMNHVzMkJnWUJ4?=
 =?utf-8?B?UDg4SmNHSExJd3dVRXlGL3N3bURGcmZPUmpDMmFMZGJBSk5Namp4elB2c3dw?=
 =?utf-8?B?YU1xZGtwVk9OVXNpTklEc1REQjJJaG1WOXF0QnFoT3FaL1c2cUt6TjZVS1hU?=
 =?utf-8?B?TGZpbWN6VUcwTTkxYXE1TFdwR2VoVzZKRDVTVWYrQUVVUkduc3Uwck5FcEFw?=
 =?utf-8?B?NUNSaUlQdFZZaURUTWZRU3FZM0ZGMG5qdkdQeTRkTnpzYVZWYUZJRFByNE1m?=
 =?utf-8?B?ZEt0cC9nM3NzbkZ1R256cHFQU1dsL1A0ZEd2aVIzek5vbFBWY2dud0I2NFo5?=
 =?utf-8?B?Mlp5RTJLaUJyd05XaEQ1dVlGTVYwRDZqckJCOXRKMWdBTEhNNnVKcWFvNk1k?=
 =?utf-8?B?TFFBY3RjRXBxSnprUWRyRHpqQzVGZHZQZzY3bHF0Mi8rWDA1ZE1QeTVUcVla?=
 =?utf-8?B?c21xaDNHcjFnclZLcXd4MzczQ1BDemVUOG5rZ0g5REJMdmsxeWo5dTdBQ3ZP?=
 =?utf-8?B?YUl4V2ErZTladWpmcEZyUGI4L2MvWjU3TkFTWlVodXZuaVdIb1RPVWkwTENy?=
 =?utf-8?B?amF1aC9zUkptZHN2V2EybHVvemVRK2d0bWd2dktnQm1NRDdZL2VCSGp6ZGRV?=
 =?utf-8?Q?7eorpgMBSGlCXewlq/RLiu6Mo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72b1a90-c5ea-413f-0059-08ddb3e1ca5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 12:14:10.0180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99K8G4RIfEZGZpUkvwlqlXGNEmHIAjCessQlq9ZPL4B3gWQOP1a9k8x6Ta+nX4QAq9txJ+QHr8MFS+iGlilZdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5377
X-Proofpoint-GUID: dUd3qojfvoEBUx7pTxgrVSlWx2Lfw0MV
X-Authority-Analysis: v=2.4 cv=d9D1yQjE c=1 sm=1 tr=0 ts=685be815 cx=c_pps
 a=WRu4cO6RzerQPdfMOIdFEg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=hT_gmRW-_-HdIJmgcNAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dUd3qojfvoEBUx7pTxgrVSlWx2Lfw0MV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA5MCBTYWx0ZWRfX+XtkuT0aPvTF
 /C+fIv4pVHTr5IiJF023nHfOqsCfZtoqXn81ej6iMnbo3RcxAURmrhqDHPiG4/Bqh37LyxDY5j5
 mT3KdlCr9lJ8RO3Fq/2BGLqeOmNgK2pqp8PRBrruTak1M7FPTZ6R5eGGqHaXKSTOeDdiRCfgUYW
 Ku4zmdxTJ+3WPmKCWTad1TTjuVnq/Ih4EVXAYP9GvsXOmG2amCKUd/RTrs865jiwPv8CwOxufRn
 JsvpAmVI8unR2K+CD6/k+pOhPHuAs+2sd4d54iBh7nstZbEk2TyFDqujng/6UsCWznXoyUa8Ovz
 IjIw3/DHx0JNDd06lG6aBBVBCoIRzRLCYQH11COxv7cD6KYy3srPXXPOIyCgpToyiaDtiafNqY7
 SDYGDKt+aOq2wmk4/G65+YInMGmkg35S2DmSrD9sKGLVtsTGRwKgBeFthA2p9yGxNjduFxER
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
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

PiBSZWFsaXplIGFzeW5jIG1vZGUgdG8gcmVwbGFjZSBzeW5jIG1vZGUgZm9yIGJldHRlciBwZXJm
b3JtYW5jZQ0KPiANCj4gdjM6DQo+IHVhZGsgMi45IGlzIHJlbGVhc2VkDQo+IHVzZSBkaWZmZXJl
bnQgbGFiZWwgbmFtZSB0byBmaXggYnVpbGQgd2FybmluZzoNCj4gCSJkdXBsaWNhdGUgbGFiZWwg
dGFibGVfdWFka192ZXJzaW9ucyINCg0KSSBhbSB1bmFibGUgdG8gYnVpbGQgdWFkayB4ODYuIEl0
IHNlZW1zIG1hY3JvcyBhcmUgbm90IGRlZmluZWQgZm9yIHg4NiANCg0KbWFrZVsyXTogRW50ZXJp
bmcgZGlyZWN0b3J5ICcvaG9tZS9nYWtoaWwvdXAvdWFkaycNCmRlcGJhc2U9YGVjaG8gd2RfYWxn
LmxvIHwgc2VkICdzfFteL10qJHwuZGVwcy8mfDtzfFwubG8kfHwnYDtcDQovYmluL2Jhc2ggLi9s
aWJ0b29sICAtLXRhZz1DQyAgIC0tbW9kZT1jb21waWxlIGdjYyAtREhBVkVfQ09ORklHX0ggLUku
ICAgIC1XYWxsIC1XZXJyb3IgLWZuby1zdHJpY3QtYWxpYXNpbmcgLUkuL2luY2x1ZGUgLWZQSUMg
LWZQSUUgLXBpZSAtZnN0YWNrLXByb3RlY3Rvci1zdHJvbmcgLURfRk9SVElGWV9TT1VSQ0U9MiAt
TzIgLWZ0cmFwdiAtV2wsLXoscmVscm8sLXosbm93IC1XbCwtcyAgLURVQURLX1ZFUlNJT05fTlVN
QkVSPSJcIlVBREsgdmVyc2lvbjogMi45LjBcIiIgLURVQURLX1JFTEVBU0VEX1RJTUU9IlwiUmVs
ZWFzZWQgSnVuZSA2LCAyMDI1XCIiICAtZyAtTzIgLU1UIHdkX2FsZy5sbyAtTUQgLU1QIC1NRiAk
ZGVwYmFzZS5UcG8gLWMgLW8gd2RfYWxnLmxvIHdkX2FsZy5jICYmXA0KbXYgLWYgJGRlcGJhc2Uu
VHBvICRkZXBiYXNlLlBsbw0KbGlidG9vbDogY29tcGlsZTogIGdjYyAtREhBVkVfQ09ORklHX0gg
LUkuIC1XYWxsIC1XZXJyb3IgLWZuby1zdHJpY3QtYWxpYXNpbmcgLUkuL2luY2x1ZGUgLWZQSUMg
LWZzdGFjay1wcm90ZWN0b3Itc3Ryb25nIC1EX0ZPUlRJRllfU09VUkNFPTIgLU8yIC1mdHJhcHYg
LVdsLC16LHJlbHJvLC16LG5vdyAtV2wsLXMgIi1EVUFES19WRVJTSU9OX05VTUJFUj1cIlVBREsg
dmVyc2lvbjogMi45LjBcIiIgIi1EVUFES19SRUxFQVNFRF9USU1FPVwiUmVsZWFzZWQgSnVuZSA2
LCAyMDI1XCIiIC1nIC1PMiAtTVQgd2RfYWxnLmxvIC1NRCAtTVAgLU1GIC5kZXBzL3dkX2FsZy5U
cG8gLWMgd2RfYWxnLmMgIC1mUElDIC1EUElDIC1vIC5saWJzL3dkX2FsZy5vDQp3ZF9hbGcuYzog
SW4gZnVuY3Rpb24g4oCYd2RfY2hlY2tfY2Vfc3VwcG9ydOKAmToNCndkX2FsZy5jOjEwNjo0NDog
ZXJyb3I6IOKAmEhXQ0FQX0NFX1NNM+KAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBm
dW5jdGlvbikNCiAgMTA2IHwgIGlmICghc3RyY21wKCJzbTMiLCBhbGdfbmFtZSkgJiYgKGh3Y2Fw
cyAmIEhXQ0FQX0NFX1NNMykpDQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBefn5+fn5+fn5+fn4NCndkX2FsZy5jOjEwNjo0NDogbm90ZTogZWFjaCB1
bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0
aW9uIGl0IGFwcGVhcnMgaW4NCndkX2FsZy5jOjExNTo0NjogZXJyb3I6IOKAmEhXQ0FQX0NFX1NN
NOKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikNCiAgMTE1IHwgIGlm
ICghc3RyY21wKCIoc200KSIsIGFsZ190YWlsKSAmJiAoaHdjYXBzICYgSFdDQVBfQ0VfU000KSkN
CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+
fn5+fn5+fn5+DQp3ZF9hbGcuYzogSW4gZnVuY3Rpb24g4oCYd2RfY2hlY2tfc3ZlX3N1cHBvcnTi
gJk6DQp3ZF9hbGcuYzoxMjg6MTU6IGVycm9yOiDigJhIV0NBUF9TVkXigJkgdW5kZWNsYXJlZCAo
Zmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pDQogIDEyOCB8ICBpZiAoaHdjYXBzICYgSFdDQVBf
U1ZFKQ0KICAgICAgfCAgICAgICAgICAgICAgIF5+fn5+fn5+fg0KbWFrZVsyXTogKioqIFtNYWtl
ZmlsZToxMDU1OiB3ZF9hbGcubG9dIEVycm9yIDENCg0KPiANCj4gdjI6DQo+IEFkZCB2ZXJzaW9u
IGNoZWNrLCByZXF1aXJlcyB1YWRrID49IDIuOQ0KPiBBZGQgdmVyc2lvbiB0YWJsZSBkZXNjcmli
aW5nIERQREsgYW5kIGV4dGVybmFsIFVBREsgbGlicmFyeQ0KPiAJdmVyc2lvbiBjb21wYXRpYmls
aXR5DQo+IE1lbnRpb24gdmVyc2lvbiBkZXBlbmRlbmNlIGluIHJlbGVhc2Ugbm90ZXMNCj4gDQo+
IA0KPiBaaGFuZ2ZlaSBHYW8gKDIpOg0KPiAgIGNvbXByZXNzL3VhZGs6IHVzZSBhc3luYyBtb2Rl
IHRvIHJlcGxhY2Ugc3luYyBtb2RlDQo+ICAgY3J5cHRvL3VhZGs6IHVzZSBhc3luYyBtb2RlIHRv
IHJlcGxhY2Ugc3luYyBtb2RlDQo+IA0KPiAgZG9jL2d1aWRlcy9jb21wcmVzc2RldnMvdWFkay5y
c3QgICAgICAgICAgICAgIHwgIDE1ICsNCj4gIGRvYy9ndWlkZXMvY3J5cHRvZGV2cy91YWRrLnJz
dCAgICAgICAgICAgICAgICB8ICAxNSArDQo+ICBkb2MvZ3VpZGVzL3JlbF9ub3Rlcy9yZWxlYXNl
XzI1XzA3LnJzdCAgICAgICAgfCAgIDUgKw0KPiAgZHJpdmVycy9jb21wcmVzcy91YWRrL21lc29u
LmJ1aWxkICAgICAgICAgICAgIHwgICA0ICstDQo+ICBkcml2ZXJzL2NvbXByZXNzL3VhZGsvdWFk
a19jb21wcmVzc19wbWQuYyAgICAgfCAgOTQgKysrKy0tDQo+ICAuLi4vY29tcHJlc3MvdWFkay91
YWRrX2NvbXByZXNzX3BtZF9wcml2YXRlLmggfCAgIDIgKy0NCj4gIGRyaXZlcnMvY3J5cHRvL3Vh
ZGsvbWVzb24uYnVpbGQgICAgICAgICAgICAgICB8ICAgNCArLQ0KPiAgZHJpdmVycy9jcnlwdG8v
dWFkay91YWRrX2NyeXB0b19wbWQuYyAgICAgICAgIHwgMjk3ICsrKysrKysrKysrKy0tLS0tLQ0K
PiAgZHJpdmVycy9jcnlwdG8vdWFkay91YWRrX2NyeXB0b19wbWRfcHJpdmF0ZS5oIHwgICA4ICst
DQo+ICA5IGZpbGVzIGNoYW5nZWQsIDMyMCBpbnNlcnRpb25zKCspLCAxMjQgZGVsZXRpb25zKC0p
DQo+IA0KPiAtLQ0KPiAyLjI1LjENCg0K
