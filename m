Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F354C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 16:39:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 314B740663;
	Wed, 12 Mar 2025 17:39:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4BFE2402D3
 for <dev@dpdk.org>; Wed, 12 Mar 2025 17:39:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741797541; x=1773333541;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NyxOfXSOY/Vp6dSt1dALwZxT50xsG+RYMFG6KoqDqeM=;
 b=blikRrFsYn2lu7S79e4wLTnWZhiA9r2N2VVqU1lqRimCx5Er/8NZ4i6F
 xHVyW4MIvD53y2g6QBad4wu9O2uau/1RRT5Q4bU135Oll+OlMu5DQQoaM
 lhRYn4NX543pjD36erPLGZt8JVPgpOa0if2wYrIFkTWzunaybJ6IUU2O/
 bZXovujgp2H1iga6s5z/h/58FZwfsKLQXjvPihudSQ1dBYc7kellHTyJG
 QrH9s585M6MxP+jqPqBcyRNz+qo+lWhb8fad10/2N398rVCXUaKfk+v0X
 FgiavqsQeH0jrdiysrN6IXNvrVWpygge/HS53W57FAwe5dLVqJ9jvA/vd w==;
X-CSE-ConnectionGUID: oY+rmGoTTOGhRCgxzT7TuQ==
X-CSE-MsgGUID: 1XJLHprHTdiqGIYzmuHbjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="54269169"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="54269169"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 09:39:00 -0700
X-CSE-ConnectionGUID: zfSGotr3SeOgV0MsSoKZcg==
X-CSE-MsgGUID: AwR/UHPpS7+9L988IDKKVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="120648968"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 09:38:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 09:38:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 09:38:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 09:38:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg5HEbmEWZWh09lZ/+OfwqdDOsB55YiS1pbmyA2PwWIjQj3PIWBLpP/Okr5WMbAnrZhEbpzNUxBmWmUvoJAF2v2pygvzTK80NKPcaLtxDs3ub3GCezIvWok9eXUqUMrXBHLhunR8Vje04lHYxYyeAkCE9TaiiVHWRiTXJYucUL7gXVxyhl12YOgkpc2+wd19bQAx52iOWkkV6rB2okvVWtjxR8ZfYkkLYWR3dk10CrTd0tw3mUDG0ZiTYxHgfFauofSxy6DgGEKVPeRpweeZThCr8kqr1T31KWXVomFhy1ltjUgPGAjyR5XYmpzT6xN8y6BIDQh2nXVFraei/rBxSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m3E+gBX4QjTMTKRLyLGkJ9Az9sJqW5n+U6pq9mtVWw=;
 b=DGIfNkYErxbwtp0lWtrGgQSi2lVTmTCzbnq+kEyuDp/7LHNbsIJE2SUY/PWJUcte+wF2c3glSMpvWSfItwPbXnwr3H1vQE/iiQ7UoyDvKSWxDKjysMmhJJkRtaw8GjbFzYezxM4pE7i82hdqeaL6ls+Z3Fg//HqfKOTBd0+zRBW+sut+t23LtpF9Tz9vDM6bbxjUXLhTFRntAMC425YSCxoLMz2nAGxc/DTQKN+6D750WpW2yAyXIjX2m6yymcwV1qmeezIPUxhBe/XTwygg96Nb3aH6+cnMqrt41EWrtckPyFC7P/53B3J8mVA3h2wkzgexUmd2n0xYhJ8ktF89Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7646.namprd11.prod.outlook.com (2603:10b6:a03:4c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 16:38:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 16:38:53 +0000
