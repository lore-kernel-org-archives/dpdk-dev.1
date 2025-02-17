Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD5AC021AA
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 17:13:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67E0C40289;
	Mon, 17 Feb 2025 18:13:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 80B6D400EF
 for <dev@dpdk.org>; Mon, 17 Feb 2025 18:13:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739812398; x=1771348398;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wK+D0LaBkUicyI+JSgQDNf0ujZEEFs3dI3tpR3GqkV0=;
 b=K7uqpYRwWZaSjsGjVM9f5osAnuYxhY8dS/vv66TUl33hbMqe2P6BbS7B
 btQlKHJzEO9bofuOv83yyFSztnWuIr+9FxAhs8P7sh1wf2CSGV2reE89g
 q8DkgIWjKnzCPGZy9e8DPihELKKMN5IbF78NfQQz0RYHKiFD7rfarmAN7
 yz3wfw+fWGh5lvSSX1dLFiidIwS1VnF4S54Hf7SUKiKhK4y2ITxzyyRrU
 kWsJ/w9oY5omrVTn9h7DilfBAcsCbYusbKa+hJvWotqOx/Yukn0YXOUIF
 AUex4KXls0v5XexrzCY1JWtZW7GrhYDLDBHtpv1VmhM/QYfzvlExKzcIm w==;
