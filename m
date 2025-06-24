Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF5AC71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 13:53:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA73E40647;
	Tue, 24 Jun 2025 15:53:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id D656D4026B
 for <dev@dpdk.org>; Tue, 24 Jun 2025 15:53:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750773189; x=1782309189;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vcSH04Gyo4CvzO4RuqyVeSACeXHMY9KOe5FlhchNB5s=;
 b=jFmHKvIAKKkQz4wElx+Y5/qiwu55l+ZmFgXs9t8JtTtPQgwJ6C1uvZe3
 RMjpZYYTmgNCqw8nN2cKWrlZh80Z92if9t27P2BH++C3CInrunvmy8dmF
 JdvAAGbWGXPOcRhiGVln+MbYt+HFdgSbAwp5B400E88gKvch5ChO6QOGq
 uG66rpmv4K1uCToJb4nhGK36PgAIz9Q/EZteK1kA3UND7qzcY9i4dakrW
 b0p1fVYwdM/dPCuo/SgAj+LAaPnXXea7owZPqNSL5eHPTbelvF8KreOLb
 8hNTwE+sJu59MeJiARHcuPh0O2BH7F21hZ+peVzhYtVZ8P28xbkLHnTkf Q==;
X-CSE-ConnectionGUID: +wv9EE0vRFSSrBHd4KjtDg==
X-CSE-MsgGUID: MJWowzQgTXSepzYqCJDLrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64369933"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="64369933"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 06:53:08 -0700
X-CSE-ConnectionGUID: ZKEGt1XARoKurs6ItQIDsw==
X-CSE-MsgGUID: Q2c44Q4HT5iCv1WJUtacLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="152090148"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 06:53:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 06:53:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 06:53:07 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.66)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 06:53:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W06QTcewyeRxCvAGiDJrKkdUp0p1fzPD8W1zuN0249oyZm416/zbze2YiKCpS9eye810GAoPo+66zoTZt2ei8qKJDja+0z2sIXF+Zof5q6vtwUfcmXliAY0hPwV0V5e4jUciqbixpCOm2ze82t34k8ShYPQzY9INGxtdgUTtcy96JmhDRQuyQSWYge9l/9GhINTUtmYDB5feYbjCK1V72Lnpc+/0p14nnUq9PxewAV6Zg5kOHgWJYO6+xMlRbUfibewI5nKhHmPHHDz/DuIu/9nJXiwb4VySttKi86B57UC/zqU9ro7DiZCMinLKU3VGHcNuGzenWksDLz4d1ibXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIIvAx1MgaRFuN30J97HJr7Q0Z3q59T2tXFAGJeVZlM=;
 b=e5TjSyFKURjPrkNG9HjoWNHRFR2ffa7TotZE4IyPckWUD0RtBrKUenxnxi2HzGb0ASY2lSvzOl23EEnRdNQM+zJ9DVCWdEAYAuKm+MZktuKW2/NuFg3JcGClj0W9qXdELSxQnJszyv2Grsum0KB/yMlWVpH7PwrLnTFRnvCC6Lzte85PQNkgLFFoQ9NXo3sBCuqcgwXAfn5IKcAZYCjUkC8arA3JvO6Q/DiKuqWVZGwmm4TMXtfhSem1w2cHU03QX4pla6jRLyTTDE8VoyyKpWlgnACnnSM3dyQIcNvys0CPMvKZcuTpy+tiTV8mUb4djIMdZPxXaNcMlQuup/e6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9322.namprd11.prod.outlook.com (2603:10b6:208:562::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Tue, 24 Jun
 2025 13:52:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 13:52:50 +0000
Date: Tue, 24 Jun 2025 14:52:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Edvard Fagerholm <edvard.fagerholm@gmail.com>
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: Re: [PATCH] cpp: Fix missing extern "C" closing bracket
Message-ID: <aFqtrSmrQJoAv3OM@bricha3-mobl1.ger.corp.intel.com>
References: <20250624111253.2074168-1-edvard.fagerholm@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250624111253.2074168-1-edvard.fagerholm@gmail.com>
X-ClientProxiedBy: DU6P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e65d26d-ce42-4cd2-2a1e-08ddb3266896
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RquXEA1VkOEeh7cgmuBv6ErPPnpXEmm5wqE150xuQMuM1Xqu12f3FBY/qB2R?=
 =?us-ascii?Q?d/R4iH0rYqLCa1/jV/T6SR2fa25M9iJVJzsHXMpWrAHT9LsOmBIvNzGpHlP1?=
 =?us-ascii?Q?WJd2RJxGHas0cbs9zLN0yJGVERsQFkHwTFpnTd6AuduKM5pveT3/1V8rDz0y?=
 =?us-ascii?Q?BMlyMRoKBw5243zuGZJ6MJjCUqKfLGsH5JiO9vdkMd40T5MmxmTk6hm1z4kf?=
 =?us-ascii?Q?fTEYwQFfAxef2RDtCIQ2ELPYIAZ9u7L2ZTV2TTrkSl+lmKmktGfioR1lk103?=
 =?us-ascii?Q?6wuLCfWHt+HHaT3ot36mfDoHAbtFZp8ecQiOpF6t0RNmOaM05mr7dfduPlHt?=
 =?us-ascii?Q?bm7FDJ5CPYhGolhcEc/q2WWr/S7+V6a1e5oMFlIggqz+CIxDGbwmZWZKuUhN?=
 =?us-ascii?Q?zEV7nr2pBOpav5/hT8QSFdQPlGBSdY6NJYqQO43D0BLR1pILSWOLXww0759q?=
 =?us-ascii?Q?e6w+Vfh7yi9JicQv+eyHCDQrV1txuWX2XR9RGG0iKuePE9yNzcbE9jNxouZb?=
 =?us-ascii?Q?tdzmRkiHJPZxpD9d3D2Le/fv9CRwh70z0e1JzAUv/+5Pm82ZH0teQOAZmQTj?=
 =?us-ascii?Q?HKtFHdt9hjcIlNQmBEtfIeQUKweGLy3eMSi+Dlm5roaELWigx1eGm49YGdA3?=
 =?us-ascii?Q?HicE9/VPMqfqMypzHrIxaa4bWnlwVZ5TLL+ftklL3z0dnih2Gu+a+100DYiY?=
 =?us-ascii?Q?A99rOZQI8I8q9Pwr2ojrRfV5Qh/Vzkrcodz32PrPgnva3jBQkhK7tygO+rfL?=
 =?us-ascii?Q?lhxvYDbv09lfEYfnkhaVU/dOKCE+OQANd+oWHG78rb/lmwwUkmbH9NPIf2PA?=
 =?us-ascii?Q?gaaDj0GkbxS4qbFwxlCo9NWzALtwse4P3Yk2IruwnPqpP7XNRv+71G2bFxho?=
 =?us-ascii?Q?p9TP2dh4WIHznQMoROnk3/33T2IjmHf2ZWOtXfTgH4ASHrNwZO6Kx1wbRydZ?=
 =?us-ascii?Q?9uZUTmmx2fARiIH5NduSe9k1rUXXd1pBlH5ob68p/L0ULZFmfQIX9237vAco?=
 =?us-ascii?Q?8+RXY3Eny5rzeG6zXdnOKlGjHHcJLTBnnpI1hNRzWn9rLATNsyF0BNHYpYzJ?=
 =?us-ascii?Q?J5tj0mKEqLnT9nAIA/MiCnLJOZ02SGUkSV60IR2OEambgzdlulWY2TOFM9zf?=
 =?us-ascii?Q?w3IZi4hf984XcHQVxk4tMRW2t4Ir0dhueVmI4EWpecc8HsSBeRusQ1UXwnWF?=
 =?us-ascii?Q?BgiNIzNmkjo7FEyMroyViaU3w8o9b+b2TfEiIXl0SBn0wJ/qhmX5tnMuNPvM?=
 =?us-ascii?Q?9LBxtdHF+IuAEB8B9/QLunQP8GlZtCc1lVQ5FT1SXrNxs0fNAw5PyGJErmJ3?=
 =?us-ascii?Q?IvdEFC9GX7/hYdCb3TCcTA4OXnJWC4WYOt0fbldvn5E6UsFKcoMvPEbJUuBM?=
 =?us-ascii?Q?HVv2x3w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m8iRMstV7QwKEQ0dxk0wEdGs3mTUd5IlNezn5xtpMLA89D89RL5G6n2uB7eh?=
 =?us-ascii?Q?9SNxEur2X9Lt/jRrzqN1GDSDr6cbqKY2b3dfcq6eT9T756zZdO/y0KksdEP7?=
 =?us-ascii?Q?RfiT1/cf3UjK72LvVcTUBfRPVvEY++XDo+UKLiggtI679mKKRtwLof7TqTIw?=
 =?us-ascii?Q?Q0DSYZ4ScvdPgUkVoCUDYcHJHzCsFrXLR/T50qyT6VFNGwyK5/F7oknzKqiV?=
 =?us-ascii?Q?RpwPZAMu+caiLaRuGnMnn1BS/6ao/OODij+JyuEoN9g1qbDFuiJPz49vwpkF?=
 =?us-ascii?Q?Zr2OMHOH7Dd90DFrBEbVlmvFlNz0DLDtUnhqe3X5AezrxxzlGUQKrMvzrPhx?=
 =?us-ascii?Q?0XDhwijpOV+mAuT3HSgSm9gGJGuBE51ozhrp7HjwIhBhAV7rZutBD5oJUYGO?=
 =?us-ascii?Q?UlwDunzREhotSDSR0VbYsnTq2oVSP2d0pw6hr0mDhJnCGQ+wBUIs21rvx7Py?=
 =?us-ascii?Q?0EQo1HwBCWh0JKOypM1qo+t/BOxDF+peozx1UOR6HgsnEArA5TDDYpd1+5dn?=
 =?us-ascii?Q?5cpUHLP+xDfRGMo521WWnRv+30FjGdAKS8gdLi8egzq7vRZ7dyivkuO0NczW?=
 =?us-ascii?Q?vBzoHgVth5o1tVxaE3ksuH2aUYl1JOcIayTk9SgCLErVcQ+NFTY8p8lRWyN7?=
 =?us-ascii?Q?9eo/TDPYlvcUtwf85AUmXy9Fedc3ECVd6AjOGBZv8xXp2wq7V4ILJnQCj+hy?=
 =?us-ascii?Q?b85pHrWyHnwmkMX3GkInKfhBClO0i8XDKj+0oiUVdfwKghA4ogk4LZgd0f8W?=
 =?us-ascii?Q?C8GeKesMKSALDSd0Q1EvNMFQQmG0iB2573HPdVDCq+Cv0iM0U2hDcuPlCgFo?=
 =?us-ascii?Q?qKID9b+/X28hlrJr/93BgyM2ARuUF6my2q1ALf/JXEIqVdG53nEOH0MWDzDX?=
 =?us-ascii?Q?ZoIqM1oHjk3eUhlEd/td6Vy4uqnWYgocKfuvQz0kZGOEe+opeOjlXRqqpomQ?=
 =?us-ascii?Q?TST64whfGfkXB7wXwvuM4cSqlHB03W9JM09Bb6G7UP6+aO2Vy9IrZ/mDWyh9?=
 =?us-ascii?Q?SF15OGGZtZrhmDUuR1aCyu3VwHmGhCulPjveLTT1WEWI4Hm3FijYgZKpedWB?=
 =?us-ascii?Q?0Lx24w88z2YV5PWdyFD3pnR3BxGYFu0y1iXqT6SoL55lg/U63pUn8wnGgHiD?=
 =?us-ascii?Q?K3bL2gxfWQ4nIdPiWtm6F7PipK82A+Xy+OCgJBaFW0gcBXZPKX8I35m01QKX?=
 =?us-ascii?Q?tVobFiMRJsTBRO0G5nQczpRygADD+NTNoz3Dzx8GI54rlnuGKXTuqHwTXT9h?=
 =?us-ascii?Q?sBB3Q1/WAxN0xywS+v3+QZ6NwoVYFNsGUIOVgA2dvpDCG8kYVYycJYf8tefn?=
 =?us-ascii?Q?XtZolPb29nd0B3q3FWupPoxpdImM7/1ihWW4oTnkHY56FzPLJ//iRRjU4JOe?=
 =?us-ascii?Q?CnotcO72ZT07URiGjpQa0ww5Z6Zi6J5mN3xO3lguhXbAqIpzq04v+Owr8m+k?=
 =?us-ascii?Q?XsLBYI4sfAAnvRtvc+tGJYVdoYKBkkf8ywJyrFyol9HLiFfCglrtQuDctRjI?=
 =?us-ascii?Q?RZO84db9QUx8jlfwx4UCaQge4UJyhW9uIwRCR8VrLMn9lfhz69J8qO572Rzu?=
 =?us-ascii?Q?EKr5nentoO0qDDEgI4YibLzX0yHWo9KFbK7MbSBZJ/e6MD61ZBkO2D6Xayg4?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e65d26d-ce42-4cd2-2a1e-08ddb3266896
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 13:52:50.3456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KK1X+mMeDsnpDXLDcEnTLmZyLbaIKB3qZ+/MESk/uzTq9/5b4hObeoWnIAFioRv2LWKiZ0W+hukZYnr1kmZZEDntcWrM/Sc+R4FWiS0R9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9322
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

On Tue, Jun 24, 2025 at 02:12:53PM +0300, Edvard Fagerholm wrote:
> RTE_FORCE_INTRINSICS with a C++ compiler causes rte_atomic.h and
> rte_byteorder.h to emit on x86 an extern "C" without a closing
> brace.
> ---

Unfortunately, patch is missing a signoff, so isn't eligible for merge. Can
you please submit a v2 with the appropriate signoff included. See [1] for
more details.

For the patch itself, it looks ok to me, but really the various #endif and
#else tags need comments on them to indicate which #ifdef they belong to
(unless it's a very short ifdef). If you do a v2 would you consider adding
those comments to help make the code clearer?

With or without that suggestion, you can include my ack on v2.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Regards,
/Bruce

[1] https://doc.dpdk.org/guides/contributing/patches.html

>  lib/eal/x86/include/rte_atomic.h    | 4 ++--
>  lib/eal/x86/include/rte_byteorder.h | 9 +++++----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/eal/x86/include/rte_atomic.h b/lib/eal/x86/include/rte_atomic.h
> index c72c47c83e..68629016b4 100644
> --- a/lib/eal/x86/include/rte_atomic.h
> +++ b/lib/eal/x86/include/rte_atomic.h
> @@ -282,10 +282,10 @@ static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
>  	return ret != 0;
>  }
>  
> -#ifdef __cplusplus
> -}
>  #endif
>  
> +#ifdef __cplusplus
> +}
>  #endif
>  
>  #ifdef RTE_ARCH_I686
> diff --git a/lib/eal/x86/include/rte_byteorder.h b/lib/eal/x86/include/rte_byteorder.h
> index 5a49ffcd50..62a87c1aa6 100644
> --- a/lib/eal/x86/include/rte_byteorder.h
> +++ b/lib/eal/x86/include/rte_byteorder.h
> @@ -48,10 +48,6 @@ static inline uint32_t rte_arch_bswap32(uint32_t _x)
>  	return x;
>  }
>  
> -#ifdef __cplusplus
> -}
> -#endif
> -
>  #define rte_bswap16(x) ((uint16_t)(__builtin_constant_p(x) ?		\
>  				   rte_constant_bswap16(x) :		\
>  				   rte_arch_bswap16(x)))
> @@ -69,6 +65,11 @@ static inline uint32_t rte_arch_bswap32(uint32_t _x)
>  #else
>  #include "rte_byteorder_64.h"
>  #endif
> +
> +#endif
> +
> +#ifdef __cplusplus
> +}
>  #endif
>  
>  #define rte_cpu_to_le_16(x) (x)
> -- 
> 2.34.1
> 
