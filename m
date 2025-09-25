Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3175CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 07:53:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAED7402AB;
	Thu, 25 Sep 2025 09:53:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5FA344028F
 for <dev@dpdk.org>; Thu, 25 Sep 2025 09:53:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758786789; x=1790322789;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2QsEDdyyOKccxVBY1QmaxJB076dvilVY44sEvanEoZI=;
 b=aICiCbIWc0bnpa8afe7aCYiyAlGBJkhzd/wqTLAIBavZ/7yaZYgJJKHg
 zCN1g/au9qohEE6tSqVomW2jGmDTinBOh202u87mH3skuEGXYDgkv3E37
 Ur0tXWDJTW9yQKOG31bVQwCVjD4WPE3h8sqRRv0lYH2Pogje/LiIoz9kf
 4eMKhMgZO3Wfseu8O9PeEBR7JhjParDlxZcx9ZBhq45tic9ysueFJPiZ+
 18WZtS0V0g5TtauU/kNNEX9nSuCwV+/jPont1BBM1CPDmGmZ9/waxTr47
 8ia4Ni1lSFkKEI8MvL3HkACtyQIEpzZDcHQzdqxNEWLVrequrlGCl4hKo g==;
X-CSE-ConnectionGUID: 04Mj6LK/RAOCI809fgea9Q==
X-CSE-MsgGUID: IqCu4IU8TXau+v7Rv8Ozzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64905145"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64905145"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 00:53:08 -0700
X-CSE-ConnectionGUID: 4i5UJH/JTZeObf7mQNvY8w==
X-CSE-MsgGUID: yDU5yxnuQBqIimXKXw2fyA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 00:53:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 00:53:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 00:53:07 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 00:53:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1BRsV//6KSexpMmwTc4EvFzWy4g7/1yql1UO2e7ppu1zI0eQc9/Sv7I7L3Mtbdju988YyjeMRlFx/Dnxzrh0VQiXzi+Dsk7yKCnbcx8si+JoeA9ofC3BBQUfQbQ9IsGGC914rh0fS5m0NqLCutuTwQDryjdO5sYvImB4WE8+CwKvHXvQV79kpOeopfG41dXVyJsfeM4QiaErOv6SYS3wXoEGay+hJBhv9L4YCU2GgbPyJ/9vhqgCUoJtLpV5vx1J7GXCroQ+9Q9ksUl+qJ8tBEsTWkYaSTxhNYC/UQVnTd/Z8KUQARb6tSg1Trk7/gVpvwCngZILLRyo/O2rGlAyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjxjcGQ2lv1Fcu72D84jBa0wgDas2LfDQxGTAgvMHLY=;
 b=O5Ky0SX9W/w3c4nANtnrFnL53LEkJI3nZbXF1r9D8ZcOArZHjvBp72WF7r3DEycAMKPFp0i5L99jGPTNoHWm2a0TpGIaNL8lkfw2BaPnGsMzmSCu3rTkevNQZyRu1gPfDpKUayedCa6gkM26qlmHWO/xDvZb7SXAiXpDAW7sGLhkwcvlqyhwE0wWdOAU3YWOeKUQ9aAyCWus/uwhdutkufUGfPvaxD3tY6iwoY2GfdEL83F8+04X9XmJ2SSe/GVhMBDU0huvjQ03e25Oaoah53Rxh0HT5MRwPH8VAjOdCrbqtSBzv1Rob9Vbog4f4zXlvFHPeZ1ESQjEdFHcwaeYVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6186.namprd11.prod.outlook.com (2603:10b6:930:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Thu, 25 Sep
 2025 07:53:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 07:53:04 +0000
Date: Thu, 25 Sep 2025 08:53:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Elena Agostini <eagostini@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>
Subject: Re: [PATCH v3 4/7] gpudev: fix driver header for Windows
Message-ID: <aNT03PNYURvMU4zS@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250924172536.2447183-1-david.marchand@redhat.com>
 <20250924172536.2447183-5-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924172536.2447183-5-david.marchand@redhat.com>
X-ClientProxiedBy: DU2P250CA0016.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: db19746a-8179-4f82-c7f5-08ddfc088ecb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rGEXRHHk/dvQ0PHmnkwC+xP6ca6PfeCllr4eoLEhlrZpUllT1s1LHDNkDPBC?=
 =?us-ascii?Q?tToIPY/wvy/+mtvdAJL3wHGl0Ew+V1fbXQ16zwweDx4VzSU8qyN3rJUFRZSu?=
 =?us-ascii?Q?iFlYaMC2bENPaYT+h2/k8ZG4452RlnmrcZZQXmrW7eAj5aqMjj1BmvD3ymx1?=
 =?us-ascii?Q?2mymVft4UTfbGNXeOm/uhCeVYrXn1oWo8ANHeuEZdt1hpDrqt9xBiLJSfkE2?=
 =?us-ascii?Q?V5gYbtxMstyeUYu6JBHGaJhORKFLR5nMv6IK5+EqsvhuTFR9camd41w9HL59?=
 =?us-ascii?Q?7nan00Mb+W+hwO4blWjT1jcJ8lj+MIeBdB3m88TMPpaEwlMVWs8qLw04Z0jM?=
 =?us-ascii?Q?rlD3Ea4QajZ8fy0gyXa67uUb8WWt/8qiq3YhH8LSDNrU+UrF//0wk0grhuFp?=
 =?us-ascii?Q?i1tjltF49FJ5QahrHn5dvvZJU8vKkajstwCjQX6OZtuXrWRCpECjWS+aJ2Xw?=
 =?us-ascii?Q?/2r5tIqF0cHddsSqYfoWpsJ3UX0XpJuegx2HhFlcoTat9rvpsMcwmU/m2MGx?=
 =?us-ascii?Q?Xz0xzhwBrEn0ncKhu5oesB3bpmg0e/j7tJ28EOHhI6KHxHHCHKjGTkREbYcn?=
 =?us-ascii?Q?1O6tMIF16Q8XiK+PZs8NhqzsZTObyIycrmSMp/TI3XzhWTAutmle6XzS1Jux?=
 =?us-ascii?Q?ggDqKrA1MrBeFKRTCzpw5H9/FYsqMPON11xFFS5fOKPHUy4n0I8SSsixT6rv?=
 =?us-ascii?Q?XM0cLeKoEm7bY8OhuzqgTAhz2815QXr74I6fYHbWnuQ3QZbiWuLf8NgWe4rm?=
 =?us-ascii?Q?JYxOVkGU5E9x9Kui17VwqDnnhpYuKq6SIhyake4M2zxrn0kUtk3BwxDmhNi3?=
 =?us-ascii?Q?61yPzgjYhjw6NOj6/dtnioX9NfomEBfV1X3r2+2dBZHNT/AUZzBMPXhl9xA6?=
 =?us-ascii?Q?U5JhMY3KDlsTjho+yrR1R2fxy21s94nN8zya7ONg0jO+KNBc/+PGP2PripjO?=
 =?us-ascii?Q?7DG/lZQinvkANawjwen47St2bqjRktcBbedhL2+RzPH9NDYELbrQnzTGV6np?=
 =?us-ascii?Q?mBOlPySQbDbGkO3D5CalTnKDFLJPaG44UTqHkun8CFKNohV1pkb3YiRIFhOM?=
 =?us-ascii?Q?efpxD36qZJSXXjRnJkCH6BphU4d8xo2iWPz0BUSbLO+eEERObT3OtzsETNe7?=
 =?us-ascii?Q?h7cwdVJmUg5RKysiuLywQ68+joMr7J59vTYP7QuBxNr7nmQ/m0JH6FkcXCZM?=
 =?us-ascii?Q?+u6TQ7Jt4Rfe0zuUnd25dbV4GCDkMSpT9tqV1T1+Z+Yxqc6bDvx4ijMdHTo6?=
 =?us-ascii?Q?nBJOdBceJHkn06kNJtxwCaE9uciApPvnKWqpVHiSU0vZTeyTOEuqUsxv7GHo?=
 =?us-ascii?Q?sgYRgj50ZzQ4m/wGXvZ+6lWi7vS8z8teXWoDKGasH1yqpOphWBy2cZSOTC5L?=
 =?us-ascii?Q?LfOi8CQW3VFiRwhp8du5bCibV8jF/F4SoBX7biJhp4dS7ew6fViwlGCm6lZ2?=
 =?us-ascii?Q?M98Sp0hnmiY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VIN//Klk+IFd69AFuUcAGOVkEK0QmlKtL3XpPqIzvDtMm0XK3fXMzdDIwGvD?=
 =?us-ascii?Q?DLdRk8o+/8xMPqRNuqowquB1EKpYH/lwIGFT2eYGwrzRPjgfOLNw/EucbiM2?=
 =?us-ascii?Q?gIZPIuY+O7KCBt+Vlgv8xEmxJAd1bXgGySfSxi8OF+7imMUajdhlFO0L+TRw?=
 =?us-ascii?Q?18mPvN8pb3UyevUnU799vq1zNYB20bumEjJuTIJL0Znw0tGCu/47TrmqaTU4?=
 =?us-ascii?Q?i2O4aeqCjuqRS4QLmfSgQ7YLi0jhlotzIcg+vYQi5ruE/Il+5E/ei8l2Iy37?=
 =?us-ascii?Q?YCxSTHyE7egaS7HCo5gomyjbHiRnrwCUyIY2CkMsktJbjW+JfELLaamyiWX4?=
 =?us-ascii?Q?+Lm0AIlr5qrSgmsW7V5AUXHSiqJ/AQ9brHQdA9hMMBV/xvWbWtoyQjy04lRw?=
 =?us-ascii?Q?Iio8ZQVTKr/4nxqAOGtn1V3PPjdsy72QPDT51E1DddB6UDbfRj9m8nv5wac4?=
 =?us-ascii?Q?e0ot16Ric9QRmJH42CgRoEDHJIuKW9gjK7IhQebj8GR+StzAaF4AE15c4duZ?=
 =?us-ascii?Q?/I58vPb1cbvRv63k6DFisJGdz+FLcAtxlhksJGtZzxR+7Tr8gGhLy2zYMHcW?=
 =?us-ascii?Q?XK9b7b7QKGjtLRe9KNRKR1e0o7C/tRB2F4inIVSG9xDHniD09i8W4PjNG7M6?=
 =?us-ascii?Q?o/tE19oAnpwPJx79tt0Re8Hw9LJhgLCcwmBPJuWAbLUVp/hf8MhI3U3o1vo8?=
 =?us-ascii?Q?E364cI8exzCMeDGU4OLPYR5YPihbzopPimsBhUIGVY25kFc6toHaZ5yuw/mc?=
 =?us-ascii?Q?3+hWFde8XFjO7qUA6/p4SdzOwAxwUr1K4lOLKSkr9FZ9vivGoJ9+HZNOkbE8?=
 =?us-ascii?Q?1BMuRIVoGS7E7tLsXTn3TXpA8OWw1HTSDrXB7zxW85t5p5xX9MIMt6IfFpGg?=
 =?us-ascii?Q?kisfm2gOL/j6uSUxaVJJqedDvdeuaMT7xCDnLvza+MiVetk3IHPPg9YJiZjN?=
 =?us-ascii?Q?ra26dA1DXQgLvjxEASGPvzWAJ70umOgb1GqZn45H1HTqO3EUiH52v69M0PvW?=
 =?us-ascii?Q?/e7qwT9aBcCAczTuPQa7kKKSrTyfru5qx7VSatbQgCA4g/jDow56oq3eFY8X?=
 =?us-ascii?Q?YSWmcDjFnxgTlQyywXM7wV4JMgzk2oblmY9AyOYXLKrBzVQLHGztHYjgdg3M?=
 =?us-ascii?Q?V1UC835l5MO8zFZjIXzgh3PNJ3aCFO9FND4yuA2T5cSsu+wwGf26Z0Yo66Me?=
 =?us-ascii?Q?NaP5DfWKCDWdRYOgOel9ry8tZDXdYYTRfL0w2RzoJJIqPA8PpnKteSa/ncIj?=
 =?us-ascii?Q?X2wths4xO4byUniQv0qrbaVD3zhuwPJh9weKZq7lcmEg4m+HatCVXHnoeY40?=
 =?us-ascii?Q?XbDGUjR2BwXvjpQ64+Tr3Pj/FS6Ta3GN9TN0kAxCQBww9z4BdqVm9HlNITF6?=
 =?us-ascii?Q?ZowEy1odqrxOBvpJ0VoS493Ilg5sgtIK9UBFFO64GU3Bs6b14TM9ooqcYU6Q?=
 =?us-ascii?Q?2+Tj7Y2kVtZOkoyE+K5Tn/RIj4PYnF+7GX2hdz3OILVArK4Knvzyxyis4cUT?=
 =?us-ascii?Q?dOGKUbxKyZFhFiL6I96TkUcU3AWvO1tH+eJFXxpCHO0K6u75dRWuSX6z3V5B?=
 =?us-ascii?Q?Y00KmNGsyARSIfR/WIuwYbWa27T5S1mq684btEV/g4Ahcsi42ZA3mb1FT8OU?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db19746a-8179-4f82-c7f5-08ddfc088ecb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 07:53:04.5150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pflJ3GfdCarWkMlJHkL2xDhI+xJxStLtCgZD6VKv5ZQGsbkWkOO9m1GP7dJn4k0cK4SCfj9rObWNFh88pRC9xFJk0AGHboGX+TcK99Ouls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6186
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

On Wed, Sep 24, 2025 at 07:25:32PM +0200, David Marchand wrote:
> Use rte_os.h and its RTE_TAILQ_HEAD definition compatible with BSD
> sys/queue.h
> 
> Fixes: 18cb07563165 ("gpudev: add event notification")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/gpudev/gpudev.c        | 1 +
>  lib/gpudev/gpudev_driver.h | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/gpudev/gpudev.c b/lib/gpudev/gpudev.c
> index 0473d9ffb3..4a2335834c 100644
> --- a/lib/gpudev/gpudev.c
> +++ b/lib/gpudev/gpudev.c
> @@ -3,6 +3,7 @@
>   */
>  
>  #include <stdlib.h>
> +#include <sys/queue.h>
>  
>  #include <eal_export.h>
>  #include <rte_eal.h>

A bit confused. Why do we add sys/queue.h here but replace it below with
rte_os.h?

> diff --git a/lib/gpudev/gpudev_driver.h b/lib/gpudev/gpudev_driver.h
> index 37b6ae3149..b7621f6e5a 100644
> --- a/lib/gpudev/gpudev_driver.h
> +++ b/lib/gpudev/gpudev_driver.h
> @@ -12,11 +12,11 @@
>  #define RTE_GPUDEV_DRIVER_H
>  
>  #include <stdint.h>
> -#include <sys/queue.h>
>  
>  #include <dev_driver.h>
>  
>  #include <rte_compat.h>
> +#include <rte_os.h>
>  #include "rte_gpudev.h"
>  
>  #ifdef __cplusplus
> @@ -80,7 +80,7 @@ struct __rte_cache_aligned rte_gpu {
>  	/* Driver functions. */
>  	struct rte_gpu_ops ops;
>  	/* Event callback list. */
> -	TAILQ_HEAD(rte_gpu_callback_list, rte_gpu_callback) callbacks;
> +	RTE_TAILQ_HEAD(rte_gpu_callback_list, rte_gpu_callback) callbacks;
>  	/* Current state (used or not) in the running process. */
>  	enum rte_gpu_state process_state; /* Updated by this library. */
>  	/* Driver-specific private data for the running process. */
> -- 
> 2.51.0
> 
