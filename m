Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B57CA6007
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:01:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C19040E50;
	Thu,  8 Oct 2026 12:01:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 12BC84026D
 for <dev@dpdk.org>; Thu,  8 Oct 2026 12:01:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791453705; x=1822989705;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WZ4RRChhxiMWDOXAcQ424I1aRU2YZskRN5s7CDNx7MA=;
 b=fx6vR/cO6ZtqSZjDRw4ESGbIQfK99WYsTxQaYo9ue9fZekuqrmPTJT1r
 vWqHtAZuTm9km3okft4KDVIGjax3noLWRxscoWmhPuFHT9UlsVSBVmn4N
 GjxD5AIACcEb8WUtvaNEyvwhGwX41BJFXmLAtEPxo9EXxqBwtlVZFa7te
 klnOhilibTRn9NPY3ZvIEqox7K/R80zQ2FK7BbLIPEz3c6E2KATGpejCi
 hVPMRCyQL4VK7Z7yniRI+IlxrInodUs8NkrVhi1oqDByDavomVfpzBkOM
 rRBRxRNE9JdMb//4IbFHd6Wi9BYbWFcFe8R/ViLSHhMSQC3DV4FQMy/3z Q==;
X-CSE-ConnectionGUID: 3AFq6euVQOKCuOfmSGdIIg==
X-CSE-MsgGUID: QkqLXbayRF63Ro1P8Xn20A==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="239331"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="239331"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:01:44 -0700
X-CSE-ConnectionGUID: NOzQZU3TSpa99pA5PHrPdg==
X-CSE-MsgGUID: zPN8vIFNQcaE32DNf5tLYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="96293"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:01:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 03:01:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 03:01:43 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 03:01:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CN6vdM5bUJ77gU8RFqh2S9/u0/X/xrJM8U9d5GVmPBq4+V5J0qLCz3HmcAbSo8wDyTcjU+20jCOqPmrA9VrpCxKe0kjz+77smS0yo5lbJePoF5gJFB45omBH6Hfp9qcXUSkYexHayWL4Iu5dByDvcc7nwIbQD9c3Ig/3AW+c+y7VzpBCl7buyW/luzp2nDljVzkjsoyEvR+3pIRxa3tfMlv7Gj3Pwpkli9hIAtPc/K5eViQe7x1ByuDyWUWpqNNxpYh5hIdB2ITYcdrNeDTImRp0/tPSlB1sPtU1NOIoc82MYvCaLCH+Zyon/U8TmVXP2HynnouILzqz4Sow0FWU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIX0m70t6jvu0Ys/i4DrGhgDxtkEp5huJO+8CTh2mmY=;
 b=LJPhHLih4M/8BlP/NN+73992iMLJ30UNgZrFSoNzG9/WkIPDmcmKBePFeK/zMXbGPHY3+R+Ky3KM0Yw+yoicy1QvmJghaKHGQEafntcNcAKAarskY8M2isNn2GiaVtCZegR2Zpi038Om2txRT9UQ0qc/4EVum3ylwoP2ogAzWETiVu5H7qFa8jfAiJdGs+Bn98jvV5rWKVjC2jmN+RQrfWzT3UCvvBgl7YrVYFtSaNocvCBgRlnx4srEAPYLXJmQGySXMjVx7pjmzgAD5x4PQsavJHsL17Bp4pfi0RjbtDPQ9qUitRauWlMRt2YIBQx3b9LNTO4fANrLIvSR1WCGvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH3PR11MB8563.namprd11.prod.outlook.com (2603:10b6:610:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 10:01:42 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 10:01:42 +0000
Date: Thu, 8 Oct 2026 11:01:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 04/20] eal: promote rte_size_to_str to stable
Message-ID: <asdqAVLffaRZ83EV@bricha3-mobl1.ger.corp.intel.com>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
 <20261007214115.3092715-5-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007214115.3092715-5-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0030.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::35) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH3PR11MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d74ca32-5495-4225-4211-08df25232708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: s4Ni+eLQhikiMSyzd7BlwvASfFHNvolS8nVbyVWz0DS4ZFN4kOj8kYbnTU90elR8zOi0y6Kj06qO/R1maqwMhxVvnTIJV4L8H9Kfr8LrnGSERapAgpDm+CiB2YWHRI5D/H/Dh/e712qIgZtKbfOg4Ar9Fl0MsEFAAknH32mv5SSWxqUpYw5z2uwnNzrsfXL/sogb41gPCMPNEzHCZNDmpuT259ekmPOQ7i5NxUEiv1/75JPEkfYSQM2ecyRXazbjlaHVa1OVcPi9hXxi9EJ14yJhV0/r9sskl2GT25dbgpbMkBcndk6XYWh9hiWq26JctDNFFJcj9fp8FMPaMsl6yPoTt72VlNqgEcU1RniY0oUpNAGpGECXNpnsBJMmE3g9p65NsAxqYN8ak9VtYH10dm/Oi7Zuy3ksyGA/CXi4X0nA0QL9ONgTjMrLFHq5zuHwNNFR/rLmdB2OW5AOFmw8k7M4gYNLGCOqI/KzlPudzeOOihM/cbLrsz/TQsbaBcx/B/+SecdbjT2E+dM1UGX6bvMcwO1NykzbUUN0CGEfzIdY6EXy5whOLIfIHjTbxQYGwF3Ey0nSY+DreBKCxN6XiJY45vWW45qH6Aqc0mFMath6bQsBGW9el1p+mxPa6AaGVzT6SbEiB3wzXuU3WneSwV4yAPKmDbloZnae0ALabt4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/+C23u6LKekP+5F0FTFhbiZIWXbXy64g02DgSXPNvBoDWvsnxbZTC5/rEaex?=
 =?us-ascii?Q?4NmWLcWY79Ie55bcDK0q9hsKF5ht3zbs/IEiSbEPH0SaTfnbYIrVj+anri9A?=
 =?us-ascii?Q?RxxA3iXz8s0sPUIDuXq3tQk7jBrhCgpflSvOyFihGy1V5tiJjtHBhtD3T47a?=
 =?us-ascii?Q?UxgmcS6QX8jdiU56P0mWNDP0Tsf73Lcq0Yv0FnI0F3IM3hLlrl/RMHnfFySp?=
 =?us-ascii?Q?iFzjqatY7dDrXCv0Z5LX1cZqxsDbNO8NvWzTfgOhGGXF5OJkUXXaEcgG2/kf?=
 =?us-ascii?Q?IsWzvhZbyAdZc+i5O9i/b+tERuybFPylf1VdbRoWAKjFqog5yG5pAmCVbrPX?=
 =?us-ascii?Q?XwBrUcp+pYliTtMq+8CATnUrwgYihwX95mW9Iob/5oIkmHpxVeFkPM2DMcWV?=
 =?us-ascii?Q?SvDQZNZauuZr2pfZlOcca00xK6b+I27dcQOS3xf6bBFo5btIRz9ZOmf1VDNa?=
 =?us-ascii?Q?sjzfD8ejtJ3NLRJxb/rjrleC+QU05r6as53MRMxmaYkF93aAXlj5CMZqpbS+?=
 =?us-ascii?Q?57YkJhfkAq7EGsJZRAsd+waCAyDPhppJCY7sFNBtglsOA8UNu6au8rS6akxY?=
 =?us-ascii?Q?fmx8VuOA+Wrf4Crspr3QccL/XVH9+3AZ7A3Mw9T0E8dNBKiWT3M6Tjg/rfQk?=
 =?us-ascii?Q?oESUWzi6zeqYQdAD//bH1WBoXVMkr5BmZVFKTdXNVNfeAHefpPaerMLPjzlx?=
 =?us-ascii?Q?u82SRq+73oONSms2L0D3n8SB8ZFqURL042cw67jm1wujH063Ez2xk9TdJWEm?=
 =?us-ascii?Q?ftd7zDvgSh2ZTxfztshcsIpa24HG3VeQtWhugc0MeY31HZksTNzG3UGmAOmm?=
 =?us-ascii?Q?lL4zFkoYnioxXGb5rsRKyNaB74kqUNs4GRsbiHOTKkNEmi/wtZqUBockgx+v?=
 =?us-ascii?Q?RHu7g7gPw5VfPDkrfZXTKiQfx9IHMWrwCYHuBb3MTc1zVm3bUuFyFoHwZIHn?=
 =?us-ascii?Q?Cb2mHXGtaIo2GG+pDcEDVyhR3An0O4p+FJYJYB1PWaOPulFKGQ0pW8aLKdax?=
 =?us-ascii?Q?inrSUfQr9Kq6TLLW+QbOVyQ+WOJoN6ewWmqX6Y+4TejFgRryIfkdonivs4P0?=
 =?us-ascii?Q?KBI+PuZIkJ2/CrCKayc+RU5Kb1vmATWBJVOlyTXFmpnZBiX0g0WoVHT4abqK?=
 =?us-ascii?Q?6HpY7YCKdlIxJYIuRMEKFB/OdiU9RYyG/esMpUUrOmhWrGz1q3uHczaIswk2?=
 =?us-ascii?Q?hJSlCng95ZpI9/xVIMy06YvpDz6Wu3Pms7A09lz7bEIkKpavKFi1qHyi4bK0?=
 =?us-ascii?Q?PymSGY+xS8pBGcyqBtLj6gYGeJdg8Gfu8DDNwmdytPpmYKESc6+NuVOnYm4A?=
 =?us-ascii?Q?tGIOyjkavfx2ovOflNmhxuAIFUjTFHS9Va3x9WrZ4MoGQz3HDcHq64K2tqJw?=
 =?us-ascii?Q?ZiEed8765ZF1avs98DhQYHrEgpDRm44dWzwyUPqYRDILjpXFvGOj/lKW7FsJ?=
 =?us-ascii?Q?jFf7Z++pQGnyMm5wmOOBI0dh0AsDife4wL4AAHNumeT4aa9M2nhWBUlOmZAB?=
 =?us-ascii?Q?qp/uoh3mRZwqdV7Ab8PknuOFEdszI5db4U7I1oPDVHQQAAiaPXMPAyqFAWRj?=
 =?us-ascii?Q?0zrZn33dqwxBwqk/get0RKYIWpZS6mB12ZVm9C1DJN1GuU3laZOyMlzcsWGO?=
 =?us-ascii?Q?L19Gp51TeP0scyHxVXxTeGuvPKzcYzYe4mu9NIsY1c4196/Jxr7gEPtXL5jO?=
 =?us-ascii?Q?uMQynS13BXcY2ciHmgsGASxaPqBKMOlemiIWj2FFx/VUyRkyOuVcDSooIbBG?=
 =?us-ascii?Q?ov+bAh3HFyzzaiVgQK7GEH48grKn31g=3D?=
