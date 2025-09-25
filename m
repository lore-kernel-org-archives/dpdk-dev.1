Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDF4CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 14:47:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE2394065E;
	Thu, 25 Sep 2025 16:47:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id D9A1040657
 for <dev@dpdk.org>; Thu, 25 Sep 2025 16:47:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758811631; x=1790347631;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=p60XMnKeMf2hlfpQs7k+gZKT/qOD4hbB3LlAvr9SPzQ=;
 b=OJguQJq6RrWTJSw+uEPdkjLrpAuf4/vdSzSc6vYOeEvgWDyQd5u7PDv9
 z2/07dyazcis1RBH0/xSahUsb3YDAIY2pKIXyLcFpJBLwQ2juUQeeZHAQ
 1bDvkPYACUmW4yW5UsFZ++kmwOc7A7pU+PMwsFZfgm/PIaNl7TP8jPu36
 5KTFXh7jRcIxI4pSyFigIl85H5HIGYI5cw9zNsSfeo748N+ib3gS72n/S
 TmUe0pDfGgMZ692HWpTCEcSxl4i52U3qhqPojZnS/nNE47AoscAZ84fep
 jrDY4piub0gSaINgUL0IR1FThAyfG6oihWds8lvrMtZRw71P4MJRUiqlh w==;
X-CSE-ConnectionGUID: Vu+R4dM+TYyZRwip8/4YUg==
X-CSE-MsgGUID: H3Yyy7weS4eYsGrAdhlOZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="78770477"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="78770477"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 07:47:10 -0700
X-CSE-ConnectionGUID: wv3ORVVxROSDETG4TF0t0g==
X-CSE-MsgGUID: UqlhGHqtRJSlLxGhxvvZ6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="181641547"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 07:47:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 07:47:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 07:47:08 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 07:47:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6KIBBBJXYbsRbAdD9uhu1pqlkGnfTlXjOT27iBhE2XfYPxVe/g4zUvla7GWFqHqfev/rpjXZ+H+c/RlkZRabdfliCpxzSp/Y5nx05qfGKRL0sr7J1JMBG+s/4jZYRd553ANBLsEOzh6aFrhLIi/FOLGJSXORnGFzmKt89xE8Upwsu3BG1t1+5UHuH4cZUrbsvRuTd1vyLFQpDpip77r0XkSN2c9g8h9pxZqjdg5Z8+qSthkwrz13812f6qfsKvopz6xCcv6ZEJhcMC74/6ypaijP97bHiTMrTcVSdzhAkl8MeU6x25P9sWUtq5nTEHrUyVCnSoui16mlPK865OiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZTrZTaL5YJyOBrRVzqizPIG/OoYwCreWbq+oyBeqLQ=;
 b=WppPUI51/Ve6nGB98LSQBNwrK3ytK2Bj2C+1LRc1mHppuCr7lN11sPsuKLsbn6hjhIAeA+8wEh/Rp24KynwGttpV4sRQvhrIkMfxxnk4q94aS4aZiiYBdgXFt6+gUfAIkgesgnXx6TZDmSXb90nXD/ycgfVSwSaav5j0+uf/YkUBSutTzASYORlh1Vm/x7g7uIHnySla+kRvr5en+qSg0goGmQSXp29B3zkFN3Yy4l0jfiwjhlKNbPv0CqAWMOPo++yGfbGP4Po8OcBynLpkQiqPsIqUMhTNS0tKkYb/zM2EdttmumqVSPVzo19chjWsV93HBRK6DS/HT3Gqggb2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SA2PR11MB5033.namprd11.prod.outlook.com (2603:10b6:806:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 14:46:59 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 14:46:59 +0000
Date: Thu, 25 Sep 2025 15:46:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v4 6/7] buildtools/chkincs: use a staging directory for
 headers
Message-ID: <aNVV3PwL39sY-W80@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250925123150.3063298-1-david.marchand@redhat.com>
 <20250925123150.3063298-7-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250925123150.3063298-7-david.marchand@redhat.com>
