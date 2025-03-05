Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E04C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 10:08:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4423F40156;
	Wed,  5 Mar 2025 11:08:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id C635F400EF
 for <dev@dpdk.org>; Wed,  5 Mar 2025 11:08:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741169338; x=1772705338;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=R5U1MR1UhKWxZMVK60eQTaEEdyi2Ma/L0FVno6u/aPY=;
 b=Jm3xwEchR3rq5KQWU4755RzBv7pHsKhedBmzCwfWVXrX3tJby19Rsz4b
 ibEYsHpumcMfZVDdox5W+FUhrBifQcxafjjfPViI0oN1U7sRXlx2vSN1p
 cJQoL8+iDXgwQ6L4Ke7aPRtXgvJDuvP/F5YSA9ENPBmfSiYPaz6u+2Q4a
 739mAhJawg8WZv5x28sSIIlgJ6HWoha9ye+JrRkaLTiplVPsWZBC+7Buw
 LIPMVNxQx/G/Rqpn5ACdto16bLe9n6jIKPjkrGd9YXLDK2xI4Hj8LgX3V
 3pi5pGMzNa6v5yBEs05AUmsamFJ1zqBCHyV7zk/eKoKyeFHr7MBBQU8jg Q==;
X-CSE-ConnectionGUID: XEiPUzkzQKGebjCaQmNc3Q==
X-CSE-MsgGUID: FFAAkUkyQqGiKoB5ngzgXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53529030"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; d="scan'208";a="53529030"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 02:08:57 -0800
X-CSE-ConnectionGUID: 70iOxBjVQUafFC44dKt3cQ==
X-CSE-MsgGUID: VZXNa7LzQBaq9Fx/2mza8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="122780540"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 02:08:57 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 02:08:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 02:08:56 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 02:08:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0XIl60aZvekE38vozJvp22oKpYtxSc77npdEgUpzUyeFWKmjuivaDt3u7W6vhfPX3qk9Ikbd6x8U/rJVfDOiCOKFWJ8WGS9pyv4Iie2GKhjVGMgIYsB/6DoZzLtiKYR7hHwo8F80M9rSMdS4WqMqWp/QPRgzcSqMVNY0XsZHcBLhNvUoXBawACPIpjFkluLpiFheMW/oXdh/0QDj0T4DTkO+7vlXtokB4enanGcMJKR5MRWAu9INOtPT0QMIS+KBU8o38x3cywsCYhCux65PzWrzwgdnX8OvquyGYiQpn0BARe0/XW15nhqM+p8Dw+sRrs2BEIho4eJfVRFPYtztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjyHZ3+M5BceLQSdCWogYCTKTfa4SR4YKtudVZ0DueE=;
 b=olSAYlqVMwY3XAxfDD41P9rYAKeYr+zKTdFM5h3vkeCANu6FM5eUol9JbXNbeyve7q151bjn1czWNwW8bcsGTDZEy4nLaeGDQI2P2eBZqtvUsF5eP5IUfQZKsAgGY5589UOaomQrc4p6GfS7lQs3Lb8FiIli0jyxa2eXLvbTkj2xYzroPXROHU6ussa9xYwQaI+SjWP+XwiSW3cJZeCP0hgCRm8R8unX1j9emxD6OiAZlafYQwrx7IFPt7wMtm36B6oKI5XwvzLhrod/EH+vEKhdMARJR4Wy+lXYcfzS0lBEsmwAEGFs+SKHz3A/M96WJQ7k2YJCtZxflloswPsdlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6538.namprd11.prod.outlook.com (2603:10b6:208:3a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 10:08:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 10:08:38 +0000
Date: Wed, 5 Mar 2025 10:08:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <stephen@networkplumber.org>, <dev@dpdk.org>,
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3] app/test: fix stack overflow in lpm6_perf_autotest
Message-ID: <Z8giob2jGIcDvltC@bricha3-mobl1.ger.corp.intel.com>
References: <1734057571-20367-1-git-send-email-andremue@linux.microsoft.com>
 <1734535286-27267-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1734535286-27267-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DB3PR06CA0035.eurprd06.prod.outlook.com (2603:10a6:8:1::48)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d709c52-00c9-4f0e-f0cc-08dd5bcdb2c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P1wSzo/422L/+j8P+DD6qg1G264a1wSIvA+BHSXwVeEYHzTLBnh1pQvKvK9k?=
 =?us-ascii?Q?x5o5/lQmFMsiRwhvv9Q1eKyRLf5RdJBmNqHt2bPLgo5i2wt8CNvV3hRxKhqd?=
 =?us-ascii?Q?UPYpvmlZM1loiItuM9GjhYJRCVWvSRI3HNUQI5qgyFkHP7eZMxsPOr0FZ79S?=
 =?us-ascii?Q?JHUuFqiXsmxbSpmr2S9+oQMfPw2xZqFMys7NxafEJLs6uUPZUY/XSMyn9Ir5?=
 =?us-ascii?Q?7YCFc7Ws0IYsVDXRk+Lf3hWVyUQOvtlI84z7pGsjAnj6uCZqW8liX5PEFE/m?=
 =?us-ascii?Q?aV3AIlj1+Ylr4Hk7bFoF2Sv2GMoueF8AhYG/AXfR6zU8cXLL5QfIZ8NC3JRF?=
 =?us-ascii?Q?NImd+AfLsf45+kByDi5rANIJ/IQruUYq/BAkPcMPgKUItOQK7/pYvRJNV7vg?=
 =?us-ascii?Q?eIchRCzQCH6+gzvpF4ROV5ns5/1FpYi64LGe3qxj5TnQ7RFQr+Ru7W+NyAwq?=
 =?us-ascii?Q?jboVnKVU25MjR+tAs5I4TQVWoHl+vlMd/YWHeYdWohY2vbISQSv7VkHTxgG3?=
 =?us-ascii?Q?fL5VJOOfDy3p3R7cshWcmp9+nOjXDGtJEdteW6zp5juLMRibtJq6+c3s7Bsj?=
 =?us-ascii?Q?IJUUsBkwIl07V9iNOqatde6n0iGd1SHr05xpSfnqmv59k3Rv/PgP24ziTacG?=
 =?us-ascii?Q?j5OK0eEH9pCpkoMG4iA+h7w8CR36GDNcFjUeyBjBLweLtk6YojhESdeJrvR8?=
 =?us-ascii?Q?trdZhZKnrd63Sw3Js2S2WghPnYguhxHUJYxizRSGHD7bI+3sUeivDSrkWa/F?=
 =?us-ascii?Q?soqyfCqT+IbABxHi7mAOJRFyx13Dn6NOI0RIPkwYrE7+OIncSTz4YKSC8kGH?=
 =?us-ascii?Q?XBigNZLyjiGd1yC/wkIE94ozmE/ruxIseItK16dK1ngOqag3F80Y2ELK0R1X?=
 =?us-ascii?Q?UqeY6v9ngahssPcgdJoPPu6OilU3Wp4tXPuXzwngxf3v4ICUzvrOgVJ+Igqk?=
 =?us-ascii?Q?v1TKHTivMxCVsp+ZwyvtvxwsMbSBh32sgkWjcoahhHwQu9/PEUlOdkhoV6qv?=
 =?us-ascii?Q?tdiWeASxDSPWGGOxGXE5CuNkOCVmRmG6YxXbtAL3ICMgzxgkPf9a9FvXcIlX?=
 =?us-ascii?Q?dVmyc4YiRNWF/F8QueA+pWH9z3Va0TLoa4r0aHYYcx3FSkdlnX9PSUoFDQGs?=
 =?us-ascii?Q?uXOjRoRRPp112Q7ii+E8cGscdwkcSJ8W7T+e1OPNtQNMjESiJLc4hw9u3UPO?=
 =?us-ascii?Q?SzllAc31Pl1MnXRYaKQZBJP+KAWq7jriSQ4HABhMy8Za6m4cgIQgK3s+WBDf?=
 =?us-ascii?Q?pdw5vdYjnT3xQlCaOB7NI55z373bHOSa4kGf0v9cMYztEULrte4EimAdzyV7?=
 =?us-ascii?Q?MuVpiEkVpRZ77uM1vc3CShCePlF8xCseZiiU0yPqgXeyfx1VvVNpBug8cz+H?=
 =?us-ascii?Q?+bYhehatRzVo5vCfhl+v4gnu8KJf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kaQZpZJZ8RTyg/h/92+IB1Jx7nGcU6VwVAbUXAXf0ZHNTs5FsoXAiF/KDMlo?=
 =?us-ascii?Q?cFzYRPlpMiJgoRwD2BDgEhX4vUvtkESTodTpE6enytMjGiZhafn7RSmMZvtM?=
 =?us-ascii?Q?xiySh+tSUlRJLZLL2J4P0luAQGcQgnDKLt5FeWonOnxTrFPmq39Dl0p6yGNS?=
 =?us-ascii?Q?n0Aja7Ot5I0hrcXUyXDcOoerzZcoVSn+u9izHDveN8bxuLDcdG4lyGIt3JIm?=
 =?us-ascii?Q?DCSbKUH2yMG32jXOmtLOo0agP2Xkn37dXKhVxxRf4RCMWcunaYmV0B8yW8Cj?=
 =?us-ascii?Q?hsA2/EJDeqbFcyQSvh58Uwer+pGa3jyBWwFMlsnKDT0FfZvxjXYQeeLizJtj?=
 =?us-ascii?Q?kWlQDth8S6EaOdYkDimCIB2SAvoomMkdpd1VeqbwrzwygalAXOHQjAKErBeU?=
 =?us-ascii?Q?CyGno4V1I5N8V676gqXhtMAeFIEBWE2+P7nk6HEHJ48QoHTbh1QoDxB6Vho0?=
 =?us-ascii?Q?3IrsoY/XluYdJOO3i5FnaM3SrBrWPdUUunIorGwmhsmVwyIBivWV/5P2EION?=
 =?us-ascii?Q?5N/xz+va+MyHuaSQEsZkzEayLGk4XcDrP5oU4LLNgrCojkCNOxDlPsBWaX18?=
 =?us-ascii?Q?ZoCu3x6CYgMQ/3XOBAoVZ33QrPOAcQES+fXwxXOrBkPVT2EBAEIyuhS8M0if?=
 =?us-ascii?Q?btV2GGWBXgdvEzRtV+2bSsx1ovwSefWbvT8AWXKWkwuzFLWZbX2zoKr2IvpF?=
 =?us-ascii?Q?JGeAOqGFIljqLDjO0mpghd5tTYPFo5bC9qwIna5+fIGp3xColc05kOk7KHoX?=
 =?us-ascii?Q?md7ikDBLtePIABXA4jumwvRFEskVb/35kWDSZBxljbVDPpe65jw5O1uTr+Ll?=
 =?us-ascii?Q?dVlCt9iEUTlam3VI1PrVHq0+LxYC5Zm/QwFREtwpocpeDom5JfWLe+zCulMv?=
 =?us-ascii?Q?pu6xGrBQo3dFQgWB40bUlGxgf4uCth0ShvguR/ok+HGTTQwq0JPQD2I34DO+?=
 =?us-ascii?Q?uSXBE8Sc07dJKHKhusNvrpxkQJ1vNhKC2Io72XhVh4Ujcnv/GKhcVcJkEvIA?=
 =?us-ascii?Q?WYCxeluKC6iBUis0dcsEYzK4bKjwagWlWAlfPWrrDOTriXpafgd3nQBbJGU4?=
 =?us-ascii?Q?I4G9E5Dat0R7tq0VCNtQ8zbnMnjX5355h2yHNYYo09t62EAeD/k5jc/dP/LX?=
 =?us-ascii?Q?RQHgiAf3EBKRlhwkVbqAHYGtfoYbR0AB5O3zr8x5aCxHcjiaK6sMawGbRTP7?=
 =?us-ascii?Q?JYWuNCTf4gYbJufrfeFCJuNW/xPD6E4m+kQg3iqRIVDwfEqDgW8ihLmSLof2?=
 =?us-ascii?Q?dkmm4BXVAwniRzb0BFGAfEz6gMd0TN59cD//5LVTszCQO2c5FEznYY9aaYVl?=
 =?us-ascii?Q?l0eTt8KTgnPDaN2Bv3xy7NuDVSaireSjENKZNGqxqkEWRwMqhvFAHB+lXDAO?=
 =?us-ascii?Q?qaI3/2Nw/LoFjEBQ564gGlQYj76uHUQ+TkqXE6vtiCLdxcdjj570WJ9b4ag8?=
 =?us-ascii?Q?8Kl5440qcJm1Jt7ZocwGnNZE9woRy+3FHt5Itgfu/0rGZcrsPWjPaw6Z09Oy?=
 =?us-ascii?Q?5+kiAfVaZUSseHp/pc0mpcheYpwQWGc94/bHlucslL5umORHY4czWkll8zU2?=
 =?us-ascii?Q?DjnEGEtGWvciMjoqYzj+htKoDA0nAy3PAQVhov878tfCRIqkKs4GN22tEpUQ?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d709c52-00c9-4f0e-f0cc-08dd5bcdb2c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 10:08:38.4358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9WD4ZPj5sMaHe/KULcpn6RNGaDb2vrTpliUv/d3DP7JlMusEEh3dhv6i2Hla4zMda3WxS8aZ/dI6FSpzK5UeD1E+zwxvdF464xaHn3/tYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6538
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

