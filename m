Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E31ACA0FED
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 15:06:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D834D40612;
	Fri,  5 Sep 2025 17:06:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id EEA16402E7;
 Fri,  5 Sep 2025 17:06:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757084790; x=1788620790;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=g79mpxMuhZYqx6O8i9tQBIonLBXEk7OCLPFKZF+0gmY=;
 b=llQ0IZ7HrKX7Rp2UxXaPsoFdxl+R4O5/hUjmL+7HnoAzwg5rZivXympn
 C4AVrnmNUpoMj1ZRYenGL1PTs7H08G8Xfy13Jz08NVt5235H4x2fvLXg8
 NQn9k51xX07S2sq1RD9PjeYV3FXtdnSmskihR1w9V1Y5iTwPJ5OhWq50z
 4k5z6dEct8V6G641eOkOnqplOET9ASOSchhyrrxHk97PzDNWLT40z5v+N
 JgFPB6hUnSOuPRXPwmj5thc2AqRdqh+RdbhTdP5X8Cslt24qPljGLcvHi
 WXVxgYKFODkrK5JGN1THeNzgm/LBmq98NR1+ctiUmihb/LHSrYEtjRSO1 w==;
X-CSE-ConnectionGUID: 9+EJGeAjTNuHaOeXF/nVsA==
X-CSE-MsgGUID: g38RcAP0QoqLgFT4pDf1mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="59135715"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="59135715"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:06:29 -0700
X-CSE-ConnectionGUID: fTwW6nOfSiKKVJyQn0gr4Q==
X-CSE-MsgGUID: sC6uRhvrTLiNkoxe1pq4fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="171748756"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:06:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:06:28 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 08:06:28 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.82)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:06:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgoRYMbuD2eZWhovaEPqfG2zbqc5J+XMxutgQ+fnta97/BPH/4auWGTC5prKWSfhlPYjwN5u1WtWABzyJ0gBKIwkCmzKEUCvwyARN55yRBTUNlwA5UyQvrTOHlcZlTyWA901OTr13JdKcBddfdBE1dEXl3/5I17DI9fX5ORkW3mbq8AoZlHyw3nE6hcTySlcZ49xBCqFvZ9zl43bzK5vUciw1nWDbCBY5rFDOOcSCSpEekjQ3xaMEdskqjdMn+GqPfWhpAGuG06zCpDDuYPwhkZkoetJJy0Plop4hE7armkUl4xUKNf41fEL71hSSK1YZdsX7RQKTuNBglWklJm0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BARxXmn0cYhAGmY5FiXPom7shiSBP4uKU0foCjizIDM=;
 b=jcnj4f168JtIgPsqw5kp9K8eKowDpFtBeKYyOS2ipZonBykDzjMs50g700kOzUcOt5DrwCYa0dqfoWC6NIaQCCdJAzXOtN7g608A5MN9Izf3MoXmn+M7CwnrQr/b5ulhts1iqLS4pZtXb1fCIj8GPTsRcJCtnT0m1GwpuaiMhl2Iv+YHbtTUs5KhB45Lp0QHmk8c58KqVqAnbRBYZcWxz5y2sSqZTkB6RhcqW93xsTcYiMPyaqjAfFq8qwK/ZSN9z681qB4qT9AUTLjfzQtPQe2KvMJy+qPVXHPBX/7E1eh5C3zqWowGxomeDvDRlkYg/km4Ap9glgGXctqUhLTOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5092.namprd11.prod.outlook.com (2603:10b6:303:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 15:06:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:06:25 +0000
Date: Fri, 5 Sep 2025 16:06:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Wojciech Drewek <wojciech.drewek@intel.com>, Qi Zhang
 <qi.z.zhang@intel.com>, Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
 Dan Nowlin <dan.nowlin@intel.com>, Qiming Yang <qiming.yang@intel.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH v1 02/12] net/ice/base: fix adding special words
