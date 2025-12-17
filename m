Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B07BD65C58
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 15:09:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFDE140275;
	Wed, 17 Dec 2025 16:09:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 086B04026C
 for <dev@dpdk.org>; Wed, 17 Dec 2025 16:08:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765984139; x=1797520139;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JYPXJ+ELlALp4XsRhD7yUXxkEXT520ReSK66OZraQjo=;
 b=cbJOmmuKps2cgPbdaodZ7XeGIIPoETAZROBJhj8d8nklTQmYsbIzCo+g
 YxVSly6zdV66aoYLVVhC33DohVGtBfS3BIlwJWlYCCathcBg61u6kNcJW
 6lPC3c7h4nKHo+NrSbtLKJt/oDa5FzFCl31mx3rG+C9nICosHkyNOVh/u
 JXAY+EWbdpcaHuNp9JYFt9jx77YU0XTmbQqlcZ1ylSVJk19a+okQgwUw5
 wkeoXzka5159Il1GC7joUND4s81EFjpk6Bi1GBVkO7yhw5dFFECX1TH3n
 Qb352YL4EUbq7heoNa3/p79VRZm9KKWQpSTBFigIm4lUmt9AhW5O5tf2x w==;
X-CSE-ConnectionGUID: qu45db2tRamRgG/dvpJcRw==
X-CSE-MsgGUID: Od5B5rxIRHulZAvACaDCGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="70500920"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="70500920"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 07:08:58 -0800
X-CSE-ConnectionGUID: hqsoS3/NROaSWFc8Xp5JAA==
X-CSE-MsgGUID: wGSY5VaMRGa1zbEDkl12mg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 07:08:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 07:08:57 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 07:08:57 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.23) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 07:08:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4t1lRi+6jMJfUjLvNIvi+BH2tNYQnsuoAwiJLUf2NeESNvDLkhofz3mU+WWJjqSYvMvUjDlFKwR19a1cVDi8D2fG7SdPBygNvMFsh50j51BpTdRqpMoWzc6CPRhKHrUkSesTvKny/jOAboQpG1UHZjlUp7CmMh6jvcX7+WLP1thYGBhNC9KmrY5xIiEn6NAHVQZFgSssbOq16sGUCDRRpIj0R9Z6zjpg0vjgC4IFO4IUDO0Wa+TYfKV4emsRVDOw/xAGEqwgvqZdOqT+O1DQALGwsHe8ssSkmGNSij5EwbVk2TmK3IopZtZJjajXn80yX1eSKh3h8Glmj3O8pMOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljhELqXTZ2G/NGjFBDod4tezRVKaGapQ02hbNliIago=;
 b=QOgqbkaDlPZ0+Q2sLDdWMefQ4vlCmQe9iYlsw9bnbaNxD5liMyeS4rSwRefUUiKrRnhEVj9wihLK1d24FUgaJcK8wF4svGQKVQbpgXRymXz/1aCEUrzUnbegqjDPt7hS7x/iczTxV2Fjjve1uLQC8kEjMazPaNgoaxKLczoyc5szqYGH6b9WiPJUpucR//zS3urL4QIwcblCrjG48E0+oroVBY7VvsZgVyORYtbl7T9L6kSeUxa0YxWwt1jRoZapO9EXbE8PXvJtp5lG4sPlkTHrWKMMHw4R5D/gl90YBGG4dlpLsQ1SEyt/4uTtKgfnQY0sBrU6VRNgheqxlnRDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6458.namprd11.prod.outlook.com (2603:10b6:208:3bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:08:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:08:46 +0000
