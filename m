Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A51EC54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 11:18:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ED29427A4;
	Wed, 21 May 2025 13:18:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2BF6040041
 for <dev@dpdk.org>; Wed, 21 May 2025 13:18:04 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9qfC5001293;
 Wed, 21 May 2025 04:18:03 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46sbxkr78y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 04:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWASx2PZ5LWqoNsVEfcLXJnO4pRtkK97z1sZxdAYXPNGm7FP8dn+HRnkKUzGw1mLdy9e5617avlAiA35IKNEAFir/2gEXwtezXkIG7LtUgmqChJhPfI6ZR9XV2WBc/bcn4NEMy92QN2trydSnasrkA8cmsbuQpXmSHoUxIyB/sZ2KpR5+R95n8qM6oLbMxoHUhAnCq6jvgl4Q5QY2D3y3j0HLC2Dg16NTW5Ro4QGZX21Kw5846iDLzPBJU976u7VpaGi4/wuC6wPu+Hq0IVfRY4gUTlx4lwDG9JsaiHI6GwE3C1tI+ouDpnIXdvJ4glKMfZ9H6/CoEOOQRyfuFFTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udh1DjQlAQBrzeghBHNuCIpDJYPJZUDR+gypKMz/ye4=;
 b=zD5hSCPjlkAjpnTBBroEOSBSiKq3EIxxhnym7TFgQQq6NcwJguYUVy0D2PeB7RASqekKTupDE0is705tpHCBAWy73nQ1h096bR+xzUMFhr114FZXdVf4iuwkABi04+kyezQGVspqv8FRGC2+36x6yP0+AkjOtIY+umC9Y1SAKX/wDLkKjpJuMDgqaTElJeiIeDWVnMHliAbuuMdThQANTesMYABQdT9VLWd5UQF3Xuh8Xe/4q+z73YApWhQA3p3PzUQJdWobP0r+roPnjiAYiOxnZ49UNe2h+J/bGQV+ySoq4tnARlcbkPNwtvg2QaxzkBJNw1RHAkBM8IT0A0dI7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udh1DjQlAQBrzeghBHNuCIpDJYPJZUDR+gypKMz/ye4=;
 b=OU8QiP5CVDRKkjfqZKa5djEm3c0wRdhxbbeyv0abTnEEpHXfCECNwJK9Ivtw2Rm3oyMOdJ72NhG9nHEMtPjssSsMBffyMGplhikyTUr/NbTs6VbICRDceHL4JpnqTlwryM/hnnkzPAawwNuo2R2EjVgAqNwXVUVcrIPmvwDM23E=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BY1PR18MB6024.namprd18.prod.outlook.com (2603:10b6:a03:4a7::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Wed, 21 May 2025 11:18:00 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 11:17:59 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, Kai Ji <kai.ji@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [dpdk-dev v1] app/test-crypto-perf: remove decrypt
 test case from perf
Thread-Topic: [EXTERNAL] Re: [dpdk-dev v1] app/test-crypto-perf: remove
 decrypt test case from perf
Thread-Index: AQHbvy3lov/oXd6m2EeRRUjEZNpVrrPdBY3g
Date: Wed, 21 May 2025 11:17:59 +0000
Message-ID: <CO6PR18MB44847802823DFA24C8FB349ED89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250502101226.1405274-1-kai.ji@intel.com>
 <11d55a2e-d745-49d7-83a6-bf9f39a0654e@intel.com>
In-Reply-To: <11d55a2e-d745-49d7-83a6-bf9f39a0654e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BY1PR18MB6024:EE_
x-ms-office365-filtering-correlation-id: c8b94c63-5f52-48cc-d923-08dd98592529
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MXRkTlFyTUE3WC9ObXdaTVg5emdvVDQ1cDNpdDBabGlsSHVYZ1hyUUlvR1c1?=
 =?utf-8?B?YWNlUjV2VWpMaUg4MDROL2FleTRwYlpVZTlxL2FkdEVaZUh6SURjU1gzdzFU?=
 =?utf-8?B?bExSU1NiOTBreTBUdU1sWlErd1UreWw5cjJmTHVDS2ZDWUJrbkp4Mk9NdlZ4?=
 =?utf-8?B?clk3MXF2ZTJFMDVhVnBwRGlFK04wQzlDREF6b05YbDNmSmxrVkx2amthL05p?=
 =?utf-8?B?T1crQnF1YzNIaW9Ub0F6RFhMa1JqcVlra0ROWjY0eGVpQmZsZ01uMWxmUzYx?=
 =?utf-8?B?NEJ1QThxbENPNk9XWVdLbE9mUmNvOXRRM0hZNHowQnRiZjdWeGRMeXB5aSti?=
 =?utf-8?B?MFY4NlIzbnVkZjNRTnpOTm53S28vdVNaOTg0OHcxaitpSDRnV1hFQ1BzNVg2?=
 =?utf-8?B?cDlYU2psZzEwaE5tVGdOK3MvOEJ0TVNzTkVhdGRCMkc2SDRvZndSUXZJSVdu?=
 =?utf-8?B?T0lZdHlQQzk2UTh3a3g1c3VUaFpDdjl6cmNtSVdkNVRMck16SlF0SzAzMVVQ?=
 =?utf-8?B?UkMrckxWekxTTGVKWlNINmx0NktlVVNJTmNqY0hBdjBCaHZjRFZZdGhaV1hE?=
 =?utf-8?B?cFVseC9GaFp2RUEyN1BKNmRLNkpTNzNGWHJxL0MweExaczRYSGxac082NzAr?=
 =?utf-8?B?QUpER2x2SWJaam9uTnNmZlFBTGV1Y2pYbUN1cnNzcEpoV3p4U1BNM21FTzFt?=
 =?utf-8?B?d3VhaThndlc4RS9xdHZQVVNnU3RmWDFpdlMxUmYrTDB2NDJOU3BXdGlPNFZ0?=
 =?utf-8?B?K2NFQ1VFYi9ETzdKWWJnVXpwQi8zVGtWL3NLdXM3dERkSWp3SXExUjhkUjNl?=
 =?utf-8?B?OVg2NlFTSlBzeGNsQmtvOW5SM0h5a1l4TjVoRWtrWWswUTh0YVBTdS9KNjBT?=
 =?utf-8?B?VDJtM2pJR0xGaFBaeURyVDdPbjNjVGFrMk1DTWtDK2pOWUJBODRmK083ZGsy?=
 =?utf-8?B?R2t2SkVzOUw2SGlMbVN5MmZVd1JRS0hKaG5EWjJESXREZndKU1lTZnlqY25a?=
 =?utf-8?B?d3JyankzYnNhdUpWUWlKR01ScHlWVktnQVJFVFBtZTJvaW9UdXJYS29wdUsr?=
 =?utf-8?B?K2xwZmVtNncrWVJOSlQxdXg4dms3V0NESHdzTTk3c3RmbERvbk1ub3dqWnE0?=
 =?utf-8?B?Vk9TNm9YazhFcmtSNXB3eldSbjVXZ0JPMDRRTFJvNEJmOE1xSW80RFNQSTVy?=
 =?utf-8?B?TWp1TTBDdUxCbXB3YTFmLzE5ejNQbGxkd1hsK0NoTXpReE9pMjRxbEEwZFVl?=
 =?utf-8?B?Z2lOOVAwUk1FYk9aS2Q2OUxNOUREVkZwaTdzSXNnL3kxQVQ0V0YxRUxZSFVJ?=
 =?utf-8?B?YVZFanJ3Y24rNFU1NjB4VG1WQ2cybk9qMmlmbnhLSjA5K3FlRUhLdDAyUWlO?=
 =?utf-8?B?Z0RyZEIwMmZZUno5N0ZDYk5lMUl1bHBiTmhpMm5OMDRaNFhvVkxhd25kK0VR?=
 =?utf-8?B?NW9rTjUwQ0V0RVZGVTNZVUNKbnN1Znk0cTJOQXEzZEVMTzA5OXBxQXhvRExl?=
 =?utf-8?B?OTZrVEF5UUhkZ2N6V0FuTXJxREZQREl2Rnh4Ym0yd28rQTBHSE14TS8wVVhq?=
 =?utf-8?B?eHh6UWxJVFRyK1JzK0NsemNnVXVWcWd0aEVmcXdyV3ZFVDJCdU40Um5EbWV2?=
 =?utf-8?B?QmVrVzFzTDhWVzFwbmk2VkFxaGU4MkxWcnlvV3I5TDVaUjFCRUJOMStyYXFI?=
 =?utf-8?B?UG9uREdyRW5jWmk4NE8yVllIVmY5aGpLaDFUSW9ta290UzN0dlRKYmIyMlhC?=
 =?utf-8?B?ZC9MYUdHNDNGNTZKZ3VlSjFuZTVnMTlhZW1uYWF1YXZBRlFFNkpiSG1PaThx?=
 =?utf-8?B?ZVlzckh0dDlwWVkxcU5xZEtZQ3JGZnY1N0V3NUpwZ1JqMDJsSjlIQlZRQklG?=
 =?utf-8?B?ODVZT1VtMjNDL1VjYnBSdldEMzNGRGN1dXNVU1VHd3h4UDYzdHBjcS9wSFVz?=
 =?utf-8?B?WGExQVAzNWkydERwZG1ndFBPdUNheHM5N1c2bXZiajluVHgyZ1VuWnl4NEYv?=
 =?utf-8?B?NFVodzdYMENRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE1FcVBBYkFSbmV0TDJEaFlTcWkrcG5VWXYzb0psamNZRXRnd01BTUl6cWh0?=
 =?utf-8?B?Y0I0UGlVSmRXTDF0Umo3SXRreVVJQmRVa1A1NEx3NytRVCtwMGMxVXluOGtG?=
 =?utf-8?B?SmhnRGQxSVhKeVFNRVV0ZDRpS3JuRlVPdW9vNDRpRVcyajl6RWhOTTUzbVov?=
 =?utf-8?B?SFZXMmFCS2s2TFJ0TUwwbCt2VnNqUUFUd1FpUGdSeTEvUVd4T09uT1ZFVmR1?=
 =?utf-8?B?QW43ZldUVW9Hc0p0YzVvZnNtcnJwLzI5cC9IUkw5MEsxN3ZOVndnM09BRHpa?=
 =?utf-8?B?VEZzVjVWZGVLYWJtY0s4K0VXQzY5anZrdjdsbXpjZDBDRGdFaHRiM1prVXNi?=
 =?utf-8?B?SU4vbTZReG5aZEhOM09ydGhyQjcwdTcvVTIzUUdoZDZKQTlFN2J6NXlRL2k2?=
 =?utf-8?B?MFRyQS8zRXdtaWpDek1yejhocHNvTndCRUpXZ0xKUUorT0EwNmlnZ05yV093?=
 =?utf-8?B?TW14S0d4TFdRWEVDN2MzTEs3NGtWdmQyd0h1Yno1Q1VJVVhUWlJ6U0VWYk4y?=
 =?utf-8?B?eVRjTVNXNTFrWWdiZG1DazViRXcvS3N6dS9IWmgyNzBzOVVCVzhuRVZ2THlR?=
 =?utf-8?B?OEh4bkFCaFJKUFQwb0hmVGh4eW5oVDNNbVhhdW83OE5lTVhzN2FnSXErWjRN?=
 =?utf-8?B?Wnh5K0NiTExOOFUvMm4ybWEyUWc1VGhOdDB5WWxSTmx1Ry9xZnFCNm5NMU8z?=
 =?utf-8?B?QjJHZEJKbFRWUEhJTzdMWWhGRUdqTCtuZTg2WlJ1MzVtSlVUWGtRdkdjMkxt?=
 =?utf-8?B?VDJvNWR5OUcrdEw0U3FmMThzSGZKZnZZYk1xVXVsb0JyeWkyZ0JXeFhlMzhi?=
 =?utf-8?B?ZFdSRG15VGpvN0tseExiMDhYYjBFNXE4OEhYWnZGMGEvaTRlOFNQalQ2OG5W?=
 =?utf-8?B?ZXlqZ284cG9tL2RVWWhEUllsT0xiT1U3MkxHbDFUTkhjYmxqTHNoVWRZUTdt?=
 =?utf-8?B?ZDFSeTJwWm44ZnA1cUFKb2U3YUM4eGMxMUluYSsrSS8rZ1lRUm1mT01YcUtO?=
 =?utf-8?B?VDU5MXRPcmMra29uTzJQeTQ0OG54akZWbVpMMU80VllJQ0JoeFhqaUFoeERL?=
 =?utf-8?B?UGlHVWpIK0x1UTNCMlhIdVhrSCt2RGhoSHJnZktQZzZRZUN3R3o3VkRGbUE0?=
 =?utf-8?B?N2NVQUx3YTJ2eTl0cWlqMlpqVVdvRzRDUFlCMmdCbVJROVNGZjliTzU2Rlpq?=
 =?utf-8?B?dlBoUkJuMG1mZHRjZFFsS3djc0FFVDVGV2FtSURyTmZLZ20xQWFwd2I4dVY1?=
 =?utf-8?B?bmVWd1B3d0pabVkzUXE3ZlhNZHl0d09tQy9HbUNEaDZiOU55S1NNQmNnTHNi?=
 =?utf-8?B?MkVLd29VQ0RSNHBMcFVSZHZldTRDcFBBVENKYVVMNWp4T2g2UlBqUyt6MTFR?=
 =?utf-8?B?QXJEUTF5V3pqZC9OdGFxdzBKWHU2ek1LNW14ajJ5YnJCV1JiSXdLYjRiSjlW?=
 =?utf-8?B?RDBEWjFaSXNrdWFPc3NCOTZlQTlmcFFFMGMvQVozRVAvSW5NaTZYY2tDeDNv?=
 =?utf-8?B?ZHpCNmxuOW5YbkxIOFhNeVBZSzlDbGtTL0Zpa2pBWDZmMWxpd3FLcWhhMnlU?=
 =?utf-8?B?MEZ5YWJGSG1zN2NBVCtZYklWeml1eDY4R2FPYnp0dE5pWWJ2aDVsTjJFdEV2?=
 =?utf-8?B?eTcveWtkM1h0MVRhaUY5RGN5K3RuZHhocWkrUk1NcmpyWjFSV2NlMlhZbTlQ?=
 =?utf-8?B?eDVyeitia1pnZVM4dEo2NXp3Y2JrTHpBMjdPb3cxVFA5L1VGV0RQbTR3MDFH?=
 =?utf-8?B?c0tLMklmTFhwOWRlTmFRamZvTnBTVVlJc2c1MUE1QzRmYTBWVC9UR3NZR2JV?=
 =?utf-8?B?RDFlQ1d6emtIQ1lMeTYva2VWZW9Jcmo5dGVvL1F6anA5ZTFhSkdweUVCdDYw?=
 =?utf-8?B?cGY1WjFoRytrRk9ZcWJZTlRNOTFTYk04WHk5Qno4TEFjU2ZEdmZwczI4empO?=
 =?utf-8?B?OXFQSUxrSEtzaWRYYmgyRUNrd1B4NmROQkR1bTlCWHlNTlNNVllIN2dqNXg4?=
 =?utf-8?B?QVBuT1NTYytYbGtlcklQM1ZyMTQxVHk1WTAxWm5ZZjQzNUFCSkc1bEhuc05Y?=
 =?utf-8?B?c3luVUdVUGxVMTdoaU40eW5ES0tjdzVodXRxdHg4NEJKV1lSK0FuUGhndmYv?=
 =?utf-8?Q?vFYeULe7zCJRnqdqeJdZ6q7j2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b94c63-5f52-48cc-d923-08dd98592529
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 11:17:59.9429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRIWp5fyPNlFkciZhgJkVLsW/s2htYzYM7IMBcpV0zBxDomjlDUrYHUisUAfPwCH4XGPOKKPbtOh6g6JU6MdmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB6024
X-Proofpoint-ORIG-GUID: uBYK4rD7YWILzxygBMs1tBdNcG4LxBeD
X-Proofpoint-GUID: uBYK4rD7YWILzxygBMs1tBdNcG4LxBeD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDExMSBTYWx0ZWRfX6D+Yg4UsAWzT
 ZHDHoV9Z50eEKo4p7nuXCl9+LntRm66+y1zHs15tZmifqNeBW9IYmnxZr0OhKqasXio/f9krbmP
 cdOA6jY0UeSHcnzUb3MtZIo1H14jD3+YgYj02A1HfTF0iVnBhF2YoRwbV/q/Tgg0YVtmL3XBXfe
 IHrVNfaDz4wR3r1qL+KXhJ9RhSCGHL6RL/3EYxUDpwxUkoVch4HSUxJ1ysuvYDzPHMqTmqwwPgu
 bkPEugURbNr0Vngx1+so5CqxcnaWkAIaTVtCw8Ed+OV8AW6L/NeMraXAP6y9gNSAWq6W9/B5tc7
 7W/3J3rcHvIXAlKGYY3eDxI6Z3dRFeoaZaGkjVK/VRw0hasCwKu67K7tBdl3arsirt5Ju1e6gjh
 SXmXXoZJhfSZrVOzxPDuRZz68x2KuLo/KvvVfb+vLtwhfnMeBVAqo+Qzt/ZGWt7uT0O7FxnD
X-Authority-Analysis: v=2.4 cv=U72SDfru c=1 sm=1 tr=0 ts=682db66b cx=c_pps
 a=o9WQ8H7iXVZ6wSn1fOU0uA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=QyXUC8HyAAAA:8 a=crm5RUOxZ38O954Dy68A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01
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

PiBPbiAwMi1NYXktMjUgMTE6MTIgQU0sIEthaSBKaSB3cm90ZToNCj4gDQo+IA0KPiAJUmVtb3Zl
IGFsbCBkZWNyeXB0IHRlc3QgY2FzZXMgaW4gYWVzbmktbWIgdGhyb3VnaHB1dCBwZXJmIGFzIHRo
ZQ0KPiAJZGVjcnlwdCB0aHJvdWdocHV0IHRlc3Rpbmcgb25seSBzdXBwb3J0IE9PUCBieSBkcGRr
LXRlc3QtY3J5cHRvLXBlcmYNCj4gDQo+IAlTaWduZWQtb2ZmLWJ5OiBLYWkgSmkgPGthaS5qaUBp
bnRlbC5jb20+IDxtYWlsdG86a2FpLmppQGludGVsLmNvbT4NCj4gCS0tLQ0KPiANCj4gQWNrZWQt
Ynk6IFJhZHUgTmljb2xhdSA8cmFkdS5uaWNvbGF1QGludGVsLmNvbT4NCkFwcGxpZWQgdG8gZHBk
ay1uZXh0LWNyeXB0bw0KDQo=
