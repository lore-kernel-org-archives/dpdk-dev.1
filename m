Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12894C9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 10:41:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 609A042F83;
	Thu, 24 Sep 2026 12:41:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 25D59400D7;
 Thu, 24 Sep 2026 12:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790246500; x=1821782500;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4+OU2JlKE068JG4Bp/Ab/7jDbydwrL8OA3d5HQqYZVY=;
 b=dat4AZlZzlxXVTkRxsyTlIfyXdFXEo6fkBEtjNYZ2t7J2rLOhBoH0Sgl
 ms0C2BxNe/XDK8bfuCKGYrRUh7Na/XNoZjJXfXZBIn0QOpzJ+sYD1Q98p
 nT6oPewn9NhkVhjAYPgfQl3/Yy6wzQXBJ8skAPKfd37rocvs4wnuiKtPs
 p884wwaSCMEOZGJt1Cfzpkt7gJymsBcTtMViwTp38vxDW8SVVoxh4BdLW
 u25OrJvmfidubnePHFrO/umfNdqkSs9RaPy8TxBnpY3Wc1rPWZWw0gRzz
 XX5+Fapv+OJt2SfEheLVjYrDllbYic5wCjMhu8xrnmZh6PuwtcgOuhkc/ A==;
X-CSE-ConnectionGUID: UXQI3HPBQOieK9352oibJw==
X-CSE-MsgGUID: 7zc85wEOQ2G+Yff/z6Joeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101591580"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="101591580"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 03:41:39 -0700
X-CSE-ConnectionGUID: kVvRQt++QvmvBusFJB+eRg==
X-CSE-MsgGUID: N5amJPaJQCarQjyT7upzTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="272134452"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 03:41:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 03:41:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 03:41:38 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 03:41:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4yfVMoRtjnbz5HNY+FZ1K+vXEMZHA56t6uUncwGT3CWELwXmpJ149xa50SoqAdYo07H9hyVgqzZm8EDkBEW5MwyePOiO2x1PCf8yYKZw9vwYLyintUMZ+RQNA1r+iW0Ld9XZXP6enM9yN/wuS+W3r7VbdBZ7X1Yq4/sQ0br0gUWvBjC5mrXnb0Llf/23nmevIjq3eXD7hdMzuVRcSDBg1oTNBBMrubatwcvooZMXIU9m74oYzD8Klch0AMbSHzlNkyRZdVQ6pVtNS7/huBexY3V4kZ35BcKIHxozeEp0zmW6tRfdrxBMubmDicuBF+GcvVJEyBuVGkBtBBut1cfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HTkv5wmYUv04vwnxYWnW5HRKLtvmCKnJmClMqSCWEU=;
 b=cHanZ2mUvqzXF+G9U9KU74j3xNWl9/HYbICttORiLqWJGTNqcuLgwrLarUjra7m4TvTC+xrvtMXwUzEo8rVYVournhFzShmCiL7j4ogYghmSEI0uX/CGQ6SaqaiNAVjf2IxV7k51kfndITItqbV+NfSK4BJ/cE5meKaFF48uPZgrIqIdGHA1ahuNcVGd0WejRTnHvo8NQe7AJANyxly/s/7phpudm6vPxtVTz3PU4lOCS3kiS7Zgmmygn8MltbqG7Im484pFcaaFVGjjqGzP9FR6FqslKs8nne8KivKuGxRs/e4agSptBGhEsJp8L8v8B+LMU4OEz6vp9BKA9xsrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY1PR11MB8080.namprd11.prod.outlook.com (2603:10b6:a03:528::22)
 by IA1PR11MB6490.namprd11.prod.outlook.com (2603:10b6:208:3a6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 10:41:36 +0000
Received: from BY1PR11MB8080.namprd11.prod.outlook.com
 ([fe80::2753:b476:2b06:9c3b]) by BY1PR11MB8080.namprd11.prod.outlook.com
 ([fe80::2753:b476:2b06:9c3b%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 10:41:36 +0000
Date: Thu, 24 Sep 2026 11:41:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: Sandeep Penigalapati <sandeep.penigalapati@intel.com>, <dev@dpdk.org>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Piotr Kwapulinski
 <piotr.kwapulinski@intel.com>, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>, Carolyn Wyborny <carolyn.wyborny@intel.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH] net/ixgbe: fix spurious MACsec event on E610
Message-ID: <arT-Wkw8-4xciq0J@bricha3-mobl1.ger.corp.intel.com>
References: <20260923112519.10600-1-sandeep.penigalapati@intel.com>
 <c86e9c8e-7dc9-412f-a1ea-cbbeaead8bea@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c86e9c8e-7dc9-412f-a1ea-cbbeaead8bea@intel.com>
X-ClientProxiedBy: DUZPR01CA0349.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::14) To BY1PR11MB8080.namprd11.prod.outlook.com
 (2603:10b6:a03:528::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PR11MB8080:EE_|IA1PR11MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed270fa-a856-4bf6-19ea-08df1a28683c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: EHCOrDyaLCAwKb93+0Zhufsch6G6LmZxqbJg8jHYpvMr+35CzSWPMlJBW4kSVPsVucrBlKghBRYQRl47SPq/3Zbl4MIYOLJzoAlFivl/oWlcruc5uFZgYRv33YoH9nZmdf38eKhBKX9wY1NCVMon+/CZfVeXKckQq5yU3e27dOO9yJSnTNa3npbMw4PEz3BtowsQzdrSDenHrP7fIbWzXwPjxHf7LhueEQsnaSkuCyUb7QCnE0+5q25hzY//ZaH59PG/g8sJ2sFVd5rNu36058ueeGg5CCcBDu8qzLnbZDpZcVPJjjUHJtRQySvNkb0QFTJ4BfhzwW7M0DEg+7KPLRtqhKODrZDBtlq7/0/YH2siZTkWH7VH3TXsvD1dVXEPlsjUozdQUGXDJ1os65/5s/Ll0JUCuR/aNpy/50DLLuU2A15zD83BQ7wjIgzFO1jgycgMs4L+4BH9crBBMVdBfYOLOrcUbL7JO3vyB8uJdoQ9YEPx3MHeuOJkRJL3tsOzmpzvm8rHVQKq99rwlL7VUQUb8+p1VcB3bxfCgqBoLvssusM7sK0f9YQnByyuAOxf+0q/f0tCQ1BgcmQnx1DZkv4KH6YGCXnV2SvN8nChylQ2RLLDgbgYgcs/edNgpyvuHUgx4GKpQ0Y6mDOdQE4XkPfkIbXkX2MnNoXBjou5kvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR11MB8080.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2jwX6ZDJ4ruzU4HzDAcEJagw+7/GfYjn1u1Gtcnt22P5zQ33kciq/2xT0WGt?=
 =?us-ascii?Q?4SXOcZd5FUqUyPtZ9/M0RAr/xHjC/4Pa75JmCgAqJWU8K/frR2BSUCndgBRg?=
 =?us-ascii?Q?9CuV6LF/5wUd/vQtr20A8OCaDgkP9RWGtxo3/6AYHoiR+1ia97QPZTrjmag9?=
 =?us-ascii?Q?HQ9gghhCakWeqBghmeyu70uYXPFsDXfG6tMfHcZBVhLkUCDYJBeJQCozvRvY?=
 =?us-ascii?Q?EX3nEcCdyarmi/r1jW5bXPRlgRbm1TcutS8DAtsGPyYEk9qZegbWHcmJ+QRx?=
 =?us-ascii?Q?zmXeHjR6AUlGwTwYi02C2CEneY9sZvVGMCgXu9xayXb2REKZpq30papF5MTZ?=
 =?us-ascii?Q?MpZSGvAy1tZp4KmYRhsUWpolPeZ7O3Yp/EMwVuPfBaFJu2kxn9gU+0TOSG61?=
 =?us-ascii?Q?lh2y34EhmuTzJmv3afJRmNUOU+H6u0gJ8O2dDCbe/dO/7spWnKNW6NH8ocXC?=
 =?us-ascii?Q?q7X9r8KYBzDuLpSaSLtVhIWvk18+O5QG2pnXQwm92VyngeVyv0ux40rdmv8b?=
 =?us-ascii?Q?WHaDsEg25lf6LN7Ts4j3lPCoOgLqfQrSrEqk3na6NQgjBhr8wzFq5ix4H+9Q?=
 =?us-ascii?Q?+EcXvdjcQDQLH2DwuR+JrAp2s/sylyrQRPjQsnNN4NQuvS5+i/b3G7OaspYt?=
 =?us-ascii?Q?Au2U1cnDLXKYGI8l42nTcRXg8vJgBDkjcSAbH8yzoYCwXMEoq8HShRQ7f6EY?=
 =?us-ascii?Q?5URo+M82BKyV59d6sNp5NoaPmS22K/cqig9M7q0vK4bG9zcJDIMknqviFFVw?=
 =?us-ascii?Q?7s7IA+wSW7cPmKREyWhdifkjw3MljwnBFecMvX5GY3aZ9RkHf/iEZzosezoR?=
 =?us-ascii?Q?6fOh7c9lc4rdtbvkPFd0kOeH65eu+8opGYL3XXzlw/IZBR4ok/k+BWzCKjqO?=
 =?us-ascii?Q?zXPQTkWr5aDDyXmrzHIqnOGO+8ScJP5VECvUY/7qz2YUgJTiweFTITUa5pEP?=
 =?us-ascii?Q?OrqukDcJmGka/fPhvgLzrOBdF+ZPF0hVhdIC7S5GqOWKAZUBxPqmzRIGE6E2?=
 =?us-ascii?Q?uf5hFxQ6hZDb11PFpM66IacV1xRPWVvi7nPVGc4rpmz9K5stKdgHwSwJEVWi?=
 =?us-ascii?Q?blUBJIkVOZkA82K2ZuZjIuKLrC+6ogUQw9OERRuIc14QQLWT+JPbEnOkkpVk?=
 =?us-ascii?Q?PSJktTuNs7CtuNZ8UUiZc87mfSuQTMv4mdTA4y7+rqSUggUi8unZ/Qke8Qkv?=
 =?us-ascii?Q?6Myzeww9dDQOH8vbz1EYIL4v664HCdhCzyDcY9BZBlIPOKTdN9u3Wh3BZPDt?=
 =?us-ascii?Q?fQuJ/xIDpArYBlxhCeEkf1LD8KK8yx9Q3hzzUYar93TvKUiu7rYEt7hxjSdn?=
 =?us-ascii?Q?2m5vwJ3SBdIEEbl6J8lUDn/TSsS6qmgokh5FjsE8RifkGRNt8vvHjwJgwmpH?=
 =?us-ascii?Q?rensNIpSB3+32F1wrPgLbP8yX9Ao+GhqVk7puwN6HDJSoUZyD+0FxOw9OJ/2?=
 =?us-ascii?Q?c/c1maOefzek/FkgRYFXEVmOjnui/E/l8I7Tdpes+NptdaEOj8MIs96jFFAy?=
 =?us-ascii?Q?dnfZbZj/XlqHOGQTZ3CFPkGfOA6aNjjyWy1S+xaUTrOj2Z2qGa0vaIRne6CW?=
 =?us-ascii?Q?CAL4sqlElyLZQwlEAcMHeo7KoNpXV2gbbOU7/J9sXnDoOg+WKomBYdFvTwST?=
 =?us-ascii?Q?WqqRHJL9ESFkecheKfpxBQ22TjjCDsAMSNcXslbxAIbUIyJ/7oY1Yaf6hRd0?=
 =?us-ascii?Q?wdaL7MxNJGNIpEqu/Zf+9zUoHr6Zz+9CM27f0r4sgyvC+E56UWFxQwLv924Y?=
 =?us-ascii?Q?uq6KS7z8hbIskLKHYnWz94MQhVQWPxE=3D?=
X-Exchange-RoutingPolicyChecked: pqFubMTrbkOxQTJoHIxraPYqzw3A2hRchykjiqmtt6xPjTnVRdf1UxtQ9JWEdhUtVKSuuOPNjrf7sE8MaTZwxBEUhlVb9Z4ib3y3t9jcVsq0sxKUYqlv9GSp3JvHnfSD9/j2CbhaScL4oXX45GxAQw+kW1eGzbs47ByJkYiuj0hkr6e6vi4XPaKMrKN+kwd0bHM315AExxBHpK0T0uBu8rSGnDWLbaUfsmkedpw8EjVo7A2qKG+68DvTN+EUaMKnqJLs4R4t+nocjI/3xZJF0feJdb+BamaINmvhNZjAGFY/RrNkePvlaOJGNUffsD9eho+0wBtAu1LAq1/oFkKT8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed270fa-a856-4bf6-19ea-08df1a28683c
X-MS-Exchange-CrossTenant-AuthSource: BY1PR11MB8080.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 10:41:36.2959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+Ggr3CZUztY95bNI6GbbPeRd06M2uLYLbl7AmlsWXIV6rSVIdJCmmySDT3QZrRUqR1dBTiy88/PegdXJA7x3WWDISi2+AGNW93R5KAJQZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6490
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

On Thu, Sep 24, 2026 at 11:34:04AM +0200, Burakov, Anatoly wrote:
> On 9/23/2026 1:25 PM, Sandeep Penigalapati wrote:
> > On 82599 and X5xx, EICR bit 0x00200000 is the MACsec PN-threshold cause
> > (IXGBE_EICR_LINKSEC). On E610 the very same bit is redefined as the
> > asynchronous firmware event cause (IXGBE_EICR_FW_EVENT). The interrupt
> > handler decoded this bit unconditionally as LINKSEC and raised
> > RTE_ETH_EVENT_MACSEC.
> > 
> > As E610 does not support MACsec, every firmware event (for example a
> > link change) was reported to the application as a spurious MACsec event.
> > In addition, the firmware events posted on the Admin Command Interface
> > (ACI) receive queue were never drained, so the cause was not cleared.
> > 
> > Decode the bit per MAC type: on E610 treat it as a firmware event and
> > drain the ACI receive queue until empty; keep the MACsec handling for
> > the other MAC types. Link changes continue to be handled through the
> > existing IXGBE_EICR_LSC path.
> > 
> > Fixes: 316637762a5f ("net/ixgbe/base: enable E610 device")
> > Cc: stable@dpdk.org
> > Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> > ---
> 
> Reviewed-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Applied to dpdk-next-net-intel.

Thanks,
/Bruce