Date: Wed, 12 Mar 2025 16:38:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/intel: using common functions in idpf driver
Message-ID: <Z9G4mKzUrPs2FRtC@bricha3-mobl1.ger.corp.intel.com>
References: <20250312155351.409879-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250312155351.409879-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU7P194CA0022.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c537a6-912a-4733-6492-08dd61846053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aWjr6yL/hhCqFip/mZNZaz29rI/N6lScgZxtfNrNQiAKTuKNNtiPCjyguVpl?=
 =?us-ascii?Q?zWTGdyntG22AQIC4ATks/tzyUR3dfw+/5FoYpVJmfyaK/N0ZemvWgXPy3G51?=
 =?us-ascii?Q?/yoROX5st2hwJaOiM7Rwc5eaiFqvIifnNhWFuX22k4g7IP1d7nnQ1F/AmwKg?=
 =?us-ascii?Q?0Vv9zknDBepEf/bPZhjeQz6+KLsf4kTT+DA5h6KBKc6EaXFDbHvnpffqKXsk?=
 =?us-ascii?Q?d79RMtjM0dIa8wnxycC9QQ8yqLvM51qIzWow8tshhTm4Fqpg8yQdI8IGno2W?=
 =?us-ascii?Q?Uuam4zHTSZOn4SR4Tj9/IpdglNZqdiU/GL8NI0V67kAtfZ4rioAr6d/P75Mz?=
 =?us-ascii?Q?aJ9b4FdGh3Twxuqi9RZc02O+oHb3s8o5A8fKcOGrgUVanqP+wdkr/QS9bYqQ?=
 =?us-ascii?Q?ylFXaL45Q+1cP4HVdyA6LD8ubA3Ooh0Bz6FxwzajQlf7ETBWKXiogZiNufOE?=
 =?us-ascii?Q?RhZJegsUGV7xdy9wsVJNRVQQqwYCQTaLSJLkPgOJcKlisFkAm95Fk3DJTTAM?=
 =?us-ascii?Q?SfX5XUdTsOm1r3X4HGta28mx4VA2sygBD2eC1KHnnLwadVacD7EyVSoAELU+?=
 =?us-ascii?Q?VxGKqqtU4WK3j0AtSS1inMWiF0vRBfprB2GramvPMCrK0bALF8u1pNB4PeP9?=
 =?us-ascii?Q?OiwHMm1DSl18sclKE/CUiOjKu/nRRZNi2S/xVeJqo6CBCODeJ9jaJ1S1qXCl?=
 =?us-ascii?Q?SZB4qybK3xI0imV93MlwpaQ80sIby3yzVRALSK1k7wo4beCmbK35pxjmHJHx?=
 =?us-ascii?Q?CWGkEbYYN+HD61YtAy+el+s6f41yNNYVXUh5nJt/pygbkUs3ejdCgFepft5n?=
 =?us-ascii?Q?DSXPzlA6SrtA+dPu8GMXBaCmdXp3Ha/IN4o06C1pGAO+9QNQ+zJWmoRwBSk7?=
 =?us-ascii?Q?84SCHHCo+hV42eKVAsEYyfCiPsTUdHNfaAFGarYQJutXFSUlE4/NIRMy/QBq?=
 =?us-ascii?Q?DWZ+zooFJ+eXVdjeHD4IgHND/RqMyAubPZmfXPQ0gC+RCUjimnCVqsLFeUUq?=
 =?us-ascii?Q?USsclHeqhnarZ6yXMGW/5oA0bmje0L4193sVodXQJrp/AhcTLAjNy6Yx6pvO?=
 =?us-ascii?Q?8mPOOVgBHHRqDFoFOGi5gq6/ZJMHMlhDCs2Dwr96YudHHSc2ZWzGlbMZMZVy?=
 =?us-ascii?Q?jbauA4zP/XJjmTPeRV0U7dt8j/IvGhyJz1cPPNRg+TjPHG671lZ9jGMohrFS?=
 =?us-ascii?Q?92S7njYScYN9SsCuo5y5VXFo30CLHo2Q3C7SThMHA2nAlcMEphf1WCPfQReD?=
 =?us-ascii?Q?Kmr/kUjQBYWJ/LDdEqAEZDZ1guG9YVaNq9qbYj78/k9OM0rYUnVEDyYA2itL?=
 =?us-ascii?Q?Gof5eZKHtYb2eIp/EC7BQqoQ4jPgXcecKJIBtg6SevbZlZFXEu9bb0Ccphk8?=
 =?us-ascii?Q?WkfvdDPq5HFaXoa5aFW3Uris3wti?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uvr3Hx4TcAZKPmYgmDadGbvkZs4o9hlVvDY5BsdwFAgARNq0AQjjF17KTT1X?=
 =?us-ascii?Q?Ymj9b9UnD9+8/9Cb0f30iAHFJdHfN7L7pBUpURLbEtfVj8MWRR+CyqxO7Q7y?=
 =?us-ascii?Q?yeVlUifwS6d13sXTots1lCto0hCdPpG/9vb9o3vYdnEZAXXJneKOHB1+/p+y?=
 =?us-ascii?Q?VeDXFBmx+E2msmyFbalXd0K5ZkQrRKOeUtwBgfeNvN7g+6285sqfeNpZWVQV?=
 =?us-ascii?Q?8oMFJI+I88Etda470iUYhrlksFCtPfLV65gaRjAzQiYuK+7PyAA3SJajEoKA?=
 =?us-ascii?Q?FP9iI+s1aSRoa0PsGwp0sTC+vNlBCp/uMXxB5lJSuRzHaP1wrpxgtOIuPrCk?=
 =?us-ascii?Q?i6qD5BTTOd2Xx+/kI7TkPua47fNmCQyTOyvZPqdbQtlVQ9iM1p3VbsVW3yWV?=
 =?us-ascii?Q?5hMdzcSGoGud7uPQ+WceQUGENxMlsjF/dq5b4vGPd5SybVPbXAfb1hKMihS3?=
 =?us-ascii?Q?h17xAqVeMck4ozibY1X1TMWGEPNZYDEe1FtsTdYD9BjadGH74MEveL65qJ78?=
 =?us-ascii?Q?pDT/MUszW+wAv8ZY4UPZXKF63ilQ8ZbGhRyLIiusXHi2Nmh4HzqAI/sEp5e0?=
 =?us-ascii?Q?HRVhTTbhL8wXRLnB7oC+jv6qcxLccD7n/I413oI9Vgb4bNDhxeNjorJHJ3Y4?=
 =?us-ascii?Q?M79FEsUiP8lArbWIOgTZXIoXICY4pwh9JVi5Bcvyjlb5VI82tpgddKaD1QpM?=
 =?us-ascii?Q?FSz70eQOeCRbWcVpNkFN0gbv/uz0bq2bbZZ78hEFST2VuxiP9Vas6LuIJEO2?=
 =?us-ascii?Q?eIRAoL7Sve69RViyAG+EyqrNlHi0DCxjAyo7iBTZiKe7An8hXU40JtSNoJXB?=
 =?us-ascii?Q?4o3vsz34pqON6mwku2mkfJfYXfrH5zkW9EhIdg9Rw7+6nhGjDj2C1/eglU8R?=
 =?us-ascii?Q?JEQlEEdnLsgZVAN9xmzlIqpCdOna5vdZ1qHKqAUeirHyTzcGY0iLiLz5a3LO?=
 =?us-ascii?Q?99SIUx3Owvc5kbuJZ+rel0y0JoNGrWjpse7u2CLP1hEg70G4XgpdoSe0bzxi?=
 =?us-ascii?Q?6FS1251wC96aPhAm5ZAA/YGLBpmcVMXPVIqUVQLXCeVs2nNx6PUrOg2wlKer?=
 =?us-ascii?Q?RzcdllXXCw/P0OiN/TMcbh1KcnOv1Nrg5WDQhsioVT3xDGzuynDHUyjA17b5?=
 =?us-ascii?Q?MWmtvFQKEEWDTeCJCIpdzXH9b+PLS01pYufKHd13N45vhfXCppo8ehD5jlW5?=
 =?us-ascii?Q?D6ib0iHlnNjJ2oS6pLVnt3d3YjsTz2G6+Mr9OnjRUGzjGD6/Ul1G9F6duB8H?=
 =?us-ascii?Q?4oQazILcV3E78LKzywh6mCa2qR6AIM/pjff/mP96MweQA+boY+DHsfpnhn9Q?=
 =?us-ascii?Q?LzlVqac6Qi07cvumqcdQJXvoY2Bu0uSl4Nj5JUu/iJhJhMgckDJ+VTdEaPIl?=
 =?us-ascii?Q?h9/9Rj/4/Y0eFe3rLq9CSm3mXYlGNuwcLceEo92yWol2elAodUUr46UT1z48?=
 =?us-ascii?Q?j0IGqBZGkIlHy3p66MUjw/E/UTmCu6P3X6AakDxFHTAJe1lGWN4EHqnbWEda?=
 =?us-ascii?Q?FCBaDBHxA+haJhbIXodjRIDmIGAGJdJza9kto6hWFA9gPR4AaPkhtlRNRrwt?=
 =?us-ascii?Q?qWF5q+heokzbcsQugDVYIdmvxcCX2P9/pl8DzKYzVg+U4DSPE5Eyez5mHkcB?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c537a6-912a-4733-6492-08dd61846053
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 16:38:53.7615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMIIDFYLcdDMMzALSJjBzUoqfTQ+NxcQDzaVmm9bMNPbvThjWDSB/a9FOSiu5+t3bZrQHeOVllGDj3GN1p4iYSLiu6Jdv8kVJIcY7+5tF0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7646
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

