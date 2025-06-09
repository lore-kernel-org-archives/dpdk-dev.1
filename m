Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C05C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 13:58:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 010F440F35;
	Mon,  9 Jun 2025 15:58:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 2E83040EDB
 for <dev@dpdk.org>; Mon,  9 Jun 2025 15:58:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749477516; x=1781013516;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BlSOZTjjFJTWLSf6L3WwaqzNobR1CQrTRe9ibFHUxgI=;
 b=Np2jPhWZZoIAla3uI/sDOFwIveUoNs7PPK2t3FM9qlER3Gs27wFo843A
 9+2czlcPsZgC987jNgQHOmRbn+QMbFIjcNd9BQvpcivMsrJc0O4nGJX0s
 /4iwD8vYPgnNlqm3tt2GEjAHGQHUWkaaVzIJesjKTq2Ik6XawKHMTce+8
 AwE6FNQOTN+s65cVPN64ytuV6+B/GlkmnlAkHHAQy/ZrS4R31svuCUllO
 7jYqFj0S3de7/YH5XJK16g5bNWXVW60hjC4EcoXKAK8+1j1E8mUcq/YYQ
 hMoY8ZeqhNS4YGCfrw1wk9BW7H75D9kFOaoRlXmy1kEu4Js4loOTP1185 w==;
