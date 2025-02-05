Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75394C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 09:16:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FE8A40289;
	Wed,  5 Feb 2025 10:16:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id C527540270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 10:16:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738746972; x=1770282972;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=S4fIsUbl6+8DKPFBgc0MnkrS/zXgT8u4NJD6kfbKVWM=;
 b=BvLfE8AzqOWuRDjsxLhsqfqY1bGCaWmbQZi7qdtThCML/Ie6WZYpgPIq
 BhmmAtJasVcHfrCAuDI1o5SqXl3OvhqdEAJRk7MFSK+OK2g8AjBGa8Cob
 1QsAvXZdWLxAqnNBP8HwvGGuVf/AA04curB0mKQE4whE9Tv+5ZwEMIhGw
 sv5SNY0UrqifOuIEqXV2y9js9qCLt/2+TyN7Znss2pliucId1UVQY/qxq
 wuJ5JNSxGf4QGSwR+28F2s0cmfopLbGa3vljyrChQcXEZMhNia+txGalg
 lnv0kLPWIJnpeH6pQQVgLGF2vssHc2tzh/ndAVYQgSc+Da9+/3LSBb+xW g==;
X-CSE-ConnectionGUID: Ly0OrnweTcGQr3DG49DiEQ==
X-CSE-MsgGUID: +G3EemaQRLu8jvBTds8tIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43222238"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="43222238"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 01:15:59 -0800
X-CSE-ConnectionGUID: jTQ9Y+A8S/+IZUV7nrZiog==
X-CSE-MsgGUID: a5XylPvjRu+y4CpefWkDKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="110736277"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Feb 2025 01:15:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 01:15:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 01:15:50 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 01:15:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amQVjDafbArQ64/9+s8WjTQ/MgXtWC8GfUKFKvCTj+ZVNVbPD8Zvjmc4HeROeCF4SpWs74vDTBvHFzzn0dtwNuPyVlNq2rHO6s/Yl6NINv3dXEw/cSA7GTpuE2kXZ1o0tnxQLq59UzHq4otOSGinrE3VhUTnJfPuJg1BI2BmlqcsWytqBfZZmq3xuvr9RojlqEFdfdUPjR8uVjbXAYaPZRmxjtTW5VmexgzfN9tevrGICMwWXqXCFxEhhVw6TLZgfxNojiMpeOiDeO4DINK4gwA72bDciHPuPrRVm+0I7jMcgS4A5/EL9Qz4Uz9QbSqFEzOsJiBJuXlw84aJ+E2slA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3DsoX5BBxCUtS6RbtfJT+5vODYIfhEgXRn+PJVFhaU=;
 b=vLMjc49IDXTEXINzIZNJGava8lZrL3GyqByZjjf1Mj/O4Ciq+CkSP8rK3NNxw0AjMRpUd26VvjudNAkESQg+74KN3k3GFMDTKjOUQdVWFEQi67UCuyHgB2tCbxs4l90uE2aLi7nggn1gQjLwOf2yPRMMFVIz3rxSiFw4f5EX2Cz0sc3iVp8+2mA8nYD19PDIJ2MK/nSAsdSeV5LtqNoxWmznVsG8UaF/GtoI3+6z6X9vzLy3GTw254RXU9zhyU+bhfd8xIn/RBhvpclcSmUBnILx3gMYI6yMrfPPayjuNWxPbGna+ALWCUauRfqG7zMxfdrv1hSKhZ3rr+WgJ6MflQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8181.namprd11.prod.outlook.com (2603:10b6:8:159::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 09:15:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 09:15:48 +0000
Date: Wed, 5 Feb 2025 09:15:43 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 0/7] eliminate dependency on non-portable
 __SIZEOF_LONG__
