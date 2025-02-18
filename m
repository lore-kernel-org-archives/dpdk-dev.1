Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFA2C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 09:28:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1523E402BB;
	Tue, 18 Feb 2025 10:28:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4D0FC402A0
 for <dev@dpdk.org>; Tue, 18 Feb 2025 10:28:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739870897; x=1771406897;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=vBn2lDyGfgBBpR4c0waCMvTrL26ALI8uDtmE03YwGpw=;
 b=dCWvGgrCMSRj1bQ+hv1vDZX5SflSa+hWZTWRMhfkNHeDeGbfwZlo+5X2
 J5sHLSXKr59cbzAX7BcJhtohROu4kljEnpc+CzA1lFRdzzIgyG9qE+/HS
 yuAsOw4YxktmlLp8dWETR5YPD5zvDwOEraOjB5gkYebiPv/PiUG7IIpKT
 A8Zb6FYi0qO8vHlE6pExyj/OEipA78xkp3it/AMC4PZNX6HkaKp2EsI0/
 X5EJlAIIFOOtTT2OQpwsWoFz6WMt4ds/BbiUAlRGsJea8uGuHJpT2Oyww
 tHB5tzcTWcBt+OjcjtYhW5OA9sPSkWFy0W6MdZcA9n5X9jdMF1l5QFhy8 Q==;
