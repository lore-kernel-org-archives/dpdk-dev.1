Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FA7D2E038
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 08:34:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAA0E40156;
	Fri,  5 Dec 2025 09:34:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 76AD640144
 for <dev@dpdk.org>; Fri,  5 Dec 2025 09:34:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764923666; x=1796459666;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=E2HxGaUxwfl8gqy59dHloaX22AO6OOo+FglsRFfwVbA=;
 b=OZgcKWIgdOS4G/y93IfhrACxyTo0n5zPclzNIt/x67jnpMIwQJohyiJl
 N/HZAZJPBnI47ia9d9a2s1JPTccEHo4Ha3pNftsJfggIywjoPUaG/voa/
 pv4KbGGZ06fIJHIUa0olFpPhapZdB/OT3xwbS1irEvWGkYUX0EscjVlW2
 1PFX95M4L/O0eq3S5O11pbYVZuBmzVe2CkhuLDXwxkQ0+rQHYeXFk4yzb
 F94k7ul83dZfMWOVXCFwjde3XJmgvb1EEKUi0SQta6E1VAuSX+bcgdK5U
 90FaiwMw5r3z98WeN660WUXVYnOCjN1EW5hUTscltvj2N4dDDi5KPhXAB w==;
X-CSE-ConnectionGUID: 0heD18XvTJuoUliYg5EUrg==
X-CSE-MsgGUID: HOupGf7vTKaR2TJYwr1v9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="54502831"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="54502831"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 00:34:25 -0800
X-CSE-ConnectionGUID: iu3XpNJxSlOWOpJittUrJA==
X-CSE-MsgGUID: HAqLdL5tR+eUW8ildvW0Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="200369463"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 00:34:24 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 00:34:24 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 00:34:24 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 00:34:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oign2kvfPVMPPnxQWjCypgvHIiVOWD2guD6a32Atp4Z948VKK+5oufCqsCpOccyqRfCm8qCxGPRxJLXRHYNKOwkhxoldQpL/VOyFl/18xehaUt/QCMc55njLBxo/yiHYdkN0RXd8UrWiaVXpzGyfSwQPac9PuUwXy8QOwf5JW3ZnSZrfVj4ne13fldkO7jw+828BGf+SxZKqPMpPy/aQizxEN83x5VgWmtc/dXdE8BurNXm3wjuxwWWphEhhQrh9gHWhtA635Sb2YXg5iXsI/mjnOKC6rje+dsawtp7FwwlNaSZvPdX8r0gofMP4Pe5JetFcvhvNL9U7YgcjfNjrig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXOfMVVKeoC4xI1v7gM+d3GOnn9D/CcXyggceSWmBKU=;
 b=RHRKIHDq7uOyaIJuINFp5EOBegx5FN/OVDbznh6bhpDcb8vh2JNqfp5VS2mc2QCNs5IOgvaO+cV6/qyjDd9TVscXy/ZYihf3wCN163uPQObRVKHTs7IVkHDE4jPq3H5RkGn5INFS8JTXKjFrAs8+hcmZ9GtEDa4rJw9WQmh01BFvpkuDGXtd0sSHr9rnseYrg/8UadCfLeXjOinDeZGztm6JD6kyWWgyDHfuBzzJZnhygRt5h2969oVTBnrsnyabdaXANmDWsRw3jynYpShtUFqLuP9rYDb2fnDct9wxEkZ1PQJVrADCLkY0rrzJnJy61LYHIBpmk4FUgNvyHkWl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Fri, 5 Dec
 2025 08:34:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 08:34:22 +0000
