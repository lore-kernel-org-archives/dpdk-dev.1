Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D161CFD35A
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 21:35:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3C1240608;
	Mon, 24 Nov 2025 22:35:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id AB508402A1
 for <dev@dpdk.org>; Mon, 24 Nov 2025 22:35:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764020106; x=1795556106;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=hNMFEsrnWN5e1V1lnJHk7WZRHb6d+CarkRQeMUqer3Y=;
 b=caAPJ+/Wibl6SbWWg4rRJmSv28ZK/TtQ1LaRtALpLXb2nsq8M6iMfgmO
 caaak4wLRz936xM3lUn02+5v2a8QvhGyMlQn5JsAzZ5XwTpL297/qtAUY
 R+QSwwKTSU+QKLsLP1EeC+1hjgVzoGeOk4DvuhDygWLIn89LiT3EE1PLP
 qBQ0kv89uheKFrKG1F1gkhSVeo9iXmMNcoKBOq5hP3Z9Sf2EDEJk3j/gT
 fRCfpg/y83cISuJG93Ue/0mabu/YdKHPQ15x1vb6e9IMRibmG8HWONtOL
 MssIj6bjZBN4zFFpWbprOpaSz0+GOCkOM4FpYCT2x9TWzDNRTo0uubOIN Q==;
X-CSE-ConnectionGUID: jvJBjuZ9RKGfr3Tvd0DITw==
X-CSE-MsgGUID: BCK7sUsdRFabW2mwPPb85A==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65976917"
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
 d="asc'?scan'208";a="65976917"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 13:35:05 -0800
X-CSE-ConnectionGUID: zMX2ZpGTSL2k/in0orHtiQ==
X-CSE-MsgGUID: LFUZ5pvpRmOWrX0LtuIHsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
 d="asc'?scan'208";a="215793083"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 13:35:04 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 13:35:04 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 24 Nov 2025 13:35:04 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 24 Nov 2025 13:35:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJLQhJjHg1BT33CXyYGfKcqU+nll6LcRTENUk0m1UATjOSHtCzch/tAuZHtAFem5pDs1euXAx1G3E93PxOlwP8g09bW2eugmi4XMdy7WWb/c6LxbTjxMUJDCJB9WOe3vtaTJoAzSJsW5I1Ey4tnoepfT9GheQW9ucNZQguE9lPR3PaciDGwbgvmqfShwPUmIZQSDFSw4QyXRBuqGLLfVkbYiSPicziycIOq3ju7obQTBINUNTCASEYeAWuyR4c87QvYoaCXL8GxoQzNR2L2blQ+756VxSUmuiS5V4voRlmxp8+tDT8YwJFLJEkCKUfjg0gsXLzkiTfOjpPSSefqjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlMvOhlubzQ7p1JsNzeYyEVL/fi1Im7pUqOS6UVz5KM=;
 b=qCX6XSUscqevU/7v3ybYpBSKEmsWGhHOa/gz1jDFYO74aJ2DfUE5vQSH3Bax867zFRlE+9PkSuH3XXQNwHLhD8HHi5Z4pnS2HMSIi+eBme1CMJtnh3WKQmBZYKUnuEKrQ9fnn3s/FdgM849oqhOBExia0XWSX5X+wWNh8fsRO7IqrKmFmjq7KIPfiFxmYcZI5vj67qpob4/OBe3v5zYYsVSrR6ryeYM9Fo4ha5XHkuHMBo0XCRO989uH8qBKkVMfHe9t3FhgFjLib5UQxqCVnbI5Izmtb9ql4TZnEH51ZEdmvxY2MoxUPGmV7oDUJI6TPPjSUDaR5ZeL46XAvdGqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Mon, 24 Nov
 2025 21:35:01 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 21:35:00 +0000
Message-ID: <d8a31647-1e3c-4344-b165-d1f9b628f7e6@intel.com>
Date: Mon, 24 Nov 2025 13:34:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/iavf: check PTP capabilities during init
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Paul Greenwalt <paul.greenwalt@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Kevin Traynor
 <ktraynor@redhat.com>, <songx.jiale@intel.com>
