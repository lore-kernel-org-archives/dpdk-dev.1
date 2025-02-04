Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BC6C02197
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 10:32:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF01B40661;
	Tue,  4 Feb 2025 11:32:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id B06FE40265
 for <dev@dpdk.org>; Tue,  4 Feb 2025 11:32:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738665158; x=1770201158;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=O+qtYVxhYxh6+smE3lLZ5vGjp+FRYmdYrJdUhh4wAO8=;
 b=mOtQrlhSlhcdxpGwwxLcWs661BPVNXIcLTd2RqBFMR8g8LMz51hCVAts
 VQ5M1Ewchv1mfFWqeHVTBc6csAA4s4ALvpo4NYz9gyh2rRCy4haa5MNOV
 I3HN23Es8E7z7ZOUOMuhXGi++WnJv9rpfMr0tCbfGx+c/H8unF0GhQfPG
 7WIpIiOb0Kh5TdylxYWpNmuElSOthDCAep64yJwKA5Obnh/K0TJPutVvR
 g0AGVO6tMEwYBR67uOimJiGKcZPpEeGbQ3rPS+kQIBNxILvCQdNmafDHs
 927rirvYW3earbCl5ml8poLxgR1aUgO+v9svG0Lsefgn6hYbwhOorAW+d A==;
X-CSE-ConnectionGUID: 9hyb3WD8S+6mmypuMOMkdA==
X-CSE-MsgGUID: duZ6xLGgT9+eWRX3uPX8GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="39084537"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39084537"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 02:32:36 -0800
X-CSE-ConnectionGUID: u1imlk/WT3K5QHFpfN4kgA==
X-CSE-MsgGUID: 7rF8aaMXQFCodwEdtSwo/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="115551628"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Feb 2025 02:31:40 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 02:31:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 02:31:40 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 02:30:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=im2kK4ywyqHP0w5UNhprvPrIVDPFu9eFzifu3DaYRkMK7WovkHB4ryf6qkw+aYeYj+jDuBZBYVmR59dpkL293GcbFr67xH4Xt1/knKHIW5PsVjNiGaScmI7PFrX/8L1Z4G+poPVFYumAlTkmdDCPPqSUoDjcxUEH+rwEhSPe3626+Y2clF4hdmHjgpIjpHHvGaw4Z5B6RcDD5RRcgiXpC/18NXezcF5eOqDHONi224mbS298f3zCfGpZgOVdfLZELv0p6HFrYMX5JdXbI/EqfdXKLCwOmAZ8J5fdfNwamXdCyxu1z+5ctR5seOoIxrguRYGonToPytaTw+JPk4pFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mknmsKm0bWk60xjlRQPO0Ee547giiHIuZSKkhz4PHW0=;
 b=dfUUOuVxWa691+CUXWxzgMYAUOpdqFnOosIN/90zZ5Y+85xOCfGOV/h1ZnP2dKhNBtvTrhG0TkPbubhCyazh/xsuk3o6Gwa1Da5QQraevBaPj6kwuQd0dBEFOVPd7z4P41hLtqmSp6J2FxOAm9CjNCY7pkHv/eu3CRKvOru2YgFj1qkRSLPA2a9sFJwFOYapf0jQn/WrZSyKlFFK9+5J0XIyHMoXFgtaekzzx3M0Qez6QAtKTIif/Y1L2r0DivrFqpjowc1vufUru2K0ki7Wx61ygAY4vEc8FRj/1bdDdNB/ZaxkpFdrkFxqr4kHbBmkWPXRxAcVUcquTcrzgSX0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5057.namprd11.prod.outlook.com (2603:10b6:303:6c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 10:30:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 10:30:08 +0000
Date: Tue, 4 Feb 2025 10:30:03 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>
Subject: Re: [PATCH v3 2/2] stack: enable build with MSVC
Message-ID: <Z6HsKwpeQKyA-dYv@bricha3-mobl1.ger.corp.intel.com>
References: <1733848355-19048-1-git-send-email-andremue@linux.microsoft.com>
 <1738634318-12876-1-git-send-email-andremue@linux.microsoft.com>
 <1738634318-12876-3-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1738634318-12876-3-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DB7PR05CA0021.eurprd05.prod.outlook.com
 (2603:10a6:10:36::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 73986977-e6c4-4de1-70b6-08dd4506e5c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5EL+NZLxURUxdbUH3dsdyE/x6g4t0vm4KVs7q2Swnc+wJ//Rv7ZxiiA16g9P?=
 =?us-ascii?Q?wibUCiKRykRA+Jm1/uIdzDKAOF8epxKjj1RRH51CxSqs4u1EA+xb9Ls6M3Ob?=
 =?us-ascii?Q?Io1jzCGOPnnUUICHMfU9NT9+gd3qxOuoapVGx03DvQw5cpdyIAOaYZEWB7yc?=
 =?us-ascii?Q?7AWDy2TkKCFpkZtH+8If+1K8JxRR8kMbiSRQJy3F+qtJRaSc/abjg3RtrZBA?=
 =?us-ascii?Q?9Eu00G7lgxtBTUX/GiPkLN5aRuUEfXnRnMh+axJOYfrveVLhda/6e2SBdPu6?=
 =?us-ascii?Q?tyuY+jPL5lo96oMZBORrIj5qMyFKiplEcfvnZox6tg9pjSGogaNNZP8DjNlh?=
 =?us-ascii?Q?0zS2fqusZSUkkCqT02vnK4UZeQ10Pd8vhUXDNzHyPKZLKpk/AwLFA5sk/xvu?=
 =?us-ascii?Q?SS9V3DNKqBsewFx7pyuY8NvZ36k5MoUwZCAO8trjEcHYpGSf8O68Ttbn386R?=
 =?us-ascii?Q?mVesTw5KnZiajjczpoDrA7B4tTKhoDogYLJYkjTpJjeEzJ3vynPYNI4w/e5D?=
 =?us-ascii?Q?l/hGClvGQgwpjUAUKaFYppKSNadJC/gD/gYK2jc4Ucj2Fw1gyp7UQqwwbsHe?=
 =?us-ascii?Q?zgyH5Hbt2F9XdTNjaNvQVsqJ25VfhjMkE+R+FSbkJr0q4GXVBJT5oPCD5Y72?=
 =?us-ascii?Q?QLe48xhXmJs2T4IRhFTtExmmq1azpZncrTsq9rGuFAiiF6C/zwKsDrbj19oa?=
 =?us-ascii?Q?I3lQ7x3vx6/AIZSOvyD/1oy/jpMljV4yuCWphf0QjDBGUsNaIacfy6RTPwMM?=
 =?us-ascii?Q?uLmZge2M9kfhqVa8R4ZNyCjOyhmu3Q3OOe6EssxQ9RRj8ygBwfcPCYdii1Sb?=
 =?us-ascii?Q?fqwjQx/nxf1kmbR1eV3zlZpfxNmrvNagQvyKzYt9c6veYClGxieeG7Zf7y1/?=
 =?us-ascii?Q?ilRxp/Xrk8bjFG1RsbnVarRlzpqTh3AcOQQnrSQDLajci+ZGG1cKXazvvL3X?=
 =?us-ascii?Q?teVEEQONKM+0XK6eqrJjtz6y5PlypFtbRKfNBfSUMyta36skrUIv6dt1CKVu?=
 =?us-ascii?Q?Ke1H0GEurLTQfyIDMnpisGYWh2uk2KRZSC3XYTftEZTJQ1dhshJiVGGqgKX/?=
 =?us-ascii?Q?rfa/uBN520GdlLUW3EiQMwoMgZ8Q+Eg/pteqKFmhFIzmxIEVA/JfNYlxdQ2J?=
 =?us-ascii?Q?reftsU5OFK6dtQpAzAw5GK1Nl8SZUpBUpjzYPtVohcKEEOll4HtAjguAyuuH?=
 =?us-ascii?Q?CNt2GWY/oKIc0HYKHVFLEOuW0Oc5ab51aq5CrxTCzh7M+q9+2Q92vGC8TBRX?=
 =?us-ascii?Q?jh+QvIDIgS0GLQIzOH9G4I0gAgn+H2UkdvRbNQXJ4cUMwKEm590QqvVoh/Zk?=
 =?us-ascii?Q?B53MLhU/g/UysDn1DJfqB3zQ4jtIkIpECR+0iSzvkrboMOcHWis3aLK1cAeI?=
 =?us-ascii?Q?CAAGVZvoav1j/J2MovSVqGo+zGE3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DxCiErj71fawjvIbbg7R1Xqbm6aGfuW9jttgVQIYEzsdik1t4guaOhkUPsyg?=
 =?us-ascii?Q?R+ZXNFn53gpJEtPPwQ+2ZC8mU73z4Ls8ixpjyYViv/ni6WfsOkjNauFpUTRe?=
 =?us-ascii?Q?FTfa/c34VIwh/6xU1nao62kBOm2EF44m/5gUBhFfq1WEhxsPDh27sinQd2Un?=
 =?us-ascii?Q?B39sm5NdD3+/KEmylYH438GOekHy3sSHp8ADckBwQcbrVwW4k2xfncz/StEe?=
 =?us-ascii?Q?tB9RGC6uKQWNVv64PUw5YAMGsTu1gSm7J0SLDMRleI3rmCHagM/4v8Nqc3QE?=
 =?us-ascii?Q?1e04WQmjgPmNlnMOw7SihpScO3ysGa1iNlzxVWQMjK0OcShUG3PGCXD0Cw2u?=
 =?us-ascii?Q?EPjWFUnTsA+xT+GUGzoeeftjRJ63QWyFVCRVrlFplqA0YnPiLi84c9JFlSfs?=
 =?us-ascii?Q?Q7gs5plnSKo3J8ytHyI/+nc2/nr+NDNsjGZPa0ilH8V2PH9w8ZYnTv6nd3zA?=
 =?us-ascii?Q?jfB3C6D7lbvU5l4ondbwl18KXRpBJQQfLKIaaho+im/5BVRYSkih6N4Z0ujw?=
 =?us-ascii?Q?4MnqafJ+N57e60aC4PLw+ByhSzU/dX9YeAtkUDJtGbuCnZn24eu3hUmaHsZs?=
 =?us-ascii?Q?6EvrEwlZ0RXcEXA4ll88EntBB2vv5OLzMlpdapeJ1dD2n6f8AVoWjr/vguVf?=
 =?us-ascii?Q?IM4TDN8PjeVYDF+upHI+OukVXJdyh7L+1RP6SmmPj3eQSfeONdb8SQ+zT0Vv?=
 =?us-ascii?Q?SdXijZkpn6mp4otVppya0W9tXGTwLi+NN/9z0837KWl1da9OVCVc6gXO8y4I?=
 =?us-ascii?Q?N3AfFEVlYie/nhOXyElCqRs3Rh97yXcUH1nWn1liz6S/+wQ6Bc6BgNHw1CvO?=
 =?us-ascii?Q?ZIv6HzqPwTFVpCP+8fXfEiP6o3zqv8kLqFuaGF+kgdRrIX27efyIbmHruJT6?=
 =?us-ascii?Q?o8Vr4vwtb5v101IFPKjZMWk9uaP3UQ4Es9ubln9tGEFpiyhyjfiEJHF3Cyn/?=
 =?us-ascii?Q?RoMiY+8L6bqVfc4nh+VnjWEjc+A0eNNP4wUvZeo9FwuljQmXXCexlf4tf4yY?=
 =?us-ascii?Q?O3gBplLEojcJohSJAAMpfSshJU0OcFG8CmJ2xG1Vm/PLfKXYOg9etkRnKLzT?=
 =?us-ascii?Q?5ZY5RYJu0WwIXB9cZDKxhklmQfZqTOCahJBhlaMxLZai7SrOMmGzLmAIPOPq?=
 =?us-ascii?Q?81TrMYx/pzNHYeriScJ0SYuXITni8lOGvr9Mp3kKgFhv7yfBsU63Aahu6J5n?=
 =?us-ascii?Q?EKl3Q0qLWPi1ULTqquaABHJpB5LAueXl8NqNgONaFBw0vhnZgsQaHHG0PzO+?=
 =?us-ascii?Q?yW5ATbElB2GG8DXJ4dHwlzQe966jbj/lP/X6AwAn8VVexY9o9uapW4Iir9Po?=
 =?us-ascii?Q?bWxXQzYQJQRTHodqcy1XYEBP8JWGwgnQx1t+Ob3BO9Mk6iwEn1ofdtsEp8OV?=
 =?us-ascii?Q?ka4mz0CmPR+nR4MseAIloxsehVvcFDO0rknwsQVHjk/NKw8TqW7A7Z44l02d?=
 =?us-ascii?Q?jYNylMW928W6eCL8ldN0X7vtdqlyoOkbRhU8I2koaYbEvDeVbgPrlh4xza3g?=
 =?us-ascii?Q?uZIOFbbogQjStAE09Syb5J1AJOLjISLfKIiGNgEZU9zVPxRhRToA947PWTaX?=
 =?us-ascii?Q?ZzpifThbKtt0jpLLhHiWKcPjLfpj6VaYbaKOq6mUlvy0xDnEsovQ9cWo4hRb?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73986977-e6c4-4de1-70b6-08dd4506e5c1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 10:30:08.5255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEywXhurRnN8oXFReT/g28RQcdwm6xclifxsLAeb7NoBqIkCxCAvIipBPLfqVcQa1Lk3Grgqfu0g6dSYyMsPOjM2QUK1Qq6v6WIylW27NX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5057
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

On Mon, Feb 03, 2025 at 05:58:38PM -0800, Andre Muezerie wrote:
> An implementation compatible with MSVC is provided for
> atomic128_cmp_exchange in rte_stack_lf_c11.h.
> 
> Now that the issues preventing the code needed to build lib/stack
> have been addressed, it can be enabled so that it also gets built
> when using the MSVC compiler.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/stack/meson.build        |  6 ------
>  lib/stack/rte_stack_lf_c11.h | 27 +++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/stack/meson.build b/lib/stack/meson.build
> index 7631a14784..18177a742f 100644
> --- a/lib/stack/meson.build
> +++ b/lib/stack/meson.build
> @@ -1,12 +1,6 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(c) 2019 Intel Corporation
>  
> -if is_ms_compiler
> -    build = false
> -    reason = 'not supported building with Visual Studio Toolset'
> -    subdir_done()
> -endif
> -
>  sources = files('rte_stack.c', 'rte_stack_std.c', 'rte_stack_lf.c')
>  headers = files('rte_stack.h')
>  # subheaders, not for direct inclusion by apps
> diff --git a/lib/stack/rte_stack_lf_c11.h b/lib/stack/rte_stack_lf_c11.h
> index 60d46e963b..898d43edb2 100644
> --- a/lib/stack/rte_stack_lf_c11.h
> +++ b/lib/stack/rte_stack_lf_c11.h
> @@ -8,6 +8,33 @@
>  #include <rte_branch_prediction.h>
>  #include <rte_prefetch.h>
>  
> +#ifdef RTE_TOOLCHAIN_MSVC
> +/**
> + * The maximum lock-free data size that can be manipulated atomically using C11
> + * standard is limited to 8 bytes.
> + *
> + * This implementation for rte_atomic128_cmp_exchange operates on 16-byte
> + * data types and is made available here so that it can be used without the
> + * need to unnecessarily expose other non-C11 atomics present in
> + * rte_atomic_64.h when using MSVC.
> + */
> +static inline int
> +rte_atomic128_cmp_exchange(rte_int128_t *dst,
> +			   rte_int128_t *exp,
> +			   const rte_int128_t *src,
> +			   unsigned int weak,
> +			   int success,
> +			   int failure)
> +{
> +	return (int)_InterlockedCompareExchange128(
> +		(int64_t volatile *) dst,
> +		src->val[1], /* exchange high */
> +		src->val[0], /* exchange low */
> +		(int64_t *) exp /* comparand result */
> +	);
> +}
> +#endif /* RTE_TOOLCHAIN_MSVC */
> +

Is there a particular reason for having this only in the stack library,
more than more generically available?

/Bruce
