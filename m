Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C129CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 09:57:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C61AC402D9;
	Tue,  6 Oct 2026 11:57:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id D2C6A402A2;
 Tue,  6 Oct 2026 11:57:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791280670; x=1822816670;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GfR3cTE8q1Dx2yezz+/z1qZGTBdo2eKr/8GTntxmcco=;
 b=K/fC2HUzeLDY4lHrL7mkGrDHKKcUKsvoDQh3mnwM+qwoSk6lP4iNGJ6X
 CYL0Q5KTvz5wg2oZpoWFlC8rSMtJO/j2RkcmS77guxDScfxLKugqcWoW8
 8TgO86UINhTDkYz5cD8T55k1rFSSKZsrnlt15+vUzRdRFQnpQII+R/GZY
 lSanOHjpbcitWwqBe4uycFvmVFRvMZFG46CsKZ3goZRGoAbboBxBQCaY2
 CDMJEUJl08fsI1q6NnJOfMDir5LAy8khq87nQFkR6JhMzrwdma/wxC3aZ
 x2+1IQ7g6befpIoXoP56oBlBtWx7MIrjyzUlV46Aj/QkPQeWrLIWJ4+Wr A==;
X-CSE-ConnectionGUID: PHSF4oN2Q0KdWxUNcn26Ow==
X-CSE-MsgGUID: JAiNilTBQ6Oq9FzSxZmEiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="17881"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="17881"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:57:48 -0700
X-CSE-ConnectionGUID: 9ETx3RWvSlSKbO+OTvgb5g==
X-CSE-MsgGUID: sbNfmEAxRReTp1Tz7Iy6Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="1201375"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:57:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:57:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 02:57:47 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:57:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1otzGoovbL767begWxefQa7YeBVWly2dSMn0LxE8/47pI/QJ3rHnMKuI4Mo6BhejRGN12rmYLj2WNVWL7PoIgtKF1HNXBkYXXAgBR1vtl7Cwyvl7R0NQa7wz1LU3/ZgQ16N7grYpweQvSlJXvM+SKR4V/6g2XmIIWkKcS+VXn9GivPUZUu+Ov9gO/U6nYA7Fyu7lGvZVd7zcyz1Y2HT/ljGUsbeuXLB+ts0W+u+g9bVFDwUyOnWXyn9TR5TICEVlnMuacmvsYBjDyrh/5uwF1Fyy8jWwOLmZJ2Bw9Pcj+azy/AyDZ5QN4atLSu86yoBLxK4MtLMB7S7ROVHGuFoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktL4arIKTMQk9pFAk1zQfzENavkc7yqcUNkbxuq5mIo=;
 b=iUPr1lG+Etr/u4dPeVCEIE1Pm1U74MYNZz+kDgUmqYp1gGpbgvMRJfE3vaAIyiHh3C0uKczkly4VwBWiXJ9JbVXQ44FaHX1jvQz4hUw+Luz6eohg8aHkJPJDTRWZuXG6qUSnri+j6RM4yy1+l7Oj4L/RNNW1MGKjn6yOkIBkDPskWODUylEQ8LNnNme2VYJ4sBjMwaUi+Uay48VdNchAwW7/C3xZ0V9IdYD50tDQLx9epn3YosWr27fwHzzoXyquqhS5xOeyqByvGOnl28Pjkcei0mIX72McAlfEG+eRnRzD1m7unUZqt3DeIcF7dK4vAEmgKTmEZYvjDEI6YNB8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB6495.namprd11.prod.outlook.com (2603:10b6:8:c1::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.19; Tue, 6 Oct 2026 09:57:39 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:57:39 +0000
Message-ID: <ea668450-0d0f-4a7c-b591-3d5e76bf2d34@intel.com>
Date: Tue, 6 Oct 2026 11:57:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: fix PHY capabilities buffer leak
To: Anurag Mandal <anurag.mandal@intel.com>, <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, <stable@dpdk.org>
References: <20260930165230.342989-1-anurag.mandal@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260930165230.342989-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0220.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::8) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9faf51-5613-46fc-a543-08df2390414f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: INvNjIVylX1in3N6LjwjdsaDEjyUm8+agDvSjSLluv7qPcrk9ZakIuw6v9dZWdh1TxtjWznhQ5U39jQmnAsBuWYPXPUtfPG5S29lMbjzQuDDuC+ySZZ6wB1b/q88HxB5r4Y2mA5ttiAp9vORn+UvVj5WGYh219eZ1PQ4QoLQOqXaQa+rhQe2OKYw26JtLuODABmsvyvvB1i+Px/FSCHbBjyH3yapWyY1lKbeD0yBkX6PhfyHC3uhlQftKSOiBrSBTCvKyNHxsyQj/fEhT1TvzU9kUAubJQwrSSYwspQ9UeHw4+7pnO0ZPoyi8fx0T7YCmmzpuQdomXIlVeib1vPkMqXelRsekyQBZAywiaAaOzCHsXYDdCw0BRSYfH3U1+B9Hte45ejEqB5PQNfK6MA/sTdMsyAhVDY/MsHMQZpJrrEekl6lernEgdNxk0V3h9icxIcH7KHB5ZY2mCX63nZZORGh4rJu0vModIudJryFbneDrF96Rxi0Pl2vMD/Ceduoz3RasdQiSVInpPuOMjTOzAY8evXm8x4ogUyEVy4hwhw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Szhrd1ordWVwUEFKMWFUWTNCSFFyWjk3S1RLSWEzZjJKQmp1cnp6T3F1UEgx?=
 =?utf-8?B?WDBnb3B6VEVKMWJqTDNEL0haWlJZNmtWa2V6MklrV3AxRW5zc1doR0RENnQ3?=
 =?utf-8?B?QjNUL1BkTFY5RUREWWg3d05KVXcySEsrSmZHdVJyT2NVRFJkOG1sMjYyRDhJ?=
 =?utf-8?B?MWdKcmZOOTJjajlDdTVUR041eHIwL1ROWmRWV2NWbklEQm5lTG1tTkwyS2xJ?=
 =?utf-8?B?NTFDTDBHd0RnREVLazZyTnE4RW43Q1Y5MkZuVkxXVklOdCtiMU9SSWpZYjEv?=
 =?utf-8?B?WEYveTczeFF6VEhBWG1NVHAxYTdXVFFsK3VGQTFvcndrdUlZbHgrblFqOHhk?=
 =?utf-8?B?QnNIbFJBZDZFT0xzcGRKRDJGQjZvVFBuRGhEMVVYY2NkL0RMbGpHdGJvUk9T?=
 =?utf-8?B?b3FZV1VBWWZzS09tRDBjOGZKS0h6SGVUODN4UG4rNnRHMi9NTkFvZ1NIdWxo?=
 =?utf-8?B?M1NBdWZlUEdsQzVZbDNOTVlCeHF3ZmtvRlc1OEUvWGJtSG1HK2hYUUQ4aUZD?=
 =?utf-8?B?WHFudm42Nm9wcVgzdjM4cThpTS84SmE3cDVlY3FvUTc5K1lNdjFEUmZlQ01N?=
 =?utf-8?B?Rm41NG1EYmRJOXhDQ3pnRXNvOXljNndsWmN1MFE4bnJLNEpCVCszQVlJcTEr?=
 =?utf-8?B?dVBleW1ESkZkYVQ1VWNPZGpuSzFYRFVpazlRa1o1RG1Qd0VhcjcxT2RrMk9l?=
 =?utf-8?B?SWRqT2F1a01PblpUK1lZbWtCaVpLTldwdjFtMGY4UnZJNjNyMElTOGFyRE1I?=
 =?utf-8?B?VkVLUXo1RGVGSXRSejNkUENyS21LT3pDZzJSQzFVeitnTlJ3cGRZRUdJUXFx?=
 =?utf-8?B?ZG1UM2JrcU5KaTFINHlMTFpYR2dGQmM1TW5VdDZ5M0h4Yys3QU9UQ29WODR3?=
 =?utf-8?B?V1lsbzFYdW5aclB5RERpTzRVWFpHZ0VqVXpnN2dmVmVwaVBJNlBscUZiZUNV?=
 =?utf-8?B?cUFlYzRjNFpyOHZTWTBKY2lpM3NaWXl0RlFoTW92Y0ZHQjF3Mk1pQlhzTzNl?=
 =?utf-8?B?ODFidVE1M1dUR2VaUTZWdkZCa3lPKytPbENwOWU3c3UrRkxnMGw4YnIxZk1K?=
 =?utf-8?B?NGg4a1ZEczZpV21leDVhTm93ZlVFOFd5TjAwcjZSVjJwSXdaK0J6bXppbmtG?=
 =?utf-8?B?UDZXNWRzWFM2aXRGZk1jeFdMWVZ0RXJnbCsvd1NWTW1tUWFCdHlyMVJZdG9L?=
 =?utf-8?B?a0JvL0dPMlFQdTFMeFl0d0h6Y0FURFNaOHhiMlVHa0tqdk0xYU5qRHcrNEtw?=
 =?utf-8?B?TFZJdTJOR0xmc0xtSlZyZWRLZ0JQYTl5S21adVloZnQ1QlNQT1puTXZhZVpa?=
 =?utf-8?B?a2g2QjB5QnFVZ05pL2theEd6N0UxQmR5bW4zeUJoc2ZaTGMyS2dSakZxQVQ1?=
 =?utf-8?B?U3hDK2RrMnF4WGVZT05BbEgwSFYrWVh5eVNYZVMybWc2VDJ3b0I3MkcyM0tO?=
 =?utf-8?B?NkMxdE1SR2NISUprOWtsSkM4bGhSY29ya2dXQjRuU2V5aVFqczJaaWFVNGZn?=
 =?utf-8?B?YWxBMHc0VmtvdHViczRVcEdvYXVGbEdOUjVCb1BmR3QzL1NXZ3JOS3pCcTl2?=
 =?utf-8?B?TnUxT09ZSjVHcXBkU25obTdaTGhwTHJ4Z05JN3Q2UHlCL3ZVZDNBaWxLRUds?=
 =?utf-8?B?Z01KQ3pJa2VNa3dIeVgvR0hmRDBmTVY2SVFNQVBJK0tSa2xJejhpRlowd1BD?=
 =?utf-8?B?Q0tTcGhneWFQU3cySUNqb0RTVUxoeXNYN2pvMEJyTFBJN1NQNHZzbXNRT0g5?=
 =?utf-8?B?VC9VN0JNcU1GWHNacXh3c29sYy91WjZFSGZBTzgvY3VsQ1pQWUxTYkE0WWg1?=
 =?utf-8?B?angycFNkK1FFTWppeHBNb2VaMGkrdS81bTIxZXhRZ0krRDFRZERGQTNsYmZR?=
 =?utf-8?B?bTRwZitIZWI1WE56OHRpUjZrbHlVa3ZEUFJjYWtza0JtZUd2aTlBcXdQZjdX?=
 =?utf-8?B?T2dqdVpYNzc3TjJOVTZWdStSY2Y5akozclBRM2k4OWpZR1V2OGxIVmNkeEhL?=
 =?utf-8?B?YVZuQkkrbUpwTDdxdVlFNjI2K2Y5azFxZWJOSGdrZnhWQWZmbVBvRUU2K0NS?=
 =?utf-8?B?NEJJRkpjRmg4REZGNzlpaVUrK3pZckN3Z0tIMUxSMmUyQnV2SzE2TnROQ3Fa?=
 =?utf-8?B?Nm9scnV3ZmxycEsxTlpaVXgzalNqdGRrR08yK05lZWdIS0xYTUNzQW1jVjZ2?=
 =?utf-8?B?akp4VGdWRFdKUWYxbWxaR3VjU2xLTTRYQVZXNWRKdjQ2MGxVYUg2N2luQ3Qw?=
 =?utf-8?B?Z1l4WnhCanBrNDRxc201S1pOUVpFWkk2ZmwwY0NWTmJHU25YZThrcFBWSXQ1?=
 =?utf-8?B?bVAzK2NBd3diMDgzUy9GWExUSEJmYXhKeXd6OCs3TXIzV0liNEdsd3QwTEpW?=
 =?utf-8?Q?MJFHpmxADK2XVSVw=3D?=