X-CSE-ConnectionGUID: kvXL0itmTmmImbw/02BGEQ==
X-CSE-MsgGUID: MUCttZ67R/26KdVCXx2EEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51963755"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="51963755"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 01:28:15 -0800
X-CSE-ConnectionGUID: ZdyUgh/HQI+ygTDrHKn4TA==
X-CSE-MsgGUID: 0qrOq+QSTImeSJ9oJ9fITQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="114536035"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 01:28:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 01:28:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 01:28:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 01:28:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qR6rALKfziufyRNok0Twqfo31PcjRAVCTMZH4wuXgEIb7YPhxMpUhE0j+db1wW+8Ng7yB0L58T/bfDBVwLXpKtsf543X7K0PJ+hiAn4UCHpL8qlq09gal9RFD35NKOA/8VOO4EyrAV8ACcHowyggc5gwjdXSCfogJpZv3LVgzkL7kZ6TEfnoa4d+VmX2mODoLy7KsdajK7dmUIWt6YxqG10QgsBzYT8W86BtcHkMzh+2tIhQOh1gyves4VaiTkqbUffeuR6bFiHQRvypwVct0gnwpHDUMcmWZcXgeADmVYejkizDDxd2GEa1gp0dIsx35kHWERGMA5BY0BFkScxHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32rvV+TNHbt4Va1OY5lyI4n+ZpNetaCRi3lEGO5fj/Y=;
 b=xMylZZ7kPfIkiYD4vOUhFyQbM7iWSw9thaWb3S0wk1/RFfd9leVSxfMG+z10apgr61K2JG1JaZt1ndGlvyTFcRGhr1AmKH7r2u0SZKtDWKg1ztcDL8rtXiM451jGN8iaai8qzk5lVAktrlKHEw6f9xStQqVwxnUa5jiX3wv2OOh55OAkc8JGFS+1uZsZk6BF6gdYOV67oGqFHF0s77Q5EA4nGCp5WaOlk4ofVTiI1253shMgc0nOL7zjVqsFqBp1iqcvD/JW6ce9RxzTpIC8mXKQzdT/+FPzQjb5DkTvpoiIvFlaNyjTOVOOAdLPg4wLXx6H9KmmQtLsqIzTm+puWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA1PR11MB6567.namprd11.prod.outlook.com (2603:10b6:806:252::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.17; Tue, 18 Feb 2025 09:28:12 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 09:28:12 +0000
Message-ID: <644f3e4a-ed77-40c6-83ca-0e2f37818140@intel.com>
Date: Tue, 18 Feb 2025 10:28:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] usertools/devbind: add documentation for no-IOMMU
 mode
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>
References: <a1a8fce7e0eb311e7ca673867862a549270f5450.1733132101.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <a1a8fce7e0eb311e7ca673867862a549270f5450.1733132101.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0041.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::29) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA1PR11MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: cd91fe60-acf3-47a3-f174-08dd4ffe904a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejFDRHRKbFB6d0RJY3VjL0xKV2RJRU1zcWZOSTIzZkcxRzJveXo4Z25qK0dP?=
 =?utf-8?B?WWlLRFRiQVRvczdwREszT1N2V3ZYcDgybVFsQUdvTDNleG9aTUN6ZnFuVThm?=
 =?utf-8?B?VERidFZJSi9HeCt0WjU0dEpUTUF3L1RFMjdQRDdtWG1rd3RneDZGVVh5Qm4v?=
 =?utf-8?B?emdoTExPMnFGUzBlbllOQTA0U3FBL1hVd3MwVGt4QlBYcWRsVmY0OHdId2xV?=
 =?utf-8?B?WXNXTGErL1JGc0lQajA1OHZXNmtYYUdITWhsdysrb2N4Z0pscnFYREk4VlRr?=
 =?utf-8?B?dWxZSEd6bFgwbzFvVEorN0dpTHpObVNEWUEwYzV5VWZFV2hIeFZCQkxVampy?=
 =?utf-8?B?Q2dsUGNJNVliN3VBY010YTgxK1RPeTA1UzlTMGd1NVk3OW9HUDdoZWhCdUdD?=
 =?utf-8?B?YkwwSEk0WHE0RE5pZGczSjBrNWlZN0hKOUdtV3VWU1l6OXVQYmFUVlREYXRM?=
 =?utf-8?B?a1pBWU5zL2M5OWsvZmxVWnVPZjZSYVRFWGc3NkVjVjF5V1JKZEVwVnYyMTd4?=
 =?utf-8?B?ZHNCZ0ZGWjF4bU05N0VXeWdxZUMyTHVhMEx5SlAzTU42WDNNQityZkhVMk14?=
 =?utf-8?B?b292VjdFU1hBUmpsSDJnNHgzbEk5ak53Vys5Z0oxWWE0UXkvSDc1SXlLWEJu?=
 =?utf-8?B?YVN6WFh4M1dQT2JjWjk0eGhIekFON1lIK25XZHRZS2JaS1JEcldNSDVwcWJ2?=
 =?utf-8?B?NjBCVE91YkhEM1ZTMnJsUUR2dDFsTFcxTVRsV2pBZE1ZZFpBbWlXZksybmpH?=
 =?utf-8?B?QzdKWTFpNndMQW1xVlVaYStJK3lOZ252NGRWcUtPbEFMRFVvTjlTdkFOaGww?=
 =?utf-8?B?MU1URlhRZExXclFUckI4aWliK2xSWUVzU2pGUElTMkFmVVk1blBJUzBrdG0w?=
 =?utf-8?B?SVlRc0pUT3N4YTBESWtPbERrZVAzTXY0dEtRSEkreVRoSE5IQ3VNbVl2ZWpq?=
 =?utf-8?B?UG9XR3F3OGRpQ0Y2c3RibHN4WDA1QkZLM05aL1RCTFJDdXpucmc1aDJadVVW?=
 =?utf-8?B?YkxCelkzRzdDbTg0ZThialk1eUx3dWxEbmJFenl6NWlCRGlXdzJ5MmtlV3J4?=
 =?utf-8?B?SC9ZMDVXVkNOYlhBTG16b1dxblp5MkNJR256U2VwaVJXU0VXc3FOcFI0NGJH?=
 =?utf-8?B?QStoUXhFOXJqYjFMcHNTQWR4WVVQaVByYlQ4amUxOTlVZkxteTZYTG5KMklU?=
 =?utf-8?B?RDkzeUI0SlMrbWtBN1NHeFZTSDRMVGo5ajZYSGR6ZnQwc3ZRUzJ1Wlp6TmZz?=
 =?utf-8?B?ZkRpbUtEcHpSN1gvTzd6ZGVSSVBLckpFUDVSUW5seFBFMWhRK2UwbFFtbFNa?=
 =?utf-8?B?MDFySWpaUkZ3RkNaUnBuK0RxOHMvbmRvakF6eHpRZmhvMlNsWWNGNEhKeU1q?=
 =?utf-8?B?NThaR3dKOWtMaDh0YlJzVDZxdzJvNWlWMDh5ZW1YRzNTMU5KMkxvb3dBZlJ5?=
 =?utf-8?B?alh2aWhqcUlnU2FqOWMweDRnTVl6eXFxSFN0dFdLVEhxSElGQU1STWE3WjRi?=
 =?utf-8?B?N0lDckdIckJmeUMyUUdWMTBlWHc1aWpYazR4NGtib2tQb2V6TFRlVXdrT3M4?=
 =?utf-8?B?ZldzRW9UNGRpRFY0Qkw4NDBVWlVmN1ozeEd1UEF0UzB4S0E3eXRZdDE5MXJV?=
 =?utf-8?B?a2M0MzVJY1pXVXpPbGYraXZJY21mdlNhZmhaeU1TR1hvY3VDZ0JKT05Td1lj?=
 =?utf-8?B?ci9IMnB6VCtCNUxsMHJKdVVqRjM2Q04rZ1lpZmh5ZGNGd3dudzlRN3o3UjFQ?=
 =?utf-8?B?bEJSelV6Zy9ZQ3k1SytudE02RjVTRWE2dnFaSUpOVjc4V05mWVo1TXRzNExo?=
 =?utf-8?B?SHAxejJNWjlHRHhYWEVtVmVlYStGNmJWUlZ4VUh5WXNCRHhYdzMxV3c1cFJn?=
 =?utf-8?Q?C1UUTNfuFjDXR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2R3eUhWT2dQRDFBWDkrcWNXeDYrajRTditXRGR3cHIxZ2VjclIwd0l5WUM2?=
 =?utf-8?B?SnIzb3ArSklxbHliTUVmTFpZbTlUUWUzL3NTbVFBc3g4OU03d0FHOTRqdkc1?=
 =?utf-8?B?bHplWStBWGlZekNDR1NGb09NYVl4V3NXUGFYMVlhaEMwaW5jSmdDTVJxWEc4?=
 =?utf-8?B?Z2ZUdFhvd0hHQVhhODB0eE9YMU5ENWlwUG51UUE3Y2hNR2VhajY1UU9aRUdF?=
 =?utf-8?B?WGNrbGdiejdEaWl1K0NwSkFiQklBUFdQQnVpcnptNGJBbUtLelZGVWpueVRS?=
 =?utf-8?B?UElzWms3cTBSUVRuV01Qb09zcG1GellUQkdGRnl5bCtXZDEzcG0yeUdsMHZS?=
 =?utf-8?B?NTRPRG5ydC9ZcXBzdk5ubzRGckhLc1FlV0lxWklwQVEvZEtWVDBBYTZuU0FW?=
 =?utf-8?B?Uy85K3UvZVdoM2tXZTdodklibUE0aVlMeFlJT2RkWityS3dMQnBWS2dncCtS?=
 =?utf-8?B?V052UkcvRURCNXJEdVZubzRVUVhJMTB3L1VDUTk2NUYwTkJsbUVFOE52WHdQ?=
 =?utf-8?B?L3QwcmI0cHh5dXNkS0c3cmE4ZlUrUzlCQi9LZWV2R0c5S1R3UlBsNksySDFY?=
 =?utf-8?B?Zk5OditvUjJ6MzJtY1dwcnptTFEzdWd0TTlJVVl1VG1wQUhwQ2g1clFWNGYz?=
 =?utf-8?B?T1k5aTJlaWVFMVZIYjR4cGNnRi93Y3MyaVY2L3c0YXFNK1lWS0ZPcXNLdGlN?=
 =?utf-8?B?MUQ5Um5Ya1B4cDM2Yy94TlJ4K0F6M0VEbk1mL2VZeUFhclN4RXVQZyt4cnNq?=
 =?utf-8?B?cnZtMWdrakZMV1Irb3hIQmNwaDJaZ1dEUWlMTEtMcm1KWms3Y1o0NlRJMWlI?=
 =?utf-8?B?MlpRYTV0VFNNVzN3WjV2QWwra0RHSGp0OUtSTkR1SzQxMDdRZUUydWdpaU4z?=
 =?utf-8?B?c0VsNityREF5cnFOemNtQk1mNEpUM0ppbE12b0hGVDU0VFE5R0MwbEhoZmE5?=
 =?utf-8?B?TUxFRTJDN3Y3dUZVVmdDS25sanVaN2xaK0lEa2t3REpLaUEvOGFqTmJzMjlX?=
 =?utf-8?B?bDVIcVNETi9McFUwYy9qcDJNT1Jyb0lLUmM3aERKcTFQcUpZbWx6djRPd0FN?=
 =?utf-8?B?bUxxa0hiL1dzWVlZQUNaYXBzUS85b2dDU2M2RllJSWd4MTk3U1B6K3RROW0v?=
 =?utf-8?B?NVA3bkdjVGF4OFowTGY5cTJrR1hvRngxWU5SR05qVkFqbEU5SUw3bDNXZVFa?=
 =?utf-8?B?UzF4QUdEb1g4Z0ppMkJYajFhN2V1QXZzQzJLTThYeXhyQmpGMVRnSU1DRTVu?=
 =?utf-8?B?WnRjRzZJbzBDQjk2dzVWVHM5T092SlNVM3Z5THNPOUtNdjZPSmJiSnNBVFFY?=
 =?utf-8?B?cFdEODR3UFdDakpOenFzSHp3ajBZRGhFQzBXc3hRYU9GQ1J3akdIaW9kM2VE?=
 =?utf-8?B?TE45WjdYdVRPYzR4a29FbmV4NDhROFlDMjR1U1VWYnVQRldSdXlyWC80a0Nj?=
 =?utf-8?B?VU81NExLNnJyNVRWS0tLRDhNaEdSdmJabnNxZ0lxcjBqT0Y1WXF2Q29LL0tv?=
 =?utf-8?B?S2JhMnVnTkFkaUY3OGlHc1RKS2xOSzZ1cHJwMXRpdWluUzJDc1FUR1hyY3o4?=
 =?utf-8?B?ZHlpa0dpWGJISElkYTZYZ3luMFphenhJYkFHd1RuOTJSOVJ5aVBMZm4rVEtX?=
 =?utf-8?B?OEZ2RE9jYU9qL2JGQTVJaHhRMDBsOEx3Tkh6V2FoS3Q5dmV4QlJGVXVyTjFx?=
 =?utf-8?B?aWlKRFB6b1dZN0xiV3U1N0szV05wRGt5RUt6VXJLb0gvaXBWNlZRUDZpNlc0?=
 =?utf-8?B?THE5UjNFd0tRMVZxa1Myb2pSMXVyM2s5eFBnMzJIcVFlTzRXZGxqUzFYQjNU?=
 =?utf-8?B?eDVCa3lzVlE2cTBjT3VuNERiQkpFKzhWMFc2Nnk1VkVrcXpjUkg4SkJvNC8y?=
 =?utf-8?B?eEViZnpra3loWFppaExsVExmRFkremcyZkpyT1MwVCtYZjR0eXA1K1cvZnlW?=
 =?utf-8?B?VjcxNUZJc2pQQXN3UzlISklLOEpzUld0cHJvcU1jRS9iMDRGZXBTaUJnQ3du?=
 =?utf-8?B?ai9rQVBYUXRBWXIvUnFGVFljVHhKcHV1ZVhOQ01GLzRyQlMzc05jaWMxTFdJ?=
 =?utf-8?B?R0M3azVZQ29QQjdFNVJKNHMvNEhJZ1BRLzI3eG1aVGFwV084ckJMVkQ4dzd3?=
 =?utf-8?B?RWFQUmdUZTR1R0d6MVRwU1dBUnQvSjNtRHBLZ0J1OU96TzVMWHVNRDdCcFFi?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd91fe60-acf3-47a3-f174-08dd4ffe904a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 09:28:12.1626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pRHYjtZB3KK/g/RsL9vGGX2k71+vlI6gAM88IEKG7/fp5n+NQgU8HzlGkPQRBdoy3TrjzyEqX2CMQq8y+wFVWQ6oRBvI5VShWwPTF+udmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6567
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

On 02/12/2024 10:35, Anatoly Burakov wrote:
> Support for `--noiommu-mode` flag was added, but documentation for it was
> not. Add documentation for the flag.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   doc/guides/tools/devbind.rst | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/doc/guides/tools/devbind.rst b/doc/guides/tools/devbind.rst
> index 841615570f..e010d4b7df 100644
> --- a/doc/guides/tools/devbind.rst
> +++ b/doc/guides/tools/devbind.rst
> @@ -62,6 +62,11 @@ OPTIONS
>         Use this flag to change ownership to the specified user and group, so that
>         devices bound to VFIO would be usable by unprivileged users.
>   
> +* ``--noiommu-mode``
> +
> +      When using vfio-pci driver on a system with no IOMMU, this flag should be used to
> +      enable unsafe no-IOMMU mode for vfio-pci driver.
> +
>   
>   .. warning::
>   

Ping.

-- 
Thanks,
Anatoly