X-CSE-ConnectionGUID: 0WJv5nTcTr2eXiktFQ1wWA==
X-CSE-MsgGUID: sD2M9jobQGe2IAeiXpVQCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="50717587"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; d="scan'208";a="50717587"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 09:13:17 -0800
X-CSE-ConnectionGUID: LUtXBdiKSkCy4d1riosVIQ==
X-CSE-MsgGUID: 6HbqfDnQR4yS+9UCXXVkRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="114045656"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Feb 2025 09:13:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 09:13:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 09:13:16 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 09:13:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHkbAQ8fanvpcDwxGmczf9tTS1ABG7ScxhG8DSnSsMbEu3zpLTCaFb0eMe+jXmRVEzq+zThK0hLEhidkeG7avFEAju8gL/ujc4GSMPEzyCQRehncMg4V6l2K/+X8a0Fy8+3twD0M2gFuj4ei+QMvgoH6c1bsMTBtSIQJ0irnc6gidv9ZQB+VC50j3cGEwi0xerLIhmtyB43eQ8qlXXya/aNPuTHfL7ySvg3LoaARhI++AR0XI8uBlK6T7I23o7I9946Qe2lCPc9XVLWB095mNShTutjCe9+AZqGlhJe1uy0FHNzqZoVqhnCo21qBXwjME7Zf5NCLCzUozIuBaXyTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDlUGG9hs8hX2hijYaRmSYUdYlfDMJwPNJkzaWWmAnA=;
 b=ELRVAPfySzqw0psFv+zUmQ32Z33ae3qCmPwuHgu5nsU84BrqYRh18nR8RyxCSRb6E7BI5Z4hAk/bx2PjqD+JA6sKd2gRLP3oF5FVmaTZQel+kg9jyOlmzBGiTn7oVOt3X2vdG5aYLySiJuPJyWcCoj944uIcwNJfbxoht9+XeODQeoex+B5umlqS8LQFFmPZlKq6zXRuFOdJzHBg9VfPzxeG+31HPfwBedn2nHTwm3FuyVzp9y2lcBpAhMw155cGA3XlrfKsZ71aHMCEacey6LCiPfRoKlS+YFX+/ZNAaOTh8Cr44nc5eDne9GjJuM2BY2yPpmFm8BIojnKWWX6HEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5091.namprd11.prod.outlook.com (2603:10b6:303:6c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 17:13:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 17:13:14 +0000
Date: Mon, 17 Feb 2025 17:13:09 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/6] fix the handling of deferred start in ethdev
Message-ID: <Z7NuJV-4DfhCee8O@bricha3-mobl1.ger.corp.intel.com>
References: <20241213214929.817688-1-stephen@networkplumber.org>
 <20250214174224.79142-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250214174224.79142-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0306.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: 287c0c75-9f69-4462-c556-08dd4f765ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vDg+ToYIkPRvKg2Gv5Yx9oemG9n2OmpK2dbuTIA7r9Gv2iZoUwq2IoGYHzre?=
 =?us-ascii?Q?DOIjlKK/ZJGkrva0ZrlZbB5v+d6g5VIl45npBFheLl8Bj8rp6Bg2j/Lpe8m1?=
 =?us-ascii?Q?6fiMQQxMbawYMcJBHQ4yZlHjrpc9+iW74+o722lLeHdxbUK7jZJS89/YXA7X?=
 =?us-ascii?Q?fVd6Lx4Yd+AATiwxtnxDAw2MPbMJNO2Zy70VFJ+xFYcagFsJmJo8HvmeEwU9?=
 =?us-ascii?Q?S/wKVTO17A9ytonpyrIWmwwWaaJS7IYWdYYLxnjxpNdt9EQ0HDjhjCpbug2B?=
 =?us-ascii?Q?oJEG4dRHjM7h4ZwMZrDCwDYNGVBXQvLVzQY6JvNHEcwMcO6u8MJ00lrv2USI?=
 =?us-ascii?Q?Egf9WdnOW2iLmiPAo21S7W9Ek+WyTFaoAINI6p+SGRRB2pplpffLuWAGzZEI?=
 =?us-ascii?Q?krZjH2iOfOBLD3DM3YltfTfB8AbpZF7LPmUPVqm2Myj7WREuMSu7kgRlAm7b?=
 =?us-ascii?Q?mzlS0hRXWbK1tPthau9FwzLqW4ZOKO+ZPA5FoMkh1y0MINnyCtQSIOXhmucc?=
 =?us-ascii?Q?LMAkI+3oBiBKUo2Xgh0S3iuG6zQffHWPOGW+2GTBdrqOCfux1iRX3/CNZw7H?=
 =?us-ascii?Q?Xt1DMZNeIxF2VDYNVbtHZPcMbWO6v1brrtsb9OoOQlQhNtJ8Z2V/IHJNn2KC?=
 =?us-ascii?Q?r5zJ0lUJCwMBie7m7zKZOsmYiwrZllJmXAuDgMUdV6Uv2AaQNBV6n/6/HU/N?=
 =?us-ascii?Q?YRfpqw6L52f+ZyM+CKuXDYtiTmB2tvevigaH39H/JyYCWiHXvK9uAu5/m45v?=
 =?us-ascii?Q?e2PDxspkqpZhIDkzL7Z0a/WS6axiXpmauaMKnRaF7q02GNmu7febSEtFEz3p?=
 =?us-ascii?Q?wgMc8DxU18ur8UoxwUMdzHCC5Agbe3ayr+5vOmMKv/xO8pc2cEO/qENvpyoM?=
 =?us-ascii?Q?fba2llAobzK4Vh35y3E//An80I9N0zjC+ffzsCxNouJB6kqFLTHuWOquJ6gh?=
 =?us-ascii?Q?d0SacPptCBs+YkQ7vUZbBZZktsRB6LolJA+SDoXCEB07My72jMIF2JIEbryK?=
 =?us-ascii?Q?xcESmYni46JLA3HCEReauRBzSyh7u8saaA17qRXTEyF++B+XiiLnlBBfUE5P?=
 =?us-ascii?Q?vljB2ZiS5vWTbWLS2WvrV1vJ3+HGXzuDGMUicYKP5qGkVON3RiV3zhI2dZtZ?=
 =?us-ascii?Q?eeQ9qkx+WY4p2Si5+iHywN0PlBQhqeVwwBoDBCgtRp/fVKnhyuB5UoYFdfcz?=
 =?us-ascii?Q?yLdiLmkvZtC9s7BTxIQ6ZgD767JvNEEuUTUUa5CPjl5br1vS41VBJ3JFdgcF?=
 =?us-ascii?Q?ZqzCKZanR5uMXG9f/krp5aUKeHNTFJ1pbS91StCcNkvKhdo5tn0EdF7oPfut?=
 =?us-ascii?Q?8oCZkrZMEpeTM7VLcmx0NEThGcujF8cHGNopxLS5E0Il5uTpdbqT6EHI5/2y?=
 =?us-ascii?Q?8+vqWBlTirmPFj3Xj+HqOjMLFoVQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QBj1DULxMFiKXbjTyvSnI2Q1UsxwE9v7Xcrs1wAyp3p/bhGx+QtsflFsu5E9?=
 =?us-ascii?Q?u2Sl7tQZCrGGqOeeOPvZSAORw1proikQptHMDVia59nH8mnHvTgXn3YKaodi?=
 =?us-ascii?Q?lLP15nIZIdbqd0Go17z0+0QO09QZ4tOyTQLmS0aUauvBpiHVTK6RZizEQES6?=
 =?us-ascii?Q?Y3aFu6ytElFDndgL7d5uAPWLsRgH4Oj3MMUrD5IlaS36NEl76aRQWHhOaIXe?=
 =?us-ascii?Q?N+2Nw1NpRY4jAq/D6LwoUUmlQLcQAB637fuxqhW1L6cGDZEDKS/w+n3AdeLH?=
 =?us-ascii?Q?SH+xAPnSIhj7KG2YOGI/njjrvp6roSO5b8JEUNtZeqQ1HaEIWL0gBOXH/9ht?=
 =?us-ascii?Q?Yr7v7u1gTr/p3cfx1b/sb8FC2Aaoyz9RWBiZ7DRRQWqPPV1HsKGNuNuWKOe6?=
 =?us-ascii?Q?2DkDiA9Z+SBTvs0ZXl0+81zSyI4O0BGmprYdOWxBr8CkvF0bsdCtjz76q9dO?=
 =?us-ascii?Q?jEClp0zKIqCwjMd2/BHtuuejhm09HkCuFr10S8t5mXuRIXTA+D/sg8uAv08I?=
 =?us-ascii?Q?SwMLW2zfqeoR2bCSsKQzM8s3jtrTa40myL28zRC4wimJF7elUM1ZN67Sp4Wg?=
 =?us-ascii?Q?RPz56RrDViVct8uHGbMRADBKb7bt4KUo4LYaPONcAwkhWLoyqO7X464AFHm9?=
 =?us-ascii?Q?/EEzpvDRijvtQRAah1taEen631y3blSXdVktT9YGA8y7zCW05x4TCDBhJCI3?=
 =?us-ascii?Q?ja3XLIV9lSS3fCK3o9vmHwPQkIpN6HDmNQwFu9chuj6EvP7aOQIArDoVXjhT?=
 =?us-ascii?Q?OxsL3CAXCEy8zEYUG8nRqO2StESY6ubaR4KgWRFdWf4h075Ii70KlUis2cEB?=
 =?us-ascii?Q?1Xi8AkfMxE2Tt4KeG/BMGJpY8Tf0pX6ppnNvCWMGzLf3zBo4ywP1cEYyfjB/?=
 =?us-ascii?Q?RrJNq8yMIZmwDvw8OOcnkFbiiqK2tcspy7EuRSmq9MM4jrUPsDD4zu+SOWXD?=
 =?us-ascii?Q?w3tIgHu0ykY4kfXn7/X3nYDa0L6HOZGFB2N6GNPuQ8BbSd+vc6Pu3Jv+ZcmE?=
 =?us-ascii?Q?oi+XtOQy9nMa0/Qs7J7BOJaW+lqv6XlaaW2cW1BVfXZ/uk9KkaH2htPlKFpT?=
 =?us-ascii?Q?ht+x32lk29vCmOOujtLi3j0IHxHPL2P0Gz36L7BEs3TDTnMTZhTkENGF3gev?=
 =?us-ascii?Q?fzSVUQA3pZcF+wopkADLrqTOZroTZTszlMstUCG+e1DyojfzFmUqQuzL88pM?=
 =?us-ascii?Q?+3TWF/NNplo+UtQBAZcv9br/Ci9V1Gytsqea6GTEFkuw/2SCun9vW+SC7DDP?=
 =?us-ascii?Q?/K5Q4lnmPAynshI3ruchRyDV7kb5Z57m6JvRpNa3axoYlk7wp5oZurxKxh61?=
 =?us-ascii?Q?tfXsan9nXQQ/SpfjTQyrdtpvxWVhnHrMtimjlAm836uh5P9wJFbdsrbTs49a?=
 =?us-ascii?Q?vVjvVNyaCWTi8tcOzuwJHxJdwX4xVoxrsmEGYA+pJTJuL2DmXXbFoN0c2KqU?=
 =?us-ascii?Q?/nJj6P14XpbwoBL8lLsSIj8hRYyTG02houE5bjB2+HwhQjUzlbGJ6P8zkT53?=
 =?us-ascii?Q?M9D8ebJAY8h/hGtfizf8eEcmp1BMnXpBgBvQF+hYTHTMor/rS+O0ZSGRIeBT?=
 =?us-ascii?Q?JsP2IYZ5j0pkhqQTm0xx9JETMDodzGPU/a/0TSNTqDME3+xRSc1zJv8Z/dTj?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 287c0c75-9f69-4462-c556-08dd4f765ceb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 17:13:14.1193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAogTbIoRe6dK+y1Kp/5Th5qpU2mYWDqaBZ0mg1AA5YxwmtsmxamW21w0KLwTDpeVTcqE7DtFsaOTPr80SeQssZCVJqCWGGy3VI+SLpVqHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5091
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

