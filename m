Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7148FCAC5B6
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 04:15:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37DD6402D8;
	Wed, 24 Sep 2025 06:15:03 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id AF5F54027C
 for <dev@dpdk.org>; Wed, 24 Sep 2025 06:15:01 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O0JUeR001811;
 Tue, 23 Sep 2025 21:15:00 -0700
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021119.outbound.protection.outlook.com [40.107.208.119])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 499ushyt38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 21:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYQvx5lY+WHRDWat/qwkgbLcahDBjAsc8XV8bMDNJlTO+Dfc0Vfagw8PNVuqzTEgix/KBeJgZnI8Hps/TknhpHzV0FdJRpzs5Ap5gNkaih3R/WFaONehPtDhJ6YjT8A7h6wM91/3FpKFEzbWzIrOjpo6zMnNYBbOwpJ9Sv+QgcYMk7mnezWYKlaNJ07HT+mhp+YVNGBkWfRKqvf3vNqJaWGkT0rUBRTfsWW47+C+1VKXzNa58HP6iQFjpECHkpfqpIZ3F64k/UNyrnWyDTn4jQHZKrKI2aa8BNyER7KXBTZzwmn2ZzDJ6I+ldCLeGY0/IDRTrRYk5EjUi9Zy6Qijiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vzp9h7hliEfiQteCEEwRG3BkNfEvLkR90jFGaVZQeYY=;
 b=Z/xU8pXp5rCdTl8gM5edX+xnjmie0AHN1KTk9GNvkTmg+RNbnMS9lDrlK1MpigWSgeAQlYx5BBkcOuAECbxo4jYSzySCiU19R1ezXwCZZUkTgyUjj8EJkUdBTdgzfE/NxdchwXhmyTtqFdCHHq0f4tcG4+J3JjLavcwQKe8eznr4/OX81CNxr+7DTBwODb+A1DMOxTq2N41w4NAvzXzXH+QAIphpwTrpToJ2PeOQm7fDN3iZ62Rv/MT3PYJX6r+JR6eaao7araP32+vWCJixUQAd9FguIlytM9DFP+/h0tLHp8RRFMGexWej1/fUi8iTxqXeELP6U5zq3Td9KQEymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzp9h7hliEfiQteCEEwRG3BkNfEvLkR90jFGaVZQeYY=;
 b=EAd01gh8JODXvRCm9WrqO+sLPxyTyXUNKEP72eL3mnuOivpuipa33lKwGGfPBtmf3EdneKV1SzVhQlCYTgJD9QVJrjq5PFoTECQ+r26GbVay3dQMp5Q24r0HzCkr+/9K4jViftFbFMWtgp6nQtPvH+yXXWzsx9dC0AOMB4d3GZU=
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f4b) by IA0PPFE0CDC467F.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::c48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Wed, 24 Sep
 2025 04:14:49 +0000
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b]) by SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b%5]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 04:14:49 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "vladimir.medvedkin@intel.com"
 <vladimir.medvedkin@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXTERNAL] Re: [RFC] lib/dma: introduce inter-process and
 inter-OS DMA
Thread-Topic: [EXTERNAL] Re: [RFC] lib/dma: introduce inter-process and
 inter-OS DMA
Thread-Index: AQHcGzy5YkOIwkQZ3keJnCVDiFvIxLSaUdWAgATUAxCAArb0kA==
Date: Wed, 24 Sep 2025 04:14:49 +0000
Message-ID: <SJ4PPFEA6F74CA2DDB3385FB29756363375A61CA@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20250901123341.2665186-1-vattunuru@marvell.com>
 <c366cdab-1538-4f70-8854-38f099b8990a@huawei.com>
 <SJ4PPFEA6F74CA2394BA7980AD7F285110BA612A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
