Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49573EA810F
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:16:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 844AB4065B;
	Tue, 10 Feb 2026 14:16:05 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7FF5A40652
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:16:04 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 619NTNYu2972072; Tue, 10 Feb 2026 05:16:03 -0800
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023139.outbound.protection.outlook.com
 [40.107.201.139])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c7s9q9fh5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 05:16:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5NIOAv1Dp43GAWTZwJg3rwjRa1UvkVA9Mjaqc6wqknZYGVBmZ5WPLF18TCTKxBK3jGb7/EQxVnTM5KiJhuuDyok6bAj8XYVZUVeBy8IVvsZ4yO+4NVg8WBa0PgJClJWVQyR5ZSlf749hG8qhnUW+jbwg38HJPwf4pXMiHJspPNn1w+0Naz6Q3p2QzSTrTxrbK/l1NkLg+dQBEDulnVC3QfJllzt+u3v3bbMxaha9mqOxmI5UXtKMQSRUvYC6x/WUn1WiWl/bwtANtfrwQGLN4bPceYjvR/3rdcPh2oLDwA1ZP5H8HhdC0nCVyr+s0GtRGlkPnVKjD0Ydh68Rtf6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3siK4wJ8xf7HX57Az4AWffiMIOLu/tQezrZ6jylukY=;
 b=BM6BM1giNVfEbcBTRANFxUBe3/5DGtjEIFzBX9kJYxjHHXZcWuTYeYIzbVF/6AmOJZcg1b4+m9QT/sqXHQWLfs5guAIoLVgJ05ieB80RA0M24oljB8PablqYFZkTC3oumGVuwqONh5do49inXqfIw2Vbe4lxbY+Jala1S4wTfQYsT9L5ovM+UiOAbj8k2E5eyTtWKGdBNz/UCR9+Du6qfNC1wIAGmSNkS+unjH0de15kXBL/SBKNHaOHOiHfLgWWLgwlDU5WNrRZGhmsonNyb2Lqxsblfn0TGzz/fr86/aDCzfeRdAHDTSpfy/O3f4SKDO1NqvuC7osK0LUKnSf7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3siK4wJ8xf7HX57Az4AWffiMIOLu/tQezrZ6jylukY=;
 b=TVhR3ZG/ay/fcZm2H3Pv6XJYNAXCbR5ChX2jzgcqxrmS7wqrNYTJcb7jHuY5FDdxx7ALuvlmrGj1YkHULpGku1v4ll69iMG5c5VMczLA7SvQJo4Rf89MJ3VNCJhjFcgE4WgwiSuUgTCI0ah09eOMA5KDBmswcJ8YnIddrhzbIsM=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH3PR18MB5617.namprd18.prod.outlook.com (2603:10b6:610:1a0::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8; Tue, 10 Feb 2026 13:16:00 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:16:00 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "Finn, Emma" <emma.finn@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [v2] doc: update device configuration in qat guide
Thread-Topic: [v2] doc: update device configuration in qat guide
Thread-Index: AQHcbzar+up9B50bsUCjIjdJv4eEZrV8QEiA
Date: Tue, 10 Feb 2026 13:16:00 +0000
Message-ID: <CO6PR18MB44846B4F0FF759A994D1C403D862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251201134711.797983-1-emma.finn@intel.com>
 <20251215104109.1476713-1-emma.finn@intel.com>
 <SA3PR11MB74617FD778283A8863CDFB3181ABA@SA3PR11MB7461.namprd11.prod.outlook.com>
In-Reply-To: <SA3PR11MB74617FD778283A8863CDFB3181ABA@SA3PR11MB7461.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH3PR18MB5617:EE_
x-ms-office365-filtering-correlation-id: 9a547a09-1b18-419a-b013-08de68a68902
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cDlMOW9Bck9mWkxrNmxiS1lnMWQ4bWNlQUtpRm5Dc3NISHh2clhUK1RaM3Nm?=
 =?utf-8?B?V25CaUFpNmpWVlhGbEJCcWV5V00yVndiS0YyUGZ2c0hYbWpHZU9UdlEwYlcr?=
 =?utf-8?B?aGVlQjNheFZPVVlOL2l2UVc2NU91UzNPNUFMYkM3dW9ZaXZMWHVrQW1lY3BS?=
 =?utf-8?B?UlpCRkFITEp2cHNWcHp6eWhUSEtDVjBiOWNERlZqZ1gyV045Tk9xdjFNVnZq?=
 =?utf-8?B?QjE3S3p0N3pQbFdWNGRzV1E1Rlkyd0pzNUdwVzd6UEMrbnJKUmhTRUNFaUZP?=
 =?utf-8?B?QkxjcVFjQVJuMk5ZZklNNVFRbHhORFYyN2pzZW1JN0VvSUQ3ZEM4SGg0YTBN?=
 =?utf-8?B?bXIwcHUwYzhqbS9naXFxN2ZRMWZlS29HcEFEQnEvZ2xRaUJiOXk1SnhEMVFU?=
 =?utf-8?B?TkVJb1UzSGY1VnMxMXJaQU5VWTMwbGwveXBUdGNQMGxBaHJOUEYrTEYzUlFt?=
 =?utf-8?B?YmpMK3oxdUtIeXRhMmVEYSs1QktKMkVFT2RjRWRFWm5KS0FUeDM2LzUzRmFH?=
 =?utf-8?B?bTFuNEFXb0tSbEZHKzVsVnVvNjdvMi95d1lOdHR0NWNQVjZCVkZOamc3ZUFG?=
 =?utf-8?B?KzhOSDY4QmsvR0FFM0ExeHJ1YlFNRjFaSHZ1WWVCcmRuREtHYTJFTk8wWEZC?=
 =?utf-8?B?WHB2R2t4L296QzdJTDNCQjRaK1o0YXhuakJ0Zy9lSTlOSVBDRHFCbllNbWNm?=
 =?utf-8?B?VFFYdlZ0SktleDZWRlFaRVQwZTJ3WDM1MlliN1h4OUJ6S1ZBajRaK00vbVlD?=
 =?utf-8?B?aDB3dnpnbHZjZlJQaWZuOUk0eHVhNlJub3QvelRJVzNMbG00UmFTSkpQYVJx?=
 =?utf-8?B?R2lyVW5aN3V2NnMrc2p1R05FSDZVVkdRb1FzVko1bkhublhuZzRRUnlBTlA4?=
 =?utf-8?B?VUJDOW1YNzhtWGZPbnQ0VWxKRXZjdGJUK0h1WGg3eURIYlpWQ0NWbGpKcENI?=
 =?utf-8?B?ZkhTaFVVZVg2T0lPKzkra3RBTzFpbzVSWGQ2MitLVVdtRXJsT2NTRlV2R3po?=
 =?utf-8?B?ZUpmVnUxVU9Fei9WSFRtdm1abW1oOUpwaHBWbVlxZzMrQVNlV2p4YWh1bFN5?=
 =?utf-8?B?VkNiWmwya0g4K3FSWENHZDRDZkRibmZqc04zSVhCVFNIbDBYLy81UmFibGpx?=
 =?utf-8?B?cHVnT2hwbVVwNmRIaWtSUjN2ZEE5UEN4d08weEJFNVNHaHRYNURPNVZRT1BM?=
 =?utf-8?B?VC9CTzAxcUxaNUtpdmtHeDRVYXRNSktrTTlBOVFVaVFURHlkMUJPdnZUeHBR?=
 =?utf-8?B?S1ovN0h0ekJuaWZJblN1d1B1TWY2cWdhRUxiRkpnZThJNFBrOUc3N1BvdUhM?=
 =?utf-8?B?dms0ZDdrWnJ0UU05RXc0d2NybEIvUENSeGkvREFDd2kyeVFBclRTbjQzQjUy?=
 =?utf-8?B?VW9YMUlVd0JUWmw1eTNFTVBaalVnMXE3YjVKQkFZOGhGQXdDVTVYMWtZcEls?=
 =?utf-8?B?eGdoV3FWUkRob04vSkYzaFVYaUlvbStYMkdLem1JQUxFZkxWemZRTk9SUW5N?=
 =?utf-8?B?N1BjVEJ2bVorWFhGRDRpOStHVHpjaUZzTFNDTWk1ckozQVFnYXJmRW51UW45?=
 =?utf-8?B?RlZmeEt3cFdWWnNZdVVDNkRhUEdoeDk0bG9zYWxjTUZrcWRsRFZRWFJRQmhL?=
 =?utf-8?B?TWtWR2dkTWtWZzlkalFPOXBmVzU5MTd4NFl6MDBtMEFrYldITVpDSENTWS95?=
 =?utf-8?B?ZTgvQi9kNnVWVjZvY0RNUjFTRDlHeDVyL1d3aEFZbXhhYzJRV0tXRGpCMHd1?=
 =?utf-8?B?cGlDTFBZWFg5ZzExdGwvQnVGUFNlMGtpR0RLWC9RS1hpSnhJdkFUV2RMOVNi?=
 =?utf-8?B?VDcyTDdISnowd250d1YrTDVWcWxXQVp5NDNFa09oYk5xeERPTk42WWpvckF0?=
 =?utf-8?B?RWw4QlRuU1ptbmZxSjNJQ1g1QW1WVzNzM3BHU29OM2Y4dzh2bnFNOWNGVEhx?=
 =?utf-8?B?YWVVRDJmSW9zcEFMUmRFTTNTLzI5T0dva3dvK1VWQ0hPeHplWDFRWDFEbCtp?=
 =?utf-8?B?eXF2cVh0dG96VldpYUphS1hVSWlrZTV2cGd4ZUtaQmxlS2FDMFZKWjUvQlhH?=
 =?utf-8?B?b1FyelJwWUhEWFVrSXdVVGYxNVF2WFF0amk0NmpNUWd1NE9HNVFnQzRRU2t1?=
 =?utf-8?B?dFZuS2QrR0tCd1d3QmpTLzRJTzZXRkk4WWduY3BtakF2bnhza0x6NnFYTTBR?=
 =?utf-8?Q?IZNiBdbwQVSrPh7RBhClMs0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkFKRU9wOUhBUkt2cGhiSEdvVGpyWVQ3TFp5QnRKcjk3eFVJT1hkaDhDVjdC?=
 =?utf-8?B?eCtDZjlCL201b2pWRzdHbkRvTFZSWUxsZGYwQkhtWFhYYnd2cUpGZGtnQ2hI?=
 =?utf-8?B?aWZPZUhna1ZnU3Jnb3N2S3pzTHZaRER6aFFRMjJGTmlRTDF1dUFROStacUZw?=
 =?utf-8?B?bm1iZUxCb0dJaEdxODZKak5hcGZta29JdFZOejlvV0NjbjU2em9hcjBPZmFD?=
 =?utf-8?B?Tm0xMFZETG85aUUweEdpYSsydXlkVVJYalRtYlkwTEJ4a3pVaE9FZCtIRDQ1?=
 =?utf-8?B?ZkJhT2lJeXRKQnVUKzd1cHhnS28yRm1GcUxmREV0NmVEMVN1RXMzeTlING1Y?=
 =?utf-8?B?VDM5TlJ1cXJUcTE2V3dQR2hqUXFyRS9GZDhTQ1I5ekNlT1hzMFFoOGJqTVVT?=
 =?utf-8?B?eE5yTCtCaHgzTnVZVWRnelI0UmpSS2xsZ3hDMVRBbkxKdDFPOTlaVE5DYmhy?=
 =?utf-8?B?eUR3TXJ1NWpIZ1pjcnhOVUVlcXJvNHR6cnhNTlUvOXI4eGEvODBmRGxNcFpE?=
 =?utf-8?B?L050TUEyL25oblpBK3A0YURHa0t4K3lOdWJKNUlhajZDbVd3czA0bUpjQ2F4?=
 =?utf-8?B?a2lHaW5xNGZWa0hoODBrZTduZ3oxcDBrZDlob3plM3ZLbjFERWhNbTRBRnJO?=
 =?utf-8?B?U0lwN2MzcHNJREJGQ2JwSXEzTTRhbTYrL2xFdHU1K0VrbjVUZDRwY1VFdHdo?=
 =?utf-8?B?SG01MWRHWVE0bVFrRWIzZzNHUkhYNWU4UUFDTUlIVi9EM1lIWGZtYWZOSEU0?=
 =?utf-8?B?L2hITG5mem1qMktXZHorVUdlbWFKV3I5SmpqZ0VGU1RvbVJ0ZTBibkozQVBw?=
 =?utf-8?B?NTl2bjhNc3Q4ZERFVG1yZ3NjckJCMDZTdmMxSHdkNmN4a2pHSGkxaU96NzY5?=
 =?utf-8?B?RzZOM1YzRDRxU3c0TXkzZjlkalQ5Nk5xaWVzOWh6SHc4TGxKaHAyNU00eHg0?=
 =?utf-8?B?dnhzSFpyaXYraDRHVzUxSVkvUXA3c3RpamhBVDUrQlliUStkZDdVdGw5S3Rm?=
 =?utf-8?B?aS9mY1ZHRDR1elQ1d2s1Um5mUXJRejBLWjIvRXhnOE9QNHNWT1JKRGJVdXJl?=
 =?utf-8?B?VFR2RmhUb0pnem5ndEpzU0VCenZia3RCSGNBOUxKRHZIZ1JZS0lVS1dXNG94?=
 =?utf-8?B?Ym1HQUtYNzFZZkZUOTFLVS9SZjQxSmxPRGxPZWhzcEhRc2Rlc0RIZDRIZEkr?=
 =?utf-8?B?d2VMVlpHOThZRi9WTTE5dUZOdVovNm1QZFNZMmdYWlRnZ1lFNUFyOGRyb05S?=
 =?utf-8?B?aTRocFFLdVIxcC9aRDNIcnYvcUtjWUVsT3VtR0lWQ3dFeGhra082WjFtYWJZ?=
 =?utf-8?B?SjQwRWwyNUtBaXdpd0dwUnFEMzBCaDJodS8xRkhpZHYrZjJ1Unpqd01jRXpi?=
 =?utf-8?B?eWF2Y2FaNTQzQ1dpOGhJNWFoc0FWVXd1YXhDWVJaZElXai9LTTV1KzZma1h1?=
 =?utf-8?B?ckdUVnFnZ051L2dNV29KL0JGb0xvUVd2MlAwVnArV3NHYjJNZVZtdHVvYkIr?=
 =?utf-8?B?MzUydzU2MzY1K3EzbVVzNTdwaVE4dHhWa0kxZGdrQVVIWHpJUHkzbW9TeFZT?=
 =?utf-8?B?NTl6Y2h4dC8ybWIyY1pWQXpsNUgrVmh4K09RZlJBY1hVcCtMd0ZhRVFQQ2xp?=
 =?utf-8?B?eU9MRWU3Sm9BWHhaclhuZ2h1UnhCUzE0VWwrZlJTTWl6N01meXo4d3c0cHJw?=
 =?utf-8?B?S2h2dFcyVkRZL0g0bHBHZytuYjRHUXR2aU5nMW9yNEwyNlZZWEVsMmVEakNH?=
 =?utf-8?B?V1VKVTNjd0JxUS9BRG42dE9XMVAveE1BeVNBMVZNdjhOV25EUmlRTDJ0UThH?=
 =?utf-8?B?ZERkN2FmLzNoNWpMQm94ZGlPbGNZaS9BOXJBQXVVa0VZQ2lqM0NkcGhyS0Rv?=
 =?utf-8?B?WHFmZS8wUW1FK2ZDck1nRm8zVU40WmxKaXBGSFRnNXVUVzA4VUpQazNUdXo0?=
 =?utf-8?B?RlBWSkx5ajVHUDkyV1ArK1AzUlFuUlRyYVFubUVMSlg4K0prRFZvZy9zQnJ5?=
 =?utf-8?B?T0ZtSkh5aEVpeE9yZEVIOUJXNUIxempMcFNCYXM0UDlzTndiS2VacFBMMlhB?=
 =?utf-8?B?RjU4MzZzeXNuQk5EKytub0E0UitVZ0k3VXl2NGdxZkZLc0l6d3FjN0VEcVl5?=
 =?utf-8?B?NG5JME1oOXpxcUIrRW9ubzlXNXhLUWErMnBzT0Rtc2pLaUY0WG1jZEhMcG9P?=
 =?utf-8?B?WGxaV01CeVZDUEJ1SjBUakxRcVJuYWlXN0xZMEdHZ1BqaGxqdFpPc1ZUdGhM?=
 =?utf-8?B?bFlRSWhvbExLOGpZZU9jTWR5U2p3ZmNPN1QxTDFhQXhXaWVJYndLb0MwK0Za?=
 =?utf-8?Q?VlN2JO9hywbO+4a7d8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a547a09-1b18-419a-b013-08de68a68902
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 13:16:00.5064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zHcEme6cn994x8ras8va65u+0BNQxWNfq04pnjEC1eHaQVm4IfYj5sQo1h+QHsJiWHKRjW/rjYFP3YdWqMC7Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5617
X-Authority-Analysis: v=2.4 cv=a/g9NESF c=1 sm=1 tr=0 ts=698b2f93 cx=c_pps
 a=3S4Drl1XJvmPajLigRaLYA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8
 a=8rWy6zfcAAAA:8 a=KD8QAkUHPGcM6O3A8bEA:9 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExMSBTYWx0ZWRfXywya9T7OrhHD
 y0B7z2SdAtJBx+s6zEUcACxEtswUtvprvaf9cTNjg4y3Nw8i0TqOxKYYFMICOiWXz877G9ZjDaQ
 j1BAeWP4lDpqk96d+lMWlypq0c0HzX/igxPlRi2LwjQm2KrmyuYhmk+ygODYBfu3LTG3akbShW9
 NhTjeayxO2vqB4q6ev4vUtAytsshTXnKWEOhzpda4fU4ZHy+2APa8a/eYBKSwi8al+k7J7mhQSB
 BJ089Q9yfOjdVIbh/zhCc7tzRnBAw4cbV7scx/juJx91R3M1bd6iyD+PUoP+J3cF/oT2DbqhzVH
 2ePFrQR4cwUCGoz6ELmk/r9IBXeCGRw7NlYWyhkdY6TzhbGdGJrVIRwZ9xlij4f4Qu5NNe6mU30
 xyG51eie88uuGMN2Z+TiATM/x2SkOBKVSq7cuflOnBAQiR+Nth0wK0jCnq8uaDk3BmWYgxeyoz5
 flTYxwdERrjEcmdwzbA==
X-Proofpoint-GUID: C7mhhPF4c4YQnN4gJ-HhGmT-7dUNU6CA
X-Proofpoint-ORIG-GUID: C7mhhPF4c4YQnN4gJ-HhGmT-7dUNU6CA
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

PiBGcm9tOiBGaW5uLCBFbW1hIDxlbW1hLmZpbm5AaW50ZWwuY29tPg0KPiBTZW50OiAxNSBEZWNl
bWJlciAyMDI1IDEwOjQxDQo+IFRvOiBKaSwgS2FpIDxrYWkuamlAaW50ZWwuY29tPg0KPiBDYzog
ZGV2QGRwZGsub3JnIDxkZXZAZHBkay5vcmc+OyBGaW5uLCBFbW1hIDxlbW1hLmZpbm5AaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBbdjJdIGRvYzogdXBkYXRlIGRldmljZSBjb25maWd1cmF0aW9uIGlu
IHFhdCBndWlkZQ0KPiANCj4gQWRkZWQgbm90ZSBmb3IgUUFUIGRyaXZlciBpbmZvcm1hdGlvbiBh
bmQgZGV2aWNlDQo+IGNvbmZpZ3VyYXRpb24gZm9yIHNlcnZpY2VzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogRW1tYSBGaW5uIDxlbW1hLmZpbm5AaW50ZWwuY29tPg0KPiBBY2tlZC1ieTogS2FpIEpp
IDxrYWkuamlAaW50ZWwuY29tPg0KQXBwbGllZCB0byBkcGRrLW5leHQtY3J5cHRvDQoNCg==