Message-ID: <Z6MsP35NONKe7wSb@bricha3-mobl1.ger.corp.intel.com>
References: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
 <1738695271-29948-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1738695271-29948-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DB9PR06CA0001.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: fe607dd4-925c-42db-0120-08dd45c5ad90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nu7aLRxnZeBr/cCmLe4IuPqZOqeASqK7oPOxR3H+g70L95YrGG+te1mBx8aU?=
 =?us-ascii?Q?x/oMtZzSn5Z5f58l5M8Y5RNhng1L1YfLmpAAx+uBd7QAug8H2iyshCG26un7?=
 =?us-ascii?Q?dyC+sFH8qkyBVW3KdFc1hn22KurZUt4MJ/7qnCzGWsYeu1MTJBhPjcMVBTVS?=
 =?us-ascii?Q?/A/nECNnT2nFagpenXPJzr3/WAjZhpoZUjt5aMS6EV2vshB7avZbrJL8vCrw?=
 =?us-ascii?Q?KtttKsE2h2FL28AgX/EXLaO94ABs71yfvGnHCaL7nTflalIbF3KF9LiEYWAO?=
 =?us-ascii?Q?pyw9DQxkdS405XsyYmO/eXemK47UcUckzTNq4VqEC/l8YGvixQamx0UUXcxO?=
 =?us-ascii?Q?tBegISLiQK93QK2q8qWAY1T+4xEtLm5BU7RwhVdQFrJKNJ9rxJrIZF1nppX4?=
 =?us-ascii?Q?ZdVTFiCPkl0YIsGSnLr1XGlJ0B6lOHPEmCkX/5arAEUgLZfL9zAAV4I3Tr/S?=
 =?us-ascii?Q?3u0eyhRyD6rB1FzIo6eTU8dwRGtXz3Jwvdn5TnDrx/6LlY/zvE8ubdrb4Uhz?=
 =?us-ascii?Q?eJIwHCYPxEwatJh1OQeZBCvyn6UA/HiXMoLo0zmnB30bx5VJk7zMYnFKs5fG?=
 =?us-ascii?Q?016Hp0CGqFW6XcN9d2dQYl2fQeD0rR/SUEHakIalHDUIdk9CiyjdCGgYHWoJ?=
 =?us-ascii?Q?qZc3xeWEJpa1O+2VLXX6OF7wyKEoZvbYpPIDYvT6vSOnojT5/6hZUjNovoJA?=
 =?us-ascii?Q?LkhUvWuooSG221Vl/3lgoIpjIRPDbhDl+cxxkzw4M7E/9wnO34eJmRfYOfuL?=
 =?us-ascii?Q?anzdfj7N1ACv8BMB8xJlxmxuTavtxa8FDD7BLaGglOXlQvhWd3Kc2tjsGct8?=
 =?us-ascii?Q?BkRlhU/rUPLT/xMMsQuyvtsWE+zPnFQKEWqtw+36xg/S8UTXhR+Joc5BXuB+?=
 =?us-ascii?Q?HWqalzOA/IJaa/tZeGVRcmG70tM+ObIYtTtEOYroAAYrm9qYKFUsC3ld/Vc+?=
 =?us-ascii?Q?xMcLDKpNvFOosPGuuCubkhcPbogyIBHzhVQjMZmWkv8SIyj1N02JaxCOdLf5?=
 =?us-ascii?Q?Dif//0pbel6pzMeKHjVXIgNSTACZvIoulfYsG88lv5XTcNez0Xk8a79UyBZR?=
 =?us-ascii?Q?/yl+NjhkjkmNjnmCL7DlHbh17EqfRYCR3UOLfr1jfLzaRBL3zo9FqGOGMZOr?=
 =?us-ascii?Q?JcGmsybm79RDVXFBWha0p3lkH6HStuwKRE1SiOJ73PdPUPN5pvLoHxxSYiXb?=
 =?us-ascii?Q?fFkjAVkL04yLThxqBiJlknkjQSZIDb5TTLAEBDkSA3yEI5Uu/k+AJfv1fYod?=
 =?us-ascii?Q?tlKocPFPYTGKz/zhZEg74ew1pbzLbkymxDcavIYyynN1jSXjWHRxsmI0hXhc?=
 =?us-ascii?Q?Kj3RvvJTp+u79PJR4tszobhBMkGSMI9F84FypVhsNGq4dMzOw7dAw+d+hIAl?=
 =?us-ascii?Q?FfbF/Cctjz0rjzWGY4K5fWep0RZ/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qcsYO0oUF//JpuR6Q+8LkgQYtwz/AxmtHokwSpUELBVdaq4DjF+Y3WLEftsX?=
 =?us-ascii?Q?d8r/vOn095Um8byVbIft9pnOuYtMwMIlvUaMAEFbl9nKA8MGv/V9o9jgJJEA?=
 =?us-ascii?Q?510IT28N4hXAiJO9xrnBRVkOcfzvrd4TqVR5dCL7CIf50O5t7xcsINvo8DWG?=
 =?us-ascii?Q?VgFpzbMEPf+WHfG4yUt6uKSupRLMbpQmfN/3oryvFXScWehS6ICy4c4qx0wj?=
 =?us-ascii?Q?RC/321pnD+u+pSG9UIJn2iWDHPJ45WHpqkTJXGs0ZsFQgi9cL3zGsmJsKPij?=
 =?us-ascii?Q?HSMQstP4O/9P+TVPX15CsGHpyy5mmviEuCmZ4gKsC34zurSixIkHiamcnTzm?=
 =?us-ascii?Q?oHi0cpAB+I+6mJwkjiV07qj9Z0bm0NyJM6M72qEgx5wKI1oUiUU92MO/0TmF?=
 =?us-ascii?Q?kagRMjy6EFAGQidFQqni3ihhDu95eYkeurPJeS2r0lvd21AyQVbWW3a8vIqW?=
 =?us-ascii?Q?5MQqZxjTrNqvTgEM/cWofBEHaLSTlmh2/5qMIpjXKsYU9kWJwZjfj+9hRBGR?=
 =?us-ascii?Q?Jq73KPZLurgiRbqmB7DhwvT8FxVnSiC+3ii9XR6Lx3V8BZyU+IMJVTzEXZ5k?=
 =?us-ascii?Q?tcC7hIoPiAh5+VHPk8ZxaJqCYMU7FhSYSK+IdpmoI1eFzc4Bhi2jYCJPTd7b?=
 =?us-ascii?Q?Pxzhu61QLF8xNsWz9IoVRFwlJxXr4k1KvQphkENh9kYPiqsKqeiMY2XoEAzs?=
 =?us-ascii?Q?R+nKW00XEINQVPzTRiqYd1KaOw1bZAUKRi1IZsAKSvhJo6bl6k12lwQTAQtV?=
 =?us-ascii?Q?rHnwv34lULQ3JRFGdSXo02mYMdq85snxIJ4ur7u25MUINbM76/mpRO07YjMq?=
 =?us-ascii?Q?o3eyb32JETq3nsmzz+w3Sa529IEAtGBGH8OZNZDqXLFZEyph/u+lvNCodzjy?=
 =?us-ascii?Q?BtkIcosw9NdqrMpMWykf1j5p01rUD78gpl2HDdzRSs+CidSwnAOUAUHR5Liw?=
 =?us-ascii?Q?E6tmwGN83q4dxPJ6G8wzffiTqPkBCjArdrJ2iCTtbp5NtwAobXJU5QtIBYF5?=
 =?us-ascii?Q?wmNv11c9wc2UFkw/XbTWKHLOeqO3AL7itmnw5oyboCggM7PGg91E66WgHIwA?=
 =?us-ascii?Q?6+fdKF3KowO6amIa2AKl8IKhfBEBL1qZqoiChdoyUY/dxfLeIbZr8YTR5toM?=
 =?us-ascii?Q?ZMMTI0nzgDZCyj10CyofIst342fk3AbH48gz29K1s0/zOY4Lo/0TeXQDzy+o?=
 =?us-ascii?Q?U9ftuXauj84iIGLR4Beb1cZrx6xTUhWJFGwoheKSydpuujGRSnNxvKb4hker?=
 =?us-ascii?Q?MxODck7GZJc0pVWPfe3PpxuX0FR7NRcbSmZi3mQtoo4/z+5Gyt0QgWmocvUH?=
 =?us-ascii?Q?APUamDJQ30VMedAnUrNnuDKeqYNURH2JHd+OVzh7yZetsNZErL5IbOJhV+ky?=
 =?us-ascii?Q?QcLI+7NnzUOR4svRg82GkdGB4uuUVsQFMBjRADhGugdAEmcyqVBN+BWfTNer?=
 =?us-ascii?Q?VvYc3kjOj77nITnvQqe5oQxLTlt1KCRnN7JJzpoXBDX0cGXZz+QOKfpQKVkO?=
 =?us-ascii?Q?OVrLno0r2M4WjAG6saJKu7ylDrePhdjQtxNYmT7eCOUsMKDPQO17nPzbsyQ9?=
 =?us-ascii?Q?H0HttmciL+7IDMvbmu2WaDiaOhte/bsV8PhDV2GFwD7znUEu4b1Xn3jpuqcI?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe607dd4-925c-42db-0120-08dd45c5ad90
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 09:15:48.1390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBp6O8dxv96UllX7PBl2ppBX7DGGbmKijFbwn/mXBActS1jlvoZ/1H0wEXS9sAEamZCOXE3Y4/5PjCa+ChBvUdgT/5PJnz0INv/BXe+cA1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8181
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

