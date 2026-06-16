Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68038CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 08:43:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27AA940289;
	Tue, 16 Jun 2026 10:43:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 2897B40288
 for <dev@dpdk.org>; Tue, 16 Jun 2026 10:43:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781599416; x=1813135416;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=im22ByA5i7LDZr2ZwW9wPwHcLU4xGffkxWEjLntOh7Y=;
 b=f8jxlpdGn9YFSIiHKcIEMUpmJ+5+5AUTS5TVlQwZUTxh5ewCxWWOMHzG
 sdk8VDsu26GjYideNoF8csqlT9zwVAEA9dXDKYzUCZPWyFLdG4WXvjCHY
 XKBQuqQ57FlZPqTrU2vfQcUv0TXUFcTNlkQmDosysdB8DaeuolomeH3Hv
 JYXVoAuuaPJ7so6Bp57lUxDlrHt9hWfr+S1gQa64tKhPjZzFieLYKrNUh
 xOuHETVOf61bwbOFeqmLNH8pKmrdvy9ypevuu4elW6wCQ6WbWIkKpuPf0
 HAKET0yGGdjG0JJRAYvqqqABJIJZhTLdIdJS13b5mOwqiZWVD3rymXq4V A==;
X-CSE-ConnectionGUID: JvtdZnmVSrm3EKe23wUHaQ==
X-CSE-MsgGUID: 5XFxjD+dSK+qFM+z3KIuJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82462934"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="82462934"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 01:43:34 -0700
X-CSE-ConnectionGUID: fmbSS+EqSLKttbtFr9vuug==
X-CSE-MsgGUID: IiMdyTZtQdeqM8petXFAnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="246820998"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 01:43:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 01:43:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 01:43:26 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 01:42:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJAsbmqYqx0agIomYdehM1tRzyQvaV71l53/fG69K5thJhXq4IWPREJ0IOhxuodErLxvOXRL1unLrv14Gl3YI5COEdXzzMC89LyKmkQ/QgFmhDZwCSWZ6WBUgrgnWK7xkSVYiQ+3T6rM+snh6Pa66zUOv/QiNXNKS3ugDgXF9PxGN5JkOWdDu0Ka7+uDGosvr2yJGMhidlS/5ipfl7uics5UNWUUr2OQuSfJXAM8Dp6cvsXCTrn1Vpw/qDxLcTb8D/bRXhk8funjUEL8iVFLW5utFB0pQSJRMy2q1UnBJVAl2HgPO+Km51Sw1A6DVqDFYygkGllLm0mwcLth6TtaxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kq7/jw5oFudHINuOpQOkvquqrrfLun/sgB65By5SSpA=;
 b=ccr6FSF50R+OTxSxAHkiJdv7c9ApkVnLqoNXWrrv7Otspoq/dCvPKAb36x6SsdEqYDdyd0GfXNhVPflfb90mHELmUraSEtpviDUfdw2PcCAhlAcBBsd7zkTTxjlsx3rLglu+DW/EagIffzqxcU5zWD5R7c67NO0wyq7S0BtHvITXd0R8kEIzrdZLJ3t0pmtqsN3ZEQRxtbUrxTxr6sphi9pNY5IXuUwL8/VKbJSszMK2g5uNPNZM7aWG5cM9bxCdeInwvKEVZMNISKLzac9cM0cJUje3MeW/Du6ouhtxrSslW2ltnNAEx+c547L1jR0UBPMAG4WfBbPT0bwJvcaRVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6426.namprd11.prod.outlook.com (2603:10b6:510:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 08:42:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 08:42:27 +0000
Date: Tue, 16 Jun 2026 09:42:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 1/1] net/i40e: allow discontiguous queue lists in hash
Message-ID: <ajEMbsynW5L75bL5@bricha3-mobl1.ger.corp.intel.com>
References: <9999fab5d9491d15ff98ac5aafa248e11df558de.1781521311.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9999fab5d9491d15ff98ac5aafa248e11df558de.1781521311.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: d8afd15a-3816-4f60-c428-08decb8331ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: UUHzaaU6mbe367Onw6SaNQatZNUvdDSBNHqzNju3HAH8vxEVmip2bahgzkRFqQ/W1Im9SGzh7G8nIGc6LpIreXn816s8+gkt43V3jibJOxrAIt5gW/LuzPZCqYucNSII5LXJb3/NUnv0R8buafWqy+pGyqESC5DarzbwbpAQAUYanABdN9cTWsRcYCFWSxhEiA7UY1Yzu4KeaJjNuMpalfiXLYMpn3XLUQ/diSjEgOuISQyd/tpD5LsKTKf4jmWJG/HRmg1UmBQt1Gn3Ts8NW5ygoS+TC7ruTWwJsbresvPDwkx61cuISReKaWvVZ8sH3xzwZF6p2Kfazvqziv26Wk8foD4le/rGxixnx9CTNMymzLXBG5Y1SCNsAAAKrX7DlR+oQAEADbS2Utf4MQda/dQzxVMoaAggp6JKSYLKlVJm/8//DRNFH5R6gmXRRWPQRexOk2szi0ke0lEh8ZCiWEYCCWYf73XO33cCUjlZjm6Q5oOcvNuNyXxpxuY5iiibrlLLZK0bqZJQsC8JzB5e7i9ub3KjE//0IUK8+qO71QYQXbATRV6ZeK8dURiSlkD+VuScMXhHtYI3brvEtyT8LS9NFeyRO3qaMWC2KrxD5NfcuEtrREjuxVWLfX9zXnfmcaEz8ONGWv00QXSJuVXzFbvr8kwWlMptAOx5YK/sFJwp9XVyCQqn4EQwbY3hcvvU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KYx8d2P3ktDFWuGOpym4jlJ00Tep5UMuWOHo2jfyNr5+E9s+V8e5dnHbQTFn?=
 =?us-ascii?Q?30sbfGUSJtfZMXa7p25BRFGjGtTk9U5o/TLNCCc3lpQq5fhl0ZM704GMOKFC?=
 =?us-ascii?Q?Yi33fKZLzdc39nO9H1bdsi5vcEs7zKzS6+kB6+R8P8KWgjqLv0wqnnmuRay+?=
 =?us-ascii?Q?SIi5n/dbR3PGJkulY6/Zq5CYCvn92M/rPakMRKiOxvIDxSn9oHf995f8XpkG?=
 =?us-ascii?Q?mSVLScOb6KmxuiiDYKMY6KUIecSBCVJbhfRiNYWGMVR3jazmh7yHFncmFCKP?=
 =?us-ascii?Q?m3XeEUleoM6S1OrCKtDfB6NTKk5FqXSxyxQZgnnHqDvbGJIBmorHS2oSKjea?=
 =?us-ascii?Q?8br7eDzjUJbhHodrYe1d9hpB8CyppfAVOLS/EzCZwWhET5hyxNJlDJRuGziF?=
 =?us-ascii?Q?qYLcz4QOMLeXoLPIhfkJ2Z3SodQykL5vnBDnldHji6vV5t01k4AKgKXW/91W?=
 =?us-ascii?Q?wpwys14Jr8GNW8mDepH5HIl2mBzdCArSc+RVvZ1P3B8+q4t4cY3eMCRBdyHF?=
 =?us-ascii?Q?0GdM5XGImcjTm79EAwAjqfzZ62cyQu2+oEt+RC1MgbFsDTa6lIvtGU9+v1m5?=
 =?us-ascii?Q?0Hm5wHNZdb1WviGBOpxQUIDL+jCVvPxJI1sBQJtEX17h47vg1hnjcO26gqP4?=
 =?us-ascii?Q?fC07Yj1lk8T5jQobLe6167L57UYggbooE9dqb8lGfw6SMJmOzZ3pR2Rnb0TV?=
 =?us-ascii?Q?aRLC/sqBkMIzTUUS/AkmCjhRsHibKfwP3EblpwgCjpyVbdzONhoUlDNN2ez/?=
 =?us-ascii?Q?UOQcrGjoO+zHKyj/YjZLamcnQaSkGiUHtHrlgCaSpTfQ52EYNYNzeKKXaW+R?=
 =?us-ascii?Q?3COj1S2ZvWpno1eEcmDYqd6VeTQIm+T9f5vNVuxsu3bTbsuiRJjqaS3R1OJg?=
 =?us-ascii?Q?gsduhaKq981jNrYUvGj1Fdwpid5j4WJEQa7wburRt92UJ9L5rTnNTvVUrbPH?=
 =?us-ascii?Q?fXm8TW8SBF0EWrKIqK1ISKgKHXxiEVok2QE2wWSkBhqGxJUHTWjuCc8wOPOJ?=
 =?us-ascii?Q?z3Ks1GUzztExQWv8Ra82uxO4zoJ2MBYSbHwvXXG04S2kCcSCGwnFkPG1HYUL?=
 =?us-ascii?Q?njudsbD7cW96ks7VzVhF6ZpdsW33rudQjN52gzQLUh/IVxOAroGKRSaLRLCO?=
 =?us-ascii?Q?FQ+6xvyXFpDpxZmTnX6c/NpjWYlloW8WswW7aHdL2F1yLFnsp/1LbjDPdLPz?=
 =?us-ascii?Q?NeK6LxPqR/GFpCsX4xCjI/KaJBrJJALBkXd6+nt2rmn0apQFTLp0CRfe0Ly1?=
 =?us-ascii?Q?lecXaWYdkuMzqslYWqXAzCDv7HYOy7rgQtf64epwnd/kV8tNQS14HK3dsvez?=
 =?us-ascii?Q?3I8OomfSdT4lG+U12DTVLn1M3AKn5zXzocHyIHkGw6KJQSAaQSt17SIMWvK8?=
 =?us-ascii?Q?u/GD6pcogq6khTzcdG3HtFaHnexmjC16H6IBpAbZpGhMQBIqRcjzCCZYIVv/?=
 =?us-ascii?Q?yX1U2QiVVQ+2nfY4vJ8IpB6mwDnPX5qRGutfeZHKkOOGUP8XRk0o0mMjzQ0Z?=
 =?us-ascii?Q?h7bMCoZ2HdBYVzyG1Q1mWvPJhymrp2E/g91oEo4+jx6QB6h4R+ciEgdpXtLB?=
 =?us-ascii?Q?MJnmERYoWfWRhEjEVxwh0E1F1O6hAatIaSCj+OlSqbxMBXAl84tDOe0QjzT0?=
 =?us-ascii?Q?rYAfbbwt4KLhjK7lqs4ZTMmrKzYTL7jBrVuUl1jEXUr8mFLxVIvgSYdZh+dK?=
 =?us-ascii?Q?KUsNwgyl48Fi6mt//atYd024kw2thrdlICrw0hEr+sXDRAEjMDog3PNdUM58?=
 =?us-ascii?Q?7LzuZQtPCxSAsWVjB9vv6f/eeu6+AHk=3D?=
