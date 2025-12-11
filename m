Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F666D41C14
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 10:25:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D51B40B98;
	Thu, 11 Dec 2025 11:25:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id A816440285
 for <dev@dpdk.org>; Thu, 11 Dec 2025 11:25:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765448751; x=1796984751;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ORf9ZEy5Iogucj1mzLFbyeVmSWF7GdjQzTE4+noHynw=;
 b=H5e6deQmjCfueJc/BA+xZ5/qVq9ka+CV1R2V6pydCaSsMC8A6D7iDwC4
 6Erj/e9X39Remfavif2Bf6tyal1aH3u0XANKZ5CanAQg0W5fTaPc6Y5m1
 fm92qSVl7cs1wIfkq/wCRBiDKDwLT3t0Iaqh7I09sxzExC3IxtD8DIDdy
 bjY7PzAK83fXaWlYN9lIkC5PT0nhI2MmqsG8SjjV/yYAffm5e7MS69eBl
 y5jhjZnGQCnMVoY12w94ovWuYyk1XySTdiyCJ6rRGZoPcwf2ZQSdnGCh1
 1PdG2QmGImJrM/4fEvIpNUkFXULWn1xrBFW6A8311sh+AQoRt/EhIHTVn A==;
X-CSE-ConnectionGUID: 9RoMHLD+RyyqfUOxK8H/nQ==
X-CSE-MsgGUID: SI2J4hjbQwKioKvUiQi+zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="78132136"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="78132136"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 02:25:50 -0800
X-CSE-ConnectionGUID: PgQLXy+vRkGRjF9ckxaxVA==
X-CSE-MsgGUID: 7/4DAiKfRoGRnOm8VcW0Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="196770924"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 02:25:50 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 02:25:49 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 02:25:49 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 02:25:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuAF31SiayodE/Hajk0+GN1VajXgERjPyGunLPL2ZT9OtUX1Wj+/dKWNfDWkzotrYFmWvuKdTvlYdtmU8TQPhcIUNB4Q6oXPv6XnipxGE7f06MDeXZhodvfXam8mS7YJbihvBGQ2R96GXGYWvQhO55rMZpPy/2gULcEc0o4UYcRZKjZHGT7pImRPMC3ACXoPJqR736mpcH2HjSXJSTPs/maUCeT73QdezOnwdf4Me+akXZkiIRZ7CqANFT9R8ACiLnw9l7a71qGmCM7LDHr4DmSBd0mx11DwaqFlBpG+e7PMwtmPs3ZGQoSwiKZXH/8hHdNTBKFtmF8Znt9oSvoQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vfa2LI38U7hKeX6fSWYJ2/MVv2IoRBlRgpMJWKhCk1k=;
 b=drrQ4eL+GArLosXxy4u0tNQZGgqJ5phb7LK2ymzEOvlwBFTIM5yt6R0fKTDI2htvuSRzX4O4I4vOOdBJYc/agFPubbIzyfC3XVAjJS3LOjja7Sk+UY8kS05SDiAi4RwvftViNMl8E27mvIPOgYjJmmLVzFtjfE4k+AAHZsK86m6lQXzduV56Z+BC1a1ISPJM1lgZhh0ypVvqKAj/dnw7P0zzVpPPFNazL70GoPWR1sA9+HyVCPfbwCRaGDOQIAemuLVJknGIYYxj8/Vpr9xpw45AFTOd8WrZgwlj7+R3uq1RUb9v00IqLwXgH2zMpEutYSTUp47vndYU/hVv1slvQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ1PR11MB6204.namprd11.prod.outlook.com (2603:10b6:a03:459::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 10:25:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 10:25:46 +0000
Date: Thu, 11 Dec 2025 10:25:41 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 01/13] net/intel: introduce infrastructure for Tx path
 selection
Message-ID: <aTqcJVadf-dPnld9@bricha3-mobl1.ger.corp.intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
 <20251209112652.963981-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251209112652.963981-2-ciara.loftus@intel.com>