References: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
 <aSRK-FE-yAgaU-oT@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <aSRK-FE-yAgaU-oT@bricha3-mobl1.ger.corp.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------L07KMBEDw2hs0m1g0YtGncBI"
X-ClientProxiedBy: MW4PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:303:86::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 18090343-b021-4ac3-68e1-08de2ba151a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzljTHVkRGlvZm9xOHhaN2V4L3dTVkRnb0VQSVBhcTdnWWh2M3RJczJPb1hD?=
 =?utf-8?B?cnVaWnVCTXVMU1hkQ2YvazhRd3hjVWhkYnhxNkdNN0lrblU1dWZHK1p1eHE3?=
 =?utf-8?B?Sk9TZjc2MTBQaUNwRi9uY3o4YVlYd1hjM1JRdUpwMkZoTk1TZDQ1K1hFTFY2?=
 =?utf-8?B?ZEFxdVlNNzNnc29tNDZpeHhTTm5VZ09RcWpsOVFWdEw1L2xyTThBdnU0eTJn?=
 =?utf-8?B?Vkt3QTUwbmlaa3J0YVFFaDBGbHBoZUlySm4ySi9wa2xTSml6eE4zangrbWdm?=
 =?utf-8?B?elNFN0RseVVmM3F0UTJRbFBpVUVGVTNBMWNJeHpNYzk4S2p6UnZndGVFS3Fn?=
 =?utf-8?B?Z1E1TDU0azhnNjlZYVh2aEJMalM4VXhTQjBrV0QvMFFwSjNzVFB3aCtsOUJt?=
 =?utf-8?B?SW5OdGw0b2kra3hnTVlITDJ2bXF3N1h4OG42enZoakFpNm5wRDZpZm02cndw?=
 =?utf-8?B?Yjh2djdvQU45OFFEZW5ISHI0WlI4WlM2S0R5RVJkalZMb0FnNko0NS9XMlhS?=
 =?utf-8?B?M2NQaVJibVB4VGxiRlN1WC9zNTM5dWJDZ25zajBKWG1LaXJ4cy9aK2tIQkU4?=
 =?utf-8?B?akhXZk9FSjlIaWJNQlhMMi82NXpMOUZNZFo0ZlpMeXBqblZYSzlPYSsreFNp?=
 =?utf-8?B?QmRMWWhxTm9xWWhkVW44MFB3K1llVEwzeDVhajRiSHdWUG5RaWNTZm9PN2pU?=
 =?utf-8?B?Y05PRklZMjRhOEpYUEVLQ0tGSkx3OGRCN1VKd2YycjVETkErVHJsaGJMcHpO?=
 =?utf-8?B?MXlTQ1FtellNa3VmZFEzRC9uQ3JBWU5SQjVTYkUyN0dCa25VeXNoWWNNRkU0?=
 =?utf-8?B?a3BRaUV1d2hlc2RwU2pIN21vV05ab1NzQWdMZDRFd1R5TUMvRXVFNnlvTlZh?=
 =?utf-8?B?Yk5FQWFWK3JvcmQ2OFlOMHM0ZEdLdGNsQjBGYUZsMDlzNFYvZ3VNY1pHU2No?=
 =?utf-8?B?cnJweVRmZ2s3SFJBNFJrRXc5ZG1aSHpOYldaTkw4dWRtdkNHN2xEQ0lqRWcv?=
 =?utf-8?B?Tk8rbm1WaU9kczhSWEhHYTd3Rm1JdkFOa0pNR3I1VmtESXFVVmhDN1I5cVdt?=
 =?utf-8?B?OW03bG9ZbVd4aExTcEEyaEc1b2EzWWx6czE3YnVueXliR3crYmpkQ2lOZmZw?=
 =?utf-8?B?c0czTkNjQVhDbGlsazZQSDZaaWVQTjVkZXQ4a0RXY3BaMkdodXFZdFZUWFB0?=
 =?utf-8?B?TUV3VkVwMlV0eW1KNEVzMFhRSW9yWm1LaHk2UVNHYkZnclhKbmU5d1M2U204?=
 =?utf-8?B?WCsvaDd3czNSeUFTTkwwbDRsQ1FkUWhJM0VTQjJYZVlKaE5hWVZUU2VWK0tE?=
 =?utf-8?B?d0o1NDhCNjNsVFV6SnRjQU55enZDcWo1dHFucFFNaUtOR0g0emtlMzh3NEgv?=
 =?utf-8?B?b0tEd2lseUswdzVzb3ptejhFWkluTWJSektISGdMeTRLWXFER2ZkamN0cmNJ?=
 =?utf-8?B?bllEamhKcFdpcXBXUkpRTUF5YnFLUlQxYjA5M1hzaThCb2JiTUZZSFk4ZHNN?=
 =?utf-8?B?bG1IRkJFL2t3TENMS3hackZWTmlJUmYwRmpmSlZVdWNjQ2w0TEFNVDJNYTZL?=
 =?utf-8?B?WStiSnZ6ZXU1L2lFY0dndkh2QXZ2aDlWaXh1SWlPd0lvOW9VU3hnUmVDS1Fy?=
 =?utf-8?B?VmNtTnpsUTcvdVBzd1FxMzdLT2JLY0JNTy96WW5xdnZxbG5raGFVdUh6azZZ?=
 =?utf-8?B?bEN1eCs2c0xJMzFOWjJZOGFFVTU3Q3lRdDU5bzZqdm1Yb0JYYmJLU2pkS08r?=
 =?utf-8?B?amd3dnMvaUxSd1JSZXNsd1pVMnRXMVR1c3JmLy90aFRES2wwMGNNYmpTYnZ0?=
 =?utf-8?B?SlE2K1g5KzV2ZVd0Q2NLcG5GL1dyalNFOFVaS2FZejF2UE55WEdtWjJZTTZE?=
 =?utf-8?B?WWExM2s0V05iK1M1R2hyNklEUXlDTWJqRGdVMXBhUEtaYzFrb3haV3dhb3JK?=
 =?utf-8?Q?6r5CXt/s60slVO4vWl/HvdQPiCPiMu2/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5089.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHdsdE1pNDlQSkpselBoWDB4Z0J3VnlMN1puUGtqL0JZblcyQ2Ixd1FaSytH?=
 =?utf-8?B?M3J4a1JBWjNZd2ljSVFqNGJCMWNOR3FXUFFBdWFGUzZsdS9HMnpSa1FnTXRm?=
 =?utf-8?B?MWpvMm1KN0ZoL2FZZmlZN2RpR3RaN1N4aUczd1ZaNkRXNDFIS3QxZk4xdnl6?=
 =?utf-8?B?VW1peWVIRHplYzhyb1owdHlOY2lteDFYVnZ3WUZKY1c4NnB4Z0dBVjQ4eUh3?=
 =?utf-8?B?NlF4QXRNWW84b0UxWmdvZktMS0Njd3B4cmZaTHJ3VnNpN2p5Nk5iQUgvL3RM?=
 =?utf-8?B?R2xNVURTL3orbHBYUG9jOWtRejZBd0Q2MUZBSTRmUG1ocUU3TUlpWGROMWVi?=
 =?utf-8?B?WEU5MCs0dTFBWElCVzZXMkM1N01TVVgzVkdHWEJzM050c05uUVJiM3pBMlBi?=
 =?utf-8?B?dWpqS1hQTnZDMERTRzMyaFB4eVNtMTdJbVlFd3dXYUJUWE84a2NCdmx3d3pt?=
 =?utf-8?B?eGErWTVkbXphdGVFK3NqMys5ZUxRdjJYU1d5SU9zZzVIMVc4cms3b2VJNHJX?=
 =?utf-8?B?amNPMVFidGxkQ3FqRTc5Mm1oSVZWQVdqczhZeUlkejh6SlVpNkNxdE9iNFZ5?=
 =?utf-8?B?VTRUQXZkM0hUZGJRT1U4QTRFN3dOZ09EZVJTTGRLZkhIQUhOZlllOCtXVE1T?=
 =?utf-8?B?c2YwWHlyOVlSSzFqcDhYS3RiVGdTMi9xbW1Bd1E3T0JxWGs0UUwvckJHTkFV?=
 =?utf-8?B?UkZHaEFnR2RDVHJtcXExT1lDWStXRlZhbkhQRTByTXJkWHh0NlVrY3Y3MFNS?=
 =?utf-8?B?elBMWlNaYkNsWlJBS011R1BvRjVseXRURGpSZ2dJRFc4TEYzanVEWUpraDlT?=
 =?utf-8?B?M1p6RTJOSkU4aVRKZmVPVTI4NDF1Tm1LNnJiV0I3bUowR3Rkb2hJdE8zck0v?=
 =?utf-8?B?WkdFWUJvZzZOMWY3enY0MmRoZ0VTbENKeUFYNFl5RnBJOXpUcDkzSGZOUEI5?=
 =?utf-8?B?a01VM1RDb0FXWHUzT0d2VkUvREFWbEVqWWcxWENWQmg5cXk1N2RuMjdKNlBk?=
 =?utf-8?B?VEVpa1VrY2dabG1VUHR2WUFFcHA0a3JqdVdQL2lIbE1DOUJiMlVJd2ZXd041?=
 =?utf-8?B?VDJWb0ZydVRuMENJdFV4bmJIYUtWRHFKVlBMRnFONWxWeFJuRVVTWWdKS212?=
 =?utf-8?B?bnJYSHNuazB6NjNTTkltdjQ5QVdKZGVNZXFnNWhsa1k2aDB1QjBBc09hRm1v?=
 =?utf-8?B?Sk9ndHpuTDE1WkZSQlNvMHRGbi9wZkVSTWlES0J6b0x3QWJJRnFxLy9ZM1l5?=
 =?utf-8?B?dzBBWEJpbmxnWDFCdXI0S3E1NGV4ZDRwNDY0eU91UEZyNTdUTkN5UlFJYlRS?=
 =?utf-8?B?RGVVRzBDMnRTRUlrTHhKek9pRnp0QlYyeVBzUjgvbWZyQlROVjVpdXM1KzVa?=
 =?utf-8?B?NDFxRUZnZTdQaDFjb0M1bVVXMTlsVzFZV0h3NmpHZjN3UXRuVm0vRGp0L1Vx?=
 =?utf-8?B?TDBWa1kreEJ5ZFA2OUt0US9PcXFTcE5TdmxFdUVuZXNRbzk2aHYwdVpWam1j?=
 =?utf-8?B?M0xVT0duRVdNTStZOUsxZ1hONFovN243d25kVjBKaWN2SmtuNCtpcjFQd3pM?=
 =?utf-8?B?SU1lZzdQZTFuQndrSXU1azNib0FqT0Q4NlkxRFBRVXQwaURWTWd3NWNkUURq?=
 =?utf-8?B?dmJnQzI3UWkyZ1QwODYzZjllR3FVQjA5UVJ6ZWt1NHQzMjF2Q25PMkMva29Z?=
 =?utf-8?B?SzBvK3paK3IxMDdSSUIyc1RldmFKWUJjWnNVcm9HSis3dnRKTk4xc3ZFY0pq?=
 =?utf-8?B?R2Y3Q2FEemNuNW0xTDlNQUZHbkRnLy93SGFpZWhsUUxZdjRqbDU0S3dNYmwy?=
 =?utf-8?B?azdDYzFweDdKSWkrWlNzVW5TNzZrK0lGVWRNOS9nOTZWM1IvNUtzc1NWT3dt?=
 =?utf-8?B?Y0hlRFpGVDZLNnVXY0NENFpKbCtzcnJVMnoyYzVBRk8xRTI2OU03ZHdEczZo?=
 =?utf-8?B?OWh2SDZYajRycTNsd25jNUc3S3pBRW5VcG9KdW1SRWhPYk9Wa3l6OXFKUGFP?=
 =?utf-8?B?b2pPR1JnYjFkcFpvelVxcmw2L0ZBblRXZ3Z0dE8zTG9NTklOLzB6ZmNzM1Jy?=
 =?utf-8?B?WVlzdHRQMkVFN0F4SG1NQ1FqbnA1WEppazRDa3JIQ2tEeC9pNWNWTXVWY3Zm?=
 =?utf-8?B?U25qYTNtOEZWVmZEU2RFcDFWYVdLbGhpOWxxcGdLbnRPajJ2UGZoYytwT2lY?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18090343-b021-4ac3-68e1-08de2ba151a4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 21:35:00.8578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AITphMnD0cbicxSl5XbUuesexWlaoilzQCxEtfzcv7t8bk/9udDklTF7880e7GpeDEWPwNgOB69qq1wY005DPHVTI4bZVVVP8IC/qa1MYtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