In-Reply-To: <SJ4PPFEA6F74CA2394BA7980AD7F285110BA612A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPFEA6F74CA2:EE_|IA0PPFE0CDC467F:EE_
x-ms-office365-filtering-correlation-id: 3fd54f60-5ddd-4db9-4cec-08ddfb20e76f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZWVVTkQzczZUVlliRU5PUW1ZNUQ4RWFFTS9pUCsvTXJZMit5M29NRWlHYUdy?=
 =?utf-8?B?V3d6cUE3ZG4zeFd5azlNT3h2MGRpazVadmlxNktwZ1MwbEMyMStIYk9iMzZS?=
 =?utf-8?B?MzQ4cm1yRmNCeERNeklhTk9pbFN5UkJPejhlYnJIb2RzckFaaDEvb3hIWUU1?=
 =?utf-8?B?WEJZQU5HOUNxOTdqeHNlSGJDeHp4K2NPTTlvd0FQbVpkcW1zd1BxNTg5ZHVP?=
 =?utf-8?B?dkNqYWtaV3BKZ2YwUFhSd1daYktvV2NkOGV3VExMZ20wREQ4ZVFNaUNlR3ZL?=
 =?utf-8?B?QnQ3K3M2WFQwSDI3YlRwK2tuTmtlSkVEWWdNa1BaLzlYOXU2dzJQa0hsWlBK?=
 =?utf-8?B?ZDZSK2FxeDlVVWJ3N2Z5OHNvNmVsMGlvMVlodVRrSTd2bHc4SS90VEtFWjVD?=
 =?utf-8?B?aFZsdFJ6NndiaFdSL1FEeGNnSDRnRGlxelVCK3RrQ0VJS3R6UlFXWjlHaTJh?=
 =?utf-8?B?bkovNFpIOGd6UThDbk1DdXVvTEdnRklnMENoMlFSdHBsRWZCWThQSzFYU3J1?=
 =?utf-8?B?dllkZ2ZCR1JGdmpWZ0pEamFqYWxucjdWTjY5Vyt4WTlITEJoelZRVmlKOFls?=
 =?utf-8?B?Y0VGOG94Q29VcEQ1U0IyaTJ3R0dZOXNwVXU5eDZyYTUxSUJJSkdaYm1TYW5u?=
 =?utf-8?B?ZkZCUG9pQWR5TXk1cVZMVDVXOHAwQ216S0tCaTdWNjFrS0FzYkw1dlpOMkN2?=
 =?utf-8?B?MVdLS3lrMFhFejlRT0MwdVh0NEkvaHVMK0ZHaitBODNHVWhJcXMrR1hQRDBp?=
 =?utf-8?B?ZkY4Z251Ym5Ta3NRZTc4K0xFTUJiQlFxaDQyZUEvaTAwdUxMY295SzBQZ0cv?=
 =?utf-8?B?cHVldWJld3B0ZlFKTzhJMFpIZC9lMFhKZnhRV3JkMlRwWWdtdzFlUlZXaXdG?=
 =?utf-8?B?T0VvMnVQWENacnpSSHFGTU4zQVV0VGhvNGhDTndNNWRkS1JrT3paSWxCcFlr?=
 =?utf-8?B?MmpEUndaTnhYWStFQndEQitocm9HUzBMZjNuclcvYS9CK0ZXanFDUk96bFJM?=
 =?utf-8?B?dERNYlQ5QU9kT3dCeUFZcm9veXNQaGltSTFPV0syY3daSnM0QlVCeEI1WWo5?=
 =?utf-8?B?a0pLT2Zpd1h3KytGSjNmbUNYRXV2TWJiK3Ewamo1akhxL2dYajRHY0xkRWJq?=
 =?utf-8?B?Q0dnZ3kvWG1xOEo2K29uK25uSGRPeDM0UHY5NWwyRWJQOE9xQ1pPQlk3NGJh?=
 =?utf-8?B?aE1zWVJiQVJQUTRqVTMyeTY3bG56QUJSb1ZnVkdvN05PRDBtQ2ppSXIyRzEr?=
 =?utf-8?B?OERhS3RBWVlXYkd0SXVHdTNDZ3ZJVjZ5eHU4dFN0YkNaVThxRFlLQkV3MUE3?=
 =?utf-8?B?ZmJ2V0UveFNnL05zbFpDUktNVEE1eTEwWGFZNDJFNU5DWVEyWEl0N2dkTEJZ?=
 =?utf-8?B?VEhaNVJKQ0RZaWlLV05XMDd6QWRJeVV5cjJNQzdJLzJkVGFvWXhIKzk0OUEz?=
 =?utf-8?B?dWUycFp0V3dpalZ6bHZwd3h1SC9FRm5iOEdmZVh6QzRpYmxKQWNzU1YyUEtN?=
 =?utf-8?B?N2cxUFdUc1AwVmdaZ0szc2NhQjdwMGpTUHE3ejc4M0xzcXNOY1dyM2lWZEp6?=
 =?utf-8?B?ZEkycXM0TXV5eExkQUd1aTdhOUx5TEdlWk9hQm1Qb0lrWW1SZ0gwckhIck9t?=
 =?utf-8?B?a3VNV3h3V09pVWlUcjFnOGNSZUdLWThBc1JrTGxUY1NXVzVJUmVqeHFwNnFO?=
 =?utf-8?B?ODVweEVKMjBOWnJCcnhNN3pmdFkrZHNLak1UNEZrb0Nlam4rT3FkT0hKcUJC?=
 =?utf-8?B?TlJSQnpySmRVWUNkUG1kZmh2bFphdW9hUU5DQy9EcEl4ZUhWUjlROHlSRHRr?=
 =?utf-8?B?N05FNVhJdU8xTGd2Q3hUVU5lV0ZFaHdXVkM4MU5zNmpmc3FrZEd0Q1pSVXFO?=
 =?utf-8?B?Q2hCTXl2b0EzaDdidktjVHM2cmowdHVzYi9WSTgyTGtreHJVM2hiNnhuOEht?=
 =?utf-8?Q?1HLCJQK0VhV8ocGl0B97DJGmmZbzJJOZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPFEA6F74CA2.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTFqeEhTMmhqSkFQVFdsa28vMm9vZFdQUUFyMzhNQlRZNnlLK1hLRnYwSjhL?=
 =?utf-8?B?TXQ2YyttV0RUVDF5dlNuTU1MT2FLNVZNLzFnMXRxek45UVBJVlZOUVVUbW1x?=
 =?utf-8?B?RUd5UmsrSmlhU1Q0a0xmZ1ByTHFMWWVlS01LZE5tVCtWcUZ2d3RweFdpUk1L?=
 =?utf-8?B?T1UzaEhVNTlBZTJiN3dJY1FFeCtIRHJFbHFyV0dSQ0lWdjRRZ3BWbVJOTFZr?=
 =?utf-8?B?RStaVEVPUmtiWG51V2dYZFA3NDdaRlA1WkVTaEtJVW1kNm9ES21RVlJoYmpr?=
 =?utf-8?B?d2RtYjBNV1FZT1RQaEdMSDkvWHlaeVcwWjlGV0ZtN3lTM3RzSjNRbGNCNHVQ?=
 =?utf-8?B?Z0ovdDU5VlIzaEtxQnAyNWdneW9BUkVkbnh0Z2lHOFg3cGZSay9XcmhRRmhi?=
 =?utf-8?B?eVhxaXQ1RFhjNnB2b091MmQ1TVBKRDRzc0FwallwdUtNaUVjWTB5OGROQnIx?=
 =?utf-8?B?TTkrdThsMkxaeEhBZmJLZmRTUDlRMXJrMG5La3l2cGVEWi9rOFdzZXhvd3FQ?=
 =?utf-8?B?U2ZZNU5qdlBWamtyaU1HUU9JMVpFSlNVc092czNEVnFYcEd5TFZqY2xHdzRo?=
 =?utf-8?B?eVBQVGtWdTBMRUttZWJmZXBoOVNtMTEvUUJPNEh6VFJnVEVPNTdVeGRtdUx1?=
 =?utf-8?B?elhrSXJNdzJuSmdya0lXMk95TzNwUFRWNUVad3lYT1Jhak1TR1RHcldNcWJo?=
 =?utf-8?B?VnZWOSs3N0lxc256aXNBZStrczN6d0ZEZjVrcldEL2FqUUw2cFpKRTFxT3JX?=
 =?utf-8?B?T0FkVFRQcG5pTFE4c09ZZVNqazJORG0zVGRUTUhRbnhBbjdGV1ZHNldYV3Ir?=
 =?utf-8?B?QUYrWHlWWVIrRVBQa0FFeURHNWVBQkd0UVBkRkRaVXBxUk5iYmNTRWNrM3JQ?=
 =?utf-8?B?aHZXb1dFUE8wcCtGaW8va243WUlVUjBRN2h5eXJWMG9ZSjdvQVVmSGJxZGp5?=
 =?utf-8?B?Ri9EZlJ3TThGcGNMQ0tQYjR3ZHVCSWNYV1l6QURENnpEQ3h2dXRuTkFTc2NP?=
 =?utf-8?B?TEh4Mk1CQkFuc0tKNzFlQ0RXempBVjFKSlM2UFNrZzhmTTVsLzF4ZW5wbWZl?=
 =?utf-8?B?ZDYySFdGcGRWWVQ2bG9LUzZBTlIzVVNYUGZSZFVsY0o5OUJzQzdzY3lvQVJH?=
 =?utf-8?B?ZDM3cWN4NEdHZ3g1Wm54T09Mc1BHWlBQbk1hNmwzUTRqY2htNFEwdWMvb0wy?=
 =?utf-8?B?OXdDUWs1ZGpvaDF0QmppZmVzN09kcnN4bHU3U3A0NXZXaytqNVYydUVFSFhT?=
 =?utf-8?B?VWFXbTZ2LzVWd3lXSDdaaC9vVHVuNFA1V1RZdTZncFZQVk4wUDZtTHY5MGVO?=
 =?utf-8?B?Umk3RWZ1QmtJZ00vdWJaSDF1bWxTNFdlL2Rkdjhic01YSWJXdk1iQ1ArenNV?=
 =?utf-8?B?a0ovaUhNc3cwYUQ4azYwOFNGYUhHQ3JkdkJlNklnVkhIWkdnTEpabkFFYWIw?=
 =?utf-8?B?eEpoTVgxQTU1R0d4VlJWTDQ3RkpNaGgydk5zQWpMdGNTaVNpczVjUTNKVVJv?=
 =?utf-8?B?bGhBOFVkRUk4NGUvOHlveFBGRlJaVXlmNkhBZ3NDRE9KUU5COE16VzNoMkMx?=
 =?utf-8?B?UXFwSFBIQThGMmJBVEE0MEpvRGUzYXhlSHMyaHJpNG9pc3NpN0oyOWpLTWZ3?=
 =?utf-8?B?bU9sRUVEeks0VVZ4NWFvMWdkZTZOZjl1TVo4dDhTbG4wV09uemt6NlR3aFZO?=
 =?utf-8?B?bk02a0xFRVVzYXErUFRHUFF2QmYrS1oxdGswNjBiaVgva0lDb1pqbm5NbVNM?=
 =?utf-8?B?Vy90VXFSNERLakZta1J0Qm9PdTZoaS82UEhJOXhtc1FLdURQMzBRa3pjOXZv?=
 =?utf-8?B?M0Y4M00vd2dlMGRWNFVFQmtTUXVGTUl3ejZRTEtBUmg0NVJuS0pXN0lzeENM?=
 =?utf-8?B?RGpydHcyWGhZRVNpZHlJa3hvNTBndTM4ejdPOUdxRmdERTFTTGRpTXFxY0dQ?=
 =?utf-8?B?bExmcnYrZ2F5YW80NDlRMjdBOGNxRS9aeDdhWHEyY0N4dDA4RDk4TVVnSmts?=
 =?utf-8?B?RzVDWjFsSEFDNnlmT3o5SnJrYThRVnIxc015ajZZWWE0UWMyb0ZMOVVqYnZI?=
 =?utf-8?B?OTMrQWt6UlprSWJpclV3U3dlZDJ0WElkb09kYmhpM0ZrYnJtcG9PT0lVZHln?=
 =?utf-8?Q?fqmLGpwA6ZmC9CXQc1BNCrsg6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd54f60-5ddd-4db9-4cec-08ddfb20e76f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 04:14:49.6623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAfN22e1Bz19rM7opRv22SOm7Q6mBfYRs1mtP4wOmQ2O2OQr04NwTMDKH0KKfjfu13NKNQwHPhVga8e9heOpHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFE0CDC467F
