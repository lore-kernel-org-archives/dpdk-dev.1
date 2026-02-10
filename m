Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D326FEA812A
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 15:04:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35645400D7;
	Tue, 10 Feb 2026 16:04:49 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3F743400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 16:04:48 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AC81B2530091; Tue, 10 Feb 2026 07:04:47 -0800
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022129.outbound.protection.outlook.com [52.101.48.129])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c84cw0bxk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 07:04:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHJ+7CW6uL9J4f71IUwOjo32juUP06mD+bQ5nKLE8isYrSeRoFDGD25Kq68LlIfYleDmpCyYwdaxWcunE+qa3L1dS4Y2XO2qtzkeTZeI+BrgtUA3S438E9CVUAmvaqhr+nvrnpVtWx94au4npLV2rRyzp7STgsVEBE60T//90tj64s9BE7/s6d2gEjMTrtHgMFJ43rvffeLMPzZ5Tb6vf5i5zuZc8AacWXy1u2yyE7sfh5oBuzQLhWBXfz8v0p3TkWeFhSy8QTeLAZF5Pn7BP4gcl8gO3BSZBwOekgnu9OwaehAW0Rn2lBuyNv13Jy9T8fX6o4AAWjSqC6oZfZD1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiXWob89c2Y5TswaZSaPksc+oBRxwnpXmMeeYpkFl2g=;
 b=koQTnDVGXu+tGd5YS1aJ3Y+NZSYKUq5o2F5cHmPkX9M3mwy3hHrOICUx4DfWSqZ2C4q1dVzsOVF6FsXqELg3ZWGBbShIoeeB596hTNw5ZX5LyJVMkT3ipn1wgYc+nXOOCQyCHZw6wZLL2k4By5ROVpJNffs9hz7D1+YBhpMfEByMUKBBeLcy5cR7wA2dOqIf9KYIiCRYJ6awLvg2AbYvgFdJYrFoBc+MtgOQwsQF6KdJ5Rk9NGes98YE5lGfSMiqWVn0s+H6TDIpYB1ieq29r/0y5XZBkGzC4wyn/uopLCPGhWu5rIXG69hnEuWwVieaPTHwWcqn2H2TNfTikxDxSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiXWob89c2Y5TswaZSaPksc+oBRxwnpXmMeeYpkFl2g=;
 b=LskevuqR2bWmetss2qBiuv6ciBIjcqBrB00lMdvbHAsZdeI5GOqceAKnf2rEUzbRWVla/WxsnEJOTxpSLj6MzgD18C2xIH9ycuOQzfhiq3bz8fg4noQGngl72FQW21ApJmwhkFpRw55JMpUVghPdXIJ/xMw9AgnrrS1k3Xt6GFQ=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MN2PR18MB3511.namprd18.prod.outlook.com (2603:10b6:208:264::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.5; Tue, 10 Feb
 2026 15:04:41 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 15:04:41 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Emma Finn <emma.finn@intel.com>, Kai Ji <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [v2] crypto/openssl: Add support for SHA3 algorithms
Thread-Topic: [EXTERNAL] [v2] crypto/openssl: Add support for SHA3 algorithms
Thread-Index: AQHcj3SNAp+jMucZMkuMafPGKLrpjrVly9IAgANwUACACSCTgIAJwWNg
Date: Tue, 10 Feb 2026 15:04:41 +0000
Message-ID: <CO6PR18MB44847F3A001FAC5DB86B8CC0D862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260129144242.4161225-1-emma.finn@intel.com>
 <20260204100538.346006-1-emma.finn@intel.com>
In-Reply-To: <20260204100538.346006-1-emma.finn@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MN2PR18MB3511:EE_
x-ms-office365-filtering-correlation-id: 6e386a6d-6db9-4600-1a34-08de68b5b79a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7142099003; 
x-microsoft-antispam-message-info: =?utf-8?B?MDMyRStQWC9hVkhUL1hramhOaEE3anBkdEpTc2ZZNkoxTVBEYTRuSTNCMkNG?=
 =?utf-8?B?YkxtQlVSL2s5NkFuYU9aVE1NdDQ4QlBhNTNwbitFbzF0VDBaTFNBcldhcW4z?=
 =?utf-8?B?WUZxSElOeXovZmo1aHZ6VWdOYUlIR29lWkV1RXVvdktsS25sYW5HQlBRekV0?=
 =?utf-8?B?T21yOHJkWnMwSWpmUyt6bTJtb3EzZVRiSmFVVnFJYU5STHRieE9rR1NxR0hB?=
 =?utf-8?B?T29CZVJ1YkZENVFaMFIrN3pzSkhvSzBqc1RUMllTM084d2FFc1dpUzJvZDVT?=
 =?utf-8?B?bDJzNXlydjdVK3JXNzVWYW1RalZvaWVkNjJudVJNVjQzaWVsU0dkWmREdDFI?=
 =?utf-8?B?RzM5TEZyZkxrWGgwaEVTdTErRURhOXdMSkFKYWwyYVRyMkZGTDRaZkc1NVFP?=
 =?utf-8?B?VG02WFRScHdMSklwVGQ0WG96dlZYeFpkRFZhUG02U2E2M05WRC9lUjBadmpq?=
 =?utf-8?B?M1VRMllYRlpIU2MzQlJhYlVvcm84aVJ1dXRVem9ld3FxUzd3cldVM3M4eVh2?=
 =?utf-8?B?a0pYSm55ZUVnbmZyMVFxcGs1UVV3bURyajAweW9TUmVuczFIRFFJSEVHYjNp?=
 =?utf-8?B?bmliTjk0SHViRksvZ2VpaTFXRzV2TkdLL25SUVdqT2lYMTIyd3NlZW9vWTNC?=
 =?utf-8?B?Smo4Y1ZHSkZTbG9FVnZtWE52RlB1OGpQM0JZOEEzS0lTVitCVmEyaFdoOGpi?=
 =?utf-8?B?dmNac3QvRDdjdE1jc0dZcmRqcm45TjFFdGxFSDhUWTM1RjR0UHZab3YyeTdX?=
 =?utf-8?B?bVBIcHJxbEdqVjZDVkZJdVA2bk9XTDl0MDl5aVpTV2FEOTZNcEZEOElQb1Ra?=
 =?utf-8?B?TERHVThmS25lL1l6RUtiUzR3c0Iyb2NQNmhzcCticEEzNFZKQldrUnkzR1p2?=
 =?utf-8?B?QTU2TWNhZkd6NFc0ZFp2ZTlRY1VIczFmU0ZaeVNPZlZqWHBUMnozY2c3UTlK?=
 =?utf-8?B?V3hVM200R1FQdXA3alFUZ1l6cHhwVy8rUHJJRkFibzVQZFJVQjlFZjhqMzIw?=
 =?utf-8?B?amRBbUFPS2djRnhiZnhUQmErMWQ2dHhkTW1oU2pNOURweDgvaEh5ZU5BbmhF?=
 =?utf-8?B?aDVjcUpPSk5XeVJJWXBvR3VPWTBlL3A3Mlo0b1hVeG5kWHlHckhTUnAyVzJV?=
 =?utf-8?B?RXg0QitvUVgxdURiQXRCNGh5RXBwY1g1VGljNUlhaWptTHBzUTk4TythZEty?=
 =?utf-8?B?d1Z0WGk0TGUvc3FYck9EWDI5Ulg3YjRYeVJJV1gyUTRwZlpvWjhkSXNScytB?=
 =?utf-8?B?REU2MGJRbzl0QUgzOUdFSnJjdmJwSnA4bVZUU055d0pYZzc3WDNSdlhLNk9Y?=
 =?utf-8?B?Rkp4cndwT2VhUndUaVVMTHBxdUk3Nkx6Wkxsb0VrUHVDNUFJdG1ncHU1YnJy?=
 =?utf-8?B?YUtQZGpONjVoZlRDUCtoOUZXMW53Z01SeWQyVUdBNlN5ZU1HRjI2OEk0L0RP?=
 =?utf-8?B?RlMwK1MvMXRvQWlUYVJFM3lJTndoTVMzZVhOUjlsWmJLVGRCWHUwRjk4SnB4?=
 =?utf-8?B?L1hMNGd6UnFVWmN0SHByaVRRVnNjVXM5MENDZ1l6b3pXdU5vZ0tacm1Ebks4?=
 =?utf-8?B?MUFoOUpmZHgrT1FQbVhDVWdkUW1Dc3lSeTF4YzI0Y1J3Q3d5SEpDUmw2NkV5?=
 =?utf-8?B?cVFzSUxzbW9PVERKTUZrQ2VUN3VhNURObElwNFR5T0treEpWY0ZmbGRTeU5p?=
 =?utf-8?B?ZFJLV1RCa1NjNkZ5OFpPNFYxcys5eVFFR0lpUDJzWmpaUElBS2x1b0RERVA4?=
 =?utf-8?B?YllweTNkUkJlTnJhTit1SlhOc1pzYytDb3o2eEh0TzFJUTFlWGVVenBtWHli?=
 =?utf-8?B?Nm1UVnptUWxLbDZPQkpRaVlrYlVoblpwR2s4dmRFaUNSSlhSSEJhZzQxaUlB?=
 =?utf-8?B?NGJxYmZUYy90WXVjTytmK2QxcUF4blhmM2tWbW5YV2FIUk5qZWhvY0t0TjJ6?=
 =?utf-8?B?TDhySjlVSDhaaXNtbTZSaVd3TE1BcEUrNHVLZkdMbnBrQkpyQ0FublRyUTA1?=
 =?utf-8?B?TlVLUUxqV2R6clozc3A1aDl3c1JwdWV6eDJCbmxMR2hJclQ2MlZrTUtaWE1E?=
 =?utf-8?B?NnBXRUN5ajRKdGxPVEFzOHBMZFZXOTR3Q0oreVc0dERHNFo0T2Mwc1VvT0hU?=
 =?utf-8?B?clBTNTh4S0lEU2FpdXdnU1lxMmFQK0t2bndRR1dRNGxoWEdUMGk0SGwyRXZx?=
 =?utf-8?Q?/cDRUZwy4HB2jtWVncuar/M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7142099003); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUNSYloxa2c4Vm0zaFFKakZhY2lIbUI0Y1k4TkVmQVBhOXhDc1lQcDBTNEZR?=
 =?utf-8?B?bVN1eXNsTUFkTi9ET0hOK2dBZGd1TkZjNlJVQWZ3UXAxYnJ4cVV4K2dLajRI?=
 =?utf-8?B?TmF1eW14dWFFWURVeW5lcjF1aTlUOEFZbi9MS0VES1ZwL3JpWXNLbVZRR2NX?=
 =?utf-8?B?T0orRHVwSmdpSm9kL05GV2tvRWhiOFdpTzR4aURNM2h6VjhyUXQzUWFma01B?=
 =?utf-8?B?SjRYZ0NvUGJaSjhCdnBpTHNsTUFFM1cvOCtRcFF2dWlsSnlwbHZOdnUxWnVy?=
 =?utf-8?B?eGlHQXllTmtEeDBhcVBMQzN4bXdLMkJmdlhUM3N5RGZ6OHJWWUhCV3llNEhu?=
 =?utf-8?B?ZUdiUjZmdEJZcDJvOFdURDRJNWg4US9JUmwrOUZ1M0k0dFdsUEpXOE4wY3Fm?=
 =?utf-8?B?YzNWcmNMUDY2djhVbGhteC9LU0FpbmorR2E0N0xkd1ZVWjhWNUdiQVNvR0Y1?=
 =?utf-8?B?VjVwa21aMEtiSlExNkowSlJWVWxZVm4zYm8wMHFMOER4VWtkajcvQzRrZzRD?=
 =?utf-8?B?aGcrdXNTemRRS00wRysvS1ozbzQ5MkFxL3YxYkN5dnQ3YTdIOCtvSUUzOVFV?=
 =?utf-8?B?VXBFS0tybGYxZWRGSGkvZWhYOWZveGk2KzBaMGQwR2ZYNDg0NTJ3V3NRWS9p?=
 =?utf-8?B?TWRIY1dvSTlKY2xXWmlnaVkyN0RZS2tiL0xLdGExQzAyQVIxeWZUbmNldjNE?=
 =?utf-8?B?Q2V6NDIxcExRU21zUUdSTmpMZDVucVVXYXpWOWljSGxOVkt6Uk4yV3lBQ2hQ?=
 =?utf-8?B?V2xqK3VmSmtaQmREeGNyS0Z2dnIxK1F2Q1F6a2xkQXpLZGNxTzdJMDFFOEpG?=
 =?utf-8?B?WDltMEQ0MGtsbWxLN2poOG1qYTZ5UEhVZTdHT3kxZk5iMUdpSGxBY1luMFdG?=
 =?utf-8?B?YU1OTDloRE1OT1RUZlF0WFEycDlJckEyRlR4K0Mza1Zyak1kK3pzS1R3eTZt?=
 =?utf-8?B?V3llUllzZFUrSXJQdDkzWWZvVDE1Z2VFRTZGTGVURTRxcmhyWXE2UFlnaE1a?=
 =?utf-8?B?RVFyZEZOT214T1hoZU4yK2NaR0k4Uzh1RHozQkhFSjNpbGxXTTg0cTNpZWFk?=
 =?utf-8?B?anFTcVBRSDlOamFxQUc3cmlacjNlQWtMY094YjVjbVkrMjJXakMrMDNUZms0?=
 =?utf-8?B?SG9Pd2FKSDFHTVh1ZjdDNnRWclY0UUp0OGh1TmZHcSt1RlgwOUpxUkNPWWRu?=
 =?utf-8?B?NGV5dUVHelZUd0lia3JveUxhdmc5NTd6eHlDRkE0Rk53K1JUMnJkQlk5bzIw?=
 =?utf-8?B?aUY2YU9obWRKWW9jM2d6ZHJ2TTZZdi9TWFZOdVVWTTd6T3BJR2xPcWE5cHlX?=
 =?utf-8?B?SG9GRHpUVlM0a2VzbU85VC93QXAzVGNVMjNDMmYra21XSkNoRGJYbzlIdVVV?=
 =?utf-8?B?SFBIWlJiNUFSUGpndTZHd0Fka2lwWlRjOHZRWU80ZGpJNnRBdEpRbGFSbXdL?=
 =?utf-8?B?RVhsdTY3Vi9ub0IreTI5cnFCNTJFOE9rY2t2Y3dTdDk2YnBDWnJjc3FycjBx?=
 =?utf-8?B?ZWtEbUJSOUZ5VTZTTWFYQkxqQ0pid1N2U0RYNTRSZG1KZlJPcXc2blZhQVlI?=
 =?utf-8?B?dlU3RkJ5azI1d0I2TnVDY2JtbUd2NGI4VGxiaVFlbk1yM1d4QTV0MU1LcFdi?=
 =?utf-8?B?a3h6UUZIMk1uR0pFdExmTWhqbWJ3WGt6dFl3NkZPT2piQzgzQXlCSEFES3RX?=
 =?utf-8?B?Ym9hRFk1dHBYMm5uWXhTOS9LQjErM0gyaE5FNWdycm83dXk1RjM2WFhRY3Vj?=
 =?utf-8?B?RU41b25mMXF5L3BZajJKQWZNdmRWQ3hiSE1KSzBRN0N2YWpvUDJnMXpOaFhP?=
 =?utf-8?B?a0ptR2ZxdU9NWlhBN3g1Vnc4S2JaOGdtcVM5SitMek12NHJCU0ZvK0FMOU9C?=
 =?utf-8?B?dlhPY1VUSVE1V21sM0M4RVA4QzNkRzFFM3Q2QzR3blFTRXJWVjJtQXFDekMz?=
 =?utf-8?B?MGc3N01YMUZCVURCQlA4RmRLZE5LTXdtVVJib0NQbWlud1pmdmdWM3dIbml1?=
 =?utf-8?B?blFpUUJXU2NsbEkzU2NzZ0ROQ25MUjgxeDlGSHFwaDJwWlNvOFR1alVScjBt?=
 =?utf-8?B?c2dnUEVlZCthR0pES1I4TEVBbWpwVFZNclNheFNBeExaajVOWlVYMGtQRVNn?=
 =?utf-8?B?ZFlFU0EreTYxcFZIWVhrQWJKN1VkM0IwTWYxaHp5Y1VoTUUvRVhWTzhORHJk?=
 =?utf-8?B?ZXZtWDVRVFpiZUF2VU1sMFFyRDZGa2ZtblNEdkZvdlpEZDAyZzJNbkFFdWxz?=
 =?utf-8?B?LzZpNjdab1NVbjZSL0ZtNG5oUGQ5eDNIaVlkQU4xUGFZZkgyRWNXekw5K0Rl?=
 =?utf-8?Q?CYjgKpVGOLnrB/DdXQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e386a6d-6db9-4600-1a34-08de68b5b79a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 15:04:41.1267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmL9+nYE/MdfIfogGJI9FVe6diGbg6fPhRhmvPl8mFY18B3vtomyipp+hN5uaqLcjnxqnYz7TZl6Oyf+Q1EyYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3511
