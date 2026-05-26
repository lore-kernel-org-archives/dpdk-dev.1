Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85550CD5BC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 16:03:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59394402EF;
	Tue, 26 May 2026 18:03:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id A9D7940290
 for <dev@dpdk.org>; Tue, 26 May 2026 18:02:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779811379; x=1811347379;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RzR5i0R9mgij6mgRYILdO8oFaBNswGCaxUOqKXj7lp0=;
 b=G2GngnJ7Qc7Yxu+cew4ExIIP1ysVONgqSA8S4nBOo1FN85xT0W5w4Z33
 csJSQIKGoPwJoOZFJiHyIlnVTBj53/U477vsYvKcIHAnyYnuR6tdsxKV3
 3zPEntGcz+N6kU6y1E6yUKvzhYqSVyiDmxuawYw2QgVHTGeeU8/omBy3G
 uWZuvdR+hFGGIERieShIikD7IK1ysCF8pjKqQz5MpRTnkhA6FiLuKMwrg
 p/xkuq3x4QKEwJdOl6BYc9LRHN/bS3ad2ARTZDYn+m8ocAnX8XMon1dF4
 xo7VTKzuhT/F7I3g22w7HbsIe9K61JS/7dDU66mpXIa2zuuq0iXBTZmkX g==;
X-CSE-ConnectionGUID: U094VEK8RKeaYkihEWU7zw==
X-CSE-MsgGUID: H9w9DyjTSx+BnxtP0SyBgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80536541"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="80536541"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 09:02:58 -0700
X-CSE-ConnectionGUID: NGxMI96fTJay/0aM596SrA==
X-CSE-MsgGUID: xJhzZ4gwRTyUoqtqN6kxWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="247040355"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 09:02:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 09:02:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 09:02:56 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 09:02:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwzyWqwGcBDIiGZSgsZ8uuZIEqnxcfqaCsV2UJzEFrh5iEePlwTHnbxsC/4CelJVIQqRitcVlWUtwFNohotupcJMygWNiyQJYrkDmGdHI0rafxtg8oRPit0cWYkcQTrK1RK9TzLTcfHfhwzChUxakYkF7APYoDwwWrdYco6RGyqQ00Hzz7+vD3z55I4PYMaVQnuWJLsPYbRf8ioRrqckK+1dqhCvim3UsHAEW0CjTmpasFQT4plbf3Ga7HGDlowwP4p0rvhWJ7yIX9j/xfRSW3xwduNIJJlUpygNGnS70byWPMPKJy4BNrZIQ8kMdXXWVp+bkYQCKeTKOpVo9Xcpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nrf3qqHekzJI2d2/0dBz/I4JZOwF9ZFvzwyNhrBMSpY=;
 b=I5ykS1RRNp/biToGqhPl7ZCVkpw6mKIZxuCF5sFxdqxpe9RIA/Qve9LC84yr9ZKGAvUDFoKb6Az553yXXfpmX8Cykt6jdHHwcUQJyl+48oR9KrpqEaqpoZrJFYeWBTiFHvZ9UOG9YYuSgQiuw1A2YL4C4aTTd3zQIpNniW6KP4YCm4qeIyV7N5jcXuQV2EgCVpWIvvguvNqVMRS1qLJXhFFxxnTotr2T/TxZeD84CCUiYRhhIIHA7K/DGEjzX7SanM5Q8NxD5kbAq1q4O+0tuJ6c7gz29kAAkFO6t4MSe4IEqB+JXVTh5Nm4rYWBGe6hc69GkvsAfEwcQh4dJUQ91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB9456.namprd11.prod.outlook.com (2603:10b6:8:290::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 16:02:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 16:02:51 +0000
Date: Tue, 26 May 2026 17:02:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v2 4/6] eal/memory: get rid of global VA space limits
Message-ID: <ahXEJslh20SWaq3E@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1773417833.git.anatoly.burakov@intel.com>
 <cover.1773417833.git.anatoly.burakov@intel.com>
 <1f0e3755ed80dd3dfa98d35002afde053e0d23b9.1773417833.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1f0e3755ed80dd3dfa98d35002afde053e0d23b9.1773417833.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 512ea676-b329-40d0-2049-08debb403d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003|11063799006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info: iBVy6cAGnpio17rh9IzeD+Co/UVeF3x+snwsOooFYODcwQ15gufwyiaIUGNZShJOnEMvJYp/65tfdC/uQt7mNyoEk4bRpy0wnyoLGoWnE2gYthcTQCMZdvBf0IbKHGG18CCgKxR7umAiaBSmm4+MwTkqRU4zau//dWVwKua9MPox5z3ozDm5NLh48Ndynhnym8YkLuDM9GYJk1aGxlmhyUUKh6mN2bHB/FyZ+xg1W+z+Ljv79wq5LTR3sskH4yZ6wlcLk+XZbVjUkifnyFslzYD9s57m/3RbcZa7wRcb3ZqyMVtsHupSm3XHK0GYB8UeFPzrgjJFwVKJXZFtTyuEAFxmhPCB9dKUzmr3ydaansDbcvya+FC5Hr9k2I9OrSY/hph0Q7cdvGypWgLb6U634emH9uwnqzuwqBNxke5nYbl6/a2774OqtavYL4LMQ0VuemNvIGnbEbfcGdPo+hftaHpk9BHzFjn5heLVwCXpZkpYgGftoBXEoYQP1dmgKEt7s7TBf0OYKwLSkU0nyLkriA/Kku6HzkB1nggtOraOHeAklUwU5dasl6tiRO0yUpMWJ8HG0x2SXfw/y9cO/B4D2Zs1bhzmNbcMqNh488GDj5xGBQRdJCF/es16lI6qXDmZ73tvtac2n3AZqWK67/pK9I425Bn2bIk4zt2EwEHuYn2X5eO3clLta8pKpTV7GatG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(11063799006)(4143699003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h8eZLCa6z2bRxL6juy57d2Cu0/uNrxem9WBt9VCouQ2HkH5hTohOwJixtKXz?=
 =?us-ascii?Q?1vCUONw+vv3MR8oXip35wYK1Mpugko4p/5fbOl33l/EHPyFg03MFMwXtTv3f?=
 =?us-ascii?Q?Suuhx6UABBPi1oRGbAReR/bnewo6VPhZWO7D6+ndMwPijcK/V2Albh4hmtBb?=
 =?us-ascii?Q?Ngro1F35CMRGL6VnTlmgzeQwzPqBbH3cj+SApSOSUaSabIYC/wcasO1CTct5?=
 =?us-ascii?Q?Lo2G76tSvzBGHsPXz502o3sL1F6SpIHsadjWgrQ0v1KpYDXkV9BZLeSJ1n6c?=
 =?us-ascii?Q?u3ieNK71SMLjf5aLwVlYO9311ECac2JFrjFJTKpMRC+SeBFCm/Uo1UOkPXYP?=
 =?us-ascii?Q?v8Ipf4GMNAOZhVQZUFubiM03cMV2uwJq63wVigxWMc5s3OEV1aZAooHdJUHJ?=
 =?us-ascii?Q?g1KQNDozk4XH1LSKCPOpBJDC/ydKnrgM4IId1Pc/3XyXr1yhh/lZC3SIcEVA?=
 =?us-ascii?Q?A+b2Rb97NTnOJwKxN0cyQZJIUVMXyzt0P9xuurjlW/QtzIFfuZZRzyiTDK2R?=
 =?us-ascii?Q?HZ3r9XXdO1VVBmRpQaClfb6dq7CuoUqdR+vqix85+Uw9h999mR/is83mAHay?=
 =?us-ascii?Q?EarQSE2SHji/MqcY+a7n18U2VM6gRBGezEoBilCoZk+shkvLnqN5rJEubdgc?=
 =?us-ascii?Q?pERLec3nHe1/54MUNx4kLSzwNx/bZGWFVVw5gWodWqFIqOCnCfyGZ/9+NnY6?=
 =?us-ascii?Q?gZIyz7uwsnrc68WoZ1TuYXb0wIvwXOK8/sBNTTcAUdozqciT7cPN2nIQDUoE?=
 =?us-ascii?Q?oyl4dfqXoG/aUKwBM2UyY12r1IFkrvB0Wdlo5LRJqp6lTVZMKeLN1b2KPL/8?=
 =?us-ascii?Q?J/CwO0rKGJ3bzF7zaGnKKu8DdBStWhgeahbpggYFLlMLiIbz+Bk+Ddpi5yTJ?=
 =?us-ascii?Q?VeiMonbM6z0zE0kwqilPDbYeA8+ABGZ8rT5MBW+V+LwkSGUb3J3TY0qEZ0zc?=
 =?us-ascii?Q?OfXGk3caW2uSllT0FIoNNVwp1kCRD9OED075zYj5BVYU8HYJK5gOwYwdV0R5?=
 =?us-ascii?Q?KocfyPFsqhJUfSWgL6bv4PdTO2gTRY5kLDMO2myU6N4s5idz1QjWRH7R3Pox?=
 =?us-ascii?Q?GiPmZdbcbNFTJI8tz4fPv4PHbpwa0fhrWN3InWO4tTnLHrf1yZekDf2duFAl?=
 =?us-ascii?Q?qdT0TU80/kJSbmfuSpvm35Zmx6SS8dhNB7oDsHX49lxnRLb4SCd4riWfgZFa?=
 =?us-ascii?Q?mFK2Bz/7KpT+hnrkMIsRRGXvutFUEMOMovYD0nd4+J6N6Sow2LPipzjijtcY?=
 =?us-ascii?Q?QYYc8w7uoTG7nic4MUybY4EbBs8xT7NIhPZGg5ax5TmIE1aQXgE87MnusCwg?=
 =?us-ascii?Q?CApd8FILcqQiml2SZn7Hg5SGUsryUhJ8zBPCMXnl/AeIPs7Rs90jNKggod98?=
 =?us-ascii?Q?ebJJ6zeC2Cl99YfTA1UToWT6IIhfb7Dd5GLTJF8qxom0acRJL16TqWM0clLX?=
 =?us-ascii?Q?mtx5XBnb+ggjaGZC7gnhsoobsNDreY6bepxqp2jUqxgyRz0eJJAHr9vf5/1c?=
 =?us-ascii?Q?hc8ySzGANr0Bihr4Id6a8ysRzfjsj3wI+PZdYfun+JV2y+6y4F+FmWVVvuyJ?=
 =?us-ascii?Q?0cPh9fQU8bCb/kl0ke1q2I+l8WIRVHqg5WDTg7QGauZsiWd/s+f5mpHD28/N?=
 =?us-ascii?Q?LuLPzxTM0qSpW+kl1YyJlA7XY5m0cUQ+5UJeF5OKs7V8Bm8ySdxCVPehbArL?=
 =?us-ascii?Q?n+bEhZx6ijqMqnb8jVMYanwqPRm8XA30FZXxxW53Cx/ghgu/n8CBSub50SKO?=
 =?us-ascii?Q?hbD7a4BfgEfTKRivf3INSJBGs5kOQDA=3D?=
