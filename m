Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A993CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 08:39:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C8DA40EDB;
	Tue, 29 Sep 2026 10:39:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 790254013F
 for <dev@dpdk.org>; Tue, 29 Sep 2026 10:39:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790671190; x=1822207190;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9KradGJ4iBI0oj5p4Buw/3LmYBhLFEqUInLIutVS6LE=;
 b=QA9QL3ZryQOcViJH/H4/iZwQPFk+OJxor3KfFq0J1OQlnCgpni2HjYic
 oYWnOfzRVweXuZTbX65wJdgUbDISfUOHMfxOsLtHarvD296PwOhT1HYww
 aEJumM4e5rzmrGoIePMY0cTHUlCO39TxrslcIF8jVWRBVgQqsbh58MOJY
 tmmc2A59e7Yq9N51CZf/ggbXPg9mESjh8jngqgzuNfBOIb1HwFVrmC/av
 JkbnjvL5UP2X2vd4w6BcYsI3NTutEbv+LUtU2TQvQmLLvjm3WIN58OlSJ
 A7nyXtavudMJ/Xw+g/GD2gHDqARYls5RbH49xfVCUqmOcltQWPYLfwILW w==;
X-CSE-ConnectionGUID: Af2+mtbwQeysy8aRMUAvzg==
X-CSE-MsgGUID: a0hp1PoBRiijZQVbcWwPZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101549553"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="101549553"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 01:39:49 -0700
X-CSE-ConnectionGUID: B+V/8bV1S02zQlMzqem+Gw==
X-CSE-MsgGUID: rMt6LhsHS8qG7BFDzw+3sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="273915473"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 01:39:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 01:39:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 01:39:48 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 01:39:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNMNt1tYXkGKe9dXtIrlmPLRsr7N7Qd7csFFkZozk9ZK0MWHXNK0LrCvJbdZUt1GiIEBzhORuxEjHfhZCoSe0NI4LDQ3qDlG+Kmt0NpxotxhEOl/agGZchGCyxCtmvvMzKn3zOauQLud+A1p/nQZaBmGongYmCLSfhKZXLpOx8elPIxJQC7i4bfKjiYj4h3/Q6oKdsbk+RL6LnYgFqNN8V7xWd4PHdG/DOWirIcd35aXbzUr/3f6vb8rNLzfjmPho1N9lVRSDWvrBBjUP43Sx0KWy0KaJMqwYXseihzQ4YanxboogRV94doUO5ad6MU0XnBrevpWuAVnReKaMyL4Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poqS0eYHZN8tG7FFVnIXz16ZLuviorGlehh2FBTkaM8=;
 b=DtTbF0ipIXsZCU5au+1ONPucsmfWwYV43wXQeeNl3hB7a83o9HM3AQe7giKaY02S7LWF7JCQ8uQiNaK+BdhISK0lvht0VJEixCsHIxmLHOaFstPVE5Zif4lEnI34F7dbzVO3AuBoPLlVgNCC02OsrIwz4UDMF1Qy9nyUnjgvbiQufGh4im52CROYhNpsWUYb5sjie62fHUt0/UkVcxoAkM1IzCCKCmSB43pM4rJxDXoOWzB92uQd8pbs1c7sZIGWNwwxDndyQkZgqRcY7J394mZ0tCoEj9+paViyzcIFG+7Vf0C2w8oMKQ7490K3EAC/A7jLE2UsaPCMpct0eQUegQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS6PR11MB458838.namprd11.prod.outlook.com (2603:10b6:8:52a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 08:39:42 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 08:39:41 +0000
Date: Tue, 29 Sep 2026 09:39:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ravi Kerur <rkerur@brocade.com>
Subject: Re: [PATCH v2] eal: fail initialization if TSC frequency is zero
Message-ID: <art5SCrwPVJ8JkKQ@bricha3-mobl1.ger.corp.intel.com>
References: <20260927195440.89193-1-stephen@networkplumber.org>
 <20260928231637.733450-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260928231637.733450-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0164.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::19) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS6PR11MB458838:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4d6cc3-89e0-4090-bcf7-08df1e05347d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GVnA2qjW0/Beo0Zn4wzXG6XYPjYFBiDf0XHHrgHqGQGc3kwFD/tnwq3zIyCpLICT6f0shdLdPONol7wCfK14EPkA8vUjgdLaS3b3uQaBeAlnk/msn4FMUU1eV7oyS/UPElreotpXYP3WBixFonwzan9tEZHv/UJI+kQsYaw9VhUwsI4loBi/HeYMqQGhj1eAeapt1i6T/jyT/915PgZRZL7S/i5RXTYptAWJSN4AS0D6otf399NiInSjdgMwsYNR02WDAgsM/pm5uk7ij1QfkirEkOQNWT5epYsKOBzU3TY2lm6JTfFxesVntE4q7yI4Y/OhoboYg/fAYj1biLK57vR1j3PChfd4p+X5w+Wj8Dk8TOKIEdItsnHkG6URuVWbKGUTLeLvZ28br7Lkgx1T9N9mkE4t0LV6CRioXSo+1Gm77QNquYwx1OhSITZ5liT/zXDT17cf/L7PxUP87+KfAicqZNDfjdPQvVdzFKrbHBWjR8YqrHrwecIgWW6bghvBjVRJA5/sI2yYgc9TcBOUQFF/xxbbLUtZ9kBCRrm9JUIsPcMlumYNcMIWh3K4lmxSqaXnxiXUa1Obp0wYjg8oxjzl2ijswceyvkGc2Oht9T6vpSX5xIvKSUIArKXUGh+8V9OXjzJyWMc5H30yXWj6tSzQ2eS+wQhsyR5zu2M6Mdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LG3KfSKDfgyAppEM4pYW3qISsoYxAjfk0T8qQ9WmPtpaq+lYa3bILFY6xnek?=
 =?us-ascii?Q?fhIVLCpmyQXdCTdK4YLjxqDJ0texc6apyE6ZOzrgNaSthhMifZDOuOuQ13fi?=
 =?us-ascii?Q?3AeoA/OjApcx32yMnyvFT6wd3MAkgETTIvhZ3h6UKc4OYzLYg6D5PoefXGQL?=
 =?us-ascii?Q?Wmff44OOkaHZsQ5564ozxcKVhXK2woZyQCWTYfX8sfW3sppRLrFlrgQrwvto?=
 =?us-ascii?Q?n/qEGB22p2r6ulcmDi0QG6JzvZABcg+WqnXZwcZdQ43Fj3BMj/qE186vw+Tj?=
 =?us-ascii?Q?sEDuauqlmCI813SSmdJMGc5CIDahdfQvAk3a9vdnAiFA0LuTCM4WUXOoCsgc?=
 =?us-ascii?Q?19iCocCLHZVzfXGiTl3UugHNGpKvg79PWH92HJ/WrOQHX5rdW8PIrMzPTABC?=
 =?us-ascii?Q?gzjFJmeLw/z8/F96oBY7qDxPz7B+If1RpSq02G45NmmXAE7P3JHvxEykBunC?=
 =?us-ascii?Q?OCOy/uHZ1w9mTmwk0oJFcyP8fX5xQZktQ6HJCdjJEY0oGAHRp65vVgrP7DvO?=
 =?us-ascii?Q?nvBQfKYEU4pvx/EwksDNzv6NYIFApLjyZryLQnX+9rQL26UcXPO+JGkF/XfO?=
 =?us-ascii?Q?k/BhdgI6ugolKW3Z6u1OqkE22rZHtXtwgZiXlvc51iJEg80Rx+Z/mUlTH4M/?=
 =?us-ascii?Q?TMLZOBt+hZarmzbbq59IgDOxQxnGdoe/btrj7sYhsT1LIxZaO/EeKXUuGuzM?=
 =?us-ascii?Q?TXQOFx+7d+5j7Xdy4Ue04FQiiMjycTacuYcFrv3M3F9nLAvD1AVVFQIpp+gQ?=
 =?us-ascii?Q?SVtvEfMGQ4jJLWBffN6I1wEy3bRArAoKYGmXv0929FtUDo7WT6EtmZydyaHh?=
 =?us-ascii?Q?0W1TxT1991S1s3JJBl8c+bqZc8Elj463DzLdFyzFDnIPiUXzh/yPQFYSvVoe?=
 =?us-ascii?Q?X1h8qlyXf0ry06tGU2dpRhbWlCsyAF4aq0VQGOjKnuCdc5s6s5jYwpiwhZsj?=
 =?us-ascii?Q?WboJJzXTeI5TxPBvUySohVPeLw6K9Jtyui08lTIFO2tl/crJ0WGsACaC84be?=
 =?us-ascii?Q?0FWkc2XP3N2iH4M+fYkFzE5gl2DILSYaYi6qftlEz3DiMElhnQnbDgm2rfrj?=
 =?us-ascii?Q?qFSGtJ+bTTxu2etrk39GYygRGUk+VvlW+jt+l0xYEzVDqSqzNHb19CZ1yhbE?=
 =?us-ascii?Q?8cgKq26QVaMZ6b4OFx3MpFzON9FPn2ERY5uUhFqO7co4qa16Z3m+zgOscuPz?=
 =?us-ascii?Q?J/FAwmZPjgUMYomb6OB0yIg5vqkf6ovtTJJuE4jZt2CiwnMvXOAX+j9wWIRd?=
 =?us-ascii?Q?WkFLUGgNEf5XaZC4Yrl2eJh93/dr0dxkTpBhv/aIcyGFZHJOjFlvRpHiOj0G?=
 =?us-ascii?Q?b2Qj5EnHptllWw/NmIz5V29arrJ2WN0LCAfw3HalSdSXPLdJkvEWp2HkUedP?=
 =?us-ascii?Q?RJj+p1wuFBaEPf/F09We857hrjRPPrXQlwF3C3KwOjaN8Nfn4H4Gychp9V2+?=
 =?us-ascii?Q?AROgwwLbXjVkyB1Cms3RiI7s+TnkhmwnsvsaD1zC4whhhkilCwbhDnRnjYmt?=
 =?us-ascii?Q?QakbmLAYbjB5zgA/sMP+zpoyJVwHy9wVQXtyNs4M80T+GSKC9IrfDOnXb4RL?=
 =?us-ascii?Q?4ue6X1uhgnMQwT2dJOI4H6O4vg/13g9sb5yZ7mvgsMlDSC59k1xtsz4MiWvS?=
 =?us-ascii?Q?RLPM47WZeYa2PO50K8H62NRBQA7DhZpA+zRuEEnx33HheDVEfwkBR2keLU7j?=
 =?us-ascii?Q?UIaOOW9tBPq/zS1aVmpB5f3hWUdgoKOQKizT+d7mYq2LAhl+e9RUZGyK238f?=
 =?us-ascii?Q?/n46swsdYBnvCGQ6HxW/KvAE0jfhQ8M=3D?=
