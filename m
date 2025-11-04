Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6039CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 11:48:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 103B140647;
	Tue,  4 Nov 2025 12:48:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id F1A9640285
 for <dev@dpdk.org>; Tue,  4 Nov 2025 12:48:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762256894; x=1793792894;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sqiGVGmCfxs7FdLcP6uUzcQCqyQGsxDXzXLDxYH57RE=;
 b=ZM4jVydEx5LjfFJ9ED0KRWP+iV9FZahOQ/Fo1IRXsOoOukgPNuU2bJHq
 v2ZszTeKSqPtGti2dJG/Eav4L22Wv58DZkElWn7Rimc7l3tsILOEY1E2I
 e5JmmJ+o4J9QZj8TsMe5aQezcD/7lj/f/65RJgdtVIXiGT9h7m5S+KWYn
 bXCJIJmlq+f+fnVCkwQc4eVefuwIV3g9PQ7mCcyZjwzfgHReQjb3ERBnb
 bwa+yfbukf0+QVOEXbPKFVcXbZs2seLAwhMydcPcopGqeGOfTVZ9VR6e2
 aJ1xQR8/1EY07bPngKeREXnjd8xqEJuy9a5WbNk0Cjo9Br2xUGvmsXgIj g==;
X-CSE-ConnectionGUID: 7WYY9KPuRrC4p357kzlVQg==
X-CSE-MsgGUID: wxDsfIm2SK2q/hyqhlLE1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64499325"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="64499325"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 03:48:13 -0800
X-CSE-ConnectionGUID: iLHY+n4STeag/Vw/mnB0Uw==
X-CSE-MsgGUID: wLdLFBszTTWCflabermslQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="192227949"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 03:48:12 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 03:48:11 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 03:48:11 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.48) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 03:48:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p37PuddYxDosNFSbyhZM7X54c+uNkn57l9mQVtykb/489kW2uKOt1CvAe6feodktPEGj+W0yjdGWnvsO+EGD7EeS3sxEcPJ2FtNneGsdSHXdM7lbi3Adssfg7FkayQHG07D1vqh6QkzXZ8Hxdsj3IbREXKnmGwnNuClr3E2jBc7zPNVjxlZs6X3eV6qupVlO3mR4hbFmc4Iewjcw8sON81mFFfqWk3EpxYM9jEMS3j5MtbN7hfs8hUVfg2sW/0U/a0hx8uWLT/h7EqEwmkPyey8pUsD5Mihu5C0a0Y+ublI7l8rGaPGJoMLS8n8tzLvg2GvnjMJJqjJ7FsvAJm3yPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlRoRvsSoIAkyOwIwQBc1YiiycKm5QHeIsLiGT2CaAw=;
 b=SgFPcovX4PZ6RtgWartXzGVVNdBSXQy6pVHleF9zc1DWpTXzz1PSm3vhDSV8XDNUvvmhYg7rCm2bjMTJKiunzihWrBJuOjwcR3nPpXEmnLS4qyioX1aUU40tNFGMhCwn7OTIlytTqG1gqSOkxx8fB0aygwPEryIfN058Um7t1xjlaRXlO35kKo2IJj9ntYI+AO8Q9Ftorc1PV2fVw0MxQDICo+0hqxBfUXB/ldXOuBnyTdcNV5dfwBH3jesbWDPfJ6dda9BWDeYUnMBGMugtwJSbf+8+Y+QCrTck2UqoU+K87jJQT2nAkXYt/p2vj+T2Tn97t9Q7FFG2hI5pbpT7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 11:48:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 11:48:09 +0000