X-Exchange-RoutingPolicyChecked: WMVY734BmfoEQaGm8iG3Gwo5/dGLv3oSS3212IM6HeXQ0YQ4c5DRQu5hqPoWxjf94I0Nm7sW2NpC6L6pG6WybJInx60zIY4RJFrFT1FDlLkVtse5uUb+YeLUPmNkWpmYaOT0o7yXoEPItGTQuvmZY5Em8GDcz9ob8A3K4BWNntC2aySGHNwYjaoERD1f+RYoXWnsqavnDGlKOhw8uDvSIhUQd1y8fed+YSp6otgRo3Qxjcm5aJ9CJ26GNxv6xO0Br/rR7W/3zgqVUgFk+ncIRZr7GZw5eXwGXAj7rYJNioYb1qA9w7+RL458e3vvmTjNa7KbDAewQ1KAGNn69umEZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 512ea676-b329-40d0-2049-08debb403d38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 16:02:51.4928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3usR7M8fyY0Yqg35K/NLgeVnNDUFZvaraKWUEe/e18t1al2DV+FVE90/Iuh2D7wmK+udaE/E9doEWaVEg1db1YcxdMEVijcEQThuY9B8UYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9456
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

On Fri, Mar 13, 2026 at 04:06:35PM +0000, Anatoly Burakov wrote:
> Currently, all VA space reservations take into account global memory limit.
> The original intent was to limit memory allocations to however many NUMA
> nodes the machine had taking into the account that socket ID's may be
> discontiguous. Since we have had "socket count" API for while and it gives
> us correct NUMA node count, taking discontiguousness into account, we can
> relax the total limits and remove the restrictions, and let VA space usage
> scale with NUMA nodes.
> 
> The only place where we actually require a hard limit is in 32-bit code,
> where we cannot allocate more than 2G of VA space.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Asking AI about this patch flags an issue whereby the contigmem driver does
not guarantee the number of buffers is >0, which can cause issues. However,
that's better fixed in contigmem.

