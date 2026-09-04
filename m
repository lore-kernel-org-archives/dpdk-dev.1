Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD490C61DD6
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 13:11:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04B4B427D4;
	Fri,  4 Sep 2026 15:11:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1DF864021F;
 Fri,  4 Sep 2026 15:11:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788527510; x=1820063510;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hC4Qd/WcPPdmxhqiFQs5ve06YJTtK6EuIziHNtK2SHE=;
 b=deYlxiSpJVHeb7QnQXqx5UsKiiJXioGXVVpjHL182DjZ6qhxY7wfwVs1
 BT914bRAZNyhGgJaWFpg9YH/9kK3BNyCe6cJv3dGgWeyPrkCyLNyZgv7E
 vE2e/OaJzs5uMfe2xIsK99q+/bAMrjt1SbJMn67yMyny0k5uZsNvP/kZA
 W5UIK4f5xiw4jTg9NvznXumnpEuQkxLMItthUa9woiUD4j4CFdMX8VXic
 jok5hFDX+sPQaqxrFjRNVoB8MSaL1Nd3R1q05nRzv78G2zhuSLFtLDIZX
 ZuYtdt9FHOgIAxiNobR6pK0MejkGztenAFH7QVydzXA0wbmsSsqmthPOu g==;
X-CSE-ConnectionGUID: W72FGjH6Teyk5zclD5/14Q==
X-CSE-MsgGUID: ah0xKcYYRcq+kIjEfzsNYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88170127"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="88170127"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 06:11:49 -0700
X-CSE-ConnectionGUID: kVqzq+9NRmijJ9hbjohFxw==
X-CSE-MsgGUID: kWOX0Ml9SmGAe+FSX7hfhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="273559447"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 06:11:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 06:11:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 06:11:48 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 06:11:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F52Qep+uQZlFGKqrXf6T8trgSIY8ddEGE6SgM8P7+n084dRDBHw+3qovmxyXyd+vCFvVDrFoKrxpWaY1ypZtivOSRhPkHxJ2H9rVnNSGzb735asI9nUiCG8rKC+6BfQduxyrE4TG3K21h6E6x0SQJlaPtKQxeRp2e5/AqmK8yjzp/0wLpcNNQAImAzQ6o6bZb2ao9/lE71jEjfuhgjQlMZLgqpFrTrMFI8GUOHbTmFSPsjZcYYL/sSzOH/t9OQn+ghs7kUGG1UzP2k/YY2oJWDwsfUQcOOhBKDdpP79FXbGNTOsOxLUW6vQy/n+x45cZJIyl0UDTPnSNj/bJybSKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oj2r2BJ2tenW2m5bAOuYJK0MRcxJ2YK0EpghVltleco=;
 b=M1/mWuR2Mnbhw6D8eeqcW4h/NkfoquhAIJqO+cJ0ta5c5V9HtnIBqq/H4LS7uiP/TnQvESbHEMU83gul0Gvd2rx6ogBOWUiv9i8B0jDy0UL8f8xsuOn8iW19CaEG82nfGSZv2RasdtX5QR8RZcvdQp7jLSYLMDweGz3Fu6Bd81ExXbuWDNtGtNJbTMX0cjyElEiR8s2pXfw0JRivM/bf/pAniNbCPJuFtf36IKWbyLn1eKAwsX8MqcwrAqbH51ggUAy/TkqS5bZbbZNJLbxYNZXiTZwFpOrjkAY4rW/lBVT6pvoQumDkW/sSj2GqXwc0+gncXGYj7+pXrkJTZ6sjwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH8PR11MB6801.namprd11.prod.outlook.com (2603:10b6:510:1c9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 13:11:45 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 13:11:45 +0000
Date: Fri, 4 Sep 2026 14:11:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 2/3] net/ice: skip TC validation if hierarchy committed
Message-ID: <aprDjRmCFnUNCHNK@bricha3-mobl1.ger.corp.intel.com>
References: <20260904105139.3117640-1-ciara.loftus@intel.com>
 <20260904105139.3117640-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260904105139.3117640-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P190CA0029.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::23) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH8PR11MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d0e576-5e0e-4586-ae5d-08df0a8611d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: MNaO86lij+JuENlMWrMH8/rLtMUczdL1COBlGJgHr47k1LxtTIB6LHFM722+TKnWVsr9HzbZc6xmi3x0/AfhCHkMdUn/68kMVnVavJDWq7Q0nHrXfhVO8juU5k6LLzYHuG9Fn/wzw/GBU6oInVgjVzSblsepnfnhVAwYwSgK5vGPP4iSNdmlgKx2zUAoPmxYsusVoPD5M6oAz+GMIg2ycYZHMl9acxg9QwO0W0TDzKcoLkz/+cV6v4Re4dZrYzSm//VbMEGeYu+oUhYQrRnnMr+nzuqtumHTbVl5s/a3RZnu6+Ll/sd7MSoqPAjdurBsb+zAMosYi+zgu+4TEwlk0B0l4NabVlj6+QjK2wm2PDnPMOL1R3fO0kEQW4SzuUoCZ4xqMnfVf9B1dFlo5RFnq4pcvykuDgjLn1sxwbjKu8HltNcFjiXMeTkfE8K2k6riiVenK51+xhR/LNo3bXUMrgSnrqqIip70rQ7D66DhjkeMbxwOeEzBb6xRjRnXWGXNEI+q9uQdcN06zSaLGHw/OeM59GO2pvISFGKpMITzUGZnLUjVt0hG96dSFzsDwEgdJIY2nKVpaYGqQHjMoFT93ixDVYKiIJlvCBfpvpsW1TmWi9SgddcCxXZ8q9eNZvbqsWWz3Q+EQVwgnuo6RAGFyd6nGw3tl/NogNtYNg1wNAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5/QAuyEbGXM9adqE7WTXvmV4qTmiVBirR5RYXZOJgyuVjLOT356N1Rj6E6nx?=
 =?us-ascii?Q?HJTwQXAgk9td6qUCLavBgwpB3Zu6S1EGhw+G8beuTAz3U1wjrME+Pk90Hhqb?=
 =?us-ascii?Q?um+NEExmWD7EXm08yrUyp9wgqCFocUmi/9Awb99rDZzYSMMtE6ALr4eotBI6?=
 =?us-ascii?Q?H5Ow60Ofxp2+M4pCex1S+vhYVrDQpWj39mQTehavThXfKxh5jD/hawUiaglm?=
 =?us-ascii?Q?TvZavdnfBs8jAu6t2pID3+CKpb0bt2P5sBLh3W3kaOoQywEYVFxSngGv6Wyz?=
 =?us-ascii?Q?sgP6TQxPDthgj14utRIqtij8UlLv6TScdg/UNRC/jO5WO/WooZIkYbX2MhDL?=
 =?us-ascii?Q?AeGaVeI1PtHSIdAdT03ugyMHkbOWWA3v1DCnQRN8KWv58VK2og4Pie/UEfdH?=
 =?us-ascii?Q?Du72BHcgc19Ek82yvnte+3P+Jy74HoCgCZlDFFXNUmW/E9v8nIQnBIfwRryL?=
 =?us-ascii?Q?jezfFQ7DgZadKgHKeQVvodc6ls3smXBPecmIyE9MeSRzyNo7X7ODzlxwS3ip?=
 =?us-ascii?Q?OUh8L7HUsgAmbwIOh99UKNtp6+AitW5oqeeBJ+rAT+p3yqTXLrjhiakQxPmD?=
 =?us-ascii?Q?hNTuGteSklH75HUDZ5kOooeGlv9tezv1HfViX64Zi+DfcSB9i5ifWJwmYNlI?=
 =?us-ascii?Q?McghZzIahpMB+pTUy5u2jDtq0rLxIP5j9jTU0gMDJ65ObEfAb63/LKif52Rj?=
 =?us-ascii?Q?P2OdY40EYUg2igzMPYwxjHc8UDMfrjNJ1pNOndx8PnltHwOU6P0/trN9qE+o?=
 =?us-ascii?Q?4ASdABPi4WPMaXDBrsxKYP4XGjdq+rBpkSjOZh7DWKrU0insY5ljclXS8ig3?=
 =?us-ascii?Q?kj8+fzyJkPBg364pjvXUbXqYgAxTUQyUe6+Fc3VkvDSvW5N0mVNtw7SvsRT1?=
 =?us-ascii?Q?bSaA4SwNuup/F6BG0Nagdk9z5lYN1X3VZXI5AEAu0vTedPTZ7zlkIWNo2svD?=
 =?us-ascii?Q?HwrJeza8H/piOe5/Plcxd8y32RnJLBfaLEamGWWQqSHXd12eQKLbK24bCSJ3?=
 =?us-ascii?Q?WiV3V0Ly79o70cMrxrIk4sKYJPoVKri8zg/XrUR32EKaQXKmnxMTdR07gfad?=
 =?us-ascii?Q?wkE9A1vhc3yhYk07TeA4p5Er0fQCYwZa7ny5EYz80lZ2R2hCWJJizulJbcQa?=
 =?us-ascii?Q?HfMDzf9WY9b+bB37ebMlcAc1+JtnmZXEk8Dj3ZvEGQvSAT9p9VRMXePT+3GP?=
 =?us-ascii?Q?86VHHL5vl74bKuP6+e5DjW5jkcoGIJWhOt14QNxIa3O+p75cEeV9aS746Otz?=
 =?us-ascii?Q?Jr7LpKohOOpykdCmkKPfIpogV7ED4CFupaPFeH1k014Vr+BQ0RaZVnExuDUK?=
 =?us-ascii?Q?AW1FlIg5znn5EydV9wEjzRFr/YHKMW9GDy0JaURogdjS6I8yt3PrGbNAZZlQ?=
 =?us-ascii?Q?etGvhR9KHxG2H/WCX/s8a43XI/mscdKnLdFynwDGFJeMlQs5S0QhqTNSADoQ?=
 =?us-ascii?Q?jRdClbeYFt4gWKaxqpK0L/H9mZNUmr9syffjh3q11Xa9cpimvw8k1mCIlEyq?=
 =?us-ascii?Q?dEeiyqQvMhVGeAg+8bt/tpOuZxWvGsGK/8wcfD+rOb3x5UiuYWQcX3IQICg/?=
 =?us-ascii?Q?SJYwD4p8ZVWSnH/ZZrl7tNhs5D9gyJrGk5ylo2OzRggWA6qDLVCf7DbRSKQl?=
 =?us-ascii?Q?7QzzGP758NyqQ2UMFaTW8vCqu3XCOihO4uh9IYkeDwQjfj++f3zSXRhYahcE?=
 =?us-ascii?Q?1MP//6qou6S5PIQv5i3j/itNHZmsKKq5fFwUUlmLOOdhKihehbQw9/kwyKZK?=
 =?us-ascii?Q?l9ncrYpZrayPA4zW9RiemK8v5hrvKnI=3D?=