Date: Tue, 4 Nov 2025 11:48:02 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/ixgbe: add E610 NIC speed support
Message-ID: <aQnn8r0-vGhG2cAX@bricha3-mobl1.ger.corp.intel.com>
References: <20251103133804.585506-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251103133804.585506-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU7P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: d9dab1b7-a121-4f0e-162d-08de1b980693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wi4Z1chphjZHW6TGqMkAcglvJdNEtmjUC/1+lnQz2QMeJakpk5SlyzAqDDdy?=
 =?us-ascii?Q?p6St/aH4Gj8pbozJWpj9inP3UoveZW4JInNlPSwigeMzY0KXXCdKvDk1TIY0?=
 =?us-ascii?Q?TIThH4GQ9jDsvuevnMXHNCpvCVYp3tnhtfwEH/HRqYmiGYeEFMwj3/q4NJ7Y?=
 =?us-ascii?Q?sB399uU+Kwev5eEBB+FnGGPT1oDvEYLtO3gDEI8sfj84d0VAJowFbPGROGAc?=
 =?us-ascii?Q?q3oLIvdWnFpjSumRpcASJgqqWV8QByl5Lg3xuK5EckJNtmcAfNVh5a/buuYT?=
 =?us-ascii?Q?xwRPpepOTmxWgxbq477r8xjQ1q/wgv6WgMJqzAb3CNNDHgx6AFDC+3qj6g7I?=
 =?us-ascii?Q?r/Bu8VJKXCbyDexuv4FtaJeCKq4+o/dZiOV48y0ucnw3ejpGy70Wz0Pyj55H?=
 =?us-ascii?Q?qd7U+aYln3XruVod9RcMaXBI+AOCbRfQ2iMGNnDbH87XVZD+CCZbBBNbE1bE?=
 =?us-ascii?Q?7LUw01MawuU5uBTE4mVTGM+OwPTi5M578YXiPzpgL5Q3kH2ReHDPi57RjudV?=
 =?us-ascii?Q?ropGp2+9UzwBmQ8Q+b0tGwjTMxOecBLwdI0VMpl+CWV9BNAeeYIsMAmhCoSP?=
 =?us-ascii?Q?fBiAPP15/fHfnrC/8W3ympdrCCZP8cZsnbZSVxf1Zhssdo4a+VBHqXjowzd7?=
 =?us-ascii?Q?cXNQTeyHiKRm29emJ+LZaX/1WIn0npYnVBQclrPzNDuR+3EaKJsmHxIQdcIY?=
 =?us-ascii?Q?lwLGGNqs0k/He+x11gpbZwFAGKvWkXw51osSLvpjvQeVMogLDMvvaVNe/I7m?=
 =?us-ascii?Q?GwJuvvN8zff5YLTXZNk1myW7gQVTdkRoPL263Pc3t11vEFZetezCL2upjb3j?=
 =?us-ascii?Q?wiJfdaypgf2a3aqgAKBseda82D4BY8tUxv6haRYG6cHY86Ox9LMpwkfNC2Ih?=
 =?us-ascii?Q?gGqI5lAHSb4m8SOBMYVdSPFLgUIO11FrVRHR4dWsD0xeCG2M+O1TPtMQYSLk?=
 =?us-ascii?Q?FfJtBCMGuChaUr9NY+3ZoXCDwe9PdP6JXjBiC1glK8gBpCMf1NN9wK0NiNwJ?=
 =?us-ascii?Q?iQS8/R50lMj1htBQzGhxsfnzDRjNukITA8Q5hheFx6t1SUNShUbc2hR6j3LH?=
 =?us-ascii?Q?rDHXHkKJl1myakRmTK026SGEyo2qdxMj3syHJFUQMqCIwLTPvKsXer4mdRwB?=
 =?us-ascii?Q?8j0H34zi6nIkRIrKJdKY+URsmVeR3E4AbyZwCpEDa4VVXUvh1wb6Xa3ujzKd?=
 =?us-ascii?Q?zbPjn42lE9MlVLNDOp530SKGqa8yFhPEFp1sjYqqEeJfC2xxvbhJpcwMNSiL?=
 =?us-ascii?Q?ArXzVxfI6NLprhq8fF3q459mx2s/NKYQO3LTK5Mn+4+rhOAnTXKshxXucNaL?=
 =?us-ascii?Q?oXgsZ8oXQ4SZhEZtap6CsHambkh1aL57OJDER985EV+xA40e4x0rxIqMhUTN?=
 =?us-ascii?Q?fets7axhXIUOH9UmIDftAxQurdr9tLBPM3himZqk6dr1wUreclid5OOvDMPc?=
 =?us-ascii?Q?h8nB5bRIu9A+GnxNKMHFgqvNtoFgzkoe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CR25HBXSK9QaKnbSC6abwFq2UMSwSGUnIC3ulVm5YoxihHGm5UCMlYieYW90?=
 =?us-ascii?Q?Bv7YIs9ocatozDt/gyq0cKMmBM2R5iXo8+bd7y9VeeT9GYFsKxtRPQ8elL3N?=
 =?us-ascii?Q?eJpkJw3Y96fgQSVLsdCToEE/RrWnpIZhWmSpkgLgBKFQ7nf3MfLToLaqufg9?=
 =?us-ascii?Q?UcCoW8FCLjupfkMsOvXxvCz4vHbWVD7enXrBcetdLY2JrJEV+fVIDyiaI5M5?=
 =?us-ascii?Q?qAC/zXXNJqQL/joT9thVYNzLTrAsvAgIq1fuiqDBBIMPEMd+I/lXxmPAElQt?=
 =?us-ascii?Q?qH2/9BtiyoppJ0RQjvAEBFahg16llPDunrQEcUskJ7xlmOfYMNK2+TybmskB?=
 =?us-ascii?Q?P5IRQFYSky3V/BFlxgb0UQA6cIuCQdOuEjnhCCSX2V4Bd9xWGoBEahoT0iZd?=
 =?us-ascii?Q?4tU6ubJlvqdDEmDRqOMs5Xx3HUpU5gVkZQkWJwuGQq2VcgZfeodhv44PaECJ?=
 =?us-ascii?Q?yhODXY/nleVv7rEP+4yTrKBh9omNn69ZDRHDKec/FkOvTPDyMvS5UVdPInKp?=
 =?us-ascii?Q?qJbq8Z6RubsaT7lB8EkGakTo0WGmq72gGv8Sxg2ASzmGvNi1RtHdG1FZkI1T?=
 =?us-ascii?Q?dpmhSQ+9Ff+4RC9bOSbY838oJxzzKk1CFACKrIAuZM4K/prZoxlmV36TP4LO?=
 =?us-ascii?Q?3AlcYG7ga6HxvxrXc6qGUix0+tkP2doJ14k3g/RLVhuHj9aSPFXkF6FIY6Fa?=
 =?us-ascii?Q?Uu4s4tuJ4r5KmBaBdgLVxOEXCpVxf2vszF5ahF1JpheNEf1R1OWX3cQhfxl0?=
 =?us-ascii?Q?Or+4sYg2X+Exjpt0SizY/TLhY3TC7u7gaf5rkJW0s5zeE3vyEYf33dIUes5d?=
 =?us-ascii?Q?SveGsr81MwUk815+OunLy/WMcAL8haRwwqXyqE0IDyhvwNNJmjkSsIiybAUw?=
 =?us-ascii?Q?2f7Fr8zDIKWeS4SmgHAxIYRPgrRsl40CBu8zbHWkikeW916hqAa3Gh0XxRyh?=
 =?us-ascii?Q?suLL59JLArlUx1JkXn+RtP6PsAvg7v4FSzICfZjpJkwGneUN6NtjIE+Xchgy?=
 =?us-ascii?Q?0fY5c3RM+OdYKqURAPeJulYqrxaRKvi616awCdo1NZH2zd9m6kslk36hCBjr?=
 =?us-ascii?Q?z7PfVzi7CPljOX2y7WTnQCGVHEBf12X7Ps7AOAVMx6JhITsmu2AxWGX91MOb?=
 =?us-ascii?Q?jS8y/St93FOALk7T2nkOPdCkeK4qtVWQb1APHbYf9ZwBZRmFCJFvzWuFvLAT?=
 =?us-ascii?Q?/bHWjjraZ0YVURFnhEdB7VIqS8hI07N2+UWA2WmrcYbBrVvJ1OA/9CF3W3lD?=
 =?us-ascii?Q?6yIpwNR/GFa1SpicfbQwmX/Cwb6sqvFPL3QFHtPzRbCcOW0G5NU1qvVRH57a?=
 =?us-ascii?Q?G14T/Xm96rCDjAGiFY67tP4p1EPOxThuaHOfjW0S3rl1qz87a2EFeuxFFtxu?=
 =?us-ascii?Q?dIo8GmSxhHo7jl+8ypMHmBWox9CkZXbRnwnQx2WvuqIRq6MjdimRRHZ9XzVB?=
 =?us-ascii?Q?FZaWWDC0owlwDR9ot/GX3Pc3l90JFtm0rGZAFV42wqx21uTOjNC/ZF1F4D1F?=
 =?us-ascii?Q?REt3pRMHK4KOOBsSGFYVWqGZI3cAQ5nizomoE5EkjoqjD5wP3ToZMuNpObfd?=
 =?us-ascii?Q?OTA9m6y1O/e+ISeCKucw9DuRjJixd/yGeoAyQVoVus/9yUzEOiC0sWInd/2X?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dab1b7-a121-4f0e-162d-08de1b980693
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 11:48:09.5047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Fm0szeY6amviBdqONu3XXMdHuZEN12CGVn205UzAt4uQ4xR23Ri+9HiG3XGB1NMGFprIiY4FDW9ywZKBoflNU4r++7IgWKyJkhTxXZIyT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7309
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

