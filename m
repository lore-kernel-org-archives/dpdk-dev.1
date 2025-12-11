Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E43D3E792
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 11:58:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B38440DCE;
	Thu, 11 Dec 2025 12:58:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id E91C640285;
 Thu, 11 Dec 2025 12:58:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765454328; x=1796990328;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=B8JGYhyS9+5+xoAZSJSVVMTHAYivKwfN6kJRcVNvjmc=;
 b=ALezuHShcp1imOidoK6DkX984rxaH+pWHj96MqbLgLj/fcFa7gaGZQAb
 H9yqAvDaDp9lQMv2Fe4p3I19DPRE9p4W7+iKlD5KpRsgeTWO5eHQcRtg5
 /SCGrOW6WlIQ4QDQ+eS3i7/CqunpEluMmVp81Ypdp6nRdrRiefM/spoOw
 p4Ug8q+3pYlNPZ4uOyLQgv+YYM6LQyO77gAXB0cdjNc16+CWJHKyNrRE8
 80pxFnejHhGdJ93hFIs5+yy+lNnVgl98/BVoVaWRtuVldtHQPCxQgatdq
 W4HG7LVadc3TaYvCM5bK7eO2bjk9TWyGHdF4BxkR0i/rSVtaZmwc4XouF g==;
X-CSE-ConnectionGUID: ujPvAt30SnKW/bxPVofEYQ==
X-CSE-MsgGUID: pGaz42ywS5uwHHyxiyQGuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="92912894"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="92912894"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 03:58:47 -0800
X-CSE-ConnectionGUID: tV9m4BTjQH6KXZ4wfpuePg==
X-CSE-MsgGUID: qxHVZqpbSVeH7UWEb1FcJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="220150059"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 03:58:47 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 03:58:46 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 03:58:46 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 03:58:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOv3dqHHwNHsBOOpIK81h60pyNYyGIdBlGuKS9PCvXT6m0l0CNYsXu2cWx++KJBbVXqtG2CC86PxtDXoZXUyBv7+NTXACPEFS+uFUONPCjlaUskUcg5FFVN2udoStusYJt4Hrjuf9EEP3S92G3/2Yf/FBHrLlrsJvN/TGYyg3HsP/+88dPqOBGJL5aGTOJecoDtY9FgRFWMXRfrTm+i1tvjY6yPyRrwKjlauUIWwNGD2uTh3zHCABhXhUM4P2QIu9qLMlsitIdqVdsa5R9L8LRdCuJOORolhkJIrANqgz9jUJMjXzThvyl4C38t+he4j1RIRfTUJyBo3VvfQRRnUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVd1Fv+wN7T+eUKgKntzXBqerYftpq7/6cw270Uzf6Q=;
 b=AtvA3czBml2/3pPjTS0CN0rFjTvLieLI4s6XC5/UjIfxXKOPvrCInl++YWS9Z2pnd53epIURDWRZYGgKU2Trb4F0bv49PyxjskbqIYuG2RmamAV6DDT6BG/H7qWmnQfeKL4Ol4nfWcyvIdKnNiKZK2+G/VwVtoQFmPK5DbOwfBBFnO6JZxNfaQs2X3Jdrdh2RJLlfN53mdPCcXILxqmDWxEBXZFOno7/i3CoYc9UjKIgXTXAE9/5fIpKmHNzQJspCFnZRgkP0PyUI/2rJVUSH5bmhn9k8l/Z6i6k62jhxwdDj/qJko7rlPNLX0jAHPrbHhZI1yrZh4TAyZiHcIai7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9441.namprd11.prod.outlook.com (2603:10b6:208:569::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 11:58:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 11:58:38 +0000
Date: Thu, 11 Dec 2025 11:58:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 10/13] docs: fix TSO and checksum offload feature status
 in ice doc
Message-ID: <aTqx6TBcy67ETUvr@bricha3-mobl1.ger.corp.intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
 <20251209112652.963981-11-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251209112652.963981-11-ciara.loftus@intel.com>