X-ClientProxiedBy: LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ1PR11MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: e18e2432-c14d-46f4-27b3-08de389fa578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AiJZGssUDgfg52XoGpu4dmwwEq761Pyz3rBUZNfZqXZcyZFh6r6Dl3ptB4n2?=
 =?us-ascii?Q?12UfAD6bQb/rIt5BTyLLYqe1rlNKWx3p2RBBDHQg4piXTDjjtvAN+iFrn+/D?=
 =?us-ascii?Q?U5/6ikCftHo3SMftmNi9du31JL6Z0eEic7LEG2muVFnZ80SVH8Bglf1dQHSU?=
 =?us-ascii?Q?dP873UoY1tkwjvJAxrMO/8RCwYHGshMnUKv3e+/c0pSbAndBYn82Yfx4OUfT?=
 =?us-ascii?Q?yGecFwOTwnZC+8cnk0CTR0uJzukZl5JkJUbZKzO3VtqR5phEXvjIaYIesO9X?=
 =?us-ascii?Q?a5dWhcZVp5nxI5D291LOEf0OM/yxO2nMXrIQwhh3xCGBhMhcFpuUm0zDLwYQ?=
 =?us-ascii?Q?QoRGxTJbkWZCc4Npjxh6qpL9TTDH2Wxwh3DF4L99Jt2EggUcqizC4JbLl5Tf?=
 =?us-ascii?Q?z0FaM4h3wOgWC9WJxtCBa9Nex5TPIIXEVZeaTaLScDTtWHsH/h9kQzubo9KX?=
 =?us-ascii?Q?5pgSDg1DBernMAm8OlAAzV6JOJNRbBocahkml8i4VcO44ngVEDKiIunLg0W5?=
 =?us-ascii?Q?otx1zfRLQKBomwvQCPzXKOAwO/brZ4DK+x8Jkxsb1vGphDVNDXwm3t9bPsxv?=
 =?us-ascii?Q?uItlT7rRyC8C+dE7e/C05Fp8xy7KPs4gSGYt0/lQLAkT7CHLPHtoirAe8AlP?=
 =?us-ascii?Q?rIU/Ff4HdqC9CtltV44yPgX57zWdnspOXV73zxqLiOVSS8fVXr2CPV/2J4zb?=
 =?us-ascii?Q?N56qyOJgsvYu7eRuVPP/76+7Y3HshC6W+x5nlCXRmStpg1JiqPq8BmL5FAbn?=
 =?us-ascii?Q?zW8BDEVW/87p1VJ4obVpDeKSmtf/Dqf+i/DkzkecwsxQmysnGS7camUE7QJf?=
 =?us-ascii?Q?9Ugix522CC3NUz1BbdtSz8cmKOBeVLsM4Ymkzh0sPZwQ9M+BYJhZLJq1wemx?=
 =?us-ascii?Q?WrRVF7HvkUSWIyO7GoiJEEz2qyGbSalcomV5Vl8CLCjqIcoOo/GoPvP/7Nci?=
 =?us-ascii?Q?vmJaInQ1HR/8FVCLfgSr4YCmQ3LZaAWrvA4uKuT8ylgQ9J/+XfPoQd2ldcoo?=
 =?us-ascii?Q?cWH8sXuu1N9MeFt/GFLIx45RRxpJVHxHBIfk2nd19W1hcZ/z+pLx0HbDfEt3?=
 =?us-ascii?Q?hbPf8vtNCJ4E4eLLQhvgvbEONBhx8qPpAm0Wv+u3BXmnKl5xQ0B76vrR4HHB?=
 =?us-ascii?Q?ySvl5qW12ZmevsnOCu+7oCfquGlmWsc+vHfdeuPPj8AB4cJCDCqLSMN7TtZk?=
 =?us-ascii?Q?0q4YU50kFRzfFH+cjrAzFci3KdS76f/7ioGDi9ourdn1abd8XOPvslpOjlWB?=
 =?us-ascii?Q?3C//mDjFjJcKn5HxoSFWD4nelYNWEd9mDrzhqxkXyDVgvcDQ2/oEq2FNE21z?=
 =?us-ascii?Q?SKSTXcju4RCi8aUjrO7joedrPVlddxo4O4Rmw2PUQ4lgZu5jTQZQdBlN4kP6?=
 =?us-ascii?Q?pn31nMrm5xyhQZb/s311Rxs9Oc6Oip7Rrcm4csdeB6+nLFISMBz5TGpcbyhO?=
 =?us-ascii?Q?vqW+rpmsLY2A63hwsFtP10PdVS+Xt3X9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wEmSV8a20PAZrI8r52A9co9rDQfccigEwJlUx+PpQ4w4mqch8/Fooprdv+jF?=
 =?us-ascii?Q?r7j6IdViA2UfmCYXTokmO9YPGEKu0xpmKyDrNOqxGR4LOTFhpqTR2TplU6WY?=
 =?us-ascii?Q?W2AgVv/VZupx83pHKyM0U1YbvhWSiVh4iN36LFMw71YdDIcooNt9Hnx0XO3n?=
 =?us-ascii?Q?LL3J+qyWvx0JR0ESTkADBAvtyEhqm8t6YT9NO0uV3466i3rsoRl7LxhTce8B?=
 =?us-ascii?Q?sg+JusFOtVHRM5CoGYHCUXC1HD/ybqJkAmMaQVI4eF1rLcY9duyHd0vrr9Jg?=
 =?us-ascii?Q?xTvdQnHcl0QqPhJWGoJ3Oapc2FttboPoo+IyQHDXuRUuFRqxZ3ZH8Ut/Whap?=
 =?us-ascii?Q?Ia0oGpucnHgmosVsmyOOrUV2X54dA/kpRVnEEwunRHJldc+xfFcTCUmqKFbY?=
 =?us-ascii?Q?zpiDjdlWCn/Ix9OoGuy7fCfrvHxL5xgN/YAWRFi99VF+kAs8DzuKjtSjaFFC?=
 =?us-ascii?Q?S/qTu8wjxaauSlanUzUT/4t+ZOJq1RjkaIECRZVbqVrDsja99BWSrZKAoALt?=
 =?us-ascii?Q?8utercvw7zMGbiN62xNBUjnr6qg6k3Vafy7dwijxB19sR1kXeYLmj4BXK4cL?=
 =?us-ascii?Q?8Qcap79OTI+gA5IYkxJA2w/TMo9OrhaSAQm32A9aunX4dz7VjTPb9SWq1vLr?=
 =?us-ascii?Q?VPCHks5GE7rDYlueFu9+IWbPiSAm33wGMpaJpfBGi2Nh8ywUvb1/16MA2/mm?=
 =?us-ascii?Q?+P8HRCF1WZ4BvSREiT7jU1+Jqvi2EKdcBcTCuzyTslB8NnAroBVTNAkxbIrY?=
 =?us-ascii?Q?MbOrsfnuf1a9/24TaYAFyZh4QR4N/Ef+7O89Rut2hJu+sOLW2qcP0+FCh32v?=
 =?us-ascii?Q?UUzG/4vIf42rwHod6u31jpRQQLzknphuq2aeJAmaV2S0kUVX2FFdEqBcqhkA?=
 =?us-ascii?Q?4Q43j/CIZowFiuA2NJNmAdlGu4+WnsY0hWMe6i3aaqlbc+gXFwkYSzaRcKTa?=
 =?us-ascii?Q?rDBMOYbmte3PCdH6Szi/KjA9GyghlfcZwHeuL9/bmGWkviohRNB3mmcCi7mq?=
 =?us-ascii?Q?N/Nq4MSkR9M1518LmSTEOoBMwGTFWWk/7WOMg4SdCbFV478jKTtJCKfc1RQF?=
 =?us-ascii?Q?Uv1YysYuoNgDghQhGB+PYlblVot44ibK5UhtebwXr/TokNdAoFMcNN8N/Whg?=
 =?us-ascii?Q?urgc8+s0P8kSgSfi+rg1IdNTLzx8J38lHLp/Y96EZSi8yWWw2afL9pnypGp0?=
 =?us-ascii?Q?D32brLm4UdS0IX46O9zL6PMAVX4VLjorb6TBFEjCz8wWssbC4NoORA3fUerx?=
 =?us-ascii?Q?uhZLto4akKN5Jn/ELU2Wc3lROYuvfD9nZ/lj8pxOQ5gZrZ2CySSGYdgYI3KL?=
 =?us-ascii?Q?Z91uLNMqdo/IoPE4xwBgswGqTBYjkfjC1Z1vl1tiWJEaQ5Hl5U0HM84k2d9W?=
 =?us-ascii?Q?z9StGJjx0n9GrD+31gP/o5SgvcvYuC4VPAn1SiQTkF1URias2yAP81sJUnTO?=
 =?us-ascii?Q?WUy48rzYntqd4oLxrs/fZn3Eca3faoTJzBadVfWQ/7Ie0HnJ4eBPmUqlJoTV?=
 =?us-ascii?Q?qJL3mLsG0LwM74K4yt2llkKzHXshUV9C0TQo5rj0bSN82kgGuPlXOgyUZj0j?=
 =?us-ascii?Q?27xJ89/lznQA/8e8+JiRy567QMYwsDM2B+aN6Bdl4RTwmkc7MVx8SZVXY6zb?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e18e2432-c14d-46f4-27b3-08de389fa578
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 10:25:46.2599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bl9hTHoYqXLzlAmZdd8I0HNhCKMFEBCWv42mHYe4B5ehX2Ko1AWK8fxDrx8D+vYzgng9idw7yewQdQwvp5WuOGS8TV7sHUlzl3yvzVVPmec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6204
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

