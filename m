Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CE2C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 10:55:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 221524026A;
	Fri, 10 Jul 2026 12:55:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id A58DB400D5;
 Fri, 10 Jul 2026 12:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783680937; x=1815216937;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wUZXkRC4d1DFG9BKk+dVABXDo0bHzOQD+9lsWXs2e3I=;
 b=bQBQIrRms53Gc63wm5ywYzEzUwckxNFa5QAV3RfmDrQYPm82oRtRrD1V
 ZA4MA7sgpA1J/LELrU5OPygJg9y+s32KOBsjQTr8Xwg154cmPPgJDf1kH
 N19+CIl1o7p/XtIKxuU0FYbWyHoqw7jNBYw3KD8QSv6oqxLGCVTQOJQ2Z
 BJUoVYlCT4lR9UREq14DMHyVgxnqdjJTF0iJXbn782DMCF5pl0FEk3EwE
 +B3+nZ/dHcZFg+R35QJhpGXoOkf0CtkKPPG9JGJ71UKr1P/uAL7xM/KQD
 R7egVFDjwkWSED+2hAF14TJtg1XUnzSyPKhi87HGyq61yZlfwSDTbgKDm w==;
X-CSE-ConnectionGUID: OyZWrlLHQRK889hEnQCtwA==
X-CSE-MsgGUID: H5lWWvO4RWW63jSvcljCwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84399566"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84399566"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:55:36 -0700
X-CSE-ConnectionGUID: bg8ui++dTzS0/VdR5A7CzA==
X-CSE-MsgGUID: nsCn4ytERoC0aF+RGY3pIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="284959156"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:55:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:55:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 03:55:35 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:55:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrH6Rsy9r22HY6xdUWz0cnBhl/0ez4wcgVUf770tTIVcLSJtlKm36ZyCWr2t/4LEvbJnEROTPtOVzzEjclsRn7TqhGyHPnJ2u6lD6ffuoCXoHW+S7ivg1ZrR3LpNVcYdvwRy1UXLuhyHLBpQhEPI8xJDAm/X8MbKHs3NUJjqDTNvSY0Q78txS2+78H7s6oCQXVAQuxA2ks3FZKsPHxpL/D9E86nF50KSCRfHUN/PqtXgpqXW9xQnS1AnEOzaowIOcAsrpbVR5CF3kx+VEejWeZH0Ak60+JaNLw9ssrf4WL39udXHm5b1fTdRtSb4+RRePOgjLMP9kC5IVDtghslv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQcmQgix6Urbqe+OCKAWcOLb6CMSqqca0WTvSFwuReY=;
 b=xM0nzJwsQ6NhyWVoCjuvDORgXX9Ag51RPpV01Ly/BwnCUR+bW2C7G6lY9b/LL3ZNAhQ3d4Dg8QWBzoPQfeFTRk2U7QLZM1f6dMr7KYcOc4ln/MuaZgN4d8NdSGOiFRnF/rUwMjGgf+8/oVptOsLEnrfvrmrIcidaX2phnrxd1Q95C5gFhhAmQII++Day5lYpakweuGK069f4G4mjgPfd+oj9298kKwGsZxSXBGxOqBHiixgO419kI0H+nchGpk+tZ/6XG6sD/lGQ7pS8NBQaDfPDmNLFJC4ze5oaVqTC6ELffUMWTKucA90Vh1pgzBIShqBgzu0oHn3zRvPD34xUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA6PR11MB187491.namprd11.prod.outlook.com (2603:10b6:208:5e4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 10:55:32 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 10:55:32 +0000
Date: Fri, 10 Jul 2026 11:55:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/i40e: fix FDIR flexible payload issues
Message-ID: <alDPoD58N7ssSRhh@bricha3-mobl1.ger.corp.intel.com>
References: <20260708002045.166595-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260708002045.166595-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DB9PR06CA0023.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::28) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA6PR11MB187491:EE_
X-MS-Office365-Filtering-Correlation-Id: 78630698-bbf1-4a57-2a5d-08dede71c375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mwPASkbcB/VFZGdZyDcri+xRiGFP9feMEZbBl6DKGkn2o9uJ7E0jPnWb8mzO?=
 =?us-ascii?Q?pNqZD7FETx0HlyNLn7xqWjy6RwRq+8wS2Mj4+7w24lbGZgZsQOGMEyrXhRFK?=
 =?us-ascii?Q?5RPw9UiBJU2Zm5/HwT6PrV9zZsLzAyZt7vkgg2kLl+c/vITI90ydrhtExpSf?=
 =?us-ascii?Q?BvEkF6FF1JXwvj/qIJOUOA7IrMnRZsbjqv5LNBMZZSv4ELiuoK+AQ8u44R/0?=
 =?us-ascii?Q?DMOQ3tcDiPuIOpcF0oIH6MAmhdXkBFNnnD3WYo6TXraHuPItqx2GqXaokLer?=
 =?us-ascii?Q?HhZWdDup3+jx9lAQX/A60pcq71Uu+uklcOGSmtisxmVQsPMex3NzKcmh1XJt?=
 =?us-ascii?Q?elq+kyNbFUcaZhtIww8X2FQTfGtJEzimS772aaztQ5OwqnVym6fAXPHMx8tW?=
 =?us-ascii?Q?v+4Lfo+0mr4QdLTwJKa27SiYB0emc0xGCDqF749mYQ2wWutEd4bnwiXLNkdv?=
 =?us-ascii?Q?ASXMH9OX+2sb1AdxNKpXAP0iey9ohpD/vHtCj2A+aumhRFtUtlVhVnIqyBlO?=
 =?us-ascii?Q?YGDuzFwmqhPHTx1NR+4RvJK455ZtLxA9JQV7nLf2nlwW6joZC3kFCLhnhPTu?=
 =?us-ascii?Q?co1ZpUC9zMzPu64wZhTzf74oQyJu09+wN7ZccSh03jSvqdzaRw4sZv+gJ09q?=
 =?us-ascii?Q?sdMj9MGMe5EUNMAlkxkyopuRqlKeXqKAAqHT0mrc9c6fHupfClopKsLaECfk?=
 =?us-ascii?Q?9dZkKx6Zq5AnERx7oWdxXWGygsgCcep5vCRBKmY4FML2O3lD5UyBPTeO8OnP?=
 =?us-ascii?Q?mHY9RFpteSXz5nRVpG6LezfYRkwy2v898RLrCkzAODuIihR0vIchYcgY5Osx?=
 =?us-ascii?Q?KQvdXessjf2iuASjMDFkfG5V25HQWU3oJoSwVFqy2SaHedXZj4xDTeRyDx01?=
 =?us-ascii?Q?MlUY54P+fzOwqt+1tucWGduZ+YsnyCinSf1eeOs7O84SonvR4H3c7IHZbX5W?=
 =?us-ascii?Q?7Y86tRN+Ew3Mj+RY4T9gi4Qb/yFQh8CgFjItO2Ar1escVlf1muVw3ibxhsKK?=
 =?us-ascii?Q?SPDlRSWwSYreJg8b6zS97CNggg3P3yGc41HuzsavcEBuPdsAoF3CbIkzlbPY?=
 =?us-ascii?Q?AbuGU322+aiFPUX/ZIvc5l9ScMvOeco4d2oDrm/L3GCOEc3yBb4q4enMyK/z?=
 =?us-ascii?Q?vt5chVjG669J3xRitQONDfJ4NRefmEEd7ecvGRzmmyHQTjKc8uMMdRHoCoDr?=
 =?us-ascii?Q?UyYYoa3lpJWI9LEep0/4GHkMhMYNgJNeNsd3RQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BdtfZ0pvB0E9hXm3VMJTUmFN1pSLGQ/8e5VB9TfnfwVpiXh4WIX8E3m4oTfO?=
 =?us-ascii?Q?lP4DaJvnBGsP3Hu/rrp3lw7tjD9GJAH/Kr9UWwK74Bc1Pd9SMJYW3XfS1m2X?=
 =?us-ascii?Q?VjD36k9Q75T7wxW3Zo5Ohc2IeJ6U9H4jnKQ+W4BsDM/BjnOOHqafdzA3PX55?=
 =?us-ascii?Q?FpHeAmaadGWALayfOQUEPNdCJ89sN2Pk1pL4LrZXA/V7NfWPDDGoK3IjfP/r?=
 =?us-ascii?Q?9B4NkQT7utm7OjV/i3kS2DRi9+T5OSDzmUxcb83HdSasTFXNGVxpIkJ9MqHw?=
 =?us-ascii?Q?+diTtDnhlBgA68gII65TClIAv3FEBJMDiTQR2s4VAMvOFaeN5JZvcniQ6Ter?=
 =?us-ascii?Q?uPGr1akZwz/AXoaJq4q10PlXXu37jHBFQDYQMrYYWIpiDRKbyrK1OLQUb2Ge?=
 =?us-ascii?Q?6lQOLc4AVrms4SITU8iciNjEh/RjLCCidb+mM++Pk/ju94XLgWX8KeRkUlE/?=
 =?us-ascii?Q?wfkNXhKTAlV1SMb9OzUiZ5zzNTvYJytYFu2Pk2v+KPkZL/oOvQk7IQnPc9YD?=
 =?us-ascii?Q?HyfDkJ9SVRRUsSWaiiUlElaAW2L+EIch+b7VVuDhEQFwaTgX0/reCSu5TJ0+?=
 =?us-ascii?Q?fsT71lfHHtU0RVJHBnBCbAEPfvOlft4HgUnqM2M4dfEf2cG3LFjCTMln3oPn?=
 =?us-ascii?Q?RrPeCHwrtkVH5e5aYUE/k5G9g0wGQBeClDYA4PKKjlRhdVwAzTEuF41YwtQN?=
 =?us-ascii?Q?N+11LI/RUoABNtFdAgzSKgwvBiVVww+gPZHAj4sfH5Rq082PoJM7Uxp6+nbe?=
 =?us-ascii?Q?t65PVBwh8UMYoTvyr5TMndCj5Av/sgRTRlEZ5DK78Z6TBG2ZlXbhO0r8/pfh?=
 =?us-ascii?Q?HR9oKuD8ofTWTVFOKNvy6BAsCjpnaAjT5W9KsCQoopi+ig/D9Fm2L0SRZu/o?=
 =?us-ascii?Q?Jcbq0Qbeb9IMbAo1jTLCeqx1d4wGf23dXUarzr4llX/7nFd5pxz8HckZCSel?=
 =?us-ascii?Q?EYNQuW/QWktOXsRELEyIqhK4MlrYNXW9pDuVJW6mB5B347gyeYDzltYVNXMU?=
 =?us-ascii?Q?L1fAJhDRSEAG76Fk1mPaCF9eAa8wL7z2I74ptFAQzgbfYmSh+lJqfI8prUxA?=
 =?us-ascii?Q?jiUq3P5FZGeX6oIpf0Tfmn39b/EQ8R/4H8pnY/ivVGr/QH2wyCaoOOMkZ6KQ?=
 =?us-ascii?Q?xED+ayMygSJ+Iw+39meI+dv+MVaze8IAb7x1kW41DTj7xNJ6MhEMR6JoPvWl?=
 =?us-ascii?Q?GNxAJHmvn06IHd0TT9BCZ/7Qev+0hWtEM1/TzaPhjvx05+JiC28VM/v91uLj?=
 =?us-ascii?Q?iFm3MkMQ4Nd9lli4cQsw3m97HztDG1kliql9QfQ8hg7+WYs4k9nDOaWrGxLE?=
 =?us-ascii?Q?vrrfWCWAiyLoRUpMpeuoKR6IvNIiK0dIp3bFOJdTbfyIRSlHeAEIum0qzIDz?=
 =?us-ascii?Q?1b+v+A1iGPnqGWMz8tUGxHbKMtKvYrrACYCWmCwg/L52OY8wY79QOdkTFUTg?=
 =?us-ascii?Q?+cxfuckfcVZ+39ttqJpTDmGAbEYNZxoWGZH2RX9MsTAkQlmOweZsuSP3M47F?=
 =?us-ascii?Q?xrsw6FmWTVwdM7M1CPESUdrjhyacb95mDlX3tPnEMTIIlob93uibdpGRo29T?=
 =?us-ascii?Q?+3R6ztTsEzlCN0bIXh7hCXH6iKRBFqXb9O0y+v+Ur3RQIxJwkGx/DIJZ9Jej?=
 =?us-ascii?Q?07gP5kfDm0m5kADAItRAvIPLcjCfyLeO4SKIP2o+1rPsCaUZwjcZyTzIpZvM?=
 =?us-ascii?Q?xzvcxJLoFEwZv4PrStwM6kF17R1cqf6UsgUQ+32df+z3HJ90TDAoZCu6rs7v?=
 =?us-ascii?Q?kqOtvzhgX2XAgJFfOoqpH2YX6zkgYqs=3D?=
