Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DCEC02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 09:29:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BE7B402CF;
	Tue, 18 Feb 2025 10:29:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 073EF402BB
 for <dev@dpdk.org>; Tue, 18 Feb 2025 10:29:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739870997; x=1771406997;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=/Vdsygi2h3max4F4hg67ma6ckMUXWBZDk9PLeJPl818=;
 b=Amh8KoISqiFmcq4K/vHwvGygzHeSemuXcTsD0NYdD6fBjzVzBWYJK1R4
 VCFP0S64DIbck4K0kUCHCKFROHiN3Yfjpv55DmzCv3dcKT8H6gkRsuks4
 IxqWLkIfJaXMj4cM2mSbk7l9M7BiZkmz4dXwNKzypKQsag3ZG5bZcVGal
 OocLzpzrk/NdYPkXBmgw3fq/K83dDwutkxaNVoz/xA6f6SZF501Fe5+pE
 WbRp0vvDxpz/anjL0SUvc89EthQzJTWlUk4T8lktENSmsvj8tw5K9IOfm
 08zcIZL7pcGkImO5WuD19NH4vlMfggePGzVvHX3qS09lepv9Fx5HZVXVq Q==;
X-CSE-ConnectionGUID: n/1RycsGRbeF2ZuyvcpsLg==
X-CSE-MsgGUID: Sxsgo+SLRUOvf77juZotAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51963980"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="51963980"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 01:29:55 -0800
X-CSE-ConnectionGUID: 1wvYrPi0TiqNKSYZRoBK/A==
X-CSE-MsgGUID: koke6ud1Q+eXKPzIGcRiyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="114536473"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 01:29:53 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 01:29:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 01:29:52 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 01:29:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6hzJFZyVS9arosKf1lAdm6KKOydYr7WLZH/muZKr5oY3BG7eTRWTzicbwXULg242TzZ6r+fGjoloLIKEK8E8ER25MAdn3/6SmiuYVkxm6Jr15jJnf1CPDjjnxIVlcZvWFGWzPiHqtAKzrilv14Pe+QOv635VsU6I5dsK7wEyO8oaYt3Eqok5GF0Om9+gdqTTKDHaFA7UQQQTYGyDCJiODdZnEcX+EJ9rUFSqATlStgiiuQ7F2tUU/gTstYw6sbY+V8pYhcVIU0VlOyE9NXAQ4W2gqZnEaOACdNJlmp0d4vxCk1MeAXACSF8BNkOrBBYxEuf60y6HgUQLhkRb8DqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQ1iZ5apUGL8ToZvSubUgHRUZw8VkRBOgJbaZV4/+eM=;
 b=ntnvbZW9P0zbqy9flRYuUkLOwULiyMDR0HKIpQ3Gw8brWzwpOdaI1GVtP89cUwJXPZ3akMcygheSZJpGg50mRX2b2sdQqjsCzIbtv/oKXNz6w74Loy9pZIwT9p+4RYtfezafVbMb6sURVl53Y54KdkbUypcnqEcdKM+5BlqyMKHGfpgHHTei3ltWZG1fhC4tZDmuOMmds1JvzOsS7VShNpdrKPSGboNkNqZpIwCyRS8oR+Dc5PX5XS773hERQ5spwwmYA2sLCmk26AxWk3gHc/rwHc5FNu+3yFoKfqfn7jf02RXu4KInhnbGNWn69OsS8jTQTtn1S5ZIqWeoWclBRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA1PR11MB6567.namprd11.prod.outlook.com (2603:10b6:806:252::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.17; Tue, 18 Feb 2025 09:29:05 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 09:29:05 +0000
Message-ID: <f616b566-a69e-458d-96d2-1590054e078d@intel.com>
Date: Tue, 18 Feb 2025 10:29:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Rewrite devbind
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>
References: <cover.1733151400.git.anatoly.burakov@intel.com>
 <cover.1733305654.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1733305654.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::29) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA1PR11MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 46345204-140e-47e3-df67-08dd4ffeb04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzd3TUY3ckZlalpZUkxCVG0ya0tpY1EyaGYwQUVuQUxjY3JwMm5rcGc0Vitw?=
 =?utf-8?B?SS9QTzg3NnlNNGJlaytNTHU3MytCV0Q4cU9TdGV2aVZ0MzlybzQzZktWRE5F?=
 =?utf-8?B?bGZ4U0h4MkhhR0hyMkphUnFTeHFEcWRROU55N3NnRmYrbm5kOFhoUmhtZGpq?=
 =?utf-8?B?dVNqd0ZuNERET2dqZHcva1c3Q3pFN2x0L21BV29yZ3RKNGhDK3VzUGRGL2s5?=
 =?utf-8?B?WXNZdzlqZmg0YklsdnhIcXRNbjBhQld4VHVVTzJCU1JPRzB0TTlnY29IQllQ?=
 =?utf-8?B?dW9icll0aDNSTzdGSStsaEk0Tjl2a3ZvNlljc0I0dG9Yb0hBcU1rSlJjRnM0?=
 =?utf-8?B?ck5iL2FMNHROT3R0MnZ5UVFFb0h0TGpqcWl1ZjRVWStEcmpNR1h4NkZJQzJv?=
 =?utf-8?B?b1QreVk1ZThpZUZOZFlZYldUd283VW14YlVLcVQzaHllUHJIYkZ5OU9WVzJV?=
 =?utf-8?B?MG1DWXkvbUY1aXZSLy9jTFNZTm9rb1BpMWpSaHV0dEkybXpobGE5K2p3aEdp?=
 =?utf-8?B?d2hWRml2YUpnME9MUGFBSmJ4ZUUwRzUrY2s4KzczdzkzQWE2d1Z3MDlBYVl0?=
 =?utf-8?B?L1R6WlB1a0RtektSL3JuTVN0WVlHdkQzMU5mV1dBRG5nVUFuODR3eERsaFVm?=
 =?utf-8?B?S0tkOER4WGhYcnpUOStRMmxORVBGSGtSb0VXUkRxUmROMGxOcStlNUdNTXlz?=
 =?utf-8?B?YVB1UU1LLy84cmh2MlBFdUZzNWpUNzcyYW42K1BRU2FPUStsZjZRWXlMdXZs?=
 =?utf-8?B?T1Q5RjcrZUo1RTVTc2JPVkgvQjVCQ3ZKSVRZMys3QVN6M2VqYkNTWWRzQ3ZM?=
 =?utf-8?B?Vk45cjhBWDMvZzc1TkFDTEdVZGN2TXRFY3ZGRm83dUkxS3loR1dmcU5FMUp3?=
 =?utf-8?B?SWhuU1FjeFZGTEJpZ0ROWUs0QlRjcVcveTcrTFEySWZzNi9IS2JhN0dXcmY1?=
 =?utf-8?B?L2F5cHFwdTUyb2pwV1FqeGIyaC9MQ0NEN0toeUdKTmJWNGFsc0hhVzFwcHRJ?=
 =?utf-8?B?SEtSRkNtbWpzV1VkL0hLMzNwSnlhTkdsRFJRNjhuNDJyNXFZSC9kZ1FYeXFW?=
 =?utf-8?B?SmJsZEcxZmtkSk9wOGlxVUthcU5lam9ERDZUbzNnVU1QTXRTSTZMRkdWaVds?=
 =?utf-8?B?elMxd1VJRWVTYWNlWGIvWWN6RmdHL0dYT0JjMjdSSVNRYzJ0K2ZvaVNTbWM2?=
 =?utf-8?B?TW1VOGFkd1M1QkdOdzd4d0tJOU1jSjdEOWVIZDRkcXpmUjdoazBDWGRPSDlB?=
 =?utf-8?B?MDRNeFZDYkxkcExEMVJhV2lDR29ZU3EvNlpZY2dub2RIcG5md3kzRktLSmFS?=
 =?utf-8?B?am55cFlQOXdnaDhyeDNEaUluNjc2a09uVlBTOGUyWlFScGFNNUswOXVhNEY5?=
 =?utf-8?B?L2FBc0ErZThlWWxUNWNlZ0NZUjhDTGplc1ArS0lubGhzSHJNMUdvWWRRL2tK?=
 =?utf-8?B?bGc4NDlIVFNnUjZmNk52ZmMvRVlmWFhsWU95WEJwVnV4elppd216Mkk3M25I?=
 =?utf-8?B?OHBDNVltUkd5LzkwM2ZndlFNVGg0NkY4U05ORzdBRW5HVE95RFVQOWY3MmU5?=
 =?utf-8?B?TVYzdk5IZjFwam1MUXhPMjJoSzZ1Y012Y1p1MkQyVXRKL1lwMTNES3VJeFRs?=
 =?utf-8?B?ZmxQMzU5eldTamdvTmZTVW90Y2lvOUpFQXV5TE5zS2FucDVra1gyYll5ZVRk?=
 =?utf-8?B?Zk5xRExhRERsQi9PMmRGbnVkMnpFT29PckVQT3JpUDEyQlVjMUhmL1Y2Z2wy?=
 =?utf-8?B?dTZ1SGlCWmFXSFVHUGpUMEtwT1B6SzJBK2RmSUJwOExGdTN5bjZBZ2dWcGZQ?=
 =?utf-8?B?S2FwcUNiZnVkeE9lTVVHZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjljMzZPWG5Iaml2V0d1cDRjOUJrYW44dGxNUklaYkxJUEhoRi9oeFN2Q0VN?=
 =?utf-8?B?Ulh3a21wdENjR2Yzc0tBbUdWRzJ1cFdNeWV5eThrZktBZlg5TU5rS1VUa01K?=
 =?utf-8?B?VE9YUFR5MjdabHJBRGtXWEI2MVByS3dDSHRBbTlzZmh5RmdUbUxFenhlaXlJ?=
 =?utf-8?B?bXhteWJLYSsyV3hqUlkrY0Q0TTAxOGFiMHBCamZQSHFHcUhEU2diei93NXVs?=
 =?utf-8?B?VndtVjlFUTM2TGduaFNQT05Za1pKelQ2clNZTlJkNE1KY0hUTTdaYkhLdnhH?=
 =?utf-8?B?T284MXMyZHNMT2JVbmMrOVI3SWp5bkF5Z2JVY0owWUdMTkdkYUtsckVxdEYx?=
 =?utf-8?B?bmptdStnbnRnQzM5MWFQbERRQ2x5YU1MS0FXbkJuVTBncHdCZXZjY0pzMTFN?=
 =?utf-8?B?UUhXR3h6ODhoZzRnWGIvYmdnMXpFOU83bHBYRmtOQzA2cXRPcWc5UTR3QmUw?=
 =?utf-8?B?cjJ3L3ByWFlTMjlsNGExUHpaZmNPL09Tb1M4N0IwNEtqYnhaYjF2RUZSZDFH?=
 =?utf-8?B?K1VMZ1l6MittQUJERkxzb2pXZlF4RkxUT21uMStZVGdhMXdqWjlxZ01LQU4z?=
 =?utf-8?B?M0JkK1FFWXNTYXVCMndHUTlzN1JNOGZNR0EwOWl6L2hYdjAvaTZvNXBXM3BH?=
 =?utf-8?B?Tk1nNW9WM3JpY1FWRXQ3bDFSdkVGWW5IYzdYTWcwUU5tQy96UzEyQXBHSSt5?=
 =?utf-8?B?eUZUKzk5Z0ZSMk5ITm1GdElvellwRWtwOStqVWV5dnlXV1pkNDhtT1RNRUhE?=
 =?utf-8?B?QTJkYkh0MFFUczgxbEVTZXRUMDhRZ3VUN2dDZUNOd25FR0ZiaGd4UVd1dW5p?=
 =?utf-8?B?UDFYN2ViZDZtK1R4QkdSbE1MdHpCZGFQY1E1NDhKRUdrNTV3VWZEV2N5WXpB?=
 =?utf-8?B?OWtWWmtjK0o4ZllpQmQ2T0pLQXR1R2NGZ0dVaTd1MHlYejJYYW1pRms1bEV3?=
 =?utf-8?B?RTF4QjNnSjVsalhOMVhuS0NmV1NXbXNwV0F0VzhXQkc1SGRsNXU3T011aElt?=
 =?utf-8?B?VU0yNThDQWorOW1lVmRBTVFiM0RsT2c2cGtHUDZZVHVKei9TajRra2wvTXdX?=
 =?utf-8?B?NWJ3cXc1VGNCNzZzblZUQWU0SHVKUmtBdXFFZk8rMUNpb3I4b1NJZytZUXFW?=
 =?utf-8?B?cFl3eFpTaVdpdjNxS3lCTFR4R2NVZG5FMGRzMFFXNnpnNGJxTkZBQWIzcmQ3?=
 =?utf-8?B?dnkwbVpCc0dZdm1CeUJCcEEvVXFGejZ2NnJYUTBhcUI0RldoZ1FGTE5nejFo?=
 =?utf-8?B?MVhsdjExSkFueTBBVzZxWm11WVJFc0dNM1VacFlQTEpzb2FhNzZlRTJMVyto?=
 =?utf-8?B?R1J3Q2tRVFNacGN6LzduOWNhWml6OWlHaGZNUit2MDVWdXZFUm9lV2ZKckxJ?=
 =?utf-8?B?c2N2VXZYYzdvRXdGMFk0dkRmTlowYml2SkFhcm81c2t2ZkZ2ZS9kNnJRRzhp?=
 =?utf-8?B?NU05ZGtBVnpGRFIxb0JQVmZ1T1RkLyswVjVZSDlOS2s0VlpiQU5OeWhWb2JB?=
 =?utf-8?B?MXJZMkNrclExK2NHTldWeVl4ZW1JWnFBZXFLaEtxNUtVWElZY21XT1NKMVZL?=
 =?utf-8?B?OFhSMkhxeVN6TWNUbnVvWXNKQ3ljaEFheDcwcUM2YWMwSnVyNFNtK1p0dndK?=
 =?utf-8?B?UlBkSFZFQ1Y3djdSb1YrOXNjanN1ODBZOGx0QXRRd1RrZjVLQ0tRYW8rN2py?=
 =?utf-8?B?WG1vZXdMTkdSUWd6citNdlZFTTBIaWtERXNZUnM5dVlUSFBXNHpqaDZTaG1M?=
 =?utf-8?B?NFZGYURmT3ZtR0pkYjNHVVJkcWh4WWtBemN1cm9hQWRCVTFkR1dlYVJFU20v?=
 =?utf-8?B?MGZNZ1NiTzJuQ040V1JETEFjb3VYKzZZZmM0NEhNQ2xxRTZoTWdJWm5VY0Rx?=
 =?utf-8?B?ZTlySWVTdVR0SUdoR1hWY2ZsV0crK1NZSTcrUHdhZlNlMVd4SkloRzNMWDFl?=
 =?utf-8?B?V3E1bXRFNGtNaStYaEN4RXc4aURraHIrMXNLbWFLRitWdFAzMVNIOU96bjA3?=
 =?utf-8?B?NDNvK0N1QUpScEJ5TFRHRlhyUEVyT3RleDVmWnlTZEZtUjUwNHluYTNvdFIr?=
 =?utf-8?B?a1BtUFA0MjNSd0NRckF5cXJQeGJNdkd6TDNkUVRpMXdXa2dzZjRpVkpHS0Uv?=
 =?utf-8?B?TVUydURManZNbGEzZFQxMnBOWFlvaXB1THJBRWdteWFhbDJwSlIrVTB3UjF6?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46345204-140e-47e3-df67-08dd4ffeb04f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 09:29:05.6395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pei6XarZhSEDvUEuVxzoGQjbBZGcI/fmPtKveW6WP/XsL1wfNuXrVcbcT4K/fOGBAP3i70u5KNUbvfcTcrq6o1hk7bxuQjwdNzsUjvhW5kA=
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