On Wed, Mar 12, 2025 at 09:23:51PM +0530, Shaiq Wani wrote:
> reworked the drivers to use the common functions and structures
> from drivers/net/intel/common.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/common/tx.h                 |  21 +++-
>  drivers/net/intel/cpfl/cpfl_ethdev.c          |   1 +
>  drivers/net/intel/cpfl/cpfl_ethdev.h          |   2 +-
>  drivers/net/intel/cpfl/cpfl_rxtx.c            |  66 +++++------
>  drivers/net/intel/cpfl/cpfl_rxtx.h            |   3 +-
>  drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |   7 +-
>  drivers/net/intel/idpf/idpf_common_rxtx.c     | 108 ++++++++---------
>  drivers/net/intel/idpf/idpf_common_rxtx.h     |  65 ++--------
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 112 +++++-------------
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 104 ++++++++--------
>  drivers/net/intel/idpf/idpf_common_virtchnl.c |   8 +-
>  drivers/net/intel/idpf/idpf_common_virtchnl.h |   2 +-
>  drivers/net/intel/idpf/idpf_ethdev.c          |   3 +-
>  drivers/net/intel/idpf/idpf_rxtx.c            |  46 +++----
>  drivers/net/intel/idpf/idpf_rxtx.h            |   1 +
>  drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  17 ++-
>  drivers/net/intel/idpf/meson.build            |   2 +-
>  17 files changed, 248 insertions(+), 320 deletions(-)
> 

