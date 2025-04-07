Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783B7C369A2
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:35:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4D0A40A8A;
	Mon,  7 Apr 2025 17:35:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 316F040A89
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744040142; x=1775576142;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fEST+WhF3I6wV6A8BgFOUUXJZM1GpLrp1fwDdHOsjFM=;
 b=abcllHDiHa3ThQmHFv+qAvGMk398hWtDv4y1BBjq+qWApIpLafsJ2YvG
 avmsPMDiyx7UOq4Q3xUMbfkBpGInBtWZB6FIqOajfeEVTQJAHEKd4qeFk
 qabobC4iguvkdID0Sa+hV94u3THN+Ii9qgkPHSMFrpCFhJ5HrcvgDKEXz
 Y/HW985qqarQMi5Cis3ve0jwLqH8JaRnukC/+R4HJQwxocKkKdxT1BVlq
 pD3+hGuRc4iUYLcJkkqj6vuHZef9BZPb6ECzdb+3PHtJKYrrN9/AOZFN8
 CF231PFbmyup6X5XBz+s1nM044qZY5cvscCGe6JMMm1xOwExvnZyS1z4j A==;
X-CSE-ConnectionGUID: kzj9lwQuRlyLiCvmvlG7lA==
X-CSE-MsgGUID: g0cYLuTxQZOBf+o2i1Zu0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70811127"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="70811127"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:35:40 -0700
X-CSE-ConnectionGUID: OOl418V4SieUoyxbW2bD+w==
X-CSE-MsgGUID: +zUFLvpjSmKVLHbgW995Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="128854595"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Apr 2025 08:35:40 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Apr 2025 08:35:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 7 Apr 2025 08:35:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 08:35:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqjrGEPgOnQKmhCAAmcNdKc+bsVdtaKbERAXhMJJSM7u1H71cbkTRNh9oZh28M0BxiqvtaDHDZtMJKiqvKY3VeUU2vWI+rDgL9VA45PKmHW2mIUnW+cIK/jEzd7nc5s57+g+reUT/1YKtzK3f3KzbGWq+UjJ4+fXW7vU2CoM5L/gKX9seA4b7achKrrhgiPLWKBZFUw739cSuMPmc23ckU4CKw0t2ElE9uRbAi15EgNqqbR7XOd1rMEdFL19WNNySonIizJZZMPB44fi3aGoSE/+uT9JBxYBSRN7Vbt7wBKpsLuAuyaHlD/rf+g+9l6+/qdnyk938+7N+HVAS+Pkng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGxsxcquwNQqeBDIbpqjcbz4WhF5/HOOaRaKLdrvnJ8=;
 b=ULecTxa/cWVMPg7g0ZTDZqcDqNydnGSC7R0AUJiCwSBxYinkDNnuRzIIp9RT3MeILTSItVJiWkJwvkAWxj9Vbtt5PUE+96SbVtFYZTrbwh+9s+vW6tQTxeotafe5kRDyyrbb/pTv8l8B4mTHp/iLzw+6RSeIWWlTMJ16jMK6V7uSmTVqwPi1wHtcp4ELLt6Oj8Os+dTZyzgl+LcZmHG3lsW7YqOhZ6xQHewDwM1PB493cKw4A/hFiciPzgA5KlByQRwuRjaliYJ8YRV7VUi5y6F6Lx+TaxOVUjBnth4A3hr5UQibX3oIe6UvWY4fHt/tyBr1Hxd13zZreO8lQ3/6EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 15:35:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 15:35:05 +0000
