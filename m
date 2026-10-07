Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346AACA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 13:01:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C0F8402D2;
	Wed,  7 Oct 2026 15:01:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 91AA140268;
 Wed,  7 Oct 2026 15:01:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791378090; x=1822914090;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=F16hsRwN2m3QHa+GrDuZT1x49XPsxMT78uYEhGQgThA=;
 b=f4CFWpUQZUvMCBFCnyCf0EF0SU8YLB5xWleya/vArShUQW2OHP/pkeU9
 1bBMMCW0vlS8QKmSUmUjFZyDa7Dp2DMaElJqB6DmP8VR4f3+BsZFP+TWz
 fRVXSVxHaxmftOXOBruzKIvzPFpgZZAhkEW8qNlpCv3Skg6zXXP6BMJR/
 0hB6Q2ArjCNgjFWM+qvHNHJ0LK0t5/SElg8AYMTC6Zb+eoB/c/iqRv9FI
 Dy7n7rFT5wOLhX0yjTZgYvk0dK/xHvSouZZb8gMfOs1+rOHaua+yK277f
 WE6YmhcxlnPT+114+FpSwABH4cZCyJqhdLbd3Mx4EKnyHNcv5D589vm/s Q==;
X-CSE-ConnectionGUID: +/+2EOcjSpKKBCbPp88p2A==
X-CSE-MsgGUID: 1akGa1inTBKZUEF9GhhReA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="19271"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="19271"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 06:01:29 -0700
X-CSE-ConnectionGUID: Keh6P2/IRAuKEswCV+QfRg==
X-CSE-MsgGUID: oF4AkD+VQDqTOMwVzxMmLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="1533438"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 06:01:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 06:01:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 06:01:27 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 06:01:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkoMU0acHsuj5yTBO+v5iDrsdo6aj65xHOGhT8+tyTtkKQAbUYKpGz9kWUfdOJkrmjbOQUlA3yMEt8Y+sOKIY1HpqYxGip9mKBPlC0xnrfgwSAEKHj6/MAL1F5A0M8NNJ2ejCgan0yGrjRWb4fnoL8H025WIQJcrfr/4TQ4pH7JgA4vYb8ihj0qmbY88a7YpvIku3XRmf6HN7Pn2RHGrFx7cyMaCxGhUwYC7z6Bv7wTJGDwZCqKdpOBYCmygPjTO7WI8/ajXA3Ck6BOAVGH9y70IAPXLEEKb50kUW0HX4u46yOZ7/Kvc6AnLdSPDxu1kT1c2JgfbbBte3APqLTla6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzzPy3u8OkgJ7DcG7MGCI+7Xp5G0z+4eHnwR9jRgp1c=;
 b=ucMFHLV41LNB+3lA0peIUnzm58KMg86gVhp5YuWqyTk1TW/eKV12Mmw0jcb/OBAt3Hpc84zcAmaeBNwWFFF1KifKouo9162hY1vRdL6mQbYnKjXVz+zPXGNzskBpH1yJ/twBwVUAoFVAdTvSQmIrC0rbdVDP6hiRKICl03gqMTXJhbVbPuQDCWV0b7rN0QyVn11Z1IToGEdszazO22/l6W32kIgepwX2Lh54BTypeL9VD0oqH6s/kip1r8Kl0o802y66BILUHkyGRTMY5fp+umNjrPM+5RtK83R8lo9dNR2RVAcjoIZAik902juo7wATHgaug7zkUJDjV0IozuBC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 7 Oct
 2026 13:01:20 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Wed, 7 Oct 2026
 13:01:19 +0000
