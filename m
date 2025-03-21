Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2DBC36002
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 17:15:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CC3B40276;
	Fri, 21 Mar 2025 18:15:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 24E2E40156;
 Fri, 21 Mar 2025 18:15:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742577357; x=1774113357;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ARZLJWIvT3EGxAoKU4CRiG8M6pXknxTcAJTxqey6lQg=;
 b=EKltGnROOoGo4o6x7Xyo3B6MgPHg9tUmxHD65RUk2mmmHIg9IkQuY49I
 Dyk666prXB9cjcsHD5pT10dJHKM+lIE4m5Xa6xKV7f7zYHdoTJ4Utcojs
 lZFQpy+tPLE8VKFhKLN4Fen1sEKRtMsBUv4fjt6US2N77xmuIhNUtA4e6
 z/5AH9QY0xfisE/mOU2yZMkiaImT1+UkYzggAt46QcP0mQoIRRPhlAksd
 saRpRx45M+tvX7BKNj02MsSj5pgGObN9vVbKHkoqdWHg1sMP9Csq4DgKH
 tHD18l/MgAYh4zH82lh9RMxqqQUvm8Gnj+g5Aud5xUAS7eSncyNxGahXP g==;
X-CSE-ConnectionGUID: 49i5CxrPTwOyFCnJwrlp2w==
X-CSE-MsgGUID: uzrvV6+NSzyowbe/ROmB2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43015460"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; d="scan'208";a="43015460"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 10:15:52 -0700
X-CSE-ConnectionGUID: 2VrXlAZyS8Oqrxj+uiKNbg==
X-CSE-MsgGUID: TBmGyqQ9T8eaHztP/ZhMOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; d="scan'208";a="128286520"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 10:15:52 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 21 Mar 2025 10:15:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 21 Mar 2025 10:15:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 10:15:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmks6B7cv8rdxrGv1VXT21yeTmv+8kYyIxC/T0fPusdLKGj5uw6iKVEk+uuagDEd2wmtY9ip/zx+141AHyNA23bj1sbKCCNe6FtVLsFxpEyz7DxFU1snSSsg9pZUmU3s82Kh8h5AaUHrDxyjQaVavTvjPr8KNcbTEkheqsbJ9t4EPRF6Uiuxct+5uk8o0UwfsB4kcjsIFcSEmQkOBQiiYARRco/kb7I31dzVLdcud/MTJEVTk+2gquKbvF9kMrTcxUZrrvpToYrGbOe6MnqPnpyCITqwtOgmsexwLyuZ0MW4o4EpfzBX3bNGuZm7VMunMCol7U3lHUz8VPYOU5wLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0cqtdF+2QKWmAzs7KFOPuzqW9tN+kpjWiWjJO5uiH8=;
 b=ABVgXb4MCx96+K+WLpyE6L8fw/o8Cmg/7gjAx7FFzYvKudt+9fuxFFagTikqA8vkicKjOIzb3DHeqAFsRdZFtNfbSdrgmGDi0PWIPWGfFVKBSLxvH1+nIQhjSODoe6iPn8FezZ/5w9Yqh8BH3deypwPeUJIltzAnSXiklRxbpnURIs2OVzl3TjnY4a2beM5R7HG2jbHi1rS/bNgbEnJQPUo8StHd5xpN4UoPPbeat1p+eXA+Sg/VyS7GNOaX6mp1GD9QG0b/D8UdLVA5buDcW3oCWh6SfhDat198z0KGrRofSJAQ+dmm+joBRgRs9WVLGUGZ1ylb7h5M2YjftrK7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8)
 by DS0PR11MB8688.namprd11.prod.outlook.com (2603:10b6:8:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 17:15:46 +0000
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b]) by SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b%5]) with mapi id 15.20.8511.031; Fri, 21 Mar 2025
 17:15:46 +0000