X-ClientProxiedBy: DB8PR09CA0032.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::45) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SA2PR11MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0a70cf-746c-46b7-5aba-08ddfc4260e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4JIdUAMqEXy+E9KMMAidSacs6apDcPRmXK9yHjtjA/eKwNHvD2JdYQM14QfS?=
 =?us-ascii?Q?DhVR56uxnV5Hl0krG4bBkjTWuFDmzhGjMe90LmGJCO6bxwsJ5DHUjmnZINiv?=
 =?us-ascii?Q?Dp8NCTY6qcfIp8m76PaUCEGdGgdZBNiBvH+c1GHpQFpvL3ImGGGL1i2+CzrC?=
 =?us-ascii?Q?eo78RVf/CZPOrEYTxk7rtELLOcoigj6dzOXRPCJAjowHSFbxxpxdjmPc0Q9e?=
 =?us-ascii?Q?TnpAbCmxCUE/tSjoUiA+1QUwiQZMOjY4ItTAIjiM6Ux1DZMECNe+a0bgHGt0?=
 =?us-ascii?Q?0aLqGdln+EP6iAAsav6QByg9hH1SyIWgztE+FuS/CFIW+wTP7aEG03yXRSyD?=
 =?us-ascii?Q?b30O21R2wka92q8QoyJEl5uft66F3d7QjcwHIveNYzYEImwKuHUVCg6Z1vFc?=
 =?us-ascii?Q?kEvCHpRnMNOMwjChmnF6nJIdAB9ZCFR+0oaDSWZjTvlh3h+Vc/XZBGAvOjJG?=
 =?us-ascii?Q?IdAiPpDPxcrsVsnbzsFmxTch+srSSVA2x995FyOML2UbyQeccHBOSy01HQCJ?=
 =?us-ascii?Q?3Jl8CmyTFK92jslxm9w1Sv6d212PVqO29n5obYuSxa3V/RRzxmugA/0LWDs/?=
 =?us-ascii?Q?FeCiS8JHGKG3wlUjAaRUc3wu2bIkrEFYyP94/pL7HsgIywO871cgJJVK4M1j?=
 =?us-ascii?Q?Z5/KwMulEnND6dZxptNPhY6ePDjUU4jPiMYgmBY3/UtnejGiMHCS9E19TJx6?=
 =?us-ascii?Q?n2GnA1ujqKl27xirZ15riiqtOGv67oPq8tWYeru0WBniiltTImX54l64g81u?=
 =?us-ascii?Q?sV29X0OECsKu1twM+qWU2o4ktyRuIt0mNTXHtorM6nqmGzBUKUuIvVpnIpu8?=
 =?us-ascii?Q?GbcAxjm7i1+7CqTT9sAFTcornK+yJHU1ancLZ4zcnb/hizLm/RGbgxJYeuZM?=
 =?us-ascii?Q?qCuNo8AoARkdeJ33P6xFP3u24aHULHTSTWe5xzgu3jjtteQyRMco/aotMg+H?=
 =?us-ascii?Q?IVMpfrPD39Qjrl/acV7n2Aug26zPzfAeMycQ9otEyYpUoSgpYG/yzhaaS9Vh?=
 =?us-ascii?Q?niNYeqaT0XnjLLCEZsDM3DcqE1OfRJoQgVwhIQcDObKfs9pAE7iNqFXMNSgW?=
 =?us-ascii?Q?yzHgxFEMHMN1F3sRQ5XTLJoVLXPEFtNzZmm/vs8WpL9ZX//oNYUEwlnLi/Da?=
 =?us-ascii?Q?32zfyTfHm4VNV5ofQtAVhfGT/+qe61M1AEUJ513xL5mxEOFeBOQ7gVcWqDMk?=
 =?us-ascii?Q?D+Z2pz8Ff1Mo4c5UR0d0IeA9RcG2FTyLUVq1V87y6BeLSn6PGV4Og0zGLA9Z?=
 =?us-ascii?Q?kfIAiG6eJaX5ZKb07a4E7eNw1NlneIQOVmBUFqCoKdyg9mY2KmMsB3CKPuM7?=
 =?us-ascii?Q?iOtxjv7Fk+aFPyMhTXSJ+KKz3l5OpiDNBk31r9YdFQhJ/841mvqfz85vbB/Y?=
 =?us-ascii?Q?dxTv3GFPLPSIvFT5CQJBft6u02Cr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hdf2brAJgjsnmyrwFcIZEtDjhiCI2BFKnIZ1bgn7gIwedDVK9g+G9XnBEgRw?=
 =?us-ascii?Q?LRcEAt9cEusAh2sCA/GSmFIQeHkASO5X+UlnfY12RJIl2q1lw6O3v8qOFIDh?=
 =?us-ascii?Q?yuuHTAu7bMoEbeZrQEo8xmwetCYS2LRm7nrHRRSuelmcixxYErKq4UlXWTJN?=
 =?us-ascii?Q?7HMKXP32mHGDiZwGLQmAFJsoGmlL3N10tWeE+RHd6z7jVxRXicBQY6t2jTNX?=
 =?us-ascii?Q?csLC0w2wN/ZpUflbCGgXjnYn6vY97YCIPSrLD60eFqhia+QqrBy1B49heFn/?=
 =?us-ascii?Q?/2bSr5E4Jr2eyktDViS7214WOwEq17Xyxngnn/PDnnH8z9RebiANP+u4z036?=
 =?us-ascii?Q?65nR0AgJHdfj487nEIxKd2frDggtKKKxgHNgZ9w/kT1eqY8hGKGM8aCU0RqA?=
 =?us-ascii?Q?ZX/AO9/6YGs0P962gotvh9k+5f7ggu1VxkEzNnZhqlZDY5BHwqU3SsxfDE+i?=
 =?us-ascii?Q?amAi6pV/tfwZAULF5ekB1Pmm2I4YE1T6rcxw6maApDXxiUCSk6BfUE//ndwf?=
 =?us-ascii?Q?lyBfEJXoB6XzegNjTkdZxxvh83vewC5ShyCWly2BHU3spjTw+gjhhdmhXS5s?=
 =?us-ascii?Q?bVWhmkU1DILxqkp+eCXBeI8ZedoMKQxl2Dkinou8AVJVfR9KrSBAqhr0nbyq?=
 =?us-ascii?Q?cXC2BbS2SfkzYis4i4OFicM21/xeZCLfWExrKdfZ1iBV8ibvtrZ27AIGZXMe?=
 =?us-ascii?Q?dNEmNeKlwLxRTP5Yxts7wubitNe+d2SlWmms2VCuK+4cOo3i/ouhH6bvewNo?=
 =?us-ascii?Q?WlPXkInqujtS+WXQoJEJuPJPbxgV0xsPNYkXLhhwl5p7F+euKRS34xYDxsI8?=
 =?us-ascii?Q?OvuEcypVOfWEp4eq65vnbe171y0YnepB06rPJbdMdLe246fmzezNp6zpb7lK?=
 =?us-ascii?Q?GHYKEZ2OuiQmUBGw9kxF4gBDHTlR818XxNduhwpIkRk7rzMTAzgDn0qeIb8L?=
 =?us-ascii?Q?JlZavZ7dQyV2hNa/319hDhYwCMsf2KBF+lXPdkQpxeZ9RzF5PSV5HKV00tU5?=
 =?us-ascii?Q?QOQgHAGaLsF9jVbahb0Xw2z69lZZ9UgWaXgzTZhvWVnaEEOQXTr0KATo/1hq?=
 =?us-ascii?Q?ZSx3Zim+NGfranr5Ea7kbuG5PSIpV6VQqIn/8nWpMO5dMuFeAH/J9ZqLfI4A?=
 =?us-ascii?Q?XRW7THqFZ49CaFU6w0SmPirf9LHCiU6zesbLwtOvdsIkswpp9Dvr5qQQZtJW?=
 =?us-ascii?Q?d8XDfttlYdWBHtKv17cKNagalv6h/bfokwY1sSHKyS0wecTfWZ7rjPdvgHT2?=
 =?us-ascii?Q?XjKQTw38NoT/eZcLuoxHi9VQKVCi7Dje2vCaB9acwtIs6lA6vcClXnYVuhlI?=
 =?us-ascii?Q?yKEvn85tsseLX+ikeVqAUUJIAX/AAvMZHvP5A6GMRXt5XN8yF0wPc8D8tI3e?=
 =?us-ascii?Q?BsI4lrI2KQHrQzV1NUrKFqh+T51JTiZBb93joQc9Wh2ifE8OKmjSpWb/8LEM?=
 =?us-ascii?Q?e3M52UI2LD8xNkQ2TWo1dyhDuw9hFczsvAwFqn69o29zWXr8hPVWcClZgV4X?=
 =?us-ascii?Q?z+WxP6+ZQ6fi6PvSLL3BaY+ydyEc+DCQ7ecZVP0cguh5eignQdd8SMeCQlft?=
 =?us-ascii?Q?VDybUaOoBDzybB4eGiisDRU1xCK5hahcViD3IuCJzT9F79QydPjJROiFx16H?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0a70cf-746c-46b7-5aba-08ddfc4260e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 14:46:59.2362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nFwEbANz5lUMaZH/UxZkFsUthvT8m9UepMcr6OTYo5k3UVw4cHIvGDkIzcJi9Aa/kFdzRp654dZFZ17Eo++wmazJzLr2vir7ePC7lUkqIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5033
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

