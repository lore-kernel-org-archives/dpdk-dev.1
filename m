Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F6DF8A163
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 12:05:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECE2240297;
	Thu, 16 Apr 2026 14:05:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0B22B40144
 for <dev@dpdk.org>; Thu, 16 Apr 2026 14:05:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776341103; x=1807877103;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=58SJa4Nwj8hvhGD1J6wBgtzv1zzpzp+gdCu3BQr6BIQ=;
 b=PSlU8XMYx33efSs8V6UmJmmR3uqi3APCn6Z7+UmJ3O7tP13ZZlsoeMNe
 VjNNZAOr+oVUZF03rg8k+7/2mN0YCPf/yjRqmutlMLFr/leB7L3XDdiA8
 rs4HFvLpwPsi/4mHZIh9obnjfXAGEnmXSdA8FnfjN1Kcopr9Q0b/Me4jV
 S9c3TFnTqvCAD0Sd/gektkTLoInn76eVllfABi4lPY8vlimguGT9nONuE
 58Xvan/vmtKG5BprJBFEgOcyhkWpqzrXJZRZakT6upwRP+zXRChRrCmcm
 NzB00Yt5U9RGday6Nsdm7cIe1GlRV4H5CLEBQD3EiVrlCSxciwwscHi1W A==;
X-CSE-ConnectionGUID: hiqd0nBLR0moDj5jwifyJg==
X-CSE-MsgGUID: fgInaH15TZCbjtA2LTVz8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="94743106"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="94743106"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 05:05:02 -0700
X-CSE-ConnectionGUID: qZuuxxOxTlOCAQNnUl6UaA==
X-CSE-MsgGUID: 8MfhvcXTRAKxSFj+w33DVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="226378666"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 05:05:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 05:05:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 05:05:00 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 05:05:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxbkrFL/zZByrUS2gt0YhOvw0+YEh/OFcMC61TYE5TMzhKx5NHtbAVfJOuOFF8Y745EtltUB+0wAXeK/PiowlgvAQwsTCebwdQ9QXVoO/Flpbo2l89+pENVgojyilV5NLhm7BMD9GYRIVGKKMp2KtxgUXybcBvIV1wl4unm+HcHWlvObrM6osAYVR2YqAGNBJ5d2NcBNlxbTbPmmYsG/VNioP5RNGTFOCOTtOp20Ipfx2kFQ24MI0t+ifTXySFKQaXVkK1WKMSS3pZ/d/MzpGEtFQTLzJkeXVu/bn+BR3kVdFnAnb/uSEep7dfcmNZGrpDOtAkbA0d9JbHxcGVtwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRVrPycmi4vsM7faHvhqUy40C1vlxx/UP4J5KX+Tlj4=;
 b=FbPTUuTDteia+dYZadH7y+mENQd6ioiF2NpQTWKHXucSeskRW5+ST5iBBd6y+itB0ZzhDXBOtLCwev9hVAn355SWmj6rhzMfjrLvpFAQr1kDwwOeGf+aDUV6Dl1u2F7A/aZHkVFP2P11vQoiRNpetv5NmNkcAsDFrNncurt5LG7JO3XYP0Q6JYlAxNICMmK/3gmjcX8i18Ar5EZZ682djcb4AUabSMW2wB3xR2v7l+Lw3lX24OjZeIW0CsAcnRlqTnCNC/MFNgLRX1JTkBr/mKGgbfKfM38DmVf3uOP8BuowHo6CivS7xamzWkrDozk9ijrNUdmN2HMu9MekdSm6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4728.namprd11.prod.outlook.com (2603:10b6:208:261::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 12:04:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 12:04:58 +0000
Date: Thu, 16 Apr 2026 13:04:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v3] net/ice: detect L2TPv2 tunnel type in pre-scan loop
Message-ID: <aeDQZcs78WTjiTqE@bricha3-mobl1.ger.corp.intel.com>
References: <20260406081355.3241393-1-shaiq.wani@intel.com>
 <20260409074441.3424824-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260409074441.3424824-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU6P191CA0070.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4728:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df24cdc-bd2b-42ee-932f-08de9bb0615c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: FdJxd8+PPgV9MMxysiGp9zureMEHLe6Gfm3G3lLV9yOMh5cDNncD7SHyuQcLYVZFAcTM1kKPZMPw9/Nkyplrcg6mfw+n73zGQoOcJErLCe4s5TQ+rMMlrECzZHW+RdfKAPDXxzqiRP1Dj+myutgT78e9DGCNzRvuH0pjX0WxVeeRsOss9qF2uSqbcGwXzBicq8zLnVSZFPOUsxMjkaoq5XdSjpbwqAGrXAwlhHe1AA9FoeeufMGWL1QHZTuJ8gtfDThABp2IpQLViWpKaWaGP0R3ChzMi0iKpqxvGTF8+gX7jjnAnwLSsPZ18rwLUwP7/6VppYc4wAf1IigoyH9sbftf5gIA2/yVHNsd8mv4wo4gjPky3R8zrQpP0vkVahM2EZh/7JoYbO86skl854TQYTfdQSsoA3VKNe4lwV7zT6Hhfj91DOv1+/f78/Mt9JJG+3GL+SeHVG/Qz2eaxlBtRc1Z5DpQ9cPfPv9FSkSw26g8Yzl9JrFJzVnvi6k1CKnt4KSUC31gW9u2zdaAIFxUJX6COyVggPmQeiZD5QtznfPLKUwaRzQ8kLxLuwqPjjWHjg8OLElxw0Td3oNw6Te0Mh/hDa0DDBkp+cEUQRjEy/57g1f9i0eN1QwOfJ3cR6xkO4F0y2WoyUfi7W6njQfjTpicwZDsl1lFyFljq5TwRNc0efCRExlpECV1BSMVz6CmF/YI8Xt5Uy3lihNmtaT8f6JSpBj2cu0vjV0U8aTQ7uY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9FgbUssrHoq7bFO8UnOMR2P45ztu1boRs6G6XwJSI7HY1UiKMjQvuFo36Xnf?=
 =?us-ascii?Q?uyEEiJabri6gyjf+Fmk/Qn55tzIZ765+odPRNk4DJ7+7wywLwdC4dh/GK+cl?=
 =?us-ascii?Q?DW+itixH/LmLG0TVdb8qiZ4Fb9whhZVrlN1lfHApNt8fzLu8k+TYET3B4Kk+?=
 =?us-ascii?Q?M3wOnO5ycJG/Bnn+FLiIL55EKGsEVVcGH4BFypUpNgLypUvjXgBYXvFvIBXC?=
 =?us-ascii?Q?8aWg89ZK3FJTIgEKLnYfCUeCS+b0dYE2AJ+VOgCn0WFcZcAiWVoMXnnfRztW?=
 =?us-ascii?Q?XkzcNRUx+cVyk1TEpFWYepnBWh+oFlI9KuN3yUpToTwmsbBc8ZN90tldIS9u?=
 =?us-ascii?Q?BASzHPElyTRKkN8hZtdYX3syJm8/ZEO3T4GIodSwrWqYQ9UomB8VM8tCIblq?=
 =?us-ascii?Q?Hlox815B37UWOtBd40fshESA9e8K8J+YbmehUHF1OTV8xiQUJE+zDjhNQ3Qt?=
 =?us-ascii?Q?3/evXB9wVm5dNxvLcOz3lGKOb2CJfBthr4Fzk2QTRt/3+esf46dun38XCibS?=
 =?us-ascii?Q?hMYXHdeNnynalXymANFRqIbBZzF0/JTmHP787sVWpcRyKxJuYJVXsEbkXO9v?=
 =?us-ascii?Q?m5kCVhFnI6mhxngCc/++Hd9Z22/Snlxa03sGYWT9gXl3j5boD+om/oxrqBqB?=
 =?us-ascii?Q?JTPBuWxbllCpq+7+5blk9v7t1Q1nenEDoApJL5flr1KGVJbrFa25wYAGum/+?=
 =?us-ascii?Q?wdy3TOLWR+MHgEpPW2D9Un+NCn0utmw92m4N5+M584s7iRHxWCH6Z8zvzGoi?=
 =?us-ascii?Q?NrIcsflRxgtLv3BmKCXW6ppfoCcirU7+szfhO/5Sgwe4NJ+RtigcMw3bQaCV?=
 =?us-ascii?Q?BEy12Zm51vQKXsNf4nTCR8IaPlF2TxkwyhSwBOiMtUsTPaTVgDB7FXRKuTZ5?=
 =?us-ascii?Q?ECg1SEeWrXdXyff8kd3OFDRVVOvVga8J7m3BRb16SvnFj7vkC3diXPyOJhjC?=
 =?us-ascii?Q?YKac6E8gIZ4iszf7ynQnYwEUJ/T0EPAG4yyclfJoWA3YaYH77ApqBR+BrZL9?=
 =?us-ascii?Q?k4QiQHxbQ/cFssT+Y881nJ5sZSm0NqNt9aEFY5NJOpmC9QOrCiZJoKjiBExX?=
 =?us-ascii?Q?BrQzgJHaQP1ptbuiT3hH2ILuHFXQiQl2+DuTsh5LjA7b8m6n5olKw9w2My6u?=
 =?us-ascii?Q?wxfDL0myRnx05AypfAhrhNWYn3D/5dr9a5e6TL5DrWQaN7hgQBbO7uNGn84X?=
 =?us-ascii?Q?qg0GZiMQjrLJl/X/Ccid85PwLpu3beaUFMdL3JdpyPSUZ1UBtU9/XGOzwDOz?=
 =?us-ascii?Q?Iy99gIkiYjwAWkk3Vd61p61CI0VIwPu/0m7z1yu4s+JqfRqGttvA8wmzAC1D?=
 =?us-ascii?Q?18CK1SkDshyllGocYR7tdQWlNP+TNjoizvzMcJ7UwPKL/A21foU6KEyQ//0x?=
 =?us-ascii?Q?nei6svfgOK0rr199CtPw/rvrR5dhj7JmTWJ6W2C9xs0M9WIPT0yXmGpyNKbY?=
 =?us-ascii?Q?hfr61qpyHfKhHEGBLyUgjSL32bEeTjwvgVu183u7L9nbvakp6zE9Zs+2cZB/?=
 =?us-ascii?Q?U9Ce+Pgc01/ijxwyDpHsiLsQXAVOVfWOabBsV61PvGlRcG09B8yJBXvzshCV?=
 =?us-ascii?Q?O1tuEmzomMY2a9+Y+RPYLZ0Vul+1k1mi5bTCJRauqLMdE4iik0U5yKycGhUL?=
 =?us-ascii?Q?87EIgtgRiNIu3ssKIlugSIy/49CmcbiacU8o0eK2Fvj2B5XIfzTTu6Asmoc7?=
 =?us-ascii?Q?2sUdFq7Pkgg9ucjndim34VV72Z37GV/euFOPhz6YlfqjB3C/KeZAZPVBJosm?=
 =?us-ascii?Q?H3N0mcRGL6yfsxrcGYlKwOYySNk9O4E=3D?=
