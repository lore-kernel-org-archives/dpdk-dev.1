Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76308C5AD49
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 10:33:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67D1440F35;
	Thu, 29 May 2025 12:33:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2FF8B4067D
 for <dev@dpdk.org>; Thu, 29 May 2025 12:33:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748514799; x=1780050799;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2QS50jEearhLlFZh388yZepVADmx5ezOwZu3+APthJw=;
 b=AoSlbt6OjTbO0PX7M1B2LCbE5VTRh/IRF41jTF1sAmWpKUwRHhdrFHlt
 GA505mAuXZQ73gxwzZ3DOHQZZZQtI+q6sfwaFOvkEpMt4id3KCM8jegzZ
 pBr0NmdTwYfYGEk6GxND7vouuA7rmRW15qCXYv/jTq66k/gzIF7pK4akZ
 JmqEfoisrovEBV3qOvzQGPPVJ/vfN3Rn5Bl9Kp5WzLb9dx3HiuIXuDhex
 c5Dh8XZD0xV2fGdS9MlPQPGtdbcy4ACWEYPDZeLdKsM569/WKk138MRBf
 4oMfwDRFnAJoxdFjdUP4gOIO6lMaj05xBqJrHky8EE2GaQAbOa6rZgP1S g==;
X-CSE-ConnectionGUID: f0ItTsJyR1WKlunUR3zqpQ==
X-CSE-MsgGUID: BDBP5NvnTfCwXx3rE5iEwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50446826"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; d="scan'208";a="50446826"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 03:33:17 -0700
X-CSE-ConnectionGUID: 8XoxMXjlQS+F8aQM2P/RVw==
X-CSE-MsgGUID: y9OuBeo1RI+Js7w927jsVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; d="scan'208";a="148676495"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 03:33:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 03:33:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 03:33:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.77)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 03:33:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLFNcKdoqyutEsLlJGhM8Ady1EvBu1ly8e/3TWGI/5tlML/5B9avs/cnecEeCu2SvLOsoNzLM0lVivhuC6D5/dMwzj//IQrM2GR0lmeIGeRKaowjaBScDfqyqOZH9Qsl7B55QrvGKfRszKGnDbbmzd+L8f+r3NPho7tTM2D5gpVEv8l0E/NCqXpHY7u3+PMrchNyooEfsJBEQTFUCtENcm9a/Nyekcc2iDGGJ5/Hl45TRHH0615ObjzTos7sSWQdkrszfewEvCMDlpHm1K3e6dzEOh1PNwyY1JYi+HWyEgoltC7J32ML6YcEN/8iRqyoYfio4OneM4CKrQmDKtxZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mPXywwkQbQ4dWx0e5XuYNonffBv9gsXseLa9GYt38k=;
 b=N0zVNIFyqPSkXvqqJdmnCVVS2Y9q27hEB4ZpXLir7g9M91MFJgCchumcACFKOgGkIN1Xt3S9AxpYEWouBBM7gSEjjlVCh64vsQed25JLWtuqlvVGBBjyYyR2fCIRZPdQPLjJPiRp1C67KKiWTNPiYcf4C4rVE6ocqGacuYpFxqqODIVUwdD8vK7gg1G6n6aynCloxQCMK0lPFnVhgMKaR/CLqAJwc++rTH0kdZBWu42j65YWMevn+ipKEgu221c72aTwmXB80GYkcmcbSh8Jg2s2hrZBTMdcO2FOknrMRDqZRzWtsrE/KO3e2hfED2gbjkEFA4+oFGzGXwMwXlRZ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 10:33:14 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 10:33:13 +0000
