Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA32C10F9956
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 16:12:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAE0C4014F;
	Wed,  8 Apr 2026 18:12:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 8DDA04013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 18:12:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775664743; x=1807200743;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DaCLUDhMT7BwUNP4prPSqw/iqtauzOvUqRSHuQQSPgg=;
 b=NKqXRj5GxuTS0WXDJlJO2IWBwj16JSk4AWJIdUpm9LOAEVu8Nr6E5UzW
 QWoydDvwgkg8k4Z/u19elw0PH3MTNGL9u6a1e2YQVlenBk0Q/c68zzPdU
 bPavLkTxVctIJj3BGCKHBiZ8H56ux96tFbOq4G4/M4IoGQEm/2t5JgNEK
 pgECeAsP1w5Mo7dXfw5/oGwX/CT01yCt/cIKs/TYZ5hMzOYrZ5rso+HAF
 HGYg+6EQO0YQAy4veAPvYGvDGrHjkrpp2NSzbk8QzrmWnOJ5L4NDG5fLz
 qIibQzVhn0UfRuq9+z7SNrAbCcglr0OQvorjWhuPU1vhL1UnO9dbq174W Q==;
X-CSE-ConnectionGUID: av1380e1Tu6aoUq7xSJvZg==
X-CSE-MsgGUID: PxR6T1WnTk6tF7w2uVVrXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76727100"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76727100"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 09:12:22 -0700
X-CSE-ConnectionGUID: 79g6lRzGQZGfOt2J7+1peQ==
X-CSE-MsgGUID: +hZ6vLZdRXej7wmpey0A9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="266492787"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 09:12:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:12:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 09:12:21 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:12:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCEopArVu8CCMCj2vHnjyf6+EJEmE1wnudZK3FJ8VRpxOGgw5UrO4TJCgmilOgPZwHD85kF/MCWEJUDK2dLNBaARfUhhnpkP8PGaA8K3b8Sn1toP521Us4cNhjMQ8GbGNCkPOgi0+yYy0lpyjyQ8QgHtH+HJ76PzZ7Hg3x6LlmJxMlKji/t4aOvkIahgtD6/oU7x0QgxzxR8omzUo5kVgZB92pxbnojK+BzXl5Y93pbQBzMoc26qCeyVqhMatUcYl63cA8ABgKYHQXILCPwFFvmUaTxMtUUg/hyJb1ihBNtlY8nYzsL8/429nDZ13Pgz10WRnBLytrTTbCyuQS+4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03RJ5p5A6if7QI6NECPUaisT0SRLyXAzh6gbhDZewog=;
 b=TNyofGgM0cEime+tJfXmx9UEqBTDAtEsF3a464q01iEjXTb7X5SM/gZBm+RlLynmG8m25h0hjaOoEAyf+2zWzReoG3tQdKuy6Xb9C6boirdLYYFhhHOVG24USrsZyFsxfha4U842R3S/FRAab+UNWIDCgGm8CJOx+f03F6U0u8Wi0HHnfrGzCdzm9G5KwGWJ+DF6l1x9+PDof9ntrYL1hp3oyx/hKwCcHaQUaMYlbNbNTE4WMOg5zulB93x+/CyIOVS94CWEL8M6XMmyC52aIZTpydD9PqedEWne0XyGefzeWIDts0ZmMwNvruoTqmCazKD6VkaFbql9VrwOPfjCPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB7013.namprd11.prod.outlook.com (2603:10b6:806:2be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 16:12:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 16:12:16 +0000
Date: Wed, 8 Apr 2026 17:12:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/ice: fix L2TPv2 outer MAC address in training packet
Message-ID: <adZ-XAlWGrzZLGqv@bricha3-mobl1.ger.corp.intel.com>
References: <20260406081355.3241393-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260406081355.3241393-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DB8PR06CA0037.eurprd06.prod.outlook.com
 (2603:10a6:10:120::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e96226-38a1-44c9-e65e-08de95899a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 5jzlNyaHdQo7oTvbEIajR+joBsCIFbKXWBieH7Do4SHLZKtwNcM9u6JHE9CtUx2Tv1G47jtwoqV9R7WMmWiinVej9b8mf+++nQsTLL9j0gPEIY+bROMxAN4jrJF5UOcBWDk6cfxJoL86wh51vbkVj/raFfE/I0lUGwAPPnbkpSpRtKq85+G8pnkNymhJnVNb6trwmzBAq2Xms66c6QG/YdNiNBzWIzF2prS0kimbsuPeb9/YsbE3wPPvC9pJdsIuKMFCuKe87yhgagHzhsFC/Mz55sZ9stkKMMbwqecA2P+A2pl3ykXGsRncPJtytYbsRg1Nj71ruvV6rz2XxkVbS44YLwfP17DSbCSCP3duRu0kd8Z8jS1Qh6mNkxyDJ/ohtOvdgasHqF52fGADt76K9pNiAf6AIebHqD3IoSgjI9+/pD7ElBqOvTs3tP/S+e4HUdP+8CAFt0nrS9aXwtRfrySLK58U1jiLNi/wQdZgSSm8WbSG2L1za65Ap+NKsCLL+2Fiv1b6iTEkhxboTV8YFahUc5ywW9QQrAUZWxDnvD07bUNd8X5yVIHl86PMN0siuk9SKfLBn0AXu5U3WeRbCv9OofscvPoNaX46vm9MZFDv5dXUQzOdrZpSL9/hWuzRpzcgiPWaMtY9S9Tn8mpRSkfC8xXfhTiCxrs0fHOWlF7Oc2qcW8ysdqHbr7CNAvpMpkdSscgT/Mv7ENRyFs0OWQU+zXoJ35oI/Sq7hmyPq1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/dyPKp5DJZUTM7Rg5svbQdVyQgrzayw7wxsa3iS9f/W4yvQ7ZLrd3GQjDD1V?=
 =?us-ascii?Q?2on8zqstqcVAn5UToR7eu7YX818hamtCOACBxSbwgKMpNITnCLTzx4WOqukl?=
 =?us-ascii?Q?Vi/Z3fogE1GgkHHNAj0nZtrmCjN8CKMyiCCWLXLWAC9PQ/zxGyvJEpC3G+lp?=
 =?us-ascii?Q?QOiLnHfvXZwXYw+m0QN6VOVjunPWXZwmDPwzsYA0JMqH7eHrXHk0BQ/j10y7?=
 =?us-ascii?Q?hZp9NaVpX5B72lVY20bDHYywDbKjftrIZ/ChZGIUOHoPxodBz1Gfp0If5YNu?=
 =?us-ascii?Q?u9JCksP5T0VeIXX+l7z4VY7MnbFy8rSxmsd+vihbnU5EfiSXtVxNQBfvjUIy?=
 =?us-ascii?Q?em9rDusv9v6QndTKa2fWFVma7I4fe5rqUp1aiNN+0CahkVxKTJ5vaIGcKLVd?=
 =?us-ascii?Q?plE1EHuZh9Jc07+pVbVIO4Esxfa3nbmX+TAgVe2ZbBuxNtkF3zvwVKmErxit?=
 =?us-ascii?Q?T5ZAWrGi62r+UoZS2mAh693O3D2D+1GS/ad4e6maJAwlJUpzH1PbKE2H7Gt2?=
 =?us-ascii?Q?QAS/86etOoawQooabJ2wOj0FyGvZjFfCyysu+bgWJVn5laKCKnmkIg6sna6i?=
 =?us-ascii?Q?E6UlwaAXR+BsZJ3283eXYc+Vg94inTOU7CBh+CrJ5fmwH1lelvkoPYWhq4uY?=
 =?us-ascii?Q?5YczhDc0P9YvOtzftJKjGiipf6RJx64mgtqjHXjtD0umo7bLEJhiOHYpARQt?=
 =?us-ascii?Q?n7GsC/oIUuAnmP2X4Gi3oijkuNR6bR3iDGlzzwUIx99yT3BUZ8im+EMtW127?=
 =?us-ascii?Q?a/XwJnP8t6MKckTDkQuqks1uUbwLoNUADkt+yLNGyJkySC7J4hIx0DgXWq3B?=
 =?us-ascii?Q?U/X7txrJ6fQ6eFNZ4y4K6Ja78JbNBtCz9OfILigbUeoYojYXuI53hFaGONRu?=
 =?us-ascii?Q?Bt5yJ1npzSW4vVdP/gFEi/Ap2+B+kBIbD1lDWa9414wi2UFnDsUyEh6yLon5?=
 =?us-ascii?Q?rN+XF67pLi12iMfobb3sE1NL50sb97gx7v9dnmhgw+PBRsyVEvdXz+HB1Pk9?=
 =?us-ascii?Q?FgC//5ngCjnbkZJDnilsSSJ4oNG7qSd15xn6UaG4Fy/DAWn1DKH0OOUFODSH?=
 =?us-ascii?Q?DJsSkCB7VUr4vtmla+Zx+aAnK1B1t0RdiS7kyp5TdHI6b0ScBWmCwbxwyVmv?=
 =?us-ascii?Q?EMZC0fOdzsC6kj2oaucORkQYoSViL9PRHnMzKMf2ytOmJDSCfnMuBjnS+qnM?=
 =?us-ascii?Q?98rhy3pwrJMslpWep1+lgDWtUhpxJv21UG4hI1IJ++8Eb1Zj4CcKJo6Hcw4I?=
 =?us-ascii?Q?TZjrs/DoGAZkPxzjM9BU6Br7hTSL34BMu0PU8JjgTIlvY4132tSD747XZzoK?=
 =?us-ascii?Q?p4V2rLyuXLUWEa0NLtdZ5rQLBZUysMycj5zejLiv9FskJZrJHKBnB23RsIY/?=
 =?us-ascii?Q?FR92KQOF2LuZif8LgyrWheNHSzE46TGowjGK4RtDAVGCLrQvN9yWCzqjk6Mw?=
 =?us-ascii?Q?4OP3u33ZqDjLZBFenZAmzdA3Sqx5pP2dBk3W0ECUSQBWQeOWTaILBoiZTDoS?=
 =?us-ascii?Q?J/dJwBo6vFraOa85P2G/mx7ON0DqU+8GQwVc/YXGaBLnTuPryLGh0N+KX6Oj?=
 =?us-ascii?Q?CKvuAt9Vr/tjzTNN7ppOXEA7vE2Cfq4CS13Jr+wKcORU/hGRKTQOetBIhYZQ?=
 =?us-ascii?Q?6bzi1L6dXdpowAMZICSY28GMIUStOMaleWMTzEp7jkQ0+eBe+jlRQV9kstJt?=
 =?us-ascii?Q?F8fCR0wE/ZYNizebNIVWuSghsQI0DeLuBkDsHitBrDen0UGDxV6OKNPiRjpk?=
 =?us-ascii?Q?2BMUNsm6STh+Z+Ad4SMqVhCZHFzv8qM=3D?=
X-Exchange-RoutingPolicyChecked: UD/uxAece5Gw+cD75BcGMcl7cK0l3ykBVHrBbJQfocFsO3fF8ZFCP1w/1WZwAyagi5wrD1SBKkUhaiUY4cvSWKNeowOgIWb1PmuuouTm7v00djnHApzSM62Fat95/ucSbqtI2OiGHgdqUt88I8pj7/TOsw9Pdw91kyY7Dkn6Wgyc9wNzNMoQ/GgAWyfLkZZ8nNso0i+U8O/UmPwEnzVSa4jLTlPuCpEDi8uIuh+btKy5xGtOnjG9LSF1CKoiK3xJ8K5SYFIsJVjos0/QaLb8OG/saHIQplAzFgPIt74HpOkgL//95WqQ71TY/jhox+L1tI+n5qEtEk9Wxl0BHv8ODg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e96226-38a1-44c9-e65e-08de95899a79
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 16:12:16.8984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5Ecq1CYoEekGKO7w8k3qJvdIDSIlZF4S5tN7xLgT+VIaeZqDCIukZynZCr8wLesx70y7hkH/w7X3FDaiCLOzGVK5G85AzGsarcze/8m/bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7013
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

On Mon, Apr 06, 2026 at 01:43:55PM +0530, Shaiq Wani wrote:
> flow rules with eth + l2tpv2 patterns fail to match because outer MACs
> are written to the wrong location in the training packet.
> 
> The pre-scan loop does not detect L2TPV2, so tunnel_type is still 0
> when the ETH item is parsed and MACs land in ext_data (inner) instead
> of ext_data_outer. Also, ice_fdir_get_gen_prgm_pkt() uses the 'loc'
> pointer (past the L2TPv2 header) instead of 'pkt' (Ethernet offset 0).
> 
> Detect L2TPV2 in pre-scan, and use 'pkt' for MAC insertion in all
> four L2TPv2 training-packet cases.
> 
> Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
> Fixes: bf662653976e ("net/ice/base: support L2TPv2 flow rule")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/ice/base/ice_fdir.c   | 16 ++++++++--------
>  drivers/net/intel/ice/ice_fdir_filter.c |  2 ++
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
Recheck-request: iol-unit-arm64-testing, iol-intel-Functional, rebase=next-net-intel
