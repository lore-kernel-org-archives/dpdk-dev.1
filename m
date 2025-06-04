Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC55EC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 14:14:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E70A42D80;
	Wed,  4 Jun 2025 16:14:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id B6C57427DA
 for <dev@dpdk.org>; Wed,  4 Jun 2025 16:14:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749046445; x=1780582445;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2zFurHLrsDwsj1UGXdslQIv8pPSgbUHEjfnDxliR6Eg=;
 b=IiM7h8YSl4RnBNqIE3RjGW5hZ3vJfv/GDR/8go4imdfaE7CvnBO/k7W+
 w/ncbDcyKwjg4Y3d0/FfAI8/KhQ6WOuOhEdER7DdsB+Vr0O18W9Ca8qGQ
 vHXSoUd4GXJjaycKU6nCvDsXJE6LOr/QIOFdF+evxM9B903IOZMxLUdl3
 nuvhMs6dka6hWxFomakIKcrLKpDpb+Kg61OheyUclebhi7i1hfJTkOYfV
 EwYTQE/Prz5s/DjK7OKsyCLMIrLQHnPolADayajecH1MztTA5ND31FQsI
 rvMSbQL9vDV4O3C+1YfYCCU1YCjuExgNuXq3hamMCqSMa96S7hbR06EmY w==;
