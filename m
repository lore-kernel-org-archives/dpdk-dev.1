Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA847C44516
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:38:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9A6540E0B;
	Fri, 17 Jul 2026 11:38:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id EC3ED40B95
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:38:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784281132; x=1815817132;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TRaRcU+7Lxh/0TnVo9ICL+2o1E4lTJQdkEpbCruE2QI=;
 b=ihqB/uTOY0z/2jo7ReC2CLTChJ90Pk4ks1BxMLuP8bOecSIZnZM3iJrI
 oUUBaHoWHaliqwyL7ETBj0//xYRQKsO+RezEmBRbVLT0uTPoGibA3kaD9
 GqFCtwXq/WtALhwDBOPc6wah6MHiaNQrG1hMNXsNflY97z3/ad63UBo4Z
 ETL7nehAl6Zl0plMQwaC732rAQyd+3iCYnw5PDMDovSWabeF1GL+vY82V
 KVidWtfOIjBn9EzOgEwFDYfumD7nXRQ52SqaFw7gbG22P28k0rY7m+2L3
 tqGaOl1i1ABVxnKZkmDRZB6/wDLGvNPB3RpqEwUWxa6aSp13OyOlVUj1u w==;
X-CSE-ConnectionGUID: nttZZpYITnyNsbPQtPSkQg==
X-CSE-MsgGUID: oK2DP1rNSMaoDCuzOSkZ/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84071592"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="84071592"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:38:51 -0700
X-CSE-ConnectionGUID: 2b689N5uSRCKfgMdGaRyjg==
X-CSE-MsgGUID: 44RwlkubRWCWhD30aCiXGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="261027651"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:38:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 02:38:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 02:38:50 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 02:38:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpstTiP4KBfIQBJOdxmB5vQgDyocNc5jqXjhdISzg+vrSabim+zuAhhewUS20df7LImq8/+eMLOEKrHzOGl9+QXw187i472MWg+wcaK3O424AOerP/HlC940SOXU0f5dfALpJVpNdJad8gvWiTir+Trirn4e9CCfYUQGR5rakJoWyS4mivjDvadMau3V4WGAUGTXmbUm9keLL74x3ReU5b79eoo9RpCDwDNJm38lgYc1NokzOUvk5ZBxmVn/lVgudMXwPxTrcj97CZhspnsazNZfhMAT4LHn+uM4EWoP0f0u9VJFbI5t+GdylbRA0wM3PNpZWau1nskRm69Z8uBIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGdSRosh3bf0VWWRwyJrRx6QBW3OvXKK7eelVcVOyv4=;
 b=ZLnJxEOh6b/4GmNnJjNTIQQq3OplSIByUi2pbEqvIVs7uHZEk5cnfbVKAZIKLpTX6TxR5jQcFOJnxI3UTk5POCZRBcN346gNzjxIIAuQyetsMOuxka7Wq2+YNcKtePLCwa+IK032wbHoeJre27hNBPJEVWHpGhQKRZUYutqii2mwqVMmHVFBqRtuvtQVZ2nGpRXKCjUwLIFAIh9NFz0EaYFWL4AKUkCUYWmNGOAK6w8LSk1GJqVdhq46JnIID+Xi78AymGfagSsnf/JSoclfY7kBwXKfYunXAzEpezZGSfP/ugvpAjkOFSUDbmFRYNjJU9rTh8Rwx+nhsWuHye/Avg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CO1PR11MB5025.namprd11.prod.outlook.com (2603:10b6:303:9e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:38:48 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 09:38:48 +0000
Date: Fri, 17 Jul 2026 10:38:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 03/10] hash: fix GFNI stubs export
Message-ID: <aln4I_V8hcMMJCK_@bricha3-mobl1.ger.corp.intel.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260717093006.229370-4-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717093006.229370-4-david.marchand@redhat.com>
X-ClientProxiedBy: DB9PR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::30) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CO1PR11MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5cf7c4-17a6-4eb0-0ef0-08dee3e733f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cEJZHVBr+E+mIO0ASLx/2y9NGVnN+BrTHx5aEQJ6kNgL/s/mk3CD7IkhmFuP3/+MRxboeQIVh6vBZ79lTp4NSF0cymmaKpslfEChdc3V+M1wNyUU+0avVmUCfdEvclYeUIb5vOO401S6qcc+7ToX3JoTZEP7Qs3lVwcxhejQ8bAWZsz/hC9mjpgNCudpbqEO/ZKJo4ni9W8bSfH8/T1R/nT+At8SiLMeJcgrhFaCV4iGnVboexDOuTmeDAyyc/apKB8Af8uVBdQlKiJCyxBWgV8M9NPu6bM3uWr4xWP/ILe20Zh8roIYq+4kQmhtAiEskuA1AiE+LfahdOb7P7WGGRfTfLnskbKqkG9hLOk6i8ssnLpUzepkdalYjb+RmhIJWfhL5VcySpMTyVL0Dt+lMGyeeXLvmVnh2wyoQXNj4qJS06ULlF8jsisNMlkqt+cCZ0+Fj8IpUHMfCJCfHURdiMLwIiSKTcPP8OMJ9U1WuXMv5Zwg7x3MXE5p8Y0p3HMDgE+jRStaBZCXXBI8GGvjzahJwF4WV66vypnrQNDHYnOUBUUnPOz0VQZZXMT58dpLgCDdCMdvumhuqd1gH94oU+kzHOPbG2RNyJib9HFZ3FpmcJ1i5Gadlt662ceUPoXhIrS2paL1cjLyX+OeKMPkUElNpgTLjnFxq77sBoZglNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f2vt0mNzbhOZAJTpH7Y+K8htvdvM4zrIcGX5TJ6Ls0eaMBfE/oJK47CX8/xt?=
 =?us-ascii?Q?gxpTUoTV9ghI2X/b4KRoiwLd0Yq4OcDkPvcf8YB+dHDfFBD9p61e3c8NfwDd?=
 =?us-ascii?Q?BNx/rpxyuv/X0FsGbLlDo+dDcHE1D4UqP2A5ovRmXuxDqSrkhouChbqaJ1y4?=
 =?us-ascii?Q?0uIliev01ad8OMXrfs6922NFwLatBhDaGp3/p6rGjD/p6BaDpEhwDkzSu6sr?=
 =?us-ascii?Q?6az1bEQoduXARvOZyBn74i6PForjBvpCntBwOQHx6GmicuHWY2/V1Rpqmufq?=
 =?us-ascii?Q?TyYasNrodZHyvOtqPO4qjK0MSFAHawVLOBvnR7ITreXoemszSe6WGBZvxTNV?=
 =?us-ascii?Q?O7hJ3rHldN/o6obDAToHfqTfE+D+XKCcmSgPRadAapQpcCvFK52NXw6Gzugc?=
 =?us-ascii?Q?sSFqNZ6fMplVeSxB/BgrssktQiSkzfBzufvC/ociraSrIDIOVqiUxgGtL17L?=
 =?us-ascii?Q?LQYxVadHYB1/mvy/Ljo7C2aJ6a6unjawUrmzaA3V22qM8RH6Jbb2JLzI35Ih?=
 =?us-ascii?Q?Vo5wLdFS0+th8N5T61HTXW2NLixt8EA1JriU1rDawbusBsSUw24ttgDff1UL?=
 =?us-ascii?Q?6FmLp+x//9+bW2hr2fXfvMFS90CswWozDUrGZt9RQ13EmrmArZwUPHc9wXfs?=
 =?us-ascii?Q?bZk3qZxi4q33I62U9hZ9b9g/CaF6Z00IBuqaBVv5U2siBCSD6DC/bYpqw4Ye?=
 =?us-ascii?Q?7XY6Ed67jU1gJyXeEyvz9LExs/wxnBlEkLB3nPBilK844Arv8Z7vl2Pu0BhA?=
 =?us-ascii?Q?wW0tKJSQKkN9KsD2zdBXDdcX6TPn2vEZGBFkUj4iulMFedKwgSVFsp+v2zLy?=
 =?us-ascii?Q?QjEMIe9ExWQPkRX7R7TlpFF65v2BqS7Nm/niJdYZq4J8Qce4Rz5aj7K2uWJ+?=
 =?us-ascii?Q?PnsVx9YBboz+cbIpXuNPQ6NjrfxEgnNbIqEryUtqRTTYrrp70msH8rcPC0HS?=
 =?us-ascii?Q?1sCCESbSPyrunaSduOWLdq5aPZQEPU2V+iXaLEsYRp5lvzN2gwYaK2OdbIjo?=
 =?us-ascii?Q?dAVwcrfKV1BP30WKcYMPcAH13h6moqYPo25NZHn05ytED9/WZJH7LMsBuhdO?=
 =?us-ascii?Q?L105bvkb3Hugyte94f4OT3oK12bheDjdCJhlU59zwg2LG1/jg4KdhW6Evp7Z?=
 =?us-ascii?Q?GZKTvy1AL3CL/EmtYX8+IGQil58l7BiJTLKuHi/mKBID2g/xV0wmLkQIjtww?=
 =?us-ascii?Q?CDvvCkBihhNQ7jAQFEX6dPigA1ZvVWlDlAjmDwE/P7Scv0eZW2/ywp8uaiPN?=
 =?us-ascii?Q?bAOsvxj79WvWYWzggubrlnoqLZiY3EJ/MiHBT9/o4FPXEWKjxofcR1zkrfUX?=
 =?us-ascii?Q?2209hdswnXtvEWNzCaXqLv5L/GobaI39zI66Zdk9Dzx6DVeLuwjDRoXYX2sD?=
 =?us-ascii?Q?naU3pt2MqAWpuVfTbCNATaVUxEAYV6U78ZJUcyYTgtDUWZJJGoh7VR0Rmww+?=
 =?us-ascii?Q?CkB5idPGYHKk2vibau/pXA8sd5Vou92ydlWvYzM4fuXz0o6VevrBA5/DJ/4C?=
 =?us-ascii?Q?xEGXRAQffxnekflsT9fKAjahNeLyI+hmFyBnpXgESH/IRtq+uQfLGpDzdAQD?=
 =?us-ascii?Q?c6wP7qV/2Eb6ImCNT3qyjc5hdavAqke4JPM/cK++kzf/fdFoJOhwYJdL/t/n?=
 =?us-ascii?Q?zIELMWYdrFFl+vsBNGid+WqotL1Kpas/kQrK8VNmCR0+dxvhoPwxb7D6h6gV?=
 =?us-ascii?Q?eZ5eHKYp83cA0azGa0JIjLNaXVg5zCN40nuSKjAPF/nUk073FN8N/pdydsow?=
 =?us-ascii?Q?3MJiyY1odkHFm5ivGC8y5WMS778qMig=3D?=