Date: Wed, 7 Oct 2026 14:01:13 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dragos Tarcatu <dragos.tarcatu@keysight.com>
CC: <dev@dpdk.org>, <konstantin.v.ananyev@yandex.ru>, <stable@dpdk.org>
Subject: Re: [PATCH] eal/x86: check OS support for AVX and AVX512 state
Message-ID: <asZCmYlJ2KmItl7J@bricha3-mobl1.ger.corp.intel.com>
References: <20261006082056.46426-1-dragos.tarcatu@keysight.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261006082056.46426-1-dragos.tarcatu@keysight.com>
X-ClientProxiedBy: DU7P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::14) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH0PR11MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: f75fbcb2-b749-4dcd-90c5-08df247314a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|11063799006|10067099003|56012099006|6133799003|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: BI8gjn8nCipDCrvL/FWz16350z/c/Igzx5ZaoFcdR+/1GQ5ujRBrv7oE99ufTqBfTS2ypD+UbS5gCnPEX6FirmZ3gIwSGskxor70I62rEBQAnIVQeu6SmntjgeSKsN+tB/H/b0CadWjMYpFgvYtA15k0ndYx6ln2TUNouWVsq0PM9IUULEG1xAOmRsd0IcmjdDzKZyUNSNmPkPUvOrbFRQ12dep27gMBtcR2ccbwwvIENWEORxKpDXzC0e1Kv9wRo1RR7w+hI9s+RuuifJT5PWthQCrtyBdVs54OKcP3Unjk0kKtSnWtwSka+U5Iboo87lsUgj/sLtvW9/mntWpn8OBt/iKKkZTb3bWdJfkQPXu4oOYHB/WuVccYQnwUV8oZeVtUI4wS3TUOXCa9ziEzI04uYpgACwOR3L1vved7qOM9T2VsJZymSzfu9aDxHEX7pwU/nzRKkC+vQliqNLqAshgNw9RH8vYzHXP7bPwX+SpU8ZQK6+AC7Ql0q0uCOkDiE6NipTT6y2sRHDIxiLpwK/hEWRjeg/JiV1IuOGCj06XqtT4Khmq0XtE0S0iUfLzyn2U2dJTLzEw7F0GYc1UNhE6dPxPRvX91jzbSGuBQevby5jam9TkO2jOOfSCM+YoGqNFGveUPw2NgHt73ewjS3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G6YUikfLiREvnCR3+mpSAsDfUV7m2U+iy6hcVAGrabgsL4hhV0oGqLCBIHXI?=
 =?us-ascii?Q?uxKDIEsPsJ4vM4kusr4tSfJ/ybTzUR52sZ4ylA1COwk8l4z2F7WtVa9PaiBx?=
 =?us-ascii?Q?VdHx1D5J3i9zhWDT3Q4kQXaJpiD6fsZ7UIyv3VtNbJGQW+QwLUXC1DDjWRiC?=
 =?us-ascii?Q?0W1ItyNl+J4HIHUK+BE7nofKqciPdbPsj/mTSZnt2kYlHkeuouilWtgRnO48?=
 =?us-ascii?Q?gEA/XExCObTgNQrq9WAKv+i6Phov49YKKjlN3i2hptjGGuwKpgrhwwk1n8tQ?=
 =?us-ascii?Q?q3MbvBYD8to0vIpnroTmaXAGtHRxsZB5vIfrXc+r8YsJ1k+/or1GMxUIr58/?=
 =?us-ascii?Q?jO0HyEf2WffXIm1sCKNicmKG95lYuiIQmQ17uUb8ft3QlmuamK9a2up8BVfF?=
 =?us-ascii?Q?kqPnwxaEotHpds6yhDGoutZDFBMXZ2R/4q0i6+ecXZ984JLeDaiQEt9PEDV3?=
 =?us-ascii?Q?noHpIEnr5L/8XRgySyvsTSwYTo6vTZE5sKJyFa2C7FsmugywZLgdu3Va1k0G?=
 =?us-ascii?Q?AdiceB8/f7SbYW+er/d9NFp01bUh5Nxn42ofTM8A7MiapxXtia4dyr+g/HTY?=
 =?us-ascii?Q?EDDi3vEtw1o91snV29t3vZBPDdDiQeG5B+E6fHd+OK8gSn047ftNPOKHlOlE?=
 =?us-ascii?Q?UC+0a4lThQKQlr5gM9smlJoH8PuWzDGlP9wtfeYoe6QV9cnctsrllZNTQc/v?=
 =?us-ascii?Q?omLgt4w+gvr2RzqhGev+gd3HD9TQkiPRAzJ+LKD2uJal8T+eJlcAViwPsV1e?=
 =?us-ascii?Q?0BgAFjdEFucXuih0uX6ccdb+clZEEEFvuo8xL6Dq4R0fit4e4g4tYrUpWQWt?=
 =?us-ascii?Q?sD1v4vxAEHo+DmV6yczxx2gCgz0EWq1pLQkvIODFf3fiZiUTJnIrIxt0BC52?=
 =?us-ascii?Q?ItVNtXS+iW13wqu8m4dKBZut+sWrVLOG9IEY9tfk5Kfrrdu2RWxfYos2oqJU?=
 =?us-ascii?Q?FmEM1+aOo2GlxP7UaZM8D7J5L8qcSbLFcmILRXy+u5gWy1CgcIwgLfbchmXy?=
 =?us-ascii?Q?Z3AXaWL540wfI0iN7+HQPpGYBCLHsIc6hsH7b1YJqDifkTluEGdJVbN6R+Xa?=
 =?us-ascii?Q?Zc9a0Oa7abQfZ6pXkWmCJoKFdE8DaoZE1NQ9bTDZEX+Q1C+gCeRIazDwEiNa?=
 =?us-ascii?Q?vrWDiWpyu+zxIiGOc7eaiHDRZHsIVCVgKg+qkljFhrvVWvwklsniaAcxd+eO?=
 =?us-ascii?Q?jxLHkBRaS1C4TCLVPe1WSr1aB/2eUUqZXBPz6fKz7C24rT7qcBpiWlbxPXwl?=
 =?us-ascii?Q?b2E2JlF6hRuvsOCpgEadpIU+OtFpCzqbCuG0XMtrUSbKgRTwQbi0GVbOqZwm?=
 =?us-ascii?Q?+bWz1k1Ugmnvx/KHMVTzrWmzNohfpEtqMgz2zzTEi3Uub9rJw8/rOzHTergh?=
 =?us-ascii?Q?sA1yNno8N7HJTpeE1fLb3Urk7vOrIT1b+bY7X9PzqlLH2uE57LKmsUM5Lakr?=
 =?us-ascii?Q?z3O9XmI/Ba89CIlOHks3lphiElnGaZmOymHCf6vbAtBHBJt3vjtyvmjbY84d?=
 =?us-ascii?Q?eUvL1NMQgfEjgS8LkSrcRNnp7km2XcXcwrBEATEIb6Qtl9NzSDuCnVTqAvTP?=
 =?us-ascii?Q?y3f3iP4q72RD8+Eu1+oDNK2Gez9RR4Lkq+LjoTW0VnH7G1Pk68Vl9Xn9ZGOn?=
 =?us-ascii?Q?wLC1t8iceoKS9d1auCCBh9HB7M2cQW1L8tNaoDT9Z/YCnn+BldhZi54za+Zo?=
 =?us-ascii?Q?zB2rybllzxPw0aEcwa3terBaNMQXgb52Lw2xlpNxJqxPWLxT/y25loz22fFN?=
 =?us-ascii?Q?09L3UAsabv0jWJ7u2e2o4Yuc6GqWSSQ=3D?=
