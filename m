Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19639C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 14:06:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1C5B40E3E;
	Thu, 15 May 2025 16:06:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id D2365402DC
 for <dev@dpdk.org>; Thu, 15 May 2025 16:06:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747317973; x=1778853973;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pmV3faHICH8hXQb3YkZEw444QVvcgnAee+yUs7mzF1Q=;
 b=CTVK6j2gvfKY+JT0tE+LGlGdy7SCow+Nmp+RWrvZu7gWAUUkLBsBzdoJ
 eDBMYhLFvhBexbKnIhAS+I8N72TGTsghOukKjAFZt2Ys5p9Lgi1ZfKNVD
 k3JZpPKe9L4TPC3JyfHC28tutHuXIXEVN/+9MeT49IsBD7Kne21j8KXK/
 3bAZNA4HZKB+W3BN8b52py++bWNphgIhxB5UJhMrh5ysS+ovZLZsLfMYP
 nx5cl1VJu+OO3QcbaxTj8OaT+Hgsos7AupbUgJlUY8ye5vIt+pWX+ClM2
 YP/FOiozS4r3wOnGJjLomDMSifAblLV3nwpCtqIJ3LTEryhG3e3gVlkmr Q==;
X-CSE-ConnectionGUID: 4SNmX31eS0W5ZeuNAcz1oQ==
X-CSE-MsgGUID: AWXXx4ONRQqtdyqj3UQFJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49152737"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="49152737"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 07:06:12 -0700
X-CSE-ConnectionGUID: KEkAnLgaTgyRcnIea+QWIg==
X-CSE-MsgGUID: m5vvBAGeQG2phpAtteuVRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="139377205"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 07:06:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 07:06:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 07:06:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 07:06:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd1MMy22MicM2zWnUlVCrUhCATwF69sNGdBxAMtyiYgUr5nVo9shfnqfDZjEBMFPRZPEVQ/oUcV4eS6FotkWRRaAD611JQWkkaB8IFgHJWPQnH/Ap+v+aTl0wylD3B8+rQTExRhdl0svWYhTsptKzEwg55z2B6nz7Fg1NGcnwCUay/w7LLf6Oz6AF+2h4zQ5kPSsQd2/pin7nVrUHeZQ/v5jyc7UiH7Dz5TQ90Cc/PfOESHFCJoP9MiGpcLFaMQiUF63UGghBZWD8ACaeXF5gre6GodaoE6kByZJOmvOf9cmTYCbwS1POi+pLBAqxNHwRAmwkRI6hjIXCiwqWVXASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ+CE0AE4dspud+vfbN7XsE1aEXe1Ies9OevsOVSopI=;
 b=odB7E4TdZlK2elgk8+XIuMcslq+VcZMonmEp5bN7h3bSqkWspK1Qc1i0wILprsowVPZHvBG+L50Phv7/5XkFNMAlGh7uAGKRPqOInxeeCmh3S04qWkjVSO8iWR3zhMpfniuiPP8TDp2LmolJN6ceTqGi9KmbfY3z3JVA6nl2q/Ijeo9jeeLfjOw75seR3U8DLmb5dXCOmmFmg86vlasKNAAcHJvqeK5jVczlf82FDPL9oK0HgdXZs7ZDBgd+7zErNbaFo5oE2C8gSzmZEGRvt+PpDKPHVKtpE0+2F2w/5CXj0mVStKo6pY2q4IJ46XUD6coIqha17oGyIiHR2XQpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPFE396822D5.namprd11.prod.outlook.com (2603:10b6:f:fc02::59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 14:05:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 14:05:25 +0000
Date: Thu, 15 May 2025 15:05:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jake Freeland <jfree@FreeBSD.org>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH] net/ice: Localize dynamic mbuf timestamp data
Message-ID: <aCX0oNP1gg1gGbmi@bricha3-mobl1.ger.corp.intel.com>
References: <20250506175025.1141664-1-jfree@FreeBSD.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250506175025.1141664-1-jfree@FreeBSD.org>
X-ClientProxiedBy: DUZPR01CA0198.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPFE396822D5:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbeb795-68a0-4681-0fe7-08dd93b98a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L2hx7gZ0hbk/5MEUpyF7kxfdefDVT77mlN44Uz2igyH9pg0LV1yeY3MJBoyK?=
 =?us-ascii?Q?0D0vBlStHABb6+AE8vZiHph/ldB4Q26h4ts0DUD4UFjnC632LH5C5uKz1747?=
 =?us-ascii?Q?xJIBULeqMB/8bmVy7DCgtMwlM8Q5/v7qX/WxQEbBd+Tv44Jife7TKSu9zSmJ?=
 =?us-ascii?Q?psQZlAcCdIstDQUBdgqxSNYIcd6MaPt6bd98NkEHJTD83K3O0GpNehj7676c?=
 =?us-ascii?Q?S60p5pbpw3meiqvH58zvEEZNECe9DiUKVk1dy0Bk1zqGDqMwt7xcP7L8eHmc?=
 =?us-ascii?Q?qDT+v3iAi2Dt6RgML9tiO92Cr4jvXJGUovmLy8JaW8EPNaS90A0HbbPS+/dz?=
 =?us-ascii?Q?6al31ywfqh5gGw1gC1lTuTRAxK6yq79cVRj/9lqt/DCTRKgNRC+JZVlBWTI6?=
 =?us-ascii?Q?WH0dLTZKX7y6L7BOkbp79kgBnWwJbB0QjNbPoqf0/unwZUHliXfZYH8IdlGJ?=
 =?us-ascii?Q?h7YGYJF+2DmaD0g6p8YSQfaMj2XTV5X8CwsKEEQljlpZos+a+dI0MB4vpmIS?=
 =?us-ascii?Q?VVehfXfW0uYKs+p36nb3EUTbRp6Ji8BVh6/9k9OwgAv1OQKKJvESdZaeiwOT?=
 =?us-ascii?Q?4vsfFZf6iFF6hj125u+AL331eCi2H59CoHzSRCuHCf0seww/g6zqhN3i1A5C?=
 =?us-ascii?Q?eMUe/0QR+rqNH1DrZlnSixgRsH5zJjqrlStyvQcuTw5nVIv1pVXkqL57W9NR?=
 =?us-ascii?Q?lf46DppFvV6xdNaX1ZiP2DnFaU00mE+ojH9ekLIjBoJ+CpirszvUOmjlFOl6?=
 =?us-ascii?Q?GJVYYAwI3P5eD9eVNwD6L4iw0lEVtL2oiLik5x+hxeBtz48sCdzrqcyBaZyM?=
 =?us-ascii?Q?zEGueazBKIIk7NjQ7IZcsGgfmBMv6p9jIFTHUMPgi9Xiv/nIXQnDJ6IV6LFF?=
 =?us-ascii?Q?E2tip3Qz1pniO7aVRlYDrxBVw/YyEDi9ABMHnuh+FfI4opqnkbVvLNZWS5nc?=
 =?us-ascii?Q?c0N6Ax/zOxFLGyjxjxjLlsfNsWFilyoYKig4SB+DD3l/AyGV1UhAZ5n+mC4S?=
 =?us-ascii?Q?hxMO20wLf0jAcpgI5SEs3XR1dSBcCQV3wCySwifGJO7XQnu/+U/eKujYXoVb?=
 =?us-ascii?Q?XRd5rPg2A+yfWv/UERDId7nOGvgkWGRja1SCaJ+PBZu69BXdWuOZ/XCBrm0C?=
 =?us-ascii?Q?aEnWeMH15TuiQhVHAvlAdY4YoYfzxUG8G4YQ/eWhygNmrT6YyNJE/URlUOkY?=
 =?us-ascii?Q?mzv3J8D17xcqxiCfQZsLRpY68erkNCtcH6S6VGlP9jBP+xQDy3rjMdHdPx+e?=
 =?us-ascii?Q?g5i6D+Gqqx3bMMqtyI20ABDDVAFVMvfIXgFZX6fvGexnvkc/tVSOCRPR6B66?=
 =?us-ascii?Q?f/G5K7r2JEIuy1dMiiige/0B9VpqEtUyJpJVQAWEDWGqBIqrOhhmfjQrLPne?=
 =?us-ascii?Q?eN7X5BVjsrpERyY+33k7swLgzdGK9I2f/jR8FZHD4em8NdtIJdV1bnHmhHU8?=
 =?us-ascii?Q?42jTADzskiY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4plfzF4+wxOYBl/7WDI/tw3I89bJbgcVs3BxYhV6RFA/7X6EexjEI6KKOcyr?=
 =?us-ascii?Q?98VTbtghWT7zCPgPZW1M9rUrF6UnPueYqLQetUorheptTtBWFckH8P+u2Hlf?=
 =?us-ascii?Q?83wb0J1aj5nLSpV0nV9qSUKxQQcXkR3WvOd9+6F7w2imhP1AyIqJ9UpiZSW5?=
 =?us-ascii?Q?AVlpCmpN/8flSdEuA5ZckC4CBWOM1l1KZLmKVdpwwy/rdCLKPkrgBGIG3KeG?=
 =?us-ascii?Q?Yz3TvM4lRyXpZu2N0wZMYS/cLVE3YHvAwyAXcf0vIUI8O2JmsPpV9g/x6db3?=
 =?us-ascii?Q?s93icRHCDOQvCKCITJgdbX3L/bIP8DA9zapMzGgmgjkiS4B8dp1rf//M4pIV?=
 =?us-ascii?Q?BMEMmC/0uKLUbjoqsFEW35h0oMKrD5GhhUXRGmay6BA7ULMAz4GVU/QH74vQ?=
 =?us-ascii?Q?MDCDEjJpr1YDhllM8LuhHVQaJb7fxeGgWsGoCigT5zIHlFjtIwWxM15iEpZH?=
 =?us-ascii?Q?seg4vmPkT9CmNcp6zu9B38JszvAocrz8VlUH7K5q0aHSUJIU5lSI19saF3kT?=
 =?us-ascii?Q?o3mA67F4VdCohdAWAujeAGYj2butDC/K/crqdXplRid3JnfcMFBVcnVGpL0O?=
 =?us-ascii?Q?Q4P1kYAJevYjTqRYfTUIjt7Y2yCaBuqSB6TlQdCENlASlfklcT/0b8cOXdgR?=
 =?us-ascii?Q?Vh3vDbJv8khRrLjGI+KcNn+RoHRz0TUDosZ0F90C2mn5jPbKlZROIJDt0Gpq?=
 =?us-ascii?Q?XJON/0Ir2PZkxQxP3AZyXehDP+r7JuPf/llfRFEyvRSXMMRugGmTrrL4+s6O?=
 =?us-ascii?Q?A43WFwww3j7fJ12fh+RcRh74QXVikD5zTghTVcZT7XkKk4y6QCD0psst3RoW?=
 =?us-ascii?Q?40EwiL/xJ3z6urKSMggNw3vt2JOxJ8d5Wk3M0LuMDCq/WlS56+S+NzgzYk2e?=
 =?us-ascii?Q?eS1jFwRqY7NCPxKvlF2+Nanf56w9SDni6VWcvYTyfYDOc5hxwG8yUuWSmWtz?=
 =?us-ascii?Q?2jXtEZpQ4qeltomh+DCwEI4SqthJE1wWA0ZCDPrIyTAwEsFoewH26bL06s9w?=
 =?us-ascii?Q?Tah4/aLmEcxfFfAFAX30O64EfJPR3Quro1wujoG4VK+Ja+Y/a2dcg30tFwZC?=
 =?us-ascii?Q?8fg/vFGmDlxc5/cpcbZABVAMpidfzy8dGQf3FToqNB/5DpuhQ2CCLjpai2V4?=
 =?us-ascii?Q?G57f27hUj0+LkMnKImRpHPkIbIdfSVn/BHlx2KcyuAP59KEiX28otJ/fJ96e?=
 =?us-ascii?Q?LCQ/Z6wZQ/vLpT41uftdsUiHQWCSpPg0ZbzidJMW5VAaDH1yiJODzN+enVaH?=
 =?us-ascii?Q?YbbNlHwMWu0NiWjHF+ZBwJjx0DGz3XIVX15l71eFwBneX+TU3zdn2i0ri/yU?=
 =?us-ascii?Q?tv+5cSKOKcsUR1oPY9Ng2HEoCLn7BL0vrDdfRursGlrCRIIVD1Yux5iATEhZ?=
 =?us-ascii?Q?YSQFan2idsUphzTjezCDrbW1NFjb3xFzZ4p4yKkiU4aKrTlU5JrQPiFgYErL?=
 =?us-ascii?Q?J2JB53w8+lsvcIw4YWV6WGW5IGVG3OW594IfG4ACVpfQewy23ngeP/8mAsA/?=
 =?us-ascii?Q?yUBhqFOyUlNUSNkMXwYn09uYc+aHgNXEs16wSKEjZJeBXqErLV2uQTQRL4JY?=
 =?us-ascii?Q?QR5vehS0g33kTNSY3diWF23eDkBmAu7BhO5pHnNlS5JYKlNd4OlNbncevHY/?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbeb795-68a0-4681-0fe7-08dd93b98a11
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 14:05:25.3132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPBipRqRzWlMNfiDV/EJybj20nxXMmUHqD7apSGo/EcR8Gsp2SGDnNl6fLxNZvFHNkFjo6bAP8PV1NqQsrpmc5FQJnmaqoIlpjNM1gi7z90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE396822D5
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

On Tue, May 06, 2025 at 12:50:24PM -0500, Jake Freeland wrote:
> The ice_timestamp_dynfield_offset and ice_timestamp_dynflag global
> variables are used to access the dynamic mbuf timestamp field when
> timestamp offloading is enabled.
> 
> Move these into the ice_rx_queue structure, located in shared
> rte_eth_dev_data, so they can be accessed by secondary processes.
> 
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 13 -------------
>  drivers/net/intel/ice/ice_rxtx.c   | 27 +++++++++++++--------------
>  drivers/net/intel/ice/ice_rxtx.h   |  6 ++----
>  3 files changed, 15 insertions(+), 31 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel
Thanks,

/Bruce

