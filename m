Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D147CC83F21
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 14:13:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 027644028C;
	Tue, 15 Jul 2025 16:13:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 8DC734021E
 for <dev@dpdk.org>; Tue, 15 Jul 2025 16:13:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752588818; x=1784124818;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=agfCRBSvql7PmwApLqC5ToL+ucSwBDIiQXEgUkPP1Qg=;
 b=Bv4GUG9o9wX5XBgfQpaEmR+D4Lq4FxP17Y+Fk17VuCsNzdzD13RQr/TD
 G0yFnoUby0GoiMyKZmKSPHVY69LXFrp0MejIGg45KAz3AfvVtZ7aqFsEZ
 qBSHFkix4OOo8MTiOHgp6nTDDuueraflMj9YUJEQgWSHGUxnROhcM+N1L
 St3spScCfpXqSqGu1C/xK0+K4KwgGI3ooeYYKpSuoP7u1wmYYhslGdnsO
 sz7Jp6jMwijO+lzRNTsT+IyablMhEKH8gAomHzZSTw88zcKgUhcqsCfj3
 ivuTHGhohajZlBaKYF98sQP0PvvCWAG/RNueKlHyornvx51YhJLA9HO52 Q==;
X-CSE-ConnectionGUID: fb0HAo7pRVS9O7cbcwE0CQ==
X-CSE-MsgGUID: iJDc7wlPQuKDOx51ZE7F3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58575293"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="58575293"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 07:13:37 -0700
X-CSE-ConnectionGUID: Iuc6/YxdShKYBuamUp28EQ==
X-CSE-MsgGUID: +op+KwJlScKohYwakh+vgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="156638634"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 07:13:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 07:13:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 07:13:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.59)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 07:13:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKS45lF8E0ixaGmRqz6dbE2lHclmxE5DtwCnbsMsehEEbnfufGdLkv3//kWy68MffJMnw6PZ/Ad+F5uoUw/dPajWjmqdkjO3wmgx6Tv79E+DE9zJcigqacg3dZ50lLIs6fLeMucFwGgBgqg3T7p+qMxkUn4P6FbT+JOVnqoGQFxAHGtpBNC49PwfWVpeYJd+vFNN6owAMFhdDrVDpY9rHzHMf0noxpPNrBKFc+8r24MbjLHwswPwfNMPTIsavrZf7KWtdvCFV28W3K8XU4Ij/gwooJfLld46gwPk/+obXVFXNLQ6Cv6ERuJDJQJbviS298IY1uN43hWnsCSFJF68xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZLKBue5eT4Qdz8bBYVYQWdkjsmV/3DSipFL6xg1c6k=;
 b=E3cfpUHVlqLz8FnsIhxmU45I57kxR/CWaU5Nz7pNtds/wgc4YAVl5arEHHLTPHQ6JRkZeu7RO+krtJTWiucVNPZFUFfFzdkIOvwpy7s2wf4xMmqXssed31FZAlWlYjl671I/URE05pbS7qoX+6WNKF5DIsh6bqmdfMySMHT2+ZbShhbiAw0M4hCish3EvPfdae02sg6uTg7oau7P6khxW2j+knMw9ZonNDItI83mN5OkI7Y4s9qqbJF8uMSoVmIc/XVKKsnLeBauuXzuZ2YYISagHuycIOilw+cfkXHa88CLUXAPP6EYAPCJihfU0e0wOYsqZa4ang6ADDbYFGwM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB8267.namprd11.prod.outlook.com (2603:10b6:303:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 14:13:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 14:13:32 +0000
Date: Tue, 15 Jul 2025 15:13:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] net/intel: deprecate some SSE paths
Message-ID: <aHZiB2qEyJ1DQL7u@bricha3-mobl1.ger.corp.intel.com>
References: <20250703121624.1050845-1-ciara.loftus@intel.com>
 <20250703143119.1140097-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250703143119.1140097-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: 0601d3b6-5f05-4e91-5f69-08ddc3a9c7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v4pKSRKYuhOvt1rvHbEXgb4Vzh8J3lMrTPlGHlmqn2dJa/i2LYuMSupybtf8?=
 =?us-ascii?Q?WqvobAPJT/Unv0aFFuGwYju/MzH5NjTRyR2qPUWv92Clg5856jWHYR0lN3PD?=
 =?us-ascii?Q?7HiuzZfg2Khia4pTjsvi+G4Of1DL5vB0vZN7xJl0BH+/DtUJt/xL7cO6noUk?=
 =?us-ascii?Q?WzS2afcn7LeYN5u9Mg3AN25/6ik0q4g4Zyz5uChkzVEl8lHuQClt0LZ04Xcj?=
 =?us-ascii?Q?0de66B9XgRtoZLhd85xFy7/6w0uK1n4IJTGWotU82cSXzJ4Vn+V45qU2IjiO?=
 =?us-ascii?Q?8+wdPEmRbGrg3Umg+J9p/FO0Z17+jN74cSlcIaIScRB9CKYAP2Vn6CKJ24jz?=
 =?us-ascii?Q?twohqcjgzd740PPe6akP0D8EpsEk2/SMmISLCx+nSyI3vVcykbf1pazN2UAA?=
 =?us-ascii?Q?nyG2dUQUscJM+SkFt9RidiX4ogQXfpr7WYiVGg5LAn5Yt6ya6l4Ir/xsvgxE?=
 =?us-ascii?Q?31ERrmWfgh5DodNTwjq/cIftJrivYqz0YEhv15Os75BSCpw+CQiAITQsppUg?=
 =?us-ascii?Q?zmIfqkxXAk5AC+RDIs+hR/Wa+3QhyWiyUTgcZqIyZ/C8/BTCUryaCxBChRqw?=
 =?us-ascii?Q?7QD9mZ0irNiohUvvbrX+JQ5Ywflv0aax0JBL+Z4HiouSRt37QImo/L/5pzQF?=
 =?us-ascii?Q?A06/mki8nZvi3/rlKGRfSYXMXd32oAwHk8pzXjlJYMNziTmQlnd4oLdOjXGo?=
 =?us-ascii?Q?e0vhF8/LEMq+gwHHHZwu8gFIsKmFeLFzfW/Rh/+xlIucO51ynKPNUcjr2ZAt?=
 =?us-ascii?Q?/lEztn1N8Dhe920hBnLjqUxOr3I43aLbYFQlDFimsHsFEhqiIiMvlwsoFXby?=
 =?us-ascii?Q?Bil/VqgtLOv1OGCVjOhd4gxi7ELpGolb2NE6W5+DKCDIIHTum71bOpWTqU5Z?=
 =?us-ascii?Q?6JfYKhPfXIOndX8ybk6pWmcHr6QnzUa7aHZBk/9/ntEN0gxLmziNme1wxDcJ?=
 =?us-ascii?Q?DBp1bN6vP/myFmPxQEiguelsSPq1cUHxfoGZ23qIcx5b7uAnY88aq1CapdjI?=
 =?us-ascii?Q?FVjVkr54chrTcEAv9lF2fbq1q5YfB3BJeEZI8d6TaiYHVo8s+F2QupA2jy3p?=
 =?us-ascii?Q?4SKTFY1XimKr+FVlMv/kLytEymvnAHrVngayifuUDyjnAzR0XYxVip6NO7uE?=
 =?us-ascii?Q?fqg39XpLMZ12UAX3Xz5DBtEjqMAMR3l5aIm3yMjgrTxoAKbUvQXIuC700pO5?=
 =?us-ascii?Q?gnlhnU4cEuVFzRtg20T17yXIp+Ld0jMbfflHW+55fh94QB2AAvquuvSUdD2D?=
 =?us-ascii?Q?O/ZDCEd94bMXE1oEipCYYnbbX8STyw4loes4qD+JMPpESvu78KkD0PfZ99pU?=
 =?us-ascii?Q?FOZxVfhm80AqMV//LEjHaLjEGCgNCfoIGNKjFNK0IDumVq3lXnhsVWIRd6CJ?=
 =?us-ascii?Q?Ll3EWU7ZYhhZ7zrNrBBmuureH2iZdNuTHM2Q3YO3ph1WSemphdS+QRoh2BAy?=
 =?us-ascii?Q?ZKpufwvrLB0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FoDcCE8tAY0gC+p8Yzdtur/fELljv6jvh6giQSXdeyTvLVJ0BfVjWSXW8cht?=
 =?us-ascii?Q?PlhKyb7j2YSFDrO14W9U6LRd7XXaVuIcwfxT/mHwmiLQVfLXesLNELiJiC/f?=
 =?us-ascii?Q?+rAeFUaGARJlVUsQtrZ/Mib0bOJqUtU9mYgzKM5PLK8IcPwegjWPs/lGC2ss?=
 =?us-ascii?Q?iNS3GGYP0tV2tr5/0tqLA2gX+lY9RghdtBrfkjA2oC1oqwS14dpzOpJUHsjj?=
 =?us-ascii?Q?ZCw9sghT23PT6+hEx9hzQhFz0un/uL8UCbrP9ES3z+hcEa/hFq8B8cAbUZsI?=
 =?us-ascii?Q?mrydaCXd5Pm58wNWlkbASiF27Dp8NZaSuHhztRJHol84KFGPGNHrhF9oEhp9?=
 =?us-ascii?Q?YX+myMdJwy3F5gno7oK3NRfUTJzP649l0agYbJI6iF8GRGa81keiV24KJy9g?=
 =?us-ascii?Q?4fks5Xu21MYMtRN5u4ed+M3dT5w6sqqgtZpFFafA8rmAitYG4RF/KIXh5VWs?=
 =?us-ascii?Q?8VC9PEAN/GJ9d+Po3sqoNBuF5gTETu+w1vbTLX0Nf6oYo4S7tU2r6LILZbLT?=
 =?us-ascii?Q?YPuZWSdDiZHsXWd4YJo2fj93AC05V2+LhdpvnVv255+MdyMzgc37f9sDdwLo?=
 =?us-ascii?Q?szWwhzpmOQnNyARXFFyyWdbyWNUZLvp6sRCNBRj/EU2UMb2tidcP7PAR7s6s?=
 =?us-ascii?Q?Y21oNhr6vdmhmNuN6A4p0PKHZd7h+FX3Esr+Wk3w5wBaIJUf7houV5u0pohf?=
 =?us-ascii?Q?XXIwC1nZBbEaFs1m+ZBFYk7me4eakzjuI5u94OBPppUAIdPAK00iqEMGewNh?=
 =?us-ascii?Q?BDvWHFP99jFdKNsEUjza3vNfi0y/No9q+GNJ/tyNsiee1r+tQqL0C7gQzplI?=
 =?us-ascii?Q?J7Qj1TBTCIGvQiKih7YKG5/SWlGy1FjnFfR6eyU0dAhoH8mZQFWgekJzqWM2?=
 =?us-ascii?Q?uzTM0oX2QK2D13kOKXYLstjqCi4GhH0q7xAomx3R0c0OgKQO5OO1tWqJbwLM?=
 =?us-ascii?Q?VEbY+pZY3pL9SR6OpERbbXsLxLseW2Un65N1yBjDHLvtQyxEvieBcu8qoL6+?=
 =?us-ascii?Q?Y3JwxE9FjKMey4R5ngS47g4FKLu9wlnaIucNOEKg5syeKxM2Js9x+oIMDKTw?=
 =?us-ascii?Q?ynbF+lLMnehMLhnGleAgeUVMnfCiMuZng5x6bFdDCwFPMVJTx4EoRQChJBbu?=
 =?us-ascii?Q?1x86t5ZnL02JXFozWerX0tekphroRB3WuN2/JzuOBLLxI2ux99uZQHhOc9g9?=
 =?us-ascii?Q?R7qUFUJrJDzAufThGR5PM8EyMzzh+Jjom0GERUrQD57Lcv1b0QW4iLoY2KUx?=
 =?us-ascii?Q?qNYcWVyZbRoScIhOc9cyvR9gBunGwarm9XT24Z2RH2GlZsf5GPHrq/CP07y9?=
 =?us-ascii?Q?n0bXrvErQNr9rzKIzz/V5rUoLTXnAhQVAj5yIXpin3wnvweO+Qr1FhC4CtUd?=
 =?us-ascii?Q?AB2/woHuPEy03TO1JlBdn6SzqWM6DtEBcs0NPt3JJYwuHrp9iinJFITCK0J7?=
 =?us-ascii?Q?T5EHsVI1hfDw27g2nUjoG4edczbrTyjLXig5iH9zqTijSLsVcOpGUb62d+jV?=
 =?us-ascii?Q?niP/RZP9YahDmYf8KWuRyUIqk6DN8pyAnrjxtqbYCX3cCCLfdZzeZQCjxwBb?=
 =?us-ascii?Q?SGbCVKkQ7aHPCq9lpgA4urSGWNd6pkMVv4gYPmuAhccNIFv+2yAVqDKCktgr?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0601d3b6-5f05-4e91-5f69-08ddc3a9c7d5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:13:32.8834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNPqKxKR7BEgh0fRknoSIHRjcKpQDcHCKxXOy/uTYkFl/yrMNVvii48r2HU1EZ3LhZowL1pxKKuo/5j/JOvN2MhFX/Nj8hZFOwHcMm5bwaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8267
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

On Thu, Jul 03, 2025 at 02:31:19PM +0000, Ciara Loftus wrote:
> The SSE rx and tx paths will be removed from the i40e, iavf and ice
> drivers in the 25.11 release. Each of these drivers have faster vector
> paths (AVX2 and AVX-512) which have feature parity with the soon to be
> removed SSE paths. In environments where AVX2 or AVX-512 are not
> supported, the scalar path will still be used, which also has feature
> parity.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/rel_notes/deprecation.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
> index e2d4125308..0d020c9c1f 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -80,6 +80,13 @@ Deprecation Notices
>    and the header struct ``rte_vxlan_gpe_hdr`` with the macro ``RTE_ETHER_VXLAN_GPE_HLEN``
>    will be removed in DPDK 25.11.
>  
> +* net/intel: drivers that have an SSE vector path alongside other vector paths,
> +  namely i40e, iavf and ice, will have their SSE vector paths removed in DPDK 25.11.
> +  Modern x86 systems all support AVX2, if not AVX-512, so the SSE path is no longer
> +  widely used. This change will not result in any feature loss, as the fallback
> +  scalar paths which have feature parity with SSE will be used in the cases where
> +  the SSE paths would have been used.
> +

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

