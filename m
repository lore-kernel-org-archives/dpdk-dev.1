Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7A7C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 14:28:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0BC742E86;
	Tue, 25 Feb 2025 15:28:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 7B92C40E45
 for <dev@dpdk.org>; Tue, 25 Feb 2025 15:28:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740493693; x=1772029693;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HbSIPAjJkp1jWpBoqzhjFEMyOUplyykP1rcxxzY0deE=;
 b=JjfzEvDEY2rPmMutHvEWx1cEPCCj4sxg1t5RzBdBkdIMySixcUye89Rr
 tApaeDRHHWBD/eyspT/ZRltvDjfXG1ulthWIjPtPWP4mRkvKLGIQcXLhZ
 fbQk5jCqetN+bSNKK5gqelB4a+CsisCF4sfgCpOdc41DxMhmYYX/2H3Sm
 C2PunwasRbrQYLmJ4f8+8k7JgYrov2X0sqF2EUOBa7aiFNx1AU+ekrUEm
 zef5snOp4nMu7hHn4utthd7/+mfIaYz0rO2UXtWYEF7v6uizMXurceOBr
 wa5I1OuqiHjUOAtvFNQTIhNVVuVbOeFKeCDuz6ac7+RBs8BpDtICApxHs Q==;
X-CSE-ConnectionGUID: 2DPOT1VWRsa2YqtG1uvpLQ==
X-CSE-MsgGUID: egNKvrAlSHimff1jhQc1VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41504121"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41504121"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 06:28:11 -0800
X-CSE-ConnectionGUID: x1ScUGClTPiBTavaH8l3mQ==
X-CSE-MsgGUID: my6gVYpnROi7RcTYpueCPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="121655074"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 06:28:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 25 Feb 2025 06:28:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 25 Feb 2025 06:28:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 06:28:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqH4oTUrTWl7AC+r3XteC7fKuqId31erGU4q0BbHFlcl9jlFESaaNjrWFLxsX/vj4BYMISIIr3YMmofA+Y70vEMp9DaA9wxazugAOIuYcYCW8akm92Sl9is14eO/fhbWOaas1iPpTu9U2h5tRZo27MyPIGbULMF3+V8z7C2gdGUo368HbTzz82J47TEg9tSBQjJzYmqRpqmGUCewpScHK1Lxrv67GRbctTTrABNx/9tnnGPwrmDtUB0eBzMUhTE5VeqDmPRnzHCQ6XNUhAG0dV5OviW/JGB5xUrCt7pou+20yv+DjfdtKtVkPc/TBv5WYPn/igpiz1HMAWcbGoDypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7laoN/JT6HTp85KkKU/diJsZgbnKzhmKmJ8oGnj1dX4=;
 b=gMIXtpZmdUq8GRqGaJCNMkXzFzBohKPZfyUPSBf3AjtURj3e+QMVhBgHNd1wnXmWokxGuAvbVqQ7zm14Cqcv33QTg8/WCwyub1p84DeqH1aI0gosNWA+hUVrXpXk/DaVqPBzuRrZgm4xw4HWPPDjzfSyeOsH3zk88+w7arsdbcnqHHXCJ1qxDfCrMgzLNyMmdjcPI96WaJ2M/c2v6KWu16SmboYgbKXq1OkwYf3VIKXAFBcm9ARVh55cENjpdIgRWgeht0i844WpaDTy7d7s3qGr8gkyxXH5xcoV76VbP6fA/eLBXUL4CYz/z/7DWkLf+n+no6jpzowOX5IUm3NQ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW3PR11MB4761.namprd11.prod.outlook.com (2603:10b6:303:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 25 Feb
 2025 14:28:07 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 14:28:07 +0000
Date: Tue, 25 Feb 2025 14:28:02 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, <dev@dpdk.org>
Subject: Re: [PATCH 3/6] config: allow faster instruction sets to be used
 with MSVC
Message-ID: <Z73Tcj4VmlNYNoLM@bricha3-mobl1.ger.corp.intel.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740430879-17874-4-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1740430879-17874-4-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DUZPR01CA0328.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW3PR11MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a24f3df-56d0-426e-89b5-08dd55a89f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qMdahtqjUaa/k5UNvlYHsPMu+jzyuu5/DFf145u3p2DmPV3T1WYxPe25CX55?=
 =?us-ascii?Q?smQ/o7RQZ/lhqb4nr1f32mmOx7A9bP/75M4mF507JTpwt7wHD4UAKHe2Fd4H?=
 =?us-ascii?Q?cAG0AebD7qWJDkokpNbogiTef6McaoXmlwcKNXZVieGZG2G+nxdVwxTnb6U1?=
 =?us-ascii?Q?MSLfSakUItUnpv06YTInuKZXQjU8xIIGTWHPnmCk5PRFdsmamq4BwzY5HqQe?=
 =?us-ascii?Q?7Fo8HbPO5/TKxJ0b3kN7Frc+gFahL9Ti+h9HV2THmUDBTFRPsPaGhT6gwDfM?=
 =?us-ascii?Q?+a2wKgRjNxRBNnk00SveGbZZcDVFLhPyo+R+ufHPLVcmeGbfcdPcANZs0jJd?=
 =?us-ascii?Q?sTk/sXkn0TIp6yLSAdu1lAE5cP6cuf4CkCclYVGBtLfhwVTIxSNJJ+jpqK7P?=
 =?us-ascii?Q?GrUX6X+C4uowiDyCEF3iU9PKfLHZvkSW+6NN5pRxuQOLxOPvq6zp5hbBzZbm?=
 =?us-ascii?Q?dq6qILjIqhJ4yRvUrWxmNGfHFiZz6ItTM5m9JcGB41Zr4USa3s5uk398cm4G?=
 =?us-ascii?Q?yQyh+x16V2d83IdBVZUyqo3t1U27C5JiN9uH+KLHpWBkiuf4a/bL5DVG7dcL?=
 =?us-ascii?Q?1ZNYbhDghYyBIGynrP6Yv94k/cAZuCtHOk4ONn/KmxMuislWgCAwhOOaGFCm?=
 =?us-ascii?Q?jen+gAOn+Co32kYklOYxk+S7S8J9rHE9VHoRa9Q0ChORhdFmHYfZV1E2zBDK?=
 =?us-ascii?Q?0Q1G3pjRxSjwgS8fObDu1Z+I6oPlhtqmh5N0/fehqUTIoFwng8VdNb9N7IT1?=
 =?us-ascii?Q?4LwPtbcHmun3vs2+tLmTEwVtRemQEdgbx1UU5JCV+iyuAKN0G0YodWd6R1SE?=
 =?us-ascii?Q?X0XEK3EuX8YLimeg4rYDlIdLV5bYHTprxBwTNVsL2AMwk9ZpXFq70tvk4P+Y?=
 =?us-ascii?Q?SIJFmM0eYr9vrzaoeNegu2Fcwgc4ZpeVVNCIRH1PjXHWAivL5TM5dJvGacs6?=
 =?us-ascii?Q?DyJc75kQAjEjORl0ViwEDu5PNQ+7LcaMfBJT4CH8lCcwEATrRIo3b0e/+NnV?=
 =?us-ascii?Q?gZV1MLyD7HvcpY2z082f5PjU7xzTj6RkhIMBy43bBPgMPnXe/vIV41ZPYCk9?=
 =?us-ascii?Q?rgNXWw9kF0gSM/KGrFggiJqgwojMJ7fGoL8HovPwhBboJ2CcS+ziGsmcxqOK?=
 =?us-ascii?Q?ZGshBLs1renUKJrbNqjUUZxZaAf8QTh7eKGpQDRpJO6fJqUfebq1VTWUKYOX?=
 =?us-ascii?Q?b0AEURwHpnYkynGKawAUcqPisPYhmIx2RTr6aBcMln+tFXEpyRuswMc624Yz?=
 =?us-ascii?Q?Q7qhdmzHs4yR+c4olC9E57iEoOokYeXlEhGDzcmMloRIiHHqOO49Ojp8wNWL?=
 =?us-ascii?Q?B1Zrur6Ixkvr/tPj2csMz9h8CRpY0KESfiHhYyip8ABf0vfVAPZXUJgwSdAn?=
 =?us-ascii?Q?7fmNpyfhW63+c4hSMvHuLrsmrVMI61xNVWzrBvqGudkKYJ2vEg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DezRFKH1WLMdmV8bwoLLYXRqiySP65Ri7OAu8MYGrWvwcUYVNTXh0JjvgE9A?=
 =?us-ascii?Q?/V99/wAH7PVUj46sA0sbL+3Ue/FNxwDdG+eWK3lUzMPnxrs3m6fwwqJ0pi1Y?=
 =?us-ascii?Q?bZinmN05koMHA75rKU5Wh+Sn6QFOqMiQKLCpG2IhwlSx23AIGTqTT+ANvX4f?=
 =?us-ascii?Q?E/MryzsVw5FpzXoVXcKyG/btOd0NG6Mwb95ULsdsWazjfNILEu7axTUGGYT2?=
 =?us-ascii?Q?f/FLsikn5w+PIssqwEVc8TW6kkgOUrpgj7OJcHhOPpr7rR6eoLOdsKKf8D8r?=
 =?us-ascii?Q?ihLpbbHI2HkB9JF8bSKUnWKMf7dEh4R1e5ibIfi+SWRfAZ3DakRuZ8q50LSL?=
 =?us-ascii?Q?x+rJOLNOu0qLLOVK61D8goyvVDhEYw/1fnQq+MjbHCKWU1R/qe1vNrV5dvFq?=
 =?us-ascii?Q?ETZNqusgHQuFe41vM2+rfbgNaoHp8okHYUSlnqBekgv27vneprE+HysFNzX4?=
 =?us-ascii?Q?DP3iI9IJE7hy4QP5MKZVxkdkxHzpuKB+dHIUcQ/FPrpeT55PYrB7THBvmNjm?=
 =?us-ascii?Q?9a1fKeUdY6zRpRvqO4yywEXwbS6y0Q7uMw6jguuZYWO+II+DGMk68zucT9R6?=
 =?us-ascii?Q?EnFkLZNk0PIvQdkZHlGs3U8kA3YHHD83vTEMSseOVGmGa39+bkdlYuB6UAhg?=
 =?us-ascii?Q?uEKodS9eykzaLngkQZByDJrjko26WRos/mRJ+8yKG+tyyVhlYoYYftwJ8Qhy?=
 =?us-ascii?Q?X/1amx5AIxE5SDieM7yqd1utl47NAmKhbLoZ+ytII/9EL2qM0TYeYSYpfNaI?=
 =?us-ascii?Q?Pd1JKXjeqL5Cwt1i9oLspb5gmUbxde40g/s/NJGxwbMz5S/mWakRNotvbc3O?=
 =?us-ascii?Q?ruHLr+Z7ITU7AEELgea7YN0UczQrGy4FWR+27UKY/ZCPPZZy71tgTWbLwLVT?=
 =?us-ascii?Q?/fFEZixAWINHApq3kVJywmr6gQZk03mxHVbnXugxuI9EaJoYqTf9TQgO/0D7?=
 =?us-ascii?Q?YSsSiWZ5C/73+Y1juvEFd+83qbxFLEAN3ApFz7J5lHNLvHXafoL9fyWNU5nY?=
 =?us-ascii?Q?lm79rPYD5/+GtD0Q7d+Iayej6cYdVyMqBc8D/6Ro1crB03oqgYHIwIi8xAgK?=
 =?us-ascii?Q?ANpvPuW5yzToYN3qLla+77iU8B01QItfzJ8MkOaKsLwFgpJztwUgTOllYoSq?=
 =?us-ascii?Q?mnubeg1fix2/I/fqUZuUni7zBxhK4m9uE0Ks5sV6lNklXg6MGd7lX/wlZJeM?=
 =?us-ascii?Q?Y42cUnt3Xo1MNLWtasG8GSm0XnPHWxSmpIUrPZQJEWpnZ8xNhzJJho/7gGRn?=
 =?us-ascii?Q?MNdgDaES4OvQ7KDwu5dirS+3pKfEbxPqNvQ5sQhw67/C00apVQqBBcPcByn9?=
 =?us-ascii?Q?NjYe2BaC6zGPn96IMDuDEUXt7Vd2IcxWF+yo6tAGZ8wmZQi/LJjqEkta+CEp?=
 =?us-ascii?Q?M40mV7Hua08tGIvRFz5ra4HEcktraN9WuAHLClK0uZpvwJkemHYcGZ959INq?=
 =?us-ascii?Q?YH+92h2EP6ybGdJI9lvnXc0/yVdj9gAdEEVWxF5vwAZIpuJF/5D5rIvmdz3P?=
 =?us-ascii?Q?kkDOYbbVZk0d9d+ECavS+W9c1Pbm7BIvoOq8LNxLuemaNl9zd93EcHbTimOC?=
 =?us-ascii?Q?zu2F9PNWRpTi7pf3QgDcw8aB6N9lL3ZD7hWEGPCRdm3eechjjsYyWiJNbw94?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a24f3df-56d0-426e-89b5-08dd55a89f37
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 14:28:07.2918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgvvLOHZrwNc5maiaPbRu9q0hQZfx1Cn4jhzIUzb7SHkJcA9/sy0sh0k/GNZsIhHzhpoVlM8nmxIl+M0uFwkO+qeuOcE0k5ZowMIPIJkAcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4761
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

On Mon, Feb 24, 2025 at 01:01:16PM -0800, Andre Muezerie wrote:
> Up to now MSVC has being used with the default mode, which uses SSE2
> instructions for scalar floating-point and vector calculations.
> https://learn.microsoft.com/en-us/cpp/build/reference/arch-x64?view=msvc-170
> 
> This patch allows users to specify the CPU for which the generated
> code should be optimized for in the same way it's done for GCC: by
> passing the CPU name.
> When no explicit CPU name is passed, 'native' is assumed (like it
> happens with GCC) and the code will be optimized for the same CPU
> type used to compile the code.
> 
> MSVC does not provide this functionality natively, so logic was
> added to meson.build to handle these differences, detecting which
> instruction sets are supported by the CPU(s), passing the best
> options to MSVC and setting the correct macros (like __AVX512F__)
> so that the DPDK code can rely on them like it is done with GCC.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---

Hi Andre,

couple of initial thoughts inline below.

/Bruce

>  config/x86/meson.build | 364 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 325 insertions(+), 39 deletions(-)
> 

There is quite a lot of new code to be added here. Might it be worthwhile
creating a "config/x86/msvc/" subdirectory with its own meson.build file to
handle all the complexities of using it. We can have the common material at
the top of the x86/meson.build file, and then do 

if is_ms_compiler
    subdir(msvc)
    subdir_done()
endif

leaving the rest of the file for the gcc/clang/icx code.

> diff --git a/config/x86/meson.build b/config/x86/meson.build
> index 47a5b0c04a..9260969c54 100644
> --- a/config/x86/meson.build
> +++ b/config/x86/meson.build
> @@ -14,7 +14,194 @@ if is_linux or cc.get_id() == 'gcc'
>      endif
>  endif
>  
> -cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw']
> +cpuid_code = '''
> +    #include <stdio.h>
> +    #include <stdint.h>
> +    #include <intrin.h>
> +
> +    uint32_t f1_ECX = 0;
> +    uint32_t f1_EDX = 0;
> +    uint32_t f7_EBX = 0;
> +    uint32_t f7_ECX = 0;
> +
> +    void get_support_flags()
> +    {
> +        int ids_max;
> +        int data[4];
> +
> +        /*
> +         * Calling __cpuid with 0x0 as the function_id argument
> +         * gets the number of the highest valid function ID.
> +         */
> +        __cpuid(data, 0);
> +        ids_max = data[0];
> +
> +        if (1 <= ids_max) {
> +            __cpuidex(data, 1, 0);
> +            f1_ECX = data[2];
> +            f1_EDX = data[3];
> +
> +            if (7 <= ids_max) {
> +                __cpuidex(data, 7, 0);
> +                f7_EBX = data[1];
> +                f7_ECX = data[2];
> +            }
> +        }
> +    }
> +
> +    int get_instruction_support()
> +    {
> +        get_support_flags();
> +
> +    #ifdef SSE3
> +        return (f1_ECX & (1UL << 0)) ? 1 : 0;
> +    #endif
> +    #ifdef PCLMUL
> +        return (f1_ECX & (1UL << 1)) ? 1 : 0;
> +    #endif
> +    #ifdef SSSE3
> +        return (f1_ECX & (1UL << 9)) ? 1 : 0;
> +    #endif
> +    #ifdef SSE4_1
> +        return (f1_ECX & (1UL << 19)) ? 1 : 0;
> +    #endif
> +    #ifdef SSE4_2
> +        return (f1_ECX & (1UL << 20)) ? 1 : 0;
> +    #endif
> +    #ifdef AES
> +        return (f1_ECX & (1UL << 25)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX
> +        return (f1_ECX & (1UL << 28)) ? 1 : 0;
> +    #endif
> +    #ifdef RDRND
> +        return (f1_ECX & (1UL << 30)) ? 1 : 0;
> +    #endif
> +    #ifdef SSE
> +        return (f1_EDX & (1UL << 25)) ? 1 : 0;
> +    #endif
> +    #ifdef SSE2
> +        return (f1_EDX & (1UL << 26)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX2
> +        return (f7_EBX & (1UL << 5)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX512F
> +        return (f7_EBX & (1UL << 16)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX512DQ
> +        return (f7_EBX & (1UL << 17)) ? 1 : 0;
> +    #endif
> +    #ifdef RDSEED
> +        return (f7_EBX & (1UL << 18)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX512IFMA
> +        return (f7_EBX & (1UL << 21)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX512CD
> +        return (f7_EBX & (1UL << 28)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX512BW
> +        return (f7_EBX & (1UL << 30)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX512VL
> +        return (f7_EBX & (1UL << 31)) ? 1 : 0;
> +    #endif
> +    #ifdef GFNI
> +        return (f7_ECX & (1UL << 8)) ? 1 : 0;
> +    #endif
> +    #ifdef VPCLMULQDQ
> +        return (f7_ECX & (1UL << 10)) ? 1 : 0;
> +    #endif
> +
> +        return -1;
> +    }
> +
> +    int main(int argc, char *argv[])
> +    {
> +        int res = get_instruction_support();
> +        if (res == -1) {
> +            printf("Unknown instruction set");
> +            return -1;
> +        }
> +        printf("%d", res);
> +
> +        return 0;
> +    }
> +'''
> +
> +# The data in table below can be found here:
> +# https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html
> +# This table only contains CPUs that have SSE4.2, as this instruction set is required by DPDK.
> +# That means that in addition to the instruction sets mentioned in the table, all these CPUs
> +# also have ['SSE', 'SSE2', 'SSE3', 'SSEE3', 'SSE4_1', 'SSE4_2']
> +cpu_type_to_flags = {
> +       'x86-64-v2': [],
> +       'x86-64-v3': ['AVX', 'AVX2'],
> +       'x86-64-v4': ['AVX', 'AVX2', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD'],
> +         'nehalem': [],
> +          'corei7': [],
> +        'westmere': ['PCLMUL'],
> +     'sandybridge': ['AVX', 'PCLMUL'],
> +      'corei7-avx': ['AVX', 'PCLMUL'],
> +       'ivybridge': ['AVX', 'PCLMUL', 'RDRND'],
> +      'core-avx-i': ['AVX', 'PCLMUL', 'RDRND'],
> +         'haswell': ['AVX', 'PCLMUL', 'RDRND', 'AVX2'],
> +       'core-avx2': ['AVX', 'PCLMUL', 'RDRND', 'AVX2'],
> +       'broadwell': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED'],
> +         'skylake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES'],
> +  'skylake-avx512': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD'],
> +     'cascadelake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD'],
> +      'cannonlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA'],
> +      'cooperlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD'],
> +  'icelake-client': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +  'icelake-server': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +       'tigerlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +      'rocketlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +       'alderlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +      'raptorlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +      'meteorlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +       'gracemont': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +       'arrowlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +     'arrowlake-s': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +       'lunarlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +     'pantherlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +  'sapphirerapids': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +   'emeraldrapids': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +   'graniterapids': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> + 'graniterapids-d': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +   'diamondrapids': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +      'silvermont': ['PCLMUL', 'RDRND'],
> +             'slm': ['PCLMUL', 'RDRND'],
> +        'goldmont': ['PCLMUL', 'RDRND', 'RDSEED', 'AES'],
> +   'goldmont-plus': ['PCLMUL', 'RDRND', 'RDSEED', 'AES'],
> +         'tremont': ['PCLMUL', 'RDRND', 'RDSEED', 'AES', 'GFNI'],
> +    'sierraforest': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +      'grandridge': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +'clearwaterforest': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +          'bdver1': ['AVX', 'PCLMUL', 'AES'],
> +          'bdver2': ['AVX', 'PCLMUL', 'AES'],
> +          'bdver3': ['AVX', 'PCLMUL', 'AES'],
> +          'bdver4': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'AES'],
> +          'znver1': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES'],
> +          'znver2': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES'],
> +          'znver3': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ'],
> +          'znver4': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +          'znver5': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +          'btver2': ['AVX', 'PCLMUL', 'AES'],
> +        'lujiazui': ['PCLMUL', 'RDRND', 'RDSEED', 'AES'],
> +        'yongfeng': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES'],
> +      'shijidadao': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES'],
> +}
> +

