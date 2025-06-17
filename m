Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B4FC71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 09:50:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BCFC40A89;
	Tue, 17 Jun 2025 11:50:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 7E0D740A73
 for <dev@dpdk.org>; Tue, 17 Jun 2025 11:49:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750153799; x=1781689799;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=IQZJS89+KsPACu9+pJ3X1Hje52+pHz7EAAeMsOJFrLE=;
 b=QIBU8aAaG40yFfvfmDo8ZQ8JnR0T1IEIYLjEfSap55oF6gMawQflBVWa
 Rk5gVK9KMaqISWYMcBmeqi+wrnThZE2PrM3Z/xLItsuRyzGlW3sQAe8mU
 VnvendumPg2V0Qy28zFK+F6gnRV5ZGb7fg75XK27NCN9LvNAp9zBjNS+F
 GY/Pi34+JPw9EsSlZiCsB7QwKF1nhAKsZpngv5IFbx2dojnEMXMmxwXuu
 Vci/OX9+s7i0jDn3XwIj5jFMtiqvyeMOXaUpVMJNeMo80JhRtNGUJRC4o
 WDtBvZj/aB9agp9GchkV0dpnb8DAZTh6jufEPH3LaS3DgYDkVHtBHfHGY A==;
X-CSE-ConnectionGUID: a1xQM9h7Sqamhhsph/K7fg==
X-CSE-MsgGUID: Y0quXZBdQ22ej1IVlB6/tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52025530"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="52025530"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 02:49:58 -0700
X-CSE-ConnectionGUID: LJWtx4iJRcOP++Z59r1jMg==
X-CSE-MsgGUID: gsc8O9klTyC1sRVlp9HM7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="148561020"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 02:49:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 02:49:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 02:49:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.83) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 02:49:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeJCZR9f96ZCuGa0h1/BWAnf04QVBgBTDMbszwhMMJ4p22/6ZbSAfDzcDHvt+OkDMrAIMEyKppjd/HoDb+UkqoYIaZ2iJ10FUKLZPN3y80WE+80E4BsCNSRhaox9UrZkdY6qf9uMaZhF7G8osnQFTa7FylKkFIPQQsuVEnjtapGKv5B38oAle1kmusfADilKZ1BUImgOgaNU9XNUrdGpCSHvwe5PbmQ8beVnmy1D6L2DdGHAd3MJIbSftTKwYAj9kLQ5k+xYkiVq19hPyeONEHZeIIALIKg0wsLfQoB3BUIWbXGI2Bmc3PDn8zXQpXtESpU9bZlpEE9TYfu7IB27dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bOaEiMNl7uP8xMJ6yPk/zFLlYwlikH/YCBQtQL9wZk=;
 b=HnJjZ4txnmyfGrDpIrgjUFEmdXMjCNAWJYFmGQs28CABi/cB00RdVUEcqm0kMeZC6PWoDfIiEYOxYNswl5qZtl1FcQbooDf4c1bmMhBbTto4ijzVYUEZBVvU2OEqrE4iyeEIjN2LuNumqeDiDX8JT/I7tA4gh9AD3RFm0mXO7PSH/Lg9dNyizeZb4ySYjkBCLLH2Tpaq9fRRffrEC/7XIl0zjOmlCbVcvmh80gVoKLKwC9fw3Gtbp3jxvQo6N6wJ+30IlqOkQSkCmuzyq0DaxzjUd4WEHPzwPhZjyG7afMykMs11Se2draxw/3TQGP8LeYnOQlNMPOjfnxEI/KhrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 09:49:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 09:49:25 +0000