Date: Mon, 7 Apr 2025 16:35:01 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, Jie Hai <haijie1@huawei.com>
Subject: Re: [RFC PATCH] drivers: add generic build of SVE files
Message-ID: <Z_PwpRYVsXLR1QBk@bricha3-mobl1.ger.corp.intel.com>
References: <20250407152857.2203839-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250407152857.2203839-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DB9PR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::30) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 222275ad-a9d1-438e-a8dd-08dd75e9c587
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K4BeH4VFQZ6TELtdnulB2fMhwuszXbfipWrh4q5czSP8iMOLyx9I27AAOg+l?=
 =?us-ascii?Q?U5bjeKoi8FIUF/oS2X3cPpRKjJlP4XquDRAhTxupWpAMlH3jl6z2yd6nZSeI?=
 =?us-ascii?Q?xRGtSVZ6OZyFMrBiK4uNohTkaTuE19870UDuDSFBKfuriqimPdKab83cvq6Z?=
 =?us-ascii?Q?6gdoaRqJwpv0iS0synJd0luRezWOBAVYWYSDc4OFkPkXWYmxXodhoEhJEVwi?=
 =?us-ascii?Q?9ZnI++VIj5aVy9H03+LW0Vs4janMPVxsfgcpD7SR4up+/846ZHui8G+k9x62?=
 =?us-ascii?Q?lQDBTlIBVjhpcSmvwoMFdh2WG1DFiYq9ziM8BsQ9k8E5Z3X0zxf4vfNIbxmH?=
 =?us-ascii?Q?OHkDUDFHaq0yUt9oI7Qe1d2pAgvDvez2oK971n0yTJzKdkcTMq1AzkTM36ls?=
 =?us-ascii?Q?XLRtTj+7PYNokcs0oUA4fAu/v4dEORgTJ78hqOCDGLMwB1t1WeLBHYvi4QIE?=
 =?us-ascii?Q?VGwIlNKERwGLEXPaVxllUyeu5/6V3tuhqnk+IgItIsyojNjfGhQsnn0xRjKb?=
 =?us-ascii?Q?WT0Z++NnHIGe+BwnO7HOTohz/In2XX3HxdMbi7zzfIxZhq8LCnRbMRRQVdqi?=
 =?us-ascii?Q?WC/LGXfgybbtt1uz1e8xobUNVRw3W1XJoVkAbb/zxPdAenzQf/CbO4+h43Uj?=
 =?us-ascii?Q?qBDhkfbM9DielJ3sSR+7E46GmoKi6tHK0IT46AluJkbq2e2rbW99bTBYjvnR?=
 =?us-ascii?Q?mOmH1FJIglsOPWocZl4roOc/M6XJrCNHalApQ/4h5tQluflZS+4Y+OonofL2?=
 =?us-ascii?Q?dNKli/hKYzY6mhQZB6gQomm8dqn1zYzbmvimMBI6+7I/vHV2OYAkxNH5X/P8?=
 =?us-ascii?Q?DQVxEckCAQjUiBPNtglKRrpdf9VtSDnS412NeRl3l7pOzvpc5jzdwbnnMD53?=
 =?us-ascii?Q?Y4fXIbdjFTvOV12Ls/4K17hEQpqV0cRxn2KC6LT6n+CfEp3JeMTDjIQvJt13?=
 =?us-ascii?Q?WOAl7a5hT9K2OmxqzHhMyek8wUjuhlm2X4t/Ba8QVatiq9E05ra8Hv5bdeIM?=
 =?us-ascii?Q?4uU/nnyPcrNgmOcIiF9X1m6dRW80WJabTbnjvawM7TDnLM04tY2Mqj4Lxvmy?=
 =?us-ascii?Q?hkENvZfH2pA6vkxMbfnfxHRTnfL7ogbO6onAM7bfN6CVrTEICQSzNlFMLFFL?=
 =?us-ascii?Q?0+2Bcm6R8SMgspGrUKZZk2W602kC0LtfJdCRyLsDmDHfmZHuDjX0T+GDOUSA?=
 =?us-ascii?Q?yW8ORie+Ub3NglF7zpVOa40oLnNbIi/xXZbCSWZyQ2GsXy2n6RDLN8/c1T4a?=
 =?us-ascii?Q?iz3yYN5g26zZGjtqMuFVvOPwiy+mWJJm+LTdB0dK26odNn8aLP+vePFpClj3?=
 =?us-ascii?Q?lb3b9jGpM/+cOkJMKFdVdn/v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?szPcG125X/CUPFm8M26UN0hBxsG2cfFLsROpBtjvDY1+Y+mWRWDNOBRh5+MI?=
 =?us-ascii?Q?45l2VdwQ05ADoqf8XoyMdF2umk7PGTPd6Yr87jRVWgyCiGvm1Iz+J+dONIkM?=
 =?us-ascii?Q?xNjv7gHD6yDnSdmywfLL8dpcRQqt+PiIDdQbtiPz+wDmoAXXLKML7ngALhdQ?=
 =?us-ascii?Q?UgcUe9wVyMDj7DKfbTL1C9oVljl7aae+mj1fSMwXJUqyOcwaEpjf7fjKG8uu?=
 =?us-ascii?Q?p3+TDRCxKYHXJCv7p/RGtmdsKatW0EXaPK79OMA4O2KGHYHw+tWP0SW9zj/a?=
 =?us-ascii?Q?GMcaQ/cGcNqzBdHpu1DjnUrV5nVUNcCHTpytG38KzA2TiZYs7s9KTZNC0oME?=
 =?us-ascii?Q?VrYv0T93K7SX5NXHPJqx3nHSnJwCBoVTrpc+Yw5N9ruyzAJmeez+8nhTnqF7?=
 =?us-ascii?Q?SOKDrn950llkPTMbYwfqCImOhyDRzRnhzHGSuBYKC/KfldmfiPw9UmbeZOZ1?=
 =?us-ascii?Q?/6VQ/M6JfX8vKYKh65wPxoPthqMni8bT2r2/CLWJsTGYZMSTiY+FSmHgEEEA?=
 =?us-ascii?Q?uA5lb+Itv4IUtqPYCyfIvXzPy9pPx0EAFs19PVYU1OKr5650LnCqdvi9rk3P?=
 =?us-ascii?Q?Z7zH1tsmVXVF+NjJGrbdH1aZnFejjBC8zkIU4iERI3bSTqpAQL0Dl03lYqZ0?=
 =?us-ascii?Q?2qU+ZZtjUMnuaczjFyGqzDc+Um5gH7lgiqDQI7wKRw9IIuAJjYenGadJcV6Z?=
 =?us-ascii?Q?XJQ4A1gUQtRhTxSVl8XwiIOpFYPRkMCDIC5Y24rX5QRJtl4xWL+BkAwjQwWi?=
 =?us-ascii?Q?h0SJnuh7AxKSKQkTqPF/p3OB+zg7Xyu6E6lzz4M68o4RweXuzuxzAmOp48/4?=
 =?us-ascii?Q?kA4yoMvPdEYzYzWELij5HsxgqEjHwXTjVsuVe2ZEPz761Mokxo/Tfduc37gJ?=
 =?us-ascii?Q?O8vIlKiHKrfThjflylT6xes4WHAQQf6E7hiAJHYtSgey3pNl/kMtczKK9aZb?=
 =?us-ascii?Q?sDXgUhgfUmFiRAVYNVOjxRt8y28CyFBMEJdocDONlJ/abXFem3QBHJ1ArUbX?=
 =?us-ascii?Q?4vV2alxGCEm+uS154nClTLnjXUCtENDhf5riGKGspf4ZPB7My1ZgThaKRdqN?=
 =?us-ascii?Q?3akPqtF4HHkifLdGXLyk6LRgT/vzVoG+7EEU7tiO2L85CCb5v/niV7+pjP90?=
 =?us-ascii?Q?DyZ9awYYJj1an5Vzn9z0H1xjttLSebeVP8erQdR8YTeyUbPMkmkhCZ2Dn/7C?=
 =?us-ascii?Q?487jRC8wQ9sAI1b3Aq5lTsA//rv3YNxTC68MZcjp8nSN1iiIsiK8Mbuz6Ii2?=
 =?us-ascii?Q?DBjBmaQvHwRZn0hJEGAtLUUSq8hBUlJWGBSPLkINb2x5j2cPX33OWk1Nx3TC?=
 =?us-ascii?Q?QwJ7BWN1ZzdM6Tdz0YnitbtaYYBzXNiSTqF3glt4V5UxQ9rX2hEdLsrVhLeg?=
 =?us-ascii?Q?JXPeq1PRyQc//I/Zkhk9c1V0uMz1FqLnAW/AyMak0ooARp91+7UtSJ/sO30R?=
 =?us-ascii?Q?7zxkHrADBescDUXEFlaZ7YnOWGg1vXztfgw0L3JxXEVauKFpZgwnf1O1IWh+?=
 =?us-ascii?Q?AFNQuAEprclrn3QKzqKOz0fTz2Y2HnWY52W4QPKMCYOM4Bww5SkASxeVjFxQ?=
 =?us-ascii?Q?bjhTTZ/WH0XVyECKqbzaKZxgvyUrw9rDno0u3uzjqC6GbfmF6mdRR8OsWEbs?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 222275ad-a9d1-438e-a8dd-08dd75e9c587
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 15:35:05.9565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOx3QEMg13A4AFBmY7UHEPR4QMpqX+2XNyPPEMqZLUSootUWmvIBf5xfLGF7MwXWDiiEv8qJardyswx3zOO4uKmzwFAG3/v3clfs3Mwmkz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6480
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

On Mon, Apr 07, 2025 at 04:28:57PM +0100, Bruce Richardson wrote:
> For SVE, as for AVX2 and AVX-512, support building files for these ISAs
> from the top-level drivers/meson.build file, rather than having each
> driver re-implement it.
> 
> This removes the remaining build task for drivers in DPDK which is
> being done by a driver itself, rather than in the generic drivers'
> build rules.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/meson.build          | 27 +++++++++++++++++++++++++++
>  drivers/net/hns3/meson.build | 22 +---------------------
>  2 files changed, 28 insertions(+), 21 deletions(-)
> 
As noted in my email in the other thread [1], this code has not been
tested, and is being sent out here as a start point to hopefully enable
someone more familiar with SVE to improve on it as-necessary. This support
of SVE in hns3 driver is the last remaining instance of a driver doing a
separate build of source code itself. All other drivers now simply pass all
code files back to the top level meson.build file to have them built
appropriately there.

/Bruce

[1] https://inbox.dpdk.org/dev/Z_Pvxr5ozfjXI692@bricha3-mobl1.ger.corp.intel.com/T/#m6614ca2fdef698e0448311f7255bf3be2438f101