Date: Thu, 29 May 2025 11:33:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <Vipin.Varghese@amd.com>
Subject: Re: [PATCH v2] build: reduce use of AVX compiler flags
Message-ID: <aDg35D8FCmbtK5AB@bricha3-mobl1.ger.corp.intel.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250527162716.319713-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250527162716.319713-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::12) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|LV2PR11MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: c92f9df8-47dc-41bb-6dd8-08dd9e9c375b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TrIOQa6lUV5GB+nhYN5ZSS+MMXrldQKVc8/vN7BGZ9KqF4tW5HQPZas6vvRP?=
 =?us-ascii?Q?wAn4jexHFMzpOyWt1DjiBha7Orfk+q7r1ART8uMFR3SyBFIyM7ONAnWK/kpj?=
 =?us-ascii?Q?GfYX9LmUPKKqRmJdj3R5/WguM9eXVLL+eBnJ0E6HJt+rY9A69HMtfqvlVR0p?=
 =?us-ascii?Q?xzTIhBm+tcrTKX+Xl8Y2WMr0FmBpFQzzwJJIJKfuknGEtd8bGmQkk9Ty8tVm?=
 =?us-ascii?Q?X/5EMzNDkWFwBcJ90W2bKHBV9pkcu3Dn/197qL/mht+sH9ViZ9PwFKrrErq6?=
 =?us-ascii?Q?TCMY3TpnLkHrSZeO4GG7Vydd1GMIM6vOVGOj7EhjxdkLpQQ2Aa/owb8rL+L4?=
 =?us-ascii?Q?t5v2m4rXS8jAE6nGgzwQXNn92EGhWIX4hfBD+MhwcQhD8IwOj/DI0lkl7AmH?=
 =?us-ascii?Q?zjiYhvZuLBhAJI3tdiDIBIizXPVj6V96vV83GESlQxyPBlUaI43lml1hyEgg?=
 =?us-ascii?Q?qVPG5V+qHjSmeayD++6Nq5ELTHX/8/vfK1EoMog5UGCHjE5NWpKuEw/ACikF?=
 =?us-ascii?Q?vkjNtCY8rslw/O/ylYYP3G1fDk8MqhEkzDS9GuvO/Aps+0aiCVEF43d/bqt7?=
 =?us-ascii?Q?bnOsPCd8p1JmSz/vAtR58gmNjoMBRjvwusXjIL2taJNqsSSkJ7ALDseV05uA?=
 =?us-ascii?Q?craDu866LCADjkjI7NvYCadIHlsWAcExiwjgcDsqD8r1ujjInJFKjfq3ixpM?=
 =?us-ascii?Q?dtxQK108Yn67sJapxGV79HJXPezsdslzx/CiNn7azCaujvoIOsqthIKeWru9?=
 =?us-ascii?Q?tkLVs8Crqw3kq6E7HH79gMzsPUsVhZE88+/m2/AQqU+0Zu1ZrFbr4jLQc5bM?=
 =?us-ascii?Q?0W4jdvw0kE5/yuNM+i2pRjiIV8H/9ZkbZJdN8RT1aIqW94v9Im0BXcliZdE1?=
 =?us-ascii?Q?JrNL09v+6xSTV5g9D+BiFcGHCSaNwObpgOZXvT0sjSLVFpDxy3V3Y/XzgLzv?=
 =?us-ascii?Q?pVf9Uq2k0ATIlR6Ehszcziq7ml6qSKd5e3f2W6GaccRwk8RMUV+c9qokWTbA?=
 =?us-ascii?Q?IH2jnllGv3H9l8yBt/GAXoj45uuNHPgNDwiVIpcHBPq2NQCc2LAPfsRr/j0q?=
 =?us-ascii?Q?h/JxLnFdDSqhKdger0642U5ZHeM29YoXQ/dD5Tm7lXHPOmtNKGyl9UXqv2qK?=
 =?us-ascii?Q?MXPCn/eWQ2ceOHYnUdHl6dHl85gLUBKxEFAUEg3peAVoH4S6aSf+BCSvTn3I?=
 =?us-ascii?Q?EwnRxdZkeJjUfxkdDz547nMZLdtCtRH03XTFRFqFgh185ZPDW76q5j+yWLPa?=
 =?us-ascii?Q?foaL5izYo3U9ikbgPGlFCQwSttqfyG8ySq1I56r6FJclebF9DfbDjv6gsVBo?=
 =?us-ascii?Q?HlwThcmo7m1CjQhC2A5YKE/MdcchcBsusv1sVicrY/8MqxhXasOIBM1GK8bB?=
 =?us-ascii?Q?oVaW/YwuOM5rdebNddU7Ii672PxckNlZBTeoiE/ZTk/F/fd6uQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?skq40trx34FHifGD/canTZRQh4ifvqPuDpsGidgCyhTDE4Atk22KCwaOtc8b?=
 =?us-ascii?Q?+AnApEWuMA7JVXOfa+kJbqEB0bLsrNOpBU4A0Oih9Q9JhTBG4BEvgTnxr1W9?=
 =?us-ascii?Q?/G6ctUnnp9SAtYa1g7WC2t9LbFfaqziJc9vo9Og1jsLDvj+zU9o6fj40uEUh?=
 =?us-ascii?Q?asnDK4hvN3J2dssA+QBQJyJzSjH9ASz4xSkckm2TOK7Hqu2h1M1LlsqCiuDu?=
 =?us-ascii?Q?/PmECcASuNeaIOlYJdyD/KJKo6PwMnqdezJ2H7SfC4w30X8+Uavoxo1M3G+C?=
 =?us-ascii?Q?NqwALcCkDt/1FbCtDhnnCATOa6BgW0Q27zuU6gISiENwqgeRGXX0zppyJhug?=
 =?us-ascii?Q?fmHO58Bm1SyXN8715DzEt/au/pQyxxHNPvIg434ljuPPAmXID4TanPQnTXxK?=
 =?us-ascii?Q?ocokWhY1DHXwBaWf52a1rgb/wVsrXCILRIQ3BXAidIMr8gPY9pmZdvYFnLpB?=
 =?us-ascii?Q?VkKCmIRrwkKjECNFDggUyxyurrdgxmE4H/2X7O7p/niVw8SwnDqGlyOpPziC?=
 =?us-ascii?Q?TW75hbaFhDEEYHf+0OUywp/DVvRqMdcByh8uoMRTiN7Lvr1xYZyuHgANOiax?=
 =?us-ascii?Q?+DkYxpmQggoLm2BBwm2AToWU0BRrbO0LTbi3B05jWcNNMlmWaibs9i0o4feV?=
 =?us-ascii?Q?TsXCr800Mm7wsKB1X+f5Sz7KDeyTZf8MUZ+rLd4xpqmfmj9tfyc1s01fzwYY?=
 =?us-ascii?Q?WvPSqbQ3QH8Uwd+8UUsj/IE1rGZ9bdvCln0jLEpx95KlntxEFVYIOyckQ0ov?=
 =?us-ascii?Q?X7UBlRJFlbkibZLxlY3Jx9rHxKZEPO/AHAPj4JEd3R2kbFTR9c5oYVPSJ4n6?=
 =?us-ascii?Q?p0qKibd6VNzndibsQJRxR99WDhjmHovIP+g5gpOaZ9uybqfB4fBwoZPcX+xi?=
 =?us-ascii?Q?NTauaBYJathVZAfAHSf/iOUov0J23sskbpemr62nQYcE0Lb5heOsu9yaqRTk?=
 =?us-ascii?Q?OlKte6t/ifU0mJZbDE0WPq9trqBiukF4yicq2L+TXFPJ2tP9nGCqh1SyICnT?=
 =?us-ascii?Q?58NXyfR5wCyqXESuCAsUCPsxHoBGKr6AsJOU/BpjCKgM3lcHerg0EnL/Y7xU?=
 =?us-ascii?Q?C7XER9vruX1uxGX5HvgnkftzqKQWOuZ09Ws9IODv9qE3NqjXtaS2DZDRKlTj?=
 =?us-ascii?Q?ypQFX251S0yVsxMW5LZRk1/A1E3zzCgkNTuKnuDvUqYadbjd1tGrUpWmb5d9?=
 =?us-ascii?Q?FM7yZmz5Rw7ku1qSKkniQDhRtnukoeqsggdxMjN/ZjItrDqJnGPCz+rrZVXz?=
 =?us-ascii?Q?sDkT4XZ6c8ItE4isBq0l0X3YSYIgZAA7yJjmD9qmoIOUh/+E4XfnUltNI9FL?=
 =?us-ascii?Q?oQuh8CVGvKOLU8e+nuUTvu6LtXl+1k1MAXSbBmWLQc+gwt/vUprdrgW6kQvY?=
 =?us-ascii?Q?3yk2z8beE8Ttr05C6NAuW/TOeYgA8BX1OfipPKfO7RbBIh9iuNu91mhY9nFg?=
 =?us-ascii?Q?9JhK00R/Hu8Ox4cudpxCf81sO2ew+PvVymTG31PBl+F/E6kKddNvJqZRZDwA?=
 =?us-ascii?Q?m+MPNGHjp55lS5HyhDsFg58/kw+TGI/hllQcIdXTrJB9f3RbjFH8H5jd7rii?=
 =?us-ascii?Q?DEsmbRYSf+S9c/8BKJvO65sUf4ZCExkoy4vyCw+qGYxJ0leOPOefeU1KpPQo?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c92f9df8-47dc-41bb-6dd8-08dd9e9c375b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 10:33:13.8757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5Ye8ibOQ7DjIEz56w3f3tFN680LorMVJoJTrrieOLm0illU98FPc+9Fi1sDSfGzQuZpaK+RPLf96h7amBwsjymeKt8jg4zl2KIRgvdZqXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
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

On Tue, May 27, 2025 at 05:24:56PM +0100, Bruce Richardson wrote:
> When doing a build for a target that already has the instruction sets
> for AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or the
> skylake-avx512 '-march' flags, as they are unnecessary. Instead, when
> the default flags produce the desired output, just use them unmodified,
> and don't bother adding in extra enabling flags for AVX2 or AVX-512.
> 
> Depends-on: series-35006 ("doc/linux_gsg: update recommended compiler versions")
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> 
> V2: dropped the doc update for the minimum meson version. Based on

Mistake here in the update log - that should read "compiler version" not
"meson version"