Date: Fri, 5 Dec 2025 08:34:18 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC v2 08/14] ethdev: avoid possible overflow in xstat names
Message-ID: <aTKZCud5IPLoPuDL@bricha3-mobl1.ger.corp.intel.com>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205022948.327743-9-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251205022948.327743-9-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0308.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a088dcc-788f-488b-a6a8-08de33d916f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8QjmJ8oNa2oAmWMhstrmt5ToBdDug6bQ52Zt9abc8VMXuCAqTgnp3sT9ezG5?=
 =?us-ascii?Q?tULc0MPAEuxoHZIK8AakLxspOcTqXE8usNJSyfeVwL7n4j29t50BA5InVrEq?=
 =?us-ascii?Q?YI2uuCnro2gw6tkfD4DLCqkkr+xC9fitRN9eXwtLOhxPppVeTcfWCdpxaC07?=
 =?us-ascii?Q?TXrEdUS5loe0sU+4SWXa3LXPYTUYUbJYlTgaHj66+tYK34G0502bNW7VKZvn?=
 =?us-ascii?Q?ezNkrtU6Efl5TLmvqWhGXaPM5+TrL/zXzd35tELaIo6KV3PcvKEQ/SDebUED?=
 =?us-ascii?Q?dTWUmF9yaBPVUaCBzLlicya47UdeekLXM+1qom3pJ9LVIP3/yYiNBXbGLeRJ?=
 =?us-ascii?Q?/ONizKE2sRvqOD5hnb4WSkiVMhYmoNjv9QN9THoUvnmi4qMKOy1rJbANReDI?=
 =?us-ascii?Q?On8sOflA8aOEkKSzy95QFrUOaztaSAeEWmr8yJ4K94XtXapYiN927Ccx1RdX?=
 =?us-ascii?Q?6/ZviDGlT7AfXLQCvDFev/hkI1U+n9+FPePVdlZAxsrE79iYAQbf/37xH9mD?=
 =?us-ascii?Q?alNq6b2INXzHZFJh3iYsX9BE05OXYroigOh+YgeAInYCzFtsuyo2hVygXDtw?=
 =?us-ascii?Q?n9rHEm9JXpl2QuirogiYyPPJ3wxdVt/dvHO24cnsCp5+0Jqf7EHUMF/TP1Et?=
 =?us-ascii?Q?r4p4g2CUSokG6tvltMJF9VVTenSjHrgfdRgNkw1+fGjzQzauaUttPBiFfk7d?=
 =?us-ascii?Q?0oKKJ8oNJqsoE6aIPP1Fvh7S9ub3VO/IT+Gj0ok7uUPAzf/HPlYCbwVuNozf?=
 =?us-ascii?Q?Y89bWRwXY+JcD+rkk5foSMxbyv5TCAePz2/JNEp/IdV3BVYyo7b3v1dnoNUv?=
 =?us-ascii?Q?+QpemWgmtqMziV/yXvtu7hx/yOy+VvPLjU2k/LvBVn1TNJqkQiOQhQiRlrYf?=
 =?us-ascii?Q?7cKw+EFa1kVdmpdpgqbrEDnUk30Qrjbn8tjO6yaJvMHBUotvuYjF1ZKGsEWr?=
 =?us-ascii?Q?7lG2OM0AvDvGTtn0MPYSqM2z/eEZ+9yXN5X5nMPNVRR5YHSY8U1ep8qpUnop?=
 =?us-ascii?Q?XfuI3xoBMaChWlB0j6IoX1T+b4U5Nw+ZUnP9LklAcdNiG5+hlRaXEXYSQzKz?=
 =?us-ascii?Q?SJ3kSZ9N0tKjCfLpoa8FR1Zk/AQw7kh5Sc+tH87C6zVHjifByrpicfChPAgk?=
 =?us-ascii?Q?XtihBAHuY0ZUBbWraAcmzSMDGEaxT6WGl5Os5YaiK7c49rntnJoJ1nPgDwqX?=
 =?us-ascii?Q?sAIGuQS44d6MXhi5VQICZEmg9YgYJ5t4/sz6mdi3gZGuvkt2xrJa6rOCeEgh?=
 =?us-ascii?Q?5qEX8adaT5KJCfbkD+JeINh6pX7XWX2BZz+MzawvjMvIMJzAf1a1usMdCoOL?=
 =?us-ascii?Q?8520rjDa+k0fXUiaT4093qnPe4AJbGIY7wX6WHC+Lsp3UpSo73wU63AiY15E?=
 =?us-ascii?Q?ALUH7+4NtEvCJxa56Ke70Vlz+JJ22UC3owytZVsjmbTfoFI9AKhnnaN7Hlw4?=
 =?us-ascii?Q?w6vbsAqjEm2BcFxiNy2d7HANXp52wHVu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oT3KvXymLkRjK0ItGlj9ZX333LytqybZAvzSvaOyqkr6aEEfoDNLqSEz6Y75?=
 =?us-ascii?Q?suhuFkBM7ZHD2q21SIlqvfSVrxjSpKEG2RAq/KtH/aR+cG8NLga5qEMxmwNr?=
 =?us-ascii?Q?hfd+ONduxbqkS2gwneu89qflWsvfttH9/lNigm3HCNonMYnJQOQ1IvuEVZgY?=
 =?us-ascii?Q?6CPcx7V5z9eQ1oi0CwKFeloaqZoGFpv5zsVpcMpdj+OLZLNXGDxs4INTWO29?=
 =?us-ascii?Q?FRgDZXi7SthY67T2/ePm+GfY3KWnUSs4xxrYDMc6W4xkYbwjUqZB4uv0XOzV?=
 =?us-ascii?Q?7A4kt+RQF12f3ganUlEZmxThCoObJN/spdOnYfrqGqA+aBUMgDlBWrCJjbgF?=
 =?us-ascii?Q?YtuwZNfbX+Qd7omvK4yYG1d8nI+jzj/eFbiqWlGFx1ZRNFvWKZOgEu8PNKgR?=
 =?us-ascii?Q?UL1O5XrqfzqfPyc9/JMpjP7h9wj9x2Ltvv546ECnsojpF88GbmV20mvR80Rd?=
 =?us-ascii?Q?7MxDDXCkSlHEBfCHvXfsYIdlx90i2PEoafNPOfJC85ai/A4xWtcjjUx+QtEg?=
 =?us-ascii?Q?WtYQ4i42khyxlavdxLbCfG7luDYVweqCIyMcJs+48IsJV61OFVOY5bDqcnwq?=
 =?us-ascii?Q?DaifRN8kRF6bMQGRGXNLoCkKoRPFdT4CElQsBcJofspVadnYSRj6iW/14ekz?=
 =?us-ascii?Q?UlUZ9oqmYf4Fqo/MrGmQnQ5WuC3I11Or9VnKtwC4Zi/SRm6n55ublMy5UjlE?=
 =?us-ascii?Q?n3V1vOGx66Q8Lhv7k11L9lMW+ZPWtf9pG5gj+MjJt9ONXMa6RAdvhYOPombD?=
 =?us-ascii?Q?xq0AgsW7JztmzyuaiAB4UwmL8IrmVXfGWDCtTvNC8Xm2S1s8o6HoKKsCeTJB?=
 =?us-ascii?Q?AZgJoKZKaEZxyg588iK7fSrdaOrEezcID4Sm+mfRvvE6HUXzNS7e9iUIOq2c?=
 =?us-ascii?Q?rUyXMKTo5lBPyo+Ic+XMcUdDLXjfLEO4tre6n5QdEpS932gBTH6qsYb0wRW2?=
 =?us-ascii?Q?86Z0ns1hP1169VUlK673fFCNfTlG2AMYPUG1VG4YVtZfFcQNKkQCDmCyiMA5?=
 =?us-ascii?Q?U5XuxEfSP5tET0Rq9hZxQ9SgkMfvh5dX8YoajMq/n7OWFNtkftBn6cbVxjh6?=
 =?us-ascii?Q?/iOuv4mlMFAqwmgaW7j9pYZF22a3mBFF0u6meVe3VQpoLnxMS+6kSJY0Os3I?=
 =?us-ascii?Q?VBPDjEvZRyQivrggvRrSc+UHsvIWZ8fnY2CUm0lDnqqUvw9Mq9CKws8PPj9R?=
 =?us-ascii?Q?/SaJEcELGOdptlihshY4u2M3QACddRSZHHWJmUA6qPwdNdeYMj3x1qWinJz3?=
 =?us-ascii?Q?gJQ0aEgDr1Wvz7oXDW2w5vr9xJyu1TvwoL3iPdGLTTJ7kcj5tPGawhFa7Sd3?=
 =?us-ascii?Q?Z/6GBKoVsol3y+V/KfrvfY+2DusFuaDuoI4+R5zrlN9lQtE5yusvUVT2npt2?=
 =?us-ascii?Q?l0z2P3Nbwhd3dK7pOYsEbLIMoTqtCR/04yufgQX6fE9+02zWy89snfwECbrh?=
 =?us-ascii?Q?wcBU6s4PELeBTYUne0tD/qsvX1NZBU4hstu7UaDvqZCK0xxS0OTO2kb3/wRS?=
 =?us-ascii?Q?AO8+R9oIh32TqDqRSJExx812dX05eFPhro6StaT0zfyZajP03wQIPEJAirrd?=
 =?us-ascii?Q?4nc0ww/npSqbbMyzDI3VHt8Tye2ArNqX9kWKRGo5l7/0EpUHS0MK3ojjpqq8?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a088dcc-788f-488b-a6a8-08de33d916f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 08:34:22.1402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mc6GeMRjLNHCr1eSXzFWk7a81683lVSzQAt4iyvoHo9LqtLSq6xQHf2HKHCqtapCnybejwGZSZ/BO5D5IRSOtKxfBXYIfqXSnN+Q99X4zfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5782
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

