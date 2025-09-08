Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E769FCAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 08:54:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF4AC40264;
	Mon,  8 Sep 2025 10:54:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 74D3E400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 10:54:55 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5887erYa023802;
 Mon, 8 Sep 2025 01:54:54 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2105.outbound.protection.outlook.com [40.107.236.105])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 491tye04qb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 01:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htZJCR4X01aDYNhM6qmj2AJSCx8EDA2iDkal7lztvft1LtYz5hiT8iOd3O9u8QDeLZXiBiYA+p2wE4AfI8gDFMnSaeLo5WX+VwkiWCa1kBPj6h7JBcIHjmlXjW2Jr8koaW+JBQ4Y4v7rippva4Z6NTxJw9X8SymCQFZF01lAa00XghGEbNih0Mb+IDXCJYlXbhCF30wU9FGPMaV2EPryFrvddSAPOvQBqBP/34wZlApYsn8QJBxymNoVDe1uR4eFTAzNsaeyf17uCHITuBlfK1K1rq7IN4SUh8sVvnijx0i5pv0JdAcQnK+5sCRoaTJV1QdeNtx03uwUiWPUB/ekmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDOajtJdjNeh9ZZdVSbgD0W9SwjimUTrhSRxM6k9kvQ=;
 b=ilA1w0TWIxscWjrU1z8uCUWiLiny1HGutzha4E7GECXvDjuBOdHHRbBwd7WBKCviq4euQe3P3jERp9UC30LY6hDQlpL0sPM9XUm3H2DNOR5xfvGChX3fxqBOxNHqTVdPNiD0hq4+qDuCyk1SdEq3BN1dkdBxvdtekYTm4m88leH4mSebPkXRFutZqLFnmCroDUm/4W2xe/7TMi4G1nC2xKY9Pg7zo5cuOJ/SXqCZK3UhMsDJ6QL9dfGoJvJkHkP83S+6pPQkJp2G/D6/p0ODTTQ/02Bo2czvIMkEDbwO7C8Xp0TjrcbuY04uWXYqfjBp8s3wltwHQ6r4HSxdzi6Dbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDOajtJdjNeh9ZZdVSbgD0W9SwjimUTrhSRxM6k9kvQ=;
 b=jRxVEtbrxn3d/kwUYi7DosZ4Gnx8mnR55XpPcnAen0UoY4nLcCJSYGYNsamg25ZPhbtfBKa7WQZF4LwHfof1C7yIvGHOPF6+oHyDGoO89SuGHpZHt/KheBvQAtRdCrnR0vC86MU+4GeYwVdJR2BHg5zIsVwCRdCYzX6U5RpPJmM=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by BY1PR18MB6089.namprd18.prod.outlook.com (2603:10b6:a03:4a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 08:54:50 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::de98:ceac:f841:3fdc]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::de98:ceac:f841:3fdc%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 08:54:49 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Sunil Kumar Kori <skori@marvell.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org" <dev@dpdk.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v9 1/1] ethdev: add support to provide link
 type
Thread-Topic: [EXTERNAL] Re: [PATCH v9 1/1] ethdev: add support to provide
 link type
Thread-Index: AQHcGwO/FZOKTPgtzESKg+7BGsIq87SGd6cAgAJjn5CAACsCAA==
Date: Mon, 8 Sep 2025 08:54:49 +0000
Message-ID: <CO6PR18MB386085C28B3A605CFC5C6EB0B40CA@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250821053425.3227866-1-skori@marvell.com>
 <20250901054552.813195-1-skori@marvell.com>
 <20250906105116.427529e9@hermes.local>
 <CO6PR18MB38603CA5F647B375807604B1B40CA@CO6PR18MB3860.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB38603CA5F647B375807604B1B40CA@CO6PR18MB3860.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|BY1PR18MB6089:EE_
