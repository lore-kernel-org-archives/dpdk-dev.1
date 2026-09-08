Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1F2C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 07:51:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 647E240E0B;
	Tue,  8 Sep 2026 09:51:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3371E40E16;
 Tue,  8 Sep 2026 09:51:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788853888; x=1820389888;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zobV0EaDTq1v9ERF9vBcniFhEcQEGdxlhkouZjw87hQ=;
 b=fv1vpEgGB1RLi4OtDEzH3edBKb9ISpu4II/LcINZKHGDvPG9MwwPWqRT
 Y1Hj48RptdaAG2cOSVGWwuDfsAI6hfmtPomWggFs02AWI/ae5rTXYa663
 TCUQKZKbZ0xApn0ys3+zl4rjCGrUefYcU/qgK5jzgbhCXxytpvHa8OwKp
 PNEpfYCCjHRMloXmjuOKIUBynMDW7FUOpU5m4Bnrn+XJ1vdnKx3hE0vVk
 WQZWF90dryEyDzFNQk92UuQEXpEdYVCUZlaZiHTHNllL1LqcA4vno5fLU
 Xr2HXY3JgUC1GkOcQjlrmp+ojEeq/FDm+q0yjhoipBQ6ypkG5BlJduGx4 A==;
X-CSE-ConnectionGUID: Lv+iUn3TQdKc4Iy3l2q9YQ==
X-CSE-MsgGUID: 4nS+XvViQ8WDYoehnD6Srw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="100769839"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="100769839"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 00:51:27 -0700
X-CSE-ConnectionGUID: aDOqeq7qTXOBPFXalS2TIA==
X-CSE-MsgGUID: Ou4gTvXsTYeLFW128r/FCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="274442375"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 00:51:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 00:51:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 00:51:26 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 00:51:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8RsP2R5nLaIaOQsEhWpxdS3c6SKJRR/CGkkIOhnIQPM8ThDnj0ZnPiy3ogoZjtleiI88lhYOPfPlU9SFYHBbdBO8aa/1rgv4/VfHrgxm/q3smy4VSzFh4EP+F7YTKbR15yck6zI1ez3eit1mnebF2PpCklCYy1rxhs1jrPVNUTCeAJ9/c1bxxVPUzhYf/FoavlSFES5617tkxSNiF1AQ2Q5Jwgd2bpoZT/VlgSINiOJ1bGcykhTzBnBKJN84KP3KOXv3nmC0olUmIdtqNT1LNTvP0ThDxejzt0PvWmIuOH4D7wAm/opYdp8Go3TVM2/IZZD6Atbzwtkk7i0XKy4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRzh+7aHKA6mTrbXnEbzSHqSgHxpWbuj71RtUw4+41k=;
 b=AGwXquUwZ/9Lx9AwnWr6CZY4zgs8fwyvs3FFT6JS/bA9a5nlv3y6+FZT2jiW0WKtpHqjAP1W5wUPHE6EfPceQYtA4PAvHQ+Y0p620ILsP+lEntZXcBO+kYrIVwsTe3tnV2xCsYXApMNkHY8yWTGP8qSplhIxFjkbKOWHpFzyBc6ogdWBVMJ2IzHHdLrMzuXXS8gXjY1lBnEABGFq1iGLBgdp1nmWO4QeMPqo2dbWk0bOQGLRfu0D2OM+7WbHT9pi2aZ+8cg6tMRfBbCnlTIj2eRM+loHxKSmpl1a+OPAyNau8lVyKToMv7aIMNgemN/UfsiTU7Mitkk+l1afUbHSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH8PR11MB9484.namprd11.prod.outlook.com (2603:10b6:610:2c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 07:51:22 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 07:51:22 +0000
Date: Tue, 8 Sep 2026 08:51:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <hkalra@marvell.com>, <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [RFC v4 2/5] eal/freebsd: fix a FD leak in the alarm subsystem
Message-ID: <ap--dDQmAsdpDujC@bricha3-mobl1.ger.corp.intel.com>
References: <20260908073835.3422310-1-david.marchand@redhat.com>
 <20260908073835.3422310-3-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908073835.3422310-3-david.marchand@redhat.com>
X-ClientProxiedBy: DU7P194CA0022.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::26) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH8PR11MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: 404e418f-f69b-46b6-b1d1-08df0d7df95d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 90ECjWhn5nMUqsiXpVoq1mQEP7u995HtntYFc684E+tWQfYu1keuBP+WIK1Qk2vyn0+7QK23LNWW6FMv9gH8rAKaSkUEOt4k4zsyTYih4rXfUpyX62BnUa6/4WdZaOU2PHBJ+ZAd6GZB/fXtddvcLSu+qx2lIJapijYc8CLLsYkEW3lTOh5qUXHv4Z1kEMifExSj1lM88kEIH7tinaOIdAHUkoH1aXyAZm8SZPYjSoIVohT78BDxnk1HDZJ+QEu7YeYeeZX+Z/m0wpL4+P9Afxbwh7Jw5tleUmpdYIsBmD5DRppGVEREvI33FiOc4QUsg5uHvT732x3N0uFCG2QjgPxiXMY2IxBQ7qtq0ixQDwSw5gd4ENj4VyFoTc8MqRaxrpwAah+aHhBYIpJrGMJLkBVfyG9tY3ILpp2/G2AWrUqDOoHNPC/Y74fyAxFZZWEKzdOQ+TdHdhv8hDHXqDS1UMcfpSUXAVWcGtRIl2iHNVfoRaVOdifxW9pteKNmMhrmDYIfdhJ45bHTo5LkrpBW9BaMi41cHs6tZhkeVGY9BfrxNWh8Sbr/MGyDAiWil7UFQNi+aoPFV3jfX8DiJBgmtc+81PCNE2HUizmXhQn3F1gB82zAS0GdcaNX9bl0pP1ezpIcpLaY68KfQgBBAmiRkLnbI79m5F3F30+K1uEeras=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/a6FJy8HNDWD4zRjRlJz1DgwJQR5kcE+Fl8Xr7A94KYnJOABjRpKrQFPmES?=
 =?us-ascii?Q?wpVQatCIxHebYCEkQhAmw7aqpsNBm356i5jim0UaxvHPELW+Z7TTo4b1pA4w?=
 =?us-ascii?Q?vFDQuWJt4uwqtmOfdQQ12dIr85fWEBQUZf0ubWI5UApUWBvXb4QooTGzGnMX?=
 =?us-ascii?Q?kcKcwZHdzGCyghVtA3TJ86dgxWEfxNYnl2fGZ77ZHE5Lgjy6g4vPuEUTRWzo?=
 =?us-ascii?Q?jF9OtBHw60WMhBuafFcBu70FZQf/3lG+cXq1kagXNvKZU1XxC/l3hJSP7i6N?=
 =?us-ascii?Q?apbZEeEKLeqQRtKuDErRc/GJA1c5nQ/YbT4hct03nsnaS0QIFuKqyZwY3BGd?=
 =?us-ascii?Q?FpwwaVZf6DfwQb0bGbyDTbOpNpZMVTkmX+jjov+4w31Jn8dxMa3l3BHuMGV/?=
 =?us-ascii?Q?IoxjyzTivyUqFaT2LKFYjx0WtzEAs1NRDRY6WJ2/xBc7SebWtHNvC44BpISb?=
 =?us-ascii?Q?LaqqTGdaqW1TPnQa4Gc60vDgkoOlJQ8dG7dCWxVRfnKzct36JPMVaP94Babh?=
 =?us-ascii?Q?+EtYzq5lndal92hO+nMaY1LvGEsvIkJZ4rQP9HSIoZKEE1OoJmruYUYdtzqh?=
 =?us-ascii?Q?nG9ZEebvb8ObyKtorN/kxtsntIJmbeO2ZLDIe95nLhCjRlVzuBL2JL6tTYpG?=
 =?us-ascii?Q?ftuFFJDZAghcuUONErMJGbRF/cJcTV/Ab8Pq1xcIcc1jEp6szYWB6QM3HgDt?=
 =?us-ascii?Q?BVwwePI1JZaVthAvnsmBbf6oxbaQuJjniO+MF4jjvAtyilQGJjTf7Ku+PfKr?=
 =?us-ascii?Q?5G0mZhbg1KMfUEeigy3yFiLU+CwAXmokGi1JE1yngVF5kKUVcBZud9Sac4kR?=
 =?us-ascii?Q?RNwZvFJ+GbtxwLxPogy0sZIAlKYvd7LV+QOcCJmucO6NLKIsKjXJK6L2XNXr?=
 =?us-ascii?Q?W9uopkPHjuFcP1ZiTnXB83HsW7RoxhihFE4Ak+f5c0W44Pt7z5XDP+5KZM/t?=
 =?us-ascii?Q?8OZWWwhAdAwDmX3DuvrTk9HH/mt7fcq7VADstvT86pu7Op3JHSF6GDu8jBQZ?=
 =?us-ascii?Q?Pc1ebVwvbEYaBUeAMbmyVAOnNqhFB3PPkhrmo5ZWAPKDHQDx0TDIswZmoLNe?=
 =?us-ascii?Q?dKbyBY3TKlM6twRJgZSUEgcdIhP9bKr8YxFY7jMUOLqMZNL6dZeIy4fSLeOc?=
 =?us-ascii?Q?9GibUM86gJu8l5Dtlzy8mvB35njv9CPPbKG/PoOx5v5YqMcPSeV7wStSvGgk?=
 =?us-ascii?Q?R6Ix71He7cfol29MHypyLwqSsYtWjqVA+f0fBTM16TsXQE62IrrfgTXA/3QV?=
 =?us-ascii?Q?s/6ungX/PrQZ0MhfpGj08TltUyGQ6lzUa2ZuQWNuffvZIkNojj5LPF7m5Tmr?=
 =?us-ascii?Q?2J1sn/qicNDcQG/arkacmnzVWYjjW0MxN/xgCoulzp0Gea9ZaQ76njKBeX9Y?=
 =?us-ascii?Q?hst/V9JUsDf0cchp8NApEQ3wQd/ayPWTRoZRortFjObqctvAqIfHDx/oe9Z6?=
 =?us-ascii?Q?fPGQQNEA1J7WDw/wa6GfLvbNZFAXSBlctIJpxcJ+QFRcq1g0ZEjXIEjGcLum?=
 =?us-ascii?Q?HOMUscUR+9IGQC6o6pDpxC50ZTw4jn7ljd7D/QYrtsPo3+YW4/+cHbNPYn5I?=
 =?us-ascii?Q?XVcdu33RtnahjmSRDdQs3vCQ7La9WZs1WyJq2eile9qbZq00WCD4A60YF9V5?=
 =?us-ascii?Q?Y5cyVb3ZgzqZK0Yo9v1A3oRhWFuSs0iCE24OjyHzEYkhnArfvYIwuLWU3ccR?=
 =?us-ascii?Q?0dF3DIyZJ83SEDya7xr+OkFSwKpx7PM9lfmSsH57bBg0N4FM2+DfGVj2zy6C?=
 =?us-ascii?Q?58JI+wFGEaswDuaIN8JQ0vpYShiYkQ4=3D?=
