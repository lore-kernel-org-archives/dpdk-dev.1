Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664B4FD3767
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 15:36:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BB184027F;
	Wed, 25 Feb 2026 16:36:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id A8C6B400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 16:36:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772033785; x=1803569785;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=sB+UhbSpvLFysjsjXdxVvZP2rdWI+5YDQ6YeIsFtW8g=;
 b=gSumB9YitDdb+vsElIUmfrU3iCNvHseEl717FXWORzIpR2LEKsWfTarZ
 esc3lR/J8+tlez2nlZ991Dq1XUKaWDqnybZ7pdm2c1apn6fQ6+x9lmS0H
 E7l1O0k9wjwxtvWwWHnyQkXvz5E0misS3w3jmT4S/xlJsauYS5A1BxWY9
 0CzZljd85xKHg7PE5IzmSJTLsJj9CPDarnHdTfFWp0J6KT26CBgxAk54A
 pQhUCV32b3wToMr2LpUNpfU6WKiCkRAh2XhQt6tfMAxb8tWDlvMvAmus8
 +gb7TYUj14k7vI+WBUIBaTqt2d9bWseAjCSuTeqhlKxVfx8Vr+x5x29kS Q==;
X-CSE-ConnectionGUID: w4vl1tc9TOKy1KFhE6H1Aw==
X-CSE-MsgGUID: BhM275BIQrqAyrFHu/s3JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="76944983"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="76944983"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 07:36:24 -0800
X-CSE-ConnectionGUID: hOITkLqaRNSw/x023GKU9Q==
X-CSE-MsgGUID: FkldZQndTo+WKHJ+5nBK0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="214551935"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 07:36:24 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 07:36:23 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 07:36:23 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 07:36:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYxgvTJhstpEwJs+0q82S0MkVeGSwaTDBFDB+1dEXMkyPY22oSkwq6t4ZrTgRzA4oRX7y51ja16UO5MyF3E5rQo23eTelEBhOZrXFx6NGGzDN5yhTAQi5ywOTdRhdU2kTpvec8+8p5nLsaEYmy7cAqd8EMk60S9So7CEipuVZmnKm8ZWcORWo6gbkxvYBqAcfTzBAUo2cXnaIoWwrJ7m4XNh6FMo60U1CRPb+6ORDQrQJH4D6B8WXhtfUvBzm45Nh3WFqbXVybJCxU3m/wLOx8gKFyw4mV+WDilUKR2jy50IruCw6DD7zWLKNX6TkTv/xeYsXiXlrD3PC5GxGkdRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkrNIpCghfb4E29EzTkoPGm3JHfVxkQ397DMUHBZa84=;
 b=TnjcX2bzye36SzY1E6W0Dhe242uhpyUS+tJi1wwIsX0kvWFkJqGlnfG8/UXn7o5KxZTcpiiKSIlk9jIQXzdD0zVfwWjenCGY1PxerukAChS3qbKSlg97mD+TlgTD5bwk9UiCG698kTmtNg3uI/xivzejadgfCH7XVtxuSTLpAyO4fApOJEYnIbyDxUt79SoSz82sBBZKS9SxPQYelJ/g4gFSQ7IwQe3qzc98oSd0eWzVtZdvNRk9EsC1+746HucjP38jyJv1IuPIeu469gi+wlCL2hNJUspss2c3t8GeFOMcApmdBDxld8KPVxWTkQPtGwMLfswJiAKzSXP99BorNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 15:36:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:36:20 +0000
Date: Wed, 25 Feb 2026 15:36:14 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>, <dev@dpdk.org>, 
 <aman.deep.singh@intel.com>
Subject: Re: [PATCH v3] doc: improve e1000 driver documentation
Message-ID: <aZ8W7mMJP1gW0PXu@bricha3-mobl1.ger.corp.intel.com>
References: <20260216195533.2030568-1-chaitanyababux.talluri@intel.com>
 <20260220211514.2616852-1-chaitanyababux.talluri@intel.com>
 <20260220091945.54af483c@phoenix.local>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260220091945.54af483c@phoenix.local>