X-OriginatorOrg: intel.com
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

--------------L07KMBEDw2hs0m1g0YtGncBI
Content-Type: multipart/mixed; boundary="------------qY0Qsk1JoxVdRt0Nhg6JaZuV";
 protected-headers="v1"
Message-ID: <d8a31647-1e3c-4344-b165-d1f9b628f7e6@intel.com>
Date: Mon, 24 Nov 2025 13:34:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/iavf: check PTP capabilities during init
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Paul Greenwalt <paul.greenwalt@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Kevin Traynor <ktraynor@redhat.com>, songx.jiale@intel.com
References: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
 <aSRK-FE-yAgaU-oT@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <aSRK-FE-yAgaU-oT@bricha3-mobl1.ger.corp.intel.com>

--------------qY0Qsk1JoxVdRt0Nhg6JaZuV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/24/2025 4:09 AM, Bruce Richardson wrote:
> On Fri, Nov 21, 2025 at 03:39:37PM -0800, Jacob Keller wrote:
>> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/=
iavf/iavf_ethdev.c
>> index 3ef766de4704..9b07b11a6b51 100644
>> --- a/drivers/net/intel/iavf/iavf_ethdev.c
>> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
>> @@ -2887,6 +2887,14 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
>>  		}
>>  	}
>> =20
>> +	/* Get PTP caps early to verify device capabilities */
>> +	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP) {
>> +		if (iavf_get_ptp_cap(adapter)) {
>> +			PMD_INIT_LOG(ERR, "Failed to get ptp capability");
>> +			goto security_init_err;
>> +		}
>> +	}
>> +
>=20
> With this code added here, do we still need to keep - or should we keep=
 -
