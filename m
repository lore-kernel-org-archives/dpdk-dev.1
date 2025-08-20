Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE834CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 12:15:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02CD4402CC;
	Wed, 20 Aug 2025 14:15:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 470924027D
 for <dev@dpdk.org>; Wed, 20 Aug 2025 14:15:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755692131; x=1787228131;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wYz9uq1/0a9dspAKMzxVU2SXIy552psyVtS2W+McrxE=;
 b=PmRswH78of3EZSrSE8mLHY1GJOtOZC1x6xxYu1q00cDM+zq24ca8HB7O
 IBy5ZsXazE0tNA40BwdfbNZAulKctvoStXHgkysKFczzAZLYEr0w3o3b5
 9+07A5/FWjVlAxznSFfNrR3dKCnTnGAYhGMW+aZAdm4ygTPTs5aBvk6D2
 EICmzBsrrKrWk2kCbolcRcpVw5srqQsbtH2aG6icpCL0GyNDpvXru3wDQ
 f8O8GujlSsRV7Lr/R5UYt5GWTJIAl98e45ysXiSEWliNyxsfTQoadB22t
 WoDCuHs4YkC9IPHTwJivctrLq48/107xHzSFiOYuaCpgtWwG/d5iHm/Us Q==;
X-CSE-ConnectionGUID: 3c0+BB3oRyOtP8eju12KeA==
X-CSE-MsgGUID: ZMyX1c0+TnuYAYklIHEFmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68554391"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="68554391"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2025 05:15:28 -0700
X-CSE-ConnectionGUID: m5S/gcakRVOJWPhxtNLx3Q==
X-CSE-MsgGUID: D+FtLXHlQu2zO33ekrTm/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="198977015"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2025 05:15:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 05:15:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 05:15:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.63)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 05:15:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3rP06JSDpbIdtiaZQxYd0XOgRUsrW605aphS5dD8Kwta5tUd2gZnM/djCCcRSJ4ZCwOL9Fo2AnZxNVA2HZ42upVQna4Cnsk+FZ0r1rmtIirlNt8BRjUfSSLOlEhAqtq+n3LkgFrgFObXjhT4/fWPQRRbOC3kQS+87KzoAFbwcv7X9DHzKC42Gm4bu0E8fOPgEsfEZIMRL6N8JjZXDQzkS8cQiSdDmaVl9nPlQF5teekpIbVqKim1RIar7fBpUgz+5bMKjJ5YLFoZ9++i5ErtKfaBvO3l38SbhRjMBaugU8nMbyy+75eDByWnfrg9S7hBPSAOyA1qIQO4gfnMG1vYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzXTweKJrH2JJs1AlD0RdMINBD4oBDBDZpKCUVs2Xo0=;
 b=meebjOlKbc0T6k3v4h1oJ7PXF+8WXZm4ZRa+BKNpjGwdJmcOoc+EJTwqMKNbhi6o3BFFTgPwv+LDpqM3mkjoZXLFV1+v5iJNlCfLOnpLbm60Y+ClFhYxfL2H2RF73B3gRyDcxVj9RjPNNz0W1B8FneNpbIC70j71y41Ai3P0O7Gm+cN03jbqOPdbh11dtRmvEt9c6xw5TxRTGV4Wgbu9iEH2hJN1QpwWvymsNlBvQcu+6f8cnkbmsjuEL/sBjN0tfrPfyZSIJiKvWzXGzGnZ0KHaIAXaGrEUpOpmRn6It0L5maqm8VUQpJttVktBeK1A04YoOsow2qiYNckq/0vRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7369.namprd11.prod.outlook.com (2603:10b6:610:14d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 12:15:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 12:15:25 +0000
Date: Wed, 20 Aug 2025 13:15:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 00/15] net/intel: rx path selection simplification
Message-ID: <aKW8WPMhdSXT5SyL@bricha3-mobl1.ger.corp.intel.com>
References: <20250818105914.169732-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250818105914.169732-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0345.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fee1a74-848e-4a1f-301b-08dddfe33e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l6zZ7pjeXMdvwMYWLmbzDNWtOfMFINWIO8cesQUY/u2sRWfzwM7Chmlxlbih?=
 =?us-ascii?Q?Jd9CgHNlYu2HJCN+qLsKvn8yHOsA51341oUknVhAoOuxD3axB8t/svPFn3Wt?=
 =?us-ascii?Q?t6ZwmoSaQwNb/xuTmYUWCdhkNfHhb9UoZEcQu4qSrqs/cNh1eBi8XXBcfFPy?=
 =?us-ascii?Q?lJ3g21LyXGSmZ6ViiGUV0jrYWmtYV/JC5eTdyioO896UjZOTWX6eQJWRSzZt?=
 =?us-ascii?Q?4yFpWovo3V7jeKg9LFylDvnnY8tzJ45PVPcTjEjdp4SZpGZKnl0PF5Lx8rFx?=
 =?us-ascii?Q?P+FVHTKhWv70XJiVeDY19XcEcpCbx3NZX8HP25L0yEybStFpUT0H5PpmmtQn?=
 =?us-ascii?Q?0ZO6fmZ+tsyccWBhu+Cb7iO8uebU4sHjPMhpwsOP3vj8MCjG07ufAxCQaYOk?=
 =?us-ascii?Q?+o56o1cF8vqVGq4xPmT5muqBLYsoMRsomg0QAm/q4b5y/iP1dVZYIa80KRDY?=
 =?us-ascii?Q?gax76KzwIMHPkU+ihjH+BzkM+Jz7pGojUAYpMnkI5tG/5dwfVmT057cBko0v?=
 =?us-ascii?Q?s05afnRXEpZ6JYP4ejvGDl14tyrr2VjUieDXLqhwuO69mxHVHksKsZ8+RwX0?=
 =?us-ascii?Q?VK4xnaHsFdStrGBPO3hCCcBlYUrxb7z4xhBsaezpoqIV6sqjmAar3v8VeD5j?=
 =?us-ascii?Q?a5xsw86+k+M0rXzxv6ua63dZAi8A4e6TjlrMZocOv7dT+fDfAHvPIeckZkaB?=
 =?us-ascii?Q?LpNavgiAZvW1zdZPrTW0uLOpB6jgItK/AUk2dr4o3ZltyY43DGIPqsvWfZLV?=
 =?us-ascii?Q?45XkqxNwrV9ZbjuZkwHkBisNtkEdCnZTmN3ornXpSbzvBP43YoyYekGGzgtx?=
 =?us-ascii?Q?H0mRdye0AUPLJVoa9QquvvFWyAgc2H4EmqapCvsGhL/c2LhGEMCT2MnWsld6?=
 =?us-ascii?Q?BTQpqWuqb11FVwsW8LLd8mar5UECcJIpRDQkKYTCaCoDv/Ksy53+dUpcIJDt?=
 =?us-ascii?Q?Ng1aHkhhxVN6OBiwPOznUS7KaPKlTejTGJhTSicdVT5Q4OEhWk0FhazVzcXY?=
 =?us-ascii?Q?gbEUk1fhDhwVQwGMWPPk1BdiiCW4ctnBMOMkXzwhjWVC7ge6qSSHb1VgjKsq?=
 =?us-ascii?Q?FlQJ6gCSsVBR1H2t11umBN0NUebSnotcPLI3WhNo6fMzQpsJclNiHcZnWZRt?=
 =?us-ascii?Q?l5nkjPocgZSdmW3sVY5n6Pq14QS/zTxO6jZc3fNrtchiV6+1KS7vUF+mn7lR?=
 =?us-ascii?Q?cVm/Uu44AABB1SEPsNYORizpFw69NnMwMmO1B/7Kx772ORFlV8JA11hUMt91?=
 =?us-ascii?Q?tWf6NLZYht+rhTvbDc8rL6U6UbwFlKKGU6pVzfxiMYRi8mOSphKICGZ/95Tg?=
 =?us-ascii?Q?q+iDoCwvK8RsilkO1xi9YoCdeNiT5B/2+pLUuqeqpa+OfFMza7aNT2wVXU6t?=
 =?us-ascii?Q?5IB4pI1fmrPE9RT2kX6mmyPT4NFLvSxaQ0J4fJcQRNY7tMh7nuWVB/jd9gs1?=
 =?us-ascii?Q?IlnfeZlwjgA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?odBwePmQLKlhuxomUrLiNpJh6LjFNxxlwBqO4/LMcnbyfLbb2rN2Xy6kJCSR?=
 =?us-ascii?Q?dQ/z0yc420Q6yoeFRq/FHpocv9tEwjBpohfMtAqoSBATAIDCJE7ObVbWUJRi?=
 =?us-ascii?Q?mE3Akkr36pD/UngGedvatkr0YBdlE6qkUnF/0yjJ2SSClMjQzgYqltihCcs7?=
 =?us-ascii?Q?/Ldj3wgTStI9m8J3uUePIn3hx5CiySZtsY/5Xi3xf7AeCwgMoWsr5dgf5uuJ?=
 =?us-ascii?Q?TrI53MHI2Bh32E36KWNc17du56K4WuFVAXGlL/RW5b0hXtY8CyxveZOvDJy3?=
 =?us-ascii?Q?1F0zYVrkejWbHQe/f1x809VvU5MJY4Nt6BE4p4e6P/9Rfi5QkaoNz0DHxUl0?=
 =?us-ascii?Q?ZWYD4jHz+FVm7xLH+uyvJ/JUW7PwxZ88Y8ayUKsW7g3wO9vVPGZ3xoqpVyEc?=
 =?us-ascii?Q?tqLHQ0BVbIIETd3LREEhSP3brGsFKLq0dbcaiJLuZ2oZC/NV21cOnPixdKeO?=
 =?us-ascii?Q?yUp8DK+ZyYkVizGkR4BtbSmT/vKxxOVDJiWHWto21Y2pDP5/6l+u+lGrhyAm?=
 =?us-ascii?Q?fvlxAPH9Hh7TszeEd65ci6Aj8Exe876G+LdbHnH289LYhBC7+eBHLdFnxbi8?=
 =?us-ascii?Q?TdyS7wPKtjk3ghUGBC6B/2p1jXhTQ5eo5+XdSsQuBzJoTi6r4BkOeP+O+8ct?=
 =?us-ascii?Q?qZXTgXX4mw4zd9Fke0rytAr30Yb/bhXZG9ER9mK6s9rWx6wbgHydwL8Szuie?=
 =?us-ascii?Q?/LZTJTT2o78iizGzgvwzpDzZ4wFlCveIsg9p9To7MWbrgrNKgocuEAIjRsVT?=
 =?us-ascii?Q?X0Vv1rp7WRODCMElTcAPoUcaVTLt60hHNvVpZRKkBs9A3K+MA8bK+OBZqfpY?=
 =?us-ascii?Q?sPuo2VfHiLneim1uuSm7SB2Ox9JH2wJzg7eCWA6UO/KSWfqXqs/A9vQeyUlK?=
 =?us-ascii?Q?u8K8KIi8MqznDkz/SiuECrw6Vyf8XEpFr7eAgs9CslCa2/3KXKRhNb9PcQW6?=
 =?us-ascii?Q?0d0pOzS2c7u1VKCOYA8Dz+1NeWsm4759/XdL8Y3ckBg0b37BClBe3fcDiGf4?=
 =?us-ascii?Q?eCobxxtgZZV9KxyAdkn4JGg8T4fqD21r7nwdySgeQy+CavFisg6j8n57q75c?=
 =?us-ascii?Q?ghwjz4oqPdGsqlgyPc7pyWRBs47PBMjBlyNWV5RO0hBuescDwZGc1t17ZCRB?=
 =?us-ascii?Q?aB7SGWIoCS19Nqt4rfAK5U1QfKdnBSWj/s6fC+8ST5I0uKb3Rcd/QwNr36EX?=
 =?us-ascii?Q?QHWFvo/Ju+U3BZHYng89m8/nKsmYVXRI9w5Hr39Sq2/6Zmhx0IZJoQ0y2gP5?=
 =?us-ascii?Q?o/24iUliGY4tsYHIcMVCrco+mSuqsv9aBbM5tZmT/cNm9xtQ7BSWwJFyj/KC?=
 =?us-ascii?Q?gpAxvDZVlbSUVbhTNBQfA4x3nPMskUTeJHrwZLzAa/PTQvG/iv9ngLlWKnhl?=
 =?us-ascii?Q?YHfRkUREM9kjJjXJ22VdlAw3bPhZYCLt8j6dxWF1Amf1WF3uOBnlLB+U6J00?=
 =?us-ascii?Q?tMdqNDQ7qJoFdLEjm6B1fD2lqX8iwrSlnpkR4utDYD9lOswjr3d9CdVOyfI4?=
 =?us-ascii?Q?srbNaxjgKzKNh3kHJSeZsP8lwmOQNf1f9vhgNU7dFz64SXkbzUoEHfB7cbTQ?=
 =?us-ascii?Q?2i3DTTQ3syeue5Mf/hG15aapHqGgovuKLGXBMlq9tvmgaFBFPlU2oDcoiWc7?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fee1a74-848e-4a1f-301b-08dddfe33e0f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:15:25.0444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4mQN58r5q/YF1AXhrU9LKz+0lp/hL5UI+RvkW0tshJGGizeX/II1SZpgN6x1t8yGlHi/M5n4KALRMUvCuDpt8x7JpBAyu+kDakCYYPsNXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7369
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