X-ClientProxiedBy: DB8P191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::40) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4824:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cef1970-c9e3-4513-6cf7-08de74839f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: oLTmkTVgBz95lafBS73kkkhV2XPLNkfRIzZZF+Jn+msuM/y0rcZ6Qqk98v+Hr7nFFfcqThVdCk65ibSti0CA8MGXm1pYmbpTqzuoq+osY3H15Fjpemm36P8VGB/CzO811/gZ9Bt7ob+2+t8omK9PN7zStfhbKmcvwqCePh8TsdobUaJLNZ5RYIWslhKUxX0L/+p2+LuUfDI/IgXS3NsGh05S3eoh2p24JBfIGRzqHWGzIui11/L0Gw2tI7sleUM9aC60KUK4aXfwngNm34bjuDqJ3H6iXVRh+EjaqtavDPmhZLkluXY0X+h81yMmQvycH6tO1aDVdRgiQ0SsBgJVzqRd0Od2qTAMZtHJk0/5iE+nlF8qWT/x1W2BCr9aIykcsSZjX6Lb4ljPEW3kQV3C3jHDPESEVEo9FmSEhZmlmKA2Hi9Fy/dHnmQOvNViiqRWv9JJJofaqL/wNYoZjo6XiLbgP+x6a0HTG4ShT7o18pEybrm3Hs9LtUf8ndRomX3VvnHX7dp9J0fnfh5cOqe5zzR+luaUaspNu5P3RAa5kcUOR0WrZ05owjbEWuFA9TvEjw6aYdpgDlp7pz0qO5kMdglH3ZYtKdivD+D7SeCUZtucRz0xkuKeGawLdV6kgvhatbhCsgvu2dkfuHHQKlZyiCIEg9nOTVAgI1NcVkWrID7Egh2BBDarFJu96iYFjB3n4w+YHCkJb1JnApQYEMX3aIwd82GvOyB+KXb4ivy+z88=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXl1eUN2UTkzdkhOdmk5aU9TMC81Tk0xbzVzTEQxdDkybjJJZmFFVjhpOHl0?=
 =?utf-8?B?bXBhVjZwOWNkZDl5YnlNWWFJWHpFNU1Zdm9wKzZCelNMUTN4UEoxYmY1ckhM?=
 =?utf-8?B?Q1hqY2tzdm9yZkZLR2ZFWFViN1NibjYxcUxxa2ZLTm9ZUWQzVGQ1aThWYUVi?=
 =?utf-8?B?eXVWcVIzVUc1dEkzZlJPZldXWW5LVzRsWmFHYkJ5UnVsVEdDWGJ4aDJzNCt0?=
 =?utf-8?B?Q0xmRk9vUkdrY2RDY0Y2bWRrQmxOdE43a2E3L3VGYnN2bkg0Y1JjcmJMZ0dO?=
 =?utf-8?B?ZXZ1NUNOQzdHQkRoQXlwYUlWdTErNktZLzc0amhRcmdjKzl0NTZJWWIvQjFw?=
 =?utf-8?B?MXY3Z1Q2RHhKTEdPdlQ1bG1oWE0yZGhFZDZDWDF2L3R4UUduR3lYR2VQNkxE?=
 =?utf-8?B?eTVzcHRNUGRNaWF6RzFmSFlNT2Q5RTM0U2d2aEhHS2g4ak13VVkxMVZyREJB?=
 =?utf-8?B?eUtVTWFXRGxOdVdVRkFhTDZreWVvb3lrMDNobWVrVTNEVk40ZkRRRGx4S0Fy?=
 =?utf-8?B?anZhYnB1OVFyMXE3RHNTWndLa1NMTGk2SHdiVUJ5VzdvS3hSS29KVnZVaGZT?=
 =?utf-8?B?MnFDanI5eDBrQUpuN1VIcnF5eFNwRlA2TEIwUm4wOExtYlNQOStxK0VwL2ZL?=
 =?utf-8?B?TmF0N0k4QkJlNnozWWpRSHFsTEM0TjRMNjRjdkJCSGYvSjJ0MlJtRnlIMmRG?=
 =?utf-8?B?ODFpenY5V2hZV0lkQ0FodldIcm9xT0RtWDdWdnMrMXc3cGpYYzlyekQybzRR?=
 =?utf-8?B?b0FQeEJzS2JTQjRvNWFkV1JreVNKeHdUVHVJdU1OYnRya1JJaCtjRmIrS0Uw?=
 =?utf-8?B?OGcrZ0FBMHN6YUJpbUtyOEV4S3JuQldaRXkxVnBiR1JzczQxRVhOZDR1L3Vo?=
 =?utf-8?B?MTZ6bkRqZHdJOElQTFpIWU94NmhRWEZRLy9EQmd4ZEdjaGp6Sm8rMmppK1Zo?=
 =?utf-8?B?cHFBMUZCekl4N3NvR1I5MzNWeG5PTHBTblNTSGhGcWthd2RING9CazBMN3dQ?=
 =?utf-8?B?Z3ZZM2NvNFVBemxBTy9XaWlYbEJ4RWlGNEhUK1JOYnB3TVBnRlZhTFZHRGp0?=
 =?utf-8?B?R2M1cU5nZjB3Y0RCOHFNYUtIY0lETjhoOHZFTmFlRGdqV0RZU3E5MHVyMFBs?=
 =?utf-8?B?enJPNm5zelV1a2FDc1NvN3QrV1lFTWdkV0U4MkQ0RnZHUGgvRE9BbDBWRDF1?=
 =?utf-8?B?ZTRnYjhyYzUwVXp2OE1xZjhVY2daTTVYeXRRbmF3dW5Bdmt1UVMwRHpkdi9n?=
 =?utf-8?B?SVF1V2NSQWx1dUhraGZDZ0FZKzh3b2wzaGZjTmxmVmtCQmNvSVFrUG5nMUk2?=
 =?utf-8?B?VkhlcXd6OW5VTGlzY1l0S052eEsrQkJPUVFINWRIbmJFaEhCZXZXN3ZUSTBw?=
 =?utf-8?B?aGprSFNWYk1TUGlGVGJ2STZPUk1GMjZvL0NLRVdvZnpmNzRyVmhRZnVMT1pj?=
 =?utf-8?B?NGZMQW43dDhROThjNUlJbjV5WllyOW81TlFlUmk2aDVBVlcxQzFPalJLZUpC?=
 =?utf-8?B?SC9QMjY0VDlzSjF2NndlSGo4THNJNzNuNHpkTnZGazJ4SEJwSkMyWmZ1TEdT?=
 =?utf-8?B?ZWxWMmxHRTEzOHBzNUdjUThSdFlJODhCWmJnditTbDN0UFF1MENEM05MWmJj?=
 =?utf-8?B?R3JtUTMyNlV5Q0pHU3pMYU1OR2tzMVA2WW5xem1ocjVaUHMrQmFVSVJIYm1r?=
 =?utf-8?B?a05sczhFOVpxRmxBNTQ5K2U0NTBKTCtlNlFySmZoQlZlblgzaEdYcUFvVmlZ?=
 =?utf-8?B?STc5THZYNXdpZXBraE5wK0lnYXNwcmNCRERhK3F2RklBbk83ZDkzVWlBR01D?=
 =?utf-8?B?WWV2ZlpWL1p5Sy8wT0h4cmd1YTdqS3FiL3hoRjVhbmN1bGxPaG9teDEzUXBu?=
 =?utf-8?B?OHAvYVBRdnNTd0R6WElnT1ZzbUxLbkJ2bC9IWThkbmo5QzY2Nm5aMHlFQjBh?=
 =?utf-8?B?NVJqQ2N3ZHdiZ1pZaEY2dTl6aU1WaHpGSHFKVlVWeHhGaTMydHJ0MlFaeXZJ?=
 =?utf-8?B?VTltSTBnNG1EeU5xb0Z0TVp4dG1CZU1uV05ZbnJxdFNRQlczOEhOcWxTQk9a?=
 =?utf-8?B?dUVjeWZrUkRhQ0ROYmtVVWc5aE5DcVZSWmxVUmlBOWhzamxsM1Nhem1SRjJU?=
 =?utf-8?B?QVFaZ1RnbFRqQVZuKzRuUTRYdTl4bUUzQzNkbFY3bE1GV3ZlYlhGSENYZEh6?=
 =?utf-8?B?UmJMMWU5emxydHhicWhyTklRMitxalhTVUpyQXpoM2tReFh3d01IUzRJaGpv?=
 =?utf-8?B?bWpJaFR2RVVrRkZLL1k4ZzFPS25sTVlWUkVjb2Q3dzVveUdEM2kyaUhjdlZo?=
 =?utf-8?B?UmtralYzeFFjV3pUYWMxQUo0QlhXQ1R4TmxGWkdSQkZaRE1mK05PNlA1eXNH?=
 =?utf-8?Q?DL6i8zlS4/689KX8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cef1970-c9e3-4513-6cf7-08de74839f73
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:36:20.3970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBM49nRTV+IP1Rn1mCa3teONG6MCMEU839hKADQal5dqw5a3J2m+RLPRyT+o3hK7RyHZiYBRy0Jw+/neGbKegN/R+lO3gH2bbebZQcxo6Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
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