X-Exchange-RoutingPolicyChecked: xXJNMSUBhIlX5zYUyRR2cWFSPf6aaYCSaITs98uafeRLdhjXLrmix8aIxQ/LVlSIttvU88glP43ktlhxfK6MwTAU7xkdP9BT7712O9RwOKlQgLQE/WAzPuUCKItz71qzEuot1vo8rA583DYOT8ErQeP05hhnhKKdUjNulh1nTLkMj4JGktK1APmMz6B32ctOHwHWc5UavaVNfrsTOOwr5P2xWupMdj/hp+8HaX86x0vyixxhp6LLo9F1xuAHAGTnR5/BQOAz5XOM1gArdlJe8TWlDrouvE9o8dus5mSoq7kSsBu+2C29Nsc9xinVw5AMX4o8Nr4nOSvErvlqC19gOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d74ca32-5495-4225-4211-08df25232708
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:01:42.0089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBQ65V6hTtHlly0VL/ALy9n7+fJc4nCty0sWmXI7Kg8jkXMnG77I9URPmG0M+suJ89q2Jp0ZbwXGJMhmYnAMyUYYCa61BTbQBMceVpY/Dcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8563
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

On Wed, Oct 07, 2026 at 02:39:34PM -0700, Stephen Hemminger wrote:
> rte_size_to_str() was added in 25.07 and has not changed. Its
> counterpart rte_str_to_size() is already stable.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/eal/common/eal_common_string_fns.c | 2 +-
>  lib/eal/include/rte_common.h           | 4 ----
>  2 files changed, 1 insertion(+), 5 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
