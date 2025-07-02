Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D784C77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 15:53:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 875E940E3F;
	Wed,  2 Jul 2025 17:53:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id AAB3C4028E
 for <dev@dpdk.org>; Wed,  2 Jul 2025 17:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751471599; x=1783007599;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Fdi3ZEAPMF5L/5YkIGw1b5C6e8OX45LT4zuul0DUVlU=;
 b=B0drwi+YwfKFHd19kX6xW52czj5aRJoxjehXbALQqNF/bJdNjJ9wziEP
 ECoMmyiNmxwjP3YKgv/4J44ene1oSMaztG2BAbZoZRP2p4abstfZVwz76
 2peI4Ej0JpMHh2styQqoN0cASrCYKczYx8T2wi8SmRIuIeF0SC//HuwBw
 tKJ5HnDs7yOelNIB/ny2VVtyqfMyiOUv68Q7hcJi0Nwm7gkqiq4h3qsey
 IVBbHa9LXLfPF+9ULw67RgXUGzgJGCo8cJmUKt0/rrOTQi4ujJNnYPMtJ
 YX6nofXBJEiYt+MVkziknq+yuOc8zFPnv/JKXdtjdk8CZ+QqoWQI3Su8D w==;
X-CSE-ConnectionGUID: wgyTF1fkQUejFiN+Kp4zWQ==
X-CSE-MsgGUID: zmSQhLkASAaqeake2jxVEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="76324388"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="76324388"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 08:53:17 -0700
X-CSE-ConnectionGUID: 5t/VO3HUQS61yyEbZqc7Mg==
X-CSE-MsgGUID: yPO7GU9GRAmNF8R3cZJnpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="158495122"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 08:53:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 08:53:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 08:53:17 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.89)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 08:53:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzRGmiZENPDyN5OrJ+GO1MmwaWG2o6MrFfjh8wW8OHyeNBN0fpj/lsjd9KwxUHtXX1WR1JpEUxoGkSV/reWBC6pj+58Fv7DIfvipEgPjebov9mDAo6cGo903Pzy/YlMAkjpTcWSwKgp4iINoGMalP5LidiL4E/OPA/QhpVp8cOD9mx86AknvCpaHUtCOz9gSbQ7yjkF4o5KmyjsFwDS45uvxtLaEC8hCHle2KIMU9cZfuM83Pet5DPxE/sKSAcfDloQq3ENOmhbZn/Yb9OrVuYfcJMZgnraZjoWa8mFK/m8npZhu/Pak82FHPWtyXFEjergvfUuE/QeRrvvTuFTJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5P6J4Wjm6mAQs2kEORKnuTI4GqiZBwRFkQB091haYAA=;
 b=M/PSQC3hZhUVG0Bb+TbGQTyYNOB7j0ZktfmrmhqTX+0cMVu9b8hAyJVrIVY0+b1Z/YgQWXsb76qtLsL8d27O10FkjzBuvIKHyInwyo+U48bNKptaBt3zCfbWAgcao60j2jA1X06DPjOXns7COLk1r2mAy8JfkP5Ofm9XhHiVaYUfjT6bpDmgesIyKhTKEsIvbIeo3GAISodDjBKWqbVWGjbYF7L34NRxe8TIRuN3XAokoVMLOo5apA9gcEo6Tkh5Zm9DHacFIgduQYUxoy0jNk54bucoBR9gRBIE4TqKX0bMqOtVEm9bqjJ3Rd307/klwXZHYWa8mbgdhICVYUXiFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7819.namprd11.prod.outlook.com (2603:10b6:610:125::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Wed, 2 Jul
 2025 15:53:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 15:53:13 +0000
Date: Wed, 2 Jul 2025 16:53:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, Vipin Varghese
 <vipin.varghese@amd.com>
Subject: Re: [PATCH] build/x86: fix support for older compilers
Message-ID: <aGVV494FJVx_uKk-@bricha3-mobl1.ger.corp.intel.com>
References: <20250702155129.3440210-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250702155129.3440210-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2P251CA0011.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 9963f34d-b17e-47a6-fc2a-08ddb9808d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oj5haTB3+fdRcgdHYXbYhTeeMUuuWUYAYfd3hcq13Ce2hSf8tPMRPRcFo4HW?=
 =?us-ascii?Q?X3jB2uCiQsEq8Rxe1zx0VUqi9SV6JAsX3TRhWrfAi6np3+BnC3/oK37bXM7j?=
 =?us-ascii?Q?SKso1V9McTok1CCGqyk35QHUtHN+Z8BzMsaJTU2uAdddwB0/YcxR2z1D2bfs?=
 =?us-ascii?Q?48OJ0WzN1erpfub4qyYNFI01NLRU2o+RsdpnjdQENAJsL6mw3gntjJR7SdmD?=
 =?us-ascii?Q?eCsIc9crkIAnnq17afhU3Ao35NxD3T5wqbElV7EdHyXQo5DsmLtZvdlE5XN+?=
 =?us-ascii?Q?QjbfL+Yo5OEzncCsbSYuJvVAcrFfXxl1UZDQhCERYO4btkj/Da/njHweRsSM?=
 =?us-ascii?Q?tvUz6jFUEE+wWG155XhPjoWrzZC7fiZ3CTugcb6VQry3E6W5+jGeWBpHnnUr?=
 =?us-ascii?Q?CZCJhcs8Teugo9fq9sreVmngIFk9d+f4acVhYxJ4xg90eDSjwmvNsKQu0pS4?=
 =?us-ascii?Q?1+uzY2eYKSUXk9rMrrb0unev2cecY8ZjdmkdHqfXrxBFzCoiSM6JUQRi8Da+?=
 =?us-ascii?Q?pRblcSWWylvlgriz2R0ztbk/wqN0sP5snp4WAQhHuZ41QRpjbMWAe4Wus+Ez?=
 =?us-ascii?Q?Fh1xfL0EdwXFvXeABpKbDUGmBjqBmDmz4/LU3hT7WyZeYCxLAub+b5MReCjp?=
 =?us-ascii?Q?QFNPBOieM8paJXLvr0YXmMPo/cYJ4IgCLIk4YY5gBHbX8glrCUcj0Fu4L0cf?=
 =?us-ascii?Q?/FqoWy2PziNMUtulHI8fQ81MSPjkchMjqy5M1uTOVDAUT21DSpROY1bH5JwP?=
 =?us-ascii?Q?kYsURt8JJ5NfNxfJ+GOYS3GpKMFrxVnba77/ayXC1rhzWlQptGkW01nuaENb?=
 =?us-ascii?Q?5axNGducyAxtnmsMe1VbM0N7uYhkUTq+1vY2V4TtXHqSLajSb72GDMDntdhg?=
 =?us-ascii?Q?OWClHLcOLtrBYs4gsiaWj6TgdN0vF4ajH+p3ozZj8G/PvKZ2bYVr1QTl9Oc/?=
 =?us-ascii?Q?7/ZaG26wxmHCYx6n/9kyYLkRhDuiuV4UcJFVBdt8gmTd7CFhaR589g2Byn8C?=
 =?us-ascii?Q?QQLxsNdeaJDuIOLKpcj7YLeMn0iMQ9nk521A3E3k0QWDiJLVoYGoIgztr7RC?=
 =?us-ascii?Q?+CI8I7hBczpBWsyXJCUlkqtA8QwWwBE585ksez8sPyUMksm3e3LCF32Ldxzm?=
 =?us-ascii?Q?+HvTMxb6UBx2lab/n+jUFnqHVRufHd87uGoCVEVDmkQn9R4XP1/n8YNRPpbY?=
 =?us-ascii?Q?+yfRofYIibMTpi/SXGavTPDs7E8TzKhsciei7xeIewpzUmKB5jX0ezBd+9Tg?=
 =?us-ascii?Q?AaSjYTea5Z9MNvaqWqOpJPnaptYHv63YRWF0CF8Q4UkmCXza3FTZxiMzwSB1?=
 =?us-ascii?Q?Lm15+xaZKoqRqaC3TS2/pKgD7Y3LIwJzGQu8SYHmof5hSI7Rs3VyeTg+jeg8?=
 =?us-ascii?Q?05vr5nIJyNdMDnc2qTtEIztqp+J2TdloEmnCDrQA5NFY+FHLlnY+krNmQ95H?=
 =?us-ascii?Q?wZqYFGEQItY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z036uuDHs6DczCvfXkCbFw28swxBSfbjdi9hC+sqinbC2qzH5lS6r78L4Gp/?=
 =?us-ascii?Q?eM7AuoX2bAm55PMBkCbvqrXB4PuCpPIbsTXuaOvYgIjtDp1pgHgS+7cLJ9xw?=
 =?us-ascii?Q?4jVxkEDGCWY6Jd29+hxJgNHdjPRRAfs2FqZ7YgwAf62AxaMVWy4h9XiI64L2?=
 =?us-ascii?Q?10FnDtOwnudWzIumVxRk5KUgZuZddFEbJuun0doXCgyKBXRIuBeDvNXrUfI7?=
 =?us-ascii?Q?/U+LSY9GfAqJtdK+2ESosqJBheJTyss1kZl/kkgTwbKNjV5mtrfQbi1qyFfO?=
 =?us-ascii?Q?Tt7QOAzTdoPnad0aeb1Y5nkZVIKMoFkZegPjN2xtfW8sWxhWORCTrcqLpPEP?=
 =?us-ascii?Q?KN+7ppuZriJeh6uU1xL+SPf90molGpFiBBQXSqFj9aOh0pic0MjLzbfRi34g?=
 =?us-ascii?Q?eXZwRoB2j3NdoyyhZKFJJZVUAkkjGJndFwk3eSowxjBSeRRuREei02oD0L+l?=
 =?us-ascii?Q?7wadY7PjfsHI68gljtDPZs0zQa8Eg7W0ppcxQaY2cuZJM1+C/4mtEupciILP?=
 =?us-ascii?Q?+QJCLiBZQfty+b8/8bCuXklaSwao8vrAHNJ7LDF9o7/MgJtJ4WDysGqCW9om?=
 =?us-ascii?Q?7AnIL5RwHr2+1L97LWiUud9S+VAyi/LYhqCOtCKHwQJU0GLl7qERA4Fm8AJ6?=
 =?us-ascii?Q?J0cyiDiPPS8i4DnYw4BkTojGBLcg7aqHY1AewcmSYRLJRlaeIO5Hxv7X/4Ox?=
 =?us-ascii?Q?AHGAIWF25rfjPoAlevGiMReofsw5iSeiAv6wq4F+gnfDB/u4mGwzk4fPG02L?=
 =?us-ascii?Q?l4AskWIOc0XL5/l23VZZq6fnrMBDymEwXAHsKsyr1LE4CX1Oi7DeyqaNPsVV?=
 =?us-ascii?Q?ooJBbFWblohTiIpMUd4A5J6KbuSATR2kt2y/8yRyJ4pM9hZQXfucwXSz6Ahy?=
 =?us-ascii?Q?3OG/ff7Z1+483cvUafhkQ9I52554j/K/zhSP9czC5PxoZIwxSSjOBAaCTfx+?=
 =?us-ascii?Q?1QrcfEZnjCCZsvAQBKRUSXR5Q4zHNgpUuRCFKKhbukVgD+rLA99Oaj+9fS9M?=
 =?us-ascii?Q?VGQFsbgKAUdX4GC94DNL/rsX8vEkVnCdsZYLyo+lVotJb6BbdRELVInNLDEf?=
 =?us-ascii?Q?9BhQMLRg8xO+PV8Nj3p+yQs/wRgjmLbc4RjHGqVq0BfYB8c9mE+DVq1r8m56?=
 =?us-ascii?Q?4VN6Ozi7UmsJ5Mo4FzWCZEgNaDTnDT72mErqYkoAGmdCaBKQY4Dw0qUy8AHI?=
 =?us-ascii?Q?TeY5Y09yHZ9EQjfrwJYEfsoVnZxYiiW3IysYpvTdrN/E7IyP9RIsDTHwiriC?=
 =?us-ascii?Q?QDvjywfWd7DwHhW4T+IPdy/afZ5iCEPHjKEn8DHY0uBTQJDRYzxV4A/nm5YI?=
 =?us-ascii?Q?zS1Wds2lHfoUEnCF4ljOO5ep6FdXa5K1juDVBcFIuuLW2yaDOj5ahT5bVUb8?=
 =?us-ascii?Q?vsncxXZxRzikXwBic8mRjspIVHvXKDXgBq5eLQF34JxsiDqrJ0ZArKZFXoD9?=
 =?us-ascii?Q?P27z+2yDJTCNiJbHzEnvkccNYb9UpRbUhnrdKHnRSO7w9qIpFAWtxxNBjM5Z?=
 =?us-ascii?Q?Ecm9c8JGfH8foFJmSpWcio8j2RIE77mWgK/iUPUGPzAJUhr1XQpNp26kwknr?=
 =?us-ascii?Q?ReT1+s8F/pomw+N7/B05HJSCvmGxOP2MEVeYrWg+0kDsQUNafWuYEDJ59F36?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9963f34d-b17e-47a6-fc2a-08ddb9808d02
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 15:53:13.1166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ifc2VQRfZ2gWJmrUHVl5q9IMr5hF+papq4ZWe6gn0fTeqTJ2J9Ne2nFtdmmXBtCXR0ZsrMT4gLa74Ly6Akhm5KBp8jSYALQkPFskkRgp1ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7819
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

On Wed, Jul 02, 2025 at 04:51:29PM +0100, Bruce Richardson wrote:
> Some older compilers e.g. gcc 8.5, do not support overriding
> -march=native with another architecture, leading to build warnings such
> as reported in Bugzilla (link below). Add a check for that case, and
> explicitly add the avx512 flags if necessary.
> 
> Note: it appears that it is only the "native" flag that isn't
> overridden, which makes the issue hard to reproduce e.g. using
> godbolt.org, or on a modern machine. For example, testing with gcc 8.5
> on a haswell machine, using 'native' vs explicit 'haswell':
> 
> gcc -march=native -march=skylake-avx512 -dM -E - < /dev/null | grep AVX
> 
> gcc -march=haswell -march=skylake-avx512 -dM -E - < /dev/null | grep AVX
> ...
> 

... and of course the output lines get stripped since they start with '#'
for '#define' :-(

> Bugzilla ID: 1736
> Fixes: e361ae3f59d3 ("build: reduce use of AVX compiler flags")
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  config/x86/meson.build | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/config/x86/meson.build b/config/x86/meson.build
> index e2ccfb6d12..0dcc5ddee4 100644
> --- a/config/x86/meson.build
> +++ b/config/x86/meson.build
> @@ -71,8 +71,13 @@ avx512_march_flag = '-march=x86-64-v4'
>  if not cc.has_argument(avx512_march_flag)
>      avx512_march_flag = '-march=skylake-avx512'
>  endif
> +# workaround for older compilers, e.g. gcc 8.5 on RHEL 8.
> +# if march flag overriding doesn't work, explicitly add flags for AVX512.
> +if cc.get_define('__AVX512F__', args: [machine_args, avx512_march_flag]) == ''
> +    avx512_march_flag = ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl']
> +endif
>  cc_avx512_flags = []
> -if (binutils_ok and cc.has_argument(avx512_march_flag)
> +if (binutils_ok and cc.has_multi_arguments(avx512_march_flag)
>          and '-mno-avx512f' not in get_option('c_args'))
>      # check if compiler is working with _mm512_extracti64x4_epi64
>      # Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82887
> -- 
> 2.48.1
> 