On Mon, Nov 03, 2025 at 07:08:04PM +0530, Shaiq Wani wrote:
> Added a switch case for the E610 NIC adapter to set all supported link
> speeds (10M, 100M, 1G, 2.5G, 5G, 10G) in the ixgbe driver.
> Previously, E610 was not explicitly handled.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index bfc091c367..c01f53d8ad 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -2797,6 +2797,11 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
>  			allowed_speeds = RTE_ETH_LINK_SPEED_10M |
>  				RTE_ETH_LINK_SPEED_100M | RTE_ETH_LINK_SPEED_1G;
>  		break;
> +	case ixgbe_mac_E610:
> +		allowed_speeds = RTE_ETH_LINK_SPEED_10M | RTE_ETH_LINK_SPEED_100M |

Actually, on checking against the datasheet [section 1.4], I don't think it
supports 10M, only 100M. [Not that I expect that many users of DPDK are at
only 10M speed, but still]. Can you please double-check these values are
all correct?

Thanks,
/Bruce

> +			RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_2_5G |
> +			RTE_ETH_LINK_SPEED_5G | RTE_ETH_LINK_SPEED_10G;
> +		break;
>  	default:
>  		allowed_speeds = RTE_ETH_LINK_SPEED_100M | RTE_ETH_LINK_SPEED_1G |
>  			RTE_ETH_LINK_SPEED_10G;
> -- 
> 2.34.1
> 
