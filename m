Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBFAC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 13:37:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33C69410E3;
	Thu, 13 Mar 2025 14:37:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0EC2A40FDE
 for <dev@dpdk.org>; Thu, 13 Mar 2025 14:37:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741873057; x=1773409057;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=TPoDWqhrONgX8SkqTrTRfqNvyMmqC/3kvRXpxIUkwoM=;
 b=iFoSA8u692tycyje/Z7PK7K27cARZh14hrauKC5Orc10TSrinvDv0OE5
 ckUGt9ou933ssWoPgwW7aA7gNXJni4duODxdw6rTD/Y2rXafI9si+lLtM
 YyU/xpQA2VoJoWcmXo0h3b3zMo6b1exAOwaVjd4vy8ervasMPfXUKCHWv
 WMGFA+BeFzn0HL1pPXLPG82m+SIpE3ywRfrIuglZ5yDMKdmkAbkiwnFrX
 EYQqxViYNiIyjlerqCqc5FixjZIEdaeL9rCR7lhqlKwCGmJcy82iUUtP/
 hYF+X2AS0kIzaeejODgrcs/ZApP+1xp3dgoD6aaTgzxNm3K+UQTcDkYMP g==;
X-CSE-ConnectionGUID: lW7GE49aRwyDdpTQr8U0VA==
X-CSE-MsgGUID: kYRceMjbRB+khYQI+FuSHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42896263"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="42896263"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 06:37:35 -0700
X-CSE-ConnectionGUID: zAG7zgt0Soa6hBgpIJPJQg==
X-CSE-MsgGUID: RMWsTY3hSfCFcd0nfSQfCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="125580434"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Mar 2025 06:37:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Mar 2025 06:37:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 06:37:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 06:37:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/4urXJPqbLPPVMMHqp7S7x17il0aKvmcxW2u9be7MqFLA7cKglK7JXC0T+i+Lr+E0i1tIHYiIHu2vv95KTJi7YopVZ80eyLrQX9Wpv9ADjx/qPBqwZOtpBw2XAL2466Yc+j5UW1iBXYXwDkgW3ECsfndmUFf+Vl+NHrStFmrs/lNvgxtcN/t9r0LUoz4IckwhBvVW40VqAA1/zCAsPTW2mQkmfaGGUPBWhZF4xOcuqb5AxhSrWOFTQF3yOeb6zESZX8eDIBQbX/Pol3K6C8v5SfEzqkqUXw2j4Wdm5mytpf6puZRegVHPDCOdWPGOm4rKiQyDuy4WZ8Je3JO3M94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AdBYgeJipd/DJxfhFxSiJYsbTnpaAQq+ac+PTOM9ZU=;
 b=nWX0jfnwfJV2gx4ENodqw7xaKsHWEyfeNz9ISOEIv0ZPEBd/rfgrhHL2xOwLhX6445ysGiGqY+Rv1OXZwAM7Ej3cOFkXu+nqIJnUEq6h7DeG9vXv+78uXHRxFLiV4RcJz7DmjaAdD0x2tMzSXaC/PC78ofSGnRtBzS07Npjaag90eXecCj6ZRmExBLxd6H6FVntnN+/t6TvTiGqL30TLQwpFFkDkK5y4vnnbzHRg1OUunLbBym/1nqimFbCjoEGIjlmugD5yGKANSRAAiYqDPaCfWnq/HIrKiIcXDycPpimxjLyT+RCrv0XfEbYRDSL0ChHSTGIbFC/uZnahtB8AAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6497.namprd11.prod.outlook.com (2603:10b6:510:1f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 13:37:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 13:37:30 +0000
Date: Thu, 13 Mar 2025 13:37:25 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: David Marchand <david.marchand@redhat.com>, William Tu
 <u9012063@gmail.com>, <dev@dpdk.org>, <andremue@linux.microsoft.com>
Subject: Re: [PATCH] net/intel: remove unnecessary compiler flag for mingw
Message-ID: <Z9LflQ-mQiuwC9ze@bricha3-mobl1.ger.corp.intel.com>
References: <20250312155458.1395709-1-bruce.richardson@intel.com>
 <CAJFAV8zAhG3U9h1A=UEu_eUjLBEV+FjuZffZg8+SwEcSuwN9ww@mail.gmail.com>
 <20250312091110.64b77903@hermes.local>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250312091110.64b77903@hermes.local>
X-ClientProxiedBy: DUZPR01CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a986f2c-c20e-48ef-7e2a-08dd623433c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TU5UMGdqOFZiWkFPYndMMW9rTVRDQVRFbC9wS1VFOU1VNHc3V1ZaRnd2VVFE?=
 =?utf-8?B?SThkTitJajNOWUZhUWs0ZTN2Zzh1OGVQZkdTQVNvUWZ6UHVKTytOT29kbEo5?=
 =?utf-8?B?UnFXMGVSKytIUFVlS0d0RVhVWUV4eEpWYWRNRTlWZlRScjQ1OTYrYmdoSDhV?=
 =?utf-8?B?eDZYTjlROVZTK29pbEw4K3ZodW9ZL2NFamNaY3pZa1QzeDZXSTZ4cHQzbFFM?=
 =?utf-8?B?M0dKbGFqMUU0Mk42dDVXdnVOaWV6cDVmYSs1MU9YU1dHdkJQTUw2REIzTUln?=
 =?utf-8?B?UFFlVTUwUmw1ajJmWWV6ZHlUYTdPTXl6SDZPeTMxSFZVWXEvUTJ6NWRnVzZw?=
 =?utf-8?B?czNUVForTklWQ044NmkwNzF3STNJUTNKRkZienFZay9PQjhsamlqa3A0R3B3?=
 =?utf-8?B?Qm5FSDdGbWJmNEJqb1hOTGt6VEZjMTNtYjFDd09acGx0VlFrN3ZML3A1Mk9U?=
 =?utf-8?B?cVRqb1pJUWR4dG56RExBTmFVaVdTUmNOa0t5UTZhT1ZGRnVVNU43L0lZNTZF?=
 =?utf-8?B?ZlFnM1VGV3BpU2FRWVNtS1NvREtBcitQQk5UandNUDhmLzBCd0Y3WTE3RFND?=
 =?utf-8?B?TVdjQkFxeDF0TkdTZW5nL3ZLcnZJNGZjOVo0N2dxUDVsUDIvTkp5MGxpQVR4?=
 =?utf-8?B?UUEzSzVWT3pzYWZhWFB4amNydUNyaHROMUFYa0VWalVqZ2lDVmdYckxLM3RS?=
 =?utf-8?B?cGc2VmgvQ2xGTytCRzdLR3g3S1A5dDBLaThtWi9wQ3JoMTJpRm9QMTk2VE5Z?=
 =?utf-8?B?MUZBd0NoRTVUVTRuVHZPSDRTSVo4RkV4clpzQzhSUkFPeTF2MDlialhnUzBs?=
 =?utf-8?B?ZEZUUHNaV09CV1dtbml3cWRCRlVqUy9NS3hQcldtYjdnaWYvVGxhbVRsbUZq?=
 =?utf-8?B?QWltM2xpa3RvKzJjVGFMVURiRzdReDdsdXl4RUVvVGQva3RuUlkvdWRQWWNl?=
 =?utf-8?B?bWYxQ3Z3Q1BqY1lkM2Nuc3JHb3pCSERTVU5GYVg1b2NMZXhTWXlxaFplS1Bs?=
 =?utf-8?B?b3ZXd1NXalcxZUpFRmkvVXg3WFdXTWh0WldmQVd2Mk9XS1pTbmJGdFU3NUIr?=
 =?utf-8?B?UEhpenhSRXIrOWI2UnEwdXZ1RnBEMkdlK0t5U1R0R3lqZlpsMlhJOE11WitS?=
 =?utf-8?B?RkRNdW5xUHQ0S2srS3ROdGhHUHB0cjVCekRWb1d1YXVGS2wyRWJiamZ6Y3RT?=
 =?utf-8?B?TFl2WEVZWDVSN0RkSVcxRHg5V3JLMUlZY1cxTXhQRHRsZHBONnE1b2dkMmFY?=
 =?utf-8?B?ZDM2cnEzSEpZeFVRTndpMVlBbUFiT0JJU3lqOG5JWHN3VVhjeGhzYVdaZTFH?=
 =?utf-8?B?THk2WEJLYXRVQ2loQzEvTE02Nkdxbms4MlFtQ2VYRUV4THNCclRSYmt0NmUw?=
 =?utf-8?B?MjdQekIzeHFlV0tFOHVlYi8vajQ0UDJLYTNyYnc1NGNsandRaG9OR1N4UUxL?=
 =?utf-8?B?eXVLYWY4RlhZSC9rcXdCQW1lRVpGckU4eDN1YlZxTFowSUFSZDEraXRwY3Br?=
 =?utf-8?B?cHdYNHpsNEZ0SHlRY2lBaWRFeUdyZ21ObGZNdHZLK3NKbXo3NHl5Qlh0Zkxv?=
 =?utf-8?B?YWxiTVNWMERLclIzY3dtVUYxcDFHMkliRUk3d0Q4Q25jc3ZFZGd3WWgwS3h6?=
 =?utf-8?B?eHZuQUIwZTlyU0JhZ0Y1aFdVNzZRNEdFSzFqRlRnWmo0MVlzbzc1SWptR29l?=
 =?utf-8?B?M3Z6dmoxSWdHTmMzYWNEaGM4WTN6M3dMekpaR240ajNPdWw0emJHcHJxVUFp?=
 =?utf-8?B?M2FwZk5TNEZoUTl1WGJvRDVOQzNNUDdZTm1nKzR2YXhjckFlQkdiTnMyRXJZ?=
 =?utf-8?B?Y2FBTVpIbnRYQzVLRXNudz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUo4OHZuRm5keHlSZXBobDF5VU83aURUazhBSW1NRjFmN0lxb1BVV01UcWI2?=
 =?utf-8?B?bUZNMkFrSC92aFA2VGRFbGo5NzA5T0FXN3kxWjZxcnQ2ZFM1SWlnYnRRVHJH?=
 =?utf-8?B?Z1owNlozWmhGSUxGMHZubkc4Q3FmTjJvN2VwOEJJampWemtER1hXTmhXUkQ4?=
 =?utf-8?B?R2hBdVJBTVU5ZkdOcm5FbEh5MjV1NTJCUlFVSFBNVjZJcC84MjhKK2JnWEtQ?=
 =?utf-8?B?Vk1SOHgzb2FCWmpOWVJuWUZoSFkzcE1BaVFTZ3RyNjFIZjFaNThEbjBUZS9t?=
 =?utf-8?B?RnZ1ZnA2cWVkU2ZDRXNEQnRJaTREZFdvdElNNGRpSEpNOXNRV1VsZUJjdDZE?=
 =?utf-8?B?aXd5RWNKank3MGtCRURKUkVJYkZDWk1HRGVyOU9NWjVWZ1F1UlNmaUtXVnlO?=
 =?utf-8?B?VERvazZKUVVHbGZkTmFSMDBETnBVYWVNVTduVWZYR3daWEljeUlWN0lZeEwr?=
 =?utf-8?B?Z0pXN09XNU4wNkNJaFNEN0pxME1sd0R2NUxrMFBCcXRFZ2JBTFR2dnE4Z3hv?=
 =?utf-8?B?TmswMEFqY21tOXB6RFBEelNJdXhSVm9EQnBxSVUxR1pJaTVqN1JOU3hPblJW?=
 =?utf-8?B?VlpJODhHekNPQ1dtbUo0UVhGNUd2bExoVlJIdmh6akdoQi9leVF1c3E1bi9z?=
 =?utf-8?B?WFRhVC9rd1kwTDN5UDVsV2x6blFmZFRsUmRxN1owL2pQN2duT2czdkJrWE9u?=
 =?utf-8?B?a0diMkpRU2Y1VURIalV0aEswYlJteVdHVERtbFphOWRoTitXY1NIdkRQN3lX?=
 =?utf-8?B?NDVzZ1RVdjNCRk56eEV1cjJUWlNJd1huYUwrTWFrdWZhbysvbng2dStrVGgx?=
 =?utf-8?B?SFA2WDhRTUZieHZ1Q1g5T0dkeFZQOXhwaS9aR29mQXRiUmVRVzZuc3EvZW1q?=
 =?utf-8?B?dkdWVmlNbnpYUEtpdTZiMWcxMi8xbzlPNkdIUFJFTC9vQzZrU2xTa1dHa3dq?=
 =?utf-8?B?UktDN2VpOUdQVHRyb08yWkYvRzBwc1hKQUdSREZjU3p2WC9nVjRUZk5UUmRJ?=
 =?utf-8?B?dWVxOHUvYTNleEpxdElkK3VuNUxXZFpVS1N1Q0JCYjA4VnUwS0Vlb3ZsRjBB?=
 =?utf-8?B?bUZuclhwYllyNkpRMVZET1BpNXhrcTUvaDhQc3RqRGRjdkJOa29WR1gwRklp?=
 =?utf-8?B?STRQQ21jczJ4b2FPbTdSK1hzYTNseTNMWUhHZ2V2Sk50Y1VBVWZyR3dmNkFl?=
 =?utf-8?B?L0xSMUpJQnJTR1lSZ3dNV2wvc0IwaXo2bTg3bVBQR3F2cWZnZXJCU21sZEt3?=
 =?utf-8?B?blJGaG05REdDMFhBdnNDSDhRNFZCWUFCNXBDa3B6WFRiSkIvclJoY1cvb1NM?=
 =?utf-8?B?c3VGM0NpV0tSbnZiZkkzbTVIUVgyVEllYVBsV1JBQXhZbERBZ3RxL0Q4dUhN?=
 =?utf-8?B?R01oRkJxand4L2lsN0tNc1FmWUVvQ200WS9WUGQ1YXFDUk4vZEhnT3h4MXBY?=
 =?utf-8?B?bjE0Rjh0NlR2WDRvKzZIUkNTY3pYMXBhcnZrMUhIS0R3WXJvUTVsUXNVc0dV?=
 =?utf-8?B?RDRHS0EyUEN0SW81cEVvWW00cnZrSmpTRnhhZk1JbWR5b1hjM2N3dFRYb1lY?=
 =?utf-8?B?Y2IrcVBUTUpZa1h1bUE5TFo0eGEyTkJEcE5HSHJLcU1jWG9ra2VKT1lFR2FX?=
 =?utf-8?B?NFFHYzJtYkd5ZnNXUlQ0cG93ekdSOTlzVXhPRmE4bmtIemtPUU9COXN0aEwx?=
 =?utf-8?B?NTRDSjk3Mk8xc3IvbjRocDd3OC9BMXRRdVBjYmt1NHY1Ujc5U04xMHJVYlNL?=
 =?utf-8?B?SXRsOVU5WHVLeVN3eGpkZTNaL25TckpEMW9aTjUyc0p3aUtzRzJJcjUzVmcy?=
 =?utf-8?B?TnJPTXB4MDdZT2hMTmpFQVJ5VGZickpaUndVSVZSeEpZZU9WNFZOZExQc3VY?=
 =?utf-8?B?YXZmdUsyN2xwSE1vSWFlOTRvTHFaMm1oei94bFZjV3htQVVJNkwzS0UxR3NG?=
 =?utf-8?B?TlpNN2x2dlNhcGd5cFhDNTdRbzhqZzYwT3BKOVV6UDc0RHVGSkJ3RmYrS0lE?=
 =?utf-8?B?VjJJdHdxMkorQ1l1SjdacERjS2kvRWFmWUVnVG9UNVNpdy9oL3g4bi84d2F3?=
 =?utf-8?B?b29BOFlpclFaTkdCTTNYWWwweDIwOEJhZlp2UGhyNG1YTmU2VXdWSVRUdTR6?=
 =?utf-8?B?TG5LVnVmWW1iSkJBNzJ3RUhUR0hwMHZDc3B3dHVBbXVxaGFqbEdta0x3Q1NL?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a986f2c-c20e-48ef-7e2a-08dd623433c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 13:37:30.4617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2Dv1zoQ2kGyl6uPGZvIbfhujGQ4jOizOhlSSsSL+05mP7jrjAqqDObVt8UOM7nEcsKibgO/b/Ja4GHJeF5LYhmBwV8/WOQBdOlURYYXDsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6497
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

On Wed, Mar 12, 2025 at 09:11:10AM -0700, Stephen Hemminger wrote:
> On Wed, 12 Mar 2025 16:58:49 +0100
> David Marchand <david.marchand@redhat.com> wrote:
> 
> > On Wed, Mar 12, 2025 at 4:55 PM Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > There was an issue with building DPDK using mingw v8.1[1], which
> > > required using the "-fno-asynchronous-unwind-tables" compiler flag when
> > > building using the mingw compiler. However, recent versions of the
> > > compiler no longer seem to need this flag, so remove it.
> > >
> > > [1] https://inbox.dpdk.org/dev/CAJFAV8z3qFhT9Vv5xOpLhi74BYAht2YCfL2ffLrmei4hfSG5jg@mail.gmail.com
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>  
> > 
> > Adding William in the loop.
> 
> Should add documentation and check for required version of mingw?

Docs, yes, but don't think we should add a required version check in code.

Will do v2 with doc update. CI is passing so looks like this was only an
issue with older mingw.

/Bruce