X-Exchange-RoutingPolicyChecked: BquHMD1xVrpudh2GmKdZrAGo7UqAQnGqQSMIgB8ggLT/jJtIw21fUmHvBRiO6HTPIddb+Y/XOurCCpfg9UNrgmnbirvu/qB9ccV440HmwdCujtcMVUYsS218uriBXvhobOwuHHcdHHIwrZXRsjSDRu+YeQqc+R2CoQZhZa9yJ6TKPqJj1cFBenRKberHKD4YwSBIq+y78//gBe4NFX0zM5ykjgp5nM8EYUEJkJtwA3qFIvz5nMn+vVMC/NRDiLOW1BEFCjic5gdASrLVpylrPAvic39XNwHXBzHdOw7vKNoIjPrsIwazC12WJC2pRRsbeGVCO5uSA0b461umG4beWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d0e576-5e0e-4586-ae5d-08df0a8611d8
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:11:45.2799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tE0BzmktqdFea0PH7x+1WiFbx78WbhNCUMzVD4+fX5rOH/cwF5OMsXyhkRbLrxtm2fQnmHzGqfm0iYgtD/xRCiZuTOloCdlWpTlJdIeeaMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6801
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

On Fri, Sep 04, 2026 at 10:51:38AM +0000, Ciara Loftus wrote:
> Currently, ice_tx_queue_start() determines a queue's congestion domain by
> scanning vsi->info.tc_mapping[] for a matching traffic class range,
> rejecting the queue if no match is found.
> 
> The Tx scheduler hierarchies only ever operate on a single traffic class,
> TC0, so every queue managed by a committed TM hierarchy always belongs
> to domain 0. The tc_mapping[] lookup doesn't account for this, and queues
> added after a TM hierarchy is committed can be incorrectly rejected.
> 
> Fix this by skipping the lookup if a hierarchy has been committed as the
> domain is already known to be 0 in that case. Since TM does not support
> DCB's multi-TC queue layout, also reject queue start explicitly if DCB
> has configured more than one TC while a TM hierarchy is committed.
> 
> Fixes: 02b71e570294 ("net/ice: support DCB")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c |  4 ++++
>  drivers/net/intel/ice/ice_ethdev.h |  2 ++
>  drivers/net/intel/ice/ice_rxtx.c   | 33 ++++++++++++++++++------------
>  3 files changed, 26 insertions(+), 13 deletions(-)
> 

