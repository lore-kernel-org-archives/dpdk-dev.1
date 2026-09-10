Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5E8C88E42
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 10:30:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21460410DC;
	Thu, 10 Sep 2026 12:30:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by mails.dpdk.org (Postfix) with ESMTP id 5394E4028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 12:30:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789036202; x=1820572202;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6e7fOGLBUXqJCDVNub+lQ1bbILJySlNsYbpjHAlt9KA=;
 b=ZB5BHB0opHMK8B0nl3dzUXxXG0SqyUQ+bzYwyk+k9QXTdZtFFigigqj0
 aMULpvswMjOf6KLqmCm/NlUrHXSpWwzqEs869kppQHj7dAZmmzFox15QP
 Pyazsv5qjJjW2E3FYBcL+nsHFy3UfdZUD2NbCjVghVqOHmC9lexkwIIDO
 lj+8Px9VLtlr80eX2+DqtT/5w3796UF3IVlnZyC8YOKTmbpZaKfGdpjOk
 Zbz8L+10yIkGmk+zdTZbRQOfFNb85fKCAT6IblO4oaYXiiTq3NcaSPNIY
 Rio2g7n6sOcdKzoB4m9RZAJKkw0xMJYxr8qJrwLXsdwvgdC8rnui6snVB g==;
X-CSE-ConnectionGUID: PySAao0fTniMDyk3i2Btfg==
X-CSE-MsgGUID: Ar7/C2PuQ6aigMNYa91JVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="3628"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="3628"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 03:30:00 -0700
X-CSE-ConnectionGUID: EeLcnntKR9+mYyHbL7Qs7Q==
X-CSE-MsgGUID: eLdWPgV4QsaDiHQM38R20g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="273548016"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 03:30:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 03:29:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 03:29:59 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.65)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 03:29:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CE8dakl021KO5lsjAqqIz+Kytq20LH/BabtlT4qHLNzwCW0xtnhLMoK72BLZjQLGJxqLZCGSMKv51Xe2rsc6ULEJ+dnkqzrunmnMSWcC1V8z9ybL4LNpF/T7JxzGqY0HfSQhmxE+96rWf7HsMj51IzX7PsIVNh/lZ1FL1nnsbS/h3wqBu8MujgkH0W1jyr8TXXBlNeVFMo2/BpgREEjhNRhe9IyXn7Whnglswfxlah91VIWZFLizzl9AIcU/4q1+TUkfBPw/ay2RXbLkuinC6mQfnIClKljjTCOz6vpbJgaQviSVYvEwfGFIb2oV2juVaTnztRhgrC9lM/SNmIFwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrABWUP+lga7Rn3pOFmWHRZnARNq3v9IlUV2qvWmS9k=;
 b=h1xD2bZS4xAamYCs3DvgVop577KKDh3CnueI8AoyW4diOD8BkfCOdtAkI+pwY/NgSxvrLBbbMjSweT/FgwPiKcepyNtq6iD4Lgtp2diOs9m0QbLDW8/7vB8LdTu0QEB1hd1gvER6O1F4Cu2Pt3EMg6fgOcKHbv1Ara8BwEos12My0ZDs7ocRDR8yd9jl3NsPaiSvqG/V0k7/w9MTDg76/l5As++4JZUJ4a5MC3tFFClAIp/0n9etPvqdQjWqx/xpjYHfCAG8xx9VtdV+5SsLzE4DXELls3ayWofrdVudC8OvCAof6Wb0hWpptYqnE7HyVheH6NyZ6ByRA0rEBIOv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LV2PR11MB824747.namprd11.prod.outlook.com (2603:10b6:408:416::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 10:29:57 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 10:29:57 +0000
Date: Thu, 10 Sep 2026 11:29:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice: add per-queue Tx rate limit support
Message-ID: <aqKGofPyWqWVWEwK@bricha3-mobl1.ger.corp.intel.com>
References: <20260910100432.207328-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260910100432.207328-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DU7P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::18) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LV2PR11MB824747:EE_
X-MS-Office365-Filtering-Correlation-Id: ac40fd42-479b-47c5-62bf-08df0f26761c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IYzXk4nUjjqbUia9SCeIVYVNBf7hdq2XfQ1w81hG6W4WRiVesNnjonsTvO0kM8YSmc1zPXT1L+UOTON01L+OoGswypo4EphJXpjhTMnxbsPC4iyyI3JUhlZ7FBV3iXJiNwEV44r/P/37JcOcYCLKONO/80WJgsE0xAls9gfeR8m/Sgh7wGMPY4FgBRVjSpSRF8MNGC49dzhnEGGrLYoBh2eJA6QD7rzP3vq011UlN1P16k112FIcCzBOpguUhoXfxpKZvFfZppjaPBNy9Qog8oYJGvSUWnyjKlILP/ssXfGv85R8I8s+PaNGXC9IPRLFGa78oNRqtU8lceMhLgorBeoPhi3bpR8ckcWLcpJgb+jJeI8hFtjuRRHcoTbqAy2lhU3xdWOyzbo2wHLUb7EVxYFDZCrf3hHS0zmuu4pMjYHxWMGSwh20teXif8Zyj8HOjmTWlSh1/Ey1MvcauppRxJoS4q2am1jlxp2JYoG1gcFozxlA+Q66IHdN+4/vSsECubaXiKqW1u/jSxwrzCzdBf2fWpx5hioda1MA87IqmHBSNiMfHBY5DHwcv3+9Ulmy9eb+ObhKSh5u3rrkDrmiAOcbFyz4cQO3CJ1rMnw3tzbGGX0zzDxVo635xkWE6px4CNhPPkP2sioIGWmgTGohVZISbTgbPHTAmjOLyeagDhw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k5CAhBWIOmQ9Zoau86FgzPdx77cdclr8hBqo/y5cH2RvTuxirFaz1Rfnpgtw?=
 =?us-ascii?Q?QHHSwTHd6AkUoPnplPr2a0dsORu39IUHGVw5fvaKK2MY9v1XUFySjpCED8kN?=
 =?us-ascii?Q?wiXqB6GrQXK9tU2SgD2G2+2w6n3Q3ul6sWD3dmvqLDcHv4e7uI23YgkbWxvb?=
 =?us-ascii?Q?EYvenMl8GfMu1TSfEMVhti9ZFUA2dWkj4tmRmJvHrUBYcyGfXriy0Qajk7z5?=
 =?us-ascii?Q?hnqxhkLWEEEhhumv2MtjIDGcM4D2UDURDTsHMqWQEbwm+3epyHnI5GJpmalH?=
 =?us-ascii?Q?GuUozX68i+yyGdiKhzWKo2lHj3OJOFzrv9fQjXlY5ScdnlJQ53VuF5YO0Pbz?=
 =?us-ascii?Q?ipMv5Br0VQQvb1n4EJPSTKyZA0x7YdOnHEr28aDBHLqzcaEziOqCsWjM+8Y3?=
 =?us-ascii?Q?GIYbtoVjgvWLXtgNh2tZ+rnrCa8RUH6oi6nQIzJaEdxGb6/cK9ORRD1dgKCb?=
 =?us-ascii?Q?7KTu2cv6XLV6Tdkyf09RMJxoT2pe9Y5BdamkxLSq50BhffYYHzCZmt8QEwJo?=
 =?us-ascii?Q?lP0peWIE4UATE47ymn41F8NGylFntdp8jzZoUfDF7VFq4qCQu6qGhjGpxoIV?=
 =?us-ascii?Q?O2aywaKDawTJ+8BIqkWjCbWTpT5wZ/WxoUCl3o8D2puXsBn6SRlYZEqjJQxT?=
 =?us-ascii?Q?sSRKWLA8Oa8aZG3dO+bDJNMW6BYJ3ynUinYPq/pmLbTis4vq7B3HNIUxe3xT?=
 =?us-ascii?Q?s1AVF0gORv2KMlHPdoE4RrIsUXEQC38syKQouPoTlCGeAFJW2S390dhujtKC?=
 =?us-ascii?Q?p8P006O8RUY72aNEnX9/DaBNuQG/rue/W7IsF01JvUz/W7Uja/3mkxBtb+Su?=
 =?us-ascii?Q?EFlswimB+ZXUvRh7V/255KqiUgCmLuiGyGJBHlTFcwSs7P0vre74OIKb0YRz?=
 =?us-ascii?Q?IRPC/JkORunxhloA2WuFY1w6tTbO4+fWIycGlrPXGv0GDCV/L7C6Mg2gVcKC?=
 =?us-ascii?Q?RP1cogrC+v+R2pfo0LDAPq5AVqVE/CEc3eaFRWZ2OBiV4/m0bnSBRVxxpEbQ?=
 =?us-ascii?Q?Qe1lV97FvCw2dddXrAb2xK5E5qDVIBBfCo92ChLCKzuKEaoEHky8XTxafIFW?=
 =?us-ascii?Q?FJqpoCM1olC9ylaizdY9ZqA5CXTm14pUIgbBVN/SwKHDtkainYfrrrTm1KvA?=
 =?us-ascii?Q?qg1Er83aeYl5Mi8ZhqnvF+qaW2tVRXhmDIv9p4u8r9pkdvwJy15Xmh6Y3POr?=
 =?us-ascii?Q?IUrZN8XgXwBfkjfOSbdMcF4Cdpm1UXRfyYp7Hpmtz96Du2JQKZAK3SyjwCy2?=
 =?us-ascii?Q?PSDCFmLi5pfxjcbxAWrLFat0/wDoEYHGJO0MhpWqV7sVnJvjtGvH0EZLtiTF?=
 =?us-ascii?Q?JWm6QVB4wVOHdsQ+gMFoNBcmbVQGHsi6CSabadTAq2j0h7snPOS2pLmpAeUq?=
 =?us-ascii?Q?4xjipq40L3Z5mwDYd6HgjKotLKythPLE6zOsH09MquV8qK2IHICb6Q5+d9JX?=
 =?us-ascii?Q?SUZhIBS9sTWpVzndMvjA0p1j6MvPd8F38w2NMufNFN0CnqnqFfj9tbbvmTTS?=
 =?us-ascii?Q?IsWmmZcFSOihLcN7M7GGQwtbrTAQvHna+wtHUof+PzbCVXHWl2nXkJ9ReTxB?=
 =?us-ascii?Q?MHCJV+8Z9M1+/WrF/bw+oiVTcTk4hKmS3thpqYxXdeLTxQhjD3IRuGXNYH/3?=
 =?us-ascii?Q?TOaht75z0NsuDm+ejD38GEQoGlRyFFhDmuX1+in2q8OXQ55W6wwgomh9B3nh?=
 =?us-ascii?Q?ZE8uarZrlfQtng7zWxWHTlikMZXqtQF5gn/OhA04B/U90/yirkknp+FIv+XS?=
 =?us-ascii?Q?qObfxdpa2RV38d4UOTZqw0K3zY+bfcY=3D?=