On 04/12/2024 10:47, Anatoly Burakov wrote:
> It has been suggested [1] that a major cleanup/rewrite of devbind would be
> beneficial in terms of long term maintainability of the code. I was in a
> coding mood over the weekend, and so I've went ahead and rewritten devbind.
> 
> Note that this is one giant patch, rather than a series of patches adjusting
> existing code. Making it a patch series is possible, however the internal
> code architecture diverges quite significantly from the original devbind
> script due to its copious usage of string operations/pattern matching and
> global variables, so it is unclear whether subdividing this patch would be
> worth the effort. Instead, as has been suggested [2], the patchset now
> consists of creating a new file, followed by a removal of old file and
> rename of the new file. It is expected that this will be squashed on apply.
> 
> The script has become slightly bigger - 1000 lines instead of 800, however
> I would argue that since most of that increase is infrastructure, comments,
> and sacrificing code golf for code readability (such as expanding one-liners
> into multiple lines), the trade-off between being able to read and reason
> about what happens in the script is worth the added line count.
> 
> [1] https://patches.dpdk.org/project/dpdk/patch/c2bf00195c2d43833a831a9cc9346b4606d6ea2e.1723810613.git.anatoly.burakov@intel.com/
> [2] https://patches.dpdk.org/project/dpdk/cover/cover.1733151400.git.anatoly.burakov@intel.com/
> 
> Anatoly Burakov (2):
>    usertools/devbind: update coding style
>    usertools/devbind: replace devbind
> 
>   doc/guides/tools/devbind.rst |   11 +
>   usertools/dpdk-devbind.py    | 1683 ++++++++++++++++++----------------
>   2 files changed, 924 insertions(+), 770 deletions(-)
> 

Ping.

-- 
Thanks,
Anatoly