On Tue, Feb 04, 2025 at 10:54:24AM -0800, Andre Muezerie wrote:
> Macro __SIZEOF_LONG__ is not standardized and MSVC does not define it.
> Therefore the errors below are seen with MSVC:
> 
> ../lib/mldev/mldev_utils_scalar.c(465): error C2065:
>     '__SIZEOF_LONG__': undeclared identifier
> ../lib/mldev/mldev_utils_scalar.c(478): error C2051:
>     case expression not constant
> 
> ../lib/mldev/mldev_utils_scalar_bfloat16.c(33): error C2065:
>     '__SIZEOF_LONG__': undeclared identifier
> ../lib/mldev/mldev_utils_scalar_bfloat16.c(49): error C2051:
>     case expression not constant
> 
> Turns out that the places where __SIZEOF_LONG__ is currently
> being used can equally well use sizeof(long) instead.
> 
> v4:
>  * rebased on latest main as previous patch was not applying cleanly
>    anymore.
> 
> v3:
>  * added prefix RTE_ to BITS_PER_LONG* and moved them to rte_common.h
>  * defined PLT_BITS_PER_LONG* in drivers/common/cnxk/roc_platform.h to
>    avoid warnings from checkpatches.sh like:
> 
>    Warning in drivers/common/cnxk/roc_bits.h:
>    Warning in drivers/common/cnxk/roc_ie_ot.h:
>    Warning in drivers/common/cnxk/roc_ie_ot_tls.h:
>    Use plt_ symbols instead of rte_ API in cnxk base driver
> 
>    It can be seen that the same was done in the past for similar
>    macros like PLT_CACHE_LINE_SIZE
> 
> v2:
>  * fixed typo in commit message
> 
> Andre Muezerie (7):
>   eal: eliminate dependency on non-portable __SIZEOF_LONG__
>   drivers/bus: eliminate dependency on non-portable __SIZEOF_LONG__
>   drivers/common: eliminate dependency on non-portable __SIZEOF_LONG__
>   drivers/dma: eliminate dependency on non-portable __SIZEOF_LONG__
>   drivers/net: eliminate dependency on non-portable __SIZEOF_LONG__
>   drivers/raw: eliminate dependency on non-portable __SIZEOF_LONG__
>   mldev: eliminate dependency on non-portable __SIZEOF_LONG__
> 
Just out of interest, is there are reason why the simple solution of just
putting "#define __SIZEOF_LONG__ (sizeof(long))" in a header file for MSVC
is not done? Should be a couple of lines in a single patch, rather than a
7-patch series, no?

After all, just because something is non-standard, doesn't mean that we
can't use it if its widely available.

/Bruce
