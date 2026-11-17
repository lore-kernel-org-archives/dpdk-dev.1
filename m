Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC4D606A32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GeKrZvmX;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=FZ9cj3x5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9140B402BF;
	Tue, 17 Nov 2026 20:17:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id D697E402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 20:17:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794943044; x=1826479044;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QVGUyp29U+GV5vCaOYHlH9ECN9CZLeKqo8+yDef40y0=;
 b=GeKrZvmXr+mPlb1sGm3oEJNsT+4eu2lhNXY+gmiwgIHo+Qu99wxgkIDm
 CZ8f0hL3K9ivILsfVlAkWL40Vv+0VU+zrGRGArdkZzdw3jt6DK2i3kcBW
 pyrNHEyVLEweW/e+FU1EXX0GWYzDViYltjrw7MURDfIdwo5B0jMDMlBkh
 eGhFqvrFm7cYT7ILiVH9e7z552nyZky71bFI+T76Pb18KD6SZShAyhTOH
 28DoJbw0l9VzLW27JwfPh5w++fahh2YTWjOFoteqjKP3JQXozwcHRJfwd
 cB8ARmkEG1o7SE23LLfMiRdjVZMzdEEYNPV/FLm7vCAIg2QYGmmHsdiDH w==;
X-CSE-ConnectionGUID: KQE18IvARba4tzS/NG+ZjQ==
X-CSE-MsgGUID: F14QsacORXOPakKz1Q2+xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3773126"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3773126"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 11:17:22 -0800
X-CSE-ConnectionGUID: 64dFs3W7SyKoz+/zGxobeg==
X-CSE-MsgGUID: XOS8wtObSmq+LHgVgQq7RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9696658"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 11:17:22 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 11:17:21 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 11:17:21 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 11:17:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8MJ+FJwZkYogP+188LBzsea9hsE0x4O/C2CKQMVnXQVFmLHCRSs5w6aasMvfn42XevhQzGCC0k0NmEUlTaSkHMIF4RbK7Sq/2LXdYvN1cqKJJwSmnr/57kLDDnBCellqusdgLPnM2GSPLV7RGor4XBWoN1/jdPuxrMRcgpNZXAzeFkV3VDryZOwoxAkYUmGBb9BmA36KtbdP0M1OrpT1Plf+ahbOdfyHV4s206RaiaaFyM2Krjowpk8qpwGusXvQeI3O0b174CBWE7ExnlMd+2qarJ72HWJNKuULcTQBUCmZ7tPILM8E14t7C3c7co+1slNhBV2KGZQXt6MiCGGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bM9iflEuix4l75EVxEbLc/bAFZnErPBjNhmMd4mPx8=;
 b=bo9AATJzR3TJdK0p3GMsC5HuzzUk70GkzzzBoUsN2V/fLNDrOUjaLAf0d6wt0LQiWxf4xaR+9VgSYqkqf51xYTuSMJpgJTcqipiMija2xCpX5Ke/D4lbls5ia4qi8+cVp55OZl/gKpHwPCrA8pdQlVvAuiKEStGuQKZv43NDY/5oKOHVafGd8Ut5ip0QwCs5UKpmjsGkqxz+BtJhYiJ6ZbV04BC0Ig4RRx41rU5aaLSd5oUnvefSotaqBq+qT2A0pc6yjFZ2M6aiZvlnOD8j27mUmwTvgrduwBuw36HaJgNtoJd++kpPipXAnCdqYM7VEUjVFHwxthUgWYK/afN2WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bM9iflEuix4l75EVxEbLc/bAFZnErPBjNhmMd4mPx8=;
 b=FZ9cj3x5316wHs/L6ooBDsbOIf356zlzF9DSlVg1vo7u+zeuedRvbeHWBlwJGWe5YrijiDH0OZPRkC+tVQK36jv+VzJM3EFYnhaAFWT3nrtzLek8yc3lcAZpQMJERtIy9updGDG59UnQAPdWufq5QlKvDybJCQRGWDR8tTe5NR0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CY5PR11MB6319.namprd11.prod.outlook.com (2603:10b6:930:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:17:16 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 19:17:16 +0000
Date: Tue, 17 Nov 2026 19:17:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] eal: silence unreachable code warning
Message-ID: <avyoOHd2QAf6aoo7@bricha3-mobl1.ger.corp.intel.com>
References: <20261117174059.736244-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117174059.736244-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0191.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::20) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CY5PR11MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 28bf4cc2-2f8d-4496-d8a2-08df44df6466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|261026140227099003|11063799006|261028144727099003|261021135927099003|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hOKhdRqX2HIqtatipSly2r0ZiuoEUlwVR5r9bKCnZiZAOskMOP01uFVwFYhMyBdk8yb49djvBpEZub/ZqWJORa40+V3CNM9sHi0QVkKqz01wmMNRrnEtgADQLxKQ4IeGZrM72/JmjaCoOPht8SFsTi+SOTHYZpDAdXGr/XkLQ++SYlR9eA8ULNQ53zpyTCyRBlkNXG4p+UZJrHyI95aqmp60UWZJh+FSH3KvUsr37WqLwAOogC0CLF7LC47LvEFdtdBZ29uMut+3sm89/5a+a/rkNj6GDvElXhs7pArXkSLsrRjtyAy52USJ3PgQptry/UDJbV/QU/bcAm7gm4P7Z6Kkn1gE7PTb9es+n433anvVaPrQt1Bf8Z6ihDMVS6EMXm0THHl8rJNCwhdDJIWGDIhyJwv/r8gLr3yMOxFqWIRab5lPEv1Nhpt3qhK9WYerdy/0OSXXeYaEyRjrpU5wnSt5GX07m+iBe8/QMK6CHPIouLkOwYcQU+9ExYNdFfdKh6ygXjY8QRmu2jiN7E2SQgaN46gGTttWBdyeFcOl8VcArTSCS8Iw0RokgEjIfiWSKTS4nZNBXeOkWbTpJke4VZ68hg8XV1ArB70E7sfY/+xVFZtWdz+VHvzWqrvlfdE6OhIUqw5RnxQ+a7Hh2OsHOqanWnerz7hkhqVYLH/NJO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(261026140227099003)(11063799006)(261028144727099003)(261021135927099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UwTov3BwQJppDbKsnG4AIN2gnLd852gvDZ9GjLCGtmLxT70CR5iBRU4L+CBq?=
 =?us-ascii?Q?Ov2CvepdX3WCHQh1k0+lgVpiivzrHzM8DljIBtZ2YCynRHd/ieLBakc1qB5+?=
 =?us-ascii?Q?KpwAi+oU+lklaJ3wN5IXm7uvAT90dNWdxmAIjTbRM/kfw8rh9Ymu1XMXMa/4?=
 =?us-ascii?Q?Q97hEnyDtidFjdmETwwmkiZIHrSNfCDldDibI4M1mhcG3+9kPx6lRclheQAG?=
 =?us-ascii?Q?+ADHFvsJd4KrcyhUs1xe9pdiQwDWV2bubQjZy+zBEKteA2h6vqgyImZkk5oF?=
 =?us-ascii?Q?xdKKRumH7OeNMDSONicKEfdzKYNPpck4R/5gk7xIppkECBIRBR3oLCRS2TIP?=
 =?us-ascii?Q?7VUr7p+1nyKaDvwrZsceaNeMy0nU1rr2yvxpsnW+ac0SEOHFhakpmDytBN5q?=
 =?us-ascii?Q?uZM6Yu88AMT7KEnOEhAV4Rz60AAz9K59OJ/mQmxtTQGAvLchrBq5syJPG3k4?=
 =?us-ascii?Q?fj3ObMZ7CuEC4RVjAjjvZEKGXND+SMgu4zRl1KLRNsQ2jPaZzp1W1gjfQxJ8?=
 =?us-ascii?Q?QJYnYn0OCGeXPoq7gXhQTWex14yEEdpNsbLEPb1TQqHN3FqZdI1VUmDywct/?=
 =?us-ascii?Q?ZNhQAkzk/EsnufvrZCSIwG1aKlgNxnfHsAIaFF2IzcVaheBV2G49SZ/zwyaH?=
 =?us-ascii?Q?jVp72Akx8uS7Ls340Fdvtgd5WOlQ9H4UOTmVnnF2z3AXhM6Xg6sdOv/cppya?=
 =?us-ascii?Q?3dmNZ0RyDuWwvXlVHvfN2cb3LDga+ArU6a7audinT1bSfUZRlEaHfKDz1S26?=
 =?us-ascii?Q?+63wjAuArjpPNjDp1HiGc5Yt+8TALBLFmNXLz/vNF671vWA97mQxh6dqAmcR?=
 =?us-ascii?Q?tQSqe9PJD+VrEBuKuNJTjP4fqgKRWC+9R5hFENo8DdQ2htHQqktOwMENbSd6?=
 =?us-ascii?Q?WIl/2tLQUYkNbFlgzHbEUDA9fWnRj5trqA9Iqb4jw5+IGq/cPli1Inf6Evp5?=
 =?us-ascii?Q?M2Gjsl64aynYn359n3dsWLxys1KRlTLr/y64QHZXXSdBpUZGjbi15+YPo3fX?=
 =?us-ascii?Q?CnPJ3QAhMr/MD5P5J18atlhfh8bL6sLxz9LteOjWujz+F+YHon2RoXAI569Q?=
 =?us-ascii?Q?mM9BUwYPeIzh8rWf84FzkqbjaKfzbtgELXk7EnsFJR0rAewaPq3x6DS0k//Y?=
 =?us-ascii?Q?62hQ7jKZ+vDuGa/uFbYdCCp0BMsXaRkbeKybbJzjNipz9OB565dfs6xRHfNI?=
 =?us-ascii?Q?M1X5GF+ijY6roxUJxMBiY4dwjlekBnuc9TZsFbI+lFjDLkhzaK2MzkJvnItH?=
 =?us-ascii?Q?JhKZmf3XM90dntMKPv4LW0jSHHp6aQxhrWWhODiVPg426rgGXb53RF4Ersek?=
 =?us-ascii?Q?MadRILTTEujAkqjYmMtte8zY+2PlVkAm1nzW3F/avhzPt802WMbzrBVFZz10?=
 =?us-ascii?Q?NvjGAFIg8k/nhhdU5il7Yo6tMqL3LUhlTeGkcN+npROwYg7xetiV7lAFd4kR?=
 =?us-ascii?Q?wYskyO4nJkoMY9ibtUFG9W5sN83XElUY4yd6k32S5+uB4X8CjCFLoLfOjrlB?=
 =?us-ascii?Q?3SSO/fBzmquX7a1nzlvcH4wkKmOUYzPhmV404FpQWrDTip13fO3C0wJuJmCB?=
 =?us-ascii?Q?/WU4I3znxMXvSvT8muNAIyGKSwXaqvYiNPU1timPTASFJ9yEEOdo2hbmsg53?=
 =?us-ascii?Q?f3OcaKwDYWiCWfQfVM4XEVWVQo/M/WbrMNF9V2BYR+v0erdHDRy0wpDQMBIk?=
 =?us-ascii?Q?H3guuV+gcebO+CBCBviCxdjZBGQOHmQvWYFDWB04wKP3p+IE1K9GVr1s7qWj?=
 =?us-ascii?Q?/urztGoFcYH2v3L6+hj+lahNmklBwrI=3D?=
X-Exchange-RoutingPolicyChecked: vpFfCjEWN73gvBCgmpBwMuQw7AyptUW/ebXFATEFadMcGD+CWJRRCv8ycPyk1PL+dYPJyhlezxn/SBkR0s7i7YLYpLM+W+hBoqLEeHcaX4AfJx6UvqYHTQa+EUoOvflJOYWfmyyOoAs3Vlj2evXU2O3guuEQ7/vJTHKkS1wAubxQiR7PBenxlAU/4Buz0Pkv93FmuIlXLtt9WxnE1X1/GC0dUtR1s1ZI5ZVwoOnBO2xka6x9IjYkdqcXXwkdspC/h+tPi2MTubZo5kpewlMiMMLbQr3mp2NwSlL9qj3iOVGR2M8alTxY+idcAvK9uZ3BspeQn0YxYHQO1kZhLyv5nQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bf4cc2-2f8d-4496-d8a2-08df44df6466
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:17:16.5101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMhHxLVx4Y6egM2pH6kth+KqfF9ljJknY4L2I8pZ5lHA6cV/qS8RN/29zQrqtcHws0xcaoVTR9dDbaO7IjhClh4Zt3GPd0xCvrI/5T/CLOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6319
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 09:40:59AM -0800, Stephen Hemminger wrote:
> Clang evalutes strlen of constant string at compile time, then
> complains about unreachable code. Use extra parenthesis to
> mark code as explcitly dead.
> 
> Bugzilla ID: 2135
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/eal/common/rte_version.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/eal/common/rte_version.c b/lib/eal/common/rte_version.c
> index 627b89d4a8..62572428fc 100644
> --- a/lib/eal/common/rte_version.c
> +++ b/lib/eal/common/rte_version.c
> @@ -36,7 +36,9 @@ rte_version(void)
>  	static char version[32];
>  	if (version[0] != 0)
>  		return version;
> -	if (strlen(RTE_VER_SUFFIX) == 0)
> +
> +	/* extra paren to silence unreachable warnings */
> +	if ((strlen(RTE_VER_SUFFIX) == 0))
>  		snprintf(version, sizeof(version), "%s %d.%02d.%d",
>  				RTE_VER_PREFIX,
>  				RTE_VER_YEAR,
> -- 

Is it guaranteed that the checker won't look inside the double brackets? An
alternative suggestion is to change RTE_VER_SUFFIX to the function call to
the (public) API rte_version_suffix() and use strlen on that. We can even
mark the function as __rte_noinline to avoid optimizer getting rid of the
call in future and reintroducing the warning.

Also, when fixing this, I think it would be nice to also fix the indent of
the else leg.

/Bruce