On Wed, Dec 18, 2024 at 07:21:26AM -0800, Andre Muezerie wrote:
> Test lpm6_perf_autotest was hitting a stack overflow on Windows
> with both MSVC and Clang.
> 
> The fix is to move some of the data from the stack to the heap.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  app/test/test_lpm6_perf.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/app/test/test_lpm6_perf.c b/app/test/test_lpm6_perf.c
> index 1860a99ed6..59df0a958a 100644
> --- a/app/test/test_lpm6_perf.c
> +++ b/app/test/test_lpm6_perf.c
> @@ -10,6 +10,7 @@
>  
>  #include <rte_cycles.h>
>  #include <rte_random.h>
> +#include <rte_malloc.h>
>  #include <rte_memory.h>
>  #include <rte_lpm6.h>
>  
> @@ -117,8 +118,13 @@ test_lpm6_perf(void)
>  	total_time = 0;
>  	count = 0;
>  
> -	struct rte_ipv6_addr ip_batch[NUM_IPS_ENTRIES];
> -	int32_t next_hops[NUM_IPS_ENTRIES];
> +	struct rte_ipv6_addr *ip_batch = rte_calloc("ip_batch",
> +			NUM_IPS_ENTRIES, sizeof(struct rte_ipv6_addr), 0);
> +	TEST_LPM_ASSERT(ip_batch != NULL);
> +
> +	int32_t *next_hops = rte_calloc("next_hops",
> +			NUM_IPS_ENTRIES, sizeof(int32_t), 0);
> +	TEST_LPM_ASSERT(next_hops != NULL);
>  

While I don't think we need to use the "rte_" versions of allocation, this
is still an ok fix - and I see that in v1 regular malloc was used.

With either calloc or rte_calloc used.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  	for (i = 0; i < NUM_IPS_ENTRIES; i++)
>  		ip_batch[i] = large_ips_table[i].ip;
> @@ -153,6 +159,9 @@ test_lpm6_perf(void)
>  	printf("Average LPM Delete: %g cycles\n",
>  			(double)total_time / NUM_ROUTE_ENTRIES);
>  
> +	rte_free(next_hops);
> +	rte_free(ip_batch);
> +
>  	rte_lpm6_delete_all(lpm);
>  	rte_lpm6_free(lpm);
>  
> -- 
> 2.47.0.vfs.0.3
> 