On Tue, Dec 09, 2025 at 11:26:40AM +0000, Ciara Loftus wrote:
> The code for determining which Tx path to select during initialisation
> has become complicated in many intel drivers due to the amount of
> different paths and features available within each path. This commit
> aims to simplify and genericize the path selection logic.
> 
> The following information about each Tx burst function is stored and
> used by the new common function to select the appropriate Tx path:
> - Tx Offloads
> - SIMD bitwidth
> 
> The implementation is based off the Rx path selection infrastructure
> introduced in a previous commit.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>

Generally looks good, a few minor suggestions inline below.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> ---
>  drivers/net/intel/common/tx.h | 71 +++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index 5af64a4cfe..c6c1904ba3 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -8,6 +8,7 @@
>  #include <stdint.h>
>  #include <rte_mbuf.h>
>  #include <rte_ethdev.h>
> +#include <rte_vect.h>
>  
>  /* forward declaration of the common intel (ci) queue structure */
>  struct ci_tx_queue;
> @@ -117,6 +118,17 @@ struct ci_tx_queue {
>  	};
>  };
>  
> +struct ci_tx_path_features {
> +	uint32_t tx_offloads;
> +	enum rte_vect_max_simd simd_width;
> +};
> +
> +struct ci_tx_path_info {
> +	eth_tx_burst_t pkt_burst;
> +	const char *info;
> +	struct ci_tx_path_features features;
> +};
> +
>  static __rte_always_inline void
>  ci_tx_backlog_entry(struct ci_tx_entry *txep, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>  {
> @@ -262,4 +274,63 @@ ci_txq_release_all_mbufs(struct ci_tx_queue *txq, bool use_ctx)
>  	memset(txq->sw_ring_vec, 0, sizeof(txq->sw_ring_vec[0]) * nb_desc);
>  }
>  
> +/**
> + * Select the best matching Tx path based on features
> + *
> + * @param req_features
> + *   The requested features for the Tx path
> + * @param infos
> + *   Array of information about the available Tx paths
> + * @param num_paths
> + *   Number of available paths in the infos array
> + * @param default_path
> + *   Index of the default path to use if no suitable path is found
> + *
> + * @return
> + *   The packet burst function index that best matches the requested features,
> + *   or default_path if no suitable path is found
> + */
> +static inline int
> +ci_tx_path_select(struct ci_tx_path_features req_features,

Is there a reason we are passing this by value, rather than as a const
pointer?

> +			const struct ci_tx_path_info *infos,
> +			int num_paths,

Minor nit: general the size of arrays should be of type "size_t", which
matches the value got from sizeof, and hence RTE_DIM. Since we don't need
to support negative sized arrays, an unsigned type is better generally.

> +			int default_path)
> +{
> +	int i, idx = default_path;
> +	const struct ci_tx_path_features *chosen_path_features = NULL;
> +
> +	for (i = 0; i < num_paths; i++) {

If num_paths is size_t, "i" should be an unsigned value to match. I'd also
to prefer that "i" also be defined inside the "for" statement, since its
unneeded outside of it.

> +		const struct ci_tx_path_features *path_features = &infos[i].features;
> +
> +		/* Ensure the path supports the requested TX offloads. */
> +		if ((path_features->tx_offloads & req_features.tx_offloads) !=
> +				req_features.tx_offloads)
> +			continue;
> +
> +		/* Ensure the path's SIMD width is compatible with the requested width. */
> +		if (path_features->simd_width > req_features.simd_width)
> +			continue;
> +
> +		/* Do not select the path if it is less suitable than the chosen path. */
> +		if (chosen_path_features != NULL) {
> +			/* Do not select paths with lower SIMD width than the chosen path. */
> +			if (path_features->simd_width < chosen_path_features->simd_width)
> +				continue;
> +			/* Do not select paths with more offloads enabled than the chosen path if
> +			 * the SIMD widths are the same.
> +			 */
> +			if (path_features->simd_width == chosen_path_features->simd_width &&
> +					rte_popcount32(path_features->tx_offloads) >
> +					rte_popcount32(chosen_path_features->tx_offloads))
> +				continue;
> +		}
> +
> +		/* Finally, select the path since it has met all the requirements. */
> +		idx = i;
> +		chosen_path_features = &infos[idx].features;
> +	}
> +
> +	return idx;
> +}
> +
>  #endif /* _COMMON_INTEL_TX_H_ */
> -- 
> 2.43.0
> 