On Thu, Sep 25, 2025 at 02:31:48PM +0200, David Marchand wrote:
> A problem with the current headers check is that it relies on
> meson dependencies objects that come with their include_directories
> directives, and all of those point at the library / driver sources.
> 
> This means that we won't detect a public header including a private
> (as in, not exported) header, or a driver only header.
> 
> To address this issue, a staging directory is added and every header
> is copied to it.
> 
> Drivers and library headers are staged to two different directories
> and the check is updated accordingly.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v3:
> - removed update of global_inc (which was unneeded, and probably was
>   what triggered a Windows clang build issue reported by CI),
> - moved all staging operations under a check on check_includes= option,
> - moved staging directories under buildtools/chkincs/,
> - renamed all variables to reflect those concern the headers check,
> - made chkincs binaries depend on staging deps instead of having the
>   libraries/drivers depend on them,
> - added C++ check for driver headers (missed in v3),
> 

Hi,

a few ideas and suggestions inline below. One I feel most strongly about is
removing the extra meson.build files and just assigning the paths at init
time to save the extra subdir calls. Otherwise, with or without any of the
other suggestions:

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> 
> ---
>  MAINTAINERS                                   |  1 +
>  buildtools/chkincs/meson.build                | 69 +++++++++++++------
>  .../chkincs/staging/drivers/meson.build       |  4 ++
>  buildtools/chkincs/staging/meson.build        |  5 ++
>  buildtools/meson.build                        |  1 +
>  buildtools/stage-headers.py                   | 32 +++++++++
>  drivers/meson.build                           | 26 ++++++-
>  lib/eal/include/meson.build                   | 10 +++
>  lib/eal/meson.build                           | 12 ++++
>  lib/meson.build                               | 27 +++++++-
>  meson.build                                   |  8 +++
>  11 files changed, 171 insertions(+), 24 deletions(-)
>  create mode 100644 buildtools/chkincs/staging/drivers/meson.build
>  create mode 100644 buildtools/chkincs/staging/meson.build
>  create mode 100644 buildtools/stage-headers.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1a2729be66..76672b67c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -131,6 +131,7 @@ F: buildtools/get-numa-count.py
>  F: buildtools/list-dir-globs.py
>  F: buildtools/map-list-symbol.sh
>  F: buildtools/pkg-config/
> +F: buildtools/stage-headers.py
>  F: buildtools/symlink-drivers-solibs.sh
>  F: buildtools/symlink-drivers-solibs.py
>  F: devtools/test-meson-builds.sh
> diff --git a/buildtools/chkincs/meson.build b/buildtools/chkincs/meson.build
> index 49dbc55254..376556f5f4 100644
> --- a/buildtools/chkincs/meson.build
> +++ b/buildtools/chkincs/meson.build
> @@ -12,38 +12,47 @@ gen_c_files = generator(gen_c_file_for_header,
>          arguments: ['@INPUT@', '@OUTPUT@'])
>  
>  cflags = machine_args
> +cflags += '-Wno-missing-field-initializers'
>  cflags += no_wvla_cflag
> +cflags += '-I' + dpdk_source_root + '/config'
> +cflags += '-I' + dpdk_build_root
> +cflags += '-I' + dpdk_chkinc_staging_dir
>  