X-CSE-ConnectionGUID: ue3Hx6VQThivNVs9J6Wu2w==
X-CSE-MsgGUID: aN71JYUnRxeU7Cv9krvV/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51133828"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="51133828"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 07:14:04 -0700
X-CSE-ConnectionGUID: sz5tuSvrRkG9ONjzqj46zA==
X-CSE-MsgGUID: jG0uLAr9TjKn/WureSVwmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="149036995"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 07:14:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 07:14:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 07:14:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.62)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 07:14:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQXc3qzfwGhYsxMygfM6ZqSRObKUNuM/vtEr8MXs7DIjbRgammMSlGPlPITKUs1s60urlzrE3ovl2rSyH1xfObFScfTwcL1sjy4p1bXPYms49ex6bqHxRcffjTkUlfbQnfcE5iyr5Y6vTchyjJlcbS7LjnNnuNfq+SEBx9DIOxb3TlX4RtQfp4nyLMxE5Mdq5/nW9RU8Uaq+/3NS6BMPEDABgq+Ke92abuqgHCAEQu8FeYHcgIlVCIAZKCRaoTFLtdOJv7CMg44JwYi5KWP3J25e1L4KA4f0pTmnv+tEwHwV02TFnbo9KgrF5Tp0RzqAG88DBrotlIY4F2yk59/ccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eb5iuFTgQH/5pMpVlIXlyoKui4061hCTNg5H0uhhNcU=;
 b=sl7QBJycbzMXeFt8YDNfXriLaT+m92M1vUvsRuKJLR7HxLuDBDympAx0j7Wzbx2V7K6xH/Cyb49LxMOerMjoX1pOO4hI1D4e6I7TiUah+Y9DZ8MxFk9WsLTQe0ZBm++nhkx+LfGNvuAkexUt+iqLASKXlWWpoehpypl1KGyQo7luY8kmsmxvf+KLPNIK45rLzQisuPAxFsbfK1zV7iG1NhtK52YjjIaSCIS+gMFD9YXrWxbkJUtZAEeKSuf02YR/iguOLnU9SjN0xSLxWRInIvZjcBNzcLaqqOSTfLMObDA/aiSmxFF/ODX7FFmfvv9vzVlZoDSKr6Fl/uagAB2ZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7140.namprd11.prod.outlook.com (2603:10b6:806:2a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 4 Jun
 2025 14:14:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 14:14:00 +0000
Date: Wed, 4 Jun 2025 15:13:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 1/4] eal: add macro to embed information in binaries
Message-ID: <aEBUo5B5EIT2eLG1@bricha3-mobl1.ger.corp.intel.com>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744839898-15745-1-git-send-email-andremue@linux.microsoft.com>
 <1744839898-15745-2-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1744839898-15745-2-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU7P194CA0020.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: c90188eb-b914-4c9d-9d74-08dda3720d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bLjUytcY0+9cVL3qkJrrcyUFmIjytCccyMqcy+GR6PemduZJw8DHMui/nQuw?=
 =?us-ascii?Q?ot/t5P20VbDC6sgKAqzDDp7ie6ubq74D44XsDjOAl4rPv7H0DudRGeBPQOv6?=
 =?us-ascii?Q?dYEty7G1bAYMJcnggHQrKyxWO+3PJ57KjaR/nSdf6jrfb+JIaSASmAeaX5c7?=
 =?us-ascii?Q?Blu/irwx/TEuxmuEqx0eNqxOYGEGrQxyQQRlsGjBJ8hLWBc1b0PteOBiwiPZ?=
 =?us-ascii?Q?Dbz8dJRe0YhAUIKV6vBQksrzrwr4tPbLT+Tc7vAiLnVCKGWCJVbEb6Ku17pz?=
 =?us-ascii?Q?vT/auU/vYJlA2h+gZl9NAix7lNFBLl2anOnTeHhGgTZ2GJXaabn+2YH/gxj7?=
 =?us-ascii?Q?sqtxBy2AIr3/I/YAJF5tsZbI08j2DVtPL5KiHjvItnwkKuWVbS+/rJ74QS7a?=
 =?us-ascii?Q?eHLrydTSqkGjbyc61i8l887UDEkJTojnM7SokJahjqonyA8EU3M5tyeETd0h?=
 =?us-ascii?Q?YNT4+eLICMwzPWKPtCpZR7tesirdCWJsIlKongHsazZ7cW94cN+Q3Wt6Vfgo?=
 =?us-ascii?Q?5Cp0UmO5z/xSDu+Hz8rYcq2ZjjS9+DR202a2E53cr/MLdBc8CGA21TaSPxdt?=
 =?us-ascii?Q?UqufaR6gib7tfajlm2BU7PyBCqqKlr9tI5M7eVh5+/bJx/s2KFUKFXIEA8kk?=
 =?us-ascii?Q?eZsTyvwipjb3b//3k8zB7hrGHol09GPnG7ilwDSv945spc/s97zvEiOPZ8WV?=
 =?us-ascii?Q?eO378oFIoBeTs6KI8ReoAtg3Z1GT0eNFldLHPfGoeI8pvb3143Bf+/JgtqYg?=
 =?us-ascii?Q?bqUfafEqKnviPuodmYFECEDOPolHLoqt+189aeFZfN9yx8dRot/O3Onhsbjt?=
 =?us-ascii?Q?kM7ij4ph2DJkgrD267FS9XDzA3KIdGHfupfya6k37BxtqWK5GMjrLD/2NUiy?=
 =?us-ascii?Q?lshJHIp7m38ECtq4wqVzqE38PgG5KDE/ZJTYOQqvvB5+YR3V5gLzoosuUsdt?=
 =?us-ascii?Q?78I/H15XHAXHSfatGtBAnd0+S4v5JAkJJA/WvPc7G+J8ecUfw5wpyWiT35Cp?=
 =?us-ascii?Q?QWFG+QcQNDIdHgByZHwco1i6PXW8k+WqAlr0t1StYOfEZO+FkwQ+e8zMKuO+?=
 =?us-ascii?Q?q+/FnTCC7SESDMk2dkZGmN1A2evRSgaFjUb934FI4ZGznUsXU/7Rr/kFJOE9?=
 =?us-ascii?Q?qySWpvmQemw1WTuOneMbWrl5JvbArgGN8r8VoN3BU2P3GZGE19EBh/bafxEH?=
 =?us-ascii?Q?6eJTUSnuwtfancVuRsmMl3jsouxOD8fcF3N74KZATlkY9K/wyizh/ewXNF8n?=
 =?us-ascii?Q?evqdSWcvz5tniESdiyeMxgrWO8P+O7kQlsW+tqLy6Po23LoHvFsbZG5uIQEr?=
 =?us-ascii?Q?nmg3eLVVQByQY6c64kBKiVMKJHLVPcnh+YTaJe4BPpcQnNMXtUUxjxYrKqUd?=
 =?us-ascii?Q?i9nMDdb+/XQLsIb2LMeT3mE6lyK4Gyj+MDoGUzPVHZbhTK7uYNrsAcgOzS+H?=
 =?us-ascii?Q?o+XugiFLsVc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kg4ENCrM/6rL/MhTfLLd0TqjABwcz6ks1g6T4g9D50Vks2mPyqfBOnoJQa6w?=
 =?us-ascii?Q?DKrgW+oX7Ff8+Tv/sWDBuexHIyP48Efb1whp2OtFX7Qw9DBsYOb76OGVvZYo?=
 =?us-ascii?Q?IliG/mgOX2rdSqH8cKh2I9olrI9W99SP05Gp8mWvoGx6vzwnxZu3h6LxO/DK?=
 =?us-ascii?Q?kSJVWJdcMaVPcQ6nBJzu4+TrIlMCyNl+ASldML1wdHQPkNzahGQqnZgTiwp5?=
 =?us-ascii?Q?KvXs7guQMirHZJDPzgZsOosGxYA+DaudoWATeiDhZ6lH3pTwWJPkf+zuDoFs?=
 =?us-ascii?Q?H+kYwudt5lhjoNHZ2braZxn1CxqjYM7tNbmChkw6opv0Na0XOC88kLbCJsq5?=
 =?us-ascii?Q?SzKorWTNciriAirCdW0l6Yvpnh5jypBHl+xgWNpgTuHfWeikFUq54zaEucma?=
 =?us-ascii?Q?rRCCDoMHYyHUpNrMkr6diJAB5KN+ab7zwlZsiTZtrq4zevetw2XmrBFkO4Am?=
 =?us-ascii?Q?eWNqUN3gYs1FtZWeXa6qf1SOx9LNmhB8DYvGrqhWpLDhs7rmhPbpVWFrtAjd?=
 =?us-ascii?Q?bwTOYRf8M6eZck7yQVRwJPE+rKHDGeE1mO8Vs/skAMGFNv0PKVMG8cqtlWEI?=
 =?us-ascii?Q?sYporZS0fcIIiHOUlRNKWa1j8AnQvjhhqbwbBvzV9/MsdJTUbowiwdUdPmKc?=
 =?us-ascii?Q?Tl4vipru62+43pc4Q/iLTkazRQcmpZkS0lNKWxEVQRe9dfBb20WPQ/DuNOWy?=
 =?us-ascii?Q?GyoIxh9CU8epCkYAX634vEZrMfJf1lnjwjsKBJeGn0G41M+WBG8B8NwqIYxl?=
 =?us-ascii?Q?AcvaXZ0EPteoZVn05fC6jXlAsEfgBRm3fSOlCRJ8v0MEVyc8n7qWbJFykSv8?=
 =?us-ascii?Q?8bA4blhqg+Lzo1f42ZBwujGImhtPMZQirwfG54mgq8TbqR8cbuPfYo0e9wmX?=
 =?us-ascii?Q?kcre49St9rN8hBZKzsVoHezIB5c9hT+N8icrgidGv+0ZtD1yM+VJR/fKwgLw?=
 =?us-ascii?Q?jm4LWfFdppQU2vQAKbg3LLs0w9zCHK5XzAUR1Pz3LARG1h+uRcBSF31NaZUK?=
 =?us-ascii?Q?NSn8KZ46VpTf/n19s19Q2qh8xVq8gIsclAjPeGUBD2sL8b0XW/4Us4dte8U6?=
 =?us-ascii?Q?m304YFNXS5GuIsnLyfvw8VHE/KQZ3FmTL1BeIE2KEE+JHDcPhfJVsOLqcNHf?=
 =?us-ascii?Q?EB4OvztgMqBI6H/NdnEPxXltvmGcU16q5eDcXi3Zdht4cmnEO0FI3TV2W0dv?=
 =?us-ascii?Q?/TE/EqBeGkKtF7FmNB+c0X3f0iO09DIcCKRg7Dmpc9CUvbQTtzORDmTtB2nV?=
 =?us-ascii?Q?8eUQj2ChQ4L+8gz1WTNEmRulMwU5F15GhLHLl/uQrNaaVQvYTndCYrRF5JRZ?=
 =?us-ascii?Q?24ZJYVDJrLIIJ/iNnIrO7SuzjV/KkpYEjm9U/659g6nU4ilRMsqpsHF0fVg/?=
 =?us-ascii?Q?sliYmiQDUeDDKyHYKNxOm+4lzoYca9uhGHa9dyd1JOKiwQy0HgUpwyNRSNuG?=
 =?us-ascii?Q?mHnRqR+1a6cPiWKRxpIdc9LUcPBP8xWGTvuCf4r6cO8oA0wUBut/8hXt3w7Z?=
 =?us-ascii?Q?T+Ptrqua4a0BRkNIX0DiP9CQbA9djHks1JCE5NKwASo3aVWvjgV60fkk7vsJ?=
 =?us-ascii?Q?FML0p+qk5AGnt9RAP1J16Ymb+ddvHKg1NXHUIVnPeDNgpzqtW5kwMEy4B/KX?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c90188eb-b914-4c9d-9d74-08dda3720d06
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 14:14:00.1485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtP+YS6M8y15W9LtvjBkc69dK7CFbNUHXJ7OHmqxYVK4I+PNHNO7DIo04y70DKUORi2svJjU0FwJywycUmjD166yiDP5jJ/g0nPB3toFm8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7140
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

