Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7AF10F6FDC
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Apr 2026 16:44:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79A8B40A7A;
	Wed,  1 Apr 2026 18:44:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id E8CA2402E2
 for <dev@dpdk.org>; Wed,  1 Apr 2026 18:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775061852; x=1806597852;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=KoDx4G2U6m9PKF02ynubt3e/g08t0HnHG2XwbcG4LXw=;
 b=R9ERZjODrh7TzSifMO/HEZPjWl3FZ9VAL+T7KZgzTk9XXY9R5OtE6Ri2
 CLnqAOOtfgACsv1MYFUkUgurWMZzQaS9MHna83y/6ql4wx6WOBhYi0Wkd
 1qBfQwhtSh7vcx9Zx52/IrL6SYzXpDdozzdl8/LyM77GlrB72PmLrWfqB
 HDqCT9Rk/tN6riUaIgfREJs4tISbFlsN2NqRR/LfRlcYtJ2j0H6wgdcE5
 eJU/kOBXtJ/No5eHg+V8Pk0uhRaV72eg4zKv4RgINL1yjgNkjfsM32Hfj
 9OTjNT7wrmN4IVdMGI0iTgjKmgdZ5UZr1T/Xso7rrlECowql6W+bIedHi Q==;
X-CSE-ConnectionGUID: EnFOSA1VSVemIKeOF6OWIg==
X-CSE-MsgGUID: l2V5JKvpTGGry9zsK63Zsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76073805"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="76073805"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 09:44:11 -0700
X-CSE-ConnectionGUID: 1TuctEe7Q1iPYNw7h0GGtQ==
X-CSE-MsgGUID: GnmuS6qIQMmTbhMjhP0PYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="249934420"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 09:44:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 09:44:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 09:44:09 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.25)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 09:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMAD29qEhU/xSuvLHinMb4x/jzTUSCkTgab4Je9oeK1+mWd5nJ9zMESMMbwBx0k32owqT56/5fbgW/PgGKYLtuxKcKjREzLwi01mORdiKrDFSa+NY2BQ+cx2fy+SNIy56TLaem2HNzZOrRakscKvd1Q6IAnTk713hP1k4ieuN2q7XLDNBqxwuaQHr+t6v5b+b5N49ovmDWMxDTWfXowbpyykcvSJS9UjjnBy7bJfQtV34R9YjBOgrzSKt04cWRhwVKNa8WiYehGXhQTuXofY9MTaWYnYwhFXaAbrCpreWjt5mXxo501GrtiNTxIErVr5v6cz+RHkEeAg9gf91eIiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgkJZZwpDZU3ffp31AhrLYOIaSMjpI+qDB9mg9M8tYs=;
 b=gVrmrTIm+wNqyfCEZE36eNiEAt3UTuj2cskYi6Rigxdt1uti24aj+ziEAXmtdiKQMAX73CpYzFNtsxnteiLp/MXujB3wBAYrCrJW9HfBzOezgkV73Am/VjsPSiCgDrcocqwe1LAIoAySDdwal5dcwtmPNtN8vC0e3mTIRqm9rOXTry8tBer6NyoVSm9cT+qdiIJJhWnm9rgSsYeu4O+P1RnNXEJ4gQNkP1u7TTUbO6aTbnQGs2e3qRfQMTc2/2ozMkR1ksGxJEjdMgYHM/EUuTxvdWFZRVDA9Ug5Sozl/BKH9Igo0ZftgH+jR3qteCj1ivu+1b87L+O2Oz0cOMr0Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB6038.namprd11.prod.outlook.com (2603:10b6:8:75::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Wed, 1 Apr 2026 16:44:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 16:44:05 +0000
Date: Wed, 1 Apr 2026 17:44:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH 1/4] net/ice: remove unnecessary null check
Message-ID: <ac1LUOvDJDAhZtnP@bricha3-mobl1.ger.corp.intel.com>
References: <20260401164108.201404-1-stephen@networkplumber.org>
 <20260401164108.201404-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260401164108.201404-2-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: fd662b79-0e8d-4558-a614-08de900de2d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: krGpzeaLxP+8mA/y7X1tIMqiDQtx3nqcYcqAjhO7gKqhSf6nj53C1vgQPjJL/LbyBRFX+TVe3H3GVCor7Y6KWLCJYeO0NbYoujpKUC1cO45UAcX6i7zNENkmniMQUTcIeXB24/dDteCxiSReWwY0+Gs3VPNTbBGD+sNHX1UqB08/uNC89IKKfXO30hQqOHMKiVTNRCiNCPwnk2HYm5LUTA2YZNH+jzRDCTYxsTkTE9Kp8T8wW/vIECkqjILb7xZT+1+fYBFyWFvLZdRUBNOW24irLusUzI7jf6u6tZNnRr3nAA1ch0/JQ7wPgrVQX6VyEZ1jzBOqGVAdjCw/kWs5Ko9Dkz2XYw8pOAvklRVviXHX7N5vVXVgxzAwQSEmvjOysPCgB/NgpyGe+HHETcfTA9ZmIQsmY+mHcJU01ZxqYltvsIXk0H0dCNj2MIkb6iI5crEdlmEPbfdw6WgWSOyzgIFEdLU++7m9L4EoZs/Xe0HJ3BQExoYKAXGD+r69D/y5zbGglV49tvHuDLZE2DNYEGJ5jKsAI51SnUlTkCts+awVcglBKoXp94ujoaYr/IdJiCuqKx4eH75lJtoYudShXaljEanwIk3rjqbo9ERfFv6TWr2hEMfl31xerK5bTCYlH4yqbdAnhJI5e0xHQy9QooIllySpkY0laM6to77TLzTXMlzkD+149eX+MjCimACU6HvvnwkoZR2tE0jOO3t5LfA4zM2TKBflMlRqpmpZFDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uRIKDbOKv8nnAFPxFR6a+F0Ci7xiUtLZTh/pX4a83V5z85rDM6EFgfE12kFx?=
 =?us-ascii?Q?5Vn8TSjEPrPucWQyvasEWrud6M+gK6DXIpzZex7SvrPWgbKUdIxpmRPK7Icq?=
 =?us-ascii?Q?/imWJuo+LIYzS4KBLCJOjovW0YPOUE2ajmqzixyQj36eJ6vmGJTRc7IAUSej?=
 =?us-ascii?Q?5ZX3hwS/cau7NFFDHVNiYm7WmQTBio3MiJkahlnicu1MhSt1lzd5R0wNEoYh?=
 =?us-ascii?Q?crHGogU1Ksp1QKHRIiffE/tx6VrwM5Ta+Aj5NKybe/AW4fYSYRoImQ5Eqh4b?=
 =?us-ascii?Q?pxGYl4vYS6fXHgbFvCJtiMRJXKrlPXBu2pKr9zhOg6TRaOlRe5x+fpgad04L?=
 =?us-ascii?Q?g/DVu+wR5sDABlku1fO9D32ybxB12xpZz59fu09eQv4ehqZY1OtxTFV3IWnP?=
 =?us-ascii?Q?krlD/hyJxeRcGsuyvuXCygOUBAaz18Lr/QsRKDId+bSowIZX0THIsD2of/GZ?=
 =?us-ascii?Q?fVX1+z9TqIWQ3yHSkiANIj4IITG9hhyn3jOazKFCm+ngUOxA4k1ybWMb9lDT?=
 =?us-ascii?Q?Agcjtsa8cNVnuH5OJqKYypLREneeZkea+SF5LsstMdAcXpby+jtMX8MZsjGL?=
 =?us-ascii?Q?b3DxPkwjQkJERyogDHk7nj/quitxtsursbPqm/+kwL/N4CKEliVi9IVxh9Wk?=
 =?us-ascii?Q?KgUG1OAlJjA5nULTNEHeyXNaMcmSsgYp1bVzlNTOTYp2o94Bd2aJ6az7Cn5K?=
 =?us-ascii?Q?zwPj2EKKsgcv+3EFWTQ1y6v7YmVR5bK48L5UXWYQVQe45ueYPUS9w34Ee/9W?=
 =?us-ascii?Q?X17drPnSkrKKhi+g1qTT6dutUsjNX4ZjVjNUGhs26gSENy8VOdniyHadB7Hv?=
 =?us-ascii?Q?tCGsTddAOd1g+gAcVyRF+YFZqK63pYjs1jhS0xGUs1HzJbV0+ChdjyGatvRY?=
 =?us-ascii?Q?mpXgWFoPirm4qMjn/A6R1jSNtOIK5sbFbYWUpma0lE7aFSqgCeWtUnmgNnJp?=
 =?us-ascii?Q?gnCGuW+6ETTvjybjfKvD7rLs0cw8j77HDfjbka7vH8vTJS9K0Z1Ghz6vvLaO?=
 =?us-ascii?Q?eHGmnFe/guAxRzZz9ubZcQOxEPyypaa6QmS2UUTsFS4+e3Vi2oA8ECuKpExN?=
 =?us-ascii?Q?xnMUXd6tHrnkz3DeUguGFTTZI0KgX0bmfMkD/2NSfuraC0UCiA61DSnV1Due?=
 =?us-ascii?Q?DwZCIhEf6LCJF3PQu0TAwbkyNWgpyZLwTafYkxEXVL2GA+ApJpT0lP5hVAC+?=
 =?us-ascii?Q?YkF2cc0xxZINEKPEFeM50SLeEMJjMsmooQOgIduArJbc8J+twge2yrenq8qg?=
 =?us-ascii?Q?1mM1up9YN63APTXMR+k6mj63fsOovuGt2/fBth972qeH2YJdHSEw9QnjHG11?=
 =?us-ascii?Q?fURjSw6eXcbU+Pv4TMcHMCvP/UROUjI97jjPtNtaY6lL7NDh1O8o9jlb6q0Q?=
 =?us-ascii?Q?M55LJVfS8oevN3AyjbCDbppAf50YY4Ddf/40JlHoeUBr42moxb0UPQCSpvZ7?=
 =?us-ascii?Q?6QwXDgB6MkzYnxv99STZkjrxwy7vmCABPjNbQKb4yygpHJpEyKFjo3ULjM9t?=
 =?us-ascii?Q?WQGFpGMXIHDf5BdUP44M2Sxz9e2N0rQ8fg9U2fykgHjIEhlTeGB9sYdFFsF0?=
 =?us-ascii?Q?BsiAX4WPQdMyQE5DQ0SP3y6iWifZO1nyCiSXmIpGGfi6CpINf6Cg2X4GqWBT?=
 =?us-ascii?Q?do2qed++nI3HrD9EpOuj4s6aCLScE586NkbPPXyEtHMZQScEyXi8LAHj8xQ/?=
 =?us-ascii?Q?35Qt4QEM5kGj7Sg6Ftj1tWX2+HSRUlcQ1vsmAPnnG/boZI0KVQbaSxsWCuvH?=
 =?us-ascii?Q?E3LxJtT9elKTuWtshhaC5puYOhUon6w=3D?=