X-Proofpoint-GUID: pqzi-8OqD1Pzj3km7jwHTPuFGfUHyc4H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDExNCBTYWx0ZWRfX8s8PtbNMofQd
 NnnSv9ALYta6f7YY7AdnV5NTavwZTS/gxRKCblX/gavid8wBNQKp8IHXqyOBft+DhvL83tv6fBh
 ES3yyyECO6aU3At2iXG3ytj2ftVjfd5WkYx/4whYtzR6lWYiDunSCHKkBj8s/pZBowyd/Tz8Ew9
 p/k92xKZXiigrNX4VkoFgHC4uhpV6uv/0iKW/V3m8NnrzowzIVY9OPEKl227falIlLuJveNY+Ba
 +m5bPeZpKqH7cEcrvwByayKAH0ChK9utPjzRyb8K7mVWLoWYk9grUbae+PJGoL8eOdSGcyYEb3+
 ocPWgUBPoKb/oj0vPjT3BRLZWR6Gb3ffGo/I4ytOj/7oKKz9cnWz2B1zQBeJit8RWv9R62VLCqe
 XpeZ0a52
X-Authority-Analysis: v=2.4 cv=auayCTZV c=1 sm=1 tr=0 ts=68d37044 cx=c_pps
 a=Dn5GTbaAjVxhKizcS6VC0A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=RpNjiQI2AAAA:8 a=i0EeH86SAAAA:8 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8
 a=bt5KbKNvAAAA:8 a=M5GUcnROAAAA:8 a=oTdxbUd3dCuV9SNMQPwA:9 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22
 a=a-zEBD5cKgE7DNtTSb7C:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: pqzi-8OqD1Pzj3km7jwHTPuFGfUHyc4H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_08,2025-09-22_05,2025-03-28_01
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