On Fri, Feb 20, 2026 at 09:19:45AM -0800, Stephen Hemminger wrote:
> On Fri, 20 Feb 2026 21:15:13 +0000
> Talluri Chaitanyababu <chaitanyababux.talluri@intel.com> wrote:
> 
> > Update e1000 driver docs to cover all Intel 1G devices,
> > including emulated e1000 and real hardware.
> > 
> > v3: Resolved apply patch failure.
> > 
> > Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> 
> Pointed AI review at this patch, and the overall e1000 driver documentation.
> 

I think the review is overly negative, but it does highlight some stuff
that should be fixed either in this patch or a different one.

> Here's my review of the patch against the existing documentation:
> 
> ---
> 
> **Patch:** `[PATCH v3] doc: improve e1000 driver documentation`
> **Author:** Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> 
> **Summary:** The patch prepends a new top-level section "E1000 Poll Mode Driver" with an "Overview" subsection to `e1000em.rst`, but there are several issues.
> 
> ---
> 
> **Structural / RST Issues**
> 
> The patch inserts a new top-level title ("E1000 Poll Mode Driver", underlined with `=`) before the existing top-level title ("Driver for VM Emulated Devices", also underlined with `=`). RST doesn't allow two sections at the same heading level in a document without one being nested under the other. This creates a document with two competing top-level headings, which is likely to confuse Sphinx and render incorrectly. The patch should either replace the existing title or restructure so "Driver for VM Emulated Devices" becomes a subsection beneath the new top-level heading.
> 