X-Exchange-RoutingPolicyChecked: tG6eRfFIU/8EFfKJI3tGGuVt2jXDIXaARx2eyOrLpDwqpvID3V5fOyINpH8TYs71bEcCmMVuErlOIQ4GXWD0/xqjjoJpZ9g3CSbSpg456jMW2TlbgLfowITaSj6zE4l+rD4jeAMTAzt7mzUvA2d580v9K8QQiIVNn/G7RLEJ5YN0hgbhdU0M3/iJCU0+y1in5trOH5Kju1FHUgu6eiCH6C+0HcQXG3IoZ03dZOKLS/FcnPBZ+ZGj+epanA3C6lofZ4/nKF0hWzpKdlhjJhd4blgRWRHna5oNrpeX5UDYVARKWy1s3qBjGJ8F0BA68zUE0CztkhHCHHzJgEA8Mj4pkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d8afd15a-3816-4f60-c428-08decb8331ee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 08:42:27.4253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jd9w/6JBGnwrgbpBi36OcGv5ve5haEWBOC4PebWj/cRkLQdDT620OuOa/JeGPStWtw7Ot0o36/xotXPnjUXH/e2fRXUNNM3e89erH7yxA7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6426
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

On Mon, Jun 15, 2026 at 12:01:58PM +0100, Anatoly Burakov wrote:
> Due to recent refactors and code unification, there are now the following
> properties of RSS queue list that can be checked by common infrastructure:
> 
> - Monotony (i.e. queue indices always increase, never decrease)
> - No duplication (i.e. can't have the same index specified twice)
> - Contiguousness (i.e. can't have holes in the queue list)
> 
> The latter is an optional feature that can be enabled with a flag. However,
> previous hash code only enforced contiguousness for queue *regions* but not
> queue *lists*, whereas after the refactor, all queue lists were required to
> be contiguous. This is an unnecessary restriction, and it breaks backwards
> compatibility.
> 
> Fix it by only specifying contiguousness requirement for the VLAN branch
> where we are actually looking for a queue *region* not queue *list*.
> 
> Fixes: 0185303c2e24 ("net/i40e: refactor RSS flow parameter checks")
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel (with corrected fixline commit id).
Thanks,
/Bruce


>  drivers/net/intel/i40e/i40e_hash.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_hash.c b/drivers/net/intel/i40e/i40e_hash.c
> index 3c1302469c..8b80d0a91c 100644
> --- a/drivers/net/intel/i40e/i40e_hash.c
> +++ b/drivers/net/intel/i40e/i40e_hash.c
> @@ -1238,7 +1238,6 @@ i40e_hash_parse(struct rte_eth_dev *dev,
>  		},
>  		.max_actions = 1,
>  		.driver_ctx = dev->data->dev_private,
> -		.rss_queues_contig = true,
>  		/* each pattern type will add specific check function */
>  	};
>  	const struct rte_flow_action_rss *rss_act;
> @@ -1265,6 +1264,8 @@ i40e_hash_parse(struct rte_eth_dev *dev,
>  	/* VLAN path */
>  	if (is_vlan) {
>  		ac_param.check = i40e_hash_validate_queue_region;
> +		/* queue regions must be contiguous */
> +		ac_param.rss_queues_contig = true;
>  		ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
>  		if (ret)
>  			return ret;
> -- 
> 2.47.3
> 