Date: Tue, 17 Jun 2025 10:49:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v5 2/4] net/ice: add read clock feature
Message-ID: <aFE6Hxj_2mdu99RB@bricha3-mobl1.ger.corp.intel.com>
References: <20250610131159.495566-2-soumyadeep.hore@intel.com>
 <20250617001429.551262-1-soumyadeep.hore@intel.com>
 <20250617001429.551262-3-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250617001429.551262-3-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DU7PR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3ba4da-8170-471a-014f-08ddad843e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1OiW7y3JW4L38zQ0yxASuPAJ8/PvxiQMabTvfkcne53FvNhueYi6al1AUdGw?=
 =?us-ascii?Q?3h3AkytmUWhH99eCk3TDUxy+PeuwRJZj2btpQCKZNfsqm6Wy6nQX6xeTU11y?=
 =?us-ascii?Q?c73Doo0gQDDBjzAtXqL7YF7hDq1a9KPnNLtF+3a6JE67bHM6AtChjxNGrbEY?=
 =?us-ascii?Q?7v+y1krVOox5lZtwlNZ/KQK8nF7J5PMFJJGhZ1nnfaQo9eYo9Cqlycd4jfzO?=
 =?us-ascii?Q?j91X/tkGEJ/SiGkdjKOmxAMVRDvXSF2aEmyBZgXi422U0m/kefEeYggiwKXJ?=
 =?us-ascii?Q?8mQyCIlm4p5HrZm0aKlAulI17BHsQoZ2Tz4mlYY8LmQRyijBpQet4zo7tdks?=
 =?us-ascii?Q?3DYC6f01x7E3rB9n5yuhuwZCH8mXjvaklJYuwl6tF6MsX0jf2w+SoixaM6cI?=
 =?us-ascii?Q?KUch1vsR5Taw1705VB3DrVnv7ceEE61Q/GdSApppyp+bHfyUWLnY1XvBiZxg?=
 =?us-ascii?Q?ngwsTi1Q50KvEfitvSrwxN/ZIYgezqHQTaTU3qjDe2MzpZJv1RqTEqtwu8Tr?=
 =?us-ascii?Q?s5ZWoGYn6CuuBz13GFEh5WK5Tbv9rtG2mx/drKjRV5P1ZOCtACdbsJMIie+7?=
 =?us-ascii?Q?vwWDM6Mzy934zpGgoDzbceCy8dWTSwtb52aYo6z298Ha/uftxGGIB8Yg7KZQ?=
 =?us-ascii?Q?+4h8FGyiCuhvcHNyTU9zrFYDtbTvFOwayPuKx+vBwCAl9BQRVIwOz+y2gWFv?=
 =?us-ascii?Q?ZH6j2XdQre2Ji9gsy6T7YdJbWciy7Nht9Y86sLqVHqqI5jMIE/yqHB8zYJ0v?=
 =?us-ascii?Q?iNG4/42/LPDJI9OQukbg6Kvc0wpCBE2/e9FPtRzIif4qaqI/JZEiSxCn4DM4?=
 =?us-ascii?Q?myzbzm7kwl/OpERUh/lqcscgCMKF9VHcvkTFPF8YP71+Kb12M4wUBSXUS0Jk?=
 =?us-ascii?Q?Ckrs8sDz043/g/sE2tV3mq+mgOBAty7QeRko5InWPKfy2xA7nOc8WqtzqquB?=
 =?us-ascii?Q?SKpDoyzTcIvPaqcxLm+25BQhZYlDmqh4Hh9jANNIpJdyZezjjHg41vFT32QB?=
 =?us-ascii?Q?2QoGPeVFLjGJb+rGK2I+F88g5Bq/jRwORFtZhZK3CThGjl/KkSTgwRRiaqBX?=
 =?us-ascii?Q?iYVRkNtadKCdl6M9jdfaMxF0id7Xq+5RGW5rw1JEzXDuOSclYwbG62dpZLu5?=
 =?us-ascii?Q?p7uA7CNq8AN0rSwsX9sf3BeO9om1DXcVBWt+URZ2cuhM1oJhUz1tRnTXF0E2?=
 =?us-ascii?Q?r48J9xSlp+6Ua45lsb075NHoioU3S0eD8BQiXwLHJ7Vx+MiUHsrXPat8zvRK?=
 =?us-ascii?Q?dlL+UjUBmcdd7J6MnRPTkWzReuV//49NPc9mSTzBYdl+u/NpkV7uFrxgIcsw?=
 =?us-ascii?Q?NnWRHCK9vQx5U//7oZCOlCm98tGIZclwtB6AnRTacSksAh1VHoAwNx318O5O?=
 =?us-ascii?Q?t1AoSoAnLW013Gro6ykNCjT0Y3e/gdxiimgppSFA3lqdvcajwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GWc2mIq4ejDmDtC0rUGGRUjU5SNG3ulZ+N7Gepzc7nrR/z7GswBoNG3r6NL7?=
 =?us-ascii?Q?VrCDc0V0D8t4M+KVlf2bt+WVMDMLdqH6nqTZbTB9ynKnuvR448cj++OZ6PRn?=
 =?us-ascii?Q?F0KKf3ba4PYoW75qylYUht+trD+I+SsXt1xEZUhiJuDCC7Dv7f0EyAVgQj1L?=
 =?us-ascii?Q?zvxumHE/MSwC3YmPOIw8ByRKQia84e/S2RPkfy4DIlGp5Da4IXVp0a2Vy6Yl?=
 =?us-ascii?Q?SXLULG4p2HsLmxHrbs/2fsMXUD1mgopsyon+lOqS0YZdDDTdD3+qGKG/ijQc?=
 =?us-ascii?Q?MYBmh0uwZycf87ojQGA9OQ5ynyvchkxvhOUKDS5SkZdSgqqaSi3WYM2m5Hw0?=
 =?us-ascii?Q?52UF513vs91F29XF0JUNYQxH+zzyykFy/BTntlf5SyXIpEWOslvS3XWrjo6K?=
 =?us-ascii?Q?QQ2iiot+GS1+LhlNK5ZOFeK2+w3rmHcVSVHQc8NTpVbYBbDHnSWHH6kAd6NT?=
 =?us-ascii?Q?8ZZPLkJy2SWdoRV+wvHeUHHyDn2xCrWCl3oHnVsmdrE4Fzw+vMwU5U3WgOgL?=
 =?us-ascii?Q?3LDzHHZP67vpzTaftBBK16c+aDBT6gOlt/Zqafuo0ObMZsjv2yM6VbijhQ0/?=
 =?us-ascii?Q?lZdshlTkvZYRVa3iQD8qxV31TrM0THslgH1htuPJ25ZAWqEQTHWv9FTsUDK1?=
 =?us-ascii?Q?25xk9lidlEoqf/WuYQb6nqFhp7hfVACvLeS2LtMEGErvU1hPVwix0uAO/kVs?=
 =?us-ascii?Q?stzVZP/6/+rpbgQ60pmwYYHvVB7wvjP8tCPjBZGf8csWwI/Hi1boORPZdeXT?=
 =?us-ascii?Q?2gYe9Dgvr4sgnMq0gLvG4KB/ahCvm2+om94giazD37NmoUcpzN44Rt/GsroO?=
 =?us-ascii?Q?vhdO3QOHMUpzpAI5bfVxGgy1W4qSu2e9OKqbKnoMLIRxByjSN3nAtSwumd/K?=
 =?us-ascii?Q?VbY8ifHsQUoA56x5axsKTQf4FcaLkKb2ZNdGAYOZsGc0QbnAr0x5K7zJjuej?=
 =?us-ascii?Q?qMyyb7TPZ4uuKehSeDjT2WFyT+WtZMVh1/wXRdsVrTC5h7bRb2WkuvwLSgqn?=
 =?us-ascii?Q?kH+zGZ1oVpVgQSTEUdu1/35IA4fc5QTY8WJECFaz9jH972iUlb0TSY+qsRMY?=
 =?us-ascii?Q?jS/Rj9l3RCIVfE4FRBKkEEjDoxe0QdwBiX68OeWxulRbFWTl0uY7VQydnjZd?=
 =?us-ascii?Q?GDOg4V/Kvc7HEEVL2Pwjr1BjVGQEAmvfBmVltsRmNFREO5kB4AmC0hJVwnZL?=
 =?us-ascii?Q?f9f7L027ZyY+JU+7+W5Ohhvh6nu5mq0pSHyEPqeSxx+3MFKos7sV6yezia3c?=
 =?us-ascii?Q?9CjPD7OxZOO9FZHlyFJTJyFNgERYmEMyHBFst3D7MLwSX/xbYA7F+CHERNcF?=
 =?us-ascii?Q?pmTkyf6ZQXTsTEvekN8NCkceI2U7FgUyo8FjfqNNSbFFxpLoMFLsTSr4jx3N?=
 =?us-ascii?Q?g61lnkLJZr3mdhG2HW0oxue3PhhvIsXuxPhkRAf1tsNPiqntmNfj42zmKxhc?=
 =?us-ascii?Q?Ul3wewYm039pRnBRHYWKtVFwmAYcQRTr8aMyoc8VDfxl4ZdSudGnnpG61sn5?=
 =?us-ascii?Q?SuE1O2UlqQBRDZ2jFTV70IPSzcSdzEiYsok0UL42633+8y7hExFsX4fAOdOq?=
 =?us-ascii?Q?rCDA6RIWBgrDq57aB+zpTnP2JtT4ELtof5jquZ5ioYeq8/guiM7DHYu6xULE?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3ba4da-8170-471a-014f-08ddad843e57
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 09:49:25.1927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82CVpnC7o4rcNk71LzcNuXiYNxmvNTnr4F4sf8HtQY/w7eiX0gD6MiBG+FFyQ+YgjbZ2F1+uH1NmG3p5DmeYL+liiYlTx9hGnenJ93zVzBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
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