X-Exchange-RoutingPolicyChecked: s9FHMZTdsKAZ592vs2DnnBLYAlVMltPyO9zLPFynNbb6XJQnO6lJzn7YloZy065IzxGL+VBsJbTMeR6Mw96GLUmlpnaInzdJoJO858PMvj/dxXpUV0DCyIX5qFtuZIlsuakJkaheEBgh6fsk041DJu1GTyBnDnzAa4Uya2dLGKdTZorAnMGcDfxDHRyKDEUTV2LvS5QzVYHIquEW2X6G5m1/bM5//0+4G8VIcdxdEtbwxIq3lCkm+SDRjK0tGnD1YEK+8xV371g9FlIFkHfxqLNxy9d4pL9OT7tVrm89q1tYKqoWpJYeRlJkj9z7Nm8/3n/Fm05xxj0KaHJ5QI6tPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 404e418f-f69b-46b6-b1d1-08df0d7df95d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:51:21.7850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5cLHiu4xL6MU9sj7U67t2dVrOJTyowIkbVyg5fWXgvVjS5wHcuSp2BL1nYGVL987GBYF63q9gIRWMFwWRICxAREF6znmUfqC+33r3EW/sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9484
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

On Tue, Sep 08, 2026 at 09:38:31AM +0200, David Marchand wrote:
> Caught by code review, while looking at rte_intr_instance_free() users.
> 
> Even if the FD is not used, it must still be closed when uninitialising
> the alarm subsystem.
> 
> Fixes: 26021a715067 ("eal/bsd: support alarm API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> Changes since RFC v3:
> - fixed compilation,
> 
> ---
>  lib/eal/freebsd/eal_alarm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/eal/freebsd/eal_alarm.c b/lib/eal/freebsd/eal_alarm.c
> index c03e281e67..8544fe8d03 100644
> --- a/lib/eal/freebsd/eal_alarm.c
> +++ b/lib/eal/freebsd/eal_alarm.c
> @@ -10,6 +10,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <time.h>
> +#include <unistd.h>
>  #include <errno.h>
>  
>  #include <eal_export.h>
> @@ -54,6 +55,8 @@ rte_eal_alarm_cleanup(void)
>  	int ret = rte_intr_callback_unregister_sync(intr_handle,
>  			eal_alarm_callback, (void *)-1);
>  	if (ret >= 0) {
> +		close(rte_intr_fd_get(intr_handle));
> +		rte_intr_fd_set(intr_handle, -1);
>  		rte_intr_instance_free(intr_handle);
>  		intr_handle = NULL;
>  	}
> @@ -62,7 +65,7 @@ rte_eal_alarm_cleanup(void)
>  int
>  rte_eal_alarm_init(void)
>  {
> -	int fd;
> +	int fd = -1;
>  
>  	intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
>  	if (intr_handle == NULL) {
> @@ -88,6 +91,8 @@ rte_eal_alarm_init(void)
>  
>  	return 0;
>  error:
> +	if (fd >= 0)
> +		close(fd);
>  	rte_intr_instance_free(intr_handle);
>  	return -1;
>  }
> -- 
> 2.54.0
> 
