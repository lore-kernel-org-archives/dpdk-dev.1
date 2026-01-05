Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9208C2A074
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 10:32:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C12074026F;
	Mon,  5 Jan 2026 11:32:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 2A70C40267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 11:31:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767609119; x=1799145119;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=CeN9l0UfuN/psPSiYIe8k97kWL1pxaV+Jw5j5/5Mh4g=;
 b=hr7r9quG6p/v2Q+1pdE8XmxFBO729TManobvSRMGILkjCniLPilix4CT
 niPILYTg4pfe4kba5OoEwK8gTKAUxaKKhZJc7EG2+P5BMA6Ubgu3KPd3a
 iA9ZHo/kQUy7/ktzVSSi0TV2JJMEewvPWqaRWfC2cNc9h8YQSjFGAu7ar
 6BSZS0ewtx0g1HRueWWt1HW0j4j+OmVovbNRW+I+f/Qu+Y6ze7GtmAUL6
 Nq8pKZaiMHCgkiSno4Rsehaxmi5IavJh8BjK6ZrvIXsONaxv5WzCcHfDQ
 JgHIqyAIyM7iiNTMFh7CIXimDvGMJfVjbYbgWbYD0YcAdwx/Dz6GQzZ8Q w==;
X-CSE-ConnectionGUID: Ksu71j8wSimbFJvDoQ3VkQ==
X-CSE-MsgGUID: bGWjGyUYSyO6dNDTb/n63g==
X-IronPort-AV: E=McAfee;i="6800,10657,11661"; a="68713276"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; d="scan'208";a="68713276"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 02:31:57 -0800
X-CSE-ConnectionGUID: ARIBy9JmQcuYc4Eldo1ymA==
X-CSE-MsgGUID: 8gyzRNTvTIuzEYq3rVcGuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; d="scan'208";a="207241725"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 02:31:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 02:31:55 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 02:31:55 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 02:31:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8SlEwxdVVtD4MTpFBXK73O8wujYQ/vxySg1iD9UuI6VR+ABo++0hRK7DTGiiF/LhdN0JaWIAdqhPXFKbOOX+4AwFB6jnT9wuBPkOMpXnushO/yl5j/DtfzufG4vm2pp3B3rTzXegstolnlKvOeZ1Y1SpWGDlayB9USnKQLrnC3bF8l+jo6WMeP0jWeFn0trps+sJbdNlgg99H56K6KVW8zMvxvR6SZ5IwH1Hgx9XHg9aN5F2JEGqY3qFVAWUQExK9a85WmwxmAbakyZmwHG6xNSAs2HGvE/1HoIEDvNQHOj403nHGiToq4Ie11mLhDeHGNdipdxshaxApShj/S1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLRbn/dXO1E2lUcpclFtysBheNFyUxjMVd7AZWURjkE=;
 b=LSUqGPmulJTZxyLLXB1cVlIkW1NkrM+8JLmeukfFEGNcCgGpizvIQ/xYBfQobO+0j48LIAZQZMDsFuxLK/lKnXUBb/E9EWmvX9oo2V81C+CutozBMClLPCWoD2kI6quUfxfkADPd0YMJgAsHilBJwgONSNQsT2wO8SLKgqD93mYP9w5vB9y/4OKLAl3Q46mOMQJ7wbLDtfl9qG+PxbcW6vaeU0VowB73INiXjcQi1iUDqtY/nGOzkLAEq/cl9QG/2TnO0+ZIvMXkGxSLo6x8O6st18Cvmpy5+vqVrXH8YysJSM7VoCRB8F6FiHSkckxP4YHjdxY0RitDXCGtVTRAnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6564.namprd11.prod.outlook.com (2603:10b6:510:1c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 10:31:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 10:31:48 +0000
Date: Mon, 5 Jan 2026 10:31:43 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] mbuf: optimize detach direct buffer
Message-ID: <aVuTD6Ex9k9kXxMu@bricha3-mobl1.ger.corp.intel.com>
References: <20260103174054.121246-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260103174054.121246-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DU6P191CA0069.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd37974-d2bb-4efd-242e-08de4c45a1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Q5GRYkgvMykXHqH2TMpN/eVuKs42sg/PttrtKOi3TOQ0xL+v3VY08HfZKO?=
 =?iso-8859-1?Q?zu5ANHpn84BmnfutVBtNug86m55mAJ6e2j2LHdLlRO/iFWthRl0Sk3V9qL?=
 =?iso-8859-1?Q?hVyKFOuK60h7zm1FeHegQ0s3OhtAdPrttiX+lU2PAsGHMYFtYkscMgOwp4?=
 =?iso-8859-1?Q?o3F7S9bBUJzdd9/DJQdrT7KP2iTxGz5t+hNoO7fYwcEko3aCQXrnlxBH90?=
 =?iso-8859-1?Q?FYjg/sD9dWg9oS5shvQPvTGjNMlGRE8IA04j/bESdojt0u70AcjvYuegib?=
 =?iso-8859-1?Q?Cl/zPSWqAZO6cz+Sh1s4z5YfYuOuNlcEgsejYrs5zMGrLKZbtv+/ATK42b?=
 =?iso-8859-1?Q?NjmGzyb1rhv7yDxNJF41wj7lvnmrqOCP6ooi0hZbdtEcaRPWGuc8XJKCZr?=
 =?iso-8859-1?Q?epVGpRuJAQCZHt1bUaudt6z+rxswFrKak/pwXBo6Fnbk1ev0xrXXgbcTrt?=
 =?iso-8859-1?Q?urrYpf7ssduRjavBTNSGAo4L4BVwNU1MB7bSKdwp1Lp7vsWQQp6Ils+eeV?=
 =?iso-8859-1?Q?YI0zSO2JL8EyKf7Q091MvhMsvqRm87Dl01QlmnAixB+dZnT0niaa3/Lodc?=
 =?iso-8859-1?Q?R3JwoTZGOihdXMnRaJw4cmPzqxxD2ZZYiluTswQZ2GwNo4UFdSEWKniMff?=
 =?iso-8859-1?Q?uKAolQKwjwC2QH3p4YVpYkilZAvSqQtlGNa34eCkeyblDUtsjg7eiK7+LV?=
 =?iso-8859-1?Q?vHWr2Xv9V1vwhkMjXwGl+CYDEXyzyQ+XtYyuJkiX1He18WUaImo+JVwcPh?=
 =?iso-8859-1?Q?brlo62/m7z11tfdYcTBP3nD+zA9j4/mibpFSA6YCjIPDqKQT5DeSjmiiMe?=
 =?iso-8859-1?Q?Bj+GPizQ9Mp5RkNNvnRvJAyh0kLlfsfnugDog317Yewj0rN7PzDR57/OYO?=
 =?iso-8859-1?Q?WzryFrPLg+8ziuiGrentjbt8z0FdH9U8yItbJ57jz4z9hVuDFPxo6MLPX2?=
 =?iso-8859-1?Q?mHOZjNagQODAm4Zvl2oi4uNCECRYixTkPyxtwagIO5A09mJn2Jb4ZSlxeQ?=
 =?iso-8859-1?Q?mWVUHuWGeDZp9tFQiehGPYWnUr2QrgHGGRsJHzpS4TA8v4Irr30/usW8fY?=
 =?iso-8859-1?Q?wRIVBxbh8pbG17sqN0tV4iBtH32tUGw7uUY/uc/a3mmzjC/Pfj2QuP7C0V?=
 =?iso-8859-1?Q?hHL8ZLqrRjVa9iAONZpQ0TxK47+az1bDdsAfyNd9X6fAS+hCMQzdkfkdEn?=
 =?iso-8859-1?Q?3WPlMYn5jmKFqng6g04gVDpUWu0WUGgb3DJJoIHzg5/fjtvhOKoEOdbhhW?=
 =?iso-8859-1?Q?XAnCvArpQtXd/pSVTCzCRKt1NxpgKmB+fnWdxOc8nKmjwIVEvD2YfyLdLU?=
 =?iso-8859-1?Q?OiOYAOJjc4ual0ioZ33J8Xf3aAThT4B+OTO5+AY5bDOS8ygQuneg8eDwZg?=
 =?iso-8859-1?Q?Wpcbprj7FQ5ztrC8g+3T9erDq59qyrHcWSP+QGLXqN8aHbG7pCZlqezTnM?=
 =?iso-8859-1?Q?B4N6DHdjovTM3DvaaGIkwh7/SHlH+fjzxZc2vycv49SDSbmoROhFme2I38?=
 =?iso-8859-1?Q?cLHDrCDkFY10KLNtnfCCC/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vcAZGJ6Z3gMtDoflpqtLR7msTXP6AT6I0q+Ra8hgJ0ZEYDNzOwfDWAwL5j?=
 =?iso-8859-1?Q?hRp+ZYIQFqvoxuFY8xKmkp0RewlyNN+QzmIHQ6DSpUUBhLVP6ns2W9oUIv?=
 =?iso-8859-1?Q?HVLEMJCvj1axPoS+gH782ptUzwwyjttQhgKmhBFflT8FHsMgVPxNdiB72V?=
 =?iso-8859-1?Q?QiEGG14qv+6mFEtzSx/czCqkPnMvfZvhMY4I5clTRmjTZZu2ucnKGkh8Eh?=
 =?iso-8859-1?Q?Y+FWnJ1SAKokb43x6uA/xL+pRmwUWteaFDhHvZnR5hWi+tsJKxcY/E+4VY?=
 =?iso-8859-1?Q?avXvMS8/SLwuQmJ6GwnL2IkYxFUbmUSOB+NHHX5ry0baAkreV2QmSyQG4x?=
 =?iso-8859-1?Q?HO2HKxS4MPuHxaPXbfS6fYSY8ytDl4jQX8Zv6NO4Sx+Sr0VlUmFTS5p7LP?=
 =?iso-8859-1?Q?aD7NxEUUg5JYGw8y1NYS3U6AvAkNKm62uODVgu4XHikTiBDZVWs/5PVVLy?=
 =?iso-8859-1?Q?P14JkuTitnoHMas5vnX/HLlvRnAMVgb5P4VMG4uAaRYoUs7gz66bIeZ1Db?=
 =?iso-8859-1?Q?8E0bXpUMEFH+YXTSDeriMOg3UVD8Y8Nfvx9wDtWIWb2fRaWYlUqajuCBF+?=
 =?iso-8859-1?Q?6UkxjMTSty67RQFTTpVyEr9f03l8qvFtzUkjhS+vCYM4hpbyDc0fnngyWK?=
 =?iso-8859-1?Q?s+o7kPP/T7oxGZU4OJn/jDtKldYceivI3HGtTOS9f1vlS45MyotUnpdFpb?=
 =?iso-8859-1?Q?UL3rA52Kr2KOsjGIJ8sSd5Hi5QqGIswWM0t/gybWSEQUPKhYwD+DiZ5Sqv?=
 =?iso-8859-1?Q?CiRHoVz0bvFJlV2m6U14GC+g35RiKC3ZsPrb6fWAF0DKrUk8Xo5TArVwSX?=
 =?iso-8859-1?Q?pAZsjI+ZZXpEVK2XIMYZLQWZnO9GbdMkIlnBQ7XVyOn1Bls8onX6zQhe3b?=
 =?iso-8859-1?Q?LXTSm7KgjqUnhZIj6u+Q+UKhz1yCR1Qrpm8FepZtts5chPht2n+sk1PRII?=
 =?iso-8859-1?Q?3M3MBwmgJ8m5gZddBZQ0XtEyTKbzxKlMVbCGRxvO4pXfRMEQ6kgECDZAYw?=
 =?iso-8859-1?Q?8GbT2b43UG1qxJVg2wB+p48mk1D+kqi+cyehouZDHt8Jas9wF0t5Mrr+m+?=
 =?iso-8859-1?Q?OhjaTGFZvEAXQhFbgdBsEz46q1C5zZh4Q/qaVFQCmdTdAREQ+xio9MUPP7?=
 =?iso-8859-1?Q?JdVPaaGCI2LRI/+WI6/4zxZsnIoTVDp3Crt8m1/xnxBz2CHicGVEX1lPMB?=
 =?iso-8859-1?Q?c5aVxeDCtiqdYxRXRgMFAa2Nm2fMptvvL/VW0J8+KLc8CppgvxASNV2J+P?=
 =?iso-8859-1?Q?NDQ7ikKd8Zrq0wcxmxKdcwlkDcCoQBqfM5Y9fqFdQ9+VViSk9njaj4+sJW?=
 =?iso-8859-1?Q?Hr4rWQp8hKa/Bx1jnDNG3D1iJS2zgNg9Dka6eijZ8hYuh2rnronRBV01l0?=
 =?iso-8859-1?Q?/MfuQiR8JGDV9Wb0nGuVF3pcOJFQVtoXlCx1XBOwL4HwAdqaHwKsrohOV2?=
 =?iso-8859-1?Q?zSbR3/QkRMJEkwV7McjKL7SQ9q47PQt5mYS2rNR+ExcNkRpRvrW1nkxJAD?=
 =?iso-8859-1?Q?nzTGZdAXMn3MUMu0CA1vXjReVM4F7csIYOzNve9N1HIp4QDnidTtH+QZ00?=
 =?iso-8859-1?Q?YhiUc1KSghnY7AAM975t2tCttAhkzrDam7uq7BjzOkFGYP7Bs3aoIGW5qe?=
 =?iso-8859-1?Q?rmhJwRCwHFZiF6NSsKHEIaIRkfcFVLA70LYqXFYIocW2LyTZMJaaz/dMFj?=
 =?iso-8859-1?Q?kPAtZb8wQ7mybrfirkEEmCok9EVk71MvfO7Pu3bRg6kHPEyOtUIHTdb03b?=
 =?iso-8859-1?Q?JKBR5wMHRDeaRvvPwQptFC1fy9h7sOKwj++z9ASXlgNaK2WDA1nqthC06t?=
 =?iso-8859-1?Q?ORye2+x6Hi7aSr000mf4O1M6rDcm0ro=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd37974-d2bb-4efd-242e-08de4c45a1d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 10:31:48.5700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWbh+Wo5ffc0mTElrUhgpKOvuWDUMoEReoCYQxoNjUnIBMfFnArXC+aHfjnATLRRwhkDAqVdGMEA+9Dpbtj+oj41GmpUmyCFsBw+CruEvSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6564
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

On Sat, Jan 03, 2026 at 05:40:54PM +0000, Morten Brørup wrote:
> When rte_pktmbuf_prefree_seg() resets an mbuf about to be freed, it
> doesn't write the fields that already have the required values. This
> saves a memory store operation when all the fields already have the
> required values.
> 
> This patch adds the same optimization to __rte_pktmbuf_free_direct(),
> to improve the performance for freeing a direct buffer being detached from
> a packet mbuf, i.e. saving a memory store operation when all the fields
> (of the buffer being freed) already have the required values.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>  lib/mbuf/rte_mbuf.h | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