On Tue, Jun 17, 2025 at 12:14:27AM +0000, Soumyadeep Hore wrote:
> Adding eth_ice_read_clock() feature to get current time
> for scheduling Packets based on Tx time.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 7cc083ca32..588edbca2d 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -187,6 +187,7 @@ static int ice_timesync_read_time(struct rte_eth_dev *dev,
>  static int ice_timesync_write_time(struct rte_eth_dev *dev,
>  				   const struct timespec *timestamp);
>  static int ice_timesync_disable(struct rte_eth_dev *dev);
> +static int eth_ice_read_clock(struct rte_eth_dev *dev, uint64_t *clock);
>  static int ice_fec_get_capability(struct rte_eth_dev *dev, struct rte_eth_fec_capa *speed_fec_capa,
>  			   unsigned int num);
>  static int ice_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa);
> @@ -317,6 +318,7 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
>  	.timesync_read_time           = ice_timesync_read_time,
>  	.timesync_write_time          = ice_timesync_write_time,
>  	.timesync_disable             = ice_timesync_disable,
> +	.read_clock                   = eth_ice_read_clock,

No need for "eth" on the function name, all other functions just use "ice"

>  	.tm_ops_get                   = ice_tm_ops_get,
>  	.fec_get_capability           = ice_fec_get_capability,
>  	.fec_get                      = ice_fec_get,
> @@ -6935,6 +6937,17 @@ ice_timesync_disable(struct rte_eth_dev *dev)
>  	return 0;
>  }
>  
> +static int
> +eth_ice_read_clock(__rte_unused struct rte_eth_dev *dev, uint64_t *clock)
> +{
> +	struct timespec system_time;
> +
> +	clock_gettime(CLOCK_MONOTONIC_RAW, &system_time);
> +	*clock = system_time.tv_sec * NSEC_PER_SEC + system_time.tv_nsec;
> +
> +	return 0;
> +}
> +
>  static const uint32_t *
>  ice_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev __rte_unused,
>  					  size_t *no_of_elements)
> -- 
> 2.43.0
> 
