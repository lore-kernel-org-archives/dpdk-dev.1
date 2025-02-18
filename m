Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13692C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 11:29:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20566402C4;
	Tue, 18 Feb 2025 12:29:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id E27D7402A0
 for <dev@dpdk.org>; Tue, 18 Feb 2025 12:29:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739878146; x=1771414146;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SErgpVFo6CA9aNDLqGBzyJVxLhE8NkKCWZ1ALeNhc3E=;
 b=VWgyz0Chbsu0lB70UNh6qwQYu2Sy8uS4SiNUurp/00ShBElcZ7Pc2u6v
 5cwTAXVAMX7dgvkAjdWJWjuLOmvzbgj7YNk/qmDdxVawTeIwaqJ/qeZaQ
 U7L4rWmedEqX7xTt3epPGdtc9yCHBWISiBhWez6z6OdgfnE44anyUZV2h
 MMS2Wdw/RScJZAqmcrYWKrI9keRrtdhXOBJjerrqpUZQVkOaq16IMD9Ci
 mgqO9P1145DY7yexNkZF633cylg89IkQs7EOsAAgIJy9TSyh0K6ERUtD/
 XeJWYjTuFlL5m2jZZBXJxU6J0uqg28HTIDLoNP1FpnmJT+2VJZi0riROt Q==;
X-CSE-ConnectionGUID: MADA39weSuuWd14AEp9VMA==
X-CSE-MsgGUID: je/VyQYUQA+kLDtGGic7Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44325044"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="44325044"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 03:29:05 -0800
X-CSE-ConnectionGUID: CXiFmcovQn62o3fR+PWGHg==
X-CSE-MsgGUID: FxESY5kBR4GsAvc3xxvrGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="151564127"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Feb 2025 03:29:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 03:29:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 03:29:00 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 03:29:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRTAm2aEKpMBCPLBwVrHWC7+lfw+kKAM/teRNYVqU6ObkHCfbFmS2La7K2jfKP/mWFrokJ6qCEVvuFqWr5ij4wcbjyiUKJ9XMj8ic2uR3oKvvWnnA9LqyBsSjZLxEefksI1NXD3zQZrZ360JwzWasfaKLoib5fH0nXPFky/++9EPuBl3eUNOR83esf/6YwZFLHl4qcAb7NxzjSJ7GN7p1dqQqFN5eAqABl7NjMmyZPAt42StiGT1xBRM/vViWFejbuyq33ncPEBKPqMCcmIQxS+kvp1wKAkgnt3BzPyf0QU4TaivvvJtC9M+ajdFOPVY3PzNUzdgHg3mB61TjXdEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEY2kmWrF8OrbdUlAiDFitP89/+LRmrJ3QvlB2+2oTU=;
 b=a0wTIfszs4US6MUv31yeEkkOjznURH0Om0pKlcmio0sCrVFLRzf9vWwX/kOqeEFFk1jFpgp33lCH26u19M/4FxybOqKH0vp3qgqsHFLsKuuIvdjwWrFeRY0rFQPTeWaWsbthBpOIx5dSLgV1cG9qH6xQRzW5PrxyHq436noV/6QNSYRONb9FU0mDJi5fZz5kD/KrVpJWNRTPKqJ9FV2Gx3j//dyUkKlnGdA9qygR4F/zBStFBpPTKpYMFh8CsUittyumOynH7QT3MWL34GgGhUnFAqNHtEOtuLqRkfFjPI6vErEUyL7eDyRwNIVRmp73MoO2Mtk3dmDqdqCQJ6Tv3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB8269.namprd11.prod.outlook.com (2603:10b6:a03:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 18 Feb
 2025 11:28:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 11:28:57 +0000
Date: Tue, 18 Feb 2025 11:28:52 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>, Nicolas Chautru
 <nicolas.chautru@intel.com>, Brian Dooley <brian.dooley@intel.com>, "Aman
 Singh" <aman.deep.singh@intel.com>, Akhil Goyal <gakhil@marvell.com>, "Fan
 Zhang" <fanzhang.oss@gmail.com>, David Hunt <david.hunt@intel.com>,
 "Sivaprasad Tummala" <sivaprasad.tummala@amd.com>
