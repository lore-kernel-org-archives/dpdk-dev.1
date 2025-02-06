Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E99C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 12:37:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80F90402CE;
	Thu,  6 Feb 2025 13:37:37 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B2ABD4026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 13:37:35 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516CCGoc026529;
 Thu, 6 Feb 2025 04:37:35 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44mvvpg11q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2025 04:37:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJW5hj8Cm6ubkiDiRIiRVKYA2Gga6dU04zBSAtYsCoXXwKVkGNR3/cV6prXxs0va1xaCw9MgJyV16X1jDsHVAoe6Av/9cBkqZUKPhtz9M12I8nOfLFDGJZ6vRAcXnNKJKUj1rWotqFKWMT26scRTXj7vbI0UegHC4fOOFAqXhWIan1QYpntkglCZnbGDiYMQKnP+JqxQ1RsxZxMM+XyM+VMrPIH3Yead3peN8QoIFwJeMBO5NK1bjmSsiWvaPEOEpVo15oDCeVzwBoosc1o5KNZJzElu2biMOnXz5xiF0LXzdiRp8+7OKNVlmj8YLHhX0dzNgcar5LDCh/l9jP4dAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fF3JAMe1yJNxVLC04ootWMYVJ9Zf79cEcaoPju72dKY=;
 b=p0J+Q3iY+s/ZyrA992E2nDPqQ2f1hR3qT+NMRZ7KjgG1xkr0om2vU0IL9bskN62MRCh/ZpLuKFfiGMFQeL6AISQMbcJc5NNkk0d3bIJMNxJiaDIvHo+tyOF8wxPE7OAS5CbNzKamJyIdQKJUsb4i8LCV99TatiI/t0BoU0lIxwu/Bx7RTPpRP3QjOi6CwJaOZnbvSZNXccqRtRCBDzR70VSBifsfX1bBhDcN7Z2XRPLTzsCzMraYPUBFHP5iiutmiuSX966HzkO5iX/7MRlZJMnuCLiA+k+6k/af5GqccuWFSsxXNKidLhMjrnABvwM/WtkvrpIefmWtgSSDH6WWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fF3JAMe1yJNxVLC04ootWMYVJ9Zf79cEcaoPju72dKY=;
 b=A2cOy2++FSaBEVAwF27ZNY654Yqk4q3tqQfq82lclu3hUd68y4fmNaregVZNzKm7GJ0IVPkp5VkMdBjV4vLZ2i9tCOL3zUNjzVguJzzt0axlOzFsrOHA019kjmyZhRu/iR7RszqBxCIHts7WCRXIgap7YuPEVQH56kB1QUd0VuI=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BY1PR18MB6041.namprd18.prod.outlook.com (2603:10b6:a03:4b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 12:37:32 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%7]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 12:37:32 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Rajesh Mudimadugula [C]" <rmudimadugul@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "jianjay.zhou@huawei.com" <jianjay.zhou@huawei.com>, "Rajesh Mudimadugula
 [C]" <rmudimadugul@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] crypto/virtio: return proper error in session
 fail
Thread-Topic: [EXTERNAL] [PATCH] crypto/virtio: return proper error in session
 fail