X-Exchange-RoutingPolicyChecked: nUvqmUrKPzhZO/LJ3mb2IYkdZWUCKUlWYvtXpvfhhFKWFE0dhPY+MCVYaeSyo05GWGEfA+VRISJAvFWsgxf7/wTihX/9EvcNqi3CVvnLCo6sHH/Txs2QsUnh6GpmizEJPVqfjc5FwFdlABTIQMb7r/yoBRVKkGOyZqRAls9NZxGED2j7yHC7KuN12mNe3OHKt92mFgqAuu3Nn+Y7+eQkQeOK0UawApVy3ojmAiitKATFY9Ahf9iKHgF4qHWr2/OvQbawNyA4VQ5eA6GHNkvWucn7461dlPflIO+caLgHo6Ck6JnEbOSjj8rWq01oXpTkkuYtYSISm7fyBNmDfD4vxw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5cf7c4-17a6-4eb0-0ef0-08dee3e733f8
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:38:48.3631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRK5G07LhU8d8FyNU0of0+k2ohlH19wbv8FnsgTmrC3nO/kZdMbm26+odqqg+CdVrjWpcrMuPS4wqtrlTQciML2MIyg6cONGdcnsAQpQnZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5025
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

On Fri, Jul 17, 2026 at 11:29:58AM +0200, David Marchand wrote:
> Internal symbols *can not* be called as part of public ABI.
> The GFNI stubs must be exported so that an application may call them
> through the (inlined) GFNI API without requiring ALLOW_INTERNAL_API.
> 
> Fixes: 944a03a5cfc1 ("hash: fix MSVC link on GFNI stubs")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/hash/rte_thash_gfni.c | 4 ++--
>  lib/hash/rte_thash_gfni.h | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/hash/rte_thash_gfni.c b/lib/hash/rte_thash_gfni.c
> index 2003c7b3db..ae55f7f711 100644
> --- a/lib/hash/rte_thash_gfni.c
> +++ b/lib/hash/rte_thash_gfni.c
> @@ -13,7 +13,7 @@ RTE_LOG_REGISTER_SUFFIX(hash_gfni_logtype, gfni, INFO);
>  #define HASH_LOG(level, ...) \
>  	RTE_LOG_LINE(level, HASH, "" __VA_ARGS__)
>  
> -RTE_EXPORT_INTERNAL_SYMBOL(rte_thash_gfni_stub)
> +RTE_EXPORT_SYMBOL(rte_thash_gfni_stub)
>  uint32_t
>  rte_thash_gfni_stub(const uint64_t *mtrx __rte_unused,
>  	const uint8_t *key __rte_unused, int len __rte_unused)
> @@ -29,7 +29,7 @@ rte_thash_gfni_stub(const uint64_t *mtrx __rte_unused,
>  	return 0;
>  }
>  
> -RTE_EXPORT_INTERNAL_SYMBOL(rte_thash_gfni_bulk_stub)
> +RTE_EXPORT_SYMBOL(rte_thash_gfni_bulk_stub)
>  void
>  rte_thash_gfni_bulk_stub(const uint64_t *mtrx __rte_unused,
>  	int len __rte_unused, uint8_t *tuple[] __rte_unused,
> diff --git a/lib/hash/rte_thash_gfni.h b/lib/hash/rte_thash_gfni.h
> index e82378933c..8a72fa9ec6 100644
> --- a/lib/hash/rte_thash_gfni.h
> +++ b/lib/hash/rte_thash_gfni.h
> @@ -22,11 +22,9 @@ extern "C" {
>   * @internal
>   * Stubs only used when GFNI is not available.
>   */
> -__rte_internal
>  uint32_t
>  rte_thash_gfni_stub(const uint64_t *mtrx, const uint8_t *key, int len);
>  
> -__rte_internal
>  void
>  rte_thash_gfni_bulk_stub(const uint64_t *mtrx, int len, uint8_t *tuple[],
>  	uint32_t val[], uint32_t num);
> -- 
> 2.54.0
> 