SGkgRmVuZywgQW5hdG9seSwNCg0KR2VudGxlIHBpbmcgZm9yIGJlbG93IHJldmlldy4NCg0KPi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogVmFtc2kgS3Jpc2huYSBBdHR1bnVydQ0K
PlNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDIyLCAyMDI1IDU6MTkgUE0NCj5UbzogZmVuZ2NoZW5n
d2VuIDxmZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbT47IGRldkBkcGRrLm9yZzsNCj5hbmF0b2x5LmJ1
cmFrb3ZAaW50ZWwuY29tDQo+Q2M6IHRob21hc0Btb25qYWxvbi5uZXQ7IGJydWNlLnJpY2hhcmRz
b25AaW50ZWwuY29tOw0KPnZsYWRpbWlyLm1lZHZlZGtpbkBpbnRlbC5jb207IGFuYXRvbHkuYnVy
YWtvdkBpbnRlbC5jb207DQo+a2V2aW4ubGFhdHpAaW50ZWwuY29tOyBKZXJpbiBKYWNvYiA8amVy
aW5qQG1hcnZlbGwuY29tPg0KPlN1YmplY3Q6IFJFOiBbRVhURVJOQUxdIFJlOiBbUkZDXSBsaWIv
ZG1hOiBpbnRyb2R1Y2UgaW50ZXItcHJvY2VzcyBhbmQgaW50ZXItDQo+T1MgRE1BDQo+DQo+SGkg
RmVuZywNCj4NCj4+SGkgVmFtc2ksIFRoaXMgY29tbWl0IGNoYW5nZSBpcyBtb3JlIHRoYW4gZGlz
Y3Vzc2VkLCBpdCBhZGQgY29udHJvbCBBUEkNCj4+d2hpY2ggZm9yIGdyb3VwIG1hbmFnZW1lbnQu
IDEuIENvbnRyb2wgQVBJOiBJIGNoZWNrIHRoaXMgY29tbWl0IGFuZA0KPj5JbnRlbCBjb21taXQg
WzFdLCBpdCBzZWVtIGhhcyBhIHF1aXRlIGRpZmZlcmVuY2UuIEkgaG9wZSBJbnRlbCBndXlzIGNh
bg0KPj5leHByZXNzIHZpZXdzLiBJIHByZWZlciBub3QgYWRkIFpqUWNtUVJZRnBmcHRCYW5uZXJT
dGFydCBQcmlvcml0aXplDQo+PnNlY3VyaXR5IGZvciBleHRlcm5hbA0KPj5lbWFpbHM6DQo+PkNv
bmZpcm0gc2VuZGVyIGFuZCBjb250ZW50IHNhZmV0eSBiZWZvcmUgY2xpY2tpbmcgbGlua3Mgb3Ig
b3BlbmluZw0KPj5hdHRhY2htZW50cyA8aHR0cHM6Ly91cy1waGlzaGFsYXJtLQ0KPj5ld3QucHJv
b2Zwb2ludC5jb20vRVdUL3YxL0NSVm1Ya3FXIXRnM1Q5Wi0NCj4+VWFCOVEza3djbVgwN2JRaHc3
OXRWNm1sd2xyT2I5bjN2SWFqRmp4SjVzUkMtDQo+Pk56N240aXJnWTdUZEh5Ujl5RmRxSkxzRGhR
ZEVOLUtmM1Q0TnBrRnZSVng4X1RFJD4NCj4+UmVwb3J0IFN1c3BpY2lvdXMNCj4+DQo+PlpqUWNt
UVJZRnBmcHRCYW5uZXJFbmQNCj4+SGkgVmFtc2ksDQo+Pg0KPj5UaGlzIGNvbW1pdCBjaGFuZ2Ug
aXMgbW9yZSB0aGFuIGRpc2N1c3NlZCwgaXQgYWRkIGNvbnRyb2wgQVBJIHdoaWNoIGZvcg0KPj5n
cm91cCBtYW5hZ2VtZW50Lg0KPj4NCj4+MS4gQ29udHJvbCBBUEk6IEkgY2hlY2sgdGhpcyBjb21t
aXQgYW5kIEludGVsIGNvbW1pdCBbMV0sIGl0IHNlZW0gaGFzIGENCj4+cXVpdGUgZGlmZmVyZW5j
ZS4NCj4+ICAgSSBob3BlIEludGVsIGd1eXMgY2FuIGV4cHJlc3Mgdmlld3MuIEkgcHJlZmVyIG5v
dCBhZGQgdGhpcyBwYXJ0IGlmIG5vDQo+cmVzcG9uc2UuDQo+DQo+VGhpcyBuZXcgZmVhdHVyZSBu
ZWVkcyB0byBiZSBzZWN1cmVseSBtYW5hZ2VkIHRocm91Z2ggY29udHJvbCBBUElzLiBJdA0KPndv
dWxkIGJlIGV4dHJlbWVseSBoZWxwZnVsIGlmIHRoZSBmb2xrcyBhdCBJbnRlbCBhbmQgeW91IGFz
IHdlbGwgY291bGQgcHJvdmlkZQ0KPnN1cHBvcnQgb3IgaW5wdXRzIG9uIHRoaXMuDQo+DQo+Pg0K
Pj4yLiBEYXRhIEFQSTogdGhpcyBjb21taXQgcHJvdmlkZSB0d28gd2F5ICh2Y2hhbiBhbmQgZmxh
Z3MpIHRvIHVzZSB0aGlzDQo+PmZlYXR1cmUsIEknZCByYXRoZXINCj4+ICAgc3RpY2sgdG8gb25l
LCB0aGF0IHdheSwgc28gdGhlIGFwcCB3b24ndCBnbyBoYXl3aXJlLg0KPj4NCj4+ICAgVGhlIHZj
aGFuIHNjaGVtZSBzZWVtcyBpbmZsZXhpYmxlLiBJZiB5b3Ugd2FudCB0byB1cGRhdGUNCj4+Y29t
bXVuaWNhdGlvbiBvYmplY3RzIGZyZXF1ZW50bHkNCj4+ICAgZHVyaW5nIG9wZXJhdGlvbiwgdGhl
IHZjaGFuIG5lZWRzIHRvIGJlIHJlY3JlYXRlZC4NCj4NCj5UaGUgdmNoYW4gbWVjaGFuaXNtIGV4
dGVuZHMgc3VwcG9ydCBmb3IgYW55IFBNRCB0aGF0IG1heSByZXF1aXJlIGFueQ0KPm90aGVyIGFk
ZGl0aW9uYWwgbWV0YWRhdGEgKHBhc2lkLCBzdHJlYW1JRCBldGMpIC0tc3BlY2lmaWMgdG8gY2Vy
dGFpbg0KPmFyY2hpdGVjdHVyZXMuIEhvd2V2ZXIsIHRoZSBmbGFncyBmaWVsZCB0byBiZSBmdWxs
eSB1dGlsaXplZCwgYW5kIG1heSBub3QNCj5hY2NvbW1vZGF0ZSBmdXJ0aGVyIGV4dGVuc2lvbnMg
aWYgdmNoYW4gbmVlZHMgdG8gY2FycnkgbW9yZSBpbmZvcm1hdGlvbi4NCj4NCj4+DQo+PiAgIEkg
cHJlZmVyIHJlc2VydmVkIDE2Yml0IGZyb20gZmxhZ3MgKG5vdCAzMmJpdCBiZWNhdXNlIGl0IHNl
ZW0gaGFzIG5vDQo+PnN1Y2ggcmVxdWlyZW1lbnQpLg0KPg0KPjE2Yml0cyBmb3IgYm90aCBoYW5k
bGVzIG1heSBiZSB0b28gbGltaXRpbmcgLCBlc3BlY2lhbGx5IGlmIFBNRCByZXF1aXJlcyBhIGxh
cmdlcg0KPmlkZW50aWZpZXIgaW4gdGhlIGZ1dHVyZS4NCj4+DQo+PlsxXSBodHRwczovL3VybGRl
ZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtDQo+PjNBX19tYWlscy5kcGRrLm9y
Z19hcmNoaXZlc19kZXZfMjAyMy0NCj4+MkRBdWd1c3RfMjc0NTkwLmh0bWwmZD1Ed0lDYVEmYz1u
S2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9V2xsclkNCj5hDQo+PnVtVmt4YVdqZ0t0bzZFX3J0RFFz
aGhJaGlrMmprdnpGeVJoVzgmbT1sdUNoUUlGYjRtaHA0NldEdVBzVC0NCj4+bFd0bDZQV2kzLTll
VUVUTkIzUUtOUDd4cEtCNlhXSG16RWp4MlNBLQ0KPj5vWGkmcz14MmJmZXRyeXV4OGJEcldwRzJL
bkI5RGY0YWJDQVFuU1V5MkNFcFVURHRBJmU9DQo+Pg0KPj5UaGFua3MNCj4+DQo+Pk9uIDkvMS8y
MDI1IDg6MzMgUE0sIFZhbXNpIEtyaXNobmEgd3JvdGU6DQo+Pj4gRnJvbTogVmFtc2kgQXR0dW51
cnUgPHZhdHR1bnVydUBtYXJ2ZWxsLmNvbT4NCj4+Pg0KPj4+IE1vZGVybiBETUEgaGFyZHdhcmUg
c3VwcG9ydHMgZGF0YSB0cmFuc2ZlcnMgYmV0d2VlbiBtdWx0aXBsZSBETUENCj4+PiBkZXZpY2Vz
LCBmYWNpbGl0YXRpbmcgZGF0YSBjb21tdW5pY2F0aW9uIGFjcm9zcyBpc29sYXRlZCBkb21haW5z
LA0KPj4+IGNvbnRhaW5lcnMsIG9yIG9wZXJhdGluZyBzeXN0ZW1zLiBUaGVzZSBETUEgdHJhbnNm
ZXJzIGZ1bmN0aW9uIGFzDQo+Pj4gc3RhbmRhcmQgbWVtb3J5LXRvLW1lbW9yeSBvcGVyYXRpb25z
LCBidXQgd2l0aCBzb3VyY2Ugb3IgZGVzdGluYXRpb24NCj4+PiBhZGRyZXNzZXMgcmVzaWRpbmcg
aW4gZGlmZmVyZW50IHByb2Nlc3Mgb3IgT1MgYWRkcmVzcyBzcGFjZS4gVGhlDQo+Pj4gZXhjaGFu
Z2Ugb2YgdGhlc2UgYWRkcmVzc2VzIGJldHdlZW4gcHJvY2Vzc2VzIGlzIGhhbmRsZWQgdGhyb3Vn
aA0KPj4+IHByaXZhdGUgZHJpdmVyIG1lY2hhbmlzbSwgd2hpY2ggYXJlIGJleW9uZCB0aGUgc2Nv
cGUgb2YgdGhpcw0KPj4+IHNwZWNpZmljYXRpb24gY2hhbmdlLg0KPj4+DQo+Pj4gVGhpcyBjb21t
aXQgaW50cm9kdWNlcyBuZXcgY2FwYWJpbGl0eSBmbGFncyB0byBhZHZlcnRpc2UgZHJpdmVyDQo+
Pj4gc3VwcG9ydCBmb3IgaW50ZXItcHJvY2VzcyBvciBpbnRlci1PUyBETUEgdHJhbnNmZXJzLiBJ
dCBwcm92aWRlcyB0d28NCj4+PiBtZWNoYW5pc21zIGZvciBzcGVjaWZ5aW5nIHNvdXJjZSBhbmQg
ZGVzdGluYXRpb24gaGFuZGxlcnM6IGVpdGhlcg0KPj4+IHRocm91Z2ggdGhlIHZjaGFuIGNvbmZp
Z3VyYXRpb24gb3IgdmlhIHRoZSBmbGFncyBwYXJhbWV0ZXIgaW4gRE1BDQo+Pj4gZW5xdWV1ZSBB
UElzLiBUaGlzIGNvbW1pdCBhbHNvIGFkZHMgYSBjb250cm9sbGVyIElEIGZpZWxkIHRvIHNwZWNp
ZnkNCj4+PiB0aGUgZGV2aWNlIGhpZXJhcmNoeSBkZXRhaWxzIHdoZW4gYXBwbGljYWJsZS4NCj4+
Pg0KPj4+IFRvIGVuc3VyZSBzZWN1cmUgYW5kIGNvbnRyb2xsZWQgRE1BIHRyYW5zZmVycywgdGhp
cyBjb21taXQgYWRkcyBhIHNldA0KPj4+IG9mIEFQSXMgZm9yIGNyZWF0aW5nIGFuZCBtYW5hZ2lu
ZyBhY2Nlc3MgZ3JvdXBzLiBEZXZpY2VzIGNhbiBjcmVhdGUNCj4+PiBvciBqb2luIGFuIGFjY2Vz
cyBncm91cCB1c2luZyB0b2tlbi1iYXNlZCBhdXRoZW50aWNhdGlvbiwgYW5kIG9ubHkNCj4+PiBk
ZXZpY2VzIHdpdGhpbiB0aGUgc2FtZSBncm91cCBhcmUgcGVybWl0dGVkIHRvIHBlcmZvcm0gRE1B
IHRyYW5zZmVycw0KPj4+IGFjcm9zcyBwcm9jZXNzZXMgb3IgT1MgZG9tYWlucy4gVGhpcyBhcHBy
b2FjaCBlbmhhbmNlcyBzZWN1cml0eSBhbmQNCj4+PiBmbGV4aWJpbGl0eSBmb3IgYWR2YW5jZWQg
RE1BIHVzZSBjYXNlcyBpbiBtdWx0aS10ZW5hbnQgb3IgdmlydHVhbGl6ZWQNCj4+ZW52aXJvbm1l
bnRzLg0KPj4+DQo+Pj4gVGhlIGZvbGxvd2luZyBmbG93IGRlbW9uc3RyYXRlcyBob3cgdHdvIHBy
b2Nlc3NlcyAoYSBncm91cCBjcmVhdG9yDQo+Pj4gYW5kIGEgZ3JvdXAgam9pbmVyKSB1c2UgdGhl
IERNQSBhY2Nlc3MgZ3JvdXAgQVBJcyB0byBzZWN1cmVseSBzZXQgdXANCj4+PiBhbmQgbWFuYWdl
IGludGVyLXByb2Nlc3MgRE1BIHRyYW5zZmVyczoNCj4+Pg0KPj4+IDEpIFByb2Nlc3MgMSAoR3Jv
dXAgQ3JlYXRvcik6DQo+Pj4gICAgQ2FsbHMgcnRlX2RtYV9hY2Nlc3NfZ3JvdXBfY3JlYXRlKGdy
b3VwX3Rva2VuLCAmZ3JvdXBfaWQpIHRvIGNyZWF0ZQ0KPmENCj4+PiAgICBuZXcgYWNjZXNzIGdy
b3VwLg0KPj4+ICAgIFNoYXJlcyBncm91cF9pZCBhbmQgZ3JvdXBfdG9rZW4gd2l0aCBQcm9jZXNz
IDIgdmlhIElQQy4NCj4+PiAyKSBQcm9jZXNzIDIgKEdyb3VwIEpvaW5lcik6DQo+Pj4gICAgUmVj
ZWl2ZXMgZ3JvdXBfaWQgYW5kIGdyb3VwX3Rva2VuIGZyb20gUHJvY2VzcyAxLg0KPj4+ICAgIENh
bGxzIHJ0ZV9kbWFfYWNjZXNzX2dyb3VwX2pvaW4oZ3JvdXBfaWQsIGdyb3VwX3Rva2VuKSB0byBq
b2luIHRoZQ0KPj4+ICAgIGdyb3VwLg0KPj4+IDMpIEJvdGggUHJvY2Vzc2VzOg0KPj4+ICAgIFVz
ZSBydGVfZG1hX2FjY2Vzc19ncm91cF9zaXplX2dldCgpIHRvIGNoZWNrIHRoZSBudW1iZXIgb2Yg
ZGV2aWNlcw0KPmluDQo+Pj4gICAgdGhlIGdyb3VwLg0KPj4+ICAgIFVzZSBydGVfZG1hX2FjY2Vz
c19ncm91cF9nZXQoKSB0byByZXRyaWV2ZSB0aGUgZ3JvdXAgdGFibGUgYW5kDQo+Pj4gICAgaGFu
ZGxlciBpbmZvcm1hdGlvbi4NCj4+Pg0KPj4+ICAgIFBlcmZvcm0gRE1BIHRyYW5zZmVycyBhcyBu
ZWVkZWQuDQo+Pj4NCj4+PiA0KSBQcm9jZXNzIDIgKHdoZW4gZG9uZSk6DQo+Pj4gICAgQ2FsbHMg
cnRlX2RtYV9hY2Nlc3NfZ3JvdXBfbGVhdmUoZ3JvdXBfaWQpIHRvIGxlYXZlIHRoZSBncm91cC4N
Cj4+PiA1KSBQcm9jZXNzIDE6DQo+Pj4gICAgUmVjZWl2ZXMgUlRFX0RNQV9FVkVOVF9BQ0NFU1Nf
VEFCTEVfVVBEQVRFIHRvIGJlIG5vdGlmaWVkIG9mDQo+Pmdyb3VwDQo+Pj4gICAgY2hhbmdlcy4N
Cj4+PiAgICBVc2VzIHJ0ZV9kbWFfYWNjZXNzX2dyb3VwX3NpemVfZ2V0KCkgdG8gY29uZmlybSB0
aGUgZ3JvdXAgc2l6ZS4NCj4+Pg0KPj4+IFRoaXMgZmxvdyBlbnN1cmVzIG9ubHkgYXV0aGVudGlj
YXRlZCBhbmQgYXV0aG9yaXplZCBkZXZpY2VzIGNhbg0KPj4+IHBhcnRpY2lwYXRlIGluIGludGVy
LXByb2Nlc3Mgb3IgaW50ZXItT1MgRE1BIHRyYW5zZmVycywgZW5oYW5jaW5nDQo+Pj4gc2VjdXJp
dHkgYW5kIGlzb2xhdGlvbi4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFZhbXNpIEF0dHVudXJ1
IDx2YXR0dW51cnVAbWFydmVsbC5jb20+DQo+Pj4gLS0tDQo+Pj4gIGxpYi9kbWFkZXYvcnRlX2Rt
YWRldi5jICAgICAgIHwgMzIwDQo+PisrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4+PiAgbGliL2RtYWRldi9ydGVfZG1hZGV2LmggICAgICAgfCAyNTUgKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+Pj4gIGxpYi9kbWFkZXYvcnRlX2RtYWRldl9wbWQuaCAgIHwgIDQ4ICsr
KysrDQo+Pj4gIGxpYi9kbWFkZXYvcnRlX2RtYWRldl90cmFjZS5oIHwgIDUxICsrKysrKw0KPj4+
ICA0IGZpbGVzIGNoYW5nZWQsIDY3NCBpbnNlcnRpb25zKCspDQo+Pj4NCj4+DQo+Pi4uLg0KDQo=
