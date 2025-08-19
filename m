Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B3ACA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 13:51:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C565340277;
	Tue, 19 Aug 2025 15:51:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 249B64026A;
 Tue, 19 Aug 2025 15:51:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755611501; x=1787147501;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=40bPI+seUYTorsjqReJ88eKCLZk2gEioLZUk1JIvVoE=;
 b=YeynAFz7yxAQIo9Zg1xfaqHVdMatsiMG3TFlKuyrr7NpMQVH4Otjj31v
 dZ6qqX6p2HlWuVwvJrNarpknlknL+JKQhC7BcdRm2agHlTYridFZh7J7Q
 EKwJ3VNCuSxAd8yOixgrRQMr/IR2Z5pL/iGONKhcJNAHnGAI9Qbc7djQA
 8viapXZ3TZHLn8enVsH7VlxrdUTCzhlBPZjTwd9LJUA2y0Lgenz8QkTIG
 QVlnT/JU3I5KaxPPuBJo7qyiDg56Yrc5r+lV3LN2K7odFHiCLnxYGtIi7
 fE3Wmo7isUyZJyGLB2vu0OzpcXGxJk2xbF48YiPfV5az27cSzlADkNGRz A==;
X-CSE-ConnectionGUID: 1MoDxg5tTjCc5WcY2504Zw==
X-CSE-MsgGUID: 8oMSY8K7TVaEfrGxR3MLjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61687271"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="61687271"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 06:51:34 -0700
X-CSE-ConnectionGUID: A8hfQzniRLav21jG4jyvnQ==
X-CSE-MsgGUID: q8q156yKQY2m3Aibqck+vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="198716921"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 06:51:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 06:51:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 06:51:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.53)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 06:51:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUXlgyMIpuCNFn4cj/8rxdHbsYvFtra6JGAj7Qzd6Tq5ZueeKYdp8+GdUyKrfXCRUxMp35evLbNQ/DVlEWObgXGlqyvw4XCfI3weCLZ1zkvtZ1l2rnuKyxLZxo9F7IU/JJ1DxuCprVBAxeCDkxpFE4WFqUBphWuXUyAKmG6l6MAjxBGkCmpiD6H8/+XEjTrhOLFBwPeZ6nzd6b5hMjYyEPpHyX0Yr36xcMuvxE5bLPhWfycCq5Er4CoqrbiMH7UXzMrU65j7W+QYh2As6547ycForxbQjDJSOlGrQsa9eOTrLS7dHHSTbJ0OUxkLEayybnQA6UHTaDFKTL3pSfcwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGz8swAsiP2782JdqPDMWyMe7tm8EuwUCeTMj53lgBs=;
 b=R0ULX251SAjM3IvRyR3NpI0i5lg/d0QSkmVKvQi3jhMBvOh++3mBtyRthkQKd3R52fN/WKH203/+HWgoBi7FzM+0+vFUPrDupmzq7EP46gQL0k+MubgRjysTtNV03aqrWag6ofdGi8JuxLhop1Ok8u7uYbs6TFVKBpy5LsIeMAyWrHqwlWXX7jai9ul+LbcnSwkj0aKksbHm9kkoORw9qOd/mOPKv5g/tkjSPumUvwtUfEEi0x5GlsC8fPTLSc0Fktc2meHS0mtDyp1xv8/pix9O/KG2ZOjiszcqLnq1X+yy7FYvQchirYowqyqOLLZVJbTjrtrTSO3ZIGVsKgWgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB5196.namprd11.prod.outlook.com (2603:10b6:806:119::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 13:51:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 13:51:31 +0000
Date: Tue, 19 Aug 2025 14:51:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Nicolas Chautru
 <nicolas.chautru@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH 3/3] bbdev: wrong fix for MinGW 13
