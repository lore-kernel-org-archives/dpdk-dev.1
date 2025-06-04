Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FB3C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:09:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94EF142E24;
	Wed,  4 Jun 2025 17:09:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id E70BA402B1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:09:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749049781; x=1780585781;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/ae2dS5W1hkri93eOQdGl2H0+yLxTblLHb5rMi5TrV0=;
 b=eHQr+5cIomHEhImP2p/l47lCaYHUMvs8zyZg4I35zUPpRf4fpbMuUPIL
 fXmI0rPVU71VtAcyGCOKkUN5YEBnf8pWOn+XN/W58NTQz3svvsgDo/h+B
 gs+lbXdbrg8VIul7LN+Lxil6RzGJ//KqD/buRy4U1Py3wc54lCKAoHDO3
 7HQOyf4Rv5iXk4TDtzGc77ibnBkVJ/ZGK1zGWrkw8zroYyj1DjA1LsJlD
 ipcuGZxDDxgEZ0E3rj4vsiLT5VjuBA+hnwzKpW+C0OBKtEjwrhFaY7cYg
 3wYUr4IR1qwAueuL5iUAKor5472Ma7t5MrApAvTYalY1MzsVe8Kwns11f Q==;
X-CSE-ConnectionGUID: 1pbbpsUwQ/CGUxHlE9dGNA==
X-CSE-MsgGUID: 7EYVnhRTQHqjJ/cW4CtdUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="61759509"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="61759509"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 08:09:40 -0700
X-CSE-ConnectionGUID: fhyBUodrQdmZHdhd8daZgg==
X-CSE-MsgGUID: NrFFPXxcTfW+2OE9rOyfFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="145088527"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 08:09:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 08:09:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 08:09:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.62)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 08:09:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pT516V0jEmBnqs7xcQawY7iKlQbGkLFi57saHrKaL+oE4fdAlZxsxOrqnxrj75U9u2X/lVzWvoMnmCyJV0nWAcjYmNHPqrSS82J7QtdEM+3gBaUDDef+pMgf/wSMdRS0Wt2L96l+R8pV25Wibr5wWLl7WSBhbqHmSGip1bY41LRZEMTqe7uq71LGzVgNzvwn5NvXpXZu+nGIUxzyQOCWqIJ/DTjGx9bk93Yop+ClB/3WDRPtesnpfKvpTv0uEtzKlLjPhICjCZ+/G+RRgDtxv8dN/STaK9ZHjDQrcvXlW8Iz7ImCZDG8KFV2Qr3zYwuthj37rjdwgaHCxpZEhqDk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJ/sjbcWWUdfPCYvSP6ONjIaFAlDTAZw5rrwozmMG64=;
 b=l5aSbDKfD68NcFKT4jHYIoN//Na8awnKLF5d9o+FD2BFdi7XSP8QniGK6+jNKTL4x6jmgqHGNNrb0zTSYZ7UzUTfrNFI7+akUCk+YgE/xY+9V1IDcYk+o7Of3+iYTCpv5awJEPRWB+kD0DKppa7aXJ9Ancs668SeJmFOZo0rmhJnmp/VPriezhS83uy5VQe4+93PTuygZk8SFiq3L9lJErL4H+5Pf0j4eXrIDnPuZ4ibApoACO1ME1Yx9d4MipidUwqocndIlTWly2vSbxTDyLBb5zSMhstAJFViGmNI4/c1XV9SSYzDqwgqq7+o16Z/KhnLpSNlCU0+j0gOfoxuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8595.namprd11.prod.outlook.com (2603:10b6:806:3a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Wed, 4 Jun
 2025 15:09:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 15:09:23 +0000
