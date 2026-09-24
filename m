Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFC4C98315
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 14:35:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A82C42FC5;
	Thu, 24 Sep 2026 16:35:21 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 02DE8400D7
 for <dev@dpdk.org>; Thu, 24 Sep 2026 16:35:19 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC7i1P2803043; Thu, 24 Sep 2026 07:35:19 -0700
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021092.outbound.protection.outlook.com [52.101.57.92])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gvkhhc8nf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 07:35:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydUmcjbBvpvHGmVzoiQcQexcanNNn0uyvdOlse+y0F7lcukPsEYWN7qIXVGljVpNegUtPgMp28DBVxB6sIkhCa+K8fx2oq6NG3CGFMqO3ux072JZjaw0wvl88c86fxrKJFtsP2xdFgJUzQ+/dZeK7jmbbQkInpeFnQ49Ohj4JhILKYqZABMToZLP9YpBV6NMC8wGQaGcBiGIrwi+L+rvYfGJCIkmzBFwrPov4M2j1y7RanGex/EcO3yqQbVUNGif4U5jqZVcE/ln0AhsEXLJn1nlU3n7gZWB5uGociayJXROimzJsnF70aS58AequApZMuIdoUL+Hm1UQyQLmobLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pTc2yaAylntjBEWPKkJxrVIUmfGEGwCweI+3pNdQa0=;
 b=ddDFRHmHhpRVV2+W9cBbUmcF4bwqsYKdntDmNYx7qoaRKHESfg0eeceLpD1kGyk3728tbHJKf5HUANQ0ZpoCPgI3MxtXOaST1Q3QbMs474xPPOusMkI/GD+JBx6PNw7PL8W16XT/UbiQ5xCn3hv+jld+75sfXTWweq60ho1CxWxgl9OAn4qKpCrkX6IXh6ML5oNvZ+pqqb+cQOmv/Sr9ou5vUmfvGn9NMJvWtb5hH0OP9rxbeUavyB5rWG/HrBdj8tE56KXRY+1Ob9fR8zxy3D1aLAWDfO828+e0cOu+RCL/DmPtbPMPYxuLB+alOqFh1JCZ2jGRxlmEBrw2FaZQXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pTc2yaAylntjBEWPKkJxrVIUmfGEGwCweI+3pNdQa0=;
 b=KpNOgrZmv9c/Mu8d9nDgYvOrPvprMkwl7AYMFBTzmvpgbWziigIyDBm10yixIlku0pgfm9dvPZfbjdAV8CHb9mT8U8z7l2ldmH5ieZk/Cma2A9vR1IiAkNVjayekvhWuSe35Zkv+KRVfJh3fKNaeM8vAEGkq8/3Q5sBU2HFlauw=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH0PR18MB5436.namprd18.prod.outlook.com (2603:10b6:610:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 14:35:15 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0428.015; Thu, 24 Sep 2026
 14:35:13 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Kai Ji <kai.ji@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>
Subject: RE: [EXTERNAL] [PATCH v7] examples: add Wycheproof validation app
Thread-Topic: [EXTERNAL] [PATCH v7] examples: add Wycheproof validation app
Thread-Index: AQHdS2zyS5RF8y84q0yzRR0X7h1hNrbdy+1A
Date: Thu, 24 Sep 2026 14:35:13 +0000
Message-ID: <CO6PR18MB44847C8EDAB63BA96FAA586ED8812@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260923105003.2811322-1-kai.ji@intel.com>
 <20260923150454.2831132-1-kai.ji@intel.com>
In-Reply-To: <20260923150454.2831132-1-kai.ji@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH0PR18MB5436:EE_
x-ms-office365-filtering-correlation-id: dd935c8f-99b5-4f88-c9eb-08df1a490b3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|4143699003|6133799003|10067099003|11063799006|56012099006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: qd7F2F7JJZTt7iexFAJr0SEGebyTmrGo8q8WbU7tk+QkkqmCxEJN2W2xnFtRFCFg+qntwhm3bGnsLaawR8iqLOcF2KlGoTWiZW3m1DXz+5zIH6qjbKtmdeMn04E9gOW803f5g1S44RcPATrW6qj6ZgbczsRD86oYzgrmBe4etINnVhLLv0IzRoW3xgFwlshT+cYPL9BE12DmITJ3bzFfWgSlyCOFsdY24tyAMomf7r5D2JZdXVBoL6julD60OjCPONRAXk95+4Nse0c8us1shcCJBnpdToKE4QaLnS5RjU7yanXWlSOkbN8FafXBaJbU93fpjQS8L98lnHPQImdCvztcCVPzqU9Mk9TM8GDGyHGEpvaLLVeHfa15QXmZqYfvPUEV7z9Lo6nchEknYRx1Pr3ruCROsT8by2CB5NVUr7XaECDUUrcBICz+hyArjefnYikJ4cESIU2XftnCoO4AL3kG0jMtwrsxWTb8s6FYuC/FapTMOIhykihLMJm56Vukur59LhvOVg6VGMUCk36vUZJG5gSpoSEHKuBYeH1LfGXeUIAPGhmWthUHFZSOuEjZ8SC7SLpNu3V09Zz1w0xOX5gSjjciqTBcvnjpsO4Y11P6WVEBWnm61fCEBlHukZqav7THSE0e6c45R24uaiqyvonfVUB/RSt7bfLxN5YswQRHbUfM7LOufXNGJgu3JX2Eu55P/yxsXV1UPmlD+LwKquvdd6bzt4TrtFt4oN1+BZg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(4143699003)(6133799003)(10067099003)(11063799006)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anE3aXY0dVlLN1ZGcEl0Y29nbVcwbDd4RXlrVHFVdGkrRWxCSkdCeTVUKzVC?=
 =?utf-8?B?QWxzUkpTa0xvN0JhR3o5L3hEVDM1cFRlV0lMOEpHVHlicHkzakNBOTNqUDRC?=
 =?utf-8?B?SUpZRU1ZNk54K1pRQ1V5TmtXeWNMZGRaU2VhQzNEWnMzOG9IMXMvZi9kUkpO?=
 =?utf-8?B?cVNjWithTU5laDhVR0FEZ1ZFbm96S3paL3kyVVI2WWh6YUVoVWR3czdvaDFw?=
 =?utf-8?B?dnM5Wk8rb0huNCsxYzhZb2tzYXlhTlREK3kxcDN2T01DbGpPWlR0RUE0TjlY?=
 =?utf-8?B?NDgvS2tGYVpOWS9GankxcVRTK2RxV3YrM210SFlrM0pjbXhkQnpaQ09rMlNs?=
 =?utf-8?B?RUxzVlR4aXVodjJ6enVjTzhtNjZwRzdpOUZndUM5WkovREZwMFlWdW9DMVo4?=
 =?utf-8?B?YnVFYWlEaGcwLzZ4VWxON0h5YTJWNWNyMEtyQVN5VitzUUhkaHNPREtZM1lm?=
 =?utf-8?B?YlZ2cGowSUNndGVJampYVk55VHJncnArSldBb3g5MmQrVHV3UHF2dGRxbVg4?=
 =?utf-8?B?elNKWUwwMzBSQWxLRS9md1RuT3FETGJXL3htWnJPYmQzUk9XSXJYdXdHYzBP?=
 =?utf-8?B?aTF4WDJLRXhIVkdtQWQrU2tuRDR5OUR3UXl4MXR0c21adG9oWDJLZ2J1a3Zn?=
 =?utf-8?B?dEMxdHRKNU5hREVqdEZVZkQzQmxJN2x5ZW81cGs5TG1aVzVUaUN1Y015RGlZ?=
 =?utf-8?B?eENJWmVxSHRIYXVyMWNDc1k0eFZ0SkJsakY1bnA0TFRHRGNWV2RoK1o2VFlh?=
 =?utf-8?B?d0x3dWs0MzhaaWJHczNTc3ZmT1crY1BlSVVmUldxaHBQNzZ4c2ZlRldlUGtI?=
 =?utf-8?B?bWR1KzNadVEwUEJpYVNxdUtYK3UwejhxMzlGcDRFaDlXcmpIMndZWlRKMkFP?=
 =?utf-8?B?Y3VoOEhkeFVVWUZ4M3Azc28wcTRWWGVGcVZaRzJpTlBRT1hIQTg0Nys2NExp?=
 =?utf-8?B?RWhiRllibC9GZXRRVU5lbUt0OWxZbXp3SC9hd1ViM0RRMDJCVmY1WkxZMU5E?=
 =?utf-8?B?Y2hGRXJwSUUwSUNsZGJQck5qUlBNNGFlemN3dkljNDhGeWdsSW5sVnBKdysy?=
 =?utf-8?B?KzFxZU5pdy9rS1JRNFAxK2E3Mk5nUGZQY2JkUXdFYmVLd1lQc2dXbGgrSm1M?=
 =?utf-8?B?UEhmaEw5Tm5LbXlNWjVsQWZORExBVWNxS2FrOUFtaTc0bmpwUEpzUlJQZFFy?=
 =?utf-8?B?SWpJdlFaemJ5WnN5bk0yVC9LMWd5RzVSdHFVYjNUSzUxdkFBNUVIcW5OaWpv?=
 =?utf-8?B?ZFM4WGh3WkMzZzk4NlRyUkZ4WTYyWXZXbTNtV1ZYZS8rU3ZPSmpJNGxWREFM?=
 =?utf-8?B?NE1QMDE0NExneStJWlVwZ05UajdBV0dDSWZjcFRjNVd1TEN2VlJvKzc0RWxn?=
 =?utf-8?B?K1pMdTlmdTBjSXdFWk5ENzJaK2J0Q0JrdUkwUUZqQ1hqS1lVRWQzcUVzUDhq?=
 =?utf-8?B?L3gxRm1XVXl6RFBEckcxMWpqdkpSZURpTEIyZnpwY21zUlA5YS9YZFRGdU1L?=
 =?utf-8?B?UHFMU29TV3ZhVWU4Mk56YkRPbytBVmVLVk9hUVJsaldkMDFWcXU2Ym5hdUVZ?=
 =?utf-8?B?VEpGYmRYOFdwSE1mVjVUSjhMZG1qUFZsN1JraUl1RXhLeVFMWkZVOEVISmFU?=
 =?utf-8?B?ekE5eG15VnNxSE1ESDhxRVFZSG5kT3NVY1VJS3FobnZFbDNlQkFVUWIweE43?=
 =?utf-8?B?eEFJRi9pTFFJU1hVcFJqcW9HVE5Ia2VKZmtDODdoSnl1QTM3RCsvcFl6d2cz?=
 =?utf-8?B?UzI0b1RNNzVSYTliZjJLMFBlQ1RKNzJxUG1yZmQ3K3ozU2dJWGMyWkx6Ym5m?=
 =?utf-8?B?N2RxeFhPMEtsWE4zYitPdmFhZ251OGtmMHRyQWxuVmx4ZmJuVDQrSG1oeGNa?=
 =?utf-8?B?ZWozekt3czluaTlZVWhUbDJtT2dDWWZVSkJxYnJaaVM3UWltTU9MWTN3K0FI?=
 =?utf-8?B?OVpqQ2dERld4djQrSFRpM3dCbmVDeE10ZkJuaTNKV05CT0hpZEJITVdlcGVp?=
 =?utf-8?B?bmdKOHpna0owdE5VSm1GdFhZcEFPSDhqT0VRZVJ3b3ovNXZkTUIzTEhLRlhF?=
 =?utf-8?B?MGlZQktuaGd0TUZnNFBUOHhPc0VGK1YvaXhBaDRQNWdTbUk0Z0t6ODFRT2JL?=
 =?utf-8?B?enUxZnFRbnJsdngxamRqQ1pmcHBkT0lCRFdxeHZtZzd3Qkppa1JyYzg5amI3?=
 =?utf-8?B?dm5kQTY1NDFDZDhabzZGdzFZeWRsU2gza1lWSjdJQ2lyL1AwSy9vblRaaEtn?=
 =?utf-8?B?SWEzRVhGYnFMTzY4TFRqMGlJKzNPTjZvZUNTUlFsc2dFVytDTzBmd2N0Y0lv?=
 =?utf-8?Q?hgEfoQD1LDnGMY4jhb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dqNFUdpOWf1x66hkB5+DGpiHcu1Z4f5ssWYwo1KOro0wLJtQcQcopR67sA5GYiAEm7JM7nezafn5CdBAo/Q3mbWo81PjOBSxcjEWrjMA3W4/CZG1/cl6WEgcRi0A+m6pAo22cjqk6xiBAf9tQz7B3/U14/pe9M1kmcFqiXl0cjwF2Y3CZ8IMzBAGvpjg049O6FIvhW9G5F0FOV799y2qJxuTrn35cXSumeSqiXgFSvlS70p7Suawczh927oLMqUNuAqVHdcf6Exr41hhq8fgmw4cugsNFv7dpO+Zx/09m2ZzmC3ECmSNd6nw96/G2SHaMhopz35OmOY1x3C7x/FkhA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd935c8f-99b5-4f88-c9eb-08df1a490b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 14:35:13.2835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OTVkGJh7Hm9ReiT/Oqc2lzBonR1mYtwOZMZrb8w6JYBdObR0KHvYAFcUXwgcr/OEn+L/Rh8WKMwL2PNwUfMbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB5436
X-Authority-Analysis: v=2.4 cv=ePyGH3p1 c=1 sm=1 tr=0 ts=6ab53526 cx=c_pps
 a=9avcgsFImRxvS4DvMwUk5A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=QyXUC8HyAAAA:8
 a=xbvQge8TzazM0ZzCFCoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Xrr0sMu2vWI3bJZ5KVX1suDgl4dDWue6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1OSBTYWx0ZWRfX4sCJyc/ywkUW
 vAaEK2GND2jaFN2fDin1BXu4fM4Zwl/iUUQ4z1tWFjflC2OBgqyBgN3/4LFxim9WxLVZZpr8S/a
 okFiypIYB6/gOI/4/Ril1bFBVtHCFWc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1OSBTYWx0ZWRfX5OdoAGvHLfXC
 1qaW8sMz1mxaWflLnGqA6iplVHSNemAgFIyWlJ8A4JvqP59d5T7SX0sUiqWVyZ1kYI8GkWlnhl6
 z5aBE5ku1Y3xpKxGpFTG0jmUzdh/BPc9MCzcjwQBMUW38L4VI9+53G4JQW5L/DfSbifZHP7MSHY
 5lHAHKlbgu2vqJl85ECKN7KS/Qceq2egjXyOk8jHg1sFNlE7yJ7XrQY4Sb8MmdFqo/BANLdwHc7
 0JHmKd081GbQwZLW47xfymGm7fxFOge2kShjyZ0iXfvGhZTyws4B46iVJUWCQBe/W3hWdkL9rwi
 UCinl36NkXegx2JoHeqUGbbj+9q6zXIiezxG7zxf9fD/GQAcyrpJbxuIkfLAepUt/Kg9sCLMBUX
 zrgJFCexipaeww0Xz4w9nLHTyWioYGNKcJVfWvzH9sOeRCJCa9VzHpgD6c5uboNJp88mSaJZL2c
 L89SsOySXkHaUeHCs2A==
X-Proofpoint-GUID: Xrr0sMu2vWI3bJZ5KVX1suDgl4dDWue6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
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

PiBBZGQgYSBXeWNoZXByb29mIEpTT04gdmVjdG9yIHZhbGlkYXRpb24gZXhhbXBsZSBmb3IgY3J5
cHRvZGV2IFBNRHMuDQo+IA0KPiBTdXBwb3J0IHRoZXNlIGFsZ29yaXRobXMgd2hlbiBhZHZlcnRp
c2VkIGJ5IHRoZSBzZWxlY3RlZCBQTUQ6DQo+IC0gQUVBRDogQUVTLUdDTSwgQUVTLUNDTSwgU000
LUdDTSwgQ2hhQ2hhMjAtUG9seTEzMDUNCj4gLSBNQUM6IEFFUy1DTUFDLCBBRVMtR01BQywgSE1B
QyBTSEEtMS9TSEEtMi9TSEEtMy9TTTMNCj4gLSBBc3ltbWV0cmljOiBEU0EgKFAxMzYzIHZlcmlm
eSksIEVDRFNBIChQMTM2MyB2ZXJpZnkpLA0KPiAgIEVDREggKGVjcG9pbnQgc2hhcmVkLXNlY3Jl
dCBjb21wdXRlKQ0KPiANCj4gVmFsaWRhdGUgdmFsaWQgdmVjdG9ycyBhZ2FpbnN0IGdlbmVyYXRl
ZCBjaXBoZXJ0ZXh0cywgdGFncywgcGxhaW50ZXh0cywNCj4gZGlnZXN0cywgc2hhcmVkIHNlY3Jl
dHMsIG9yIHNpZ25hdHVyZSB2ZXJpZmljYXRpb24sIGFuZCByZXF1aXJlIHRoZQ0KPiBleHBlY3Rl
ZCByZWplY3Rpb24gZm9yIGludmFsaWQgdmVjdG9ycy4gRGlnZXN0IGlucHV0cyBmb3IgRFNBIGFu
ZCBFQ0RTQQ0KPiB1c2UgdGhlIHN5bW1ldHJpYyBhdXRoIHBhdGgsIHNlbGVjdGluZyBhIHNlcGFy
YXRlIHN5bW1ldHJpYy1jYXBhYmxlDQo+IGRldmljZSB3aGVuIHRoZSB0YXJnZXQgZGV2aWNlIGlz
IGFzeW1tZXRyaWMtb25seS4NCj4gDQo+IFNraXAgcGFyYW1ldGVyIGNvbWJpbmF0aW9ucyBvdXRz
aWRlIFBNRCBjYXBhYmlsaXR5IHJhbmdlcyBhbmQgaWRlbnRpZnkNCj4gcmVjb2duaXplZCB2ZWN0
b3IgZmFtaWxpZXMgd2l0aG91dCBhIGNvbXBhdGlibGUgRFBESyB0cmFuc2Zvcm0uIEENCj4gLS1k
ZWJ1ZyBvcHRpb24gbGlzdHMgZXZlcnkgZmFpbGVkIG9yIHNraXBwZWQgdmVjdG9yLg0KPiANCj4g
QWRkIE1lc29uIGFuZCBzdGFuZGFsb25lIGJ1aWxkIGludGVncmF0aW9uLCB3aXRoIHVzYWdlIGRv
Y3VtZW50YXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLYWkgSmkgPGthaS5qaUBpbnRlbC5j
b20+DQo+IC0tLQ0KPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgNSArDQo+ICBkb2MvZ3VpZGVzL3JlbF9ub3Rlcy9yZWxlYXNlXzI2XzExLnJzdCAg
ICAgICAgfCAgICA2ICsNCj4gIGRvYy9ndWlkZXMvc2FtcGxlX2FwcF91Zy9pbmRleC5yc3QgICAg
ICAgICAgICB8ICAgIDEgKw0KPiAgLi4uL3NhbXBsZV9hcHBfdWcvd3ljaGVwcm9vZl92YWxpZGF0
aW9uLnJzdCAgIHwgICA1MCArDQo+ICBleGFtcGxlcy9tZXNvbi5idWlsZCAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICAxICsNCj4gIGV4YW1wbGVzL3d5Y2hlcHJvb2ZfdmFsaWRhdGlvbi9N
YWtlZmlsZSAgICAgICB8ICAgNDAgKw0KPiAgZXhhbXBsZXMvd3ljaGVwcm9vZl92YWxpZGF0aW9u
L21haW4uYyAgICAgICAgIHwgMjA5MCArKysrKysrKysrKysrKysrKw0KPiAgZXhhbXBsZXMvd3lj
aGVwcm9vZl92YWxpZGF0aW9uL21lc29uLmJ1aWxkICAgIHwgICAxNyArDQo+ICA4IGZpbGVzIGNo
YW5nZWQsIDIyMTAgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRvYy9ndWlk
ZXMvc2FtcGxlX2FwcF91Zy93eWNoZXByb29mX3ZhbGlkYXRpb24ucnN0DQo+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZXhhbXBsZXMvd3ljaGVwcm9vZl92YWxpZGF0aW9uL01ha2VmaWxlDQo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgZXhhbXBsZXMvd3ljaGVwcm9vZl92YWxpZGF0aW9uL21haW4uYw0KPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGV4YW1wbGVzL3d5Y2hlcHJvb2ZfdmFsaWRhdGlvbi9tZXNvbi5i
dWlsZA0KPiANCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5k
ZXggMTg2Y2M4MmIzOS4uNTgwZTJjMjU5MSAxMDA2NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4g
KysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTIwOTksMyArMjA5OSw4IEBAIEY6IGV4YW1wbGVzL3Zt
ZHEvDQo+ICBGOiBkb2MvZ3VpZGVzL3NhbXBsZV9hcHBfdWcvdm1kcV9mb3J3YXJkaW5nLnJzdA0K
PiAgRjogZXhhbXBsZXMvdm1kcV9kY2IvDQo+ICBGOiBkb2MvZ3VpZGVzL3NhbXBsZV9hcHBfdWcv
dm1kcV9kY2JfZm9yd2FyZGluZy5yc3QNCj4gKw0KPiArV3ljaGVwcm9vZiB2YWxpZGF0aW9uIGV4
YW1wbGUNCj4gK006IEthaSBKaSA8a2FpLmppQGludGVsLmNvbT4NCj4gK0Y6IGV4YW1wbGVzL3d5
Y2hlcHJvb2ZfdmFsaWRhdGlvbi8NCj4gK0Y6IGRvYy9ndWlkZXMvc2FtcGxlX2FwcF91Zy93eWNo
ZXByb29mX3ZhbGlkYXRpb24ucnN0DQo+IGRpZmYgLS1naXQgYS9kb2MvZ3VpZGVzL3JlbF9ub3Rl
cy9yZWxlYXNlXzI2XzExLnJzdA0KPiBiL2RvYy9ndWlkZXMvcmVsX25vdGVzL3JlbGVhc2VfMjZf
MTEucnN0DQo+IGluZGV4IGRlYzk2Y2NiYzcuLmNkMjcxMWRkYWQgMTAwNjQ0DQo+IC0tLSBhL2Rv
Yy9ndWlkZXMvcmVsX25vdGVzL3JlbGVhc2VfMjZfMTEucnN0DQo+ICsrKyBiL2RvYy9ndWlkZXMv
cmVsX25vdGVzL3JlbGVhc2VfMjZfMTEucnN0DQo+IEBAIC0xMzMsNiArMTMzLDEyIEBAIE5ldyBG
ZWF0dXJlcw0KPiAgICAgIHdpdGggcGVyLWRlc2NyaXB0b3IgbWJ1ZiBmcmVlIChgYHJ0ZV9wa3Rt
YnVmX2ZyZWVfc2VnYGApIGFuZCBwcmVmZXRjaCBoaW50cy4NCj4gICAgKiBDaGFuZ2VkIHRoZSBz
ZXQgb2YgcGVyLXF1ZXVlIHhzdGF0cyBjb3VudGVycy4NCj4gDQo+ICsqICoqQWRkZWQgV3ljaGVw
cm9vZiB2YWxpZGF0aW9uIGV4YW1wbGUgYXBwbGljYXRpb24uKioNCj4gKw0KPiArICBBZGRlZCBh
IG5ldyBleGFtcGxlIGFwcGxpY2F0aW9uIHRoYXQgdmFsaWRhdGVzIGEgRFBESyBjcnlwdG9kZXYg
UE1EIGFnYWluc3QNCj4gKyAgdGhlIEdvb2dsZSBXeWNoZXByb29mIEpTT04gdGVzdCB2ZWN0b3Jz
LCBjb3ZlcmluZyBBRUFELCBNQUMsIERTQSwgRUNESA0KPiBhbmQNCj4gKyAgRUNEU0EgYWxnb3Jp
dGhtIGZhbWlsaWVzLg0KPiArDQo+IA0KPiAgUmVtb3ZlZCBJdGVtcw0KPiAgLS0tLS0tLS0tLS0t
LQ0KPiBkaWZmIC0tZ2l0IGEvZG9jL2d1aWRlcy9zYW1wbGVfYXBwX3VnL2luZGV4LnJzdA0KPiBi
L2RvYy9ndWlkZXMvc2FtcGxlX2FwcF91Zy9pbmRleC5yc3QNCj4gaW5kZXggMjhjNGM5YTViMi4u
MjQ1OGIwNmNjZCAxMDA2NDQNCj4gLS0tIGEvZG9jL2d1aWRlcy9zYW1wbGVfYXBwX3VnL2luZGV4
LnJzdA0KPiArKysgYi9kb2MvZ3VpZGVzL3NhbXBsZV9hcHBfdWcvaW5kZXgucnN0DQo+IEBAIC01
MSw2ICs1MSw3IEBAIFNhbXBsZSBBcHBsaWNhdGlvbnMgVXNlciBHdWlkZXMNCj4gICAgICBwdHBj
bGllbnQNCj4gICAgICBwdHBfdGFwX3JlbGF5X3N3DQo+ICAgICAgZmlwc192YWxpZGF0aW9uDQo+
ICsgICAgd3ljaGVwcm9vZl92YWxpZGF0aW9uDQo+ICAgICAgaXBzZWNfc2VjZ3cNCj4gICAgICBi
YmRldl9hcHANCj4gICAgICBudGINCj4gZGlmZiAtLWdpdCBhL2RvYy9ndWlkZXMvc2FtcGxlX2Fw
cF91Zy93eWNoZXByb29mX3ZhbGlkYXRpb24ucnN0DQo+IGIvZG9jL2d1aWRlcy9zYW1wbGVfYXBw
X3VnL3d5Y2hlcHJvb2ZfdmFsaWRhdGlvbi5yc3QNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
aW5kZXggMDAwMDAwMDAwMC4uMTdjOGJkMmI1NQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2Rv
Yy9ndWlkZXMvc2FtcGxlX2FwcF91Zy93eWNoZXByb29mX3ZhbGlkYXRpb24ucnN0DQo+IEBAIC0w
LDAgKzEsNTAgQEANCj4gKy4uICBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogQlNELTMtQ2xhdXNl
DQo+ICsgICAgQ29weXJpZ2h0KGMpIDIwMjYgSW50ZWwgQ29ycG9yYXRpb24uDQo+ICsNCj4gK1d5
Y2hlcHJvb2YgVmFsaWRhdGlvbiBFeGFtcGxlDQo+ICs9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KPiArDQo+ICtPdmVydmlldw0KPiArLS0tLS0tLS0NCj4gKw0KPiArVGhpcyBleGFtcGxl
IHZhbGlkYXRlcyBhIERQREsgY3J5cHRvZGV2IGltcGxlbWVudGF0aW9uIGFnYWluc3QgdGhlIEdv
b2dsZQ0KPiArV3ljaGVwcm9vZiBKU09OIHRlc3QgdmVjdG9ycy4NCj4gKw0KPiArVGhlIGFwcGxp
Y2F0aW9uIHJlYWRzIG9uZSBKU09OIGZpbGUgb3IgYSBkaXJlY3Rvcnkgb2YgSlNPTiBmaWxlcyBh
dCBydW50aW1lIGFuZA0KPiArY2hlY2tzIHRoZSBzdXBwb3J0ZWQgYWxnb3JpdGhtIGZhbWlsaWVz
IGFnYWluc3QgdGhlIHNlbGVjdGVkIFBNRC4gSXQgY2FuIGJlDQo+IHVzZWQNCj4gK3dpdGggYSBQ
TUQgdGhhdCBhZHZlcnRpc2VzIEFFQUQsIE1BQywgRFNBLCBFQ0RILCBvciBFQ0RTQSBzdXBwb3J0
Lg0KPiArDQo+ICtCdWlsZA0KPiArLS0tLS0NCj4gKw0KPiArQnVpbGQgdGhlIGV4YW1wbGUgZnJv
bSB0aGUgRFBESyB0cmVlIHdpdGggTWVzb246DQo+ICsNCj4gKy4uIGNvZGUtYmxvY2s6OiBjb25z
b2xlDQo+ICsNCj4gKyAgIG1lc29uIHNldHVwIGJ1aWxkIC1EZXhhbXBsZXM9d3ljaGVwcm9vZl92
YWxpZGF0aW9uIC0NCj4gRGVuYWJsZV9kcml2ZXJzPWNyeXB0by9vcGVuc3NsDQo+ICsgICBtZXNv
biBjb21waWxlIC1DIGJ1aWxkDQo+ICsNCj4gK1N0YW5kYWxvbmUgTWFrZWZpbGUgYnVpbGRzIGFy
ZSBhbHNvIHN1cHBvcnRlZCBmcm9tIHRoZSBleGFtcGxlIGRpcmVjdG9yeS4NCj4gKw0KPiArUnVu
DQo+ICstLS0NCj4gKw0KPiArUnVuIHRoZSBleGFtcGxlIHdpdGggYW4gT3BlblNTTC1iYWNrZWQg
Y3J5cHRvZGV2IGFuZCBhIHZlY3RvciBmaWxlOg0KPiArDQo+ICsuLiBjb2RlLWJsb2NrOjogY29u
c29sZQ0KPiArDQo+ICsgICAuL2J1aWxkL2V4YW1wbGVzL2RwZGstd3ljaGVwcm9vZl92YWxpZGF0
aW9uIC0tdmRldiBjcnlwdG9fb3BlbnNzbCAtLSBcDQo+ICsgICAgICAgLS12ZWN0b3JzIC4uL3d5
Y2hlcHJvb2YvdGVzdHZlY3RvcnNfdjEvYWVzX2djbV90ZXN0Lmpzb24gXA0KPiArICAgICAgIC0t
Y3J5cHRvZGV2IGNyeXB0b19vcGVuc3NsIC0tZGVidWcNCj4gKw0KDQpXaHkgZG8gd2UgbmVlZCBh
IG5ldyBhcHBsaWNhdGlvbiB0byBwZXJmb3JtIHRlc3QgdmVjdG9yIHZhbGlkYXRpb24/DQpJcyBk
cGRrLXRlc3QgY3J5cHRvIHRlc3RzIG5vdCBlbm91Z2g/DQpDYW4gd2UgaW50ZWdyYXRlIHRoaXMg
aW4gdGhhdD8NCg0KQW5kIEkgZG8gbm90IHNlZSB0aGUgLmpzb24gZmlsZSBtZW50aW9uZWQgYWJv
dmUgaW4gdGhlIHBhdGNoLg0KVGhlcmUgc2hvdWxkIGJlIGEgc2FtcGxlIGZpbGUgYXRsZWFzdC4N
Cg0K