Message-ID: <aKSBXajOemwaIf-C@bricha3-mobl1.ger.corp.intel.com>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20250813152829.457463-4-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250813152829.457463-4-thomas@monjalon.net>
X-ClientProxiedBy: DB8PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:10:110::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 7188c546-87ea-4c9c-0c6b-08dddf2780d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Sf6pnRKLmLC6HzMYXpLgIZw1WNZ3jWuDSlKxw/sSsLCtiPVUwFMSL0zZNZJ?=
 =?us-ascii?Q?CF2XjKUgVdI6zSx5gA09V+7XOXnittrKIhuqeXFylm1ORMFkTPVXWs8Ku6aI?=
 =?us-ascii?Q?mUJ34zTMRQeA2iHgXWYFMTFD5iN7uC5DKtdCbwm54aeP9N6zmLnOQeChvPT7?=
 =?us-ascii?Q?sRVP2+0BtB0vEeje1H1Nj3btxWehTa8GLNK3NQU49Mp86vZrZWaot7kU9Swg?=
 =?us-ascii?Q?DThqJQ0qDOOaIVqfR7xURGiZ6UEmmAzlFSqQKY2kx/ZbDqR2NdLW2qFrQ2LC?=
 =?us-ascii?Q?WEKjzRfCy2oYApF9v/3PlgKE7+aPAWkykkWHHEP/e5yt7VgrPH4uTKGbfgNq?=
 =?us-ascii?Q?xYFQbK6f70cXAm+EVigyfYmhhdY8VTTLg4qJHlaJxQPBYP8EUNBDevNq3VSo?=
 =?us-ascii?Q?AUtWOzYFKKeKiLv+OBAQztGdzjayz7OwHm/jZGgbUY2SUttcuLs8UMnTKyt5?=
 =?us-ascii?Q?0BXdxF1i/dGBq8LIhHV6fToNAl/pukeK3FbPyYZt9y9ez1gwp+9MPXvDHoHz?=
 =?us-ascii?Q?ARToZHxMEmwJFo0BSY/fEjznJXfAGUTfefPCSVewLApL550D7Q/Uhc0RJYBK?=
 =?us-ascii?Q?KkI/wh28wXd53m7NT3e5whwieAXSOZM9d3QqVDauAd2DkVdJCLKjxqw+iQQE?=
 =?us-ascii?Q?BOMuYLCfuWL9f5cfkDJELVW/mwtGI/+PIcFVVy636wKCXP0YEY49I439FrKF?=
 =?us-ascii?Q?tiDOgFLNM3oIPG4p6DY1HEbSaYaBvR3r7c+WynEWsmqtA1JZAEg0YbUo5wqS?=
 =?us-ascii?Q?ebFmXto6oFI7AjbZ3PJf0INgHU4y/vLbMTIdNEnLKLFEKyFa36GQIYL9wF/a?=
 =?us-ascii?Q?57HdQuPKP2dqX4Ysu+1KE0JtceiZSwCnPd9KkCHp1LUY6DTiVnr6qeyh/FIN?=
 =?us-ascii?Q?lGLkzE1kLKGB3MbbgqT+iwK6oYEbcKgYT3+ZbUj6wnBR4dXytiHwlb+vuA0k?=
 =?us-ascii?Q?2+EiIX4+bjcf31l0B0VIkND2UJJOQbXNxVrguMk98Ams5zqrYmSTcpJnNpKw?=
 =?us-ascii?Q?l+5oBZR7BvZ1qlCyLxu3KTVYy+acO2jIJxywdngcOnkuEPKRR2ypsIuYfRbU?=
 =?us-ascii?Q?fzDzL/vD2DlbQ/7/IuAotqjKQdrZ07e9Lak1SZoveeNjS9nVLn1WDm77BGg+?=
 =?us-ascii?Q?1sR5FGVWUI9OGnAt6gTZxbZNuMeYFmnyyS6r+svFF5WhHqN0LyG9YXxKNfmj?=
 =?us-ascii?Q?AC/xRuBOJO2eqoISofzQzUwKJ0LcVL7MsTj0FmlZd909AOqxAhE6YC58eJU/?=
 =?us-ascii?Q?2ijpKRLJalr9O1f4bPPTAIRYkOId4Hgs0vkT+AdaAdvDHTW2mrYaoJ/4uZvv?=
 =?us-ascii?Q?5ME0MQE1JH3UW1GRnHNj/cmoI4TC6bPe9cugvdbMT/YwLVe2SVpzbKhoaJnC?=
 =?us-ascii?Q?QQhlN13NEX3oe2uAhX64afSSxHcqunEz1ITvVvmJLxxbQhLVbTDqjv2I6AdV?=
 =?us-ascii?Q?JOKKgFmQlco=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y7KqEfLnOCeEzBhlQ3QeGqYTI7DzWUhUBtYTX5aR5tkBxVWo2Lew1Sq3cY02?=
 =?us-ascii?Q?c3JGYvqEPSA7MVKXK1mkvRdQWddx5fI8ruxgGC695o5vRkwxCYjwLAQxphOn?=
 =?us-ascii?Q?NLNa1tC7XzTfMU2HUD9q3b2BibFUx5UZV/pgOCU1/zWeAV8WbmMikqBVfkou?=
 =?us-ascii?Q?5TDH2NJtAoRMr5d0629TKDQ5464CJPM6fjUNSY+/XwhLXPtsPYyyibNZo37j?=
 =?us-ascii?Q?TbO9em833hZKHCHWqkf7A1Qg6acJuZ8Kst59cNHdA3e2kid3qcrnhaK2gvrw?=
 =?us-ascii?Q?uXNapbtgYOd4OAIO9hG3KP8S6aEwEAOnC+VLQuN2dcpM8N0jFIWcmPPEMnLd?=
 =?us-ascii?Q?2s//1ZCK2msAdfbIQ4DGqjKX8l+kW/nqPCOQM1pLVOfgTpZsdFE+Q7Yjuxro?=
 =?us-ascii?Q?we8v/H78n4lCrVYSRAHZp7Tk/t62We9SxMBY0tiqGRh3V16hQOGXdpNVIv6m?=
 =?us-ascii?Q?JWoE3diGHdmEDjOJaqkKfW/lHGpKGTKktyGqdc2WeQ7B8OPb/mlaE7vewNrJ?=
 =?us-ascii?Q?X9L2CXJjyvu5szLJThO8U5ZwnzZUoNGIG8X61aD76vHqofdOXWYzFYBaaKIA?=
 =?us-ascii?Q?e8DZpL8XTPFlMnWIqC0VC5zePCRBM34mGwTg4inT0yWuawsrIMAJCMh+ZaLJ?=
 =?us-ascii?Q?HJrbjde5tFE1+p36aTkIJ7kvRLrWYT8BkX+cWlVX9yYdmBtPUJMKOakcGxCx?=
 =?us-ascii?Q?IQKkIhbIJ0LlKZHv1omHaUhvjYb6H5hEJ8GF5gG7Xhum5Maha0bHdDEShJiT?=
 =?us-ascii?Q?sPRblj3wRYUOsakWYcS4csMJtPvOuKnvbM46uC+KT0rqflLNKb5UHXV7Aow8?=
 =?us-ascii?Q?I/tnncUH9oRs/wrWDIwgGfXKyQSzNUP9T0w6hnLwELhd5sMT48H5kyxDWTVW?=
 =?us-ascii?Q?DaI6zQ6B8gNwIoI2JPZG4qQaoaZS8E6tu0QB/2PGB5HP69RhrMW55L7G/akB?=
 =?us-ascii?Q?N3X5Fco8KoMt8UiP6q5frGt1lMRkVqmZ9DxWoLwegN7aHfLvw4a/wiwqgS28?=
 =?us-ascii?Q?DsbXFQdW+GeCZPOhRbrmZ4vX2esBr9pSSa+DkyBjoWDmBSVSbY7jNbpJHqbK?=
 =?us-ascii?Q?w3umzeaddJvrMQS9Xk9BuHDKs58L5g/Gf5h+aVubtTCdSOuLFZejHJIEtYpT?=
 =?us-ascii?Q?tcIdga9EEvwlvOzFQOq2U1zNkpU7HjbbZUwvb08nTb5gXyuV2tqKf/NKZUN+?=
 =?us-ascii?Q?1sNefqVKEMdD1EierUwGuc2ApvtpoVG5/HNq5mmcc/y4VnT4mf7BYI6cSLYF?=
 =?us-ascii?Q?7J1RTIvL2odX2pdBwW0+lIgfI6/jLx3qIuho4HLnLqfbXvKf1hLUZMZi8KTC?=
 =?us-ascii?Q?t2VPgmzhQVyoGjTA2ta6kvI3TB08yd9bhArxqTr4/6wjFbdCC2p0VA0XepTl?=
 =?us-ascii?Q?5Vn8uoo9UXqL4WVii1iTuNo9j0YMeKgDacH3gA73iz6v5VxXN7O2dnffo3LY?=
 =?us-ascii?Q?W5Hbcmc0QDkOaKkFWXZO+mIpJXTuQyoZY24s4X9XzJdyFgsOXvjnzgY1T/TI?=
 =?us-ascii?Q?nyd4XnI8F7UXFIw5TH0PO9bjRaDD2EZtRhG2r1f7gikQFkxKVawKPgXFyffd?=
 =?us-ascii?Q?J4YhFbozdY0cBblEpCRI2Pxx1Auj8F56vGcD+5nGIbk9wUDfaHsoQkRWxR5F?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7188c546-87ea-4c9c-0c6b-08dddf2780d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 13:51:31.7291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPXr84m9qezJ0nAiRmD8IqDVLIkvv09Pl6Jx4zuI9UoMj8jJRGF3i0Y6gGqYR7DrdMDYLQ6EXYtKpp5INIUKp661bVC1ov41IpSMx8oKe0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
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