X-Exchange-RoutingPolicyChecked: Ka5brz9H36lxnBEXpysK5DmIIFIf/8+tklpbo4q0LNBvtkhpc7Ggi0T4mh62aKV9Q9/YG+GeoxivN3EUXPi1bMo8uBJOtl4xQdJewwoAUPAlEjctIgLcY5LapgI80zqb+cI2KNFZ3rLDoCQ8DRSap58Glq1rMthITzYhmVI4k0opya6pj3Lsrx5cKTScPaa6ZVyZ5O48BR22qClmbfTg29HaHtUFVGHOOiuoSnB5Gt/5qfhM+8yEl/n7wlZeIIvULZ2oWAnyFtq3UPaPYPpXq7h9tocFB75yZ1U3ZmzPhtIhfx2FlQqe2ThFHy5mHhB+f9ygz2wWTWOsKJazD7RvhA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4d6cc3-89e0-4090-bcf7-08df1e05347d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 08:39:41.7108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDxIJ13+w8MaHMRibHnD0fpFz7Ti9NmdCUu+oe+X7GrrbxJICCHs93yp7cUX2Ciehr7yGZ8j+vRta5QeoVv1AMC6QUsADAUIuKP6e4whNLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB458838
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

On Mon, Sep 28, 2026 at 04:15:58PM -0700, Stephen Hemminger wrote:
> Many parts of DPDK will fail with divide by zero and
> other errors if the initialization logic ever TSC hz was ever
> determined to be zero. This might happen on a broken get_tsc_freq_arch()
> or bad emulation in QEMU.
> 
> If TSC hz is zero, log the error and propagate back to
> fail rte_eal_init().
> 
> This fix doesn't need to go to stable since it is a purely
> theoretical problem; we aren't getting divide by zero reports
> from users.
> 

