Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E99CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 12:43:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADBB240671;
	Thu, 25 Sep 2025 14:43:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 8E8BD402AB
 for <dev@dpdk.org>; Thu, 25 Sep 2025 14:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758804222; x=1790340222;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8IzHtkuM2xC9chiZqjRSf+HuKyhcObCcHStxkBxL7HY=;
 b=FdqGEd/94aMARHFx/VsR94sEwPPkYCE7nsn4EGpkzjzZaf23q58zoDch
 DJYjBwXHE4L9N7CpURt/cWe1QMfCsclpaahpBWuJsr4JUGCP3KGLkW6xY
 uMGLQ27IJb/VP/oAchI2cu7A3Mpviqt2j06E9AUbNNvHyQoNFkRe3K+I+
 ORRTJUg/bIhjdhiWysS3M5cZLYD3vfeIpo7u27ySwpI36xP2K4/6In0be
 aKEObdOemxyvuk5EEFjgc5Wx/4TRf/jDl+icmIs8mDm9XoBLcFk4XR244
 Sb/ybhEaFfM1YiZBwWRidthiXrz1CxH31mmf95/3Qywf31/S4UWoMcZ2n Q==;
X-CSE-ConnectionGUID: jk4y8pHmQ+mqDQ3hqyX3/A==
X-CSE-MsgGUID: QYzxGPEjQ22F2dW2X3MamQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64928691"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64928691"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 05:43:41 -0700
X-CSE-ConnectionGUID: Z3ve+0ZWRWKp3u/x7pUZUA==
X-CSE-MsgGUID: eH/AkGwQRwWXIxCzYFxv8A==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 05:43:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 05:43:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 05:43:39 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 05:43:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lh0eftxLsepWRt+NQU2StXQTBBD0ex6obV734ob+PeG97qLPdBPwTBS9Oi+IUCkMB6tT4TeF/ubLC32+Rc8K74Jv4+pv8ZzsA0ZkXDj+URiarom8umIBNQkZklq41m4j3bInBEw91g8aApQ+tiRhJdzKHMjbJdYU2cFZhjXL4pYbq5X3hD41OMBOH13sRJ0rhpTNwk1ybJjviK2qVnxPfey0jJsmnC1ND0MW1MjI+X63mqEPdDnBaRFGcf4jbnET2p2U2E3OpVVyf2RAyf5VTTXO7YA6UpocBBg8qLWvU5pp691XJMU6hEjCBZO7PI/WOXs1oVaHKrduXSyKVGLuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jusK0Rx5H0t5vWELLrfjEBJbPsNaeZZIHeDY6Jh69Kc=;
 b=NVjSU6IiE8Dm3oTgRfx1dTdBz3C4O5PMl/EtYgxzfnKcHdYWbhLo84eJq9i6Rv11Y3mFNBQSUQTGzjOUgSgvv5Pq0o4r+WrkO6j5BVwTrL1lO5NaohFrFJhY9pDWuGDv3EdMxMmcl9vi1SX/Ks1N54upVgXaowOTgqr76LWNPQ86dyPLRYQbmxKJJ0jZcdMqIoC7N7eAsjuuipuxm77sGbl+g616PTzEpanYUuok7JYhyBrcXoLV0mdZ6k8FHhFSkoI+Bk86Cc5APM96hZzJTb5cqLAfIg060bOmuSAD98IVpVj/DQaaaHLkmgFfMwB5SJ+epa2HQMMe1VgBzVFhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DS0PR11MB7577.namprd11.prod.outlook.com (2603:10b6:8:142::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 12:43:33 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 12:43:32 +0000
Date: Thu, 25 Sep 2025 13:43:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Elena Agostini <eagostini@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>
Subject: Re: [PATCH v4 4/7] gpudev: fix driver header for Windows
Message-ID: <aNU4779G3gH3GzsB@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250925123150.3063298-1-david.marchand@redhat.com>
 <20250925123150.3063298-5-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250925123150.3063298-5-david.marchand@redhat.com>
X-ClientProxiedBy: DU2PR04CA0176.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::31) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DS0PR11MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a37e9b-0779-45fa-c710-08ddfc312292
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AgLA0d0zg85gyauzSUN1yWZBt+YDjpkXDHBS/2+gv+EdvZ90QqH3GlsT0XtP?=
 =?us-ascii?Q?Ei//gVLg7GQRUvA6wlY/BL2M3woGCn/BitDhtsV7fg7axeMdSvB/En/6cEUz?=
 =?us-ascii?Q?ekKF+FWBjReNv6Tcss98ayXt6xXQnNfAaM8IUKaE3cGJPyZ/mw5zDCjygRsE?=
 =?us-ascii?Q?b/kQVnghLlx+w0We1JcCI2a7qdtuY2mNKj8rcArRABXPofVa/soc2TjUfqVL?=
 =?us-ascii?Q?A8ZWV1RVPKtA6VLfrCkg7VgwP9Em+k++3vlIPlOUIaECPFH2y5ikavEU5Exu?=
 =?us-ascii?Q?a5oeQYMjzeK1FuKcNa4Q+YfGSTS4D7YFPEpMMdFhxfSwAQM1fplvEMxapK2K?=
 =?us-ascii?Q?68Usj2PoXVF1O9OBO2HqCXHboOMCCTNUKq7JdxIcqdqF4DqBZV0M2uRIdkE/?=
 =?us-ascii?Q?Y7HGLQJXFTS5t1C/3QW0BRQrPhCNOBp4Bc7hBlDNu4+GqcX5zdLlA4JwlQx2?=
 =?us-ascii?Q?hXQU4gBcg/8iIn4mBGbjAh5yQTsqYjIDanGm0V9lWfJvSDgaVbayxRCX6z4t?=
 =?us-ascii?Q?EjmmWoE30dQIhJ9pB0vGvJqstIBSlKZiwrkEX9ZD+mw5sxykSwrdgi1NZNDs?=
 =?us-ascii?Q?nFS65WYABdP1dwLyWQEuOgnBX7SxyZQXwEP/C+sHKuEsAZfMSv/i1zxlGuxZ?=
 =?us-ascii?Q?abXX6JyrzHI5y6kJkg26z8JjkYLdGpfTZOqCQkB2isG8ONTHIxEJo6pQ/1fc?=
 =?us-ascii?Q?+PZlAXAnf9CHBTmyYux7a37S8qBVF/KyRyomxuF8Hoq7sFo0vfXDClkfrYyk?=
 =?us-ascii?Q?SLr/OTjc1V/2YSpVx/OE4FuU776tQdd/xWmTH4e4R+/PuuJLRGmFi5mkav6n?=
 =?us-ascii?Q?pWzZhK5wwl7mZXATb+oktfgbJhJKE6SlCsdbbx6GCrs6QXIOrgPeyAw1LWLc?=
 =?us-ascii?Q?h1olq++B/q6Xl2WONYaFGMw2Wky6wn/QBTeSpeX4bBmBJ91Usy2lf2Yc+t7M?=
 =?us-ascii?Q?/f6Wj9nB7LW84K9JuuC47KbeLbNl0P/RoL4MaRBeLrddEwQcPvOoCXPqssTn?=
 =?us-ascii?Q?6HIzIh5H86WbdOtydwa80OvVBB7qE9eHNpK8xtBT+Yfaeay1K8d+K9vI92mp?=
 =?us-ascii?Q?3GeYksT5WdGxHmIJSEfrCoBhB/AMG+Twm51oRULBswWkpJg8ViQEpmsq0GcV?=
 =?us-ascii?Q?kJDkmojmJR161duXI38j9I1itJJRw8DUGIEPhA5ObS17uxUHZfAv74QdjC+X?=
 =?us-ascii?Q?lJyhRb9gdlJNt7sq+ARvwLrTVXwsSGsLaCDxw9FeFAmLgDaq5f6xHuRk6LWU?=
 =?us-ascii?Q?c51yVvwkBDkhatTIqbqsE80psCsnRRufhiu/ie87l+iXjXqccgeAWsVn4c+j?=
 =?us-ascii?Q?YlP7RVm1XEPwDftD/2n+VP+6a7od0Blx+1kqyFZjYhH2Oe9UhGcjKkGePY97?=
 =?us-ascii?Q?ArhbRhbMDniifT6sJjO25bd2VjRSHvNNTAyIC5qJl7lNLXQzogLdOrfIiysk?=
 =?us-ascii?Q?xMuqt3Zjbc8tIraEGSuDn6FIu1GJxaq+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HlbVHl94W6ixtblIxYi8PD0IE0gyYR2ztQ6Z6E1TiWX47OgfW2WXDCHKjLHB?=
 =?us-ascii?Q?mpUd5oPm1l55J3Ygqu45Wj5YSS2n7ywR63u2xxlr/O+2XhmTdFzTms0xZJY9?=
 =?us-ascii?Q?8kOwJUJV7z3YQzbDdf4Orux+62s/zh98zUZ26r6/ti7w+asSBOyTovzINV1i?=
 =?us-ascii?Q?CSh+7woMahqmZt2wHUckvqnVnmK6YpW/NAgMhXIc0gnYgi2VM4x1uxOwuyIU?=
 =?us-ascii?Q?LG/mut+NHHKJxjSaWT6BXTbAtYR6hR5d3qEP1Hh+pY6V9vfdjClDAYJ50Pek?=
 =?us-ascii?Q?cI9hxNAUL/5FaK2GJW+4Fb1zMsCQuP2v2PLWgJkHX4mLjg71QAvMFh6meoDy?=
 =?us-ascii?Q?ADREjAPCkHzQH56LBPEm+cXtjVP2Z6t/P4/XNri6iMOYKHPbP5olyP1FT32l?=
 =?us-ascii?Q?Inyu9MURHSDmYU4ynq9npm4hcYUhtKx3NqQIC54lytnzhwwDCJc9W9kvePJW?=
 =?us-ascii?Q?ZuUIhiF8kX/J9xPJrquB54+jtOn9Oq+rbJ3L9gyvCSY/p9GnaKdLcFW3GKGV?=
 =?us-ascii?Q?B826sFU3YV5/bAGH5XpOENRSnSY2JCMwoABBNJEevJxPZplswz4R4b03uJ4J?=
 =?us-ascii?Q?tlE/bscyAs671h61qVZUuTGyA3izIky/ZUUIWL8oDGS6sYzIIy2Eiy0/bkEa?=
 =?us-ascii?Q?QGYFeCCyQiVi2/J/839A3bNAZ2owUZHLm7q4YyEcvfZeaNx3CzCUaTgmHM33?=
 =?us-ascii?Q?FeCsASG+MEHC0Kp2qXomMHcLlas086DiNjpxENm5j3CxPJex/MOKWfQHsXyj?=
 =?us-ascii?Q?ccdkVF37Tq8XbIRgMGiR6LxUzJBwbNy8nCLDgp1SLz06MsREJndwM8qsIbuM?=
 =?us-ascii?Q?kab0LOzEPaQ+kxx2c9KAZ1YWaxsjKyo0mdyF365yarf6135H4i+oHV1Ma69h?=
 =?us-ascii?Q?SQwu/U3BPhawcKsdEdEtxHgMj2wP4Dg5v8Lm4vomQIGzT9ZYLuSWg7q7oz1S?=
 =?us-ascii?Q?lfC2CfVQ4H1gItrxZO0DdlvecQfnMuUQUxoWv2x8RrX0kZWDJAhc9vAWDnac?=
 =?us-ascii?Q?LYytYJrEjIOxi2dTZeA8wjw/boRnIUooi1sQvCyx2HzHwYEV5C2sAf5Iro+G?=
 =?us-ascii?Q?uyepFvqO+6TeuVRWiTjM9e6AcEmACgN8sL62AhI13EuDoSIdRu4/s5yLDSBB?=
 =?us-ascii?Q?lUb1MJBH6S9UOaG7ViDq1MFC+JOs3imBJ7O6Gm5a9s86BfDhAu/CNsvHEUUA?=
 =?us-ascii?Q?17WYIQiDvYVYstI2GK/muMuJi8jYgfghsESZ90thdT/n1BEyuKklsq61AMhO?=
 =?us-ascii?Q?VMsGuEZQhW+Tv/IeoSd9GgINOCxtzBrZcIcHVpAA68nY8ATE/Iw4yBRiCGzO?=
 =?us-ascii?Q?vrEynixtC7K/IT2L/t2r/YrLlTVAnYNwZyFmXNMfMTIw6fJ2L7712bkN6SjU?=
 =?us-ascii?Q?BE4YPGosW+fvMGr/4VSEAn6KxtB5XNi28bQOwv831YtTK7bie4n1vMrFgEnY?=
 =?us-ascii?Q?Z9zA7eWx79Z8xEOybaEDQNEF/ZIcKJeW/gWEr7YTcLywqwgShXqA5IMRNqps?=
 =?us-ascii?Q?7DtGWGGKqb0rwccd56gm8e+GXIW3IgiuzEww25Tv/rZrqunSdg0ijwyoM5O/?=
 =?us-ascii?Q?p+d70uf3Dx+Z6tDhlJV5DdDCz0t2I1XZFsBhRLlr7LPPwqgItXRjGZBvWev4?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a37e9b-0779-45fa-c710-08ddfc312292
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:43:32.1585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUuL8XC0U5862jMSnTp4NRnf6CHC9h+PGF2K0ZUuFkpf2Q8e7Pj57qJcGFz+iDByxu9grftmt4FlldaHyfZ0a0svmKkdjuifqMj7kIppcJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7577
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

On Thu, Sep 25, 2025 at 02:31:46PM +0200, David Marchand wrote:
> Use rte_os.h and its RTE_TAILQ_HEAD definition compatible with BSD
> sys/queue.h
> 
> Fixes: 18cb07563165 ("gpudev: add event notification")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/gpudev/gpudev.c        | 1 +
>  lib/gpudev/gpudev_driver.h | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