On Wed, Aug 13, 2025 at 05:25:25PM +0200, Thomas Monjalon wrote:
> After an upgrade to MinGW version 13, compilation breaks:
> 
> In function 'rte_bbdev_queue_ops_dump':
> lib/bbdev/rte_bbdev.c:1269:63: error:
> 	'%s' directive argument is null [-Werror=format-overflow=]
> 	fprintf(f, "  Enqueue Status Counters %s %" PRIu64 "\n",
> 
> The enqueue status string may be null if the index is too high,
> because RTE_BBDEV_ENQ_STATUS_SIZE_MAX is defined to include
> padding for future enum insertion.
> This padding case must be checked
> to avoid printing a dump of a non-existing status.
> 
> Fixes: 353e3639d458 ("bbdev: add queue debug dump")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
>  lib/bbdev/rte_bbdev.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
> index e0f8c8eb0d..d662a2b364 100644
> --- a/lib/bbdev/rte_bbdev.c
> +++ b/lib/bbdev/rte_bbdev.c
> @@ -1248,6 +1248,7 @@ rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_t queue_id, FILE *f)
>  	struct rte_bbdev_queue_data *q_data;
>  	struct rte_bbdev_stats *stats;
>  	uint16_t i;
> +	const char *status_str;

Minor nit, but I'd suggest defining this inside the for loop at first use.

