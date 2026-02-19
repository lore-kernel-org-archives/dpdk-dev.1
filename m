Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC4DE9A048
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 13:07:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EABAC402C6;
	Thu, 19 Feb 2026 14:07:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 09D20402AA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 14:07:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771506450; x=1803042450;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4CuULPIxxyV0oQWdcwJQRFCWXkxgSaOWSfAiw8t4+KU=;
 b=GYOy+50jA/jRkBFb7dG8PQE+Mzfnc4O35uJ3VgBNnVm6IyIsw3tDKYCc
 kD2RFL/rSfG1IjkQouchxg0JbUz0fpCAvVl3glfoD9aOF7qMU/P65WM48
 8xE7fctq2KsHpyEzTb7FKOUvZ9vP2VwRyBD273XUEAJpf/Yd4EjkliyXr
 XUNcd122lW36BYSzXTB85dTAOE1fsMYLypMah9ut+rs+hRp5oTpxIlBaH
 t1g7fxWjRz/+C7o+O5KH3njk8UzYFGbAIWgW3luQSOU8JTzYb7SEcB6M4
 sZz6s0WNEdUBne8/40eJLUDikaHF3Dc+o9rt0w782tkhFJBo9jDEKPfWS Q==;
X-CSE-ConnectionGUID: J7q1Y6u9TbCSdbDHqYvOyg==
X-CSE-MsgGUID: J+VWDca8Q96VUJkGHJiKAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72629810"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="72629810"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 05:07:29 -0800
X-CSE-ConnectionGUID: DqWv2qehQeazyk45Ifh9BA==
X-CSE-MsgGUID: 2UmjK3pfQRqemdiQlFz3/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="237500515"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 05:07:29 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 05:07:28 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 05:07:28 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 05:07:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kd1bh6//XCCjF0XHD5J+3OCfiijJCvoPhPo7VcX6248HDR2ezLeSqgcwSxt8ZruvyzGjamM9rs5z099LLKmAtZw61/Gq0gYf+1DFgE3S9VXh7DUvVCAU3SHTVYBeb4NUollx1Q0R+RNofwRVK9/WpMQBAeqGTOJoKeD5TlWkd4l2ZBct1Mf46y4iq8KF0vwnXoaHaau85w9NRJZz0z/CDMVbbsPGXpQWiHI9KwqW9owF8v5fDkZ9E+pnFV7B3WrFgxjW1fqfH2nrbJKHWUZJGIbn87FV41lWuI7UloaH/1CxLG3Bu+v2mUow13eHI/L+JJbts9diblLRYNLYCC2zWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJM0tE7Lubli2YLbo/S5ZCIhVogqByUh8ST3izGs4Uw=;
 b=sfvgE3wdhrKrzRsOao0n+adsVvgJ6dlLqp2IwcOqjaPFMeNEV+nMlOYWuXM+wtg7br0VFvbtMr/R52ZXwBmcYqe3GBHF6E/+08Svasa9e+Uzp750z7n/ok0l62fViGqxRnkWop+ZrfcSkVakJEstlRqgIGy5tMmdbgE3fnmpust81vHsURXXS/3cUgVrW13li/+dZE990udlvDRKjn1OiZcNvHR/GBGNzJJqMZj8zbM2NwKbFy/tTeoUqN+bXWz6PmbgxHiR5F4BdaRzCj2wrWh9sQ5cf8oy/VlP53KXu4jWg/AnBM9A6Kc0mz1988iGBChiufZ+gilHGskmFwoyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA1PR11MB8394.namprd11.prod.outlook.com (2603:10b6:806:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 13:07:25 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 13:07:25 +0000
Message-ID: <33e11563-dc9b-423f-addc-e400d51cfc2c@intel.com>
Date: Thu, 19 Feb 2026 14:07:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/27] net/ice: avoid rte malloc in flow pattern match
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <cede863bb4f30cec73029f5aa60ed5b09f8f3976.1770978324.git.anatoly.burakov@intel.com>
 <aZNV4WRmz51Ojhzs@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aZNV4WRmz51Ojhzs@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::31) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA1PR11MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: 950976b2-9293-4d90-9ff1-08de6fb7d38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUsyNDIwdG40aURyRThpV0sxOUxTMGdXNEVRSlNoT3NMQUFsWm5TZmp1cHpS?=
 =?utf-8?B?M0FuVFlNMllvc0NhMGVmS2FJcUlWS0xnWFZvY201YnFsRUd4cWZ5Z2NBU1Nx?=
 =?utf-8?B?WTJTMDQ0UWZFa1VubkR4dFg4ZmVySW1xenJTOUxKZGJXY1BQT0Z3aW5YZ04x?=
 =?utf-8?B?NkVDR2tOT1ZVaS9qVDJDUFg4ODRRdUVFRm1qYmZqMDVEWGpiTVlxdHFpNHJJ?=
 =?utf-8?B?TFo1c2o0bzBRN3ZMUE9NTXNhT2RTbTg1M0RodGhZc2pRRVNmY1NBRUlVbmJ6?=
 =?utf-8?B?cjBiOXM2RWF4MTZBZWVUL2RHc1VUZ2VTWTgrN2pMdjhQOWdRajdLV1ZQVVE4?=
 =?utf-8?B?UW1UUVQ4SW5OeWwxcnpYSEV3RTdSSkJnaGZ5VnhTSXpoY2tGL05QZDRxN0kv?=
 =?utf-8?B?SWtwL0xCYTd0NFJnNFdWM3UzK1RoU0Z4dGV5M09MejBiVGgrTy8yM3dFd1VV?=
 =?utf-8?B?QUZlUmxtMTN0czY3Sk9hUWhFQ1BxZ0l3NnFac0p4K1Z0MUF4WHFKUmExR01E?=
 =?utf-8?B?Z1hoNzNHOXZxTXVGcHYvblhyczcvdEZwTkVhTWNwL2dFWFlUZ1REQkNZWGFj?=
 =?utf-8?B?WlZ6MnFudjRFNHJBVzdwYk1HaE94ckVGejZVeXpkSEgrSzdseHVvL2ZuZGVP?=
 =?utf-8?B?Q095WnVhRHFsbFRWSU13Y2dnYkZYZTlXUEZIbjVjaHk5RzBNT2VvWGF2V2Qw?=
 =?utf-8?B?U2hPREZPT2F1bWFPQzRJbldscWJWMjJNUlB0YzVZME9RYTlqTUdLdHcycy9B?=
 =?utf-8?B?azRaTys0dDR6UDkxcFBOdWczR0ZJRmJ1Tzl1OFBEWkpkMzNwRGx5TXl4dkQz?=
 =?utf-8?B?QVppSmxpVHhPTCs4cS83V2IwMHNHZ00rUlQyR1JaUTQxQVI3TWxUcUZTT3pl?=
 =?utf-8?B?SFRJRitoVi9VaWxZZ0tPeHIva2Iwc1ZtZDJ4YVdUckZnVVlqcWpaWXN5T2x0?=
 =?utf-8?B?N0NjZGovYUF5dVdTY0tEcFJEdjZzL0hPeDg3YWE4ZWRaeCtRMmx0TmFxUE9I?=
 =?utf-8?B?bUFhcWdOMzNqYzFFQ213U0l3Ukc3ancvZTlSOWo3a2VTblNmcVdIcS92NUNE?=
 =?utf-8?B?aHlsbG1NSGx5SlJ5UVBlTVZLUldWM29WK242bXVONGx5N2xBTlJ1RGVmQnFn?=
 =?utf-8?B?ZFA0M09UYlJvQkNYeGdGdFU2dFRvYTVManUvVnZDdzFzbER4Qms5WkhvVTBn?=
 =?utf-8?B?MjB5N0NiR295a0tYbTE0LzFUamtFOUJiQ1NOdzFja3RybytydUIvN1pSYXF6?=
 =?utf-8?B?K05NUEJrS25xWDhNNGtyQkZRdmJwdFBiUDNtV3RuUGFaU2ZNN0h5UkRtYmpx?=
 =?utf-8?B?R21XSEpzZHRvSzU5VUhZdzM3S2RCMUlTb2t5cGlaalFEYlNpQ2lxV3d1VHFj?=
 =?utf-8?B?U25MdXI4ZWU2NHoxMXpPcWFlUE10RnlFMlVieStIQVA4UVpGUVE2V3UyQ3pp?=
 =?utf-8?B?VUxMZDNZSnFuRElXOElmSEd6R1lQMDhGbUNlL2VEVGNTZFBRUHJla3Z5YnVF?=
 =?utf-8?B?TzBUN0xJMVUyVjhuRk1VaHFXWDhJSTZpa1BibWM1YXlzSDRaMCtIWXNrRVJw?=
 =?utf-8?B?N2hTcEtlMXVFMCtQVENOaXJyTXkxR1hLdFpMMFRsL1JpTG96aGE1a2VZbE1U?=
 =?utf-8?B?ais3cnJvWmVMcm5hcUhRei8yMTF5N0w0NThUYTBXVlMyN2J4ODloSU5RcHVj?=
 =?utf-8?B?RFByWHpDT1VXamJBVGViUkRsaU1OQ1MwVUhqaDZGRUlyKzU2bDJpT1gwNzND?=
 =?utf-8?B?WTVDdWJWbDZyK25wb1hkaE43eFVGSkYzcHMrYXFtTm93cXpPeHg2aW9SL2tK?=
 =?utf-8?B?eldaTDFmOTZ5cnRvbGIrbVVjRnF6QmoyWjlNWjNaN1ErSEFMZ20zTWhWMExZ?=
 =?utf-8?B?cVpURElSeXFHUGlkM2Jnd24rOGRab3J5dzJldFZJZW41UHg5WXBZK2JRZ3JZ?=
 =?utf-8?B?dTg3endldVViaUYvZGUzckpYbldQbTdYK1BNMHZXN1lvQXB3QWVSajRMTlc1?=
 =?utf-8?B?emJnR0txNHN6SmtYWGRBQzZiMGJBdWtvbzhXS0hrK2pTNm9OSzFBZThiVjVK?=
 =?utf-8?B?SnhHNHZFWnV1RTk1VmJlSmVHbXl3bTBlV0crd1puWUlhaWlKaDV3YXk1eU1O?=
 =?utf-8?Q?sQYw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWRBVXRucGVOak1BUVpabFVta3cwVGZtRm9PVVo0UTVqQTRRSExmTDJNQmVB?=
 =?utf-8?B?aTJzUyttMTBnay9GRDhEL290d2ZOQmNQem9LNnpiWXpEYjJzWjNQU0o3WFF4?=
 =?utf-8?B?M2lubnptbVlrQ3U0di9oUGF2K3NJQTJqRVQ5RWZSRHgyOXl2M0tpZVd5S2Uz?=
 =?utf-8?B?WGU2c1ZDZU1MWVA1UTlIRkZPbm5jb1YrUnRtVmFmb0d0WkllTmIvV084K2hq?=
 =?utf-8?B?SGV6ZXdpV0Z1QW9SblVhbXl3bGxoUXVmVXYwM3ZHRmNxU3VEeWFlek1qd2RR?=
 =?utf-8?B?eDVidm9yWVRiOGtHWVRUWk94SzJuS0djdkpGT0UzV290c2d5d2FMcGtmK1Jh?=
 =?utf-8?B?cmtTTDlnSzJjTmpteWdNdllNbmN5QTBJQi82NkF2c0padkZwazllQS9Wd2R4?=
 =?utf-8?B?eHZzNFZEeDlBTTNWQm5PMDJvWG5FNVRkK2c2bDByZ0RDOEQxaTcycFE1Ry9E?=
 =?utf-8?B?Q0V3dGJZVmhpYmRXdFVlT1FQblJ4TE92Y2FXOE03S21iQTVTOEhFUEI5ekRl?=
 =?utf-8?B?V2tEdDFXRmppSExUVGozd0xxZEVCMGtjTnc2VUw0bmYwb2s3ZDZ3UFZtM0NQ?=
 =?utf-8?B?UGNrbUQrQlNSeUR2NFcrVzNKM2VCUU54NHUxbkFYTjZ5VldzWkNpWkUxMXFi?=
 =?utf-8?B?L3pTbE1JUXlNMVA4WWJmTUxUby9kWEVFVVltdE80dDNTQWZjaW5vcVo1b2F1?=
 =?utf-8?B?TTBZY053ckZiRDlaUGNFL0sxZDNvMTRCb0VnNXpFckhnVlBFTS9vVmZsbm00?=
 =?utf-8?B?NXVqN1FVR3FaT2lEOTFhTmo2S3VRMjhUbVNVaFZia0FKQ0t2RE9NVjlVcTV0?=
 =?utf-8?B?RHpkU3NZdEpaQlVMWTU3SElzSDlQeVhUTE01eDF6eVZ4c2YwaWJYMzFsbHBn?=
 =?utf-8?B?c3Q4YkltUXNFYllsaHdBVlJsVUhJWCtGajdCYkRHOGFGRSs2TlNEUXpDdklC?=
 =?utf-8?B?YjdJYkRJZ1UvZEd0YnZyT2FFN1l6b2lxSXlLVExnWkM3bVJqWkErUHlIdTJR?=
 =?utf-8?B?OWo4elcyYTdHUVJiRkJjWjhncTVEU3NUNXozOXNRcEZHWExiUVJNTHVodXRE?=
 =?utf-8?B?NDJOci9zL2QvKzVKSGxKZUw2OGd0WkdWZThjUXpZYmxxTWhBQXJJK3BsT252?=
 =?utf-8?B?QjNvcHVOekp1MDVlQnd0UkgzZTVuaGV2OThxQ1ZJR0VRRTBJQ2NmYVlxTWVL?=
 =?utf-8?B?MDhXMlJ6MmxGVGpvMGlZNjcrOGE4RTJjY2lqQWZ5ZXpIdVJNL0xwNlFsUnZs?=
 =?utf-8?B?S0NWcGRZOXJ1bjFaVC9BaGtxS2FQYnJJVWs2L3lhS1Z6eDFCSHVaRGFQbUlx?=
 =?utf-8?B?cG5pWDNFd0pJNHFWbFNVcUxKdDdmN1FQVVo3ZWhIeDZ1eGwzT3JWSG14TmlI?=
 =?utf-8?B?SGo3b3I1YnFTUnVscisybjBqV2tNZWR2M0hUcHpvRUkwQ09qbnl6UlYxVURw?=
 =?utf-8?B?MkVjcGI3MzJpcVZhR09QTklVV2RaVWFKbjZFYWdaYjhab3h2aUxNQ0kvZ2pR?=
 =?utf-8?B?MitTT01MV2RCVzhuNFJaaDRSK3FGWTZiU3JlVk5ZaHlPZjRZWFg4b2YrelV3?=
 =?utf-8?B?QmR2dTZLVmpQdDNMc0ZkQ2sveVlLeWhLVTIzV01DdVF3c0ZXWkpTUjJmbkox?=
 =?utf-8?B?MmNJazlqN0IxV2IvbWNUZEcrUmRiR2xOSEhueGwzY2UxZlpLMHRTL01Cc1VH?=
 =?utf-8?B?OUIrUmJ5R1dOT2JyVlhaSFJpWmRWL08rOWtWZE9COVFaTXp3NDhDeERsQ0sz?=
 =?utf-8?B?bFBocXQyZHAwZjlsQU5FVTZZeWI5NjJ2WlhxaFlIVkZ3RFByRHJvYWt5Y2RI?=
 =?utf-8?B?WXU0V240cytjYmFsYldhd2I3bHJMUVVkK29iNCtwbW5tQTlaa0pONjd3NjFp?=
 =?utf-8?B?TEd3ek1EZEtyYTg5MUZOQ1lXNkErTG5lZFBxWDI0RDJuR3lBWGlyUVpHNFlW?=
 =?utf-8?B?aXRzWkxrUDhPVlV3ckJoQjB2K2FzNGtCRzdFVDFEak5Lam9tQkxHTDBKZHFV?=
 =?utf-8?B?YnFSWFNoamJSNTdTQlZvN0J1Y3VjdXJXbkFWL1IvWm1OTUlieXY5TU93ZnRU?=
 =?utf-8?B?OTFvTGY1QllYUStLRnhPNHdIRG1oaUhjUm5odDFEMUZMaWxMV3g5Q1BXaXVz?=
 =?utf-8?B?aEE5K1cvOFhHTjhWMTJya29xUzMyZTAvZUxOYnAvUGFoK20yeExIYnhGbUU4?=
 =?utf-8?B?UXYrVC9zVzN3a1BzZHU3ZTkwMnRhd0NUMXhGWGdPcW1lYVE5cy9kNXl0RFoz?=
 =?utf-8?B?TDgrYlpjcmVpTzJoZ1Vmamt4YnJhc2FhY3YzQ1VTd243cGIyVjN4b2gxWGR0?=
 =?utf-8?B?d2VOZjQ3SEVaaWovM05rVVhLT2kvYUNpZXRjd3ZkeGU2WERub1NPYnRNLzZW?=
 =?utf-8?Q?kVITA6Cuebt7i9rM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 950976b2-9293-4d90-9ff1-08de6fb7d38a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:07:25.4325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0BoFWzVSUnl/DelNzLz5Ptd2JOuAFmIG7Qc6uJkAwWDrqrDtawKLR2d91oxln/5opayZ/FevmBq2nMLf8Ow5mvwPRyhUhb67QR1MJ7Zff0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8394
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