X-Exchange-RoutingPolicyChecked: lgaKusSGQJGI3ESRDbR8xtQfuKOiKC2+S+Ex6SHd/tf3S1B+fUkuZgUfcUO+DqPzvXMDotTnP541Iq0Wv1c3qk78PgRjaxSE7H68YNa0OX8ouwmInnEF2kGvTurzUZVaQeWOfeGh1wiqaKO2iw/GI5Lu7EAjRQypeTEtHIuSI2tEnDwAcdLvyKdFdQAC/YM/e4HeyjtJh7pw47j6HLkfc/CZbjbT2G8iJdAul+thJFJ+1oM6+m3Qyd6VgJaaFQWsTDW1Mfhzi23UllO1JORoFROYWo0lo7dF5X92ue9SCo5XuWvSH77NsUj3Cjs5WN7ZnYMuPXYoHn7oTQYj9EJCxw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df24cdc-bd2b-42ee-932f-08de9bb0615c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 12:04:58.4246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDor4rW5gOcSjNcFQ1n0/XAcS/Qz39BoXqVfpaq+3+mM7zCY6Tz8KdY7rg6TncjgkJogROkgBBhBtq6NaOcmPmu6q6655AMkg+CIey7QvU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4728
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

On Thu, Apr 09, 2026 at 01:14:40PM +0530, Shaiq Wani wrote:
> The pre-scan in ice_fdir_parse_pattern() recognises VXLAN and
> GTPU items but not L2TPV2.  When an L2TPv2 item is present, tunnel_type
> stays NONE, so the ETH item handler stores MAC addresses in the inner
> ext_data struct instead of ext_data_outer resulting in rule not matching.
> 
> Add ICE_FDIR_TUNNEL_TYPE_L2TPV2 detection alongside the existing VXLAN
> check.
> 
> Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