X-ClientProxiedBy: ZR0P278CA0157.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 6570266c-ecd9-4680-24ba-08de38ac9eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RojqydcS9OlnGD7UK229iwBFE73mTlnbGtL7DlGnJWuLcdIG2ZfHiN84+GHY?=
 =?us-ascii?Q?klmL3/dZyKvUBYD7vl2MZAIGmmrYXLp5ozRv+hlzEBLKUhub1llSGVZQQXux?=
 =?us-ascii?Q?UmungTyXBMqWThhmKUVRUTo81FLSv+LSFdYqSC1P86q+fKOae1WPBj1i3McE?=
 =?us-ascii?Q?Xl+ETPF3GUHfMKylPst1LTfxL6OHake3VgJnzjREsgNudWmqnGcG/6me9Bbr?=
 =?us-ascii?Q?ntWyAzFPZD0/sXp4I5T524xhNQDJUAyyij2m9gdiqRrh45vwl+gzUlcFm4Ra?=
 =?us-ascii?Q?1GEQvbCLMyhuxKfQfsP7Z0dVHyyI34ngKxJHdx9CteWL6DlF8AzlybdQBHNX?=
 =?us-ascii?Q?0JO6sK66DLSXdILSVTxs1hXTK9iNZC5EEOnI++zo1Zc9NjK/S5BDQ/Hgz3ud?=
 =?us-ascii?Q?7wd6I2ajxJF/NuuDMGLeYYhrF8yqwcEXnrIhTylBL1h4DtaW/+Gaengys/XC?=
 =?us-ascii?Q?tGrlYLLX3NYCcbQdNA06PcXIW8BYnJ9EOPwAUVizvaQkKZJBNoALSlZT7Ztk?=
 =?us-ascii?Q?i9DISkul+TyQISFaivYmQkmoSZwtuoIjDrhAs6zrv5p/7tbzV36WWw0qrajl?=
 =?us-ascii?Q?2f7b+2D5/U+PRqDnorcD6qsblLvGAnVtDcwWrKVuyeYwdNwhjyFicChFahKX?=
 =?us-ascii?Q?ai1sGpju4LxGTK9AtRDV9FEg/l1b9xCAYkklDf3jJQVUUD3LPvmAE23tD/+r?=
 =?us-ascii?Q?uO4bBF70PK65gUF0UvKdJwwhep1YNoR6DRO/zJ08VtQ5oc9pNgvocVIw4DFp?=
 =?us-ascii?Q?De+c4vv+5nei8dbXN+THmzGkKEMl8F7mSG4t7kdPLV8UpHIWoFAwktIpRvP/?=
 =?us-ascii?Q?ZbwQAWwYexjLZMm//GRYhOdsKuuOw5lbP/g7XD4JDnXx7i+MFvGf/HPQYqOv?=
 =?us-ascii?Q?0Uo9Osx8kSmM2Su4g0qpUW/eXdDOqxZ2ekgoE6hjXCSDe9YSZS9QXHrv/JcW?=
 =?us-ascii?Q?j9R6mrv0YqJ3m79b+ThC6E8o3nC5jgRlpFFxCsq8n16AiPdxUR2Rm+nMLXuJ?=
 =?us-ascii?Q?czVgwl1oEQrs6/sP2R9knQ9/SK/NJdILKgkkH9IqUhmnkFja0Z1Hm5BQB8Cn?=
 =?us-ascii?Q?Ln/22NCSnndc51Gtlu+t77HL4Q7pZbxDfH2hy8GtEE2UkaJdSC9O429Zat0/?=
 =?us-ascii?Q?pt8N4RZIhJ7Xsl6bm/TqUmO4QFK10TYl0oURYCbCuiHq16bdDd0GlOzYWFkT?=
 =?us-ascii?Q?3K6I2PxBe1WY3/tOkrKKGiRCqMZcdiC88+zbAzK+pRmRgd03hYHgNs03xRL1?=
 =?us-ascii?Q?kRwC/WebXXnH8IhOgkTAXxsZGMs51uhIDIZoa1bVp1IA+g2MAscg+9k/f/oA?=
 =?us-ascii?Q?4Lc2cPqg79Q5woUdsxdWzrtgz18stV+Kp97I554Qjdwnly1pL134vy62WNFF?=
 =?us-ascii?Q?h+1M4dEM3TQo3AObhFT8aZajIGsIyUUfCskb0HTVxm/pua1zPtscSRjoQO8q?=
 =?us-ascii?Q?X+onjPbvbY5FpStxYXtBtotbdZERhJU9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XcEXXDxPxbPYwT+aqSlcwwBIWd3FSAZYyf73Jcu5abrWgupYYmPd79C+Wnfr?=
 =?us-ascii?Q?X9Bz30NABlyh8f09qo60r8fRndaqBW053hekeuDdJzRn4WsJsCMjTDlLOoB1?=
 =?us-ascii?Q?zARPluTsKd/q9ULjwv0DFjykluIX0y2TwnLMF1x7vO7mbBxgMY9Ahv9vBkRq?=
 =?us-ascii?Q?z0zHgCuhYgBEkgIvBZpg/yErTwtyKG9s6fNxw/FJBCRGTP6V7uMePar0xfMe?=
 =?us-ascii?Q?URgg5s6ULGYF0PwO6VxCnjvR03mMswspyxWhyv8MN5oHEU/VXBZAsetRQcyF?=
 =?us-ascii?Q?9B/GVScoFrs4/mfxxWWj+5D//tLOic17bu9WacU0G5Q6WUJfA7DSwnlH0C1j?=
 =?us-ascii?Q?p9lPV0O65A2455lAFhfErWIzMYiWkZ2YXIA6z9eKz/yRrpN49OjcUL/iUdhh?=
 =?us-ascii?Q?tR/sdq+ZNzftbY77AWMaPcKVCYUprFF/T9iJtk+LifBVTm8rVJQJbueZbARN?=
 =?us-ascii?Q?mLisDsPTjU4Dn0Q+0C65HpwPX2iB7kDsijtTmKnIlhx4HPCGGw1yITfWKku8?=
 =?us-ascii?Q?6HHqi+JacujVXJryCE/FQdWMqkXsBXOMPd9hz1OErOkJdBeiyc9qzkuWkP4I?=
 =?us-ascii?Q?r33KkBHm9Oix3mDvzR4Jae9YAB6Vw7G7G/jP6RDf9wCHgerB3ccOIvRVjSYJ?=
 =?us-ascii?Q?Ee+P3vmj+Qo39PQdhhHFIiZnm+EGFNdva4if/9jNRsbOhOh8C6C/IW+B0wUA?=
 =?us-ascii?Q?8J4p3crC4jQWkYL7RDXZ6z1ZRWAQOngPSenO7AJjpdjoo+JPulrd0fUZ+fpo?=
 =?us-ascii?Q?J9/aJCPNiE16aJD4UIbfkOF3Ixb7N2I2BU0/tcL8CZT49T+aG1EXIAJpobkM?=
 =?us-ascii?Q?vGlqDrOl9oSJN990xRmj6bHViPF6bpqNX0ihJoYDnR2mg4pMrBhzkLyh7rpB?=
 =?us-ascii?Q?0ABtWlGfDN/V/fD48q9HbC9gsR7+qHaZSwZfBLAjTSo7oBJ/mZDskYC1yBPf?=
 =?us-ascii?Q?9ES+8QGX4aUfVqMAw6Abdb/5w/vaAbVBjOP9uDxv5RO3VZzzG6L9euW4YzS3?=
 =?us-ascii?Q?8vvz75SyFPsFb3aRi1oODPeTYvlQz57BzpvynAiqVeq85P4lVK96nSwf9+J7?=
 =?us-ascii?Q?98FnantclvPlK+MowPQ8bdtDlihvc09bfWXBFcEmRViMaslhpruSQ+Nwqri0?=
 =?us-ascii?Q?mE4ZakbRmXDiMjPUCmFeQGANnvXDSR6w/3goVSQyTrnA+VGLMSF9ynvD2RwN?=
 =?us-ascii?Q?JsaZkTPlRun6IpTzB8XjsTYOOt0Gpq+8Po0GAXZ+G70MWT9knCNP/0S5Xu6r?=
 =?us-ascii?Q?aF/PCaox7Fb+2ZaCGukmL8iwhIqX0adxhA39NabFg5VfReP3iVrYfyDR9xez?=
 =?us-ascii?Q?aTVyVlpoCBLm7XdHoOg/yuaTUNGlk9jz7v+0Lk5BzhMLvpc3kutbY/dGjUKW?=
 =?us-ascii?Q?yi0yMOjTk9gL2dNZ2RXXCavW8P2wQIjEy4XI6PNRqCzlU49uaSRBpGGTzO57?=
 =?us-ascii?Q?qu22/m9HQkVjwskMLJ/xv78oNxesiDrW0g7fzaYLiWp8oSXQi0b/yTygbLLY?=
 =?us-ascii?Q?+pIlY/L59jxCltEcytom9gYlCKcJJ9d7ECBaE2uINnCtZo1FnQktG15jvqYy?=
 =?us-ascii?Q?l9yvZKr5UFc3sQxZsb0KJpyqq75IBN4pc85KqEEhnD+0xFB0XY7J9UlPKe1g?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6570266c-ecd9-4680-24ba-08de38ac9eeb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 11:58:38.7489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MQd4t9tgr17k2yy3TI8lkHSE5YM1aPQxkNTrZ19iNMzCyQA+GD4Ru/G/NhuIPu0qqIDlbQVftKm5INo3pflWHVw+6VniOzotM7X9VbBiac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9441
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