Message-ID: <aLr8bOseRlg7Srkn@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <6e919683011310f00dcdb60ffbb66c8f721547c7.1756833701.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6e919683011310f00dcdb60ffbb66c8f721547c7.1756833701.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2P250CA0019.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: bf874967-c90b-4d21-c577-08ddec8dc86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VJXvccTFj4rLNCaqebNaVtAWjzXpHTm6cuH9xzAf/jYBwaeVKO5nFicHduil?=
 =?us-ascii?Q?aKJhD739qdYdjSfcVfWiisVVt2FCOKb8MA1kFtwF4vfENXZ7IaRp3UFlyjj/?=
 =?us-ascii?Q?99WUP5LUUJt8fkJBGkp6gYQso+TPw6R8kMuZG44iX7ZRB/vm/ssB74pKHH5B?=
 =?us-ascii?Q?qcAKoG84TidcrX/Jozlz5JEgDKv20aHgHAqgN8NJYwe/APiSiNiUzaxvExdu?=
 =?us-ascii?Q?S1VUpTGw2RuoyVNbt+iUMZJwlj2L9KcjkTk8NIrWtEwm9GHPXgJjyqFKTHWP?=
 =?us-ascii?Q?GwkEBc2YLDg5ua0Ix9J/b9GWvHhURVA+G+2zMYbZByJNLeaBC2f5VYWibpEk?=
 =?us-ascii?Q?vIMddFjg470ya06fy0n87w+03F/LVnV1X+AuzNvz1XUe+RthgHAKSA/6SDiX?=
 =?us-ascii?Q?n9Kfv1ul7ztdygQg+WIc+zznk1rPaVeyzXsACjRFwIiXsIbjE1JdIILMI7ni?=
 =?us-ascii?Q?o0oQ/gVkwsttDN5hRxshtOjfO+sNILx+EVWoBnyB8BaJMy50wP0CvunjfjiK?=
 =?us-ascii?Q?gIf0FebgGAcM3TE66x1Yyvpl+0dAvVyM7XDPwW90a+ehHmgkBQ1UDklPDewp?=
 =?us-ascii?Q?vkYOJpO4/p0W/WEEGPnRRK9oXoaIEx76Q5Npzgv35euz4efAqhMJC9VYWn/I?=
 =?us-ascii?Q?KBMFY/5TlLJZe6Ex1kfIdtig9IkTeJMY4VZB2/kSVcBZ6MfwItympG9X6IST?=
 =?us-ascii?Q?Jk14n9MBuep3hKvDW5BhLzQQrRah6iB65GVQrPi5/x+aZsrTveQrTDHTmih1?=
 =?us-ascii?Q?6GKqWcqAxyih8VAQaTvn19IQ5eNn3rWqMcOSpnj0ak/nHAXdks6ITADT9iH4?=
 =?us-ascii?Q?BP3QFUYQUbrBj/Uirsn7skh+GoAvAHJq6O94uPmPYbIN5BEkFJL6WtHhsw8B?=
 =?us-ascii?Q?63L5SXIP3Rkk1OvpSLAiggGbtiLjRleQS8SXdnwsvorNDY9j4Hx6NA2ybYYL?=
 =?us-ascii?Q?JDu1uboZaZOTwJl4UNhe2828qG9FXgHhWTr509hAIbr2HYk5xh0gHgWerAWw?=
 =?us-ascii?Q?nj961Yk0orkhp5Geu4lkx9/puXWabMWxM5ZIyft9ap9KEbnugyeoAPLslPYZ?=
 =?us-ascii?Q?otv+SkiE0pli1L+skk+ev4R4R1mtB4m6896wpN5mw/PkNKHOcA6RpbaOBZx/?=
 =?us-ascii?Q?2AfU/geEK6pvydjkOeLj1PFFnAdNrhF09+dG+pWgIXTEHLf3m8Eee+EsNj2L?=
 =?us-ascii?Q?DP53HDUs2A/TEiJBbBE0u9g694tqogbaa35zOjBnvIR+ZHBzEOJ3x6nAdj/p?=
 =?us-ascii?Q?SZBydPCILuzZ2ZGqfA9+IyOWhsGCYHYHii5MTOOxa8iWCng95kkuegE9LMvF?=
 =?us-ascii?Q?11u2n+MJK1saacVbuppUvzxE9UsYTDt7Z9c8EH/dneF4x5GbroudSbUjr9el?=
 =?us-ascii?Q?EzvVN8sgQ8uqDtOpSs5DJEwoHUW1q6MXshaPcwupqANJyUWXxkSr6KAGXJgW?=
 =?us-ascii?Q?TSX2iodxP7U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yxUEJ3mNlP13T4OeycmeQycmAMlt2nEXvjAx+1iKimQuOVYBJQ2BSd16ek+I?=
 =?us-ascii?Q?D/lNYxoPKPKEg8gLwSHTCH+qF80PCuQQ7v/hk/8JfvMwi1DyMbr00iEZZ1Zl?=
 =?us-ascii?Q?+upFCu8aKK0JGnznazlJAVQoxOgWA5qpe3GA/y7prXLOUMkej+JKzjYpQwO9?=
 =?us-ascii?Q?QmVfBdq0Gg4NpBgDMSVlrlCv9mgLhwHEZ3nUuBFhcbrSdx3rlb5SG7+D8Jyl?=
 =?us-ascii?Q?pECwpSj7ZHn7MpGXthVAFD0xMgjxvI67I098nHZkQHvlFrieNybpHwGBBv8e?=
 =?us-ascii?Q?HTdY/HyV0Dka0Ty2Bd6hyhvATfK2ENiTJRH+rGJYXWfIXPsE1x8zLnjN0oec?=
 =?us-ascii?Q?S66BLOg0d2COl23PLtkH0UveqvFnwacgKNzN3pY2EhZXF7IkwSpjQXonKCwm?=
 =?us-ascii?Q?yMopsAiVP0LoY+3DokG1nmG6pdn2eCZ8G9pwi4VGUPiiRELzSe0wK9o3yrQX?=
 =?us-ascii?Q?rvE5yeRCey+ISKvMNN19ZZIDrlgkU5gZnWHvLi8X/7Ed1W2U3ihewdqwD3fu?=
 =?us-ascii?Q?7XYrrf7hGilflmuzK8O0IbUxd7IXBCZeZqlDp5RZ28Sb6n6d9Z0KM/f95xdY?=
 =?us-ascii?Q?itM1EkIoRZd08nfRQTlkg+0mVQKiUc58aJxSE9HKZx23i30YBuIAmDA0mc0t?=
 =?us-ascii?Q?sixuazi0Hvjb/sTtznSp7MnxKWktEzLiUX0QV2W8XKGtmrPtB7mSaLHvULII?=
 =?us-ascii?Q?pTfadrxZ0UnnKFC+dO7Qcxpghsaa6mZNo7MUN1q18O4MdObXUwU5Onig5x5W?=
 =?us-ascii?Q?j9adXxY6j1RdVmbGm9zoEUUG/6DJANJ6/IQn5VuWpSGPTAoGBJv8uLXEXsXV?=
 =?us-ascii?Q?xyhXWyqrd3aZQg3yyyS5uJTZhqMNSpp2mdKzBw+Aey6mrJmlpeD2DmJiG+F2?=
 =?us-ascii?Q?E4LZ7NgsVezzm9DlHVoqReGy5oRXOnuEzg4bio0AOsMESNT+KzCcTUryV2hG?=
 =?us-ascii?Q?JZ74DoR1qOcOVyZtEJ7SvMAMG5zgLwPCIgBYBGiPH2i9WhLh6nR+zqmEW57T?=
 =?us-ascii?Q?I6PNX/j/QmKNNd9vX+lGBpAlU04co6HZONDAzdN1wF7adcJGchLIhVJH1JHO?=
 =?us-ascii?Q?H99XarbWE99ou3oaMxhr8iUBahkYBhbgFZ/+DqlmSNNfRXuDytVpCvsrGc9/?=
 =?us-ascii?Q?MXB3QI4+IkKBMabSVj6mKXQXn7KgI9D5MAmPc7AU+fUPwdikUEXMy6e3pU3R?=
 =?us-ascii?Q?bueoaE+SmVIKUSLR8521lo2AA+HItKpWFiUMW2ZEkxXSB1NfVjKTOSNLwvUH?=
 =?us-ascii?Q?1FWLXieix5+xKlY6o1sk20jNreLpHXrqBa123MqscGMrko9WVT2CqJI1G24d?=
 =?us-ascii?Q?t8X02Z+8EXIgK/BdOfJMOou4Ph0PZk4fySyHwUKKJ5bw8pfKi+I3ENnIZId0?=
 =?us-ascii?Q?pkO52NcSfKDJ/LhpUlzJo5ikLNtZjNxuVe9N0ildLb3yYSPxShXiJv2flk1Q?=
 =?us-ascii?Q?ioN7/3LS5cWfX6RalNNxdLHE5D2YJRuYr8gxCWkHMgV/0ep1M3ZsEQzJh6Ku?=
 =?us-ascii?Q?zniUId7Gk6kXQpM6hXuqAjDEhuDqy40azvSKsUNHRDtszEt4iNXZ528veELY?=
 =?us-ascii?Q?PRhwOiTgfTswr4vO/pG8HSvcyBrsNHwoo09/DYUqccWa+4s7uwUmbS/bxd+m?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf874967-c90b-4d21-c577-08ddec8dc86e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:06:25.6096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgmAnNTv9drb4DFVywrICH7hbID36/eo9B/8/gRjT609UXzKTGgRz546kMZqWE9PSWfJZ+CNPK2T/sP2+opVSMm7REyDvlby4Li3CmtNehI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5092
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

On Tue, Sep 02, 2025 at 06:26:52PM +0100, Anatoly Burakov wrote:
> From: Shaiq Wani <shaiq.wani@intel.com>
> 
> The function ice_add_special_words() is meant to add special words (such
> as traffic direction) to the rule. The function that
> interprets/translates these additional words is ice_get_sw_fv_list().
> 
> However, the ice_get_sw_fv_list() is called *before*
> ice_add_special_words(), so the "special" words weren't added at that
> point yet, hence they're not translated. This results in the driver
> ignoring whatever special words that were added. The fix is to call
> ice_get_sw_fv_list() *after* ice_add_special_words().
> 
> Fixes: ed3066a3b1b0 ("net/ice/base: refactor DDP code")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Jeff Shaw <jeffrey.b.shaw@intel.com>
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ice/base/ice_switch.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