On Wed, Apr 16, 2025 at 02:44:55PM -0700, Andre Muezerie wrote:
> DPDK uses GCC attribute "used" through macro __rte_used to indicate
> that a variable not referenced in the code should be assumed being
> used and therefore not be optimized away. This technique is used to embed
> information in the binaries, by having crafted information stored in
> them.
> 
> MSVC offers similar functionality, but it differs significantly: MSVC
> requires a pragma to be used to send a command to the linker telling it
> explicitly the name of the symbol that should be included (even if not
> referenced). As a side-effect, variables called out to be included cannot
> be static, otherwise their symbols are not "seen" by the linker. This
> restriction requires some DPDK code to be refactored.
> 
> To assimilate these requirements/restrictions, macro RTE_INCLUDE is
> introduced in this patch.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/eal/common/eal_common_options.c | 2 +-
>  lib/eal/include/rte_common.h        | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
> index b6fff7ec05..8d115a5bd7 100644
> --- a/lib/eal/common/eal_common_options.c
> +++ b/lib/eal/common/eal_common_options.c
> @@ -135,7 +135,7 @@ static const char *default_solib_dir = RTE_EAL_PMD_PATH;
>   * Note: PLEASE DO NOT ALTER THIS without making a corresponding
>   * change to usertools/dpdk-pmdinfo.py
>   */
> -static const char dpdk_solib_path[] __rte_used =
> +RTE_INCLUDE(const char, dpdk_solib_path)[] =
>  "DPDK_PLUGIN_PATH=" RTE_EAL_PMD_PATH;
>  
>  TAILQ_HEAD(device_option_list, device_option);
> diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
> index a6085dce27..4c5a3b668f 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -231,6 +231,12 @@ typedef uint16_t unaligned_uint16_t;
>  /**
>   * Force symbol to be generated even if it appears to be unused.
>   */
> +#ifdef RTE_TOOLCHAIN_MSVC
> +#define RTE_INCLUDE(type, name) __pragma(comment(linker, "/include:" RTE_STR(name))) type name
> +#else
> +#define RTE_INCLUDE(type, name) __attribute__((used)) type name

Any reason we shouldn't also have "static" here, for the non-MSVC case?

As a general question, is this needed for any/many tasks other than putting
in place strings? Rather than having a general include macro,
I'm just wondering if we are better doing specific macros for the driver
string, and then other-string use-cases.

/Bruce