X-Authority-Analysis: v=2.4 cv=YsIChoYX c=1 sm=1 tr=0 ts=698b490f cx=c_pps
 a=KF1eHXQEOlhFsAwOLvdZ7g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8
 a=tzjsv0qvte87vNQ1WowA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MucdDvTwV30buv1pjuPA8UvPvGCuEjfu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEyNyBTYWx0ZWRfX5DT4lWroEkgH
 zomv0obDt3ZP3fGCApKmO+kjcDwkx4QzvjwzHb6yX3QL8RKclkRzlkiFXLVV8wdKOaeqsVTQSq3
 cllutqztTFI8J6k/+HOuvvYd5C3hqh7JCr2g3+VrH0vqsgUZ8YRSKOIWIDxy1did8FookkDzkWB
 vfZp81wozvgy5ydVen8LTeDP5dj8f2yY6zgZqUEsEXcRuJAjmoBccl0mOk0ty0Rc/kfo/oRpZgt
 XdBtGkpaq2tOJCOA+WBgcKMzzs1xdOnyz6V26Ok6GVUOWHboJl4gADcGd5rEINPWcKwL1QpBl/o
 bAYTuN78hlYTi4i4PBLB6KJxdVQ6RROnfua5WZlLZ5VwPWtC07niLNwRX6NhgSRChm+nPPVUMEf
 if6onQIg7AcPnolvQ8jxsByxxH77vA3+w9ddS929FBw0l3TM3Ed8umUftmg4bVPeuwwXENXFF05
 xHOrMMJcOvoIFhnZ9+A==