Did you hit this in testing, or was it just via code review or AI review?
Fix looks good anyway.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 76b8ff0a72e..fd148848d3c 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -3963,6 +3963,8 @@ ice_dev_configure(struct rte_eth_dev *dev)
>  	ad->rx_func_type = ICE_RX_DEFAULT;
>  	ad->tx_func_type = ICE_TX_DEFAULT;
>  
> +	pf->dcb_num_tcs = 1;
> +
>  	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
>  		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
>  
> @@ -3992,6 +3994,8 @@ ice_dev_configure(struct rte_eth_dev *dev)
>  		if (nb_tc_used < 0)
>  			return -EINVAL;
>  
> +		pf->dcb_num_tcs = nb_tc_used;
> +
>  		ctxt.info = vsi->info;
>  		if (rte_le_to_cpu_16(ctxt.info.mapping_flags) == ICE_AQ_VSI_Q_MAP_NONCONTIG) {
>  			PMD_DRV_LOG(ERR, "VSI configured with non contiguous queues, DCB is not supported");
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 7ee3ea8a709..5914454c7c2 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -609,6 +609,8 @@ struct ice_pf {
>  	uint64_t rss_hf;
>  	struct ice_tm_conf tm_conf;
>  	uint16_t outer_ethertype;
> +	/* Number of TCs requested, 1 if DCB not configured */
> +	uint8_t dcb_num_tcs;
>  	/* lock prevent race condition between lsc interrupt handler
>  	 * and link status update during dev_start.
>  	 */
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index c4b5454c530..71f9155e588 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -839,20 +839,27 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  	tx_ctx.legacy_int = 1; /* Legacy or Advanced Host Interface */
>  	tx_ctx.tsyn_ena = 1;
>  
> -	/* Mirror RXQ<->CGD association to TXQ<->CGD */
> -	for (int i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
> -		q_base = rte_le_to_cpu_16(vsi->info.tc_mapping[i]) & ICE_AQ_VSI_TC_Q_OFFSET_M;
> -		q_range = 1 << ((rte_le_to_cpu_16(vsi->info.tc_mapping[i]) &
> -			ICE_AQ_VSI_TC_Q_NUM_M) >> ICE_AQ_VSI_TC_Q_NUM_S);
> -
> -		if (q_base <= tx_queue_id && tx_queue_id < q_base + q_range)
> -			break;
> -
> -		cgd_idx++;
> -	}
> +	if (!pf->tm_conf.committed) {
> +		/* Mirror RXQ<->CGD association to TXQ<->CGD */
> +		for (int i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
> +			q_base = rte_le_to_cpu_16(vsi->info.tc_mapping[i]) &
> +							ICE_AQ_VSI_TC_Q_OFFSET_M;
> +			q_range = 1 << ((rte_le_to_cpu_16(vsi->info.tc_mapping[i]) &
> +				ICE_AQ_VSI_TC_Q_NUM_M) >> ICE_AQ_VSI_TC_Q_NUM_S);
> +
> +			if (q_base <= tx_queue_id && tx_queue_id < q_base + q_range)
> +				break;
>  
> -	if (cgd_idx >= ICE_MAX_TRAFFIC_CLASS) {
> -		PMD_DRV_LOG(ERR, "Bad queue mapping configuration");
> +			cgd_idx++;
> +		}
> +		if (cgd_idx >= ICE_MAX_TRAFFIC_CLASS) {
> +			PMD_DRV_LOG(ERR, "Bad queue mapping configuration");
> +			rte_free(txq_elem);
> +			return -EINVAL;
> +		}
> +	} else if (pf->dcb_num_tcs > 1) {
> +		/* TM only manages the TC0 scheduler subtree. */
> +		PMD_DRV_LOG(ERR, "TM hierarchy is not supported together with multi-TC DCB");
>  		rte_free(txq_elem);
>  		return -EINVAL;
>  	}
> -- 
> 2.43.0
> 