On 2/16/2026 6:37 PM, Bruce Richardson wrote:
> On Fri, Feb 13, 2026 at 10:26:38AM +0000, Anatoly Burakov wrote:
>> Currently, when allocating buffers for pattern match items and flow item
>> storage, we are using rte_zmalloc followed by immediate rte_free. This is
>> not needed as these buffers are only used temporarily within the function
>> scope, so replace it with regular calloc/free.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/ice/ice_acl_filter.c    |  3 ++-
>>   drivers/net/intel/ice/ice_fdir_filter.c   |  5 +++--
>>   drivers/net/intel/ice/ice_generic_flow.c  | 15 +++++++--------
>>   drivers/net/intel/ice/ice_hash.c          |  3 ++-
>>   drivers/net/intel/ice/ice_switch_filter.c |  5 +++--
>>   5 files changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
>> index 38e30a4f62..6754a40044 100644
>> --- a/drivers/net/intel/ice/ice_acl_filter.c
>> +++ b/drivers/net/intel/ice/ice_acl_filter.c
>> @@ -9,6 +9,7 @@
>>   #include <string.h>
>>   #include <unistd.h>
>>   #include <stdarg.h>
>> +#include <stdlib.h>
>>   #include <rte_debug.h>
>>   #include <rte_ether.h>
>>   #include <ethdev_driver.h>
>> @@ -1009,7 +1010,7 @@ ice_acl_parse(struct ice_adapter *ad,
>>   		*meta = filter;
>>   
>>   error:
>> -	rte_free(item);
>> +	free(item);
>>   	return ret;
>>   }
> 
> Should this code be reworked so that the error is propagated back to caller
> and the item freed there so as allocation and freeing occur together in the
> one function - or even in the same file?
> 

It should, and in fact further rework is also about fixing quirks like 
these. With this patch though, I tried to minimize the changes and not 
touch logic, because untangling these allocations is not trivial.

-- 
Thanks,
Anatoly
