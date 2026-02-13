Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9B9EDF146
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:10:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F27A402BE;
	Fri, 13 Feb 2026 11:10:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 797A240287
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:10:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770977414; x=1802513414;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bSCb20dUXNhCPWu9sbT1pK/j3g/gPqm8aSYA2F+QQko=;
 b=m7u0bQV5Y7oKYQcCwddXxrmpOOX1ocquBVT4Wx5JvdCbBUv9ruyjo9mM
 NBHqhBDhPbZV9BYI9XjskQsqmALn4eESSDN9Yqb5ZvmXolZ+l9Jy3RivY
 1IxflcKXOTlGsfa8sYFZE9RFnC9stxfJ26vY66uAIoWjBX15ZSCVsDHEJ
 vcArOgNuG9PiEB0gr82b4OCN0CVRRxR8BmU4v6grp6618NikjQfaY6iQ5
 RjfGfeI9cjttjPADaZ2lCDQAMv5QsK5FJ1OS9/+MTtxzhQHu/1Kpo0qfg
 UjEXfkNF87W33lFj1pbw4dI95k3EUgkfx2uCP36dTE1sHrhMD7Ow9sWDH Q==;
X-CSE-ConnectionGUID: pMS4m9HtT4q6U5u8oSICyg==
X-CSE-MsgGUID: qcITOmvvSIWPNI52f6InJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89572367"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="89572367"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:10:13 -0800
X-CSE-ConnectionGUID: e1WRQiFoRJeM2zDICedGOg==
X-CSE-MsgGUID: 2XG1Jhc9Q9uApQJXeS+tNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217041185"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:10:12 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 02:10:12 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 02:10:12 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 02:10:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykvkMjod1fkDRRQfVNlQn8ic1y2exdIh/vg103c6huRSySZTmD1WyuADau0ePE8A1ohE2/WvF74YLqZyVc7Zwi3nAoyO1cIWV1XBtkiTiG2HPWSQRebnH4qqIMrtbyr0n4RD6xaKS0kgCgFDGV358yvf/17WKglBDUKQ4v1VKAj7BOA6vFKMxQa9hTAbnlB4K/860VMLeIXhY2cVZhhHNLyNFJkUDVF5pQiTszFb36d4I66WUyYJJWdL7u8SwcOtQ9cP94g/LjIzzplB41jL6G1uslycOmZnAVPU1KncisIjLLiLGVAwRy5CnJ/TFWr8fmuycSzj0T1iuEEBm2AdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcytaD4sbaBy6hiRfQq5nC6kxOwJUamVCL8VbwwFwyc=;
 b=VnTqlhE4jayM7+0Uvc3K/PQ4Kb6Q9UqaW/nX4OJjiYRUHI5jTf6xMIafYq1V/+928bq5A78uR0/Wka8uwEdbDOS+Kikih4vUO2nIyLmGDv/qN8bT7LpVeeMBwISg73iZ0h/Ugwb0YNtFYZ0hqeiZSaauptagg/VFZlnUvLLQfiHGgOvt9ECWIvOiyGJ46/XlggnT5ZLHFUEowKMl3/GCWYlvej7rgoGjgYi1F69dTro90iTXRKeRNM6Quhdq2V57dqJbNVUZxTlx9FmSfxVwvwdOgYsuAtHTJogzPJF8W+GC+qM2Tiaf9g3rwrYrAnwFaCzZDMaYr/PFL+OAqMUlqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BN9PR11MB5244.namprd11.prod.outlook.com (2603:10b6:408:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 10:10:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:10:09 +0000
Date: Fri, 13 Feb 2026 10:10:04 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v6 00/12] Assortment of bug fixes for Intel PMD's
Message-ID: <aY74fN7dR7t0bVY6@bricha3-mobl1.ger.corp.intel.com>
References: <4084ed8c4f7c01852ca22c7975d0639fc4c8a066.1770641909.git.anatoly.burakov@intel.com>
 <cover.1770973745.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1770973745.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB9PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BN9PR11MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 3781f741-367a-44bd-d651-08de6ae811aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PEJG14GmI38fgxmUeZTi8ebKPpHDhGwDBBuUe5P6FjWJJro3ViXthMS6uLoI?=
 =?us-ascii?Q?pmYSWHLkCVFlMWHyDA10GiL18e3VavSrbsAb0isc6FJUt0xXtvz2Ueqgm2nB?=
 =?us-ascii?Q?nQG33Bakc1WJtAucTlg41Pk8dMk7TE8+G7AhkrtOgD+a3JqZEAvA6quae95d?=
 =?us-ascii?Q?xP/O6ETXCJuU/ZXd3j/0Nu5+prlFK4/EETVWZ4pjWPLMkpBLw7QRUnzqe0r9?=
 =?us-ascii?Q?UrjOB9zbHfvTXJCYI+Yvd/BeIG/bII/RCQO9IBQBtNdOINOexAtfHHteLKhw?=
 =?us-ascii?Q?K7IqYUPwVc7GyvvFRAIJiuEVMrvMQgEBErxKXUNNT42HEDfxSEh11n1fM0Qc?=
 =?us-ascii?Q?45en79fWSBBBpK4/pWnQEJDZW6uhCNcCm+0Xr4FirGLAsTzwYXNiy8ILnMPN?=
 =?us-ascii?Q?g61bbiSXJQeD84jmOV9s1GVfyFJCilh4/za2Pr8GPoD6W+npmjjGcvuMtIII?=
 =?us-ascii?Q?t5ELsfZ3uko3+wFaJ+KY3Pi0pMKBqP8ZO8AbmQa83OF9PZTzREtb0yTOpYES?=
 =?us-ascii?Q?vFsYeYfldcc7xoezacNZvB0tvYNW3S3qSmZEwi9WTDJdC0rDi1Lz6DYh7eQu?=
 =?us-ascii?Q?ZeLUwW29fdRsQ7bcbM7/NemLLLm3YUUhkX24b6mEZoPoxcebVyY+uCqMnLb6?=
 =?us-ascii?Q?WA77Hrq5dHD30ART3IBfQoCGxtZ4Gt1s6lngyTvZPUp11/DNV8HPzKXFUtJ7?=
 =?us-ascii?Q?KAnVTmWHbS7YOQPIaGgNYWuiUrXFndzFGiZD+Z6jpe7xXoAVgH65ZW+od4JC?=
 =?us-ascii?Q?8IZCp/zlyCvWe9UsaKPTdQIWmnjKv6y5qMuSd81PH7WoxH0vG6K6oCs3Exa0?=
 =?us-ascii?Q?NabIjqXe8aZgjSDO5RInrG7BchG1LmV4Z7ZaIsHWnaZAQpeV8mG0ZXh9nwq7?=
 =?us-ascii?Q?G+AkjJ4DZAQdtFGXMMReREDz3fYiq+4cFQjYVejIEjhCXmmpszCX76s4Rgfm?=
 =?us-ascii?Q?i5EHFpkaIXOeZj2xnPmK3ARfe51ISJX+1zXPa2zA8fcsBuUlMTsXNvK+TBR8?=
 =?us-ascii?Q?eRwlwoukEbC53O2zreCE3W8j1tnQJhkwMVDBNHJ0dZpBSnXwGNqqi+L9+WmT?=
 =?us-ascii?Q?MLFLG90nwifqRcIIYbbedvwEhLY2r02eJrpnkd9+g6ScD6TS5L1pGr8WidCA?=
 =?us-ascii?Q?mEBqzBMy7ewjPdfUesLq2F4Ydymcq0E8MAoH5Xjc/rB1CmJg4Twm1m+hHV6U?=
 =?us-ascii?Q?XNab3rUXXaDTQK+TCRkYSmYjCtqlzRPD0w90xnOclGC3IAX3wD2Lkj4y8WQj?=
 =?us-ascii?Q?CS9RI6YKFoQEJNeowhuowe95553cV9XyUV2TI9IaJWaSD3IrRDaza+t5TXHq?=
 =?us-ascii?Q?VQQfhJNASPCTpFrG3onVkpM0bxOxHG9+o7lvru13dvIb6k0PUvMqAwQ99aTm?=
 =?us-ascii?Q?/TVZ9NfzRi9gzr8lDFbnIcZWDqDn8QjNMfcaVEH6JB7alLBh8u6okbybmnSX?=
 =?us-ascii?Q?hESjnRh8elF1VcXwvtbukvZDSl0Hvtvyu2fwkpEG6N/KfgBEwjTmCsVWDww+?=
 =?us-ascii?Q?Xj8bgzEGL1HqqbXE/DK1t76qY1Ql93Qp5Z5t/mfu0ei3akSc+tPmXoicUegG?=
 =?us-ascii?Q?S0VYeJgIrELV9yoHThx3Bof3pfeLZpcZvaPPdPb9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/+0GCSdjNsVhoWuFzALw9kJ/MNqiOTFGQgCY1WYvrlfaw3l66Y7KoJtUeAYa?=
 =?us-ascii?Q?ChQGnNlNoZeOUNODIS6IGnLLIgNP77ZuZEXYXGwWM6jTzFjLRN4NNMs+qE2o?=
 =?us-ascii?Q?89OTBC7ttnupLavtp5e3PU0f6qoGy5EiltwoR6G1WfGkc0BiKMLDwIrJp+pt?=
 =?us-ascii?Q?aXEXGRZqkvWbThTlHiwIGEY1ASshtS7m/Qm94nrD2PoEcmTGS75uzR0WRsz2?=
 =?us-ascii?Q?Jzz6l6pbTXEP7ticbDfmxbzCFVRr+1aFaTqCMYJI9urtpZuBsNVfRXxy5e6P?=
 =?us-ascii?Q?QnMC+JGKBtS3x0HQ52mramDfHCh2RIfV8Dtr+u5ePv6ANdkPazitn67Crgru?=
 =?us-ascii?Q?1eztVxn2fCc+RxYmHbInv0iQKJNaFBaIJAUIi9/1DGr/pCCquCUM1ZptPb2j?=
 =?us-ascii?Q?ZWWV66rujUmi755N2G+Q0utjT5xgA9MPhe7mTgzWhAcbmhXec/hgubuDYWRQ?=
 =?us-ascii?Q?X5ji45KoSGYyIImqc1/H/5iENgl1ZG20EWV3Tyf8DHdQrRhsbwkR6bjEX6Nv?=
 =?us-ascii?Q?34/P9U0vNA42uuaB1EhZbq7hA7eULy2n5DJ1yEbaPkKxatTR5MjU4Z5wqG/k?=
 =?us-ascii?Q?pdaeXrE88wa++aMGSZF/BUjgL810VB/73PgT2gP7DD/ClOsiCrdzcIklBsSl?=
 =?us-ascii?Q?Ynw59RA6PQhBhUMJkCjFtczqqjQDnjlotUXtRfxmYRiUNrz/ux8o+ZzHe5tq?=
 =?us-ascii?Q?J8BBba3enhjaH90VkG9itBj6ssN3YUG/1fa9IKbJ131a0FoWmNmZ/3HEz/bJ?=
 =?us-ascii?Q?fuNIguvlRi5hqnX0uufIqlu46nAIuSVVcp3lD5IUYibNzj93J25WF7ewAyiV?=
 =?us-ascii?Q?aLiTCJwqKuxT2shHONTd8LwKDXPhEwPdF5/8cpcYJ5K0fgPbEUKNUTEKOPG8?=
 =?us-ascii?Q?R5cWTYaHVQflfeSPfUl3J0TogSyn6xvE+w2fNIO+TgZfr5G0O2WfChaoBIij?=
 =?us-ascii?Q?N07TUuVuaGmMQyVKmc3ofQms6LrCH8J9nOeVHO3Am9J9alzdUyvsq/SD1hsX?=
 =?us-ascii?Q?p4L6PqfjhnMmyPfOPd4ZIX1DgW+Xvs+luam8Ka7QqtQhmTHwpk6yx2AXy8n2?=
 =?us-ascii?Q?3nMroj4QRt4jUgvP2GJ6/SfCdtyLxRrAGZ+GUXSykKnZRpuZDplLzZ7nNKvM?=
 =?us-ascii?Q?JO/u8jwKgdfEQFt9mlM00Ns8C2nPtBNVq6xgGGXHQGBPmhEfGYz41k6vdxzy?=
 =?us-ascii?Q?qSFcWZM9dh2kZIcJ4eq3b2v9ABEy0eqwR8CtnvsHSwkWo6BEUcCJHS/3qIlq?=
 =?us-ascii?Q?0ujSh/jtZaxi0Mxum2occbA/uqZWlxeQxQSzA9x7g0bxB7dA1LwBKgIdavJH?=
 =?us-ascii?Q?IsIS4agxeVLPuTnIN6m1z/PH2RB5e5y9MeeYqooQJ+m8elAGj1HSJZdryFgU?=
 =?us-ascii?Q?dGLh7cphmQoXJ2w/K+D8CLPG0/vKRuJ3CJggNi7avc81+IyXuTegbRi2MBbx?=
 =?us-ascii?Q?IGyOGtgsBi3orGiMsYwO9sHhBwJV1YH6biIVxQpj7XWCW1Lr2c1PBhEZ44UH?=
 =?us-ascii?Q?f5NRhKfVbsMdMPIiRASaT1xpU+CMKeN8QL7kZhOCKWLE+LKXb0NROfGthnoJ?=
 =?us-ascii?Q?siE15vrhnqW0+8gHjfxk3rFliISI3MNL2puVimcQX/pVmRT9m2HswDkQiJju?=
 =?us-ascii?Q?yLo2cdsinhS5q6I7FWxPMCBKWXELvbRvH2/+u6rRBUVXrNdb/4ZLX+/GMVXe?=
 =?us-ascii?Q?JoKEcKnuH64ZAmRBZeYDQnsWjzzbQtdVofgG3KizIS2Rbh1LZm5nuNyCGr9S?=
 =?us-ascii?Q?xxjS9EFDEQxm2ya9kW6r4jGXUdLvMLc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3781f741-367a-44bd-d651-08de6ae811aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:10:09.5613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjHhAqfnw+se/95+RrboU2zYVFdbe3+jln6jbHW/fIc8jFVe+lkvK3TP9ISwdQjSfnNubMRXcaiVTkppGdwNtQ+bh6ygXtFVQBmGgsN6J5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
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

On Fri, Feb 13, 2026 at 09:10:02AM +0000, Anatoly Burakov wrote:
> Various bug fixes for Intel IXGBE, I40E, ICE, and IAVF drivers
> 
> v1 -> v2:
> - Added patches [1] [2] that were previously sent separately
> - Added patch fixing leak in DCF config
> 
> v2 -> v3:
> - Added patch fixing leak in FDIR parser
> 
> v3 -> v4:
> - Reordered patchsets by driver
> - Added patch to fix ixgbe security flow memory leak
> 
> v4 -> v5:
> - Fixed build issues in DCF patch
> - Added three more patches to fix various bugs in IPsec
> 
> v5 -> v6:
> - Brought back comment about constness and moved it to where
>   casting away actually happens
> 
> [1] https://patches.dpdk.org/project/dpdk/patch/fbd32a8a688fd0ed90fcf497703edcc30f69d54d.1770643356.git.anatoly.burakov@intel.com/
> [2] https://patches.dpdk.org/project/dpdk/patch/ab4f8d8cf24dcd18f0dd6da3359266083f31d789.1770642901.git.anatoly.burakov@intel.com/
> 
Applied to dpdk-next-net-intel.

Thanks,
/Bruce
