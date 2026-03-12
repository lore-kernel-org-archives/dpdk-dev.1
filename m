Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E63105A583
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 11:58:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16819402C9;
	Thu, 12 Mar 2026 12:58:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 39A83402AC
 for <dev@dpdk.org>; Thu, 12 Mar 2026 12:57:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773316678; x=1804852678;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Fg5fBGf5MZaNbJn5rvUfwW4aEl6ZJLbC1IYEwXgJ+VE=;
 b=LkQhSljXtPYSQvwtl5cKsYcyrAKtJvvWoNP52b0C+oTuTWPfZozYpBce
 yy5lNWeQ1mlBw07osMHcRAGq/BShVK9ALn/bOFugkDiWRgrnwddybTiLx
 dPSLtqcw4dH36a7+wewFV1YW5hpq78wRcNIMyyNPUN/2nyUS+GphUpjdr
 hyaAAjO9qD/R/H+wkoXMb14DsYv2nKOVEsWvd8BXWqbTQK4atz/Vo8TVA
 zF0IZRsKMSsB7ZrQYbKU87ovr8UFq1NdCiXu1OqLRDKEIudBGF+/tBIY9
 ZELnLavoGwfsqKtVNTm6kI51uSpbOk7GiopK2qOpPyknVydMwRKAYjGDB Q==;