X-CSE-ConnectionGUID: bbVBVA6rTsiGVx6nIWw9dw==
X-CSE-MsgGUID: Bvj9DzUpRHa70VQai4Q26w==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51547838"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="51547838"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 06:58:21 -0700
X-CSE-ConnectionGUID: pIe2akjQQvChSiNYwi6oQg==
X-CSE-MsgGUID: /MhtBIcERluP6VpyV1+TRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146520814"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 06:58:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 06:58:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 06:58:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.84) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 06:58:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvMdJzS838RCxbVbtOqujdRxjewWzr0OEI4KAa4ddJI8sESNGs1JDQCHqtimn+S64nuV4JFs4ANvfS34/C8Uvo42LjqOJE9nkcqbAnIeuXlk+dA2DI5YaGJ9DlURoXfirL60rqtBt7z2LW7Y5LQYv6s7zQuKrlYYqr/u/GgPxRxCFk4l/PBbX4TTPCoGXOOyEfANABC8DCNxR2oP9cdLr7Mac2cSARYF+oEq0PTyNQ3Qq4xxlrSLKzs8wqpNEqHTLpSUckj9fCqk7SceoA+TBOgrWiD/M8NXTBmmteHy3T6GP/rH7mxKIoTuMzaPC0M5KNGPLHGTRB2XCW+d+AyY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX3BpegupDKbnpcJ3YSQPIineZfKFwK5eDg6V0BdtGQ=;
 b=qkNdlStMXdlfc53DLf6bw/J1xTZ5bUVYxMOmlS4zfl3XEeuNHVX8hUrUYonR0xnHBo2p6xTh62C41e4wkJsroxoAUq0EJ3y981WVQdu3LJasRf5Fs7gcpFbWgsV9xxBsAlUgdoeHF65EcX/9K8vN9HnaI+Id1AvHsR5ncoDgSm8PZvarImL5fzVitAA9F590gmrzr2voyn2c4Zcm7Mb0SaVavxePmvrK5HOlxcKwEurnMADnHbKhkdPD91e/CyFt6A7DKIT0XFgbpqrMAs/88/myH8pSL45voA7j7PQa50eUtNW72BHfzg+o4zN28mtU9WD+1EsjqbWdRdp9Dc7eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4928.namprd11.prod.outlook.com (2603:10b6:a03:2d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 13:58:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 13:58:03 +0000
Date: Mon, 9 Jun 2025 14:57:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v3 2/6] net/intel: add read clock feature in ICE
Message-ID: <aEboZmlQum9B21UL@bricha3-mobl1.ger.corp.intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250608113223.487043-1-soumyadeep.hore@intel.com>
 <20250608113223.487043-3-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250608113223.487043-3-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DB7PR03CA0099.eurprd03.prod.outlook.com
 (2603:10a6:10:72::40) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e26d51-a64a-43c3-f590-08dda75da735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JZkSqqq9WN2n6x/VJvZjmPFmU+VIi5ESL07XYBZ8kXBa1yyo6b+RAKt2VUWo?=
 =?us-ascii?Q?9R+FGFxCVjq89m+ehM1mW4fTgXJAvhVm3vqguKKh8r2E+LWURydWdj1eh+U3?=
 =?us-ascii?Q?vCIahJAkvS+JWSJkW01LS+/hUUIDYUsiMKiZRqR6jLioSksNK1+3dndvKbfB?=
 =?us-ascii?Q?NqMosygHEJuD0z54h3JcHzfbAvXv339/2/QNaJ4DnbZtsp9w5J/SOXPX1OP0?=
 =?us-ascii?Q?uzbn3u304b1zT7RyLhxizvePHqMdn3k104FyCFq3XlP2kvQd5zLmCprbPVAA?=
 =?us-ascii?Q?lhBZG34iKexdifdwCvEyrGXPcek+r5YhwR6ebZhgJRTXk8VuVLrGjCEhGFyT?=
 =?us-ascii?Q?nEgaQG4typ/WJN7jUXyL/OhIqmUoiyTouOa2RR6w5phE9kVKx4z0YOu7L25M?=
 =?us-ascii?Q?wazyqoLSDNhaRgBORklllnOLHmkTmPczWicDr639Ia7kcftRiyGAEWsxRwoI?=
 =?us-ascii?Q?wknQU0JFVPb6bJb2yfUYH9eelAiZyxNFcoIpeX9gXWtDt7wjWSXuIDisIfzU?=
 =?us-ascii?Q?AeSkCcvnjh35oJFEN9FiP+1CM6gc6XOPaEuAR+u2JWNz9BguahE4XRKyBs9a?=
 =?us-ascii?Q?4kYHgIagKXnzTLYVZ6ccQLzAzK4NJvn7WgudeOx0VYkkDEW1r8vmnvC5QELy?=
 =?us-ascii?Q?cvX0EK4Iq/9/LGeaYQy1IoZzWC7gWk91b1QmPf8VBlC2qI3q0cA1Mg6ZfrXX?=
 =?us-ascii?Q?01w0e3UyKKmYg/KvNjyPEVOuebU00qwbsvRL2xJMTo+oFvneWQfJc57emVsu?=
 =?us-ascii?Q?8uFDDPp30uqIx8EZ9CyMwSJRkinRVTQ+kNc/UM0BEIHBFUL7Dar531hOrZzy?=
 =?us-ascii?Q?yzHwhWjpcKPYj7sfR5b8lbt51s79V3McG6LJqGODmc3jpSiRcUE6l1fSQkgP?=
 =?us-ascii?Q?r+QWl+g766rP5IpgPsXDiU4CvJ0gb4W5swKtt1m0O5RuAPrDQEhwqG1CM5ae?=
 =?us-ascii?Q?0kd8oDLA3jH7RaEB0Z63/YgVttaWM4EHyVF90a2zZI/BQDTG0TFGIkoNzQhY?=
 =?us-ascii?Q?TtDf3uzVtKGd2rJMTrJhVyUr4LNeV80l3w6KsRQ8x+iAg6IHpSJ69ET8L2YW?=
 =?us-ascii?Q?+hLAokq+IjvMe/Tqh1gZ9DG8AoIRzWvQUAI4kaIKg/wVz1/WwWRc8zxitDT/?=
 =?us-ascii?Q?OnV83W2y5nI3+IJhUewccCYmXigg8k7q8hUbI3JTCdDa/BHsxLzN8WJYlHev?=
 =?us-ascii?Q?3mWwL6XVtpUnbgGDQJyvHdpYjG6Mrzh1ORIqyyEIm+R5XMRLUN5D1603mGVF?=
 =?us-ascii?Q?jDyiCzxoltcnnl8jkaBdpv07/XRlZCpUIiNFVWUSg0wEtbs49KeDjB2DKztV?=
 =?us-ascii?Q?dt3uR3JF10qdryragFvw+kvWbujCP6KHtHdlO9n5fIAl7kTPsCfwclndSvFY?=
 =?us-ascii?Q?lXC3y33tlPkbNJ2M3maAbC80K9M2iqhjWm4t7d2xe6jgv7sNBw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+t3K1lXHboFn2WR5DsbO1sfWHjnsKZfkkzTUl39F+z/hSmHzKSODLV6Hil2z?=
 =?us-ascii?Q?wHOC5E4V666pRbK28NDm1gKxawQT2HQWguNCSq9sPQrLLcrWWHF1HbROeBZO?=
 =?us-ascii?Q?LjIf9eKcyFt2/hduGs+6M79TXbhV7rOJA+qmd8TYdZmPZSvM1gj6GQfGSY+7?=
 =?us-ascii?Q?GtrKQAq1KtO7vx5xrgIWGAH8rykYxRGxyJOE+h/+yHf1Bhfzx/CsXnpg9S3j?=
 =?us-ascii?Q?1RCHN+pKPOn7Jfdn6ULjPRyrOLrnU3CXYZa1WHxXNRQIqAzOcj+9MCX+xI5m?=
 =?us-ascii?Q?GBDRtwv0j/scsDWhGoz+jns7RdNbEUePQRPoqdd5b8xre/qqF9TnD2KSIDtA?=
 =?us-ascii?Q?g8AKry/91N2ztFQO85KwET6vTVZrggpfscscStC0USQQgZpQgbIPihDkfXbq?=
 =?us-ascii?Q?TLkaNrGVdnwREhFLpyED9FgB2mtTBcJpU/Hm8ZGJsFtn7wdn0eEwVFTVRYor?=
 =?us-ascii?Q?lz4mVHJtzTKFIMbOUNHvcOqpxGFiKnUyNwIk6rDVwKwAO4NywPeaPQXbqvIP?=
 =?us-ascii?Q?XdcsYAHGOgljiKldQ1aO44fVUhuVBW3D4y172sDLXjIw0OMyUjQ/alAyPeGC?=
 =?us-ascii?Q?BEmo5eE090+jLhmzcYrV2fc12kaaUgpeQM78JMk0Qr6aPnDH+IHgjjTr7UnD?=
 =?us-ascii?Q?q6m1XSkRbW2HDtlUzGOo3roX7lfQtFEgCYg7P68s5nbthZbMvL6G0VWDwc9N?=
 =?us-ascii?Q?6j01858A1U9NT77RXmJDPRKdLiRAbLwXufwGsir9Xs1K9boCNRZ3wb5+lu+b?=
 =?us-ascii?Q?5vF4XhhUVK7FwrKZ3/Qmqj1jkLbLoAZFdXByGqXJN+ZraRDW11dGHDjoKlGh?=
 =?us-ascii?Q?ytF9MM275ePm4qYg/hVaPYfGRk7gDk94VAh8elllD3KuFucWTqycDZ9LcUc+?=
 =?us-ascii?Q?VxTj5BZPPNCphzsdnXNcMQXZ6xQWtRl6RWjRd8AjzuuhDOR74SZH2ubWCFPq?=
 =?us-ascii?Q?gWF314nXFDSl2Gh68nQGIW79W8x8T35jypaEn+od0or91t7ZBDsyI5xommKn?=
 =?us-ascii?Q?zida2NaosGO863GhYD65YwGVnnUXD0x4yh5XxQM0jruoDspx9b3ODPOrLusR?=
 =?us-ascii?Q?U38/Pdle9VzQDRGP/0FaTSMsikSbNnvRz+SVOGdfLZp6bsKXNsUM+e8G0edk?=
 =?us-ascii?Q?lTNp2nq0C718zrEgGIoYbnxbUn6uzHN2qOG3QFmnydoosX4T65eIMNbDGGjX?=
 =?us-ascii?Q?wjs+CJdqwhIPSaokTUzWjWObYGP/8pwqZJOuZXp4sWlHUgVz6oB6XV1AkEZK?=
 =?us-ascii?Q?zZm6B3BLC6zf4N/JJsetbu1i0UMO3TdIBmburoUiNIWk2OuAF39KWkAXCX5R?=
 =?us-ascii?Q?NPM8m3GaHmJ1s5O1MET4JUCqLMpyNxvLkoYavhA4fuRVTJUm9JK3y1XgeQrS?=
 =?us-ascii?Q?m2Zf0zYUmWgH4xfGaXOMqgZSzcFHc02fwAnJ+Xp+jovaMfk/vY9GZGHI1iQ4?=
 =?us-ascii?Q?fs5R2G7CBLTjb5ioAfGYJ84koHe9TiT2yf7JbyhwLWr4KaYPJA9PrsfpaD13?=
 =?us-ascii?Q?cruyMUTi6helM0WYxMMi7jNnQ4iZ+NalxBrzYH+JsoMXc/kAc4liHLerjrfK?=
 =?us-ascii?Q?hVKaJ+wLLquv1BD9uw7ppsPAe9gUTKx10ytdqRQc9l55s/SALTPLXmwbbETt?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e26d51-a64a-43c3-f590-08dda75da735
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 13:58:03.7930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEc1DsZYxDvDwAd9VvL8u/C9VOEunTyG8QAHnJUjP4fx9k0mj8tcUVbCVQ4xvKT80e5wyVrkeS09NJVxM+v5wdHjj0d6Zl6MeizDsyP2Ch4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4928
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

On Sun, Jun 08, 2025 at 11:32:19AM +0000, Soumyadeep Hore wrote:
> Adding eth_ice_read_clock() feature to get current time
> for scheduling Packets based on Tx time.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 7cc083ca32..9478ba92df 100644
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
> +	.read_clock					  = eth_ice_read_clock,
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
> +	clock_gettime(CLOCK_REALTIME, &system_time);
> +	*clock = system_time.tv_sec * NSEC_PER_SEC + system_time.tv_nsec;
> +
> +	return 0;
> +}
> +

I see a number of problems here:

* The "read_clock" API is for reading the time from an ethernet device.
  This is not the same a reading the system time and returning that.
* This uses a potential system call to read the time. (On some linux
  implementations I think it will avoid a system call, but even so, we
  should not add what may be a system call into these fast-path APIs)

/Bruce
