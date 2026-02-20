Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5033FC55190
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:40:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 752E6402DE;
	Fri, 20 Feb 2026 11:40:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 336FA4027B
 for <dev@dpdk.org>; Fri, 20 Feb 2026 11:39:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771583999; x=1803119999;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Vp5I9GMXBeAJxs3FQytpO+VIDIQp0nDFVnlkODzlGAo=;
 b=Nt4qheTBXPRTjVRI8ixys7xA/kgCkwjoP05qRjzNqFzZ2pkN8wSs644y
 ZeXnqvbUx3ONRv5rHi9vf324qnmvukvtzKLk6b5lQAid6VzgnF9w1AaPA
 nlwNxPDv31cl8kLrN/M8HCdmIrExfu0fZJtavq6kF0D4RRNZeZSMfYyJh
 EIPGH47tC7XCPx9+0p+NRJK071/4Bz6s0FUS241azbLTDHnJtY8F/49Ez
 Uunss503sASCFaWIuKqpqg5mrfq6z9HbE3OvEsrI3sJXEcimhwagWlxm/
 S4Sv1QkGBAb6nbYwsOdBhHU2//+QFoiAgNt4FUtoYwjS8o0bH5GLixNyu w==;
X-CSE-ConnectionGUID: 6LupzlgRRTqXZ+K8nKlFbg==
X-CSE-MsgGUID: SJQg0Zy7SqSWeUZOxfrPGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83390977"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="83390977"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 02:39:58 -0800
X-CSE-ConnectionGUID: Bqh7WOHUR26NyQ/eyeigQg==
X-CSE-MsgGUID: r6BUZyuaSYKwbvHy06/LZg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 02:39:58 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 02:39:58 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 02:39:58 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 02:39:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRYH6RK+X6rgY0pVuT0MfgUNqTZghlPUnyLdW1HV0hDj6IXbNU1H0mSSkrcugbAjjPw+RnMvdZlu51CC90Bn4unvSKkd9fLVGJb6rpqT3nEdIOtI8GeO22yQ4NWAFnKmEGk/LK1vglY2ffQ19uL9Fqu3rFZwnWvppNCqJlSDqzwFfOseY2Sln31l1r2ZpGS5Q7r8jq1ZGI9vMu7xzp51pw34kk62GRATbsJPKB0LWCvdxJKtNMYmQfUOwfB1jqMrvqem/dnDmACD0ip/f6z2PUfjjRPMI+JuCINABQnmtpPP7ZKdqdzi/bJkxz5zfTPhRcbm1VB+saOmwLyi1gkk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZB7LvaMvIXoljW8CL6APjwka1D2ntxEaQpd4O3GjdA=;
 b=TwHbPnfK33Xcv3zDRAu+wzJpIEHextk7TNRBzWtFPOnxYLxQrXXvItd97wdS3+sqSNnxdS51+ikpL6P9bV46BfMSaLb5jAEg55MMmIjITXz24zrS34HKvT7xkoWZFZZUsDGNLcMK+yPNUFwHK+J8ZGePsJos136prtpmmcOkG4BDVMzAxsKV6MRe+lKvVvodXxvtlkCrbKpqag0IA2MUebjqmjjXSSwU5g//I3IBLQZlC41sHpq+3sUeEpHNCJkc0GgbJc5K9eiBUG1nBCru63gER8znsOHgy9B1yvsgOEKfL9euDtz6ONlR7D6ZmOIIXcvlLe3YsqbC0YAX9NKVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4976.namprd11.prod.outlook.com (2603:10b6:a03:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 10:39:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 10:39:55 +0000
Date: Fri, 20 Feb 2026 10:39:50 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Radu Nicolau <radu.nicolau@intel.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: Re: [PATCH v1 1/1] net/iavf: fix incorrect struct in status get
Message-ID: <aZg59ixd-hR-X9ZT@bricha3-mobl1.ger.corp.intel.com>
References: <c87355f75826ec90a506dc8d4548e3f6af2b7e93.1771581658.git.anatoly.burakov@intel.com>
 <d58e2c87-5341-406c-93e2-83d593ffed95@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d58e2c87-5341-406c-93e2-83d593ffed95@intel.com>