Date: Wed, 4 Jun 2025 16:09:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 24/25] net/intel: add common Rx mbuf recycle
Message-ID: <aEBhnr0zR-Xqm4Ds@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <323c98086ebb9029b0e33e408068844064f425b9.1748612804.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <323c98086ebb9029b0e33e408068844064f425b9.1748612804.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB8P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 456915f1-83c1-486e-0cad-08dda379c9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h9X4bIXyWajT6JFFDL3UMF3mFfEtsjj0o+jFcw+SR4sSx7IjIm8fiVVNe12V?=
 =?us-ascii?Q?hdc198nRxt7CbrMv43Ydq0bgCIMmPmkNF19R/5T8liZi2c/xJJVRnYYM2I30?=
 =?us-ascii?Q?E1ajzvn+l8+Yg4txdK1vJgJuiKJRgqPbKGhFbd7A9Ikz6zyZd2x+E28MldCu?=
 =?us-ascii?Q?hy5f1MaGjHD5w4GNN5fAuFpnZ7QHPKx0JVLYUzoFY7J5CXGqTCvvvf0Dmab4?=
 =?us-ascii?Q?yL4733VZJvOmEOXf+3pcRaed3JxklGGl2vMXIhErqsBRIemSSZe38/GKCtb6?=
 =?us-ascii?Q?yGhzBT3IcUrPFb/2MlTtlWz2g5mUldxZuZFQQs/XOIAILWxp7lNcaFgrLGW3?=
 =?us-ascii?Q?tjstfk3fOp+CgaPcp0NT9d0e7vcKZk80h0y4fbdFNpv6oCFhzupBkk2LeU7i?=
 =?us-ascii?Q?FboAxHHiSnwt0ZmpzFO7JU0dPKQQN2Hrt2m8mu2AEArXJyTQCIIoApUC/Oh1?=
 =?us-ascii?Q?BfmnChBQy5Yc9X4D11379Ed0epZzwZLMzQGWFJje1gab34dOH1ELcUvRfcko?=
 =?us-ascii?Q?VAqQzk3+ZGS+kAKCyVGFsG7BlW5suTUM0kfAR9mQAP8lNlGUU5RpUMIeRxTF?=
 =?us-ascii?Q?b+XJNp3xtQp1EAJABoljF6W3OF9pZq/JI0rjDlMx4dXO38Bayv/dKNhMJBau?=
 =?us-ascii?Q?Ph+rn0BcbsxARRF1SZAxa7zo7F/qQZw5kJEoZyd82sDkBFOFIO0yiTdY5kSr?=
 =?us-ascii?Q?bpNnN+LCzjNzxSRH2wRioxUmEA4Acl2cDirE5X8e3QrRZM2bWIAbMMobzCyt?=
 =?us-ascii?Q?dbxiw1t3FcRQL3dDxGCiVKT/nU5PPPCZyeb3A183dfrPxtHN3ASizqZP8D1y?=
 =?us-ascii?Q?FjVg5KkCNbN7IMuKzEE+5scswN4UmGN9c3X5P63lbQOtW6FXhfn3r08aDYTk?=
 =?us-ascii?Q?QegvUHYeNkbZI6L2playhkj2uU09JY/90g8rD6dC2R1XxlOwe0xgc9uDCsmF?=
 =?us-ascii?Q?VdBp/Me65/57JIkoslxFy7X0KB7DVfK/vDXZUZ3SpoiGAtgq6DetpxIczaM/?=
 =?us-ascii?Q?FAXF+YgtrZaD/ghJcxjwDLLBR65d8j9xop7UiaVwi9hNB4xD/ShMj0yMZLip?=
 =?us-ascii?Q?uQOhs36xbXvCMJb+bN9BpKPbTVul0jXD65oHv6bY4SAgnlfBWJdABpSY1mPQ?=
 =?us-ascii?Q?cV9SieQEpEAX/MITSnBrlsNNIxzWah2udouX0ts+b2VOmOliYxYqijlnk7IW?=
 =?us-ascii?Q?tyzVM60y9Tv3u9q+Tt6M2rfeGyXhXldB39nrDwRnNtmzXgJ+QWLtgHaJksxF?=
 =?us-ascii?Q?6z9UT/xrm3Gq9RogyULZrfKwr28r2pud4I7vuH7rq8GxGRD/Bzttbq+pkFV/?=
 =?us-ascii?Q?PcQbODdXbzlYPtnSyZ3X9mVNcBDSVXd6xtSTPwGxPj9boUBdcnB16lof6jps?=
 =?us-ascii?Q?deSLtv1uHXc4GoBg6CVy1sRMjuecT+jPwExfKh8m5+tOz5/nKthuhueIq3Zx?=
 =?us-ascii?Q?ECwlV+sQbi0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qe6uaRKPrzp5brgSXUd75W8yiNyWYE98sV1ZevD3XgyAaPsFfl2DK8RSJQyG?=
 =?us-ascii?Q?Vgy8nz0ly7LcoLgSIMV2EciwXxAM9Xvlt82j/umdD9p6U5JoQWNa4/gXGmYx?=
 =?us-ascii?Q?Hg7SLjRL8nPzHYgUuwp41AXx1P/SuifZxJ76Bs0qbszowToTekoPoyqStg7+?=
 =?us-ascii?Q?FaE5kxyUIWi4ta7q3wnY74iNNM4ibzlvTWyEHVu/nu3XBXt9ERerABDRQwSo?=
 =?us-ascii?Q?xhuEimyyoOmWqef+zvHXhkOC7rfDfl6p2HKkIUByNk71Ff5/Qc6Fw7SlHM2w?=
 =?us-ascii?Q?jXCyZpUJaC9DnRI/zft12Y8xLDjeTDOmfgpafCKqI9+lz56LVYQAI4rjRLBW?=
 =?us-ascii?Q?Ahy2eLBV6mX96jWThbzTypsfz+CiTSrM1ZvsmofnVYJPFGSw7Q0NnyGvhFMX?=
 =?us-ascii?Q?tR7/cGfABRQ6qYAR9vuQY1YNHzExSCBimxDr2FcUZERCRV5RnkunZ+KHozk3?=
 =?us-ascii?Q?LoHtDsndQKdMYVewK7v6hmMnQwonnNmnIjqh2JXBEvceVnmajmVT0b2ek3VS?=
 =?us-ascii?Q?CxnWRt+HItfFnQVDEvvVtfuJJqJU/v25o6kL733UsN+RzVAq3DNH3zvJj/A6?=
 =?us-ascii?Q?AEURwYDgJzWSuIqSopk9MW1YujY/ZQ4CflQic0UBKAADCrslf67AfoDNtdA/?=
 =?us-ascii?Q?faP0/9f9mXrOPUxNG7U5H5/KMDNcv106BRN1Gd3s/XGaTroqHD28gt06cVgi?=
 =?us-ascii?Q?SOQU0FO/tPIZfGWxEy203jW5F+o7BaB9ukOREeTdOrMkEUqtWArx0asJpBsh?=
 =?us-ascii?Q?mxEGTI35ENBeBb/I2TI5IPnCdgCa1ZiKYW9Mh9l7oqr+NC/Ns6UyIF0Tw2TF?=
 =?us-ascii?Q?s4f0WSrONHADyN9VzABbRE7GfEVuMrUjiBOCKnZIhcYPv5xJUhOixm2iyGNq?=
 =?us-ascii?Q?lvbsMqmlTowearOozrwU6rZctvxG8mX7Otm0ApkFKQaUn9IY0STsvBCuysoI?=
 =?us-ascii?Q?9tsee3tObGx9sUmYX8Yqgc4zcVt/jjp/RukguSn2tMNHyeersZE/s9Sf6uZR?=
 =?us-ascii?Q?+diNXbgbZrEf9rfibK4/laWFG5D73W/+MgG9uVOMld6qkXmvbI4makjPv2i+?=
 =?us-ascii?Q?yJb/QjMmlDcRZlTj/WYWM4BbrxkS0rTvMHlxHslM45h3FqdbaK5bCik4IV3W?=
 =?us-ascii?Q?u6n1ZvxqGA2aPD9NNC6ZLJqNgLIi6MkqTQjJqzTSFAuSPhuLomurnzQEC2G7?=
 =?us-ascii?Q?8a3HNJLWzRO8bzqPtBACZZYOrR3xEzHPug+tc0wu3CpxSC1SDJMHXV+yW/sA?=
 =?us-ascii?Q?rHlQvC73uOQYzcNUzfx/1+8jGbSomR/t+sBQaHpTnOPo9NN/hZaFeHMQAguu?=
 =?us-ascii?Q?jh1FsNNxdqomkPiB1AV/VjH0BV8G1kfXMDWOcHnG/tPr0vihVL/TOWIy3tyP?=
 =?us-ascii?Q?waoYfl+VAxqtAnXpcnHqPGecVKxJrP+ZtYRKZWFjWXkAQTDTuktPTPjFClO1?=
 =?us-ascii?Q?mBvnm24kd+rZCnChe3+sJVRtd7Z2O9CRmhhOQQl1bQcmA7DQStwqF+8iGY8X?=
 =?us-ascii?Q?TpflpGrADEYWgMgk3wqKo4rRs8fmEyLp3TUdmcX3xJLnlU3SukPPaA28g/DX?=
 =?us-ascii?Q?0Ye7iMx0isr9ECHNUEtdPC+6ZRrPNwSLWi9oqs36Zh4jXewt1ElLLkfEfe8e?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 456915f1-83c1-486e-0cad-08dda379c9e1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 15:09:23.1722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XT42CCEmzrlnjg8XH5aXim28zb/WcKbBMyuMOGnPhLy2PSBqkj2XGDi7XhKl36dG5T8FYkfnnLg/MsvVzCZa+aNSfo984+NXDDVV+WtE9jE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8595
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