> the existing call in iavf_dev_start()? I would have expected the call t=
o
> iavf_get_ptp_cap to be moved rather than duplicated. Is there a reason
> to keep the existing call?
>=20
> /Bruce

So, I considered this, but I am not sure. In principle, we need to make
sure that we re-check capabilities after a reset. It is unlikely but it
is possible that a device reset could cause the PF to change its
decision on capabilities. I didn't see logic to call this during the
reset handler. If my understanding is right, thats because the start
function would get called after a reset, at which point we'd recheck
during the device start function.

I think its harmless to re-check the values as they should either be the
same or if they did somehow change we should get the updated value. The
intent of checking earlier is really just to make sure we try not to
report that we support timestamps when we definitely don't.

In particular, I wanted to get the current case with the upstream ice
driver and the DPDK code to fail closed instead of attempting to enable
timestamps but doing so incorrectly. (As outlined in my earlier cover
letter, we have a compatibility issue with the in-tree Linux kernel
drivers and the out-of-tree drivers regarding the capability struct layou=
t).

That setup was trying to turn on timestamps but the PF did not actually
enable timestamps due to the capability layout issue, and thus the
timestamps were bogus. Instead, the new situation should be that DPDK
reports it can't enable timestamps, until we figure out the solution for
compatibility across these different variants of virtchnl. I'm working
on that but don't have an ETA or known time where we'll have a good
solution.

Thanks,
Jake

--------------qY0Qsk1JoxVdRt0Nhg6JaZuV--

--------------L07KMBEDw2hs0m1g0YtGncBI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaSTPggUDAAAAAAAKCRBqll0+bw8o6HHt
AQCv78bLmA/xCqOcOT4/MinmkaM/9oU/D8pUDjGUGiBzeQD/U0Zc8rZC9HHcULC8zun2oPVOiCpV
YN5DQrTkAekzMwk=
=0Oiv
-----END PGP SIGNATURE-----

--------------L07KMBEDw2hs0m1g0YtGncBI--