On Mon, Aug 18, 2025 at 10:58:59AM +0000, Ciara Loftus wrote:
> This series aims to simplify the process of selecting an Rx burst
> function for the i40e, iavf and ice drivers. Three main simplifications
> are made:
> 1. enforcing the same rx burst function for both primary and secondary
> processes.
> 2. using a common function for determining the maximum SIMD width based
> on compiler flags, CPU flags and user-defined limits.
> 3. using a common function for selecting the rx burst function based on
> maximum SIMD width, function features (flex desc, scattered, bulk alloc)
> and requested rx offloads.
> 
> v3:
> * removed arbitrary defines for features and replaced with new sub structure within features
>   structure
> * removed unnecessary initialisation in the path select function
> * added error log for case when tx simd width is invalid in i40e driver
> * fixed ice vector offload mask to excude QINQ
> * removed unnecessary #ifdef CC_AVX512_SUPPORT in ice and i40e driver
> * changed == RTE_VECT_SIMD_256 to >= RTE_VECT_SIMD_256 in ice driver
> 
> Bruce Richardson (1):
>   net/intel: introduce common vector capability function
> 
> Ciara Loftus (14):
>   net/ice: use the same Rx path across process types
>   net/iavf: rename Rx/Tx function type variables
>   net/iavf: use the same Rx path across process types
>   net/i40e: use the same Rx path across process types
>   net/ice: use the new common vector capability function
>   net/iavf: use the new common vector capability function
>   net/i40e: use the new common vector capability function
>   net/iavf: remove redundant field from iavf adapter struct
>   net/ice: remove unsupported Rx offload
>   net/iavf: reorder enum of Rx function types
>   net/intel: introduce infrastructure for Rx path selection
>   net/ice: use the common Rx path selection infrastructure
>   net/iavf: use the common Rx path selection infrastructure
>   net/i40e: use the common Rx path selection infrastructure
> 
Series applied to dpdk-next-net-intel.

Thanks,
/Bruce
