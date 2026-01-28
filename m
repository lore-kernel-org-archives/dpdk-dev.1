Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBE4D25B47
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 11:38:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D78EF40274;
	Wed, 28 Jan 2026 12:38:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id C008D400D7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 12:38:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769600284; x=1801136284;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=P/1lQMY8SOrENtqPo6/ym0OeRB967dmPFtKNGS4yI3k=;
 b=aXrhkBddXLNh4vSfzO3nyWoDJSyLEDbQu9alrVveq3DqdGhoA88Aa6Se
 F20UAy8UnvgF06iXaHsaQ6hbzGfbpX6DN97Szo4R42oHpdQcY5HK2ErcV
 8rYjfCnC2ugkHm7tiqZvsZHa8HTqjF6VN0DBrkEc4q6UyjGMntAlLkGc6
 /zBGB9+AIDdWjm/TPJ9DXcG2Tk8bCKsQc0VUNfBrwwAsHP3+YHfNeo+JJ
 M5cFaimb3jtVZyRnS3iLdbh+zDeYTxhytGcQUCrlXEqTrqgNjaQXtvK9a
 WXoM83lG9U2Og+JkFA6ZnjWVbBrZSynhqcU+T4RyJnA/XcXOL409ZCP5B Q==;
X-CSE-ConnectionGUID: Orxqv2NETfuJ/ThSGTDAGw==
X-CSE-MsgGUID: KUKGCglQSwWuKWydwK8Tlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="88228167"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="88228167"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 03:38:02 -0800
X-CSE-ConnectionGUID: nIaNwVQqTiS07Xhmn9yrXg==
X-CSE-MsgGUID: Izd23awATlSHgr3iOXovUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="245853922"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 03:38:02 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 03:38:01 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 03:38:01 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 03:38:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NA2nDwvIcb/Exhb+paq2CtUhGsME31E0GUWSdcbpzRu+VVKbC9i2CqKD65Ii4hBtxpMBHfV5JagvwEi9EWpHVSWrZX5X0qtyUU1SEC2WohcGCM13OBaTYHpyCGUW2kJxeRZUImMlLtaTqHb1+tB+xVMPop4gSvh/d7uFGly/VrUIxIqltdAlfQLLMniO4V2wZrSfcKnBEDqKV8YdUOFU/VPX2P3zC8cHmkCda0vc4GeV74yF6zrZsNhg1SOCmZtlP3H66PqGwxQ1S4y+kxFxO36xXaCZq6C+xzgu9qPryF2BHKcWF3j56/UNLhZCV7sSvBLw0ETFK9RWfZo2ds61Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yroDgRHR7LDGq4hgbBu7M5PyN21xB0CnurvL/i9xGok=;
 b=aODtKgBuDNt/qtftaXCjw1QNd0O6PPZzLNP405hqMf0l48WmbyeJnV/PWZoR+95RsLPPTMYOcW6kNAH3I6I3YJ4g4ZL6QcB4HC9tw19EMaV2TbCQnIEPghpgAGO3hzA/vWeEGiovPsqVBRgY+cuaUdPghudomncOcZoZZG6p+N1bLNgP6fPTmV0kCPER57D2CeMCR3ikvm1H2RNN6ZmFhNO1Qk2GYfhNUrnz+t+hWYcFkHDc434A1p+eZT9Y+22JvgJVJFnnmdW5R2MNvh+Io1hr719qEAfjqMyBhbO06sCFzcO5BJ9tKUFFMl5MqYpHBbjKCEA3FQzk47wMnyxR6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SA1PR11MB5873.namprd11.prod.outlook.com (2603:10b6:806:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 28 Jan
 2026 11:37:58 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 11:37:58 +0000
Date: Wed, 28 Jan 2026 11:37:53 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kevin Traynor <ktraynor@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] build: bump meson version to remove warnings
Message-ID: <aXn1EbSpDuTIAZ59@bricha3-mobl1.ger.corp.intel.com>
References: <20251205121301.3443561-1-bruce.richardson@intel.com>
 <aTLP4TBHLtqm0kpR@bricha3-mobl1.ger.corp.intel.com>
 <8c80d03b-cd24-4b84-b5cd-22fb34ea7d36@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8c80d03b-cd24-4b84-b5cd-22fb34ea7d36@redhat.com>