x-ms-office365-filtering-correlation-id: 2cd3991a-45ac-471f-d646-08ddeeb55e81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V0lObEJ3Z1ZpZ2lucXZBa2NRdDY5MjAwd0dISU1UcU5GbGNOUmxaeC93bURj?=
 =?utf-8?B?WVVLNG81QU1IVUZPZWdKTXlFV1NFOU12azJwRy80VjFpZHltc0h4WlVIKzVX?=
 =?utf-8?B?d08vN2V5eU1ENno2SjhIaXRVTjR0UUVEaUpzcHk5dWE0RFJoWkFKMEg5eFFG?=
 =?utf-8?B?T2N1TVdqdFpJWVdsbUxZc1RNM0NvellzTGNIVTBpcjRRR0JRM0YzTXVlQlBR?=
 =?utf-8?B?dkJnRFZxVGJRbzFLY3VPcmhUVTV1VVYrOVZkemNsdU1XNHBISTI5WG5oclVl?=
 =?utf-8?B?U0hlbHZPTGdhYlRTR3l0eDM3TUxqeWVCWGhxYnpMYk41TFBYUFp3bkVwQ0Z1?=
 =?utf-8?B?a1plMkVxSmRMOTJ2TitJQURBSy9OMU4zZGVSS0VBeG5qOWxLRy9ER0JPMTRM?=
 =?utf-8?B?UmNSWk1UMUk1a3hObG80MTBaK25nRnppSWg3aG11M0RHRjBtejR4VlVyQ3RD?=
 =?utf-8?B?akpHWFVZMGxQdHlSYXJ3cGhkL0RoYzczNnZRdHY3NjdNYVd4c3k1QlFGQmR5?=
 =?utf-8?B?ZXRMUzJIcU85YkFlZWpqK3RzWE81VVZGR21QMEwxVFROMlpZMGl3b1JsRk1i?=
 =?utf-8?B?NmM1c1crSUd3KzNUWnhqQnU0VWN2aFc3N01pakczeVl5MzZnZ1lZUDdobEhi?=
 =?utf-8?B?ZUlUMVlmNEQ1VUlET2g4R1l0WWtUOS8xTXgwejBlME1LMytIZFhLYkdHUDgx?=
 =?utf-8?B?cWcyMkVvYmppNGI5WkRVZ1Y5b1gwZXdHSWFJN2daTHF5cVF2dGNvUTRpZjVG?=
 =?utf-8?B?aVQ2SkowZVZINjdsaXJqWk5XWElXMXVva0V6R3V1Wlg2d1lpeTBwZE9pK3Jh?=
 =?utf-8?B?MXI0Ync3UkVxRmxoeFNvajZnOEhuc2NBd1JzcDhya2kvOE5VSWNpdzlMMHM1?=
 =?utf-8?B?aTBaWnUwb01td0lmelNPSmhCS0ZhSEEyMGFzS2RGYjB4TUxic0ZlOHVTV2s3?=
 =?utf-8?B?RlgwNVEwMVY4elBnSnhmYXpHZ3VUNGRQZURMZWRBME94dXlPbGp6M0t0V1BT?=
 =?utf-8?B?V0JnVGVSM3hicXJ4ZUVKU1hxaTVnN3VwdTMwbVhCb0E5OU5JT3M4NUlXQjZu?=
 =?utf-8?B?UnRDWHR5SEFyT2N3UVRXaTRmampGaDdjbzdncG00N2U5ZCs3VXp5VVlqaEtn?=
 =?utf-8?B?L050UHBvR1hRSjlFb1VEc0tvQVEwWU80VFI5citYVXVxQ293VGJyVTNxdzNZ?=
 =?utf-8?B?aittbEVFbDlIbUxuaVJEMmpHZ29tSk9qd0ZId0VzUURwejNjbmM4TTdsTmVn?=
 =?utf-8?B?OUg0eXh4MVJnK0Y0SEoyd3VGbkZqOERpRk8xWS9VMFI3M0dnSngrdCsrVXY1?=
 =?utf-8?B?SDVHN1FxaWNBWHNteStHTEltOTFUSSttbnVjNzdveXlGZ0tkblpBOVQ3VGkv?=
 =?utf-8?B?Q3crZkEvdFNtMDdYREtBbzhwV1A4RlRLZm0wNGRpNXZDTGd4YVQ2SStVdnd0?=
 =?utf-8?B?amh3SW0rODg1MUFvb0psODVNaUZrZHFEUTBTVUFaVHg4K2kyakx6c2VHUDc4?=
 =?utf-8?B?ZVNoWDNyaXNiWGxxU1NZVDhqSjhVWFlhMEdaclZybGg1ZlFMd2tUTDg1Z3ZS?=
 =?utf-8?B?VHZnWjdveHNqczVSaURQb1A0UHNCcWFVT1YzbFdaNFAzNEwraDJBbTZweXl1?=
 =?utf-8?B?R05HSmJoL2hPK1creUpHM1ZBY1NVdXovalZxZjZnVDFwWnBGdGdFRlJoZDM2?=
 =?utf-8?B?U3BmYzAwelRRcDE0N09OR1RteVoyRmcxeW81U3R0MkkyaCtNZWgyTzRJY3Bs?=
 =?utf-8?B?djlPeWNyd3VseC9zS1ZlWFAzNHJYWUhkWlJ4OCszNVFzRFBzY0liWXh6SDlz?=
 =?utf-8?B?Qk9wSzQydXFGSXVSNm55WVhsMWFCaVBjemg1bkl2UkoyQnFWRXR5UXFOdW5M?=
 =?utf-8?B?cUhnSzVYY3A5dlFBdVBqMFpWZmRMeXpDTEhsS3BKNThIU0drbDl4bHgzbUJ5?=
 =?utf-8?B?TW9JOGlXYlFheXNaSEh3Z1Urakx4azd4RzByeUZHb29mVkMzYi8yUFhzTzFP?=
 =?utf-8?Q?+DBVYuSOPD873vbssKclTZrDrF+plU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUdITktjUGJEOHltYVNjYlR5d0dEcThhSUczN0RnV3RTNnIraTZRWnBKZGtX?=
 =?utf-8?B?bWQrRnpVZ2liVTVONGNITVppOWhaeVFZNkt6VWFkWmtTNVB5dFp5WGc3WWJZ?=
 =?utf-8?B?MlBzbysxK0NCNm9VeU56ZnpUajRybGlZMjRwTUxhZTBqS0lqQWxxVXM2U3F2?=
 =?utf-8?B?ME5Ydi80aWo3bWs1RE9KVTBDbkpxdWJZMzM3TDRwSWNSclpBYmVsWldyQndr?=
 =?utf-8?B?TVNScXRydjVUMVJFVzNvekY2cmZyMTl1MktScnN3MndpMVhoY2ZHY3NkNFRI?=
 =?utf-8?B?ZUk5cm1Wd09SY05rRDQ5NExSTlVKcjZoV25qTGpJeTBMNVZPaVllekZXODhU?=
 =?utf-8?B?aXN1U3AvVFQ1ZTlVVDEvUmk1L2g5WnNHa2NENWFrdVRYYkhsK3hiK1dKSEIw?=
 =?utf-8?B?dExYZFZ4ZG1jcWdpcGZpK25FRTBVaS9INmxtYkN4SCswQUJ5Snl3c1VjM3pD?=
 =?utf-8?B?T1Y2Q2lTaThsWUk3YzZteTlWcXFzcHZ3RkhwYlpLNkFmaFUxNUNYUVY1Nmdm?=
 =?utf-8?B?MVFQc1VtQmpmRlo3b3JvVDJURFowWHFBS25EOE56M3ZQaGlYeHVHT3VUZ0xP?=
 =?utf-8?B?Nmg0VGRyT3BpN3k0QmNHUll3L082clIzenFHbjlFaDJxMXJPRmNxVmFsOUpJ?=
 =?utf-8?B?b1pKRjdUbEk4STBrdXhKNFVidkRmdGlvOENRK3hneFB6Y3VtTTVQY3AvK1JV?=
 =?utf-8?B?OFJvKzZWT0lVVXZKS29jUkcyNlRpOXI2OHdvR0FQL3ZKaVA4OWJKNEpkVFVr?=
 =?utf-8?B?TmRvQUwxeGJWNk4xYnVheXRnYWUwRGVFa21VZHYyL3BhcGRsSi9FamMwTFEv?=
 =?utf-8?B?TmphQ2JpblZ6MzNvaTJoSVF4cVl2OVVCTEhZQ1lVTVpEdXFEZld5d1ZHQWN5?=
 =?utf-8?B?TE5JZi93eW40c25iRWVoNDNtSzNPVnFCUDVaSFdBako3eUU5bmpkck1rSFox?=
 =?utf-8?B?NWVuUzBkRU9PTVZSS1BYa3Z5Wlk0SHZkWk5aWkIreEF5TnBRdWhTZllqSnU4?=
 =?utf-8?B?ODQ0cXlmU0t2SzRsK0Y2U2p1MGFhZ016SmxwN3pSRjllenZHeDZxY1k5YmlE?=
 =?utf-8?B?NUlSS3RhL0tKVTVVVWp0aVhQL3QrVDA3QlpVa2tHdmRPMGZuMVZBVVJpWDhm?=
 =?utf-8?B?ZCthNnB0M093NUNpenJaOWx5YWtqRmtnVllNK1IybDBYc1hGWjdPRE0xcUtR?=
 =?utf-8?B?c2FuUDhwQXJJcHdGbDlFcUdHR0tCU1EyaHRSam52VVgxVXRkV1JMUFZHTy9r?=
 =?utf-8?B?TGQ5bEQ1Q3lMRmY0M3J3cEp3dTJqTmZVU0Ryd09iYTNjYjgvdmFVQXo1d2lF?=
 =?utf-8?B?ZlVGdlgyVWpWQlM3aXFrRGIzV04yTXJYSUdHcHhFcGJuYkNHRTdjZWdwS0d1?=
 =?utf-8?B?Y2RObno5bnBZaWhCZTBsZytBaWp5UTU1VlJiUGZBV0U2cm40UzAyN0tYR3hl?=
 =?utf-8?B?aHhIQTlndWZub0ZGVDRHQ0lQM2xoVVMzQVdrL0htdjVFYVV3NVF2MVk4dy9D?=
 =?utf-8?B?Y1V2ZzFuYmZmSFFobXNlWTdwRFBRa2tCb2NTNTQwRTczVTBVRnl3Y1JHdUxD?=
 =?utf-8?B?UHFPZ1VsL014QlRjQnhkaGRseEVnUGNXNTgzamQ5akJKWGE4Z3N0cDZ3K0RF?=
 =?utf-8?B?eWRuUG9rRUphSllpdUtZMlJ6Vk9DVE9NVTBoTkJtNnNKSzJteWR2UnR0RWU5?=
 =?utf-8?B?dWlhU040VWVydHN4TitBT3BzeTNuZU9oRlJwQ0hkcnhBcG81NXpZVGJBN2Jm?=
 =?utf-8?B?Sy9GQ0hJVVlvYUxabGdjQ3JkTTg2Z2ZmUEIrVzQydS91dlBxc3RmS25JWWN2?=
 =?utf-8?B?L3UxYU00UUhtUmNBeXkrSkNSNlJQa294VHh0cmtScDRNaVpLc0VXTUJkc000?=
 =?utf-8?B?Nkp1VStXTFZ0a2IrTVF2WlJ0ZThnVFRNZmZ0NWpnOGNwSXpLRzlYVm8wWVBn?=
 =?utf-8?B?WjdxNHU3WXRNb2dmWjNsZkxBUzR1YktqUFRucGM2ckk5bC9Eb0hvMkMxT3pl?=
 =?utf-8?B?UUdLMWU0WTNnQnJkeGpMOUJQalRFZnpobkdyR2t1SElmOUhOWGwwaGZBdUU0?=
 =?utf-8?B?blo4cTUwWFdJcmFtNDZyYmxDUFFvM1QwNVZraWY1cUxxTk8xZFJ5NUZMOE9G?=
 =?utf-8?Q?90Xw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd3991a-45ac-471f-d646-08ddeeb55e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 08:54:49.8097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KATAnUe97mMw4kHnmGe50XizB18rTsywKriGtiY7dUHy34GiStC8PVXcFjqx+6ISIgk2GRPuhqaLPM3P/73ubw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB6089
