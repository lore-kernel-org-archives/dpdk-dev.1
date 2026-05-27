Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE7CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 16:19:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B74554026C;
	Wed, 27 May 2026 18:19:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id AA40C4014F;
 Wed, 27 May 2026 18:19:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779898781; x=1811434781;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xaCDEIKmAUULhDi+RvIBO/we7+KYqVLoOLIuQpH+txI=;
 b=KpK8yc0g1lBPnqJ4sKTwukbURRs0cdcZiHy0ZV0UhdKvTcPgZAqxov7k
 vSPHxmcFviXXzUNFO+gSzFK9dXumSf1sXBJdeCOYn4A/ICU8j0/msXxWm
 VYLq4bGIZQZaSTooZtfDXyzKcSejCq/SkA6OYB5VN7DOXVp8/LdGov/Dg
 tM9gfZJZPjregLU5p8D9jEmXCEysOrPIPWSYbGCy0adLx8s6kNazaTdc6
 hJsi/txhWfjC2GJsJmbtOjOFT27BQIyBOEEtl2sGZfohmbtXam+mnjmKe
 zzsXxqIfyqNyecbOYfZaqYMMw4jyONAfq9kpaA2yIAV+M3yQkV/zjufjt w==;
X-CSE-ConnectionGUID: dMigFS+NQcOY69PcDIlnYw==
X-CSE-MsgGUID: Mn0E7AI3TQCf72aOk45+HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80461550"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="80461550"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 09:19:39 -0700
X-CSE-ConnectionGUID: Q2pqywEERJiwP+BP+D/3vw==
X-CSE-MsgGUID: eg7sEM6oSASE6pm4E9WEdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="265896676"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 09:19:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:19:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 09:19:38 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:19:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiPVy517JH+EidZQOAYBIFDXC7wbHFU3IVfezxM22cXAg8aLdfcQls9Hl04HF/Q9PfgkWHV2LRA+snXAkBf4tPMrMdhRLa9YyBoZkaGEqO0/bW0TcEEVvtelHm9GZH+COkMvUOLGalpzQUIJRulEl/CuSi6TpxZvOK0AGjCNlJwhzgWHIlhtw0hh69J+g80OaIB0lGaJw1GaCv1aw/EsZ/uYt1JxUdaVHodbhBez62cOTEi7u5Figb3YFy+wMWP2K5aQ1mprPFioXqRsN2Zfzl8T91RxcMIgIsLJPtYIpmX1wqDr40KNUK3Ud8DAljWUYoHDJ+Eqm/mUtEJBm1ghOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYsJdzEHwpXrQEFZ3b/T9dXW8fcDWlN6wn0aRwvPZBM=;
 b=QWOeU+Fuk/tIjc/PQUeGG1ATtJuvDAFg39k0NGTgzet3Vzm+nENWSbQ88BILLm4zPyPJMeHMb4S9XIYVSowq1N7ua25U08El0PTTVDbIQQVvEly6lkYi6IlNP1nhJjgwpHaUvUltmmcbGxbFU6QkswEQxYic0HW2jI7delsT5wGMZwOl7b1CXdlQhGuMiwpKCoyKgFcMmWlUbpn2d3BR05UDvM61aDNfPLSWaBk15UgMPQPlawWGNAJgH/pJ1r4EXE3pqc8Uf6Q1YCuEylreCpEPUnX0kE/U3zzq9zBrPKeck2Uz8+ciiHbDt8mp8tgDDrEwoDQA90xoJRxVm/Z7kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB8569.namprd11.prod.outlook.com (2603:10b6:510:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 16:19:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 16:19:34 +0000
Date: Wed, 27 May 2026 17:19:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Chas Williams <3chas3@gmail.com>, "Min
 Hu (Connor)" <humin29@huawei.com>, Tomasz Kulasek
 <tomaszx.kulasek@intel.com>, Declan Doherty <declan.doherty@intel.com>
Subject: Re: [PATCH 1/3] net/bonding: restore dedicated queue state on mode
 set error
Message-ID: <ahcZj2uEgr1brSVw@bricha3-mobl1.ger.corp.intel.com>
References: <20260417165530.653328-1-stephen@networkplumber.org>
 <20260417165530.653328-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260417165530.653328-2-stephen@networkplumber.org>
X-ClientProxiedBy: DB9PR05CA0004.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: a7806b2d-b7f2-406f-e06f-08debc0bbd62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: pboFKyYjcfq7VGOCVWB2NbOipp425wBPcDAamspTrLh2B7ggSwuW4wfsFyQyM+B/SQtWm/7Xn9Gl7ybZ9fab+bN5evz3/b1QCmEWXc57HY6nn4A3eN3/F6kg/LKiJy1LQJxDgw4NrDgEV/zzdccDA6lZfE39zzfFWE0G+0Auh9vqUStYh5DGZUf8hXcF8yy8yJkTS6uet3jB6tYqlllH3wgcklihUXYbb4BoLljruhH486X6s2wFEuUk9pYByJIUsxtbxqKIFFDji5jN3fl1XLtXL1Jkw/5Ayvn0S/MS2iBk39KY1ikGHZ9Y62EENWTFfFPUlaMjiVLr++XasWbDUF+Wf4t6ZJ0gohwpQb8APor/hDR+0dY9ruTVUvNo7sLmEDJj/tXTPfbo9CzT64D6W541yxJ2IE0qZ9THh7RUYGBMFNtSzrsRqBfp08jh45MLUpZ/LwWPvgApLwMfs5GQMa0NTZaNUuVxylOETqEiJynXYERSfixyGHEXu2btlVAXYbkIDGCHbzezrd6lX3hXH9G125ObNv06hcV6cFXjzxywBbfUPMSJxbmmYD0ZCnYYsIQW/CfuXdI3IPePCN9DGrtpf4OOruvr5KptvP1TvdlcvTnYh8b2empFeLeS+kXZ3QiTEfdGEsy/1pDGwKzgztylWARc2OOvVOgiUus6kN/HvrgqcQcGOMlSx6U5aZQu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mRu4j1nc7gr20dQrHfyruPhXugo01JwBcZ/73+EWx4NTDzV7uQS+xDn0siMu?=
 =?us-ascii?Q?wNbg224uqf2xZ0injhRsCMoROjyGUhXNsaNVXRapJs1MGSPJOgJqd1Cf5Mh+?=
 =?us-ascii?Q?RAyhEbO16brUDAD9HvBCuEA9fCbVA9MvOT6V+YPMT55JqSsAM8jEcrkq8gDS?=
 =?us-ascii?Q?uhv+m6hDCgGlOw0ugYWUPjxE5RUuDYG0T8+5yRSuwRP0o25MS5Xd2vM8cN5i?=
 =?us-ascii?Q?I5OVqqlGv0H4UoMevJ01PG5IaWkQfcTRpDJcWcdTofwaddJ/fYmPRtQr11Cp?=
 =?us-ascii?Q?KiFqIpaoZUU21bV5kzmKmnD9rzp2xzs+xhqshuTQzlkZcWMPME8Qkpi1QwpE?=
 =?us-ascii?Q?9tgnS90WM5oAC/8IsdOyKq8he1ExhmELnIaP7U4cCwpcRRfO+w4HsBFknqNg?=
 =?us-ascii?Q?ThaHHlLUQkoBePinEBy6mPf0LH8Z0qUKvO0JVqSJAqNgz2VODTTiumdGXLiE?=
 =?us-ascii?Q?XaXa1YQeEwq9dMHING2gpot/XlBC09A2Oy7TcgCaofP8x8DSHRePkGY8fjvB?=
 =?us-ascii?Q?kG6KDQk7r3WZH3Rpy42OlXsWugmAr74xxjt41m7XdTYCd24PukbQwqBOLz+h?=
 =?us-ascii?Q?pDR49IzSovff5uZ02b3m56yHxfD/RdWyO4DKAA3P25dRgZWr23xZPq+3sU0j?=
 =?us-ascii?Q?DeOpGyHjPTflluvtjLATINE8g9RySAIY6fhpOgw82lKgDOKQ8wL9pgveLNEA?=
 =?us-ascii?Q?yKXoxQOFYwNl7tkBJzqoUcdzgqUr4kgnFPcPZ0t6vdP4tG7RA8UselcDkvEr?=
 =?us-ascii?Q?tUU4Cuc1sskf9PwxPxPM5REsDIQCCrfZC5x41UjN6E0ZLeSaxI62Jr4iScY1?=
 =?us-ascii?Q?kL39E0nrYkZrx/YkhEyKV5z34INkQQSlkczLu1x5AoNtc6YeL7KaoHHNaIeG?=
 =?us-ascii?Q?MTS+oyeG8GbMMTmSgRMvnY3iMQFb8s1fGK8OT5DBLbA37lt/lnhyIdJP03h/?=
 =?us-ascii?Q?jktOe9Cqbxg0ggLA3FJDUdLbaeG62AEUzgWlWobB740/Xd9XAf5+vNv5poJ8?=
 =?us-ascii?Q?zmIvnOEOL9CT85y2clT5k4Y3jTmt5Duu/xdEgklGELRzq1gnO79PkNKQ+nhy?=
 =?us-ascii?Q?Fj5F1B7+maQqXc+E9ObxLjAVhSxv/9m6BpGi8PMp8guFJnzf4W6tPrqUMhwf?=
 =?us-ascii?Q?zvWvp58WG3WUiCgQ16fE5UU3Z+0tjOVRTwGvwMxstvr75oi6LTaK2wts3K0x?=
 =?us-ascii?Q?ZSiLKgRAe4OilZ+udjtHuGvpiR799PulqJmA+kC7NpyaM9sUGjsiJ4GZgx0H?=
 =?us-ascii?Q?X+Sq2EKORHJL7MT/MLk81EJNRbCgkbXNfEGXJEus7hCxINDgWhHvtsbpYsmI?=
 =?us-ascii?Q?fNjnwH/VoaCTajHO7kqv6NLv+XFeGxKilZfOmQQkXdHCbTl9hVlqV3zdRxVW?=
 =?us-ascii?Q?1h0Sw0abQq7ooS/l8/l7GYg2hHzW1bqrSy4M4QDoy4nbcoaheDnucY/Dvq7E?=
 =?us-ascii?Q?izIGKZUrezpzTJSl+A3g4OgzW4ETHAfVDCnT5lDX1d2xlweADDS/KOEbCw89?=
 =?us-ascii?Q?asSDCr2mR+YwCcfyY6v7SttGHxiDN1HZjEH4WfT1YuO59icmXCaG3txnNzqW?=
 =?us-ascii?Q?inF1Towrsi8iBznIWyk0Zyh38HXCKCEHbJDzKXhbYkzCgp0RWcqJiQDVs06N?=
 =?us-ascii?Q?P5JKuEOkm6JS/gFKkh+E/HY+9wQRXzYmjSBPr7nXdKGHIOI+aTu0vXkyy04M?=
 =?us-ascii?Q?tDZ368tKKgfywBDk+hJCagK7xuTqOkhaL9QkdikvxzPEq3qHQgOZIeWLaQsL?=
 =?us-ascii?Q?Cf2JSsgHoxKD6dH1oVIKAeyrkPs8y5k=3D?=
X-Exchange-RoutingPolicyChecked: hPRgAvl3/c/13RU5SE7L3pLjPxCS3Op/hn81cx0dKB+XOudMV4K5xdGKmaLLTneRYPKvcLhgGmjVIEsjIQUq66DIwDTyKiWRHvuJrZsT2RnlEzlTGNfLl8jjWFXGt6MIWcbY7pkArS6clJKYLbVKjL6zZwpZYcG70Mosnmp3IuVcNMJohVzK+7jireMoNIRLtwilo21wrl+jjKVejfdPz39wRn3TiM9HFYchKLWIhsIDPvBr4p50aSPKgcsFgHLiNaxkGm1/VB1PVycUgGa3ClNpWftcuR6BRB8SMFXGJKPbO1Jmb/HtdJCNV7GJur9jvsoZqUPfVXxf5rPJ8F9e8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: a7806b2d-b7f2-406f-e06f-08debc0bbd62
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:19:34.4108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmki+rkKaMTU2Ji+GHBUfPIEXWuFD35ZGqAaJCC3jXsY0a2mVoBjDgXsF8Ix1wjhR7Y/EBQ2UGDQFch+Ektl7asZ5uJBApyMbN0itoy4V+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8569
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

On Fri, Apr 17, 2026 at 09:51:35AM -0700, Stephen Hemminger wrote:
> The calls to enable and disable dedicated queues are missing
> proper error handling. If setting bonding mode fails,
> restore original state and propagate the error return value.
> 
> Fixes: 112891cd27e5 ("net/bonding: add dedicated HW queues for LACP control")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/bonding/rte_eth_bond_8023ad.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
> index ba88f6d261..a74b0059ac 100644
> --- a/drivers/net/bonding/rte_eth_bond_8023ad.c
> +++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
> @@ -1727,7 +1727,7 @@ RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_dedicated_queues_enable)
>  int
>  rte_eth_bond_8023ad_dedicated_queues_enable(uint16_t port)
>  {
> -	int retval = 0;
> +	int ret;

Any particular reason for the variable rename? Not that it's a problem, but
it does expand the diff.

>  	struct rte_eth_dev *dev;
>  	struct bond_dev_private *internals;
>  
> @@ -1744,17 +1744,20 @@ rte_eth_bond_8023ad_dedicated_queues_enable(uint16_t port)
>  	if (dev->data->dev_started)
>  		return -1;
>  
> +	uint8_t old = internals->mode4.dedicated_queues.enabled;

Should you add a check that old != 1, and just return ok if so?

>  	internals->mode4.dedicated_queues.enabled = 1;
> +	ret = bond_ethdev_mode_set(dev, internals->mode);
> +	if (ret != 0)
> +		internals->mode4.dedicated_queues.enabled = old;
>  

Looking through the code, for 8023ad mode, I don't see any way of failure,
so this failure handling seems pointless. The function
bond_mode_8023ad_enable() loops through all the devices in the bond but
never checks for error for any of them, so always returns zero.

What is missing here is a check that the internals->mode is actually set to
8023ad.

Similar feedback applies to the disable function below.

/Bruce

