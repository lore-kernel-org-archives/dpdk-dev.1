Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1E3C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 10:58:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB688402DC;
	Thu, 15 May 2025 12:58:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0819240289
 for <dev@dpdk.org>; Thu, 15 May 2025 12:58:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747306717; x=1778842717;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kgCXeCAJMmNIbePYn4e6384rA2M8fvrH967glpT7nyg=;
 b=Ru1TboTEUvSYIcpQ0goeBl3BTwxmmTdvnFyXOaopi7wQkCJ6YxuW0XET
 ULSVAb/rDh3a927tyEkd2n91xP3vpPpEFAaMMtzVzz9VgogtvVjUUubh2
 ev7RF89/OKeg/YfH7rXPVuwn4hwfdUGD/LBfJwOYj5kh1a2RTKaNyc4Vc
 j9160i732n9MFsU98dKtBykCZWp+KWzIO0k35+wfv8kD4tNa1oYA5vBUJ
 AZNMuoXuBQpZQ0T5qITvblZPLCUxlTg9ecGhRirmRX9N8t5x2nW/DoBM+
 sBEkeGKt51Df4IzoVEQ7EQxHzUhS4sWXpsArZI455ZtxvBKjDVltadOsA g==;
X-CSE-ConnectionGUID: JWzkATBPRcq3h4xQ2X7i1w==
X-CSE-MsgGUID: bkEYyTW9QyCI6lQpUq/o9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="59465218"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="59465218"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 03:58:36 -0700
X-CSE-ConnectionGUID: LQx38jccRDu3uLKU+xlviw==
X-CSE-MsgGUID: gHssTr4NQkm4aGgWCnJyAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="138213898"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 03:58:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 03:58:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 03:58:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 03:58:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbLWHnj5b6xe+Ud4/G+rRfmGB5FrfK+NkAr8DsdZLIlA5f/Ql5cafStSEsKfVqkHkMetfua9HP5wGT8Kr3Duw5h89zSFi4FJLOaxw18SfLQQnatIhW8FLKljqYdOUD4V6qnjez6c/90tUZC6bZxkPbosKFAhVTjWqgGVQA2U0WmXqYQpiN423auPVqdk+2c071uo4vIDX6uTJQbjo7ljamxJthfBwAKBAAfMJjS2FwvF9RiyefRXZsIjpmTs3BctiUUmNjEAIK8SyGAq5ZRGCnAE2aJbKJRkKUZqEx4+UWeUDSnwmOAqC5Wc8pmcDdtjrDP6SAs2DBbBz2xFn8UsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVJ9k7M+uvd9FIpgHdeKLDKA0TGpiClBUbyRKUm0uCE=;
 b=P89BFM3abDP26GCB2huTo3pgy/5FUTzC9CFgLJl+V/vSpvGz/jxXYh1JcbJKcuiTPgbduPm2juEHVCXvKxzbxqjDRfWF5gIbntp4bUvWiCFD0vKQ2+epuPranh/WmjLA1eBGqappeVA5Dgrs76A6uo2WgEQK+w/yuqleq14NZv4zkSB5j0X4O5UhL99+FmNGueBycQihFjb1DfShg/s7gVOhWuB0la9E+aG95pMKa/hBxxAtbSyvBNfIZVaSPp8zOYMOH+5Jke3E/F2Nl0ujztSH+zu7+6t4K+EdwWJUMtg8+EUolqnJDijC/iOuavQzw4ly16bD5w9UbN56ZjlHDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6163.namprd11.prod.outlook.com (2603:10b6:930:28::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 10:58:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 10:58:18 +0000
Date: Thu, 15 May 2025 11:58:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Ian Stokes <ian.stokes@intel.com>
Subject: Re: [PATCH v3 08/13] net/i40e: use common Rx rearm code
Message-ID: <aCXIxgQPhadwfDL5@bricha3-mobl1.ger.corp.intel.com>
References: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
 <49839280b3646472ef174e45d97c7191fa0ea67e.1747054471.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <49839280b3646472ef174e45d97c7191fa0ea67e.1747054471.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0236.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 188ab3f9-013b-4f96-720d-08dd939f668f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y4wD+SGM6JTYH4y9Fswz9AloJwOgqcYBGUSqLumdGHe1za078Ron0bqA19n4?=
 =?us-ascii?Q?SBCjU+uQzQ67HZyv6tNxa4Mc/UmeVyneGJ9KKAg9QClSKeZzp98fip2kh3up?=
 =?us-ascii?Q?vaQi37xuPHjBcsSxIZJinvoPptKbvY2YIh8XPbarNVodGtcLdy34a7iqJTqR?=
 =?us-ascii?Q?+db5XScK8XwKeii+4ETK4AU9NMtK+WArHoaUF1IUmXXgmLI0d+YcPJUrILoz?=
 =?us-ascii?Q?kB1FUMBzBbTXDoBEeVOfX/yzPXRTcBQkoOq7+tjqoOKAOU/f43G3RzXodCQr?=
 =?us-ascii?Q?oc7s69VRTqSnb4/mlGLpQf/8P5H0gGvSwH1pnqXkbKD0Ysimqx1zILEp46RL?=
 =?us-ascii?Q?Sd3oYkp6tDhEn23GQAVDKuwdJOyUgPTQl+n0Tp0nc5wiitN0Pd7/wtIUU/LT?=
 =?us-ascii?Q?2U+6dI2Ci1l8hvfd6DyJPN9AB3VKq9pvbvganHdDtZieUULHHAs/jLHUmRiH?=
 =?us-ascii?Q?k/AUNXe8U8hgTWH2UpzGj1FufUu5xgeq30+ayJ2vOMtS6woDwNEj5j5d7TWI?=
 =?us-ascii?Q?G4Vg4k+WkTATatZLCUPDxKgsu0BbuLmdl2nJBjuH5io9uGXzjvB4jwB339bx?=
 =?us-ascii?Q?riWYXjNSw1k2ROaBxO71oXAc14A4j4cO/NsvvfJye+5pxkxMASuB2RmEtXDU?=
 =?us-ascii?Q?QlaSqvSc79NHMvyYkE0fU4LtkrQu9v4wF3eS5xusZPlL8k8AtOc9B7RaG840?=
 =?us-ascii?Q?PNaJXslZLAF4vr3k46isMvo/glpQzhhD8IpWtBQqibbl83n1ClJqg+Ns5969?=
 =?us-ascii?Q?FboDAKXINx1+9WdEDzhlQ9FHJuUrc4OW4f1aZag/1wYAiW6PnwcZaO/tbyQm?=
 =?us-ascii?Q?2es/2XD9sGP9HZRSYvNyHgFpkOvtHCbN3etcUo0s4Rsg/LVcnkaV+PGP4Ykd?=
 =?us-ascii?Q?Bm5gC2hkdQMqd4QGciiSaTKJKOH2EZwwVtp1a41N+0yeBQ6GGz8Z+Lj9/1Hs?=
 =?us-ascii?Q?l14VCgAXPzxtiqTAjT59PnuP8OzThESuatj30wKP/zdGcmsnPbIz5DdT73p7?=
 =?us-ascii?Q?TUIUTBeBczJYwdM/IX2yKKoh4iehgqleokXMRxdQBKPuB0SdwLoB7yC2E+XY?=
 =?us-ascii?Q?MjrXhl5FoeAvx/GZ2fP/aEd2PWgq8SXTBMP5pulp3tRGYIXWLwDdNK78Ofr9?=
 =?us-ascii?Q?o+AsDhRs38+ot8R86eobR9sG1Pi93KHWVUJQaRvsnYOBWvXOxoKMZoBSXDxX?=
 =?us-ascii?Q?t6vrK7lVlfZftPvVzxI36syK3gt+xug0u2oaYkBL+IhAyV4r67IpMcZw/PDT?=
 =?us-ascii?Q?aMmFIukfVPAMBJakSnrZ7/S0+okC0gf5qkesYmQoniQrw3D655vjIJKZVPq3?=
 =?us-ascii?Q?FAdWARRS/hvCmRq3pMlSDccHCtbE16O/qgGT+1s4pEONTbBwbq4IimvHCgw/?=
 =?us-ascii?Q?iYYpPFQQHMXEd67UZ2hSdh7nOy2GIebe/p2/NHNvf7UEUtUhGXuFhXKUaHAn?=
 =?us-ascii?Q?bL4OQHHJh78=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jsK7y3GhSA4hMM+y5SdUnwPfw098UF7HP1uTelrvVu/5LgCh938UBL66B4i6?=
 =?us-ascii?Q?xAZ3AK3MopswUH15k4oSZNsUYUWsRZiZ1xfpg8DpRg6LOQZC7VwkCpMt/lNT?=
 =?us-ascii?Q?Gc6gQwoY2NhWhJDqlhLOqMDCG9lWevOq63b7F/0ii0Y1rZ96eRRT66+26LGk?=
 =?us-ascii?Q?V6QGVB+EoIuAuatvjsXqaBFoZdLaclwugMdbTJEEixRonefm8LHZIXwimfxi?=
 =?us-ascii?Q?ljU0qC51yaFIjl8ZVC56Xriwj+TH8aaKAX2BVVa5VTdLXMWFRMnB3RYL5QB6?=
 =?us-ascii?Q?b4cV15p8Mewmc3P79j1BWmwGETpiAY0w1FRUA7LX/NFPwDVVvh1OFp6sTnpj?=
 =?us-ascii?Q?xQRzymiGvuNatXn5f+9SctmiKq5IttUiGQN7swjxSexuSO10FP8WHXXNxYdy?=
 =?us-ascii?Q?rKR8hcNE1KuXSj06RfjPO0wgShXyyWKxHLDeRNpO63rRoxReew9CdzWdIgrY?=
 =?us-ascii?Q?PTL+cbbjQ4xxUkMz9kCXq05vtsEIU7zacATIGuCvk5bgIpeGunN4UWerC4RH?=
 =?us-ascii?Q?zMOEBmEvVmq39PsS8/beMxFQcjnG5QWQaPPso/5L42rXzWRwLFg0ibvFMbVO?=
 =?us-ascii?Q?8V48Chbe8TvFhI/GXuxRiHtzBgfahfU/R8Qov+wPqdDxpP3jJBLRsCZgbhJ0?=
 =?us-ascii?Q?IFlC2cbQ08qYSuaGmxcRWZs9uh7wW2HwTRepkPHVepwA5Y7MdWEqJch7wY33?=
 =?us-ascii?Q?BobBKRZFJelB61xmxdXGvrP/B5K0B42O0k8bERZuaDuwMcwqYyb9iHnFrjDS?=
 =?us-ascii?Q?kaTYsoDUjqTf8+Lm0iq69iBiA4AbNDi+oFMkUGe1lsskhcVUF0ToG+Uxcipx?=
 =?us-ascii?Q?ZPXkeZ2NyvboTZ7e9850b77iH6/lPTjWioyUk43UkLcPNTcRm+l5frKa0RZd?=
 =?us-ascii?Q?dCO8hpTIZ8ENTRfo/F4D/zKRzou3XamEZ9YJwCgTn5PEjNVth10/Pxva365I?=
 =?us-ascii?Q?33A3NgKhDEAL3wWao8FiBFLKnru8KszQZcRjaArjf8/IRmB3IfEiPnKt97pz?=
 =?us-ascii?Q?+fn45vZ596Hf+EFKYM37knl+j8azQTrsNmk1XFBKvOfkhHgNGRKWS8Z9EqIQ?=
 =?us-ascii?Q?O7ZbLZj8UMnkqevuxu/RlWbYs9KG5BwSVAUv2Z7U2k5vtSxFYf6EK/48ax7T?=
 =?us-ascii?Q?JII6KkUSACpXJySp8jWnskbF8FsT3L174zm3icipZEeVO4VQ5qi189RSpRgS?=
 =?us-ascii?Q?uB1d7d0vAx13lCC0ZWPYIiZuPiJQFLNaYZd8xwLVrm37IE324n0yfYb0vOU4?=
 =?us-ascii?Q?P6sLVax2r0LL2vwU1e0GwcmM5izn02uZ7WI72DqzVoEkfAyR/N11BPktsala?=
 =?us-ascii?Q?OheTT1ppQkeI05/n/7JPj6YP6+h1H+JDzlTbZHrD1V4MxnobsJOhg6oe+jD6?=
 =?us-ascii?Q?mkZHdYsSBbVDMq0NWSDB/w6H7gnbFme9wY8GbUZbthsNK0calx0izlnFR9VY?=
 =?us-ascii?Q?wJEjtO55UlwEhRwgFPs+s5N/tnQ2l1Gi2RkZz9BWYFuj4wgNarvzl78r61BZ?=
 =?us-ascii?Q?3fkW9dqEUo/LUxpDXsmoKqud/1Swq7FxrauRHdfb9ZDiSLAYJLRtu66Y5/F8?=
 =?us-ascii?Q?3oOdhZmA3t+HAX7SgDsDjmc/msgnLCXlGZII3fVSNGnX91jq9oJVb4LVifTH?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 188ab3f9-013b-4f96-720d-08dd939f668f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 10:58:18.8503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbEa9X/o6XMmX0i2aJD7LBEDoqu136CxQJu8GD1hSgNQsjLmxA6yAqwGnNN5QhviJZjDeJfBglCHN1wCfhyJvIlhTMjURTcvHfLQrUqGn+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163
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

On Mon, May 12, 2025 at 01:54:34PM +0100, Anatoly Burakov wrote:
> The i40e driver has an implementation of vectorized mbuf rearm code that
> is identical to the one in the common code, so just use that.
> 
> In addition, the i40e has an implementation of Rx queue rearm for Neon
> instruction set, so create a common header for Neon implementations too,
> and use that in i40e Neon code.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
> Notes:
>     v2:
>     - Fix compile issues on Arm64
> 
>  drivers/net/intel/common/rx_vec_neon.h        | 131 +++++++++++
>  drivers/net/intel/i40e/i40e_rxtx.h            |   2 +-
>  drivers/net/intel/i40e/i40e_rxtx_common_avx.h | 215 ------------------
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |   5 +-
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |   5 +-
>  drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  59 +----
>  drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |  70 +-----
>  7 files changed, 144 insertions(+), 343 deletions(-)
>  create mode 100644 drivers/net/intel/common/rx_vec_neon.h
>  delete mode 100644 drivers/net/intel/i40e/i40e_rxtx_common_avx.h
> 
> diff --git a/drivers/net/intel/common/rx_vec_neon.h b/drivers/net/intel/common/rx_vec_neon.h
> new file mode 100644
> index 0000000000..d79802b1c0
> --- /dev/null
> +++ b/drivers/net/intel/common/rx_vec_neon.h
> @@ -0,0 +1,131 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2024 Intel Corporation
> + */
> +
> +#ifndef _COMMON_INTEL_RX_VEC_NEON_H_
> +#define _COMMON_INTEL_RX_VEC_NEON_H_
> +
> +#include <stdint.h>
> +
> +#include <ethdev_driver.h>
> +#include <rte_io.h>
> +#include <rte_vect.h>
> +
> +#include "rx.h"
> +
> +static inline int
> +_ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq, const size_t desc_len)
> +{
> +	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
> +	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
> +	volatile void *rxdp;
> +	int i;
> +
> +	rxdp = RTE_PTR_ADD(rxq->rx_ring, rxq->rxrearm_start * desc_len);
> +
> +	if (rte_mempool_get_bulk(rxq->mp,
> +				 (void **)rxp,
> +				 rearm_thresh) < 0) {
> +		if (rxq->rxrearm_nb + rearm_thresh >= rxq->nb_rx_desc) {
> +			uint64x2_t zero = vdupq_n_u64(0);
> +
> +			for (i = 0; i < CI_VPMD_DESCS_PER_LOOP; i++) {
> +				rxp[i].mbuf = &rxq->fake_mbuf;
> +				const void *ptr = RTE_PTR_ADD(rxdp, i * desc_len);
> +				vst1q_u64(RTE_CAST_PTR(uint64_t *, ptr), zero);

I suspect many comments on the previous patch around the SSE code, e.g.
about unnecessary casting, may be relevant to this patch also.

/Bruce