Subject: Re: [PATCH v6 1/8] build: introduce optional internal dependencies
Message-ID: <Z7Ru9MwRobkyY8lV@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739877265.git.anatoly.burakov@intel.com>
 <6a2c1083c2196b6dbf39f3fe043e3336e5216358.1739877266.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6a2c1083c2196b6dbf39f3fe043e3336e5216358.1739877266.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fae62ca-4b89-4ece-0c31-08dd500f6f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h1WOZUCar2FNWohRTs9FVRZFoMqrLzd1Afi9ffAIbvOR7xBAlZNR8dX72vgN?=
 =?us-ascii?Q?iyLegtjN+yK+Xqm126frmzLDznSeIRdfX3ugosRJQURkaPeXmw8EpeNJ8ucu?=
 =?us-ascii?Q?jBJHX/Zsdp8YddAiPKMT3SKwE0B2xKQ3cJDSbQXfOWAg+JfR6dD/VIL3sYUr?=
 =?us-ascii?Q?3HDmwM9CLWOqNxiGIxkOep685UPzcB+IFt2wdj1DlyUPw7L8dMg0jcHtE/9r?=
 =?us-ascii?Q?Uv45U9VIwDjtPX3gAQzSl/w6os0xrkKHbIMKmCY9udC24QFfAXhPs4wSykOy?=
 =?us-ascii?Q?YdStrJtimuVW+btpgUTk+t8ovKmN7cMeOhLErg7hxozMZkAo3g9qb2iGbEtu?=
 =?us-ascii?Q?U1h9tXEdmfEVe4RCA90Ou5cqPBcTzihhJhREYJFXc4ZZ0Sij8ApXvatg061H?=
 =?us-ascii?Q?m4r8VQDEFbsrQnldLtPemNZqJb0x/RQHEqSIKUBL7x7sK0yO5ccC5M+i8bj6?=
 =?us-ascii?Q?w2bFw+48c/13rDktBPQ64eWBiFoVjPjWjSaMHWcYPU8a5GYk43Ix0RIpyCBu?=
 =?us-ascii?Q?HLq04K4nSaXeL1U77tPEShUyyOOwdUwq6PIIAGGxbj/nXARVQ6KE31O7roVh?=
 =?us-ascii?Q?F8DpeYHymoABqjp6o7ipLk0LYi/4Anu5WZo75AD5vBGpM6r/iD5BtqiuYMQ6?=
 =?us-ascii?Q?d/h58YHw24Oc2q0kNoaHv3RtLGe09VrMRFs6RUpX9K6w2awm22ATMyAjnres?=
 =?us-ascii?Q?vTvxYBt3vSioRLxVx8chSe90H142GxqvW/8ZLJfz7hL7W2yx6UflsJq8KjUu?=
 =?us-ascii?Q?+MsAiOORzCOofq0Dt0OEZgYbnbSKGtnPOc8JA7t3Hz2gtDbdKws6vh3R4+fP?=
 =?us-ascii?Q?qyKtwh1aW6eLXK+LvPiSQYpgbnlXp0fU9m1ENAUxDWJpgRPGG1QuBDTfdCn7?=
 =?us-ascii?Q?+liQ2ud9wkyyDr7bH/iOQ/zNUmu1hbj1UOOJ1ueuv+Hf0xlFsuGHlZ7kfIAq?=
 =?us-ascii?Q?IGeBYf+YH5mWI21BxhrUDIffrW4RoImddwggngUq1YlIg8OCbwfBQGJsjoXE?=
 =?us-ascii?Q?sDjc7veRfDeNF0wXbgCGrXcsQcgumU8gFluLiqlj0Vii4C4fYVI7i1xutNu8?=
 =?us-ascii?Q?BRA1h1oOfnqh+PcyhKjiDkmVHBiJoJ0xMpe1UyHA1gIYJZGUUMav4UegO4+7?=
 =?us-ascii?Q?bITYvMiF3x0Lyhb9y+s+zZ0KQE/SDCq8yVOs9MORpEuKEI6m1TfXlEaDf4SU?=
 =?us-ascii?Q?EjdJSmzcWCi7LC/kEJfpLDJlhDZBkZ4ScfY2w/dtKUUVulKKSg+jZCsKdlDE?=
 =?us-ascii?Q?fIoM+cS/kjxlZd1KxVTt3po5IaMDktsY/i1yWHQb1MWUmBWB/OUj6EeO5/Ek?=
 =?us-ascii?Q?hXD/0XicjO6qyRbkYGaBR0bstWAuUrUYxJ+0XjAoZVqOgA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CrASw6PcbjlHJgmKiMpVDvfarMB5cXcShEes2pcTuDEsWljqoTpIpxvuH5dz?=
 =?us-ascii?Q?LCZh0JGlk+I1Wnn9hJK5ssXtPQgsQPEAABclc72R7j4mbDlUe/l4DoquzqsV?=
 =?us-ascii?Q?I2jnukNEWmzVOYGJmMks5TNI5+hd8tstY55EkilcBpdPNfTgC6pOXdIOBFVQ?=
 =?us-ascii?Q?8Q5560Ms55ixthTliKp2nQakkgDvpZi7f0xGbpx4rvF3AqdH5LC/lqikyBtj?=
 =?us-ascii?Q?/c5Efi+ilckS/06sX99lxRFPZoIbWZ4Rdt3IlmCsv8htgICeEQb0nG8XRvp3?=
 =?us-ascii?Q?fC7osCD0in403AhEHl4WQDCtvoyoyzRjRV6nmPHInn+EnmoANcEVaT+EPmN7?=
 =?us-ascii?Q?2UP9N5K3naf5MNty573WCkBezU546AhD4+IUxMIkgWRlxad0RpxoHSITJRIk?=
 =?us-ascii?Q?HE7UcBXkf63RBbU9NvlbJPsPzj1rDqzlQ6BiCdilRBfl4KmOBxNXJC332ewg?=
 =?us-ascii?Q?ZERN8CjK64XW+1C4h9lIbmRrWTL1OKP9jz8JEXi+Y2UV5os+orBXLozL/4FC?=
 =?us-ascii?Q?uxSFoF9/4tCIUzXoCKknYs/Si+Q6vLSln31PUKsUzB7LZdJQzHq/CUlUJJlG?=
 =?us-ascii?Q?gmnL+TnSgjUqbNSvDed8zGFyLbZVgc8kRxh0n6/ioQtAffq5EHyUjqAbfAkw?=
 =?us-ascii?Q?kt5u2815n6VG4Tyv4JGWkyE2bPNVrb6nBXrswFHTlkEC0gUzfQrG0TeMFyyT?=
 =?us-ascii?Q?DKl6o2VetTNtQodQOhr4zlXGlW1jt/Upa3mYVKmbvYH1pyAxvBzOTBvNRI03?=
 =?us-ascii?Q?jMrPkOTgXAN2hD5KL75bAtkgv4ReStiB7aswijwU2DhUPSOlgLfpotZM7VdV?=
 =?us-ascii?Q?Uh3EutXp5uC74EG96cjbCEBTi7cZS5rDAJHT+879r/NDweWxXteFbAKOcmr3?=
 =?us-ascii?Q?B2rsZ99Wv0efmj+wCeU2ggTAi6XPJtp+pG3LS55bcrBXldYdUInq6WXTrtrH?=
 =?us-ascii?Q?77oSTpN5Wo12+e0SpnQAcBvU2ZyXk8fy6tQHxXFH0Kr2yi6O2Icqd68PJDRg?=
 =?us-ascii?Q?O9tzCrQ+6N7Jj2D+0SSvV9wMRUaUHHn3Hx4Hw5eg8hTrAzM8fcN7cWzo9W5M?=
 =?us-ascii?Q?70SUd2Zvu6Y8Up/BMSoMiiNSr93GUg1n+YlcViHks5EafPwAdSU4EhCy86Jz?=
 =?us-ascii?Q?f2B/c7c+0n/Ub7SBkFpIEztYqgSkhr+tjhLFD8BJOIHntM/7jPXNtgOAewGB?=
 =?us-ascii?Q?+t5WnzAHCrvcNJ9gyjz176Co+pkHRF90hDpIitZ9LLBu8h7tqwqH0/9Fe/U0?=
 =?us-ascii?Q?uzKGi0hGLjEfKl/fqjI0/OQaATL8gKo2o81H3VREwDrLdsdDe+jldV6Fjj1F?=
 =?us-ascii?Q?qbPhRur+tSyDh0OGdd+a/nBYUTHi3BdzqIDmT7uu7DQOfSwO9zEA/OUCT6dR?=
 =?us-ascii?Q?Ns7MR1MoRmsGZ+50OBaz/am5CgbWIwd5/tDbn9U2dXdkiIPeA3ZVUDPYU9/g?=
 =?us-ascii?Q?97xnjrGlcQoNjvGRlvo7P/hu12OTDCas/n4IYlw3xCzOL9O9cDDXyaNpVpLX?=
 =?us-ascii?Q?5p1NQv0oj0ZQrXwXXoUNAaTeXEFLqkx06VnFr9spor4p0ffHx9LU+wXj3aK3?=
 =?us-ascii?Q?SESAdMf+KDlrGaYPm/iswoC/HJlof/RjRQT7DRRlig8dZA61q+FQ0NnutAa2?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fae62ca-4b89-4ece-0c31-08dd500f6f32
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:28:57.8878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHK1+/Q++Q1oYh57Ghr+6nXIWKt5jIN4joJqOvnTuaSu5YaefPD7U4ZlmKAjxybjDnbSAZg9Do1bPbv9uKkKtGkmnN5XhnOk4Ll25fzfEF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8269
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