X-Authority-Analysis: v=2.4 cv=ArLu3P9P c=1 sm=1 tr=0 ts=68be99de cx=c_pps
 a=m2tzK+5tEFzy8O583httjg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=6kNuK2YmLRr4-mn7wb8A:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA3NyBTYWx0ZWRfXyfIImUqbmco5
 XrvKO7JuJUxGnU+DHO0J+OHO6ypsrv/VDmPvMNq/GPXFT0rc6tyGO6UxhMOprWVpe64HTKxWnoP
 +sEfnnr9HRvVICfuIc0ATJ4hIyQM9BjhGBtVQAMMYEtqlLJMSf807zSiaKHTpzWnPNmzgvwmlfS
 /4bnXs1xz5R2uJuRyeb07dc9zzE1KfqdSlABUUzaVLthSEXkv4/CPXRSYAKpRKBnTBTUkuDL87l
 NAdrVb1slpRTO+tupWmBTjf3DgAUPZkuiWyADE4q/kCFRhIZpjEh7DHMKQAcWqDdF0IJ86y4KB1
 GTE7J3hccZXV+8e0jKEAuK+5CEaj71m2JgvMAr/eD6T2vfwjjT18x0TJ1uJO/5CA8uPQv/qUlG0
 K8CXavWU
X-Proofpoint-GUID: AGaSs9Hy9VzKF-OjXe-3kl4s0w9kqDCo
X-Proofpoint-ORIG-GUID: AGaSs9Hy9VzKF-OjXe-3kl4s0w9kqDCo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
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