X-Exchange-RoutingPolicyChecked: OL/nCQgdInXTEFe4XSZgM379cEzW3sxrGtvYEDTV8cIyRyw6DRqEQegBZzTA3hKRTfeOuTsda1ywE1RHG2duPHSCj0fd2zruD6HswpEUtFKSLxzPeskkUbAPOOqe+G2xxJvLnbeCQf528fRj2eTca+5rsHoInnM1eZ/8Xokgy0vxm8+bgWCZXXB+twjAVfm7Y3oEK5vNF+abKeNGajtazgxM1RUppg1XWaSiLWHqNlbuk22TJwGV2tN0Qdb9+ur7Q6/+RC1CkdHT858eFPl52Ajb5nMNqwg9guUllMKTEVzzkShMGqE1FfBWLKK+BcfdDdh0DWMsJ3zFkclTuSSVQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78630698-bbf1-4a57-2a5d-08dede71c375
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:55:32.6625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HchZ28smkdxB1Ef+YnlYmb2Wsy6PE3GTfXq0R0x6WabecCbYgUCtUx8/n+rSgSuk4p4ZAr7K38IfavZBJwaLQX2BSA5jHoVPOcw05bQwdzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR11MB187491
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

On Tue, Jul 07, 2026 at 08:20:45PM -0400, sandeep.penigalapati@intel.com wrote:
> From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> 
> This fixes two issues in the i40e Flow Director flexible payload path.
> 
> The bitmask array bound was checked after the write to
> bitmask[nb_bitmask], allowing a one-slot out-of-bounds write when the
> number of partial-mask words exceeds I40E_FDIR_BITMASK_NUM_WORD. Move
> the check before the write and use '>=' so the array is never indexed
> out of bounds.
> 
> In addition, i40e_flow_set_fdir_flex_pit() programs the global GLQF_ORT
> register, which is shared by all PFs on the NIC. It was called before
> the flex mask was validated, so a rule that is later rejected still left
> the global register modified, affecting other PFs. Validate the flex
> mask first and only touch the hardware registers once it has passed.
> 
> Fixes: 6ced3dd72f5f ("net/i40e: support flexible payload parsing for FDIR")
> Cc: stable@dpdk.org
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_fdir.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