On Tue, Feb 18, 2025 at 11:15:27AM +0000, Anatoly Burakov wrote:
> Allow specifying internal dependencies as either mandatory or optional.
> Specifying a dependency as optional will mean that the component being
s/optional/mandatory/

> built will be skipped if said dependency is not being built. At build
> time, the build system will resolve any optional dependencies and add
> them to the list of dependencies to be built. Any source files requiring
> said optional depepdencies will still have to be added explicitly to the
> build by the respective component (e.g. adding BPF-related files when BPF
> support is being built).
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
> Notes:
>     v4 -> v5:
>     - Automatically handle optional dependencies based on Bruce's
>       earlier patch [1]
>     
>     [1] https://patches.dpdk.org/project/dpdk/patch/20231220142152.492556-4-bruce.richardson@intel.com/
> 
>  app/meson.build                       | 14 ++++++-
>  app/proc-info/meson.build             |  4 +-
>  app/test-bbdev/meson.build            | 18 +++------
>  app/test-crypto-perf/meson.build      |  4 +-
>  app/test-pmd/meson.build              | 56 +++++++++------------------
>  app/test/meson.build                  | 12 +++---
>  drivers/meson.build                   | 13 ++++++-
>  examples/ethtool/meson.build          |  4 +-
>  examples/l2fwd-crypto/meson.build     |  4 +-
>  examples/l3fwd/meson.build            |  4 +-
>  examples/meson.build                  | 13 ++++++-
>  examples/vm_power_manager/meson.build | 16 +++-----
>  lib/meson.build                       | 13 ++++++-
>  13 files changed, 89 insertions(+), 86 deletions(-)
> 
> diff --git a/app/meson.build b/app/meson.build
> index e2db888ae1..61202495bd 100644
> --- a/app/meson.build
> +++ b/app/meson.build
> @@ -66,6 +66,7 @@ foreach app:apps
>      # external package/library requirements
>      ext_deps = []
>      deps = []
> +    optional_deps = []
>  
>      if not enable_apps.contains(app)
>          build = false
> @@ -83,10 +84,19 @@ foreach app:apps
>          endif
>      endif
>  
> +    # resolve any optional internal dependencies
> +    def_lib = get_option('default_library')
> +    foreach d: optional_deps
> +        # if optional dependency is defined, add it to the deps list
> +        if is_variable(def_lib + '_rte_' + d)
> +            deps += [d]
> +        endif
> +    endforeach
> +
>      if build
>          dep_objs = []
>          foreach d:deps
> -            var_name = get_option('default_library') + '_rte_' + d
> +            var_name = def_lib + '_rte_' + d
>              if not is_variable(var_name)
>                  build = false
>                  reason = 'missing internal dependency, "@0@"'.format(d)
> @@ -111,7 +121,7 @@ foreach app:apps
>  
>      dpdk_apps_enabled += app
>      link_libs = []
> -    if get_option('default_library') == 'static'
> +    if def_lib == 'static'
>          link_libs = dpdk_static_libraries + dpdk_drivers
>      endif
>  
> diff --git a/app/proc-info/meson.build b/app/proc-info/meson.build
> index 316253cd5d..51315f72a1 100644
> --- a/app/proc-info/meson.build
> +++ b/app/proc-info/meson.build
> @@ -9,8 +9,6 @@ endif
>  
>  sources = files('main.c')
>  deps += ['ethdev', 'security', 'eventdev']
> -if dpdk_conf.has('RTE_LIB_METRICS')
> -    deps += 'metrics'
> -endif
> +optional_deps += 'metrics'
>  
>  cflags += no_wvla_cflag
> diff --git a/app/test-bbdev/meson.build b/app/test-bbdev/meson.build
> index 85b060edec..d41bd60396 100644
> --- a/app/test-bbdev/meson.build
> +++ b/app/test-bbdev/meson.build
> @@ -14,17 +14,11 @@ sources = files(
>          'test_bbdev_vector.c',
>  )
>  deps += ['bbdev', 'bus_vdev']
> -if dpdk_conf.has('RTE_BASEBAND_FPGA_LTE_FEC')
> -    deps += ['baseband_fpga_lte_fec']
> -endif
> -if dpdk_conf.has('RTE_BASEBAND_FPGA_5GNR_FEC')
> -    deps += ['baseband_fpga_5gnr_fec']
> -endif
> -if dpdk_conf.has('RTE_BASEBAND_ACC')
> -    deps += ['baseband_acc']
> -endif
> -if dpdk_conf.has('RTE_BASEBAND_LA12XX')
> -    deps += ['baseband_la12xx']
> -endif
> +optional_deps += [
> +        'baseband_fpga_lte_fec',
> +        'baseband_fpga_5gnr_fec',
> +        'baseband_acc',
> +        'baseband_la12xx',
> +]
>  
>  cflags += no_wvla_cflag
> diff --git a/app/test-crypto-perf/meson.build b/app/test-crypto-perf/meson.build
> index 87dd3bc5f1..fb48d9ec29 100644
> --- a/app/test-crypto-perf/meson.build
> +++ b/app/test-crypto-perf/meson.build
> @@ -20,8 +20,6 @@ sources = files(
>          'main.c',
>  )
>  deps += ['cryptodev', 'net', 'security']
> -if dpdk_conf.has('RTE_CRYPTO_SCHEDULER')
> -    deps += 'crypto_scheduler'
> -endif
> +optional_deps += 'crypto_scheduler'
>  
>  cflags += no_wvla_cflag
> diff --git a/app/test-pmd/meson.build b/app/test-pmd/meson.build
> index f1c36529b4..bbc8d429f8 100644
> --- a/app/test-pmd/meson.build
> +++ b/app/test-pmd/meson.build
> @@ -34,47 +34,29 @@ sources = files(
>  if dpdk_conf.has('RTE_HAS_JANSSON')
>      ext_deps += jansson_dep
>  endif
> -
> -deps += ['ethdev', 'cmdline']
> -if dpdk_conf.has('RTE_CRYPTO_SCHEDULER')
> -    deps += 'crypto_scheduler'
> -endif
> -if dpdk_conf.has('RTE_LIB_BITRATESTATS')
> -    deps += 'bitratestats'
> -endif
>  if dpdk_conf.has('RTE_LIB_BPF')
>      sources += files('bpf_cmd.c')
> -    deps += 'bpf'
> -endif
> -if dpdk_conf.has('RTE_LIB_GRO')
> -    deps += 'gro'
> -endif
> -if dpdk_conf.has('RTE_LIB_GSO')
> -    deps += 'gso'
> -endif
> -if dpdk_conf.has('RTE_LIB_LATENCYSTATS')
> -    deps += 'latencystats'
> -endif
> -if dpdk_conf.has('RTE_LIB_METRICS')
> -    deps += 'metrics'
> -endif
> -if dpdk_conf.has('RTE_LIB_PDUMP')
> -    deps += 'pdump'
> -endif
> -if dpdk_conf.has('RTE_NET_BNXT')
> -    deps += 'net_bnxt'
> -endif
> -if dpdk_conf.has('RTE_NET_I40E')
> -    deps += 'net_i40e'
> -endif
> -if dpdk_conf.has('RTE_NET_IXGBE')
> -    deps += 'net_ixgbe'
> -endif
> -if dpdk_conf.has('RTE_NET_DPAA')
> -    deps += ['bus_dpaa', 'mempool_dpaa', 'net_dpaa']
>  endif
>  
> +deps += ['ethdev', 'cmdline']
> +optional_deps += [
> +        'crypto_scheduler',
> +        'bitratestats',
> +        'bpf',
> +        'gro',
> +        'gso',
> +        'latencystats',
> +        'metrics',
> +        'pdump',
> +        'net_bnxt',
> +        'net_i40e',
> +        'net_ixgbe',
> +        'bus_dpaa',
> +        'mempool_dpaa',
> +        'net_dpaa',
> +]
> +
>  # Driver-specific commands are located in driver directories.
>  includes = include_directories('.')
>  sources += testpmd_drivers_sources
> -deps += testpmd_drivers_deps
> +optional_deps += testpmd_drivers_deps
> diff --git a/app/test/meson.build b/app/test/meson.build
> index b6285a6b45..eb0447e8c6 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -7,7 +7,7 @@ sources += files('commands.c', 'test.c')
>  
>  # optional dependencies: some files may use these - and so we should link them in -
>  # but do not explicitly require them so they are not listed in the per-file lists below
> -optional_deps = ['crypto_scheduler', 'lpm']
> +opt_deps = ['crypto_scheduler', 'lpm']
>  
>  # some other utility C files, providing functions used by various tests
>  # so we need to include these deps in the dependency list for the files using those fns.
> @@ -222,8 +222,8 @@ foreach f, f_deps : source_file_deps
>              break
>          else
>              # technically we might not need this dep, but adding it is harmless
> -            if d not in deps
> -                deps += d
> +            if d not in optional_deps and d not in deps
> +                optional_deps += d
>              endif
>          endif
>      endforeach
> @@ -244,9 +244,9 @@ foreach f, f_deps : source_file_deps
>      endif
>  endforeach
>  # add the optional dependencies
> -foreach d:optional_deps
> -    if is_variable(def_lib + '_rte_' + d) and d not in deps
> -        deps += d
> +foreach d:opt_deps
> +    if d not in optional_deps and d not in deps
> +        optional_deps += d
>      endif
>  endforeach
>  
> diff --git a/drivers/meson.build b/drivers/meson.build
> index 05391a575d..fb48e11eaf 100644
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> @@ -133,6 +133,7 @@ foreach subpath:subdirs
>          includes = [include_directories(drv_path)]
>          # set up internal deps. Drivers can append/override as necessary
>          deps = std_deps
> +        optional_deps = []
>          # ext_deps: Stores external library dependency got
>          # using dependency() (preferred) or find_library().
>          # For the find_library() case (but not with dependency()) we also
> @@ -178,11 +179,21 @@ foreach subpath:subdirs
>              # get dependency objs from strings
>              shared_deps = ext_deps
>              static_deps = ext_deps
> +
> +            # resolve any optional internal dependencies
> +            def_lib = get_option('default_library')
> +            foreach d: optional_deps
> +                # if optional dependency is defined, add it to the deps list
> +                if is_variable(def_lib + '_rte_' + d)
> +                    deps += [d]
> +                endif
> +            endforeach
> +
>              foreach d:deps
>                  if not build
>                      break
>                  endif
> -                if not is_variable('shared_rte_' + d)
> +                if not is_variable(def_lib + '_rte_' + d)
>                      build = false
>                      reason = 'missing internal dependency, "@0@"'.format(d)
>                      if dpdk_libs_deprecated.contains(d)
> diff --git a/examples/ethtool/meson.build b/examples/ethtool/meson.build
> index d7f63d48af..bb2a7fbb89 100644
> --- a/examples/ethtool/meson.build
> +++ b/examples/ethtool/meson.build
> @@ -19,8 +19,6 @@ sources = files(
>  includes = include_directories('lib', 'ethtool-app')
>  
>  deps += 'bus_pci'
> -if dpdk_conf.has('RTE_NET_IXGBE')
> -    deps += 'net_ixgbe'
> -endif
> +optional_deps += 'net_ixgbe'
>  
>  allow_experimental_apis = true
> diff --git a/examples/l2fwd-crypto/meson.build b/examples/l2fwd-crypto/meson.build
> index c21722b85c..2a1070707e 100644
> --- a/examples/l2fwd-crypto/meson.build
> +++ b/examples/l2fwd-crypto/meson.build
> @@ -7,9 +7,7 @@
>  # DPDK instance, use 'make'
>  
>  deps += 'cryptodev'
> -if dpdk_conf.has('RTE_CRYPTO_SCHEDULER')
> -    deps += 'crypto_scheduler'
> -endif
> +optional_deps += 'crypto_scheduler'
>  allow_experimental_apis = true
>  sources = files(
>          'main.c',
> diff --git a/examples/l3fwd/meson.build b/examples/l3fwd/meson.build
> index 74144c7979..9a9f2c6d40 100644
> --- a/examples/l3fwd/meson.build
> +++ b/examples/l3fwd/meson.build
> @@ -18,7 +18,5 @@ sources = files(
>          'l3fwd_lpm.c',
>          'main.c',
>  )
> -if dpdk_conf.has('RTE_LIB_EVENTDEV')
> -    deps += 'eventdev'
> -endif
> +optional_deps += 'eventdev'
>  cflags += no_wvla_cflag
> diff --git a/examples/meson.build b/examples/meson.build
> index 8e8968a1fa..14b8aadf68 100644
> --- a/examples/meson.build
> +++ b/examples/meson.build
> @@ -98,12 +98,23 @@ foreach example: examples
>      ext_deps = []
>      includes = [include_directories(example, 'common')]
>      deps = ['eal', 'mempool', 'net', 'mbuf', 'ethdev', 'cmdline']
> +    optional_deps = []
>      subdir(example)
>  
>      if build
>          dep_objs = ext_deps
> +
> +        # resolve any optional internal dependencies
> +        def_lib = get_option('default_library')
> +        foreach d: optional_deps
> +            # if optional dependency is defined, add it to the deps list
> +            if is_variable(def_lib + '_rte_' + d)
> +                deps += [d]
> +            endif
> +        endforeach
> +
>          foreach d:deps
> -            var_name = get_option('default_library') + '_rte_' + d
> +            var_name = def_lib + '_rte_' + d
>              if not is_variable(var_name)
>                  build = false
>                  message('Missing dependency "@0@" for example "@1@"'.format(d, name))
> diff --git a/examples/vm_power_manager/meson.build b/examples/vm_power_manager/meson.build
> index dcf23198eb..6fc081b06b 100644
> --- a/examples/vm_power_manager/meson.build
> +++ b/examples/vm_power_manager/meson.build
> @@ -8,17 +8,11 @@
>  
>  deps += ['power', 'power_kvm_vm']
>  
> -if dpdk_conf.has('RTE_NET_BNXT')
> -    deps += ['net_bnxt']
> -endif
> -
> -if dpdk_conf.has('RTE_NET_I40E')
> -    deps += ['net_i40e']
> -endif
> -
> -if dpdk_conf.has('RTE_NET_IXGBE')
> -    deps += ['net_ixgbe']
> -endif
> +optional_deps += [
> +        'net_bnxt',
> +        'net_i40e',
> +        'net_ixgbe',
> +]
>  
>  allow_experimental_apis = true
>  sources = files(
> diff --git a/lib/meson.build b/lib/meson.build
> index ce92cb5537..76bf849852 100644
> --- a/lib/meson.build
> +++ b/lib/meson.build
> @@ -134,6 +134,7 @@ foreach l:libraries
>      # external package/library requirements
>      ext_deps = []
>      deps = []
> +    optional_deps = []
>      # eal is standard dependency once built
>      if dpdk_conf.has('RTE_LIB_EAL')
>          deps += ['eal']
> @@ -171,11 +172,21 @@ foreach l:libraries
>  
>      shared_deps = ext_deps
>      static_deps = ext_deps
> +
> +    # resolve any optional internal dependencies
> +    def_lib = get_option('default_library')
> +    foreach d: optional_deps
> +        # if optional dependency is defined, add it to the deps list
> +        if is_variable(def_lib + '_rte_' + d)
> +            deps += [d]
> +        endif
> +    endforeach
> +
>      foreach d:deps
>          if not build
>              break
>          endif
> -        if not is_variable('shared_rte_' + d)
> +        if not is_variable(def_lib + '_rte_' + d)
>              build = false
>              reason = 'missing internal dependency, "@0@"'.format(d)
>              if dpdk_libs_deprecated.contains(d)
> -- 
> 2.43.5
> 