Message-ID: <a8d5bb3e-4a16-415f-8fda-6251d5101ec4@intel.com>
Date: Fri, 21 Mar 2025 17:15:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ixgbe: fix missing checks for E610 VFs
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>
References: <20250321171211.386594-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250321171211.386594-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0258.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::18) To SJ0PR11MB5772.namprd11.prod.outlook.com
 (2603:10b6:a03:422::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_|DS0PR11MB8688:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f4acad-9d78-4e0e-eb4c-08dd689c04db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXJCdFNlK3Q1clNYa3d2Tm56UVJBZFovVmpONmFRNVhISENXOTJ4cURic0Rp?=
 =?utf-8?B?SEJYdURjTHVFQUlVNmRUWjJod2xIcHgva0c1VHRrSUpONTlaZkZuTWVuYkpI?=
 =?utf-8?B?TGdjZUIyVzB5UUtZSEo5Z2diVElEcGErb1Jvblp2SGE1aDk4MWFGTTJ6cGxS?=
 =?utf-8?B?ZTdWREN3anZmc3RsY1JoOXhCOVhGQ3VObk1ieE00cHJPUXRSSnVuVVZmZlFV?=
 =?utf-8?B?ejU5Q1RNcm1VUG05aDF3M3Z1cFVHakUyQTdDd0NYMDVtSXlnL3ZRbS9mQ0xk?=
 =?utf-8?B?R0xiSFVoOHRaZTdQNmRzSGpFV0JLeXl2dHU2NVdsMW9BSFRlZWJDYzlHRzBk?=
 =?utf-8?B?bW5RN2J4alFwY0M1cmczdVhNbkViVFlxTkxSME8vem9LL3U5QnphZmZTWGdn?=
 =?utf-8?B?c0k4clp4U2VSb0RxeXNYN25URlZUYVpDZEJYL1ZHZUljeGdJRTUwcmdHOU1L?=
 =?utf-8?B?SWVEcXljWm14Ly8xaUxjTFBtTFpoak5uSUpybEI4YzFwVFRHVnl5UmlHcmVH?=
 =?utf-8?B?RGFlc05MMjk3YXBVZHBjREpuc0MxdGRzYVoxeHVBaENNVlE4c3hDUmFnN1Jp?=
 =?utf-8?B?SHVkbDQ3QXdwK25uZDRsZ2l4c2hEcDN4YStkYUZYeFgrSDBTWE1XaWJQNGtR?=
 =?utf-8?B?cDY2aVVkeWMxbmJPbXlMV09NS05iclVkaEU4ejZpdFZjZFNoYlR0a0I5QVh2?=
 =?utf-8?B?ejFNUjJqWTNKSHpBMHNnR2o5MDhPOVZOeVdJWEFMcWZ5eDJjWlJOL3VwYXJO?=
 =?utf-8?B?dyt5bkxGU1RsZGZwQWtEaEpFUDRvZ2czNzBtZWMyOXJqNlloVWJOTnptcGl5?=
 =?utf-8?B?TGtVZUxDK0NVdy90S2pYdURVVnJUUFJMMjBxaUM5TGdydlFKNmduQmg4WjZp?=
 =?utf-8?B?dk9QM2VHeWpXWmVaWWYwdVRUZGFxSDJSNFIwNVA1QWRYeWZpQ0o5SWFMUVZN?=
 =?utf-8?B?cm02WDBJMUFkOVI0UXc3UFhxS3pzN2ZvNWhMWjdSMWJ0SjNaQUFnT1lJcjQx?=
 =?utf-8?B?ZHY4Yjg1Y2Rqa1FGV0JrNmZYTVY5aW9oSmdtM2VLZDQ0OGNRVkxvZW5FSjVy?=
 =?utf-8?B?NmxjZHk4NDZneVRHNWxmNTFrYTJLSkZ5QzF4R1lhaEFNNEZPK0ZlYzU5S1Az?=
 =?utf-8?B?djhFbWFLcnNLSGx2QzlXMk5QeUc3VGhkTVhxTjRYTHJXNkJzQ0NmNDBhTWJ6?=
 =?utf-8?B?dnZqSkU0RW8rWDNFY1pjbFVwa0ZGdGpxQTY4ZmtGYWczZHJ3Mmc5a1pPWGRo?=
 =?utf-8?B?VjNGUkIvK3JnYVV3NzRia2hFY2tYc0t3OHZsYk5LTFFSTHo1U1lmUUZTZHF3?=
 =?utf-8?B?elBYcnY5UXJ2b1Z4enVock9rZ0RScHF0a1JramZUbk1kVlczb0xOdTZPR2NH?=
 =?utf-8?B?ZHFqa1VPWVpnV1JITytFM1VRZERuMUQ5YW91WHpCU2JJQUI5UFUzcnBud1pW?=
 =?utf-8?B?aTVFS1prN3BKdTJmSm1qcGdFS2lmTnFJN2F1SjBGSXM2UElCNFZnS1pvbUJL?=
 =?utf-8?B?aXE2NFMvVEx1b0crTUFpQ1hydnhpeUtKWC9LV0RHL0N5S216SUJQK1hZWmhp?=
 =?utf-8?B?S1FibFlwNG1qMGpVSXoybTd4dW03YXNSWjRodFlOTjlJbWt1NmFkVVh4Zi9C?=
 =?utf-8?B?b2pCQVJ5TFBjSnF3MmpXTnlLUnBjbWJrazRnUjlkWExBbllCYXRtK3RSNlht?=
 =?utf-8?B?ZitCOUR0a2hWUUFOOEx0N1I2akt5Umx1Zm1DY0NzQnBDc0N3NG12eXB6dnU2?=
 =?utf-8?B?dFlGdzVUVTg1WElIUzZHQkdObXlsMUcwMkFtOE5OL3o1aS9jeVI3c3VvbTVO?=
 =?utf-8?B?aTMycmV1WkE4K3lkMmNXU3hXNmp4dE1vdlk4NXJuWm5BNG84SUJQRjZPZTRh?=
 =?utf-8?Q?eldhdEvUpZAiz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5772.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHNyby9MV0l3ZEwyOWZXNVEvS0R3NzBnb3lEeEJXek4zU1BuNlhRNXE1azRy?=
 =?utf-8?B?blYwQWd5QzlXenQ4SlFlelhhMUxBSFJzMlpxbndzdmhnaUQ3b252WWRIdW5M?=
 =?utf-8?B?OGxqQjQ0b2FaVTMxVGJIOEJEd3JvUUd0by9jcDBSQkxwOUU5bVZKWXlLYVNF?=
 =?utf-8?B?dzNFYjhaeGp0YmJ4QURDYVhhTWdnSW1kQkkrRk1ZdmVxcGZFMXZrYzBUcVpT?=
 =?utf-8?B?eDB1L1VrTGZNeE5IMEtoZFlnRkRIOElpMlJZVURhNUYzdW5DMVZXQVRSY3d2?=
 =?utf-8?B?bjMwNk1VTUJYRFV5VEZxdHV2SmFpNU5lbFhKQUVyRHFONVVmUkJTcGRXL3g2?=
 =?utf-8?B?NWtpV2lEUFgxbVlUVm51SnFHQ25NaVRrOWFZMTkvZnl1TlpIeUxpcTRVYkRs?=
 =?utf-8?B?YkZBZy84MFJyaTZiTDdyNmtwSGtuUGtVY203SjdVN045L281bHcwMkN3YU9h?=
 =?utf-8?B?V3dJVTFLaUpkOE9YRWFUaWVnQVBmNmVFZzZkV2pwV0tqaGhPaDBveDZFczUr?=
 =?utf-8?B?SkRhdnBXaGFNQ3NnSWwralkyUUg5d0syZW1MNURITVoxdGlRd2hrZGJ3WVVz?=
 =?utf-8?B?eHBPT3dHL0ZKNEJoRWNRVndiOXlHR1dNT2NhTk4reTlhSEZoODcvWERYeGlF?=
 =?utf-8?B?dFgwb2xkb3lIUTZDTVRycW4rOHl3RjdackV6T0RQQWtuaE9EQTlrQU5kYmwx?=
 =?utf-8?B?TThsMXIzamJKRVFJelBGeGI2OEViZ3E0aTVrRWxkQXBSUGZkVkdWVG1zNzU1?=
 =?utf-8?B?QklJSzZha09wbjdaQ0I0QTlPR3pkYWdVUE5Mak53SWJncjIxK1BUamFUWVRu?=
 =?utf-8?B?Rkc1VG1RRDZpUjdodThxUVBqUW1SaXNqSnZwTzEwbkZRM0plTlZHUHJCZDlV?=
 =?utf-8?B?eTVaM3FSdWhySnc2d0Rtbi9nd1JWQ1E2MnFlY0lXSnVuVlErdVE4OU94aHBX?=
 =?utf-8?B?clJRQS9WYk9SeWxVRmI4YXNta1BlWEx3cHd3SHpTUjQxLzhzNGsyUHdxWFhw?=
 =?utf-8?B?ckdaMFNhK3A3UmFuaTJoRC8yMWd3Z0c0OGpHYWJlN3hWSEpNUE54YStCcVlw?=
 =?utf-8?B?dkczMFYwVXd5RDRDRkJKK1Y5NDIvaVJXdFl2dk44N0JyUXJWZE9RWVovN2ps?=
 =?utf-8?B?MWFnNGttbVVlRU5OZTRLdVE0RWlJV1E3UGdlb2JOZFlGd2VFSVlHRGRjYU9a?=
 =?utf-8?B?bHJUNUc3TSttOVV0TUlWL0F5QUJaTUNkNC9IRE1waDdqTnlGNVVRa0hVSDds?=
 =?utf-8?B?WFFjY3UvTEozWm1IUGQvbDRTYlYrYVpsZGlMUVBrL045dmxsYlFmekVCZjdh?=
 =?utf-8?B?cHVCejh4UElTYlM5S2VlMG04U0grd0Y5ZVdvTDduUWhqdjFIZldXUy9RUjB2?=
 =?utf-8?B?clNnTjVhNk84ZW40bVByZjVDTDVMRUVLRDdnSHZuemQycDdHb2hLd1ZndUFm?=
 =?utf-8?B?bk1WNDR5cnNlUU5RZVcrSit6WkhodTRuV0UvWHBEZGNMeHFGaUo3dVBIdHNS?=
 =?utf-8?B?UmdrN1VWc0x3bUF6NmorM0I5NkRxN1FNOEI1TmVqQzFzV2NhZFY5aFZZREo4?=
 =?utf-8?B?ejRXaWZYeXBsNktDS1VTTlZsVzZyNmI4WGVaU0pqbkJNcmVhMGg2UmhQN0lx?=
 =?utf-8?B?WlN2eWg4YnFoekx1aWdhOUNBT0ZORU9pUVdYYm11Yi9Ca0xrWlYrUm9jL215?=
 =?utf-8?B?ZkgyY0cyaUFKNkJ0UzZMazRhUDFuRGNGY2FmR21qejdlMFhVV3dpZDg2cHVa?=
 =?utf-8?B?d3JoVDQ0OHdJc1grMytOUW1JeGs0UlFVQVFXdGN5VkJNRHB3a2hUSitxbnFX?=
 =?utf-8?B?SXFKVnh1SDJKelJEVytxdjkxSTBndmpzTGRMMHhIQnV6UG9yZXNiR256T0w4?=
 =?utf-8?B?V0gvZWM3d1U5djRqMGo5di9iU1hxY3ZyL1RUaFMvR3RIM2d2Ylp5M0NuNElW?=
 =?utf-8?B?MTVjN2kzWDQrampuZnFiMnRFWTRjOGdOZmhxK0dKcnBxOEJSSHJoSGxVQ25a?=
 =?utf-8?B?b29ZbnJDbE54bFloN2hGOFBOeFdQSmRqbXh0eHVDTTkyOSs4RTI0Y2c1UkpP?=
 =?utf-8?B?OW9ROWZ1ZDc2TFMzT2E0U1MxajNhbTRRN3M3a3hjNzlyekJkZGFZQmNYNXdC?=
 =?utf-8?B?akdhcUVzSzZhdFFzSkk0U05KN1MybkZITGNPdkhTU1RxV2xRWE56d0YraGRz?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f4acad-9d78-4e0e-eb4c-08dd689c04db
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5772.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 17:15:46.4869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyM0OSqeG8grQluAC6MmKSD96BbdepaoWmUa8M7fvGbjkBNezlHEha/6s2a6wyEVBAytvWdlmjCwwK2M8zdtC1l7MPOlPa/ay3HqKyvtFkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8688
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 21/03/2025 17:12, Bruce Richardson wrote:
> A number of places in the ixgbe code check for a virtual function, but
> these checks were missing the identifier for the E610 VF. Add them into
> the conditionals.
>
> Fixes: f678f3dea8fd ("net/ixgbe: fix missing VF PCI ID")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/ixgbe/ixgbe_rxtx.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> index 3b7a6a6f0e..0c8a9ec763 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> @@ -2767,6 +2767,7 @@ ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
>   	 * Modification to set VFTDT for virtual function if vf is detected
>   	 */
>   	if (hw->mac.type == ixgbe_mac_82599_vf ||
> +	    hw->mac.type == ixgbe_mac_E610_vf ||
>   	    hw->mac.type == ixgbe_mac_X540_vf ||
>   	    hw->mac.type == ixgbe_mac_X550_vf ||
>   	    hw->mac.type == ixgbe_mac_X550EM_x_vf ||
> @@ -2987,6 +2988,7 @@ ixgbe_is_vf(struct rte_eth_dev *dev)
>   	case ixgbe_mac_X550_vf:
>   	case ixgbe_mac_X550EM_x_vf:
>   	case ixgbe_mac_X550EM_a_vf:
> +	case ixgbe_mac_E610_vf:
>   		return 1;
>   	default:
>   		return 0;
> @@ -3153,6 +3155,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
>   	 * Modified to setup VFRDT for Virtual Function
>   	 */
>   	if (hw->mac.type == ixgbe_mac_82599_vf ||
> +	    hw->mac.type == ixgbe_mac_E610_vf ||
>   	    hw->mac.type == ixgbe_mac_X540_vf ||
>   	    hw->mac.type == ixgbe_mac_X550_vf ||
>   	    hw->mac.type == ixgbe_mac_X550EM_x_vf ||
> @@ -5835,6 +5838,7 @@ ixgbevf_dev_rx_init(struct rte_eth_dev *dev)
>   	case ixgbe_mac_X550_vf:
>   	case ixgbe_mac_X550EM_x_vf:
>   	case ixgbe_mac_X550EM_a_vf:
> +	case ixgbe_mac_E610_vf:
>   		switch (dev->data->dev_conf.rxmode.mq_mode) {
>   		case RTE_ETH_MQ_RX_RSS:
>   		case RTE_ETH_MQ_RX_DCB_RSS:

-- 
Regards,
Vladimir