Thread-Index: AQHbYcblhVcaY/Nq2Ey62LV+BjZB/rM6ZAOA
Date: Thu, 6 Feb 2025 12:37:32 +0000
Message-ID: <CO6PR18MB4484141DF35754366B1557DAD8F62@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250108121427.3715-1-rmudimadugul@marvell.com>
In-Reply-To: <20250108121427.3715-1-rmudimadugul@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BY1PR18MB6041:EE_
x-ms-office365-filtering-correlation-id: bbeee83b-ce91-44ec-f1be-08dd46ab06ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M0hsWDB3UHN6ME5vMGh5SlVxb0E1U0MyZ25tTUpoSUFLWXQ2VXBuTGZONVJK?=
 =?utf-8?B?a2FOUzlySHN5dzkzRC9EdkpRN0x3VzlxenBnbWxHSVUyamtkU2R4T2t5MmE3?=
 =?utf-8?B?TTBzVXc5OTFYS1hFY21WUGZJZlpiWVZFWUQzYVA4SkYwM1BGaWs1bkRxdUkr?=
 =?utf-8?B?T3lyVTVSK2NqRHptbzlaSENWOU9sMy9JSTJ4R2dnV0hsRTJGSWoxMUY0ekNk?=
 =?utf-8?B?K2xMWHZFSitMQzhBUERCVVlqL2ovNDhyTjlncDlpMk9aUm1DN1lNcXRtV0p1?=
 =?utf-8?B?UmZTUyttd3lXNGJ2M04xM2pEaStvODRCUzhGeTZRaXIyUllUdC8rZXh4RTdy?=
 =?utf-8?B?Q0R2NDJUaVlaSWEwSXEzR2FzM29ZTXU1NG1wWGhPc2JuakxNWDJOQnNlMjhx?=
 =?utf-8?B?YWV6bm4xWGtIclBIMEtjcGh6NlJNdCtQQTlCM0dxek9ETjJTVXViOCtkNnZp?=
 =?utf-8?B?ZlVkT3ltb0dpbmxsRGdUZ2RjZ0VFa04vdHZrMnFvWE5IZiticE1jVVFwbXB0?=
 =?utf-8?B?MTJsMGRyQ1Zhak1SVjRoUlFscEZZZW5TLzgxeHJyakliUjFrS0Y4Y2FrQWlE?=
 =?utf-8?B?QjZoTUVNcUU5Y2oxQnVhcUJTaldCZmMrb2t2NnpOQ01FeG9qTkFEcThZQk9B?=
 =?utf-8?B?b3hPUnlHV2orZ0RsMzkrYlNjaFdMUzRpaCt6YmE3eWFKZHJLUGNGdUQ2elBC?=
 =?utf-8?B?ZjdPL2FWYklBeHJGRkRodVk5OW1HRTBZV3NtWHJ2Nk5yWFhpRjZ3MUVndXdY?=
 =?utf-8?B?dEtmQnNnUVEyeTVYZU1UOHcwei8zQXZxb2Q2SXNQZUE4TTgxbXVwTGg1WURo?=
 =?utf-8?B?eEdkeVhpeUwyZHIzazFZVWx4eUppb00rY3ZESUxpV01UMlBrRFNTUWRrM3da?=
 =?utf-8?B?bEY4VThaZWZOQUlUSHU3SjZQSHIwUU16aktNY09FbmpUZ2pmYlpXbnUxczRV?=
 =?utf-8?B?UjFuYzUwbmJGK1BRM05DUGxucWlQR05NaW9FL1RLN2hzbURMZHU4TVZySFg5?=
 =?utf-8?B?VDNEVjlZTUlxcktBWG56Q1ppTlhCSDVPRzNoYnZvaGdlUjRUSFBVVGd6TmdG?=
 =?utf-8?B?eUJ3T0oyODl4WWRPQ3Yrei9xNmc5ZFo3cUtGK3ZvaE9KdmlmQXlhQ1BrR0Ix?=
 =?utf-8?B?RFZWODI4aW5PNUY4akh4SXllWU5xYUVLcmdFaSt0TENlWVY2bnlkUWQ1U01Y?=
 =?utf-8?B?QUpSZHVUZzlZVmI4QTlDeFNUVEtVMmNxOFlzZzZ4QU0yUUFscWVkUnVCREVJ?=
 =?utf-8?B?TS82cmdqbWc4NkVLclMzWnV1YkJxVWhvNjlFYTF5bld4TC9DNmFnWXdaYVpD?=
 =?utf-8?B?T2h2NUJBelRnUmo0UWRJSkJMNE5SbWJLQXdSbEpjZFduQUdpZG1NRDNnSzJM?=
 =?utf-8?B?VGFZVTFuUkIvVHVBbVJjQVdGeTJ5MFovQVh1blduM292bU11VkY4eUMrZkdw?=
 =?utf-8?B?N3RmVUQzVkpYVUptSXN2VXU3MnBoUytYZlpmL0l4SXBBMm8zM1VVR01Sb0tF?=
 =?utf-8?B?UWFLSG0yQzhwN29MSkRRSmw0eWlJNzNqQ0R3VTFRclA1ak9jWlFzOW96MVFa?=
 =?utf-8?B?Z1Q5Slh4cFNwUHk5YWFld2R6bzJZanI4YW1aRWhQS3FiS2svNlp6anBIcXQz?=
 =?utf-8?B?bUc2ZjNVbjZxWjVUT1Q2cmJhemJKNGZOUGIwcXNxYWJ2TEkrUHFUMlJXS3Vp?=
 =?utf-8?B?YlZ3RzNKenJubDZxUlZNclVtYXNNS0dTb0NncXMwcXlta090U2xRNHNneXVj?=
 =?utf-8?B?WDZWMEl2MGs5aFd2dUk2NGlGL0FQZFNpbVhJQmRxM1U1QTM4bFdWUEZpZ2tC?=
 =?utf-8?B?b0U2SWdCT3VBeDNLRUlseFNjdDBuYngrR0VOeGZVU1gwZ2NPbUQ1eWFOT3Uz?=
 =?utf-8?B?d0Nudm1zdGtlckh1eVVybTc5QmlSaVdPVE9wYVkvbzN4RUpzQnlxZ3RNZXE3?=
 =?utf-8?Q?2ozy6SZW2lwV/SSprfkMNimhY7hKqk8A?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekZjZm4vL3NGNTh6TXhOQ3cwUkNKWXpNei9RM083S2NobnRXRm1sd2o1M0Fv?=
 =?utf-8?B?cUxkWDEzeE84WmZEU1hnT0tUYlB5blU2dHFuTnZBUkYzRWMzVlVPWmF4TU4x?=
 =?utf-8?B?UTVUS0J1RkdoSVdwWTZycjNOa2hKK1lCbGlvUWhJOFhTd0pTN0ZNM0txQ0p3?=
 =?utf-8?B?VWFubmRBWGpaTzl0NXc5THUxbVJOWGZjdHJBQjFiVGR0bWFXODA0YkMzQ2lx?=
 =?utf-8?B?bnRldzBiYWdTVkkxb0JRcmtrbS9yd2VTV3dHUmNkaTZhMFRHdE5JS09EaVdV?=
 =?utf-8?B?ZzhEaEg3TzR6MDFTVGR1a09JSll3aVpNa2NiZHQ4bUc5aVN6c1ZVOXl5TVdS?=
 =?utf-8?B?OEd1RWNVaTJkZ1M3WE9YR2lzSER1TEhuczdWTWZwa1BRU1lZck95ZGFIMWNh?=
 =?utf-8?B?RHRBY01GTUJ4aE5uRXZZMm1KOG82aGpxZWZxbXJtZXBBQTh3Z2hRcTZqZ2pI?=
 =?utf-8?B?cUdVbTdENHUxQ3hCbndHV1J3aWowUG5WYmc4S0RTNlczU2VRckR1eXViUlNt?=
 =?utf-8?B?bzdqUFRJY1VJSnpuMDV1Y1c4aGYrTVR3cEdHOHEyZFdXLy8razhXM3VHbzJ3?=
 =?utf-8?B?L3dlMVVNQ0x3UVdySnV0ZVhnQ3hOak1Fa2dZcFFQeTgyM1c3Z05HRDNJU2pZ?=
 =?utf-8?B?KzZwTG5TN1NtTnRyME4zWlZJdzFlMS9qOWk5WVVmYm5zeTBYR0JKZjBOeXhD?=
 =?utf-8?B?N3IzMVoyS3lsb25RU1lkTC9GV3BLWXlETVI2bEUwaWNyZStzTDhBSWNtZXNy?=
 =?utf-8?B?Q2pycmdwc2grS2xydDZ6b2wybllkMnU3Uk5JbklERUthOWJPRUlIUGZaNGdJ?=
 =?utf-8?B?aHpLaTRrS1Z4a0srRkJMY25iOS9SUmZNdnljYlNHS2htYXRheE5xd0pzUnFV?=
 =?utf-8?B?RnN4TUttRk04Z00yU1R3bUR5NDMxaG95dTJ1OXpGRUFPWWc4bGovdnZJbnVi?=
 =?utf-8?B?L0prNHlsa2FlMGVUTnlrUXo1VWRZOHU1UlM1VHlrbmRhWFducmZpOWhKOXoz?=
 =?utf-8?B?S1Y5U1g4TG9FMDhVazgwYUZlWCt1ZDJkWGdWRmFGMnNtU0cvOHdsTWtLMVFn?=
 =?utf-8?B?Q2wxbXpON3lpdEdLdHdrSy84aHBvSGg3eHhEK24wR25JemZOblJBV2I4ZUFR?=
 =?utf-8?B?K28xYW14bHQwTlptanNXTmRmaGhQK20vR1Z3VmwrOFdyK243blhKeG52b3dH?=
 =?utf-8?B?bzVqZWV4S0J0d0lCVnJiSVk4dEFuQnVMTUhsZWd0RU9HRjRZQU1GZVhnaEpY?=
 =?utf-8?B?aGVJSmJXUVJFQXgydG8wYW10b1V3VDN6elJKQ2xrUDZxNFB6WXFjTHRmQ0k3?=
 =?utf-8?B?WGswNWZwZ2dGWVU3SVdZMzhybXF1VjhhaU82M3J6QXhaY3JBb2NzOXBjaGRU?=
 =?utf-8?B?VGV2ZWo5YjdyTXJ1M1ZrcUN1cnJaNVBmWDJ2Qk5pWVBqSDNpM1pHNVBUL1Jn?=
 =?utf-8?B?L0ExTVY4S25tM29yd09QVGZQKzRjVGd2RFNkK25FSHJvZ3VFekJGNmwyRkJJ?=
 =?utf-8?B?ZTIveHVQdFdWNjl5WEU4ejdOeVdqRWpROWpmeHhDMWwxbVp4eXNsS0VoU0Na?=
 =?utf-8?B?eWM3K2JaZ3RrcEk0S2dKY2oreStaWXBWNXIzdk9SMXZSZ3RwVUpqY2RlZEE0?=
 =?utf-8?B?bWFxZXNrNStWZDNQRENPMDdNTGtTK0RTZFdNRHlHR0xaRGw2Z05jRzlPZHRM?=
 =?utf-8?B?ZThWbGszd3MrYXVXU0tuaWVoSnB0ZlB5Z0ExYk9VT3FCUFd5MHhZcU1ZeUQr?=
 =?utf-8?B?bkwzaUZTd3N6NnZTMGtCV1RNbmpGakZXY3dIOTBCSEhIR0dnZThuTkFlcGFI?=
 =?utf-8?B?Zmp3bHRkc0ZsWjZEYzc4WE5vZ0I0MzNsUUVIRVhhWWJ0WkV1MHB1K3VTRzUw?=
 =?utf-8?B?eG53azM0NUZXUWcvVVd0a0xSUFdDRnMrSUVreFlsZU9qSmhqQWpRdDlrZWtq?=
 =?utf-8?B?QTdpbnViRGdGZlhZZ3dQaHFnZENjVEc3K01JSU5oVThsZ0RUbEh1ZEZCc3U4?=
 =?utf-8?B?TXRQTnZ4VC9xeFV2YVIzQXNLK0p5U2dhYmM2RmMxV05jd0svQW5HeTY3V05F?=
 =?utf-8?B?eXp3RTFuaHVuU3hUbkp5WHMyT29HdUwzaUpYRmVpckxNNGpEVjhKV0tZMFBu?=
 =?utf-8?Q?vPx4BfbUeYV2t672XGZ314cjR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbeee83b-ce91-44ec-f1be-08dd46ab06ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 12:37:32.5539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +owVOukjZRd1UTxncIC2KWCK5OYA5+9YR6NwckpBbgZe/paw2e8kipG6u1rH4T0qSdArvwuT4LMQOtDhqztENQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB6041
X-Proofpoint-GUID: __2l6LPzuqjM1mIM5C6d5GRMWSf4IaT7
X-Proofpoint-ORIG-GUID: __2l6LPzuqjM1mIM5C6d5GRMWSf4IaT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
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

PiBSZXR1cm4gcmVsZXZhbnQgZXJyb3IgY29kZSB3aGVuIGNyeXB0byBzZXNzaW9uIGNvbmZpZ3Vy
ZQ0KPiBmYWlscy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhamVzaCBNdWRpbWFkdWd1bGEgPHJt
dWRpbWFkdWd1bEBtYXJ2ZWxsLmNvbT4NCkFja2VkLWJ5OiBBa2hpbCBHb3lhbCA8Z2FraGlsQG1h
cnZlbGwuY29tPg0KDQpBcHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8NClRoYW5rcy4NCg==
