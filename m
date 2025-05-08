Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275C0C3ABC0
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 11:29:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C229A40677;
	Thu,  8 May 2025 13:28:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id EE7834026C
 for <dev@dpdk.org>; Thu,  8 May 2025 13:28:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746703736; x=1778239736;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ea4sJIciNq0Gp5bf+4nQk5iTRQPUr3vvo6y5nGA497M=;
 b=ASlKK4UXyFEx6/yUcvDfVhdtCKWTG7RTcAPzGd01fFslpZIc0QUQnP9y
 akNatt/POq/6amUJ0Q8PCyLTZLbvlCXXQzpm6YEnJjpPH2ZBwnkw8vMQ8
 0hdciL0kCgnlkk723ArhV9650YacHWdjYkAAGoJnnWO+lTikQFpKtM0pT
 x4EX0QBSt4EduHjBEXeNKDjaDHiePKlP25tsiM5dU8BYT7/DOtuYC1/7p
 76ZxO5ShPrz77HbUs4roGuCSOY0EgKYlqpSRU2kH3gq0R5pwqA6Of0Ee5
 xd/xH7zhiP/L05xfHmJO15jwAYJI/4XHdySHO9gsSIm379bwGfges36+h A==;
X-CSE-ConnectionGUID: C7hdUXDsQ/iEokYt/n8ZYA==
X-CSE-MsgGUID: Kwk29SBkSDaFnOKyGmu4bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59141659"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="59141659"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:28:54 -0700
X-CSE-ConnectionGUID: PLBs/wjmSoqSSVj6gkxdlA==
X-CSE-MsgGUID: rcHAJjm5QTqc4SU/2CO9VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="136783135"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:28:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 04:28:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 04:28:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 04:28:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvrJKKpJbpIzuJH4deCsILHBntnGYTOBiRVJQyypOyzGjEmcgPla7v76Hrq0eEZO5gGOjlbu7hmJdsWib2+1Ic9os9KPwabAZ3zzYLzcHZMVWbbVG2oUyKljtKANNEFmuSxlxdgPiYuKm/wOLuExADLN4MnUs8BBBz1TBOZ6U8om46ms7I3uUY0o1ZsHTwBids/N6oS5NmcaujH7sfaNov7ZcdAimYBFM27wMeLBrDJsqtNT/oiChmBMp4LfQcnLTiO+VaSUwXwnTWpYip8xinbWW5eGCGNJJsNC8FSI1BD3iR8cje2E2MCJocwGjKjhVa7+nH69UCFbckQ8rCf+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHzGobJgolycppg3Ds0zLIyUX8ujsHGE6bvQh7L4DwY=;
 b=R54k8DpPK6HLR9CUvOamhtfgIr6VVRe9u/jU420j+DXYhVaX56gD0dcLT63PhRlooMdhY4yu7kh5DA2tT/J8GzHeEdPvdVCo+md/5hi71vpx/pwYxTe9YQsb4XtIVDNscunQMsHNY0y1bUsV+4t8SUqUFPjWvZ2D7n4RqGFFFwC9/YubKZnl3JKMHfXHZ4cVCw5C7ujLzVyCEURCKuLDz6jpKDlJWK5fP0dIO63oRq3YAipXs04PBSg45rUFLsRNGCmknshEsQN7xSXKiL5bUk2g2bSp6h1xD6jOzBbppQMVsg2laclxfUEe+zC0j0JYwbdI3NUvutTc5dCc20l04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 LV2PR11MB6072.namprd11.prod.outlook.com (2603:10b6:408:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 11:28:05 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Thu, 8 May 2025
 11:28:05 +0000
Message-ID: <be4ff15c-46d5-4cc8-92d7-cdbf4940b90d@intel.com>
Date: Thu, 8 May 2025 13:27:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] bus/pci/bsd: Fix device existence check
To: Jake Freeland <jfree@FreeBSD.org>, Chenbo Xia <chenbox@nvidia.com>, "Nipun
 Gupta" <nipun.gupta@amd.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20250506174046.1136711-1-jfree@FreeBSD.org>
 <20250506174046.1136711-5-jfree@FreeBSD.org>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250506174046.1136711-5-jfree@FreeBSD.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0025.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::32) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|LV2PR11MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 3267e4da-9aa9-48e9-fb0a-08dd8e2366a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzBRTzBHQXREVXFnZDEwb1VLT29sNmJhbldlVVpmU0tkdlNvQlhrYVZ3aThG?=
 =?utf-8?B?dW9UMmQvS1MvK1VJTXlqY3l2TVExb3pFaVVVd3NKYVlCcFpSdFlhMG1tdTds?=
 =?utf-8?B?RDdIOEJ5OTRveHNBU3Z0OFRrQyt1NGp6Q3VjYzNBcnpjMmNGQitaK0NPaTRa?=
 =?utf-8?B?eFBZMXlTTnZYWHFPUjRYbmRWeUNYdHB4OUxKQ2J6bVVjRk1ZSGlsbTB4WU5S?=
 =?utf-8?B?eG0vOFpDWnFZaWNPc0dTNytqQTVVSDN6aWovTUU4OGJVZkg4ekM1VndyNHkr?=
 =?utf-8?B?cGlHSXlUU0VKWnZJVmJZRXVIdmdGZUs3TE82VXU0LzR2bzF6L3YxRklBWGRm?=
 =?utf-8?B?c1p6ejFXbHVCUW53NnZ4eWMxcmMzTy9vQmIzMFRhK3NoMVB1MlNvbkdCMkph?=
 =?utf-8?B?WDEvYWg4VDNOVDlWM3ZLYTdqZnlJMTB2OFIxYzVkRTdaZG9LWGVjZEFtR29T?=
 =?utf-8?B?T3hleGk0bHhVMFVWNmVqRzEzSWJ2R2hsb1pGYTBOM3JKOGdaakp1aHdva1pY?=
 =?utf-8?B?a3h0L1BST0dSNjVGMnRwckI5UDgvVk5BMVFjUUY3aEpXM2ZLeEJSbUV5WnhK?=
 =?utf-8?B?R2hjakR3OEFDN2RlVXYwWk1NRnkxOXdHbEc1bXZEYjBvWW9vY05NQkZoYTRB?=
 =?utf-8?B?ckFvd295Qmt0ZGlCZWVyUHRuQndxVnBCWlhGclhkRXYwK2x4UGtnMi9FR2Y5?=
 =?utf-8?B?V0FnL1FXLy9XMTVHUkFqZXArNENNZjJobXB4OUEvWGcyQzBCUktTSUluRzUx?=
 =?utf-8?B?R2EwN2s5eEIyb1o5ZkZLME50RVg2RmFnakhGY01RckozdW51TmdlSnRicjVi?=
 =?utf-8?B?cVphZzlJbG44U3R2dWdEd1Y1MWtOaTVrbnZuYVlCK3RiNk1SS1A2TmgvamRz?=
 =?utf-8?B?QlRPUzIra3YvazVPUnVoaFN3WDkzdlR5dVZhVDJLTW9ycmhaVkJpbnVQS0JC?=
 =?utf-8?B?Q0F0ZlRwQ01pNGQvOHJrd2V0a2F1N2EwODMwbjJ6OENVU2dLZW14NDNtZnBq?=
 =?utf-8?B?Q2NDSWU0RHJqOWthLytrM1VCZG5tTG5ERWZrT1pwRlVRSyt0dXdJN1RodHZG?=
 =?utf-8?B?TXllVzFyMU5ZZ0p6VzNRV2xGRThTbGlFNWd5VlZzN2VHSGR2KzNLVDFWT2pu?=
 =?utf-8?B?UDMvMXVpY2JSZldCcThyemNVNGROUlZNNzF0RHViaUhZVTRHVU5IQURZZHRE?=
 =?utf-8?B?UGtqalpLcnorcTJOcStMRlAxbDFuK0hYZFBPdzcyRlJJS2o4cEdQbE8zOGM3?=
 =?utf-8?B?d3BoSEk3ZlpyeWdXMTdRQTR6TEhlWnNVdWtGWU1PSW5VREh5ZW4xMmpZR1FU?=
 =?utf-8?B?dUtBN0JXcTh4MjcvS1lwamR4cmhubXA1QkJOcGNleFhwakU0ZzJHZUpsKzlS?=
 =?utf-8?B?eWtpVW1VcHcwWUxyeGh0VjhCdnp1clpjaUlXSldSRmVCeVo0V3dLRHp6V1pv?=
 =?utf-8?B?ejNsYkhnbGcyL0lqQzF1NDgwVnNwZXBlUFBZNGlMUS85dmNSTFFhb2N6bUxo?=
 =?utf-8?B?VVo2MXgyTUV2MzVOamR1bHdZajE3Zk4wbDNaMk1PMXVNWEV3eS9ZSlk4UzZ3?=
 =?utf-8?B?L3lnU2RHcWdzOE5sMzBRd1F4K1VKMXkrcExIbVhaMlpRUThYSWhqeG1Oakt5?=
 =?utf-8?B?QU96M3RocE15eHBHUzJTSkR2b3Exay9PWVB5TC9UUVZhSjI5RVhnSVRYSEVj?=
 =?utf-8?B?SVhFSDE1L045aXErMm45TTJPeE1NdWk5VmFPZGdWS1gxUWVwUkEwWDRGbE1r?=
 =?utf-8?B?K0ZDWnV6elNvc2g5a2cwcXByMWxWUDV4N0JwSGlxRUxTUUlyZzZOcXhQSGhl?=
 =?utf-8?B?K01MVytSZloyWVBFNDlsVmJ5dmhrVUF0cUF4QkpkVjhiL2c0enc0R1Q0bW9i?=
 =?utf-8?B?ZkRzOE5UOHgrOW9yOFAwUjRIdUJ3RW9LTnZmWlFDUzczb0lvTWtvbkFmV055?=
 =?utf-8?Q?UfcemM5vUMI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NitUN3dZNkZIR05GMnM4KzQ5MUR3VFg4alBtMmhNblE4YUNTR0hJRTdCL081?=
 =?utf-8?B?VUZHV0UrVndseEgydHZtYXdHSXBQWEl5ZlRVQW9lQ2VHV3FjcFUxM3RZd1A0?=
 =?utf-8?B?SnFSdDVzTGllN25OdWhsaHF1RUFlM2UvOTdwelAzYzRINWhHZlRvbnZzQUpz?=
 =?utf-8?B?UklwcFpnUXlGalZ5Qjg5bVBoeEliWm9YdVBZUkRkc3c2bzFMWm9pc2ZZaENo?=
 =?utf-8?B?MndJTHl2NzBBdE5qVzlPSmxLdlk4WnVOOTliUkdpQTgwbVNuT1pRbXdEMFhy?=
 =?utf-8?B?VzJHdldZR2hUUHBkaHdLZ3FKUTkzMlBqMDVSMGZkR2lvY2lsR2NaRHlmTnRC?=
 =?utf-8?B?KzNMK3h4eEFSZW8yVTJteEVVME1ydGFaM2tjSmw1a1F5eUFPZ1p6dTBGb0d2?=
 =?utf-8?B?ekJTMHg3UFhOaEFhWElPWmhoUXdvVDV1cTNFUUliVnRUQURvVjAzbGxIVHNm?=
 =?utf-8?B?cy9rOHZkcCtrWGI1enV2SDJGMys0RkVmdXZISkw0dy9yWHJFMDEvVGJrbDBp?=
 =?utf-8?B?aEh5WUgvSlFqWmgzTFdNRFk5eTZmMm5nVXN2WUJFcmpOSlVwQWFuMytmYk5P?=
 =?utf-8?B?NHhqdW9sb1dXbjl6UkFKVUViMFNkcDUwSGRtemNMZ2QyMS9BTk5mSlp2RlhU?=
 =?utf-8?B?Vm5IT2Y1eSs0a2pmSUxEdldJb2R0cjB2K2pRenBhSW5hRWw1UUlxQzN6emk0?=
 =?utf-8?B?L0l3QzV5WWhTN0ZNNWtiQXI0d1VlVEErL29qMXVPUXhCYlNMcGRxT0hnNmRS?=
 =?utf-8?B?em1YSVRMOGtzc3lsWTNrZmtWbHlrZStJa3kvR2tPNlpidFpucVBIbnBaSW1S?=
 =?utf-8?B?QjdWbW05Y2kwR08xaU1XYkFsVVZsMnluTFl2dlcxRTRZWGRpWC9EcklRSHBt?=
 =?utf-8?B?UW5qSWxlRGxlTEc0bHQvWXRDK204elNQcHpieHdQZ0RqTlVXakl2UGd5OXZI?=
 =?utf-8?B?RjZkWWZMUURsZGRtaTFPNzRHVGVXc2w1d0VUZmluaDRkaVVvTmltb0I5a1Zw?=
 =?utf-8?B?Rngya3c5QVEyVmFuakQ4Rjc0eDByRXNvbVhhTGQ0N0Z5REFSbFBFRU1CVmFy?=
 =?utf-8?B?V3NaNS83dEFDRVhQOXYvQVhINm9naHdPVkVCRVZGcVJVenFJQkI2ajFoY2cw?=
 =?utf-8?B?MFduNkFnalBhSXkweFl2aE1pb0JoeE5aTmZJend1UUxOTU5ZMUJtbmVLOGNv?=
 =?utf-8?B?VGZvQ0ZZRnhjWXV4ZU05dTVjUXNhL3oyLzFjUmZCdXQxb2Q1THJaQll4QmF5?=
 =?utf-8?B?Z0syczVndXh3RWNhaDFUY0pPMmxTM0JNNTVxSkx4QXcrMjlVdFpYQ094aHNl?=
 =?utf-8?B?M25kRjVCbzVZditmZW1PZ0pkUFdTeUh1RGdwUVlPazNDRlA1ZlFHbG9TNktS?=
 =?utf-8?B?TmVnU3ZuSFBMYzNrYUxieHkydWhMbXl2NTdZL0kvT0VpamJvYmk3QUxHTWlq?=
 =?utf-8?B?dEVOU0xHdytFSWx3MGkwRnhzM3ZXaHFNRnp6UnEwTkFtWjhhekFWWEoxRFhN?=
 =?utf-8?B?RmpYTWRQSS9RQVhtVlBpcU1NWml2MmxLdXk4OTQ3Qk9WUzNvek9GRFI1d2k1?=
 =?utf-8?B?SnpFVzZIK284RzJ0ZlZkY1lCY0dubXZuWk1hOG5aTDZzeW5Ncm9lRGQ1WWs1?=
 =?utf-8?B?ZExEdERSNEd2d3VXRjBHOVJDZnowRFlJMlJqKzFGQVNWTDRrSXNmSU16bHFh?=
 =?utf-8?B?Y3J3M2JOajB1dmNSMndJQ09CQWVDMFQ3ZTEzSjhBaFZjaS92OXZCa2NkMDg2?=
 =?utf-8?B?ei9DYUFEaFhBT0VCMHM4MEI3NnFsVzVtWnFmRjZDUmFzdzMxTUhhVG0rczl6?=
 =?utf-8?B?V3kyc3Myenc0NnJsdlIwYnRvYVowa2hRMDFFZ2F6aGUxc3Fsd1VGa0JJaWFE?=
 =?utf-8?B?WEN4UlZBQzdDR0loVGtySnFaOTduSnVnMUx5RWFTQXBEVGlKcUN5Vm1uS2Yz?=
 =?utf-8?B?TnVvaXJkd2tFd05yWFNGYVpCaEpYeisrZExSZFl0bWR6RThKNjFLVmd2UFFy?=
 =?utf-8?B?dUdmN3lTSnJCRFZkK3VpQUNJL0lvMkFlQ0Y0YlREanFCSzdNOVR4dG1XNS9s?=
 =?utf-8?B?MlZ5RWYyR2JORmRRVjhTSFdDVzE4c0UwZlJVeWlKUlI5L2dzT1BCVXBTUW1P?=
 =?utf-8?B?cTJvU1FOUHJ0azNPM1M5K0JES3p2NXVIQUYwMDdDVjdINjZqblhLWG9QUklN?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3267e4da-9aa9-48e9-fb0a-08dd8e2366a3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 11:28:05.6062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VICsZutCCuX+X1xheg2ea0OpV3x5M3vYcAuD1/zAW4FEQZVoQe6HRXuAI+f+nI3pIin5S9WwsN5DiigTfPatDqrna02DxBxk/DixpKn8txc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6072
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

On 5/6/2025 7:40 PM, Jake Freeland wrote:
> Use open(2) instead of access(2) to check for the existence of the target
> device. This avoids a possible race condition where the the device file is
> removed after a successful call to access(2) but before open(2).
> 
> This also fixes any potential bugs associated with passing open(2)-style
> flags into access(2). i.e. access(2) does not formally support the O_RDWR
> flag.
> 
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> ---

It's odd that static analysis didn't flag this, as that's the kind of 
thing it would normally complain about.

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