On Thu, Dec 04, 2025 at 06:28:17PM -0800, Stephen Hemminger wrote:
> The compiler doesn't know that all the elements in the table
> of queue stats are short enough to avoid overflowing the snprintf.
> Add a condition that will not happen to warn if it ever does;
> maybe some day a new long named queue stat could be added.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ethdev/rte_ethdev.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> 
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index c6fe0d5165..20a6ce3450 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -3501,10 +3501,17 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
>  	num_q = RTE_MIN(dev->data->nb_rx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
>  	for (id_queue = 0; id_queue < num_q; id_queue++) {
>  		for (idx = 0; idx < RTE_NB_RXQ_STATS; idx++) {
> -			snprintf(xstats_names[cnt_used_entries].name,
> -				sizeof(xstats_names[0].name),
> -				"rx_q%u_%s",
> -				id_queue, eth_dev_rxq_stats_strings[idx].name);
> +			unsigned int cc;
> +
> +			cc = snprintf(xstats_names[cnt_used_entries].name,
> +				      sizeof(xstats_names[0].name),
> +				      "rx_q%u_%s",
> +				      id_queue, eth_dev_rxq_stats_strings[idx].name);
> +
> +			/* could only happen if a long string was added */
> +			if (cc >= sizeof(xstats_names[0].name))
> +				RTE_ETHDEV_LOG_LINE(ERR, "truncated rxq stat string '%s'",
> +						    eth_dev_rxq_stats_strings[idx].name);
>  			cnt_used_entries++;
>  		}
>  
> @@ -3512,10 +3519,15 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
>  	num_q = RTE_MIN(dev->data->nb_tx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
>  	for (id_queue = 0; id_queue < num_q; id_queue++) {
>  		for (idx = 0; idx < RTE_NB_TXQ_STATS; idx++) {
> -			snprintf(xstats_names[cnt_used_entries].name,
> -				sizeof(xstats_names[0].name),
> -				"tx_q%u_%s",
> -				id_queue, eth_dev_txq_stats_strings[idx].name);
> +			unsigned int cc;
> +
> +			cc = snprintf(xstats_names[cnt_used_entries].name,
> +				      sizeof(xstats_names[0].name),
> +				      "tx_q%u_%s",
> +				      id_queue, eth_dev_txq_stats_strings[idx].name);
> +			if (cc >= sizeof(xstats_names[0].name))
> +				RTE_ETHDEV_LOG_LINE(ERR, "truncated txq stat string '%s'",
> +						    eth_dev_txq_stats_strings[idx].name);
>  			cnt_used_entries++;
>  		}
>  	}
> -- 
> 2.51.0
> 