I really don't want to have tables like this to maintain in our code if at
all possible. We used to have something a bit similar in DPDK IIRC, but we
found it a maintenance nightmare and just switched to using the compiler to
do all the work. In our existing builds, we just pass the
cpu_instruction_set parameter straight to the -march flag of the compiler.
For MSVC support, I believe we should just do the exact same.

Maintaining lists like this will be a problem as new platforms need to be
constantly added. Do we also look to backport them, because if equivalence
with the linux build is necessary then that will have to be done - as on
Linux when a new version of GCC comes out, we can then use the new
instruction set targets on the old releases of DPDK.

> +if is_ms_compiler
> +    cc_avx2_flags = ['/arch:AVX2']
> +    cc_avx512_flags = ['/arch:AVX512']
> +else
> +    cc_avx2_flags = ['-mavx2']
> +    cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw']
> +endif
> +
>  cc_has_avx512 = false
>  target_has_avx512 = false
>  if (binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
> @@ -30,12 +217,14 @@ if (binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
>          warning('Broken _mm512_extracti64x4_epi64, disabling AVX512 support')
>      else
>          cc_has_avx512 = true
> -        target_has_avx512 = (
> -                cc.get_define('__AVX512F__', args: machine_args) != '' and
> -                cc.get_define('__AVX512BW__', args: machine_args) != '' and
> -                cc.get_define('__AVX512DQ__', args: machine_args) != '' and
> -                cc.get_define('__AVX512VL__', args: machine_args) != ''
> -            )
> +        if not is_ms_compiler
> +            target_has_avx512 = (
> +                    cc.get_define('__AVX512F__', args: machine_args) != '' and
> +                    cc.get_define('__AVX512BW__', args: machine_args) != '' and
> +                    cc.get_define('__AVX512DQ__', args: machine_args) != '' and
> +                    cc.get_define('__AVX512VL__', args: machine_args) != ''
> +                )
> +        endif
>      endif
>  endif
>  
> @@ -47,42 +236,139 @@ if not is_ms_compiler
>      endif
>  endif
>  
> -# enable restricted transactional memory intrinsics
> -# https://gcc.gnu.org/onlinedocs/gcc/x86-transactional-memory-intrinsics.html
> -if cc.get_id() != 'msvc'
> -    machine_args += '-mrtm'
> -endif
> +if is_ms_compiler
> +    # Determine cpu_flags for a given configuration.
> +    # SSE instructions up to 4.2 are required for DPDK.
> +    cpu_flags = ['SSE', 'SSE2', 'SSE3', 'SSEE3', 'SSE4_1', 'SSE4_2']
> +
> +    message('cpu_instruction_set: @0@'.format(cpu_instruction_set))
>  
> -base_flags = ['SSE', 'SSE2', 'SSE3','SSSE3', 'SSE4_1', 'SSE4_2']
> -foreach f:base_flags
> -    compile_time_cpuflags += ['RTE_CPUFLAG_' + f]
> -endforeach
> -
> -optional_flags = [
> -        'AES',
> -        'AVX',
> -        'AVX2',
> -        'AVX512BW',
> -        'AVX512CD',
> -        'AVX512DQ',
> -        'AVX512F',
> -        'AVX512VL',
> -        'PCLMUL',
> -        'RDRND',
> -        'RDSEED',
> -        'VPCLMULQDQ',
> -]
> -foreach f:optional_flags
> -    if cc.get_define('__@0@__'.format(f), args: machine_args) == '1'
> -        if f == 'PCLMUL' # special case flags with different defines
> -            f = 'PCLMULQDQ'
> -        elif f == 'RDRND'
> -            f = 'RDRAND'
> +    if cpu_instruction_set == ''
> +        # Nothing to do as cpu_flags already holds all the required flags.
> +    elif cpu_instruction_set == 'native'
> +        # MSVC behaves differently than GCC regarding supported instruction sets.
> +        # While GCC will create macros like __AVX512F__ when such instruction set is
> +        # supported by the current CPU, MSVC does not do that. MSVC will create that
> +        # macro when parameter /arch:AVX512 is passed to the compiler, even when the
> +        # CPU does not have that instruction set (by design). So there's a need to
> +        # look at CPUID flags to figure out what is really supported by the CPU, so
> +        # that the correct /arch value can be passed to the compiler.
> +        # The macros also need to be explicitly defined, as /arch will not create all
> +        # macros GCC creates under the same conditions.
> +        # As an example, /arch:AVX512 creates __AVX512BW__, but does not create __SSE2__.
> +        # More details available here:
> +        # https://learn.microsoft.com/en-us/cpp/preprocessor/predefined-macros
> +
> +        optional_flags = [
> +                'PCLMUL',
> +                'AES',
> +                'AVX',
> +                'RDRND',
> +                'AVX2',
> +                'AVX512F',
> +                'AVX512BW',
> +                'AVX512DQ',
> +                'AVX512VL',
> +                'AVX512CD',
> +                'AVX512IFMA',
> +                'GFNI',
> +                'RDSEED',
> +                'VPCLMULQDQ',
> +        ]
> +        foreach f:optional_flags
> +            result = cc.run(cpuid_code, args: '-D@0@'.format(f),
> +                            name: 'instruction set @0@'.format(f))
> +            has_instr_set = result.returncode() == 0 and result.stdout() == '1'
> +            if has_instr_set
> +                cpu_flags += f
> +            endif
> +            message('Target has @0@: @1@'.format(f, has_instr_set))
> +        endforeach
> +    else
> +        # An explicit cpu_instruction_set was provided. Get cpu_flags
> +        # from cpu_type_to_flags table.
> +        if cpu_instruction_set not in cpu_type_to_flags
> +            error('CPU not known or not supported. Please update the table with known CPUs if needed.')
>          endif
> -        compile_time_cpuflags += ['RTE_CPUFLAG_' + f]
> +        cpu_flags += cpu_type_to_flags[cpu_instruction_set]
> +    endif
> +
> +    # Now that all cpu_flags are known, set compile_time_cpuflags and also
> +    # machine_args to ensure that the instruction set #defines (like __SSE2__)
> +    # are always present in the preprocessor.
> +    message('cpu_flags: @0@'.format(cpu_flags))
> +
> +    foreach flag:cpu_flags
> +        machine_args += '/D__@0@__'.format(flag)
> +        if flag == 'PCLMUL'
> +            flag = 'PCLMULQDQ'
> +        elif flag == 'RDRND'
> +            flag = 'RDRAND'
> +        endif
> +        compile_time_cpuflags += ['RTE_CPUFLAG_' + flag]
> +    endforeach
> +
> +    target_has_avx512 = ('AVX512F'  in cpu_flags and
> +                         'AVX512BW' in cpu_flags and
> +                         'AVX512DQ' in cpu_flags and
> +                         'AVX512VL' in cpu_flags)
> +
> +    # Decide which instruction sets should be used by the compiler.
> +    # With MSVC, intrinsic functions are always enabled. However, for the
> +    # compiler to use an extended instruction set for automatically
> +    # generated code "/arch" needs to be passed. So we instruct the compiler
> +    # to use the largest set that is supported by the CPU. It is implied that
> +    # smaller sets than the largest selected are included, as described here:
> +    # https://learn.microsoft.com/en-us/cpp/build/reference/arch-x64?view=msvc-170
> +    if 'RTE_CPUFLAG_AVX512F' in compile_time_cpuflags
> +        machine_args += ['/arch:AVX512']
> +    elif 'RTE_CPUFLAG_AVX2' in compile_time_cpuflags
> +        machine_args += ['/arch:AVX2']
> +    elif 'RTE_CPUFLAG_AVX' in compile_time_cpuflags
> +        machine_args += ['/arch:AVX']
> +    else
> +        # SSE4.2 is expected to always be available
> +        machine_args += ['/arch:SSE4.2']
>      endif
> -endforeach
>  

Since these appear to be the only /arch flags supported by the compiler for
code generation, I would suggest that these would be the only instruction
set flags that we support on MSVC builds, and that we then build up the
actual CPU flags based on the minimum flags to be expected when each of
these instruction sets is present.

Similarly with 'native', rather than supporting all the different CPU types,
it would be a lot easier to just determine if it's an SSE4 machine, an AVX2
machine or AVX512, and run with that.

My thinking is that getting this as a first step should get us a lot of the
benefits without such a massive maintenance headache.

> +    message('machine_args: @0@'.format(machine_args))
> +else
> +    # enable restricted transactional memory intrinsics
> +    # https://gcc.gnu.org/onlinedocs/gcc/x86-transactional-memory-intrinsics.html
> +    machine_args += '-mrtm'
> +
> +    base_flags = ['SSE', 'SSE2', 'SSE3','SSSE3', 'SSE4_1', 'SSE4_2']
> +    foreach f:base_flags
> +        compile_time_cpuflags += ['RTE_CPUFLAG_' + f]
> +    endforeach
> +
> +    optional_flags = [
> +            'AES',
> +            'AVX',
> +            'AVX2',
> +            'AVX512BW',
> +            'AVX512CD',
> +            'AVX512DQ',
> +            'AVX512F',
> +            'AVX512VL',
> +            'PCLMUL',
> +            'RDRND',
> +            'RDSEED',
> +            'VPCLMULQDQ',
> +    ]
> +    foreach f:optional_flags
> +        if cc.get_define('__@0@__'.format(f), args: machine_args) == '1'
> +            if f == 'PCLMUL' # special case flags with different defines
> +                f = 'PCLMULQDQ'
> +            elif f == 'RDRND'
> +                f = 'RDRAND'
> +            endif
> +            compile_time_cpuflags += ['RTE_CPUFLAG_' + f]
> +        endif
> +    endforeach
> +endif
> +
> +message('compile_time_cpuflags: @0@'.format(compile_time_cpuflags))
>  
>  dpdk_conf.set('RTE_ARCH_X86', 1)
>  if dpdk_conf.get('RTE_ARCH_64')
> -- 
> 2.48.1.vfs.0.0
> 