On Tue, Dec 09, 2025 at 11:26:49AM +0000, Ciara Loftus wrote:
> TSO is only supported on the scalar path so change its status to
> partially supported. L3 and L4 checksum offload are enabled on scalar
> and vector paths so change their statuses from partial to supported.
> 
> Fixes: f88de4694d94 ("net/ice: support Tx SSE vector")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

I still think we need a better solution for items only supported on scalar
paths, but until then let's keep the current scheme.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  doc/guides/nics/features/ice.ini | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
> index e9796c1eab..893d09e9ec 100644
> --- a/doc/guides/nics/features/ice.ini
> +++ b/doc/guides/nics/features/ice.ini
> @@ -21,7 +21,7 @@ Power mgmt address monitor = Y
>  MTU update           = Y
>  Buffer split on Rx   = P
>  Scattered Rx         = Y
> -TSO                  = Y
> +TSO                  = P
>  Promiscuous mode     = Y
>  Allmulticast mode    = Y
>  DCB                  = Y
> @@ -34,8 +34,8 @@ Traffic manager      = Y
>  CRC offload          = Y
>  VLAN offload         = Y
>  QinQ offload         = P
> -L3 checksum offload  = P
> -L4 checksum offload  = P
> +L3 checksum offload  = Y
> +L4 checksum offload  = Y
>  Timestamp offload    = P
>  Inner L3 checksum    = P
>  Inner L4 checksum    = P
> -- 
> 2.43.0
> 