PiA+IE9uIE1vbiwgMSBTZXAgMjAyNSAxMToxNDozNCArMDUzMA0KPiA+IDxza29yaUBtYXJ2ZWxs
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IEZyb206IFN1bmlsIEt1bWFyIEtvcmkgPHNrb3JpQG1h
cnZlbGwuY29tPg0KPiA+ID4NCj4gPiA+IEFkZGluZyBsaW5rIHR5cGUgcGFyYW1ldGVyIHRvIHBy
b3ZpZGUgdGhlIHR5cGUgb2YgcG9ydCBsaWtlIHR3aXN0ZWQNCj4gPiA+IHBhaXIsIGZpYnJlIGV0
Yy4NCj4gPiA+DQo+ID4gPiBBbHNvIGFkZGVkIGFuIEFQSSB0byBjb252ZXJ0IHRoZSBSVEVfRVRI
X0xJTktfQ09OTkVDVE9SX1hYWCB0byBhDQo+ID4gPiByZWFkYWJsZSBzdHJpbmcuDQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogTml0aGluIERhYmlscHVyYW0gPG5kYWJpbHB1cmFtQG1hcnZl
bGwuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU3VuaWwgS3VtYXIgS29yaSA8c2tvcmlAbWFy
dmVsbC5jb20+DQo+ID4NCj4gPiBUaGlzIHZlcnNpb24gZG9lcyBub3QgYXBwbHkgY2xlYW5seSB0
byBuZXh0LW5ldCBvciBtYWluIGJyYW5jaC4NCj4gPiBQbGVhc2UgcmViYXNlLg0KPiANCj4gSSB3
aWxsIHJlYmFzZSBpdCBvbiBuZXh0LW5ldCBhbmQgc2VuZCBuZXh0IHZlcnNpb24uDQpQYXRjaCBp
cyByZWJhc2VkIG9uIHRvcCBvZiBuZXh0LW5ldDptYWluIGJyYW5jaC4NCg==