X-Exchange-RoutingPolicyChecked: ACTvGc6Y6WFI9RPZLzIH48r9n+zvf9NwwKmwU+rGt3ryhvxiAgEKkwTyyYWK72eoMIZnyfrvtt72vKg2TGLVFfQ8xM8IB1w11QNTTGUZ+8AvuybyHxKnFJ4pKF++Z+C4Sy9K2kZXoU3orazHtPAhf1d8ryirwu4HhNPkJRJ6NpcARr1Qbr068cBPtYYeXveCYaL7tVI7ANuCmzqQsPvRGGGUjISbLh6hQhqaDJY72wQaE1Z46BXqvMaAxfB16a5Bs4+g5kllo/zaus3KCpvBGLJLg7afmSUH28JEKxbOuJP8yAEVskv6HUYvbrAGCRvogm6gaj1i6/ci420bHFz+ew==
X-MS-Exchange-CrossTenant-Network-Message-Id: f75fbcb2-b749-4dcd-90c5-08df247314a3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:01:19.8132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/G/xsg0RhgmK8QbybNpYcn8kH+nxAzRwb1HNI6IXdMtAQMgVGg4/HwWX/RJtAklMaZ5SYJZhQZo784vtgreqZ+j89BolRCuaAv+kgZW3jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5902
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

On Tue, Oct 06, 2026 at 08:20:56AM +0000, Dragos Tarcatu wrote:
> rte_cpu_get_flag_enabled() reads only the CPUID feature bits.  CPUID
> tells what the CPU implements, not what the OS enables.  If the OS does
> not enable the related state components in XCR0, the first AVX or AVX512
> instruction raises #UD.
> 
> CPUID can report AVX512 while XCR0 has no AVX512 state. Old kernels
> without AVX512 state support leave XCR0 at 0x7. A kernel booted with
> clearcpuid=avx512f removes the AVX512 state from XCR0, but CPUID still
> reports AVX512F. Similarly, gather_data_sampling=force removes the AVX
> state.
> 
> On such a system, the rte_net_crc constructor selects the AVX512 code
> from CPUID alone. The dynamic loader runs this constructor before main(),
> so the application gets SIGILL before EAL can parse any argument.
> 
> For the AVX-class and AVX512-class flags, also read XCR0 with XGETBV.
> Report the flag only when the OS has enabled the related state.  Use
> XGETBV only when CPUID reports OSXSAVE, because the instruction faults
> otherwise.
> 
> This change also affects rte_cpu_is_supported(). If DPDK is built for
> AVX512 and the OS does not enable AVX512 state, EAL can now stop with an
> error that names the missing flag. This is possible only if no AVX512
> instruction executes before rte_eal_init(), for example in a constructor.
> 
> Fixes: 3934bb741354 ("eal/x86: identify AVX512 CPU flag") Cc:
> stable@dpdk.org
> 
> Signed-off-by: Dragos Tarcatu <dragos.tarcatu@keysight.com> ---
> lib/eal/include/generic/rte_cpuflags.h |   3 + lib/eal/x86/rte_cpuflags.c
> | 102 ++++++++++++++++++++----- 2 files changed, 86 insertions(+), 19
> deletions(-)
> 
Tested this using two "x86-generic" builds from test-meson-builds.sh, one
with this patch and one without. The test app from the one without the
patch gives illegal instruction on an initializer for avx512 crc, while the
one with runs successfully.

Code looks correct to me also.

Tested-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