X-Exchange-RoutingPolicyChecked: p/8zbyaGZyPeVvN+sxU9Q/kd0GcFsMtE515dfF01NbXTno+lYJltA/XctGGuNeGjI/zie4ECPlw9pCw3p9NMxQwTsHFIXtbRr27IcSVblQHFP3W8FvbTUP7UbDPI2mQyD2zsVPuNavztJAPg+ZCp50FXBym2WNjp94uoF8naIG4bWiOzPaCUy4BhxzXQluWpWjE2K9mk6JqHBf8kO0HCgR6UQzwTwHN98sofCJUx46Mh4Y6DrM1wLpLaO84MiLkMVHQHlCU6aB43NgoBo3iC3qsPwtcAHt/lWNWmxiGbdpr9N5+1QCdjGr9X/NF/HBpQ6ggnbF1JOMTiLvCvUUxx9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: ac40fd42-479b-47c5-62bf-08df0f26761c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 10:29:57.5920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qjVZvgYBhxtVWxSvZfU5nI13qLN5B2o3mYTQGJH7cMLxP2D+XycrQKBRoX3Oo+b+th6aJm5AUNiTkOFh6zLWKCRK5m/Gk49V3ftikDWmW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB824747
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

On Thu, Sep 10, 2026 at 10:04:32AM +0000, Anurag Mandal wrote:
> The Tx rate can be limited per queue with
> ethdev operation ``rte_eth_set_queue_rate_limit()``
> and can be read through ``rte_eth_get_queue_rate_limit()``.
> 
> This feature uses the hardware packet pacing
> mechanism to enforce a data rate on individual
> Tx queues without tearing down the queue.
> 
> The rate is specified in Mbps.
> 
> ice_set_queue_rate_limit() applies the requested rate
> as the EIR (maximum bandwidth) limit of the queue
> scheduler node using ice_cfg_q_bw_lmt(),
> converting the Mbps value taken by the API to the Kbps
> expected by the scheduler.
> A rate of 0 removes the limit and restores the default
> bandwidth via ice_cfg_q_bw_dflt_lmt().
> 
> ice_get_queue_rate_limit() reads back the value cached
> in the queue context by the scheduler on a successful
> set, and reports 0 when the queue runs unlimited.
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  doc/guides/nics/features/ice.ini       |  1 +
>  doc/guides/rel_notes/release_26_11.rst |  3 +
>  drivers/net/intel/ice/ice_ethdev.c     | 77 ++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+)
> 
Is this functionality not overlapping with what the rte_rm APIs provide for
ice? Using the rte_rm hierarchies, it's possible to rate limit a queue, no?

/Bruce
