Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FB2C77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 14:13:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A70DD40B9E;
	Tue, 24 Jun 2025 16:13:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 2D0F84026B
 for <dev@dpdk.org>; Tue, 24 Jun 2025 16:13:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750774418; x=1782310418;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BgBF91CwJiFzqideu7/Oyh57J/O+QHSWZfeOVtOQyIg=;
 b=kyLmoPUPEnrjfwDiKFGZz8HlvE469dU6g0ggXiFsViTderwq3gTXyNWG
 FJeMKZegMNfLeyduHJCgNBQNebFzQ09sPmKJz87uEOWOTWRFC2grQlZHn
 fhPOg3//Qne1j7umZruZpEKzSizPw9yL/3Op6f0iRZ1wmtByO8SHFvQY1
 1qeh+EisNx2nvfXzqKAUT1ZvkqX2nGc8VEZiM9vO7Sh3e/4ohjaNoDPDO
 +697q3MHudFnl1xlmlpvEI3KxEJ5YP18v6nmZIX28j4VZr3SH0dUuY5dm
 WMpU7jcEX2q0zT/Xe8p2oJUgsoy/1DFYvukc9UDO7UFQbOII4nYPoEFa3 g==;
X-CSE-ConnectionGUID: hLkuTurITiK4FUkrWY6PMw==
X-CSE-MsgGUID: o9pNMlLqT2OOxTNG5Tl5mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="70584666"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="70584666"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 07:13:36 -0700
X-CSE-ConnectionGUID: zFEzgxntTgKJS5wxcRGFHA==
X-CSE-MsgGUID: 9sfOiUhVSquOyFCXlQfmpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="157419160"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 07:13:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 07:13:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 07:13:35 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.57)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 07:13:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8sy0fijMqBV+1zTrnuoE2/lyLWqqVVDbhgE70+wVUaUs09+EqUYRt8vKrV0MoASn8al42ca4fHLXiTH9r0ClqG2jlgx2ZQDNwSTYcH6Vlagbyudq4WVDt+/4F3sOvvngQn6TFgXEks4C3t0rCP7zn41wyjYDGg/dDIlFBScsdSeGGajwAaJWD9UY4L9elIlcbo1tRSyX1SPmB3YbJFwFRWO0FjCb2ive25gUOuNQt9P7PwGcI5uSTi24Cni0TnogY8zQ6G1M3aQHe/YwJq1YKXRN91qgi8JgzkUvE58fcGEzHYrIHsJ6po5SfijuYTnxVFG4958Lo/aQ3O0mTOT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKa+eGuyLadrJ5G2jkX6YGU0z7HY3MxXft+j/cgNd04=;
 b=O8JVemJ+fgrM1XnOukPX7XoRzOJ05QdR8bbbqHEA1q7kUyHOQGmlErx13/PJEnRSMA1kufmDlf6lMrdhTlNYTkvPKKcDPJn1cDjxmKJVY+FF4xUJeFwQy7+SGZlP+K8jX99i1m1KY2owos+0DAaZPrNMUkkXYTnrfnvsywQwbAU6Nk93mrdVzbjbgpKqRwNKYJc1UxT2eGqnrylPiFdipbH+wSlQQUb0dyvbWYEVLYQs/Wj7XU9LlcwE8b8Y8MICnDrMs+0PaLpnFc0WiuBGfbon1La8Mb87MM4NBTf3moh5FcdEKkX6LNmNe5CQsvvPd4D+visJe6FXUtUyPGHsyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7815.namprd11.prod.outlook.com (2603:10b6:208:404::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 14:13:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 14:13:32 +0000
Date: Tue, 24 Jun 2025 15:13:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <Vipin.Varghese@amd.com>
Subject: Re: [PATCH v5] build: reduce use of AVX compiler flags
Message-ID: <aFqyhwuDFvHMPEkC@bricha3-mobl1.ger.corp.intel.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250611105310.472523-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250611105310.472523-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU7PR01CA0039.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: cd62adb1-ed3b-49f7-1a41-08ddb3294ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zA9grY/ColyVIT3hPWPKN3AKaeO9nffuwPvEOuPHI4douqgalI4zV7xxgKoC?=
 =?us-ascii?Q?AZyT8uVBVHv57ZBFYvH0VFLQTHqFBv4tgCDP6KIyKOCy89pdp1K/ClPGVVFN?=
 =?us-ascii?Q?IjtHEUZQJI02qz3Ag9R4xsqssCi59t5aL5ODAvwShqRLmeqgl28dvJ8kUHLS?=
 =?us-ascii?Q?GRuuAgBseLM7Wgh83fXRzP+2KOSKbdBEHizxLC7Q83TYiUyGZbAmgJO3QJJi?=
 =?us-ascii?Q?74z7FRQMriJ17gOs7971sFUL0JaTVBAUJraVpV52+FMc1R9K5oGjHXaATOjv?=
 =?us-ascii?Q?6qffMh6d9jl5OziENOSn3AHvBAhPN7+oyJVq34syZRP/fPd1mPqFOUPTCQ1L?=
 =?us-ascii?Q?oYtWVioR1B0W9ioqm0JZDPymbbxW+SNPUzpi+8gDd3OqczkKLHzkOWhX7YCD?=
 =?us-ascii?Q?pf/Zax6iuuTki6yNxK1kkwOqTjX23l3jdC/zYgYtz92JK1EH7m1YsqLrWGvl?=
 =?us-ascii?Q?pXzGqKeUDXL/7KheSbjpLCKli5M1lkf+wSf95TM7UKnlZMxlDtC2hckR1bm1?=
 =?us-ascii?Q?TlXeIAgGXEb35wa5ZVQELc9Kw89xwWSxfZla0FkVFRZTPUtzFN47bS9Dlknx?=
 =?us-ascii?Q?5syswRI2RS+yum5L8yATEY27logWcZsi+hadzMqTcTvp/0QttkPR3Hrl6NYr?=
 =?us-ascii?Q?6SQ//JcoMoSWuw0yT4aTeu57Ix6LO75dHBRNkCiT+Mwjh4RM8jbAGvmB/Erj?=
 =?us-ascii?Q?JBQ466gwqEz2+JHkGJ7TowNIaWv3d3PrGKPD1+j3indMJHryxO2FBMZGt2HJ?=
 =?us-ascii?Q?YmDZOZPdqFLkkFwmO2HscOY6MGw3G0AM9B6a0NTEYMajLdb03PNK7GbjWjkp?=
 =?us-ascii?Q?0vGv7GRMbxwHD97My5K3vLxzydJqerwnsyoFtAG7dgMxDrR/H6ebRKfgOYhv?=
 =?us-ascii?Q?y2D5VgqMfWLfx2ZwLGS9L7Sk+haHW1anP/Rlk8gL4zLgvGtwzbxwAoU3Q2rP?=
 =?us-ascii?Q?5QaERCdBsC3yGJXP0xFkdlHdjfTSMeDFxHDDBztyURmbvvYSclOrgi7PpmjI?=
 =?us-ascii?Q?fDimAJCG0u4b8imVsTp9KoeG/1QDs7xx4zkrRYBL6avcAqZSWX0YPoKhr9qI?=
 =?us-ascii?Q?iEStTgZ44CcRSE1yoUq+HzIMUnlGMZcEdyOawYJoVIHZLg6dMxb3B5e2jrhs?=
 =?us-ascii?Q?Z6rExKxcqh1nJdKfMI+pTnazJkQBCtkPXwSzAZr14yTSNJb5nAMBJAFWjVWS?=
 =?us-ascii?Q?KZGoYRwLy4uFbxMmjAkc+dWDKLgXRD4iXDM3loHbD1GSWVXa6E06ptbd0V06?=
 =?us-ascii?Q?mT3GBp8uu9RV+3lQWPtjuY2vVCUlpw59RjDFKYtaVRHiNpWq5Q/cjS7oELdv?=
 =?us-ascii?Q?NsHdEnXAftMI3YdU1HRO+AbfnpWmcfdWRiIvApfDV8FgycGY3cctCRyRBM1g?=
 =?us-ascii?Q?Dpc4mP1txBvpVLa6csHsiK3NhjXGEF2lQqbinbVvzWBVS0u7F5uHn921oVZQ?=
 =?us-ascii?Q?W9AxRsiLoxE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+yYuVCky1ESzWmZJLXBrPuolUz4afTzckm+hb4J5Tw4clIKwrRw1lGcudmuj?=
 =?us-ascii?Q?Fd0X6kT88V5O2ltTQBmGWrbbjc4/apLOmWO9lfhW6wcqGIX3yQsEyUbhsXLM?=
 =?us-ascii?Q?V/gdDlT8MB3QRU9v3fHGrbjQiPAkaCbkSgB2BANpDDZXxpSQPPmKunxq/HHd?=
 =?us-ascii?Q?2kZDxJTiCAYMU3JhHK5g5cyKQD+yasbgbrF6W7YSPC8XNHhWGHcMVHIFxbnt?=
 =?us-ascii?Q?ToKxXUIq8SK07fkYA55QMctKvL74GwSIlK46nMCDTUovvRiWtJ+43vA7YxlK?=
 =?us-ascii?Q?wiXA1TlK/KZAevCePo98ZZefZfs4oa4KsBwQFHEvPR9MiusAUNcb1CYqqCYm?=
 =?us-ascii?Q?ZTmlY0AkkDovHqgT7D0a5+eGa57+4ZRlTtSeA3z7W9ZKj2NYk+vLmqDDyvUy?=
 =?us-ascii?Q?9uKkcxq6exXn3vZkkhrKHrTlE3Qbc5UYWAwsa5A8DE+AFnlm9kOXwfoBwXUl?=
 =?us-ascii?Q?IiYA8xtW75JmIICvCEcHLISj0/4riiNnVVcPncU1PzapyycxQiIlTciz5qmR?=
 =?us-ascii?Q?LhVnyyy8ct19dSY66k3gQmJMp4s5YQjZJPHRotFsH6WtoFKxb0SR1AncEdKW?=
 =?us-ascii?Q?8dcHY4iLwA04haQRoo4MNd4jJLGR1iWic9A+2Xsl5Za7QkaN8uLqcT4U2PaU?=
 =?us-ascii?Q?G0EF2Y6uW2wP/ZIiyRgQf7T4CJqq7sJQwdOfBcWTW8xKTf8FS/tj2BhZb/KX?=
 =?us-ascii?Q?SgtaBeRpDzYHV5k4T8WMjhdezx4m6j2ZqkZq7xzYbW5l4GkRSTXZw7qFRUq7?=
 =?us-ascii?Q?pu1Khyx2g1ahy/YMYTGwrrvUkj8sXXJMDfsh1ATmp5zTe76WRqddH4KvZZBb?=
 =?us-ascii?Q?yp0mVA4iNha+Q6BZ8UR1a7AiqHq0X99QbVm3ksbffk0brGnYscFHOybvzatX?=
 =?us-ascii?Q?KHi/JEgBAUojgVQjP75TioPflFvi2MV6Jouo8idq2Ow3edTCF3wMe4btWdBx?=
 =?us-ascii?Q?9fyIjzsZuRR0jfZzRvEka6UCuMI6pzaz6Gw9ZOAk07SFnLxhampZYLaE7RPD?=
 =?us-ascii?Q?ohebiMTw537D3Mlx5xe1lbKgKonQ/EsDsYtMqKzVJkNYhTJQbP4R/z+V6ywE?=
 =?us-ascii?Q?Brw72SOMPBdsrSr4XlM+WyAE8B9mLCvuFf9ZMODhQF0EKEUgIg3OrkRDK00r?=
 =?us-ascii?Q?VcPo/RJAgMxYhWhoc1z4crE2fHpdt0cisiCFAjKziTf6ViRCC0rI4SlwJ0Qf?=
 =?us-ascii?Q?ldfEh539Abcuh+6QvO9zQ4H3gbZb3h/hA6RiDfK97Dq3PdE1IlT3grW6Dpk1?=
 =?us-ascii?Q?nRMFSXm1qj6tLEwyTd8azHAUCQORPqInt2RkmtIKDjUQTDi1zth8R0t9o8lx?=
 =?us-ascii?Q?JF5oJtS/3OLtXfF+8SOJc5LcHonZbxXIsQEZLOJIgSgk3tAgMOFvoNKnMakT?=
 =?us-ascii?Q?pEXeba3DATIS+gYD17i//5/QL+shm+O348rkPQKWGoCA2iOOpzzdCJelVzBm?=
 =?us-ascii?Q?GgTaQJWzlXKcPwl4ATKkbBKAaLMXVAnCRQmBHnUb5BiTZFoMaDGGwfep5MBV?=
 =?us-ascii?Q?6tVE+Hz1Qxb+6BoNFTlODX2JxlWmDCmvc+BYBHyp4DdDH3jbjv0DxSxEcXtQ?=
 =?us-ascii?Q?DN1KFsCOWxqmS2prQxWjLj1Fw5BvT6fDs4EBzhQcfRdD3Y+2QbfXcNcjikEd?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd62adb1-ed3b-49f7-1a41-08ddb3294ca0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:13:32.0019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qt0UM5Zr7TIbIPdTv/G8KgScqI79RVlVmyicZ+9MzgGpQ4TImkPKDZ7ns0mbEGw+0t9LUNyEIFOckNDuD9Z8kEXRpoU/KfX3MEjO6Qj2JWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7815
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

On Wed, Jun 11, 2025 at 11:53:10AM +0100, Bruce Richardson wrote:
> When doing a build for a target that already has the instruction sets
> for AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or the
> x86-64-v4 '-march' flags, as they are unnecessary. Instead, when
> the default flags produce the desired output, just use them unmodified,
> and don't bother adding in extra enabling flags for AVX2 or AVX-512.
> 
> Depends-on: series-35421 ("doc/linux_gsg: update recommended compiler versions")
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v5: Use "x86-64-v4" arch, when available, in place of "skylake-avx512"
> 
> V4: Fix error flagged by CI with clang builds without AVX512 - change
>     "cc_avx512_args" to correct "cc_avx512_flags"
> 
> V3: put in version check to work around an issues with some meson
>     versions, (hopefully) allowing builds to pass in all CIs. The
>     printout of the extra flags now only happens with meson >= 0.60.2
> 
> V2: dropped the doc update for the minimum compiler version.  Based on
>     discussion, that version bump is larger than proposed in RFC and is
>     now a separate patch/series [series referenced above]
> ---
>  config/x86/meson.build | 34 +++++++++++++++++++++++-----------
>  drivers/meson.build    |  9 +--------
>  lib/meson.build        |  9 +--------
>  3 files changed, 25 insertions(+), 27 deletions(-)
>
Recheck-request: rebase=main, iol-unit-amd64-testing
