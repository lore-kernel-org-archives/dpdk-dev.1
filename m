Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7F8C98321
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 10:51:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11F4C427BC;
	Fri, 25 Sep 2026 12:51:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id A52E040608
 for <dev@dpdk.org>; Fri, 25 Sep 2026 12:51:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790333463; x=1821869463;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=w7ucfYAMZi6B/tYnBYZvJ5JC1YLS0q7VhQXAqyq0QNw=;
 b=AoAlqZvNjTnPUEgdU97VVzWywMCTDSPRKyxE7mHQ9R+6eVyTVdzxc0nB
 YuCfwguHeEBKPne0T3y2ykDQHW9Goyhi458hrxBscoh0vXJRFGN/HUFD2
 e7uwE7a7Z+fweWt3TrnhuvQVu38bVPjw8LfYJcZew5YyOjgUjQYWKflFP
 5jbRFNYjRYql7Yti1bCiutf2YXFwxspKbgwt6YBjalkZoOTlWZWE+wmmS
 r03+pAwayoZI2Ep0FY2trs99n+fj2sBECX9AOXZuanirmXoDV78JiSNEF
 DHkR1yxAfJvaWsVYFIpbPVV1kx42N0/rkYIhFi92DmQPTojpmoeN2ZreW Q==;
X-CSE-ConnectionGUID: B/j3hSzYRY2SRhpAf0PYsA==
X-CSE-MsgGUID: iD5ue7gkQZGs3vhGGtHWxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90024109"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="90024109"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:51:01 -0700
X-CSE-ConnectionGUID: yRWoA7hUQ3KvJA12OU5xUA==
X-CSE-MsgGUID: F1GIb3VETSiyGHdb9Tf/6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="273793889"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:51:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:51:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 03:51:01 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:51:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMm6mQHBIRtFSnP0dEFSmMzuhg2fyC0V+xHzd7jJCOMeSM3nzgYUQGRU4aNM315/4yblrhrC1rs08uYS9cbYHCqYjXQWv9F9WU+1wMFDyNqFSokO9oJwp15PtGn2GBUIKoJ1fS/BiPDnNCO476pa3Gv8pBABt12FTCmrDjYJCJ9tPCz6MUQ1ruJ0+wcpg2MTi51FLQKnLS15RYL9VPyyt3mLciuDLm0OKumfgWg+qhHgo/xFIJwDTvaQqq60YY360egkeylWw8w8tNwrKXaE9VIzttc8UwlCRPuwnFZNw34mUZ19GtejJVKRrJKXDD9x2wm5mkF3ZZN9CI7dKd/ePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IapwBobkgVmlf/H7ZKWtliYyZpsbAgs8bJH7p1YPE54=;
 b=mm102ifPP1bz+jZWMAYcI3hFcxQhFWBDoc19OifmPekkOJppSKMYJjlmTtDGCM8LK19Pq3W8LBsSIXkgPh+PyQsN3Ridrl2zm1IiqE3p4NFjB8nN4tIEcEH/d3GtH2VgL7JdNjJh91oahKUD9sJRkX/62nGQE5H7QNr1cH12yKXizZ46mW8P883DkTOlYiLarxrDLSnFnUPKjKr1iUUrG0XiO5itGAVE/xasTRU4+R7O0WShs5Q/w1NeVXTK7FKi0kVji3Nf8RN9cfXU2D2qYBG5QUBpSHv1AbDbyA2l3aYXVOxZYT/s0t9vMPPeyYfKeBO5H7TE4DQawRe+o3efUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CY8PR11MB7011.namprd11.prod.outlook.com (2603:10b6:930:55::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 10:50:57 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.018; Fri, 25 Sep 2026
 10:50:56 +0000
Date: Fri, 25 Sep 2026 11:50:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
CC: <dev@dpdk.org>, <jingjing.wu@intel.com>, <rjarry@redhat.com>,
 <thomas@monjalon.net>, <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>
Subject: Re: [PATCH v1 3/3] doc: add AMD NTB support
Message-ID: <arZSCR-GL1jq3iqM@bricha3-mobl1.ger.corp.intel.com>
References: <20260823140639.153997-1-raghavendra.ningoji@amd.com>
 <20260823140639.153997-4-raghavendra.ningoji@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260823140639.153997-4-raghavendra.ningoji@amd.com>
X-ClientProxiedBy: DUZPR01CA0224.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::20) To BY1PR11MB8080.namprd11.prod.outlook.com
 (2603:10b6:a03:528::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CY8PR11MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 963e2eae-d82b-4025-df38-08df1af2e017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: 4u7ViYbD1q79O5VoWwkMmvAGCYDgRcGTmAaMY9+gPnRqiXtdva1NqsoxRQFS6ce3uig7IVjnFgiOYOjhATu827h2CO4dSwdhBn/3AYZVEeFlRojTllTbd/TK17sxh+m1WNpm1tNVAlx8ss/D1h/L1MdA2kCf+4oVPt8mzIexFpFzlY9v08mpviCP33ldPfhFPiNTtBMweqSqUAcKCyP6/YLxBqZSUKW28RQeSmMvpJD0bXkgQq9E/kp/ouOFyKKAYtcwkT9OCRg8M3qZoLDH00PhwB09HRz/jpqS+sAWSTs8YGMYoNcqviVQWFen63H608JfwzWhSsJbwHBhzGzm3CBzOvFgFxsYBxZw+tXsIHXPPBlTBy0TuqyQ8VIxWPtTZm1X0Z0r0S4wzZunj7hFMMz/HRHecbMa4Vmbx5zSD1Ca+HuAYeUv3iA2UuVKLLxxtyS3bIawnJEBWmbUSfZ4iu41pdfPb/nDT5XzBMBr3vvyg0gLIUmnpVCIQCDc2VGY/8QH4PoWzSQt3/cocUst8j4joaGu4+57oBvD1ertuZ3sHxoWk/m7UMbVmBoZ5SVisp5glQ3m3+lOu7w9e1xWJXEjqA9bMEYGpitFv4kqZhvyWgDhGtU8BFc4wTX6oIrCVz0kAhrT5hPAouPOmQOXssNeaucwkb6y83rO+AUuTgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sHAJveNnNJMDflqjHO0Y9QP3jZCm3oCQ5NgiZOnfxsww3lfM5w9xCRDFP/Dq?=
 =?us-ascii?Q?3wb5Im8PU5dk32etEwi7v4XUA6xUb0ffBDBmkXFnPPyTOG6SNDS3ulmIasla?=
 =?us-ascii?Q?M6yGaUAZKsSAaCIqEAXSqshzZhxZFhzk3Ck1POwKy118vI3LW00n8dnbU6DM?=
 =?us-ascii?Q?bu6zqU6ROhVfANGPXvix1e7LPzcOw2/ipxHXw+yTZCsYYENfSugBA9utqnvN?=
 =?us-ascii?Q?pRZ63kXYvg9wEnju1rPz7Q3zHLMqSHygK/D/2ZB3sdLpZDVR9FPhPp52HgUw?=
 =?us-ascii?Q?z5wEutOTfAJugdjv61q0goj/+RwyrYCRh43PRMwO/pXn9CGzQTvLUqFUkYU+?=
 =?us-ascii?Q?VcthC2KQ7F6yg8lawRjrSAw8BLtb6DytEOjDlpXM34LIkFSYEArCwaPX4UhM?=
 =?us-ascii?Q?OpQmMZpJFJ+AZ6FBOVWjpZrV8Tv30RCx0oOn7lD0NzZuT1d5QMD3C/aR8CoZ?=
 =?us-ascii?Q?9oLNtazmuZfToF4Ng3FnSyjS9YpG4M0A4IMDklGf+q9WTaRle6WkrZgQaggv?=
 =?us-ascii?Q?Er/x1pdWH81FwqqxGXJEYRRuKMIIoOJgtwbYx7hP8teEugGkUr6Tu4Zx1mXy?=
 =?us-ascii?Q?c0SRvsG/fGHGWVteJ0ZPHvch2PFW5ZDa5iR3B9QeEIpbJaClyLkbfu83ac4c?=
 =?us-ascii?Q?gIHuL+CZmaz/KvUc3sljk+38tO/qK6taBQekqGmcL6ONHrr8rNK+BcaqqEd5?=
 =?us-ascii?Q?ROo0ENIzHm1pmE3oPRSjR+QBXNCwT2RitziO1AqW6GerQPBKF5yTnOhNhuaG?=
 =?us-ascii?Q?e9FwuP2XCZwH7qLNaT7wn86ctAGwr+1ZvkjRmxrEl1Wa7jtJSgHj08vkcdeP?=
 =?us-ascii?Q?e5zCgYIUJBDbuTEozSIP34kAJuCpsQ/0rv2HorqPAkL4DYPq8NeZmBu9Q5o7?=
 =?us-ascii?Q?rwQ/9oEU8KoxZzEmkduXiQGBuURcg6MLjpdQrpj96efzFxFgenRcsHsFyJhL?=
 =?us-ascii?Q?HvNstdi3bMu1R6/12Vdu4LOwbxce2xM/44MLXfqs1B9BdXv2/nEKPL17oOtl?=
 =?us-ascii?Q?iP7QxXJdevXZH/Elu9zrwnHrx5Oy/pt30XQkxk2w52EL7O33Uh9+JiEp/f0t?=
 =?us-ascii?Q?W3LkaoaBfnH39vHPfnTFYKLdHisBPT88wRpTLUG5GT7DEa8xURVI7WrkCspe?=
 =?us-ascii?Q?Jk6sT9qRcPNguXlGNGxmsa0QdU1oiYmo4IiWn2EJob3pJP0ETCmXJYt1qg/S?=
 =?us-ascii?Q?o0YRFQNpeiTdJ0oIE6nXsvMwNNOszL2tunl4t6SvusOw6HmqOjCdnW3U/2pY?=
 =?us-ascii?Q?PUQCIHsv2nxA9hBWB1QjrCD83Vkq8oY8pVcLq9fZIgYYu/a157PUj08GcQL4?=
 =?us-ascii?Q?ruLZ/RBl3y5p3/yVAmYkXEoFxyQULUG/8/H3wvTUwaXXdpkptk3/ccxekmk3?=
 =?us-ascii?Q?CbILJM8LMfdYxaAA5mjOoj0CHp8arHR2LfpPjmjaWsvroDjEVm72Sxp0/ckX?=
 =?us-ascii?Q?Je42tqsiKGEwUfMIf7CxIX5KC+fkhCN0v9nN+YnkozxKjCsDVttKIJbwG7F0?=
 =?us-ascii?Q?CzvGPDMD1wjcSb6ko5sy7NXDt3JL8F2f1PH0uMgajk2BppncGL/BN83hxnO/?=
 =?us-ascii?Q?JJflnFEZkQxnRikJOIuweO6SuTh4CrKPqKjYHOZMkmQva9QSBbVA1PPbqJ4Z?=
 =?us-ascii?Q?hg7tHRrhX0I30WnEXjwOG0pcizOpq9YwipmOcV1mdYGc4dX352djF4nafzIa?=
 =?us-ascii?Q?LL5Acc9vUK3Hs+CS9PkJwmR3Kv4R03ddDJ+LgoA6IYqnBPErmGf3b9pf1gnt?=
 =?us-ascii?Q?NdjbvTqFDJcsWFFSLCthudjpNJgEu+g=3D?=
X-Exchange-RoutingPolicyChecked: YNGLcPITRt6q0G6BWjs+RS8FHFAigRgnSI6aNnt9UKEcRAOvywtqypeK1KyC13j53xADdiaai8q3G71sjnL1XXP40qI0FCnnwG5wmVNyYXlsrCSnyu1BEwHSFjufQLRPnG9l30YGG71Hsfr079ZYuKfF3p3q7KwGsiVYLxy3Q1LXw0iufL/tr+XVdYZ0Nqj9KbOe4CJEE29XaptyieaJKVPtxyX9c4IeOq4sD8kI3Yf04mbGtDq8V1mS9Ddm5Edzfked6e42lWNMT3/q/IWxe4NevhgIF+O1Rmkl2eZ2YxbrUK5i0WVKyGTCqRiAXTRxT53ZvplmzIPbSN2CtUWCOg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 963e2eae-d82b-4025-df38-08df1af2e017
X-MS-Exchange-CrossTenant-AuthSource: BY1PR11MB8080.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 10:50:56.6013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+3IrN/2+aIlwIpCt/u/9oZNlTOw3/gAQy51TUwFJY7y7iR5SFIWipndnjuTo3hldqiBLXgXfqhq2rpeOMmm94k5P8jsHzfFHafPbiERklA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7011
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

On Sun, Aug 23, 2026 at 07:36:39PM +0530, Raghavendra Ningoji wrote:
> Document AMD EPYC Embedded NTB support in the raw/ntb guide, add a
> release note entry, and claim maintainership of the AMD NTB support.
> 
> Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
> ---
>  MAINTAINERS                            |  1 +
>  doc/guides/rawdevs/ntb.rst             | 18 +++++++++++++++++-
>  doc/guides/rel_notes/release_26_11.rst |  8 ++++++++
>  3 files changed, 26 insertions(+), 1 deletion(-)
> 

This documentation should be squashed into the prevous patch adding the
support. See also one additional comment below.

Thanks,
/Bruce

> diff --git a/MAINTAINERS b/MAINTAINERS
> index e99a65d197..13306345fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1613,6 +1613,7 @@ F: doc/guides/rawdevs/cnxk_rvu_lf.rst
>  
>  NTB
>  M: Jingjing Wu <jingjing.wu@intel.com>
> +M: Bhagyada Modali <bhagyada.modali@amd.com>
>  F: drivers/raw/ntb/
>  F: doc/guides/rawdevs/ntb.rst
>  F: examples/ntb/
> diff --git a/doc/guides/rawdevs/ntb.rst b/doc/guides/rawdevs/ntb.rst
> index 3721b4880e..c89eaccac8 100644
> --- a/doc/guides/rawdevs/ntb.rst
> +++ b/doc/guides/rawdevs/ntb.rst
> @@ -37,10 +37,26 @@ then reboot.
>  - Set ``PCIe PLL SSC (Spread Spectrum Clocking)`` as ``Disabled``, on both hosts.
>    This is a hardware requirement when using Re-timer Cards.
>  
> +AMD EPYC Embedded NTB
> +---------------------
> +
> +The driver also supports the NTB endpoints integrated in AMD EPYC Embedded
> +"Turin", "Genoa" and "Siena" processors. These use a primary/secondary
> +topology rather than the Intel back-to-back topology: one endpoint is
> +enumerated as the primary (device ID ``0x14c0``) and the other as the
> +secondary (device ID ``0x14c3``). The BIOS on both systems performs NTB link
> +training; no additional NTB-specific BIOS options are required beyond enabling
> +the NTB endpoints.
> +
> +The AMD NTB hardware exposes two memory windows (BAR23 and BAR45), 16
> +doorbells and a single shared 16-register scratchpad bank. The scratchpad
> +bank is split into two disjoint 8-register sets, one owned by each side, so
> +the driver uses a packed handshake layout that fits within 8 registers.
> +

The documentation needs an update on the alignment requirements and
handling - either the need for the new alignment API if one is added as I
suggested, or else details on how the app needs to handle it itself (which
is less preferable).

>  Device Setup
>  ------------
>  
> -The Intel NTB devices need to be bound to a DPDK-supported kernel driver
> +The NTB devices need to be bound to a DPDK-supported kernel driver
>  to use, i.e. igb_uio, vfio. The ``dpdk-devbind.py`` script can be used to
>  show devices status and to bind them to a suitable kernel driver. They will
>  appear under the category of "Misc (rawdev) devices".
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index c8cc86295d..0b364ccbd4 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -55,6 +55,14 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
>  
> +* **Added AMD NTB support to the NTB rawdev driver.**
> +
> +  Added support for the NTB endpoints integrated in AMD EPYC Embedded
> +  "Turin", "Genoa" and "Siena" processors to the ``raw/ntb`` driver.
> +  The NTB rawdev framework was generalized to support multiple vendors,
> +  with AMD-specific hardware access, a primary/secondary topology and a
> +  packed scratchpad handshake.
> +
>  
>  Removed Items
>  -------------
> -- 
> 2.34.1
> 