X-CSE-ConnectionGUID: qoY1+SQSSqW1QZPPefWzqA==
X-CSE-MsgGUID: 7jtXYj0sQGqcGDrBHhcfeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="77014975"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="77014975"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 04:57:54 -0700
X-CSE-ConnectionGUID: OduZOZh+RKCe0CNSGoKtmg==
X-CSE-MsgGUID: 3WH0g8JLRM+CvCZ/Fw1SWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="220747706"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 04:57:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 04:57:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 04:57:53 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 04:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XC/YG4+r+rHkD2iZz9K0MnI4oGk2JuZ/6w4PkBfAv6zcZyyhS9nYQeSOJ5GhuwyWzydotd4dkroySs8Mi9VFHTHbrf/8dTzVPlrdEx5DUq2/gSSfkZpKVL3eNUdwr5IZwP5LldGg2AhjTCMdUCQ1JKNOVB9afmr7xLczza1ER+89P12e8Wm26rLUDDZlY3WYhXihhxGWAdthjbj3WRcn49BPcVUKsVW/8IB5gKV8U0BgCNnFR6WTDvfnJXkTeEj1cbzDNA0rxZdjIWukg/DcetfiqGZdKalf5U2/HkhVZlSgtPJY8XLVfIbHxEPo/JpqtPhGwKa02A9NVXbrvpwunA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSKAtNWFUb1btKPSTYYFru+JQm5LrkMG4iEaa+yVHec=;
 b=Xi1vmQG5WB3faZKGUb0Y/AS2740A7rWTPUHowQC5jN6TW5NWcSF89E0L9orR7KVo8onF+FFJzKaO4BLrkvAqevDXrOUKB2WdV5DWsIDOoDrp2Q4HaaJWhlk7f78xKPQSnulofqAi33NGfkaVm2zVihIIibQwFdzy/AJGosu8L9mh+CCAbWhp5ZOESwFcIjQHynq81O64Ut/jtB5S9OqOmCmO2a+93oS7Qw98E1fUMvqvV3BBMdb1ztQKESHI+H7IF6u3baNW76YJPmHUDx/e+KUiib87lpG2j04vmt3CNYlRUEyUGXR2x7BYFeoDBHsLog4QMrC4fiAsopGdgf2x+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SA1PR11MB6822.namprd11.prod.outlook.com (2603:10b6:806:29f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 11:57:39 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 11:57:39 +0000
Date: Thu, 12 Mar 2026 11:57:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <manoj.kumar.subbarao@intel.com>, <aman.deep.singh@intel.com>,
 <dev@dpdk.org>, <rajesh3.kumar@intel.com>
Subject: Re: [PATCH v1] net/idpf: harden PTP frequency adjustment
Message-ID: <abKqLQmzhTE6P6bU@bricha3-mobl1.ger.corp.intel.com>
References: <20260312184344.1475052-1-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260312184344.1475052-1-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DU2P250CA0002.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::7) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SA1PR11MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f9caf3-341f-4c45-bb3b-08de802e8f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: dmHJ/gOI4FYKP57m70uXLU/jGexx4UTg2gWWsRelCLRyFSD0fkyoderIbSzMP+Ei3v34PQdedDIRoeYGYWcRlZdIZlc+MlHpnzF4B0z00xixQZsOCmZZSa3fv3y5/eiRSMxdYtzz5Xc7xxecO8+Asv+nX6MRUTpiYc8JFq99BHeIqh5AVtxLAJ9tB30exkgMH9z3zhMOtc2aBdXYALtsSFx7oWh+IPpZPWfH3gC9miTcmH3SvgQg0PwlAuFuih/hJ3zLELnZ9PABeKtdPDRCB42pe9edczGl+qkoKQ7iLJWqtPwdMhgHZ4w48qsrldY1n0QkY5qCmyKt6G3OPV1hG8qU54FuI9BtiL+/yovtXSCidQTb/q0ScEUuKlmGDsW/dVlal8fqjhzcBDNYMsjWH4QiHXBJSykAz+vjdzqk8aBPOqGxbADM7qm7hw1UHCsDL2/GPDViUTkF3xrRGmp6xD40t6hE/EXy5FkUGGr+/NrTRbgtzYx3RzTyORJQSB1zrXAhBTr0CFdEWRCEDCECU0JcrmpSiwOra/S5J+nJeVEdwMT6GlMeF9P9PfLOnIgtEhoHjvWF4Ibv+UxrYqpiBnPH0l/hP1ZCuZDn1eptSXWXi227eFOFbgSaLLXhC5IvifnaNeVXtFyYA9aXls324/J2d4ppHH0+QYbc9kfnPIxrJk0MYkd24J5ezmj8gk7QQzZWLsGQDJ12zbjdZ8CZ5gQdxFrBc25vkmO/HZYs8zs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MmxoPFDxRDpVsEmynXjed/2Nfb6vEjRz4lBS+WRZb1QPrLmbDW726WUwWIdZ?=
 =?us-ascii?Q?4hk3diqXbmH+h1XTtEGcPphRPy9HyWsUFu8C/zfbYKBB7mztV5X7r08N2mnF?=
 =?us-ascii?Q?ThlBSDWafGw0DIkHzLK/ffP/Xzz4r8nOovV3jIE/+xrtp0xeX9f0pLwUyhom?=
 =?us-ascii?Q?xEQ1AcuX0EMB627+JqP4uIVUbkg59KjXdeue1V0y6cp3o5aL9OKHSAMQvFX3?=
 =?us-ascii?Q?Gtcm7cl/pNHAGosEan0KN6+vuHGSzk+lTDFJ70D7gr8KWj8XEq3hHLt8NIGB?=
 =?us-ascii?Q?/W8dLJ0Kom2K41KCbpZRdPrPymDvb95Tvy6C2+FpQ2NcbJNtzzrnlE26uNrW?=
 =?us-ascii?Q?jaOnFCelIEAKoF/+jsTu0fmESM9LDqx0Fz35MF1kR4fiD/7nD7Nd/3mlUzi7?=
 =?us-ascii?Q?6ZA9uGUTm6DrD1KihHhVQa5xcmWYoT2k47Gr9DcUaoOJq5SJHCokifZr0tOW?=
 =?us-ascii?Q?PuMBbGZ0shMyGvIuFy3nUk8XT6dWstF5qevmp18CZuh8S1hzWH1DOIxYNwBI?=
 =?us-ascii?Q?t4Nep/NfbcbYH1cbkRYz+6SOTpN+DhpnR5KlZI1/El1Pn5CsyXnn9X0DrebW?=
 =?us-ascii?Q?HydkjEPNI/m5qRm8+fhIVlgUijq5Wnc4S1iNl//ucPj1i+o+rDdWu2SdOyzC?=
 =?us-ascii?Q?fKuVACxUgpl2TE1wCzh6365W3MEWR6tMCpaUPJ3xtMwDpXApLmO9jmdd1hwn?=
 =?us-ascii?Q?8cw/kaWCuiZEAPXFBXQRlX300Ra/ab9lxIqd2dBw3aLXzZ7bOfQhJ+X5sL+S?=
 =?us-ascii?Q?NTjRBTojq//7thXwOmNN2Gqjk+Y85GC2fPXdEx6vPUCiH/FwVRDZYv4v0XZ/?=
 =?us-ascii?Q?i7gy9udRoVcSnHvSC8C6chO0QYJcqJ7CrNUHfSsXHcd6c7t4HY5+3Xf8Qepe?=
 =?us-ascii?Q?pJhg21vtEejx2KH/wucZn/3O7djU8kcsx4ECpjQtfkAqWaWVgebxeaVNq7Tg?=
 =?us-ascii?Q?CG1SFLvjlSOZlf1C3Kp9IyVI/UHQ8eC6UFFCkgDR+BP3WdpT2MK5M0e14a+P?=
 =?us-ascii?Q?TkraqX2SRtAhbBNBRREZV2T1KEEE7u3NuKAJ0i6PEfaVQ6jW5NAcvdvLt1GT?=
 =?us-ascii?Q?TKw2f1DADDI2AvemkdQmK7LK92jiYvPa5whz1oam3ljTXBk2ybdzIt7mYCGS?=
 =?us-ascii?Q?yKzlB+RKiABW9few2ZmL0kDwyZXkLSn6uonBXEY2f3mfMgr0G/1eTQgYGfes?=
 =?us-ascii?Q?pVZsIzGSxc4hUFcjPdqj5DqOCujDBUzKetOE3PTFfb6K+qeeR7XmDPcZ/3ix?=
 =?us-ascii?Q?29lFeiZt5b8OGjxzFoY5GWTMVAtueIYUy5TgVtMBieDZm5YAHl3XyXGjvoTX?=
 =?us-ascii?Q?DpK31nBe/Jp4rwAEDuSrDqTYYgHlQXQxdadG61dUf9kjbZR3uEP1KkSNiWlQ?=
 =?us-ascii?Q?Ne5O6QQlvYeCBNw5IqAcBw89n6k/ViR3v3kevqbg6wsDyO5ZAUl36cdNODGS?=
 =?us-ascii?Q?SFMBadO7xMaRlcNJIxh/gXoIgwWR/hFQ7Vga5UsptPiUdb3p5jJWyZWjU865?=
 =?us-ascii?Q?vdcqfUpHUILiXZokfCZpmK5n89YDsAZeSLeKtLC2+VvCl04Ps6SIYLvCgptV?=
 =?us-ascii?Q?8DpkwihKqdEce76tePjEYuGtbv+dzmsab3z0KeCnSyCGo4gXAQiz0Uygq+Bi?=
 =?us-ascii?Q?Fx1atRYmK3y04tJUHE6wJoIftSDw43K30Y5+QwimeBEK/ntLD+D7phnXLdh/?=
 =?us-ascii?Q?LO7sCueAxm1SNSf2zdLLVZfUTm/WluqdQCJbbdvjE6JXZP2J7L0Z59Y+lC+E?=
 =?us-ascii?Q?s5qZ7o/V8kViHamMlQe4v7kOBsrR5zg=3D?=