X-ClientProxiedBy: DUZP191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: 8faf4464-ac53-4b1f-94b0-08de706c631b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mP3EHefs+vTlrpivXalIlpHInrKBHC6agtaH+MOIhhVCL5iaxzFQx82eE7gh?=
 =?us-ascii?Q?ZEoyi0KRXmhXkOsftmimiMl02Gyo6+1eoDVA7YM7AmlVnTYbD4YVc5gurx7v?=
 =?us-ascii?Q?XH5VdOnXK6pwQaak715GYNZr/IA8IzUlvGZtMRbuSyU0d4uPfhS9CtQpq1/h?=
 =?us-ascii?Q?TYCWs5q9mChnS9ZugpwYNLSKCGklmrF39BRP0Wz1t7xBWfjUjPJm2YmHppzF?=
 =?us-ascii?Q?k0tLZ5uuzp2614WMHNbuG0iTtjL2Av3dbK4mnY7kD6Ln98mdhD+pGwyPI9I9?=
 =?us-ascii?Q?OCEwLoEy9dga2lDSGIEEqhWZQwn5J5umZbZQmERH3B+uE9DMlmoXAw1E1qab?=
 =?us-ascii?Q?utPjrMOTtpi90mk9T4T6tkC1en8VPurWa8tRk21f+dTJADp7TxIkr0Ct8Qwc?=
 =?us-ascii?Q?i2SGJ2qmPx9wk9ZHprCiDm1Br1f+N6aBx6ebFiQ1mqDt5XiHRfl2l9PdGkMU?=
 =?us-ascii?Q?ksXxxFqowUXUF7FQhwQa8awXGaCWYWgcR1wgOHxVEABGhT3123bnyg0+GsPW?=
 =?us-ascii?Q?IbLPGl5qV2Vy+CaEk52gLLYxsWl0rpZqO9CTgKKo3Uhqzx2iu40UmQvM1H/U?=
 =?us-ascii?Q?GUV6wJ5w1KQCZ39morKgt5Y7KTAXZNntn2HQStgqoj6dlS5G1zG7nCaSqOyX?=
 =?us-ascii?Q?tIC88aFrSfD/Eoe18BDwj52b6LaVurcketwmG4VACzwfZLy0cV/h4XMqPLj+?=
 =?us-ascii?Q?fmOyEzQ4wN4eUBqgU9nng/ZYHEKHtGwxBfv+buVL2R1p7Duwj8L51LXAJT1Y?=
 =?us-ascii?Q?YqsgX3KnprC4n+ChusWScRPCar6I60gQ4hZXyK/qMOYkZCyUoGAr+u1vm3Se?=
 =?us-ascii?Q?Y2OmHuYsWwcWt1PwZL6dat9cZTSlr493WRGeHGRk+AgsYXB0LX4ZBfFNiE/o?=
 =?us-ascii?Q?k+CVzKEH443AOPP7HZYYpzvCjC6L4skEIarVt+RXgeffEAVbfLqavkI/MvI+?=
 =?us-ascii?Q?Lhvk6kw10m6n73mVQEo+hKdc0tpyLvOuqNiU8hmymFTtY7xjDyCuOzWKL4Fo?=
 =?us-ascii?Q?N9gfB0SyplmPm1osswK88p1Yg5q0QlVhBTkx2ZFsXkIBs0si/s4PnN5BN0Wu?=
 =?us-ascii?Q?OoqbZdRSjw6tcCMJKprGJHz1hQpaihU3FmV4F8K1oxlrjAadrgzHt70pmPGi?=
 =?us-ascii?Q?myILVGj2YnmEz0HkgUfTIWNYWCuuh/se42a+mgXewC5Zap+FIhuOE2UuxPP2?=
 =?us-ascii?Q?0s2CKwNtQZCgKPl7jF4hS8vDYNbjyvaglt/tBnFOgyazO2aU/umOWdGt3ewN?=
 =?us-ascii?Q?O7jkd1MMCzRLghL26oefjxcBLNHNwCFmMDZl4JbIvv5kwpmotxsHo2zUvuic?=
 =?us-ascii?Q?MRiYKiOretcl7XBCyZdE6u/FAOIACMrh6VdJohR/yIJCFpHvq/lyhNLdYTSt?=
 =?us-ascii?Q?xMhZU0Ebxo8XruiSMH+P2MXdSjGvkvUwz14Rr3Yc1Ha/XHTA8+klWVvUKBvW?=
 =?us-ascii?Q?w1PgDCJIXnVHDPxb7ZgUezAFwDxMn+Rh+V2lveYnD/y4EtrdMUNjP8IV9n9i?=
 =?us-ascii?Q?Nc8ivL7OhlFbZEk3z0TfD7a+TxTjZQ8V9/D/X4noy/sfa69Oqj41Z+90jnU0?=
 =?us-ascii?Q?2BOtB8zoBEuaR6RJlP4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tXDYppOejQip+NE1a0u4yUMN0QLH3tGEB39nF9dRE/PYgURBTQLzTa4rXGQP?=
 =?us-ascii?Q?DbYRbDMPMxAM0llBdkv1lnPlKowtF7T3LNNtv61OoNs+JiHFt4H6rGusQpth?=
 =?us-ascii?Q?Mq9U/u8sRviIZmXTIXeu439hjE4HUyJo6cEe+w48a2yWhocqbxncwwOiC/Vr?=
 =?us-ascii?Q?zpQLRYvSPCGPDN2SoaDY9u2JqONkVV4dmaSGq0uqDjY+VKGRiWFah1LaUO/I?=
 =?us-ascii?Q?i8QIbedpIvtu2MUPnD0YHXl69oqrmXSnS5EAZAi5WUo11/Np9F/VhIosR+/p?=
 =?us-ascii?Q?vlpGNYIhnNAeop2dIYZRGtNOSzFlbEQGllh54TXNm2sC4PeFlK2LEvJpJ8ix?=
 =?us-ascii?Q?3AlDLuHsBnFSRXVdca7pm8fI4sLsExU4L2iTpO2nb9b/zUaN6rb8ksycBpoR?=
 =?us-ascii?Q?/g77HHrev5qOV3G4BlNRGhBX33JQeq6pliTdBDFeODavx61O2OJztTxzrBrW?=
 =?us-ascii?Q?3Pb0THchFyuYjhR9nhZy2aUQET4Xrg3N5O+WDciYh8KP+7swKGgrYxsg7fc8?=
 =?us-ascii?Q?uAfLuIsH2sLbVA6hI8i/37tJYZcOd+8ZGN96nszSUo7yFyxvYbT3hZpMbfO3?=
 =?us-ascii?Q?lEyYSsVwpdz4wZ0ItrtaIG3l/48cI+ikqxT+bkJWyGLhVRihkAvX2kd9eBM8?=
 =?us-ascii?Q?8AnREmvoMMOAqKMjq6asZHMC1aEKMzB0WRC+gB6r5DDD0aoMzMzECPmJufUB?=
 =?us-ascii?Q?KyzVjj3Midb42QXhJ5aLyCgSVk/PMTv190hGlVK9jO079kbpuvOhAp05bpUd?=
 =?us-ascii?Q?zxJKRmtaRXMWne+IPq0WXiLKqvNS6Z3d8klo099KVPXd2m5SdroPoAosJz3F?=
 =?us-ascii?Q?olppBjtyR93xFIOp3hjwMI3FZ7PRfMDRIXIdP4H5HJxcefOo5gFYJigaDQAw?=
 =?us-ascii?Q?ZJzozyNZ62XY0g7jhu3S1b0n4OdA5/hZ0z16wv0burF9Hc7rEHoQ2B9FGMMk?=
 =?us-ascii?Q?7OkdSaCgoUc8lhFZ1ukIVG8Son+BBafw0Akicaw3wSneNmlyhOoTZ5cz/ejv?=
 =?us-ascii?Q?pHL1nDv6nKPA/JCI4qSiIjoZ2g1fbHd/dDdj3l34e++RrcHTnLBKpukPXpA3?=
 =?us-ascii?Q?/UHNQawq8G6tN6qWo9bG/CQpLUzu1Tw3BJQJTmSY+NT/hVyWUjEm4DWRwDiu?=
 =?us-ascii?Q?KKFZRlVfxsWY5uTrbbgLw8HD8W5mwX4hy6dqxRi7PUSIKE5DEZ9X53dB8xcz?=
 =?us-ascii?Q?TItnR+uN6YPvR+g204xGn299UluFGraPxR8QalCe3tVOJ/3vjy5nSacL9NNc?=
 =?us-ascii?Q?FqRztXUGFPx/r6RTZfw+CH99eL6AxHAU+VCQJrJHq5f3F6jIKO2hWp/w4b2V?=
 =?us-ascii?Q?rkO9MUyFJlh2xdDltaJ863WigaQmMc72I/a7+faB4g4or8kAwLeoYNLEh+nz?=
 =?us-ascii?Q?G3CE+ilXpMvc4KZVgnnCxsZTye6NXBwv0fOjE2oIDghph9kLKxtiVKaPUwwz?=
 =?us-ascii?Q?EqfhGBVsYUdTo+8A62IndoTN/slU8GcmvKQpDUKNQdBdy9F/Bq4Gh3YXVUY8?=
 =?us-ascii?Q?Rv1pPWs+svOBS+rUswcYWGUi7Pejh+2G9lrN2EhqKUD8ENQ6pRrmZ0zvlK7A?=
 =?us-ascii?Q?ntXIOzqvD7hglroUFW9CaBFXrL59vC8bOs4Jh33Wubhpr7vvEYJ1P4IIzSxe?=
 =?us-ascii?Q?F09LVzbZSxNyk2VSrH2Pg108Ptu+va15SsYcMXZP5XJVjCaKGdax/IAJVyOU?=
 =?us-ascii?Q?eR3dfMu/VDn4hx6VHYkdcFSnLfSQTVaMtXyGcRlO8AyQZYFzdLscE2KZXhqN?=
 =?us-ascii?Q?GUSVaivJ9S10OLSDcBwrAERl1I788Zg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8faf4464-ac53-4b1f-94b0-08de706c631b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 10:39:55.5927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6a38kGMr/cfa8uf1W3Fidac+dMpRUUUGAro6msQa/GnAPKD/KjoHoqGXB6mLb+CCT8ldfPQwq0rXEKtpglGXd7xLrpIEwSfCeh4/bHZHr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4976
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

On Fri, Feb 20, 2026 at 10:14:55AM +0000, Radu Nicolau wrote:
>    On 20-Feb-26 10:01 AM, Anatoly Burakov wrote:
> 
> Current code for getting crypto status is using sizeof() of cap struct
> instead of status structure. This is not a big problem because cap struct
> is a lot bigger, but the code is misleading. Fix it to use the correct
> struct.
> 
> Fixes: 3940cd9b8cb3 ("net/iavf: fix device initialization without inline crypto"
> )
> Cc: [1]radu.nicolau@intel.com
> Cc: [2]stable@dpdk.org
> 
> Reported-by: Stephen Hemminger [3]<stephen@networkplumber.org>
> Signed-off-by: Anatoly Burakov [4]<anatoly.burakov@intel.com>
> ---
> 
>    Acked-by: Radu Nicolau <[5]radu.nicolau@intel.com>
> 
Applied to dpdk-next-net-intel.

Thanks,
/Bruce