X-ClientProxiedBy: DUZPR01CA0174.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::23) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SA1PR11MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 23931e82-fae5-47a7-463e-08de5e61af83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xx6LOg/CgTCUKix/B1A8vAlCoCS+kJru+RGK+fyXaxCUQ2nHjlQzBj1Y6/AA?=
 =?us-ascii?Q?awO9ALim7gKf5bgVeeQ1MsvoNOH2qEhIc5Q+zKjuEmf1xT8qBFCSkoZZ8BEs?=
 =?us-ascii?Q?LE7AVQ3zV62AYKbSoB08/3NTe0KFZ2mv20Zb4m/rSz88N0Og0rvZu2DjNGQH?=
 =?us-ascii?Q?Pp5QAPT7/dKXysiJMCB/aXFBMp4vLLsz+QFdwbsP/iEXcugexpzD07cCJ/m8?=
 =?us-ascii?Q?bqHHQ7S4lj5Rkc6V3+tOxmNI00drmoVfAQYWRMeyshNdGEKan8RG2KwXL/XZ?=
 =?us-ascii?Q?HbBUdSGJukSKpOHATcXKty9FLtZEQID4L/1UVyPK8Xicgw4mz0EJ0hhePfot?=
 =?us-ascii?Q?IT8tzXozlN3ImwqdJ3e3n+afqduzbq9BaVBoYyHWk4kK96nj7GItaXjPApR3?=
 =?us-ascii?Q?UbiZZC5VBhTcLtAQ3GNO3EDHni3BkyKVwPKEvOGgDiXeAalo1zPgJDen0J5b?=
 =?us-ascii?Q?QkvfIvPr1ogQsCUHytNhlqnNyKugt0E9yMPiIo23xAw/h7unuFNEz8Tx19Oz?=
 =?us-ascii?Q?N+iOwTty+yHQlHnEFjqDa+U3I7I9W4klFyvlW8AlIRyIUj7Kh7rewiQk1EI/?=
 =?us-ascii?Q?J1LvjHh2KzOZYLfua+GVG2d+lDScipvfqVimAm45/6TVmd7opXa6rz9xlvvj?=
 =?us-ascii?Q?HxEqx5vHG6tf2NDWbmDKKJ9NAc8fOrfTjQgdKPIydTOmU5lHtzOE1HgFoiiO?=
 =?us-ascii?Q?gfU3zJT8tZRmEv6UoGA+rvYZZAMhIolpEzbbtFlJz8cgSSmjF+zsw7/CA1eP?=
 =?us-ascii?Q?zoJ6OHToHsXVUqZQy5wEQ4rZ4WgewvOKMsFIwQex6mNS4gzNdyPb/xZa6Mif?=
 =?us-ascii?Q?iPiMXGm0VNtlAvEMSJWN0szatn7teTHldPw4Z23SGhljTnHFt8KwJsbfRv53?=
 =?us-ascii?Q?24EMcMulL5Mb76ywQvQCFynOvqIALL30X3Trr0zGo9OUsI4RdGdArgz1Hc06?=
 =?us-ascii?Q?KG9zx6LfaHyuTS12lKX1qpUcMKm65uc/8IoqqonWjA6Aqdjkiqv+A5jL6su6?=
 =?us-ascii?Q?1sB7uExTOiia2h8LeWSasb7ZBAnxSXVwPU1IIlyF9asCKoii2LVXk5BzGdgX?=
 =?us-ascii?Q?fDHFvXCsrR1a7zTlZRZ/XxUs29vz9D6e+i8sU6NKX6TrbKrjVEJMZf7azSXZ?=
 =?us-ascii?Q?B3cbzrIjWKlJTf6KbhJiafoQr4u2fXYebjXw/ZVowOkIqIoJ81DP+aLdyAPz?=
 =?us-ascii?Q?kTNUmsq+mv6TvOOoYe1ksSPohP7ielnBXLYfQVgiIY1UpGhwfXRBZ67Uzdhv?=
 =?us-ascii?Q?z/jYMPtA/asI6hG2zChvvPot4oy2p5msT0qG5tpDXbvtb4GT52VD+Vn+PTtX?=
 =?us-ascii?Q?BfVaVGRe0Cd9LxGgvUtUqJcoj6B+uBVSxFBcwIQ8QIZ8zeVs6YK37HMdMkCb?=
 =?us-ascii?Q?mjgpm1+Fyc0vBRnnLPw+gWNXhXmOSW41A69K3cheGL/DsjX5iQ+PSKKHsD5g?=
 =?us-ascii?Q?52LxUK9HL7UzURsjuNGPKXIF2Jl0Sa7PGQ5KAT1WgitDdqjTi0v7PT3oVPEc?=
 =?us-ascii?Q?3X3S7V22Se40LninL8o9QJD92CiP/U8kPUrHxSH3Uvje7/aTh/mswkirrVP4?=
 =?us-ascii?Q?n/zThm2MDmxx9SO5ry0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YD21M1n/942jYoY6XAGgMy4i4OCP9f9mMVwR7oycsckA2q7jkFmCW730H8eI?=
 =?us-ascii?Q?JaFFs+guYecbg7DKTSuW7gO2C/zl1YrVYPU2xHqJNYqsFuwIm0dRVqrWmZP9?=
 =?us-ascii?Q?rLZaSyiOBr5K2ycOgjWBN4Ck9i+SRIIyNu+L+u60eN50J6/cgkZAKlVBMIjT?=
 =?us-ascii?Q?yw4q3GtmourmF4t5zfc7T488vzhzxUHdV2zav38Hd4ES26z5wht9lK+yRYj6?=
 =?us-ascii?Q?AARNTEN9C4h5+OiOWkQ9PS2gE1z7AUPGIAUaSivpdnDd4l2dD+BdeA1x6IbB?=
 =?us-ascii?Q?NSuwctsysXNAibbdxdpSkze13RCZjHvHp5c2m68tHen+BZxD2hPW1dUjjP8D?=
 =?us-ascii?Q?h56kA8zEHFuuSYpPm54CSXA8wZUbI5LbwcFtGum4UDga6lSPTNuk2UnKZ9+h?=
 =?us-ascii?Q?Br5pz/roXpH8vj8obTcw4YTmjKdDk3PHneuCZrGwQnjKp/wW/vASDGDqfFqe?=
 =?us-ascii?Q?A5na238bu7U9k5kIrA30De6u+CrLCgxYpuGkO+50gYXWoSuQg2YKc1prTi1z?=
 =?us-ascii?Q?faYHn325HpG5zRvPoZJV9tYjwQhkseMxP77Arg/kfe7Jk7XRAUymCN424tcI?=
 =?us-ascii?Q?FQu7AlOYea8wKmJBbH5PS5VeR1eNI85RasA9zWg7Zf4bDQnVCiH2XzLPVXDC?=
 =?us-ascii?Q?jrERECIVfcEVIxCYinDsZyhJ7zEV/5KI+8kBT8zVBlGpecyrhiREV8RHEWW7?=
 =?us-ascii?Q?XkzcD7E9bY6pPlFUqyFqVnl0QcjC8ptYRA8z6svQ1zuqflkB0/itG9+65B/v?=
 =?us-ascii?Q?sC/9nH4KwTvM3tIkmJz37rA78UMO2d1WgDGNSrhifszQOEVBleaVGFQ8f3MO?=
 =?us-ascii?Q?AryABiXT8FvboHNuWDStjnWrSeCgRBq9iwsLxzC3WJVasGOYQ34t3liml2o0?=
 =?us-ascii?Q?DvrRs2n2l4vEdEN50iNJjM31DUhZHTR7c3/pMa01hedCyEPPKEPZ7qkvr5FQ?=
 =?us-ascii?Q?1zHsVEQfcYaCNvWX5fYhRdF4uMVtsB16Td1v+5HuyZxgI2y3qeO851lyQ3Ia?=
 =?us-ascii?Q?NiZzEgXeBUheuBKXv72MsskO3i5m3Bu7tid6SZ3raUSMAcLR6N/SM9Krk568?=
 =?us-ascii?Q?jYEFKYRGIWilRAAMm1MIaRiZ1mVPTTZH+KXOqsCTLc2nH85RSSVpKn1UA49G?=
 =?us-ascii?Q?XYBbLKDYgRT8CNjea4t8fd6sQaukpE46raZHw45WmewCUBISxQI5NRqTzGtW?=
 =?us-ascii?Q?EOAAMM6i78SzRaSW7oHRy2WQ4ZBvSl5rdmjjkyICCUjg52WGLU2QqAQlN0aX?=
 =?us-ascii?Q?3WEGX3YK8pEBPCb2RLh3no/G3xEjJ4p4y2se46UN3dmfYudWU/cpxPSalAJ6?=
 =?us-ascii?Q?F6TziDOi/ALJbu+kg03dp6g87FfDPORok9B6C23f7jD1jgErfaPULBZTDlV5?=
 =?us-ascii?Q?Qs2agRltp7b1DsGNM1HgDY7ouEDzfT1o8dCsaozTwSmY9xJ++LCNp6oa59Pc?=
 =?us-ascii?Q?iHYNrWCXHSVtXV47merFVvpA+ytZOQeP6G+VKyo9A0Uc2kT3z3XyBoARYinf?=
 =?us-ascii?Q?PER6eyVA+MyQlr7u4BU8hXhlopUf86fG48h9tWD70bbHXY/v+iWk9xBXgme5?=
 =?us-ascii?Q?/ZYg/NilzESROaRdo4FRH/COKi1WkCA1PCkvuu1Tk5HxqGwE07sGN2KASTKv?=
 =?us-ascii?Q?S8/da10bDeFXF9HkFQ0PfGylSUh4eJhOjZ1HecDqIo00SzGuCpvdF7fIJZAs?=
 =?us-ascii?Q?yK1XR+pdFKrjQ39ZLLkwkZwXw975xQjNLG2ECaPxlmsnQD5qhK3tcwx0dpa+?=
 =?us-ascii?Q?tVUIKT/5nVWK9Y7EQdk7PgsXgBvcAQU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23931e82-fae5-47a7-463e-08de5e61af83
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:37:58.5195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Y6acXglWLlYfv2t6FwG5H0wWd0+qA3rb91SHSlUafsnFSU31n58qE0v5/x4DeSupetCe1zcsL5XRMCcSAjokVSsAmTv3iMT4I9Us1FWWVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5873
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

