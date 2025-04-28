Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB2FC369D5
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 15:00:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0673140667;
	Mon, 28 Apr 2025 17:00:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 925BF4021F;
 Mon, 28 Apr 2025 17:00:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745852411; x=1777388411;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tN+O4gEI3hBwh6Ycy48AtUAR613kDEXw0XLcD+9T0wk=;
 b=fdn8OCbE9GDK1kApZZzo4ZqU1z08IDV1lHLtGJNs3oH5IyrHJZYgTulH
 psTh/TCeudXOyPYdxz+TsKoKUnUoLGVpAm1BJM5U0m0nmPpLzZix3cEpA
 bUGatt0IeTvPcuA8erhxIwzF/NZOj9disTnBhM572ehyWYmQXOcZ/ekis
 ij5Me0ZJdloNz/iXunBce2nSCFMrx2KFIQLYWKNWPq4Fpy3N5ZeKx/ozF
 fmxJd12yBeF8Dc4U3I9yhszt4Xj7jn7ZInq+57UPMbnWHXfIxJ9RSnO8m
 043Z2z1uuZADoP80Vwco6Zl+ALTUW0QlgrBlrSVyQUN4RWYqNcQw7e/Oj Q==;
X-CSE-ConnectionGUID: xYU/oUIkRSahrs5IEoqjMg==
X-CSE-MsgGUID: vZG1vnmCRBqD3fgAfsFoLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="51254978"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="51254978"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 08:00:10 -0700
X-CSE-ConnectionGUID: nwqEL3+uSbqCV+sX2IZQfA==
X-CSE-MsgGUID: nUUxnBcFStiDLJpl1+jc7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="164623790"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 08:00:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 08:00:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 08:00:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 08:00:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4vpRHGwdqdmGvbUOMPv2a1ON9Wg0F0i227h+aSDj8Uvzd/nJC9FEyqYtVM+YBKc9Xxvtx4+HIJgYb8lOiuLc2KjPtBb3UJqbIXHFgfIQXky0pu4Rnhpvl7dnpPdFEEoY+hk30/XN0YoMOtFGZRH1Uw2mVAf/hZ7ahpufccahMrY8fN/hFY9Iwo1Du2LyXHW7OFRad2SKcIliSuzkfi11QGAATMeBTRSjfYOo+pXhz68vyTn5HMwNp9wBKm3+0JTIe8OjLFfN4zJ12neGjF6m5VyBNMqd8HCbCT9d7WlM/o2ww+Tppf/Ov+jFaXpViFB+NwwbE8YlNK0opK2tjo8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0O3HpmWURsgA5lf5+X+C6ep3MrKtEdr8QutR7B4sm4=;
 b=epMBSA2iUB55z4bF6d5vxuoD6jl59lwZPXMc/XF+29I2PT3a2LlA4r3lnuDYyq3Es225a5MSTnwTMeWBeqOR1zVKVHrYya9pHeqpSPHjrbhoifoBj55tHg5zV7uTVNFtiTXWxlkCJTAmK/HVhARcszXVsIN500ABGrqma+j7+Q3YjYavE3jRyyJGG4IZRa4JTYIn4W6Rk3cXzyprMBFYT+d+L5tCgrslLCZsLWTvmUgoZEXdSSeBfrQJY7SpZiQFM2Y464xEcDuDZMIUCqIkz2C+lYb+gFqc3H7FPXtsdYVTmYw8Dc9MOO7+OX7McBJ9rGPi3GG/t6qrV8N7Jd4HEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7825.namprd11.prod.outlook.com (2603:10b6:930:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 14:59:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 14:59:36 +0000
Date: Mon, 28 Apr 2025 15:59:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Liao, TingtingX" <tingtingx.liao@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice: fix Rx of large packets
Message-ID: <aA-X0lL-otgUXRJl@bricha3-mobl1.ger.corp.intel.com>
References: <20250408155736.2739406-1-bruce.richardson@intel.com>
 <PH7PR11MB685914C66497FD23FB074C9892BF2@PH7PR11MB6859.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH7PR11MB685914C66497FD23FB074C9892BF2@PH7PR11MB6859.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0318.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: e89ca72f-b96f-43e6-551d-08dd86654b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jfvT1fsUQ9wmU3FoTyka4rJs4dMOPKpRV7wOpnB3N+lGGjD6KcZwkmnG+6yZ?=
 =?us-ascii?Q?rT2krH9eOEai1VCuOWnlBJyfGgpqTErvm1FRa2n8mCCqshnd9FbpETIjO9CG?=
 =?us-ascii?Q?ynZEyYHlD1Z3yEqjG3yjXvWHWPI4gXkfoPS1mQeOvulujyIA4f+k5B8MWqtA?=
 =?us-ascii?Q?HrCWkPJHoLgp0cZ/0NWnCrNl3vjDpDhmOq3kVzeTWnPJQxleBf6JNnUfcSKw?=
 =?us-ascii?Q?HMTNGIVPOsVcbiivtJww3XOh08W9iEaYsPyVV6CI0uHrZs0viiCjtmOS7oDt?=
 =?us-ascii?Q?OV1Lzax68ZVFCq5Km93kn3GmWfGxUbA7UFWCW1OLhB8AUr54uz2e0/1gp2DH?=
 =?us-ascii?Q?VC7ZO0Q1pYavmmBnFF4kqcvDQzKz72ZuPCz+JfrvBZH9WVoCW+h1dxVMvLof?=
 =?us-ascii?Q?PgKqufo8OzgDUnEM/sKSYC99SyFAzJf1ufwE2sW/PrmaG9QWLXFTxOrc50x4?=
 =?us-ascii?Q?gGTziSjc2t9k5u8dDIg8TYzZYb9Yl7a/+8XW+vWYv3E1P3asYAIIj5bLOzc4?=
 =?us-ascii?Q?h/AsF2DPezkw4VZL/4eaf1g4nVk31lP+3obQXTSX+zqTfQmY+zJ1NNQB5cJP?=
 =?us-ascii?Q?aXcUiaN1ISAUthKP682HqVqmK4taUi+gd8X+B8Z8eQ7Ft68LB9gwWlMtKKOx?=
 =?us-ascii?Q?ZRi8vhZTNCxveHxYC5sDoQOBNECjsdWAaY42PrJTBD+kK5dwKGrbyye/0KCC?=
 =?us-ascii?Q?naklbUpaZ5yUN8TMucBagLKLTVF5gVchvesKJkgm6nfFN+aLqR5vrhMLD1Sm?=
 =?us-ascii?Q?by4+f7wN2hzaI29sIA7NBfSM5YZUxziF8jSATz/Z5ky84e6VxTToM7woEfty?=
 =?us-ascii?Q?4KjukktiCYWaVlG75ffFRdRjBCxV8hroWjtMkRfjJ37YSfmqKd6Zf60TdzNK?=
 =?us-ascii?Q?NuJQDt031R/CKKCO1yhg79UyG6WIIriJsjHllE0o+08+uyg2Qm5nA4pIW8qY?=
 =?us-ascii?Q?NIwnvbwSV+Hfwg355DG3+O/FMTZ/ZqqUtcVSOBPaoF2fImrSFR7B8ZXGDddS?=
 =?us-ascii?Q?D/e+tyJ4lwBVdAH2lFPb/EAr9VhRH0htJ7UIGBUgiKjKEx1+vJGstBGorTru?=
 =?us-ascii?Q?+jQJ8rmacKlFlOfWKU69algjNDJT0n5e0Nsgs0m5lkje340i6bbbVHCn+KWP?=
 =?us-ascii?Q?hWWaRgQV4DgZwNtHYqdj+Mc7zkYSLPSXUeHKc6OukSk0SKIRrLJcnqKY/IYT?=
 =?us-ascii?Q?H/DOajlP6ayN6OAJilwFj9zwmcfwe8w7issQ33vQ+B5c6QkTz34VCVKXlTui?=
 =?us-ascii?Q?r3u0lHYsdArMYdjBOAmf+vfno89K0TPwWMIunRchA5k6NEwbASeJLRaSdoVF?=
 =?us-ascii?Q?8IXLdOWmOunf/212xccSCXAcIfuJRGA1JxEWVwc6Llli3teqwp3R9nF7CLd2?=
 =?us-ascii?Q?M3sWaXtk+VPhVaIa8GR6f0iZCxA9C1AWg+4ehyuvbXL/h2VrEcl40jmWWrIN?=
 =?us-ascii?Q?MNV6BvrzKEs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S4C6yzQLC5aZLZX7oIZu4xq6V3GBPR0WgLGwITsi6Bs+//9wLTQBwb3hNg8c?=
 =?us-ascii?Q?GEqEO/KsTso6AyuGhtXxIlSQiPThhGTmIdLKZYXJ4VkgDjtYDIecYudOoqCz?=
 =?us-ascii?Q?DPNSlh5UvWLeIuf+Xcmkrnat2TGjvjwKg+6eaLhrbO1sU2HPUmDbFj6JMDjX?=
 =?us-ascii?Q?Iz52Frn9k9cV1z2EM86cDt/RhpcRTelFVVgitAJ7KeMjIkYpNgB/Zd8zXZVQ?=
 =?us-ascii?Q?JjIVKZZQgOW51za9A2FdJhWVbrxADTNejzYop4JZqPIsto+PewJYYB5A05BZ?=
 =?us-ascii?Q?C9f3NyE+/znEU++B3DBVhz4AMWKCoZlIXpM/sUyZL538N2nr0crbQlerFPCM?=
 =?us-ascii?Q?YOG1PBbUbqfG6iqCdv7vGZ0lXOJQY5lc0gZGBVeORfOYutKvd3hhiB5YZYDF?=
 =?us-ascii?Q?L9RQEAK/6xaf3L01jP6GOO5o+z7zUz0zj8yl6yx7W7FIDuHYu3UpmBGaGCgD?=
 =?us-ascii?Q?PFxjrpzd1NygSTwrXJjiAasM5pOvEWFf2F0rsI+X7w8oLHsTMjECPyfHFhyH?=
 =?us-ascii?Q?qvUKl80vigWSNXKhmPPZncGm9JT8rc4/Y20uY9r7cVTzvCoZ0k0lPOwaRHxI?=
 =?us-ascii?Q?A/14DzoHkAgsQiwAvvRQmgeqcy/uy7etgCKT1wBqc/9miwlHlbpM3pezeO++?=
 =?us-ascii?Q?D9gSrutV7qN//6q4mReKybbzdLnsPel/FT8NlwyWkREtBJHcmPVkh5U9xnRE?=
 =?us-ascii?Q?yQbLgPMP6C8LwRFWveR61eE1HL2e7fEb2zj2xrJA6IRj8TMJbxAk7x0PtYmR?=
 =?us-ascii?Q?kEVfReX3VNrDYQ7UtLezR8KS6rmtne5X2GgFkFmTuYVDt+NaaBqEqCN9b2cX?=
 =?us-ascii?Q?NrGPeC6FQikc9WsaLSpN2yXaGpfuIf6C7kV1LPoswgBbgp02/zz2XrKeN504?=
 =?us-ascii?Q?QuvWHSrYlKloafwXsLmWEZSVH+eM6GlNA2V9Mk80r8n+2PvWcKLauC9ddLWU?=
 =?us-ascii?Q?wJzmgzKOQpc56EOETTswTu+6p+K3X5efrRAKBX43yF4HIO4xaR3bbWIlf3Q2?=
 =?us-ascii?Q?UBVi3qQDkOCzqB5F1b4SXx/vTWjttNTciiE2w54wiCjIRITLaH/CoKOjuysZ?=
 =?us-ascii?Q?yPctkFHOSx4bEtjIo37PRLt04I/UCB9xGnrtlIzzo0HyhMtgtIC/KrxCBQNV?=
 =?us-ascii?Q?3viy5ndVb+6ZPfIZ8r9NW0DjOxgFRjhowGmIpygPMmB2s83ZrjGXindb3a2s?=
 =?us-ascii?Q?Z3gfv289IBY81jgZqyr+pPVzfpuF7lYG+Yq3AyqWVAwsmspBKQI5M8RtJ/Sx?=
 =?us-ascii?Q?eOAbQnHhu35wUEU44Kwpm293/g6mpzA9ME/ILnlYBGTJ6gJxJAjgsGuU/lgy?=
 =?us-ascii?Q?sgRymRQLfUGAMwHUSq2PScMCU0XyNNd5BiwRdRlYhntxOyhL3vGQauwB+lRc?=
 =?us-ascii?Q?6SPStZK658xrPuN2IjB2EqtyrYH9P5mLvTsfU4qO0BOd4laZ5cKq5574KwRD?=
 =?us-ascii?Q?NJESdXXeoeFlq3RIhyz3W4KudVSRcj/B72zGuymituBpEhGmc3RLKDRlW6H0?=
 =?us-ascii?Q?x1m3CSMTE/jc3X+EMsFmyCOig4EIBJ+Tfl/hnemBkOQ0rmp/CKIZC4I7EFFj?=
 =?us-ascii?Q?V4FOJcarR07fxegwpJWMIyYv4WZVbTI1HLX8NT6B2MLH0Sedfg8MImDGdwET?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e89ca72f-b96f-43e6-551d-08dd86654b06
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 14:59:36.7393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnwHEmuzvZoe0F3ff9EuIlxFB+ZLJo2ssMul4lXetnOSwDVFmg0YW7KZN+Uy8xdrldmVqoCDA66uoy4DEkxz5f/Pc2Ssy0uJgIzbUNcCCUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7825
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

On Fri, Apr 18, 2025 at 04:04:26AM +0100, Liao, TingtingX wrote:
>    > -----Original Message-----
> 
>    > From: Bruce Richardson
> 
>    > Sent: Tuesday, April 08, 2025 23:57
> 
>    > To: dev@dpdk.org
> 
>    > Cc: Richardson, Bruce; stable@dpdk.org; Burakov, Anatoly
>    > Subject: [PATCH] net/ice: fix Rx of large packets
> 
>    >
> 
>    > The determination of whether or not the buffer size is less than the
>    > packet MTU is made in the Rx queue start function in the ice driver.
>    > This means that we cannot choose the Rx function before we have
>    started
>    > the queues. Move the Rx function section down in the code to fix
>    this.
>    >
>    > Fixes: 3c79a3d91d9d ("net/ice: fix mbuf cleanup function")
>    > Cc: stable@dpdk.org
>    >
>    > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
>    > ---
> 
>    Tested-by: Liao, Tingting <tingtingx.liao@intel.com>

Applied to dpdk-next-net-intel.

/Bruce