Thanks for undertaking this work. Hopefully it can simplify our code and
improve it. Some feedback from an initial review inline below.

Regards,
/Bruce

> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index d9cf4474fc..532adb4fd1 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -36,6 +36,7 @@ struct ci_tx_queue {
>  		volatile struct iavf_tx_desc *iavf_tx_ring;
>  		volatile struct ice_tx_desc *ice_tx_ring;
>  		volatile union ixgbe_adv_tx_desc *ixgbe_tx_ring;
> +		volatile struct idpf_base_tx_desc *idpf_tx_ring;
>  	};

Very minor nit: The entries listed in the union are in alphabetical order,
so let's put idpf just one line up.

>  	volatile uint8_t *qtx_tail;               /* register address of tail */
>  	union {
> @@ -51,7 +52,7 @@ struct ci_tx_queue {
>  	uint16_t nb_tx_free;
>  	/* Start freeing TX buffers if there are less free descriptors than
>  	 * this value.
> -	 */
> +	*/
>  	uint16_t tx_free_thresh;
>  	/* Number of TX descriptors to use before RS bit is set. */
>  	uint16_t tx_rs_thresh;
> @@ -98,6 +99,24 @@ struct ci_tx_queue {
>  			uint8_t wthresh;   /**< Write-back threshold reg. */
>  			uint8_t using_ipsec;  /**< indicates that IPsec TX feature is in use */
>  		};
> +		struct { /* idpf specific values */

This struct is quite a bit bigger I think than other structs in the union.
Hopefully there is some way to cut it down a bit. (ixgbe is the next
biggest, at 24 bytes in size. This, by my count, is 3 times that, at 72
bytes)

> +			volatile union {
> +				struct idpf_flex_tx_sched_desc *desc_ring;
> +				struct idpf_splitq_tx_compl_desc *compl_ring;
> +			};
> +			bool q_started;

Do we really need this value? Other drivers seem to manage fine without a
special queue variable indicating started or not.

> +			const struct idpf_txq_ops *idpf_ops;
> +			/* only valid for split queue mode */
> +			uint16_t sw_nb_desc;
> +			uint16_t sw_tail;

We are wasting lots of space in the structure here by having the fields
placed at random within it. If the "q_started" variable is kept as-is, that
is wasting 7 bytes. These two variables waste 4 bytes of padding after
them. There are similarly 3 bytes wasted after "expected_gen_id". Just
reordering the fields alone will bring the size down by 8 bytes (with 6
bytes of padding lost at the end).

For sw_nb_desc field - is this not the same as "nb_tx_desc" field?
For sw_tail - is this not the same as "tx_tail"?

> +			void **txqs;
> +			uint32_t tx_start_qid;
> +			uint8_t expected_gen_id;
> +			struct ci_tx_queue *complq;
> +#define IDPF_TX_CTYPE_NUM	8
> +			uint16_t ctype[IDPF_TX_CTYPE_NUM];
> +
> +		};

If some of these fields are only relevant for splitq model, or when using a
queue with timestamps or scheduling, would there be a large impact to
having them split off into a separate structure, pointed to by the general
tx queue structure? To avoid expanding the struct size by a lot for all
drivers it would be good if we can keep the idpf-specific data to 32-bytes
or smaller (ideally 24-bytes which would involve no change!)

>  	};
>  };
>  
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
> index 1817221652..c67ccf6b53 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.c
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
> @@ -18,6 +18,7 @@
>  #include "cpfl_rxtx.h"
>  #include "cpfl_flow.h"
>  #include "cpfl_rules.h"
> +#include "../common/tx.h"
>  
>  #define CPFL_REPRESENTOR	"representor"
>  #define CPFL_TX_SINGLE_Q	"tx_single"
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
> index 9a38a69194..d4e1176ab1 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.h
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
> @@ -174,7 +174,7 @@ struct cpfl_vport {
>  	uint16_t nb_p2p_txq;
>  
>  	struct idpf_rx_queue *p2p_rx_bufq;
> -	struct idpf_tx_queue *p2p_tx_complq;
> +	struct ci_tx_queue *p2p_tx_complq;
>  	bool p2p_manual_bind;
>  };
>  
> diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
> index 47351ca102..d7b5a660b5 100644
> --- a/drivers/net/intel/cpfl/cpfl_rxtx.c
> +++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
> @@ -11,7 +11,7 @@
>  #include "cpfl_rxtx_vec_common.h"
>  
>  static inline void
> -cpfl_tx_hairpin_descq_reset(struct idpf_tx_queue *txq)
> +cpfl_tx_hairpin_descq_reset(struct ci_tx_queue *txq)
>  {
>  	uint32_t i, size;
>  
> @@ -26,7 +26,7 @@ cpfl_tx_hairpin_descq_reset(struct idpf_tx_queue *txq)
>  }
>  
>  static inline void
> -cpfl_tx_hairpin_complq_reset(struct idpf_tx_queue *cq)
> +cpfl_tx_hairpin_complq_reset(struct ci_tx_queue *cq)
>  {
>  	uint32_t i, size;
>  
> @@ -249,7 +249,7 @@ cpfl_rx_split_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *rxq,
>  	idpf_qc_split_rx_bufq_reset(bufq);
>  	bufq->qrx_tail = hw->hw_addr + (vport->chunks_info.rx_buf_qtail_start +
>  			 queue_idx * vport->chunks_info.rx_buf_qtail_spacing);
> -	bufq->ops = &def_rxq_ops;
> +	bufq->idpf_ops = &def_rxq_ops;
>  	bufq->q_set = true;
>  
>  	if (bufq_id == IDPF_RX_SPLIT_BUFQ1_ID) {
> @@ -310,7 +310,7 @@ cpfl_rx_queue_release(void *rxq)
>  	}
>  
>  	/* Single queue */
> -	q->ops->release_mbufs(q);
> +	q->idpf_ops->release_mbufs(q);

Looking through the code, the only in the ops structure is the mbuf release
function. Presumably this is to account for AVX512 vector code vs
non-avx512 code with different software ring structures. Based on what we
did using other drivers, we should be ok to just use a flag for this -
something that uses only 1 byte in the txq struct rather than 8 for a
pointer. Having a flag is also multi-process safe - using a pointer will
break in multi-process scenarios.

>  	rte_free(q->sw_ring);
>  	rte_memzone_free(q->mz);
>  	rte_free(cpfl_rxq);
> @@ -320,7 +320,7 @@ static void
>  cpfl_tx_queue_release(void *txq)
>  {
>  	struct cpfl_tx_queue *cpfl_txq = txq;
> -	struct idpf_tx_queue *q = NULL;
> +	struct ci_tx_queue *q = NULL;
>  
>  	if (cpfl_txq == NULL)
>  		return;
> @@ -332,7 +332,7 @@ cpfl_tx_queue_release(void *txq)
>  		rte_free(q->complq);
>  	}
>  
> -	q->ops->release_mbufs(q);
> +	q->idpf_ops->release_mbufs(q);
>  	rte_free(q->sw_ring);
>  	rte_memzone_free(q->mz);
>  	rte_free(cpfl_txq);
> @@ -426,7 +426,7 @@ cpfl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>  		idpf_qc_single_rx_queue_reset(rxq);
>  		rxq->qrx_tail = hw->hw_addr + (vport->chunks_info.rx_qtail_start +
>  				queue_idx * vport->chunks_info.rx_qtail_spacing);
> -		rxq->ops = &def_rxq_ops;
> +		rxq->idpf_ops = &def_rxq_ops;
>  	} else {
>  		idpf_qc_split_rx_descq_reset(rxq);
>  
> @@ -468,18 +468,18 @@ cpfl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>  }
>  
>  static int
> -cpfl_tx_complq_setup(struct rte_eth_dev *dev, struct idpf_tx_queue *txq,
> +cpfl_tx_complq_setup(struct rte_eth_dev *dev, struct ci_tx_queue *txq,
>  		     uint16_t queue_idx, uint16_t nb_desc,
>  		     unsigned int socket_id)
>  {
>  	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
>  	struct idpf_vport *vport = &cpfl_vport->base;
>  	const struct rte_memzone *mz;
> -	struct idpf_tx_queue *cq;
> +	struct ci_tx_queue *cq;
>  	int ret;
>  
>  	cq = rte_zmalloc_socket("cpfl splitq cq",
> -				sizeof(struct idpf_tx_queue),
> +				sizeof(struct ci_tx_queue),
>  				RTE_CACHE_LINE_SIZE,
>  				socket_id);
>  	if (cq == NULL) {
> @@ -501,7 +501,7 @@ cpfl_tx_complq_setup(struct rte_eth_dev *dev, struct idpf_tx_queue *txq,
>  		ret = -ENOMEM;
>  		goto err_mz_reserve;
>  	}
> -	cq->tx_ring_phys_addr = mz->iova;
> +	cq->tx_ring_dma = mz->iova;
>  	cq->compl_ring = mz->addr;
>  	cq->mz = mz;
>  	idpf_qc_split_tx_complq_reset(cq);
> @@ -528,7 +528,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>  	struct cpfl_tx_queue *cpfl_txq;
>  	struct idpf_hw *hw = &base->hw;
>  	const struct rte_memzone *mz;
> -	struct idpf_tx_queue *txq;
> +	struct ci_tx_queue *txq;
>  	uint64_t offloads;
>  	uint16_t len;
>  	bool is_splitq;
> @@ -565,8 +565,8 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>  	is_splitq = !!(vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT);
>  
>  	txq->nb_tx_desc = nb_desc;
> -	txq->rs_thresh = tx_rs_thresh;
> -	txq->free_thresh = tx_free_thresh;
> +	txq->tx_rs_thresh = tx_rs_thresh;
> +	txq->tx_free_thresh = tx_free_thresh;

Rather than one big patch, as here, the process of changing the code to use
the common functions might be better done in stages across a couple of
patches (as was done for the other drivers).
For example, a good first patch would be to keep the separate txq structure
in idpf, but rename any fields that need it to align with the common
structure names. Then later patches which swap the dedicated structure for
the common one are simpler and only need to worry about the structure
names, not the field names.

>  	txq->queue_id = vport->chunks_info.tx_start_qid + queue_idx;
>  	txq->port_id = dev->data->port_id;
>  	txq->offloads = cpfl_tx_offload_convert(offloads);
> @@ -585,11 +585,11 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>  		ret = -ENOMEM;
>  		goto err_mz_reserve;
>  	}
> -	txq->tx_ring_phys_addr = mz->iova;
> +	txq->tx_ring_dma = mz->iova;
>  	txq->mz = mz;
>  
>  	txq->sw_ring = rte_zmalloc_socket("cpfl tx sw ring",
> -					  sizeof(struct idpf_tx_entry) * len,
> +					  sizeof(struct ci_tx_entry) * len,
>  					  RTE_CACHE_LINE_SIZE, socket_id);
>  	if (txq->sw_ring == NULL) {
>  		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
> @@ -598,7 +598,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>  	}
>  
>  	if (!is_splitq) {
> -		txq->tx_ring = mz->addr;
> +		txq->idpf_tx_ring = mz->addr;
>  		idpf_qc_single_tx_queue_reset(txq);
>  	} else {
>  		txq->desc_ring = mz->addr;
> @@ -613,7 +613,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>  
>  	txq->qtx_tail = hw->hw_addr + (vport->chunks_info.tx_qtail_start +
>  			queue_idx * vport->chunks_info.tx_qtail_spacing);
> -	txq->ops = &def_txq_ops;
> +	txq->idpf_ops = &def_txq_ops;
>  	cpfl_vport->nb_data_txq++;
>  	txq->q_set = true;
>  	dev->data->tx_queues[queue_idx] = cpfl_txq;
> @@ -663,7 +663,7 @@ cpfl_rx_hairpin_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *bufq,
>  	bufq->rx_buf_len = CPFL_P2P_MBUF_SIZE - RTE_PKTMBUF_HEADROOM;
>  
>  	bufq->q_set = true;
> -	bufq->ops = &def_rxq_ops;
> +	bufq->idpf_ops = &def_rxq_ops;
>  
>  	return 0;
>  }

<snip for brevity>