On Fri, Feb 14, 2025 at 09:38:53AM -0800, Stephen Hemminger wrote:
> There is a inconsistency and lack of documentation around the deferred
> start configuration flag. The queue deferred start only makes sense if
> the driver has a way to start the queue later via ethdev ops.
> Therefore move the check into the ethdev queue configuration handling.
> Fix the driver documentation where the support of deferred start
> does not match what the driver implements.
> 
> Stephen Hemminger (6):
>   ethdev: check that device supports deferred start
>   doc: fix feature flags for queue start/stop
>   net/dpaa: remove unnecessary deferred start check
>   net/dpaa2: remove unneeded deferred start check
>   net/enetfec: remove unneeded deferred start check
>   net/virtio: remove unneeded deferred start check
> 
> v2 - rebase and cleanup wording
> 

This seems a good idea to do.

Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  doc/guides/nics/features.rst         |  1 +
>  doc/guides/nics/features/gve.ini     |  1 +
>  doc/guides/nics/features/mana.ini    |  1 -
>  doc/guides/nics/features/netvsc.ini  |  1 -
>  doc/guides/nics/features/virtio.ini  |  1 -
>  doc/guides/nics/features/vmxnet3.ini |  1 -
>  drivers/net/dpaa/dpaa_ethdev.c       | 10 ----------
>  drivers/net/dpaa2/dpaa2_ethdev.c     | 14 --------------
>  drivers/net/enetfec/enet_ethdev.c    | 16 ++--------------
>  drivers/net/virtio/virtio_rxtx.c     | 10 ----------
>  lib/ethdev/rte_ethdev.c              | 14 ++++++++++++++
>  11 files changed, 18 insertions(+), 52 deletions(-)
> 
> -- 
> 2.47.2
> 