One additional comment inline below.

> ---
>  config/arm/meson.build                        |  1 -
>  config/meson.build                            |  5 ----
>  .../prog_guide/env_abstraction_layer.rst      |  2 --
>  lib/eal/common/eal_common_dynmem.c            | 13 +++------
>  lib/eal/freebsd/eal_memory.c                  | 28 +++----------------
>  lib/eal/linux/eal_memory.c                    | 10 +++----
>  6 files changed, 13 insertions(+), 46 deletions(-)
> 
> diff --git a/config/arm/meson.build b/config/arm/meson.build
> index 523b0fc0ed..3b03f5e31b 100644
> --- a/config/arm/meson.build
> +++ b/config/arm/meson.build
> @@ -69,7 +69,6 @@ part_number_config_arm = {
>          'flags': [
>              ['RTE_MACHINE', '"neoverse-n1"'],
>              ['RTE_ARM_FEATURE_ATOMICS', true],
> -            ['RTE_MAX_MEM_MB', 1048576],
>              ['RTE_MAX_LCORE', 256],
>              ['RTE_MAX_NUMA_NODES', 8]
>          ]
> diff --git a/config/meson.build b/config/meson.build
> index 02e2798cca..f68f1f5f53 100644
> --- a/config/meson.build
> +++ b/config/meson.build
> @@ -383,11 +383,6 @@ dpdk_conf.set('RTE_PKTMBUF_HEADROOM', get_option('pkt_mbuf_headroom'))
>  dpdk_conf.set('RTE_MAX_VFIO_GROUPS', 64)
>  dpdk_conf.set('RTE_DRIVER_MEMPOOL_BUCKET_SIZE_KB', 64)
>  dpdk_conf.set('RTE_LIBRTE_DPAA2_USE_PHYS_IOVA', true)
> -if dpdk_conf.get('RTE_ARCH_64')
> -    dpdk_conf.set('RTE_MAX_MEM_MB', 524288)
> -else # for 32-bit we need smaller reserved memory areas
> -    dpdk_conf.set('RTE_MAX_MEM_MB', 2048)
> -endif
>  if get_option('mbuf_refcnt_atomic')
>      dpdk_conf.set('RTE_MBUF_REFCNT_ATOMIC', true)
>  endif
> diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
> index 04368a3950..63e0568afa 100644
> --- a/doc/guides/prog_guide/env_abstraction_layer.rst
> +++ b/doc/guides/prog_guide/env_abstraction_layer.rst
> @@ -208,8 +208,6 @@ variables:
>    can have (where "type" is defined as "page size + NUMA node" combination)

Is the RTE_MAX_MEMSEG_PER_TYPE value still necessary?

>  * ``RTE_MAX_MEM_MB_PER_TYPE`` controls how much megabytes of memory each
>    memory type can address
> -* ``RTE_MAX_MEM_MB`` places a global maximum on the amount of memory
> -  DPDK can reserve
>
<snip>