>  	struct rte_bbdev *dev = get_dev(dev_id);
>  
>  	VALID_DEV_OR_RET_ERR(dev, dev_id);
> @@ -1264,11 +1265,15 @@ rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_t queue_id, FILE *f)
>  			dev->data->name, queue_id);
>  	fprintf(f, "  Last Enqueue Status %s\n",
>  			rte_bbdev_enqueue_status_str(q_data->enqueue_status));
> -	for (i = 0; i < RTE_BBDEV_ENQ_STATUS_SIZE_MAX; i++)
> +	for (i = 0; i < RTE_BBDEV_ENQ_STATUS_SIZE_MAX; i++) {
> +		status_str = rte_bbdev_enqueue_status_str(i);
> +		if (status_str == NULL)
> +			continue;
>  		if (q_data->queue_stats.enqueue_status_count[i] > 0)
>  			fprintf(f, "  Enqueue Status Counters %s %" PRIu64 "\n",
> -					rte_bbdev_enqueue_status_str(i),
> +					status_str,
>  					q_data->queue_stats.enqueue_status_count[i]);
> +	}
>  	stats = &dev->data->queues[queue_id].queue_stats;
>  
>  	fprintf(f, "  Enqueue Count %" PRIu64 " Warning %" PRIu64 " Error %" PRIu64 "\n",
> -- 
> 2.47.1
> 