How was this discovered? Is there a coverity issue id, or was it just AI
discovered?

> Fixes: 040cf8a41187 ("eal: deduplicate timer functions")
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> v2 - cleanups: mostly squash useless comments
> 

Code looks generally ok to me.

>  lib/eal/common/eal_common_timer.c    | 19 ++++++++++++++++---
>  lib/eal/common/eal_private.h         |  2 +-
>  lib/eal/freebsd/eal_timer.c          |  3 +--
>  lib/eal/include/generic/rte_cycles.h |  2 +-
>  lib/eal/linux/eal_timer.c            |  3 +--
>  lib/eal/windows/eal_timer.c          |  3 +--
>  6 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/eal/common/eal_common_timer.c b/lib/eal/common/eal_common_timer.c
> index bbf8b8b11b..e9f8b56b59 100644
> --- a/lib/eal/common/eal_common_timer.c
> +++ b/lib/eal/common/eal_common_timer.c
> @@ -52,7 +52,7 @@ estimate_tsc_freq(void)
>  	return RTE_ALIGN_MUL_NEAR(rte_rdtsc() - start, CYC_PER_10MHZ);
>  }
>  
> -void
> +int
>  set_tsc_freq(void)
>  {
>  	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
> @@ -65,18 +65,31 @@ set_tsc_freq(void)
>  		 * systems where arch-specific frequency detection is not
>  		 * available.
>  		 */
> +		if (mcfg->tsc_hz == 0) {
> +			EAL_LOG(ERR, "Primary process TSC frequency is zero");
> +			return -1;
> +		}
> +
>  		eal_tsc_resolution_hz = mcfg->tsc_hz;
> -		return;
> +		return 0;
>  	}
>  
>  	freq = get_tsc_freq_arch();
>  	freq = get_tsc_freq(freq);
> -	if (!freq)
> +	if (freq == 0) {
>  		freq = estimate_tsc_freq();
>  
> +		/* Check if TSC is not moving */
> +		if (freq == 0) {
> +			EAL_LOG(ERR, "TSC frequency is not changing");
> +			return -1;
> +		}
> +	}
> +
>  	EAL_LOG(DEBUG, "TSC frequency is ~%" PRIu64 " KHz", freq / 1000);
>  	eal_tsc_resolution_hz = freq;
>  	mcfg->tsc_hz = freq;
> +	return 0;
>  }
>  
>  RTE_EXPORT_SYMBOL(rte_delay_us_callback_register)
> diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
> index 6340bab8be..952cb5a03e 100644
> --- a/lib/eal/common/eal_private.h
> +++ b/lib/eal/common/eal_private.h
> @@ -409,7 +409,7 @@ int eal_cpu_detected(unsigned lcore_id);
>   *
>   * This function is private to the EAL.
>   */
> -void set_tsc_freq(void);
> +int set_tsc_freq(void);
>  