X-Exchange-RoutingPolicyChecked: Jtv1ifYg2eo/H7ZNHPGaOeZkL97H1skv2HiRNwc7cWwfZFn2PM+UtlCmOtodOZ9dXwwSSlwZBf44lGnGb0gCFomUmaGqbwBsk/K/noEuZpnUY/WF2Q78+CvKB4QNLD2XxgMFkxrkFrjKhlysbOzb1fz1IOUh+TlHnX3KC2jsdVL5kmeE0fk3Wwvcnxx7AmxoBdceB0Bmtb4z93BTGD4Ktn6jCFlM/kB3XfmJkK2FFCh4BggcEy6E+dCXDHrj123y9AoOpN3qUObFZErmyE907je3012zQUad3h6bMqqw3GtqwacZYohiHD/jzroP4HGpIRANY/Q3xgsOVgdmPr3zoA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fd662b79-0e8d-4558-a614-08de900de2d4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 16:44:05.0003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZu+ugGB0VMzcwVEFSPwkDx8pxWHLc8ctIGVCxhNKr/AetXtmm8VetyCpozh1qhkHF7dWbdO3VTRG7oYgeJ+9M9WKCf5aiT3DrtxKIT/s3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6038
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

On Wed, Apr 01, 2026 at 09:40:22AM -0700, Stephen Hemminger wrote:
> No need to check for null before calling free.
> Found by coccinelle script null_free.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/intel/ice/ice_dcf_sched.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
> index 948774a282..14e902edbe 100644
> --- a/drivers/net/intel/ice/ice_dcf_sched.c
> +++ b/drivers/net/intel/ice/ice_dcf_sched.c
> @@ -877,10 +877,8 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
>  	return ret_val;
>  
>  fail_clear:
> -	if (vf_bw != NULL)
> -		free(vf_bw);
> -	if (tc_bw != NULL)
> -		free(tc_bw);
> +	free(vf_bw);
> +	free(tc_bw);
>  
>  	/* clear all the traffic manager configuration */
>  	if (clear_on_fail) {
> -- 
> 2.53.0
> 