This needs to be fixed in this patch.

> **Content Accuracy**
> 
> The note in the new section states: *"The `igb` and `igc` PMDs are built from the same driver binary but are documented in separate sections for clarity."* This is misleading. `igb` is a Linux kernel driver, not a DPDK PMD, and `igc` similarly refers to a kernel driver (for I225/I226). DPDK's 1G PMD for real hardware uses the `e1000` driver. The note should be removed or corrected — as written it introduces inaccurate information.
> 

I disagree with this. I think the content here is correct so far as it
goes, but maybe we need to expand and clarify a little?

> **Scope vs. Commit Message**
> 
> The commit message says "Update e1000 driver docs to cover all Intel 1G devices, including emulated e1000 and real hardware," but the patch only adds 16 lines of overview text and doesn't actually document real hardware (PCI IDs, configuration, feature support, etc.). The commit message overclaims what the patch delivers.
> 
> **Content of the Overview**
> 
> The bullet point for `e1000e` lists an extensive range of adapters (82563/6/7, 82571/2/3/4/7/8/9, 82583, I217/I218/I219) but the existing file is entirely focused on emulated/VM devices. Mixing in details about `e1000e` physical hardware here, without corresponding documentation for those devices, leaves the overview incomplete and potentially confusing to readers.
> 

Yes, this needs to be fixed, but not necessarily in this patch.

> **Minor Style Issues**
> 
> The note uses a Unicode non-breaking hyphen (`‑`) in "PCI‑Express" rather than a regular hyphen or the conventional "PCIe" abbreviation. This can cause rendering or copy-paste issues and should use standard ASCII.
> 

Needs fixing.

> **Existing Document Issues (pre-patch)**
> 
> Since you asked for a documentation review of the file as well, a few pre-existing issues worth noting:
> 
> - The document is severely outdated — it references Fedora 14/18, QEMU 0.14.0/0.15.1, KVM setup instructions from around 2011–2012, and kernel version 2.6.25. These sections should either be updated or removed.
> - Line 60 has a broken code block: `tar xzf qemu-kvm-release.tar.gz cd qemu-kvm-release` — the `cd` command is on the same line as `tar`, missing a newline.
> - The hyperlinks on lines 53, 81, 95–99 use the old `http://` scheme and some point to domains that are likely stale (sourceforge KVM project, `qemu.weilnetz.de`).
> - Line 90: "The Qemu" should be "QEMU" (it's an acronym, always uppercase in DPDK docs).
> - Lines 113, 114, 120: em-dashes used as list bullets (`—`) are non-standard RST; they should use standard `*` bullets or proper RST definition lists.
> 
> ---

These issue do need to be fixed, but again, not necessarily in this patch.
It would be good after this patch is respun to have a follow-up patch or
patchset cleaning up the rest of the doc.

Marking patch as "changes requested" in patchwork, because of the things I
highlight above that need fixing.

/Bruce