One minor suggestion: set_tsc_freq name implies that the user passes in a
value to be set. I wonder if "init_tsc_freq" might be a better name here,
since you are updating all calls anyway to handle an error return.

>  /**
>   * Get precise TSC frequency from system
> diff --git a/lib/eal/freebsd/eal_timer.c b/lib/eal/freebsd/eal_timer.c
> index d21ffa2694..84127d876b 100644
> --- a/lib/eal/freebsd/eal_timer.c
> +++ b/lib/eal/freebsd/eal_timer.c
> @@ -65,6 +65,5 @@ get_tsc_freq(uint64_t arch_hz)
>  int
>  rte_eal_timer_init(void)
>  {
> -	set_tsc_freq();
> -	return 0;
> +	return set_tsc_freq();
>  }
> diff --git a/lib/eal/include/generic/rte_cycles.h b/lib/eal/include/generic/rte_cycles.h
> index 7cfd51f0eb..f8e1cde332 100644
> --- a/lib/eal/include/generic/rte_cycles.h
> +++ b/lib/eal/include/generic/rte_cycles.h
> @@ -34,7 +34,7 @@ extern enum timer_source eal_timer_source;
>   * Get the measured frequency of the RDTSC counter
>   *
>   * @return
> - *   The TSC frequency for this lcore
> + *   The TSC frequency for all lcores, always non-zero
>   */
>  uint64_t
>  rte_get_tsc_hz(void);
> diff --git a/lib/eal/linux/eal_timer.c b/lib/eal/linux/eal_timer.c
> index 39f975b6b9..bccff60ff8 100644
> --- a/lib/eal/linux/eal_timer.c
> +++ b/lib/eal/linux/eal_timer.c
> @@ -99,6 +99,5 @@ rte_eal_timer_init(void)
>  
>  	eal_timer_source = EAL_TIMER_TSC;
>  
> -	set_tsc_freq();
> -	return 0;
> +	return set_tsc_freq();
>  }
> diff --git a/lib/eal/windows/eal_timer.c b/lib/eal/windows/eal_timer.c
> index 33cbac6a03..aec8ea854d 100644
> --- a/lib/eal/windows/eal_timer.c
> +++ b/lib/eal/windows/eal_timer.c
> @@ -94,6 +94,5 @@ get_tsc_freq(uint64_t arch_hz)
>  int
>  rte_eal_timer_init(void)
>  {
> -	set_tsc_freq();
> -	return 0;
> +	return set_tsc_freq();
>  }
> -- 
> 2.53.0
> 