X-Exchange-RoutingPolicyChecked: qDsgfdzSQ8phIAaZ1Spnb7NmkXEzjqgdKuYltTdfP/Eqd+D23EDiClTpAQ6VcD57h9U7Z4Q39cz0YYmtQK1dzBTFiZmVJzeWIyvZcv2/HKvhQZI70MSGdFyHPXubU35GZHXUUlWjbq5E5xRXYIVzGCyzAVroYzbFKdP4/k6CkjGB1DzGoBmsaa8DNZAroPpcYDMgt4EuVsggYGiB7kAgLPyyB3zJVE8LPbgRSZViD0ww5qNrUutqpZ0Q3m99g5iP48g7V5Ru4rVY+pVE6M3rNexGaSxcz3y3WHFwqMo05hI94qTRlj0A21y8y6yj98oWmX4ldUXj31GnazhzIhnZUQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f9caf3-341f-4c45-bb3b-08de802e8f32
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 11:57:39.4246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9QcOh/yAYPjUZ7dAwg/jsHvkHsrPyOiDJHqW9G8/fbKvj77J9kI/h8q3bPGHCKUjkDTDuzkkn1Q3uvnSQEa+7uxzqQ0aLlFW41dJJPPAmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6822
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

On Thu, Mar 12, 2026 at 02:43:44PM -0400, Soumyadeep Hore wrote:
> Normalize ppm to an unsigned magnitude before using it in the
> increment value scaling path.
> 
> This avoids negating INT64_MIN and also prevents subtracting 62
> from the reduced log sum unless the sum is still above the
> overflow threshold reported by Coverity.
> 
> Coverity issue: 501832
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/idpf/idpf_ethdev.c | 32 +++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
> index 5e57a45775..1c5bd2ee12 100644
> --- a/drivers/net/intel/idpf/idpf_ethdev.c
> +++ b/drivers/net/intel/idpf/idpf_ethdev.c
> @@ -1007,7 +1007,7 @@ idpf_timesync_adjust_freq(struct rte_eth_dev *dev, int64_t ppm)
>  	struct idpf_ptp *ptp = adapter->ptp;
>  	int64_t incval, diff = 0;
>  	bool negative = false;
> -	uint64_t div, rem;
> +	uint64_t abs_ppm, div, rem;
>  	uint64_t divisor = 1000000ULL << 16;
>  	int shift;
>  	int ret;
> @@ -1016,26 +1016,34 @@ idpf_timesync_adjust_freq(struct rte_eth_dev *dev, int64_t ppm)
>  
>  	if (ppm < 0) {
>  		negative = true;
> -		ppm = -ppm;
> +		abs_ppm = ppm == INT64_MIN ? (uint64_t)INT64_MAX + 1 :
> +			(uint64_t)(-ppm);
> +	} else {
> +		abs_ppm = (uint64_t)ppm;
>  	}
>  
>  	/* can incval * ppm overflow ? */
> -	if (rte_log2_u64(incval) + rte_log2_u64(ppm) > 62) {
> -		rem = ppm % divisor;
> -		div = ppm / divisor;
> +	if (rte_log2_u64(incval) + rte_log2_u64(abs_ppm) > 62) {
> +		rem = abs_ppm % divisor;
> +		div = abs_ppm / divisor;
>  		diff = div * incval;
> -		ppm = rem;
> +		abs_ppm = rem;
> +
> +		if (abs_ppm != 0) {
> +			uint32_t log_sum;
>  
> -		shift = rte_log2_u64(incval) + rte_log2_u64(ppm) - 62;
> -		if (shift > 0) {
> -			/* drop precision */
> -			ppm >>= shift;
> -			divisor >>= shift;
> +			log_sum = rte_log2_u64(incval) + rte_log2_u64(abs_ppm);
> +			if (log_sum > 62) {
> +				shift = log_sum - 62;
> +				/* drop precision */
> +				abs_ppm >>= shift;
> +				divisor >>= shift;
> +			}
>  		}
>  	}
>  
>  	if (divisor)
> -		diff = diff + incval * ppm / divisor;
> +		diff = diff + incval * abs_ppm / divisor;
>  

Asking Claude AI about this code and how to simplify it a bit while also
avoiding the INT64_MIN issue, it suggests using __int128 type, giving much
shorter code:

	__int128 diff;
	int ret;

	/*
	 * ppm is scaled ppm: 1 ppm = 2^16 units (matching Linux adjfine).
	 * Use __int128 to avoid overflow without complex split/shift logic,
	 * and to correctly handle ppm == INT64_MIN.
	 */
	incval = ptp->base_incval;
	diff = ((__int128)incval * ppm) / (1000000LL << 16);
	incval += (int64_t)diff;

	ret = idpf_ptp_adj_dev_clk_fine(adapter, incval);
	if (ret != 0)
		PMD_DRV_LOG(ERR, "PTP failed to set incval, err %d", ret);
	return ret;

Maybe worth considering?

/Bruce