Two minor suggestions, 1) should we not use "include_directories()" here to
pass these properly? and 2) would using the existing "global_inc" value as
include path not work ok? Is the reason for not using the latter the fact
it includes too many source dirs?

>  sources = files('main.c')
>  sources += gen_c_files.process(dpdk_chkinc_headers)
>  
> -# some driver SDK headers depend on these two buses, which are mandatory in build
> -# so we always include them in deps list
> -deps = [get_variable('shared_rte_bus_vdev'), get_variable('shared_rte_bus_pci')]
> -if dpdk_conf.has('RTE_BUS_VMBUS')
> -    deps += get_variable('shared_rte_bus_vmbus')
> -endif
> -# add the rest of the libs to the dependencies
> -foreach l:dpdk_libs_enabled
> -    deps += get_variable('shared_rte_' + l)
> -endforeach
> +cflags_drivers = '-I' + dpdk_chkinc_drivers_staging_dir
> +sources_drivers = files('main.c')
> +sources_drivers += gen_c_files.process(dpdk_chkinc_drivers_headers)
>  
>  executable('chkincs', sources,
>          c_args: cflags,
> -        include_directories: includes,
> -        dependencies: deps,
> +        dependencies: dpdk_chkinc_staging_deps,
>          install: false)
>  
>  executable('chkincs-exp', sources,
>          c_args: [cflags, '-DALLOW_EXPERIMENTAL_API'],
> -        include_directories: includes,
> -        dependencies: deps,
> +        dependencies: dpdk_chkinc_staging_deps,
>          install: false)
>  
>  executable('chkincs-all', sources,
>          c_args: [cflags, '-DALLOW_EXPERIMENTAL_API', '-DALLOW_INTERNAL_API'],
> -        include_directories: includes,
> -        dependencies: deps,
> +        dependencies: dpdk_chkinc_staging_deps,
> +        install: false)
> +
> +executable('chkincs-drv', sources_drivers,
> +        c_args: [cflags, cflags_drivers],
> +        dependencies: dpdk_chkinc_staging_deps + dpdk_chkinc_drivers_staging_deps,
> +        install: false)
> +
> +executable('chkincs-drv-exp', sources_drivers,
> +        c_args: [cflags, cflags_drivers, '-DALLOW_EXPERIMENTAL_API'],
> +        dependencies: dpdk_chkinc_staging_deps + dpdk_chkinc_drivers_staging_deps,
> +        install: false)
> +
> +executable('chkincs-drv-all', sources_drivers,
> +        c_args: [cflags, cflags_drivers, '-DALLOW_EXPERIMENTAL_API', '-DALLOW_INTERNAL_API'],
> +        dependencies: dpdk_chkinc_staging_deps + dpdk_chkinc_drivers_staging_deps,
>          install: false)
>  
>  # run tests for c++ builds also
> @@ -58,21 +67,37 @@ gen_cpp_files = generator(gen_c_file_for_header,
>  cpp_sources = files('main.cpp')
>  cpp_sources += gen_cpp_files.process(dpdk_chkinc_headers)
>  
> +cpp_sources_drivers = files('main.cpp')
> +cpp_sources_drivers += gen_cpp_files.process(dpdk_chkinc_drivers_headers)
> +
>  executable('chkincs-cpp', cpp_sources,
>          cpp_args: ['-include', 'rte_config.h', cflags],
> -        include_directories: includes,
> -        dependencies: deps,
> +        dependencies: dpdk_chkinc_staging_deps,
>          install: false)
>  
>  executable('chkincs-cpp-exp', cpp_sources,
>          cpp_args: ['-include', 'rte_config.h', cflags, '-DALLOW_EXPERIMENTAL_API'],
> -        include_directories: includes,
> -        dependencies: deps,
> +        dependencies: dpdk_chkinc_staging_deps,
>          install: false)
>  
>  executable('chkincs-cpp-all', cpp_sources,
>          cpp_args: ['-include', 'rte_config.h', cflags, '-DALLOW_EXPERIMENTAL_API',
>                     '-DALLOW_INTERNAL_API'],
> -        include_directories: includes,
> -        dependencies: deps,
> +        dependencies: dpdk_chkinc_staging_deps,
> +        install: false)
> +
> +executable('chkincs-drv-cpp', cpp_sources_drivers,
> +        cpp_args: ['-include', 'rte_config.h', cflags, cflags_drivers],
> +        dependencies: dpdk_chkinc_staging_deps + dpdk_chkinc_drivers_staging_deps,
> +        install: false)
> +
> +executable('chkincs-drv-cpp-exp', cpp_sources_drivers,
> +        cpp_args: ['-include', 'rte_config.h', cflags, cflags_drivers, '-DALLOW_EXPERIMENTAL_API'],
> +        dependencies: dpdk_chkinc_staging_deps + dpdk_chkinc_drivers_staging_deps,
> +        install: false)
> +
> +executable('chkincs-drv-cpp-all', cpp_sources_drivers,
> +        cpp_args: ['-include', 'rte_config.h', cflags, cflags_drivers, '-DALLOW_EXPERIMENTAL_API',
> +                   '-DALLOW_INTERNAL_API'],
> +        dependencies: dpdk_chkinc_staging_deps + dpdk_chkinc_drivers_staging_deps,
>          install: false)
> diff --git a/buildtools/chkincs/staging/drivers/meson.build b/buildtools/chkincs/staging/drivers/meson.build
> new file mode 100644
> index 0000000000..b19b1c0908
> --- /dev/null
> +++ b/buildtools/chkincs/staging/drivers/meson.build
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright (c) 2025 Red Hat, Inc.
> +
> +dpdk_chkinc_drivers_staging_dir = meson.current_build_dir()

Minor nit, but I don't think we need to have this file and the
staging/meson.build file either. Since all they do is assign paths, I'd
suggest that we just assign the paths directly in the top-level meson.build
file where we define the staging dir variables. (Even if not, I'd suggest
assigning the vars to '' rather than [], since they are not array vars
anyway).

> diff --git a/buildtools/chkincs/staging/meson.build b/buildtools/chkincs/staging/meson.build
> new file mode 100644
> index 0000000000..0b05656330
> --- /dev/null
> +++ b/buildtools/chkincs/staging/meson.build
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright (c) 2025 Red Hat, Inc.
> +
> +dpdk_chkinc_staging_dir = meson.current_build_dir()
> +subdir('drivers')
> diff --git a/buildtools/meson.build b/buildtools/meson.build
> index 32cea7cff7..561236e0af 100644
> --- a/buildtools/meson.build
> +++ b/buildtools/meson.build
> @@ -27,6 +27,7 @@ get_min_meson_version_cmd = py3 + files('get-min-meson-version.py')
>  get_test_suites_cmd = py3 + files('get-test-suites.py')
>  header_gen_cmd = py3 + files('gen-header.py')
>  has_hugepages_cmd = py3 + files('has-hugepages.py')
> +stage_headers_cmd = py3 + files('stage-headers.py')
>  cmdline_gen_cmd = py3 + files('dpdk-cmdline-gen.py')
>  check_dts_requirements = py3 + files('check-dts-requirements.py')
>  
> diff --git a/buildtools/stage-headers.py b/buildtools/stage-headers.py
> new file mode 100644
> index 0000000000..3057c6a26f
> --- /dev/null
> +++ b/buildtools/stage-headers.py
> @@ -0,0 +1,32 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright (c) 2025 Red Hat, Inc.
> +
> +"""
> +Headers staging script for DPDK build system.
> +"""
> +
> +import sys
> +import os
> +import shutil
> +from pathlib import Path
> +
> +def main():
> +    if len(sys.argv) < 4:
> +        print("Usage: stage-headers.py <staging_dir> <meson_stamp> [headers...]")
> +        sys.exit(1)
> +
> +    staging_dir = Path(sys.argv[1])
> +    meson_stamp = Path(sys.argv[2])
> +    headers = sys.argv[3:]
> +
> +    staging_dir.mkdir(parents=True, exist_ok=True)
> +
> +    for header in headers:
> +        file = Path(header)
> +        shutil.copy2(file, staging_dir / file.name)
> +
> +    meson_stamp.touch()
> +
> +if __name__ == "__main__":
> +    main()
> diff --git a/drivers/meson.build b/drivers/meson.build
> index f25f425565..dae1e83ca4 100644
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> @@ -245,7 +245,31 @@ foreach subpath:subdirs
>          if get_option('enable_driver_sdk')
>              install_headers(driver_sdk_headers)
>          endif
> -        dpdk_chkinc_headers += driver_sdk_headers
> +        dpdk_chkinc_headers += headers
> +        dpdk_chkinc_drivers_headers += driver_sdk_headers
> +
> +        if get_option('check_includes')
> +            if headers.length() > 0
> +                dpdk_chkinc_staging_deps += declare_dependency(sources:
> +                        custom_target(lib_name + '_header_staging',
> +                                output: lib_name + '_header_staging.stamp',
> +                                command: [stage_headers_cmd, dpdk_chkinc_staging_dir, '@OUTPUT@',
> +                                    headers],
> +                                install: false,
> +                        )
> +                )

Rather than using an external script and custom target for this, would the
configure_file() meson function, with "copy" set to true also work for us?
https://mesonbuild.com/Reference-manual_functions.html#configure_file

> +            endif
> +            if driver_sdk_headers.length() > 0
> +                dpdk_chkinc_drivers_staging_deps += declare_dependency(sources:
> +                        custom_target(lib_name + '_driver_header_staging',
> +                                output: lib_name + '_driver_header_staging.stamp',
> +                                command: [stage_headers_cmd, dpdk_chkinc_drivers_staging_dir,
> +                                    '@OUTPUT@', driver_sdk_headers],
> +                                install: false,
> +                        )
> +                )
> +            endif
> +        endif
>  
>          if headers.length() > 0
>              dpdk_includes += include_directories(drv_path)
> diff --git a/lib/eal/include/meson.build b/lib/eal/include/meson.build
> index d903577caa..92aa1c885d 100644
> --- a/lib/eal/include/meson.build
> +++ b/lib/eal/include/meson.build
> @@ -79,3 +79,13 @@ generic_headers = files(
>          'generic/rte_vect.h',
>  )
>  install_headers(generic_headers, subdir: 'generic')
> +if get_option('check_includes')
> +    dpdk_chkinc_staging_deps += declare_dependency(sources:
> +            custom_target('eal_generic_header_staging',
> +                    output: 'eal_generic_header_staging.stamp',
> +                    command: [stage_headers_cmd, join_paths(dpdk_chkinc_staging_dir, 'generic'),
> +                        '@OUTPUT@', generic_headers],
> +                    install: false,
> +            )
> +    )
> +endif
> diff --git a/lib/eal/meson.build b/lib/eal/meson.build
> index e1d6c4cf17..4ffd048ab1 100644
> --- a/lib/eal/meson.build
> +++ b/lib/eal/meson.build
> @@ -12,7 +12,19 @@ endif
>  
>  subdir(exec_env)
>  
> +arch_headers = []
> +arch_indirect_headers = []
>  subdir(arch_subdir)
> +if get_option('check_includes')
> +    dpdk_chkinc_staging_deps += declare_dependency(sources:
> +            custom_target('eal_arch_header_staging',
> +                    output: 'eal_arch_header_staging.stamp',
> +                    command: [stage_headers_cmd, dpdk_chkinc_staging_dir, '@OUTPUT@',
> +                        arch_headers + arch_indirect_headers],
> +                    install: false,
> +            )
> +    )
> +endif
>  
>  deps += ['log', 'kvargs']
>  if not is_windows
> diff --git a/lib/meson.build b/lib/meson.build
> index a67efaf718..34f930f12e 100644
> --- a/lib/meson.build
> +++ b/lib/meson.build
> @@ -214,7 +214,32 @@ foreach l:libraries
>          install_headers(driver_sdk_headers)
>      endif
>      dpdk_chkinc_headers += headers
> -    dpdk_chkinc_headers += driver_sdk_headers
> +    dpdk_chkinc_drivers_headers += driver_sdk_headers
> +
> +    if get_option('check_includes')
> +        lib_headers = headers + indirect_headers
> +        if lib_headers.length() != 0
> +            dpdk_chkinc_staging_deps += declare_dependency(sources:
> +                    custom_target(l + '_header_staging',
> +                            output: l + '_header_staging.stamp',
> +                            command: [stage_headers_cmd, dpdk_chkinc_staging_dir, '@OUTPUT@',
> +                                lib_headers],
> +                            install: false,
> +                    )
> +            )
> +        endif
> +
> +        if driver_sdk_headers.length() != 0
> +            dpdk_chkinc_drivers_staging_deps += declare_dependency(sources:
> +                    custom_target(l + '_driver_header_staging',
> +                            output: l + '_driver_header_staging.stamp',
> +                            command: [stage_headers_cmd, dpdk_chkinc_drivers_staging_dir,
> +                                '@OUTPUT@', driver_sdk_headers],
> +                            install: false,
> +                    )
> +            )
> +        endif
> +    endif
>  
>      libname = 'rte_' + name
>      includes += include_directories(l)
> diff --git a/meson.build b/meson.build
> index 2423884df7..82498bcf54 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -38,6 +38,11 @@ dpdk_static_libraries = []
>  dpdk_shared_lib_deps = []
>  dpdk_static_lib_deps = []
>  dpdk_chkinc_headers = []
> +dpdk_chkinc_staging_dir = []
> +dpdk_chkinc_staging_deps = []
> +dpdk_chkinc_drivers_headers = []
> +dpdk_chkinc_drivers_staging_dir = []
> +dpdk_chkinc_drivers_staging_deps = []

As called out above, the staging dirs are not array variables, so I would
initialize them to the empty string instead. However, we could also just
give them their final values immediately here e.g.

dpdk_chkincs_staging_dir = meson.current_build_path() / 'staging'
dpdk_chkincs_drivers_staging_dir = dpdk_chkincs_staging_dir / 'drivers'

>  dpdk_driver_classes = []
>  dpdk_drivers = []
>  dpdk_extra_ldflags = []
> @@ -74,6 +79,9 @@ global_inc = [include_directories('.', 'config',
>  
>  # do configuration and get tool paths
>  subdir('buildtools')
> +if get_option('check_includes')
> +    subdir('buildtools/chkincs/staging')
> +endif
>  subdir('config')
>  
>  if is_linux
> -- 
> 2.51.0
> 