Date: Wed, 17 Dec 2025 15:08:41 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/1] net/i40e: unset vector flag when scalar path is chosen
Message-ID: <aULHeab_ajR0ikgu@bricha3-mobl1.ger.corp.intel.com>
References: <20251217145436.3217068-1-ciara.loftus@intel.com>
 <20251217145436.3217068-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251217145436.3217068-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6a7d6d-3e0e-4f9d-1c4c-08de3d7e2ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ng4yppP59n9TPBolwBdsxLoYVtUA0QGv20qCZXlgHtfGN39Lf5vi6rHZ+n2T?=
 =?us-ascii?Q?I6tlns8UB+NpOOas0ePwWVapskfxwRsWvbDwwaYaWRqrhorWStk+mDLAZB3R?=
 =?us-ascii?Q?xvZBdkeY6RfgLxzeH6A5yPU4Ai+XETaaTD6XGdjy1dMjbkXS3PscEU2QTZeL?=
 =?us-ascii?Q?cEltYwagG+vALvYm3BCnocy9zrjYM9zAcxQvY+wBVxlG+QqUa+CRS9sSYmOG?=
 =?us-ascii?Q?4lcqoLnkapLGmzTClnbhGWLyPXrsfNU6CsjvvSbByi0dSnR7wADJpMOg3Ydo?=
 =?us-ascii?Q?IH7CaSZnBFQ4NxSUyMrzaoObQOCVPm03piruJi4UyZCYkGSpcNySAmf5qUNk?=
 =?us-ascii?Q?sFIv3I62CRY9oGDEfzIgYCMDSU2y1dKHCqZMfudlOSEOtPFDrqFfIkugQOT3?=
 =?us-ascii?Q?GA4plQ5Xwd4nYf6oGmKC8kA4P9BFlOYWGNP9+QKWEPuqFlYnp85zzgj+0gMp?=
 =?us-ascii?Q?7DeG6A91Pp69Ma1QZphvSqyHCjMsOhrdj+FU5XEigW+vSrHOGDBPH+AWao9/?=
 =?us-ascii?Q?YYmTCdaW/n0UUS5GTNH+lW1l0qsKAGikTHPmnV9Zy1L6UHm2PhCFk9DfxERU?=
 =?us-ascii?Q?xG6aEyG3Qs3DE6FxUwLwfsDuu7jLzBlSfZyRC6cvPBWdLYf3mZteBRivuDQk?=
 =?us-ascii?Q?io4xHDmwmpTUP0YywTdOd+2F6bSVjWZzUCN0MTKLeHHu5huafi6kGxDXqmKp?=
 =?us-ascii?Q?L/uqRBKaxP//b9i3dmaamQ2VftYEKcO6ub8+IVPWtUnJ/B2paHyhMlwnGt2U?=
 =?us-ascii?Q?vzOgKaS6+uKNyef+n2EBO7DE2Db+MNDG+B2NnEqffp7ALytV3UON9fnycaBU?=
 =?us-ascii?Q?CQlt0sQBz2M3IPSGa9h+vOLcpfoYZnZY5JDzvSb1jARrKG8WwUYxjHxsRt+y?=
 =?us-ascii?Q?pE4w5emA8OjqDSJ3LDAxw85Arj5qRFMdc1YktZS+Eq5nEKE5i9gxKu0NbKIG?=
 =?us-ascii?Q?uGtDXY9XKnNjHnnafhLGP6f9yqJ2Jzq+FHy9hDYS/R23GwywelxdxFC9r46b?=
 =?us-ascii?Q?OFUHZUoQqj/6GmElA2+ZPVPKLjvE1qkPzDDgQRtBW1d/QVzOarYXmW9qtD2V?=
 =?us-ascii?Q?qpB8RoHoUDJdB6F137khm5zUczeEPYc8GS40D9AffWzUjqCie5uxL778f1qz?=
 =?us-ascii?Q?FZ8iHm5eB22qqjzA/9tS193yyGwqYLblbMt2B0Hf4YfKNysdmLBSYtjw4XkR?=
 =?us-ascii?Q?AVQCV8JeAcDE1TiMxOYBAPC48Emp4mYRZN5eUAYYl2xQtMhcPMGL0m8wxd/j?=
 =?us-ascii?Q?orypNxAouoZHBXiFvPG3SUn1jEiJ4TYHELvNA3ebeBvqvBqwc2Px7tm+0Kc+?=
 =?us-ascii?Q?qMFPnh+tRfL3aoQGQUL2oAXqf3I88u7TiPrZ4zSQQtskQLkBGgGMWNyKxb4+?=
 =?us-ascii?Q?+N8KKFR0Uq4m1Ed/3kfroKtqQ6xGagJJVIw47W1v5n3pde3QzzK3csciL4Zl?=
 =?us-ascii?Q?TszKith/TKhEobQFAvAqsztea2DHy/ZT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oBDTSecmPI8pdMYzQUCt5GPD7J1+DI4qYX+O9U2GKj4BRfIh04U8belJsJ9j?=
 =?us-ascii?Q?QjNKw8HgwVj+SKWb3pWHUjutEOHMgC384G5LInNmULOwwYU1lMhvg5lLVLnW?=
 =?us-ascii?Q?nBHZ0Pi0SQ4snPjHhsyaJklRi6IlUjSFvz3lbeuwi7PL3IF0J/XerxksNRSc?=
 =?us-ascii?Q?TBk+vdFachN75C56Jklz09AqWp+7b3Sekkno2Ks2mnNTK6vRzunRNY08//po?=
 =?us-ascii?Q?WYLc+EmgUTraGTbPZFEJpbUDiKcYQGvRawSmK0VPnB8UQ0ai8MEK4aRv34+g?=
 =?us-ascii?Q?DeBz8tA0Dr3pvR59mMPakKWOXDggO96AL0NAdEgIHV5U6SIQEJDmOzEf44Eb?=
 =?us-ascii?Q?XdKjEfE9EwITVzjvJpAL/Ow2Oge8StyJexxVEIV+mYoDxeZOG0JGFeuvHUHU?=
 =?us-ascii?Q?1tv1oD43tLPilOBbVcLYKqOKXcdAPU/tQMmimfQRalPd5uWWrHPWQgpBxnxn?=
 =?us-ascii?Q?oYxSHwku8BK6FvtsCWLjIbavjJUZe92VHikXIQTEV9Gyan1eyrXmQ5ZUz4lU?=
 =?us-ascii?Q?40ySuXU7g7ZDi/MYNlEzVw12NUDV2BAgUXrOqp+pSelfo45+3pB/0vtPXTFL?=
 =?us-ascii?Q?DuOUU5U7U/pBDVA0Xtae3pdtuvzx9eyCybcFHwphFwRcORa+yqTpXx9ixk3W?=
 =?us-ascii?Q?OqUbE3c/UEUDdsJgqfFZVZkKHGUX2sWCrmtfFqqOUGTdGbhrCOfIpdsL0mqZ?=
 =?us-ascii?Q?X6rWI90oeke7I2JIpF9EZXrSXOuyNWBaAiXaBy7ZlfICxVMOFsJMbkkThwgI?=
 =?us-ascii?Q?u53U6JZjgfi0vHN6Zen+ArHSHMi0Dcv/1NcTEHFF2Nz6KIFNnVWgksoENFIz?=
 =?us-ascii?Q?cPMYEpwcdBlgRyW6sZg0Kqlug4g1xM5p3D2L/DfZQQ1n560v38tlJ7xtY3Wa?=
 =?us-ascii?Q?4oYj3YCklLUWqkp/QNngAVhw0P8BsNsOJywMG2xONbJXIPc1Gon1k+BgbZA4?=
 =?us-ascii?Q?NUoNEgXy3Zd9ONViqNvBR+oYR6Vsx91xA9ay57Lp7TcwfgIyxBVdq+CKauNz?=
 =?us-ascii?Q?mjr4GHi7IoSDWv4OjlBOq6l8JVaQP6fchtGdu4XNpxsC4/lrGwY0e4t9+gd4?=
 =?us-ascii?Q?vLVqxDL3Ry+pITFXMpGx09Eii9H3e8vvZh+YfDd9DOhgBArGYFBT4A47wxZQ?=
 =?us-ascii?Q?kNlZ5Fd7lmzSkpf6FuEicUj5AXGl9L7IWRCXgAjhhKmqFE99v1ayadggmcyQ?=
 =?us-ascii?Q?DpP2DIKrrcfSt8QOmrTlSyD10UMu+ARna60RAMiOrUfQLVGrRnmFTMRAN7wo?=
 =?us-ascii?Q?4Nb8+kAzIDy3L2gk/eB/4500KvOMznkSR07Lbcb1bf1G+ZB/V0EAcwImhdfm?=
 =?us-ascii?Q?I2ZA89j4EGiU+nmFw3hjwtk7K0WxX13BLuyrvIIYOTehXM6aKxXc0m+jZPfg?=
 =?us-ascii?Q?6qE0okP4jpGrEEW/5q8mDWmJgq2ig9/VSkKehpjhcNBsxYV3wnKpZ/f/QmtA?=
 =?us-ascii?Q?61jOndDruoCHeXhX6m/hEV3pmwSL0vaV+uxT6XmrqBZFNAYegXA+AjQHHAEk?=
 =?us-ascii?Q?hsSCL/DcB7AN61sNGDPASb19Je4DET8pF3iqbg8n967snQtJH0pF52ULTAUp?=
 =?us-ascii?Q?jELBIlxVrYNxE2M6gStZwmbKb+bygFMB2ukBnyEZYUq+dtCvRgrNb66dt5Ro?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6a7d6d-3e0e-4f9d-1c4c-08de3d7e2ca5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:08:45.8810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: il3AnKm+RpkUZAG9ZKt5958Fvadgx9sj+ML2kLTr9WWhIw5TWEAjxpOPM0LA108U1CFwBo1dM2MmOZQmjy9cJvJIPk55ePSnG1K0WRC6e68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6458
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

On Wed, Dec 17, 2025 at 02:54:36PM +0000, Ciara Loftus wrote:
> The tx_vec_allowed flag should be set to false if a scalar Tx path is
> chosen.
> 
> Fixes: 1ff08bb7ad90 ("net/i40e: use common Tx path selection infrastructure")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_rxtx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
> index 2db58c6b24..dd859bda4e 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -3631,6 +3631,9 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
>  			ad->tx_func_type == I40E_TX_ALTIVEC ||
>  			ad->tx_func_type == I40E_TX_AVX2)
>  		dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
> +
> +	if (i40e_tx_path_infos[ad->tx_func_type].features.simd_width < RTE_VECT_SIMD_128)
> +		ad->tx_vec_allowed = false;
>  }
>  
Under what circumstances would this be a problem, or under what
circumstances would we have this situaion?

/Bruce