X-Proofpoint-ORIG-GUID: MucdDvTwV30buv1pjuPA8UvPvGCuEjfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
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

PiBBZGQgU0hBMy0yMjQsIFNIQTMtMjU2LCBTSEEzLTM4NCwgYW5kIFNIQTMtNTEyDQo+IHN1cHBv
cnQgdG8gdGhlIE9wZW5TU0wgUE1ELCBpbmNsdWRpbmcgYm90aCBoYXNoDQo+IGFuZCBITUFDIHZh
cmlhbnRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRW1tYSBGaW5uIDxlbW1hLmZpbm5AaW50ZWwu
Y29tPg0KPiAtLS0NCj4gdjI6DQo+ICogVXBkYXRlZCBkb2N1bWVudGF0aW9uDQo+IC0tLQ0KPiAg
ZG9jL2d1aWRlcy9jcnlwdG9kZXZzL2ZlYXR1cmVzL29wZW5zc2wuaW5pICAgfCAgMTAgKy0NCj4g
IGRvYy9ndWlkZXMvY3J5cHRvZGV2cy9vcGVuc3NsLnJzdCAgICAgICAgICAgIHwgICA4ICsNCj4g
IGRvYy9ndWlkZXMvcmVsX25vdGVzL3JlbGVhc2VfMjZfMDMucnN0ICAgICAgIHwgICA0ICsNCj4g
IGRyaXZlcnMvY3J5cHRvL29wZW5zc2wvcnRlX29wZW5zc2xfcG1kLmMgICAgIHwgIDM2ICsrKysN
Cj4gIGRyaXZlcnMvY3J5cHRvL29wZW5zc2wvcnRlX29wZW5zc2xfcG1kX29wcy5jIHwgMTY4ICsr
KysrKysrKysrKysrKysrKysNCj4gIDUgZmlsZXMgY2hhbmdlZCwgMjI1IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gDQpQbGVhc2UgcmViYXNlLg0KDQoNCg==