On Wed, Jan 28, 2026 at 11:19:16AM +0000, Kevin Traynor wrote:
> On 05/12/2025 12:28, Bruce Richardson wrote:
> > On Fri, Dec 05, 2025 at 12:13:01PM +0000, Bruce Richardson wrote:
> >> The build of DPDK now uses features from version 0.6 of meson, which is
> >> greater than the current minimum of 0.57.2. Although these features are
> >> non-critical, they do cause warnings to be emitted on build. Increase
> >> minimum meson version to 0.61 (== version in Ubuntu 22.04 LTS) to remove
> >> these warnings.
> >>
> >> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> >> ---
> >>  meson.build | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> > With this patch, and the previously submitted patchset for assigning test
> > cases to the various categories/suites, all warnings in the meson
> > configuration stage should now be gone.
> > 
> > In terms of the specific version, as noted above I chose the version of
> > meson present in Ubuntu 22.04 as a reasonable baseline. Both debian stable,
> > and debian old-stable have newer versions than that in them. For the RHEL
> > line, I'm not sure what the baseline is, but I believe that RHEL 8 shipped
> > originally with a meson version even older than 0.57, so moving to a later
> > one I hope doesn't matter. [I wasn't easily able to find out from Google
> > what the current meson version in RHEL 8/9/10 is]
> > 
> 
> fyi - RHEL-9 has 0.63.3, RHEL-10 has 1.4.1
> 
Perfect, thanks for confirming. So 0.61 min seems fine then for RHEL instances.

/Bruce