On Fri, May 30, 2025 at 02:57:20PM +0100, Anatoly Burakov wrote:
> Currently, there are duplicate implementations of Rx mbuf recycle in some
> drivers, specifically ixgbe and i40e. Move them into a common header.
> 
> While we're at it, also support no-IOVA-in-mbuf case.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

One very minor nit inline below.

>  drivers/net/intel/common/recycle_mbufs.h      | 68 +++++++++++++++++++
>  .../i40e/i40e_recycle_mbufs_vec_common.c      | 37 +---------
>  .../ixgbe/ixgbe_recycle_mbufs_vec_common.c    | 35 +---------
>  3 files changed, 74 insertions(+), 66 deletions(-)
>  create mode 100644 drivers/net/intel/common/recycle_mbufs.h
> 
> diff --git a/drivers/net/intel/common/recycle_mbufs.h b/drivers/net/intel/common/recycle_mbufs.h
> new file mode 100644
> index 0000000000..c32e2ce9b1
> --- /dev/null
> +++ b/drivers/net/intel/common/recycle_mbufs.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Intel Corporation
> + */
> +
> + #ifndef _COMMON_INTEL_RECYCLE_MBUFS_H_
> +#define _COMMON_INTEL_RECYCLE_MBUFS_H_
> +
> +#include <stdint.h>
> +#include <unistd.h>
> +
> +#include <rte_mbuf.h>
> +#include <rte_io.h>
> +#include <ethdev_driver.h>
> +
> +#include "rx.h"
> +#include "tx.h"
> +
> +/**
> + * Recycle mbufs for Rx queue.
> + *
> + * @param rxq Rx queue pointer
> + * @param nb_mbufs number of mbufs to recycle
> + * @param desc_len length of Rx descriptor
> + */
> +static __rte_always_inline void
> +ci_rx_recycle_mbufs(struct ci_rx_queue *rxq, const uint16_t nb_mbufs)
> +{
> +	struct ci_rx_entry *rxep;
> +	volatile union ci_rx_desc *rxdp;
> +	uint16_t rx_id;
> +	uint16_t i;
> +
> +	rxdp = rxq->rx_ring + rxq->rxrearm_start;
> +	rxep = &rxq->sw_ring[rxq->rxrearm_start];
> +
> +	for (i = 0; i < nb_mbufs; i++) {
> +		struct rte_mbuf *mb = rxep[i].mbuf;
> +
> +#if RTE_IOVA_IN_MBUF
> +		const uint64_t paddr = mb->buf_iova + RTE_PKTMBUF_HEADROOM;

Nit, prefer iova to paddr, since it's (hopefully) not an actual physical
address, but an iommu lookup address.

> +		const uint64_t dma_addr = rte_cpu_to_le_64(paddr);
> +#else
> +		const uint64_t vaddr = (uintptr_t)mb->buf_addr + RTE_PKTMBUF_HEADROOM;
> +		const uint64_t dma_addr = rte_cpu_to_le_64(vaddr);
> +#endif
> +
> +		rxdp[i].read.hdr_addr = 0;
> +		rxdp[i].read.pkt_addr = dma_addr;
> +	}
> +
<snip>