X-Exchange-RoutingPolicyChecked: lIldsNZOwtituh3SKbfNqHzWon/QqYm3dLTccjG9SU2E1PgZjrmAnxQzAKugrWUXaw96JrcePaSsvreZPdxOM8QjvGz0Q0KpfKZcD26zThOzUy+S4iJls8FoZMExteJPOCRS2sN5t1S0cDaf0koEshhNs4eDutwt+ZP5plsipK3EbaLftrb2Sg9Bir5b+dcuNj/MN3zsu33jtfKiaSUFFtSX8xSNvvuScMqNnnXFXte5tm4gUXBSpLUzysMED38sF/CxpepfV3LMz5gGkXSz9pGsicrqOv0urVs1GeuQHVEtSmLh1ytOFS4mbhjVnEVCL/Iy6LSrN1AmWGAd6yb84g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9faf51-5613-46fc-a543-08df2390414f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:57:38.9238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvwO3Ha52MOY4ixHqJNZLFMDBbT1xQ9Cu5qwDLgQWAS0blFUtKBCIkknrca8OfLkb+rqe0tgGpwdM7XWmDFy5S7+q14g6iZhRcvT7xDl+8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6495
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

On 9/30/2026 6:52 PM, Anurag Mandal wrote:
> ice_phy_conf_link() allocates the PHY capabilities buffer and only
> then validates hw->port_info.
> If hw->port_info is NULL,it returns directly without freeing
> PHY capabilities buffer causing the buffer leak.
> 
> This patch fixes the issue by moving the hw->port_info NULL check
> above the PHY capabilities buffer allocation.
> 
> Fixes: 36afbc269081 ("net/ice: support link speed change")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
