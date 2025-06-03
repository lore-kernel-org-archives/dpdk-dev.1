Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F94C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 14:42:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A45EA402C8;
	Tue,  3 Jun 2025 16:42:45 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 749434028E
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:42:43 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553AK38S021991;
 Tue, 3 Jun 2025 07:42:42 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2122.outbound.protection.outlook.com [40.107.95.122])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 471y6rgggu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 07:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brpFGSDNbviR4HtE3rJYPtokkKz6ke5chQroKFzydsCkS/8P3FQBbwJDKZZUWlyJA0ZD+yeu6lKurcFuThhTLaQVk9gRoQ122ef7PbONn4c2113HgPtmSGa+qEVgkVPu/SUN+epxJ8D+mYZCZHOiiLNZRL+/IeRrkOPG9+XBYdd/Z+XzO5MRMwBPUzFrw83rla3BP5IOjDCGA2vxe7WW4S/wOt8u3KMmRDm9JziPGzmtDM0732k/h0/+qSEP047qTpmyY77vZdKsRxqoGG78ZQQ9AxC1wOPZPMr59q+Iw+b5eA8CqIRaITCTRb+dT+IfHCiJQEq3OAk/6PTUud0Shw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwRIcl91NAPmnBxR6uMl0Ca+wSnQmCt4JsqONfYvYWQ=;
 b=C/wlOZrDkKgn8QbLi+3Ds8cpltrrmk3+1LwT1QSnpc6nUD3k+i0QWqvlGZBdObi745OKw06JWldK9z1eluZhH1t1mA4TykVAtx/sj4+xgCHFnTZ4KL6ECvRchRcVbZvS8ZSpK9uXOySbAv1z03RoO4j7t9dkhYjUS1eZozzbZUm9Yvs+ZxfqrVyCbEw5WNW8G12Vs/Ml2sjW/+RXzHp9jvyiyXZpXLC1+rSXX9R0TFYOXLnQ0tqCHTGM8TJzVoQGVnrLqAvRwnn3H4HhlWnb12tiCxAlJaf+8nohhRZiZ8nb+/xKL7lRjp0/EOpQ00OeVxGdWXYEWKOZNp1CUq3LSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwRIcl91NAPmnBxR6uMl0Ca+wSnQmCt4JsqONfYvYWQ=;
 b=VC/jAOimnTtb9oguW8qChu3RU1mra8nFpkMmCvxEjjFnds1xAxbMxHw30rRGLFe18e+5H5iP/53gVgBzfJ4y7HEQI6uc4+iPzKolKEgy39TvtM78PdGPkikKL2BW2Y2VJk5Erlra31eQU8TYS9/alHnwGpWs9S04i0JrXDe7g0Y=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH3PR18MB5955.namprd18.prod.outlook.com (2603:10b6:610:1e2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.32; Tue, 3 Jun 2025 14:42:39 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 14:42:38 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Rajesh Mudimadugula [C]" <rmudimadugul@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "jianjay.zhou@huawei.com" <jianjay.zhou@huawei.com>, "Rajesh Mudimadugula
 [C]" <rmudimadugul@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] crypto/virtio: fix driver ID for virtio
Thread-Topic: [EXTERNAL] [PATCH] crypto/virtio: fix driver ID for virtio
Thread-Index: AQHbz77V0gGnXpASK0OGI4pisQGc4LPxi8zA
Date: Tue, 3 Jun 2025 14:42:38 +0000
Message-ID: <CO6PR18MB4484B86F8FA28AEB40254462D86DA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250528105347.2014993-1-rmudimadugul@marvell.com>
In-Reply-To: <20250528105347.2014993-1-rmudimadugul@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH3PR18MB5955:EE_
x-ms-office365-filtering-correlation-id: 98896c9e-9388-40a7-e0f1-08dda2ace349
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dDRzU2E0Sld5UWY3d2hENGtDVzNPTFZ6eWIzMGtxQUdxMFhaUU4zSE40MEJF?=
 =?utf-8?B?ZTlzUzgxOWxUVlJOS3JCMHJJNVEwQ0dVTWNwWU5YeEllRVkyWGt4WnFLU2xV?=
 =?utf-8?B?dUhBc05RaTZjdDNjS3ZkUmRUQXYrR2lwNms0Q3FSd3lWOEdRcnoxczAySmZM?=
 =?utf-8?B?VU1JcURENHhFTk9jVzFQekpOMDBJRWhBeFNZanozZHhCSlRKc2Y0b2Z3cmNw?=
 =?utf-8?B?YmNPN3JOQ3VLUFlaRFZiTm9zUnlXMXRIS0tQVURFTGc1TVA5aFlwZ0Nic2Ev?=
 =?utf-8?B?MC9ab1QwNUpGY0ZJcDBTMjRjWVpxUFE5Tk1PZmUzUVIrMG1ieldsMlBhSzA1?=
 =?utf-8?B?N3VsVzdwdFlwZExJK3EwT3FsalErK09kTjZNazZyb0tUMkZUeUZxb1NPeUpt?=
 =?utf-8?B?ZDZXTnkyMm41dnBDbHlkcDBseDFrSXFPeVBSNFRndWdhWnlRSnRYb0tNbzE0?=
 =?utf-8?B?ZDVOQjZyVllia2xGeW5iY2xRV0RHTWdqeHlDTVR4MENmT0ppMU91RXI2RnpJ?=
 =?utf-8?B?OGpTTmZzOU1NaVB2NysxVFptZVlIOTh5cTZkN0ZnZzhVckFScGhkeTVaMXJy?=
 =?utf-8?B?dm1pUzVleWxVTkJWc2RrOHFZcjFCNWpwd3g1cVN5TjF1anVvMU1LcmxyQkdP?=
 =?utf-8?B?WXNSbXpEaXpSVjJYUHY2aFVPa0VtK2NRbCs1UVVNbVcxamMyZzl0OWJTNlJE?=
 =?utf-8?B?RWdtSk10YmRtZ3hoU1VCTm5HQWhOUGVyUFpmckl6MWhrUDlYMXhscmQzSUpy?=
 =?utf-8?B?b29SWGRhbHhJa3JtVzZRYnRuZzg1eFN3U2NoeGtuVEJEamNzeDVhaTRKMm5q?=
 =?utf-8?B?STlzRUZuVXh5ajBIbi8vSHowV0JqVDAwMm1MQ2ZnODA4OHU2ZnhiWVZnOFhv?=
 =?utf-8?B?ZGRxR1ZsS1FQUjI1Y2wxTGhCdXpLZkpIZWtwNFhMaCtyeXVmYlp6bjZ6R2FP?=
 =?utf-8?B?dkJwSHFxWmJMZytvMEp4SnkrUHRvM1Y2TlFJVHhJdTdsTnpTa1NiRHBNaXhE?=
 =?utf-8?B?V3NabXc3YldaTkdjR3puMlVzcWhRSmxucnNkeG92ZDIzZ1V5Si9EZUVod2ww?=
 =?utf-8?B?T2dIN0RKL3d1M3QxWEJLNUdaVzdROEZ3MDJobStzMWZYZjJGYUxoQk1YM3B1?=
 =?utf-8?B?b3BVbmJKd0pvU3RDRG53ZFFzckQzcmM0d2d0ZVlPRGdRcGFxdGVua0tYOUdE?=
 =?utf-8?B?WFJDeHV6Z1liQTdXUFNXYmtjQWRrTXYzaklTbGFHd1JzUUJyUnF2QVl1T0Js?=
 =?utf-8?B?Y0VIRzNXTXFIZFVock95U09NVFdLWHFJQnI0WFJJNE55VU9GVFM2bnB3WE5j?=
 =?utf-8?B?dC9tVmFNTU1NQmgydDBDTUU1c3Y0b1FwbE9JZjRSYUY5aEFscnoxckV4bEEx?=
 =?utf-8?B?YmJwZ1g5NW1VaWNlMTY3WDAvMzNpdEhEak51UTVTUStJQzlFSHBCS3htSUZU?=
 =?utf-8?B?cnJBSGJQQ1VMWEcyR2kvUXVkTEROVnhPdVlCNm9UbWRzUHFTcmE4QTBRSFcy?=
 =?utf-8?B?RExLUk1NSm5GYll6S0Z1dml4SWlZd1hKbXg0K3dQUVpmUnFubWoyL2NLRTFV?=
 =?utf-8?B?aXRnei9nb3RINy9JR1pIM1BPTFpUaGJtWS9rUXdCWk9JbGFVWHlUQ3U2Q050?=
 =?utf-8?B?T3Z0dVRzQkpzM0t1ZEVNMkR4SW92dTBqblVTVUMreHNXYXliUDhOVHhWd1Nx?=
 =?utf-8?B?UkFnWVdxcVRkOUVpc2cwMCtJaEpsUmtHTTJ2UVAvVk9TVUloRXd0cnhNd1Fh?=
 =?utf-8?B?aFJXb0JNcDlqTWdOOEo5NVlFYVlKUGlPUitRT25PQnE0dStnSnB0dlFiUmVE?=
 =?utf-8?B?ZWFPMyttMUlKVm9uNW52T1EzclBTZ0FPNW05N1lvYkwrajJiQ0tCK3hUZFJv?=
 =?utf-8?B?RjI0eEpiNHFaaTU2emxHczNUQ1VrRWNZNkRRL2N3S2M2aFYwcER4NTJsWld1?=
 =?utf-8?B?V3hvdjVDc2l1QmVJME9UMmRUTG5JaHVYRzlNQUNIK0RjOGNZdFFrWjZ0RnN4?=
 =?utf-8?Q?0cW6kJEwPVLokiOJsJBNmOaLh2PqFA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUg3ZE1DODhzZW9lNkJLMENlZ015QTBaV2xRVWMrWUdqK29pcXhLZ1RPNjM2?=
 =?utf-8?B?dURkWlI1MXAxUzd2aEFyZFlUd0p6dlh0ZVpLS0kzbnh2aHRHV3dRL0VPbGV0?=
 =?utf-8?B?MXM3NXJXSk9kY0VvYXV3Q1VyL1g2Z1U2SWhkN1R4OFJWZmJZTnFyYzlUdWo3?=
 =?utf-8?B?Z0xQUForVktOUUpmR3lGMzRUQjRTS2xnT2xZWDcwc0k0UkZJN3BaK0ErYjRS?=
 =?utf-8?B?LzR5SWhyVkU5eGNRMlU1dmd1S2thTXllY0JrdXJHaVpON2wrKzMrWUcxMTcy?=
 =?utf-8?B?WDd1SEJwcGx3UnZNcWNqUzFZMGNHTEtvMktwYWxneWU1d2JLN1pKQVYvMEZX?=
 =?utf-8?B?KzJneEY4ZXIzN2ZDNkp6RDVBL2FMVENZckpVWTRRUWRoVDN3Q2FJLzBvWXEz?=
 =?utf-8?B?MU9FdHJaalV1Z0FKVmswK1g4RXR2amUweVIzaFJOOTJkOWREL2k0bHNhVDNt?=
 =?utf-8?B?UUJlbWdIbUZFdzM3VEM3Qkl5YVZ0MWJyUVJTbVE5cGZZVE9zWVJobTQ5a3c2?=
 =?utf-8?B?TjVZaHljbUp4ZEtWRTFab0FXMVJ0Y0ZyaFZKSDNnSUk2K1IvcHFZMERIVzlN?=
 =?utf-8?B?QWN2TlhDWEpHYWtJemVJUDZMLzdhN0hJRE1MUCsvWit2TXBETXBydDlpTm1v?=
 =?utf-8?B?dzJQVUVOUEpOUXQ2TmgwRmxwYWR4OExVYlJnMjV4MmRSczJZU2hvK21zYy9E?=
 =?utf-8?B?dlFjSHFTSUZmbEpzNERlajlvaHZEZVI3cFFnM05vbndUcVV0T3JiN2dFSW53?=
 =?utf-8?B?S0F5RXpNTVRzcTl5VjkvbU9BNlBheGMvSkN1Y21DZ0ZlRGs4Nmdsdy9lZS9h?=
 =?utf-8?B?UkNmYlIvQ1M2OTFHUHM4YXN2UjFKaVJhck4raTVsM1gvOTI2aUxYa2M1Lzg4?=
 =?utf-8?B?WktZVGxJRGZ6ck5aYjB4YW1BMlZ3Ny9rb1A0Znk0U1BVU1h0eDZJelFoZFRr?=
 =?utf-8?B?UnlvbmUwWS9kZTAwZWhwcEdsUU9ZNGJ4ZGI1RzI0MkQ0VzhqWTBoekRLYU9Y?=
 =?utf-8?B?bjNYRUdYeVE1U1FnUkRkVEZ3MEM1MUlqYklUcmNTdVJCM3hMcmhXdVcxL2Jo?=
 =?utf-8?B?YThjN0dnU05FM0dHUnRZUTNqUDNubWFwN2VqM1JaOUZlV3ZhN09Pc3hldEZi?=
 =?utf-8?B?dDUwZ3dYUFovMFN4YVMrQXdpR1JhYjc5bmhKeUdpNzBZN0tadlhka29qazJY?=
 =?utf-8?B?TjdLQjFBR29adWtZeG9GSVp4TUt2TUsrS3pwUHNQdnkyem1GeE56TEZmZWV3?=
 =?utf-8?B?alVrRG9RVkViZHhnVzJZTjAzYTg1eGNKTFVkVkdEcGRMRk8yZlREdzNISlBi?=
 =?utf-8?B?ZjFKaVhsWTNqcVU5M0Z2dnFmWDVLZEhaVnJva0Y1WFNaTklnUTR0c1o4b3ls?=
 =?utf-8?B?WGE2ZktNUjYxRkYzOStXaDFVQkRaTy9zUGtoendZZ3JZNGVDaVB0N2NqSWto?=
 =?utf-8?B?bmZVZlhQR001SHovb0FOZnJTamJBU3Y1Q0pPTHU4Z2JLY3VwMmw1WTJYeVl0?=
 =?utf-8?B?NktJQjM4cnc5MzFyaVI5Y09pSU1tMHJseGtLM0lCSGxYUjRrbTVGRm9vV0h2?=
 =?utf-8?B?OVJLQlU5NGlFSzQwcElXNDF0cGU0aC9MWk5WUW0rdzdWUjVZc3gwZzZCSU1U?=
 =?utf-8?B?cXlWemh6NnNjd0h4a0ZoTEQvK3FLcDBWTDVWL2pUTlkxRWxqa3RmOFJiMnBH?=
 =?utf-8?B?SFRmbWpjdWtveDZvYlg2N3dRSTlDb1k5OGsraFJjTlZ4N1FxbmQ4Y1lvb09k?=
 =?utf-8?B?RTMyL3FKTmZFWXgwdnVmRWFCTDVPMmJpdk9rbzJCTXUwZ0ZKaUE5QTRHY0p3?=
 =?utf-8?B?T2NnMk83a2Q2dk9hQmRtYklIM0h2Sm9VUTB1R3dmbUVXS2VNYW03dVBNTytQ?=
 =?utf-8?B?dXJqWEFOUGl5T05TV3QxZHlZL0FibzM2czNRNkZGK1RPQzd4Rm0weVRDZVhl?=
 =?utf-8?B?TXBrSDUxejJ3ZStSdGpwSHEyODV5NXFQOUc3VXc0SzdYUHlremVqMERMSDR6?=
 =?utf-8?B?YlAwOUFuUHBzVm5SRU9RaGZSaTkwMHdtNUJlMnRGTlExYVBJNzRXc2o3a29T?=
 =?utf-8?B?YkN6U2d3WE9oZzg2OUw0Nk45Wnlzckd0SHdiOWZiZk01MjB2RU9tRmpaV3c1?=
 =?utf-8?Q?FI/A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98896c9e-9388-40a7-e0f1-08dda2ace349
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 14:42:38.7346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: woYms8aqZPH4p8o7SsnJaDsB794a0i0QYdQolSmkHVa38TB8TymM9dEV3H5GfVDirQMiY/Lv11oHO7HK3OFlBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5955
X-Authority-Analysis: v=2.4 cv=Xpf6OUF9 c=1 sm=1 tr=0 ts=683f09e1 cx=c_pps
 a=9KfKS67X5H5xMp0rraAONg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=lqsVQBTuZXnp9WXg4pgA:9 a=QEXdDO2ut3YA:10 a=GazqmjL6yFgA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: fqQVirtJL0YBW7WZm5_l6O9WngoIv6WW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEyNyBTYWx0ZWRfXwCdvvMx3mEc+
 gvgBusBSyw5W2VvTVC1VGcqrq1h6J4JQUFt6EMH/Vr82Q2FHYLll/7BRlj8YOmhnFlByKcjm3Ga
 kHDcSS0J77NPfO/q4DrQBVisLIPDPFf5Ga/yBOXGhHYcmBo6FiXgQ427W0yzGgYYW1s5cz0a5A6
 fUcsS28U5wz9ZTvh00OYMMsMlKr2S8GyymYaeRNVdF9HBfkFDunWH+IupRMbnGhyobCsWyVTojK
 C6GdqZK4Mq4kkmLrnGtfOpyF//DTU/Y/UZcN4UoPIfEb+rNlFOnaem7AKrF5kHF2iR/BeyaD3CM
 iVvl7s8HEtGA29jhmzosUbpb0guo9jMt22XAV28ZmcA2toeVKyuiQzpngBKRucU/ObV73/azy9t
 mWNwa26zt25e+rMsPPwk67YmrMjUMobRH8ZimVggatZpgwHz1HwqHhFB8vxBPBSQzxUXCajB
X-Proofpoint-ORIG-GUID: fqQVirtJL0YBW7WZm5_l6O9WngoIv6WW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

PiBUaGlzIHBhdGNoIGNvcnJlY3RzIGRyaXZlciBpZCBmb3IgdmlydGlvIGFuZCB2aXJ0aW9fdXNl
cg0KPiBwbWRzLg0KPiANCj4gRml4ZXM6IDI1NTAwZDRiODA3NiAoImNyeXB0by92aXJ0aW86IHN1
cHBvcnQgZGV2aWNlIGluaXQiKQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFqZXNoIE11ZGltYWR1
Z3VsYSA8cm11ZGltYWR1Z3VsQG1hcnZlbGwuY29tPg0KQ2M6IHN0YWJsZUBkcGRrLm9yZw0KQWNr
ZWQtYnk6IEFraGlsIEdveWFsIDxnYWtoaWxAbWFydmVsbC5jb20+DQoNCkFwcGxpZWQgdG8gZHBk
ay1uZXh0LWNyeXB0bw0KVGhhbmtzLg0K
