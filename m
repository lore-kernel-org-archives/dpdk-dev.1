Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3CDCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 08:03:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58CA740267;
	Mon, 18 Aug 2025 10:03:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id D9BCC4013F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 10:03:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755504187; x=1787040187;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0IRL6PCvFbwN7I+BbdJ7ZezqeRSDO37/t1mF5G5HOtE=;
 b=AwSycNQZZCNxHOqAwm4Exo7c8OXxAgn/jr5DbXAoYx7r1s1BMwxsDlQ4
 mt8W19NujGSuK5afxEqPpVTagymvXwcXTsDe7iKxRfU0hY5O2Q0pv7Fzo
 EhKRVNNjDt86vfQ9zp+9uqKq+s3VP5MDb15K5WzLtCSvP7igoy9pJEsIZ
 7NC5pyeAFxWsQ8JlpL+QxmfixnRTo04LRE/Rajjrowt4QO94AM7sQzWbj
 JrqMku4UnBrkren0uOkg2hIWqL/d2OM2J1LsQhMdyaIUIBaVaQEMwP4o3
 PUPKg+OhKIwiTPBtB/4MGH+PpuoG3VRKxSL1OgbO3GbyF731CiQVOEpJj g==;
X-CSE-ConnectionGUID: mVxgS0YSQZGMovCRTA9p9A==
X-CSE-MsgGUID: iD1Nk1jbSeGV5TU9VWSbow==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57437265"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="57437265"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 01:02:59 -0700
X-CSE-ConnectionGUID: kb4phu5uSNyH3SHHBZYp1w==
X-CSE-MsgGUID: BllXlpkaSCOUclJRjl9IaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="167013130"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 01:02:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:02:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 01:02:57 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.82)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:02:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2SNsuv0qRAVXVD7mw8m+B2e6mzrHdpIwUIB3hXSwK5XphqoSSiK62aFnh2kr3B2LGJfcliuyL5nvzohXS7cI+N8a2x1aooE3sYEpK0XPTeB0/NKC+k2Vu7UZQbWr9nIhsKfZJOEmw4X8AgC+rhm6BTc8c0H3aJxMeJPwLJLCIQVXQyNeMM17YKS7+UPUAl3kX+iKLQGpp/4aVBYnzYW6L+TtzH0w3cFs/MzzuOZRea2xIXbWmuhfzosyN7/I9N58r80B2Btpjyh4844xkcfRz9V5Aq3r8LZ/iJE/rbX0x+4zZrGaBXlfsFbDrLCmQPoC/tcuzPYvWJc+tN1JpBaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRfU/5w4Ra+4Jjbj3vUgHfyjS2tyLjn6gfSgYxiiBMA=;
 b=Q7fpeAgY4VxJf4fap8UUYblBbEhAKcEUlhNV7e4aXzt6fS7vVEdCfs8oGMKb3T5Fhai6pBCoubV8TVj0MEoVsjztycjd6YaaBt/82u79QWrDCWNfksjHD/VT5GO+ZFNl74k+fT42P+yCYdKn0Qm6JNien1280U6BXBb2LVLLD4AJKvwTAWAwTSxv9gNgpBBI5iTVnQ4fagxPyP7cNVPeBepxdrezAkkT7cyZRF+nx15UXzhGK+PEbH7cukvWdjKavcHM8rRIVjhJgJqEQEEyvK+rZVNpwEm5nGJzJXokLYchEZTrpwMHE2a7lXWBR4r0869W8GAGC8qpr89mcAD5yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 08:02:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 08:02:54 +0000
Date: Mon, 18 Aug 2025 09:02:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta
 <ashishg@marvell.com>, Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)"
 <humin29@huawei.com>, Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 4/6] test: replace unnecessary comma operators
Message-ID: <aKLeJ2xMi_RMCTLD@bricha3-mobl1.ger.corp.intel.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
 <20250814212901.88863-5-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814212901.88863-5-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0002.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4855:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca5ea93-216d-496c-cece-08ddde2da287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nEcvPs8CbdNMQuIEmagT3Pb3bZkAg44Pl/FTOQSiHkb3oTORY9yB/bW2k+ZV?=
 =?us-ascii?Q?7gXdXWTP/e5O8lHaaqy6vyqZVZjD2nlkpY0Hb4StbNgwbNIZpEUvBZ50jJFE?=
 =?us-ascii?Q?tGCGcf2qJ3altSr/Uho/mcgKapj5DL8QoqMPV3Bgzlm9cm+sZQgVWCyhnb77?=
 =?us-ascii?Q?zJehcLRdbdH7KWGHizupgwROgU9VZwJqVuWANdylLJ1EI0DcniyXEuuLZIqM?=
 =?us-ascii?Q?5HuBg4PwEqzS4oC3EFCuQ7OITMv4UUCyp/60b0JvaB1+g1F8Pt5Oc/cGZAYW?=
 =?us-ascii?Q?RjF6EW8t5Be7QC5feWwXyVJK5/eOAx0QaaSP8VKFL+Pmmnq48ua9wNpOL4iQ?=
 =?us-ascii?Q?Gkcs4g5ngKQiAUOQKMG0AEhAIpxemillDO6nQ/CU2et4Nypah54B55Aowk1o?=
 =?us-ascii?Q?sCaO68B6MLbD0HrO1kZ+gGdgL47o+OKNjlHsHs5dkhoOb2ojLqAf10KoRglD?=
 =?us-ascii?Q?0NaW/8yprspSDXUlRJE6qdXpa4xNWTudoopjPO/i3OAWi1Clo3Y8t9W2ft5l?=
 =?us-ascii?Q?lE++dKQDnMYsTKCr78AJ20BFoehR1HEAW51BvRkZr2A88YrtMMQPZaMQMWRA?=
 =?us-ascii?Q?cgbUZCUPgvfUUjMJkb6Gr8gRtbA0S8wVROI52LgAxVLr0XNlgxSRZGCl3/kO?=
 =?us-ascii?Q?I5bYiKyoI+6Fxpy+U6K9rp25eGDY78WvtzUk029KLRXXO41Dh8zLxuyx5YuX?=
 =?us-ascii?Q?CksyFj8vv7A/JT4JKW+lVcxZmcxF2pCs8UT44pGqhLdrgrV9OCcYIfSlw5x+?=
 =?us-ascii?Q?AsTDJWkEkmgO4QjoFPEh6U5Nu+6UQj9R71SUce0Yue7YlOaLZXQAIVr1bRSX?=
 =?us-ascii?Q?B7DMEButquDYZjhTCEBXvsc6n7MqWwkMX9nSP0LXDElItcbOA2duzBTV0+am?=
 =?us-ascii?Q?3IrNGQ4scH22HOOH9aVaCCsxplM400TWygHjSfJFGq4+3jsm9lllLKSxbXAX?=
 =?us-ascii?Q?V/h9ekxpl/HQRa4gAmvaGPDhuqVRcAwdlEcUf8iBOExy4FeIP8LDSP3zjpq4?=
 =?us-ascii?Q?65vegYAPV6Mk0kwSRg6F7Vd4ccGTs2k6zjyZ4noIYXHRcWjyLTGycETK9XDq?=
 =?us-ascii?Q?unm9ODuDIXWfdU6w7jfJjzswzKV/ggyCZINNGsEn9gCbaOqGKbOf2Iclvyl3?=
 =?us-ascii?Q?V4HzTKKahfIpt4EEdYWSP81k0urqqZZFWjmnEiOfAN162ld5nRKPoiMPabIR?=
 =?us-ascii?Q?0Spe5e7C55tM9pcrnUqOtc2a09mY/i+9TsSdBvnpXFUgmXojesPn4tAch3ZI?=
 =?us-ascii?Q?BKR1xRO5YJCh4gwzRA4ZisXMQ71cjRMvf61EmGuKI8RBchEhCM0jf/w7abKZ?=
 =?us-ascii?Q?+Ocbw8javdK2QuOtsCYUBtIVgppPYIW2zGEJzVl1sgUPQjCEHGuonEOnBe9O?=
 =?us-ascii?Q?BdFZnzs+CoGh4mU/+0vcUc6bAz3xaw97i1lTX5+3F1l6kIUtwxvEUF5YtFo7?=
 =?us-ascii?Q?3ukl4aDoDqk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?usimtLB6ZWqUErSGY6Ro0KMqInSn4FMKyJe32KYLTPJjZPDUUVxXquAZNGM7?=
 =?us-ascii?Q?j32ZgmqlcGLFDORPhK6QJXXz6gesZDwlSQjZ1rpj6ScMU/cvjIjY8rzY5jlS?=
 =?us-ascii?Q?9xNHr9N3VE5QPzwQirlcy7U/NjnLvbOsA6ICpBVhboLkj9QGxaACNmppkJ9U?=
 =?us-ascii?Q?U3e41GIi1gVW+u0Xgy2CSUk23gqWyhCorcW7rdfzGTrGSIrEo1RE4/XPO/YK?=
 =?us-ascii?Q?nrMIJgOZNMFu/t7WL9ThIQQxEOfwwF7EJOWKIqAG7DmBMepJA+AFtz6Mgtla?=
 =?us-ascii?Q?OBUPl/1CLI819Zwzrx6Oyhl/WRX9wemc67jkjd6YRAYGbsLoTwgCm8rO7zMW?=
 =?us-ascii?Q?yvgJoG7fYmY4yz6IHydQjZqSfgQMfbxr25GpFH3CctzqbFQj9h7L589NCYCO?=
 =?us-ascii?Q?+sy/S/j/ygTW/cKduLDKeGfXM3QyJy9zYktlUmmh2f7XC4rLgmmISXU2xskX?=
 =?us-ascii?Q?N0YzWwLf35Lf4IrsqVZw3MOFIT41AMwHx8umx5L2CVRCRHIV84/dNRwk/z1e?=
 =?us-ascii?Q?yCf50Y8VR30reLJVMpdZvcJC5/JL36zGqXMrY0NaA5rf+nAZedGdGHIQUbSf?=
 =?us-ascii?Q?nlMFtrOJrhwxXkhewRp77pMobZraZMm9MMu6F9MW5ZiqlqoWD8tXzDir0e11?=
 =?us-ascii?Q?UbQcHqLH7eG6/ZWYri+VLK97bCLbYt7a+r7rXWdAOC9rfpCOCDs2+xf80OAJ?=
 =?us-ascii?Q?sfWGnN89ecHEZvjcCYIl1KSys2AGekP90fbE03Uwxw/yXSN/PZZlKkEhLH1N?=
 =?us-ascii?Q?nnst4t3wVBBMTxU5CANDmBoq+/R/DePyh4PDwWpebFe8C1ffJ/v7R/O7yIQz?=
 =?us-ascii?Q?ssK0RrcqXcfs0XMyPvFAVpiANxJXFta4/TkaqCUpuwAbD8Wje96Xy0obNLtC?=
 =?us-ascii?Q?AYxQCrdj56zNWDm4S0LG892o0lTA8zBPyVC3bdyWta1yvDtc6FR8Sge2bpOh?=
 =?us-ascii?Q?bNptX2W7DKnUdtvEbIlXB90t9Vdq88nebQA3I+sU7pkC7VQ9hii9uCiArh+q?=
 =?us-ascii?Q?QT7vrD06yOaZ+KNFCtDBnBDSUuYWeicO3U6smx7tHNTBUN9+VdQP1smh2NT2?=
 =?us-ascii?Q?qBgPVgT3n5dMPuXw8WT7A8SwrsiwZWkMAVhY4PtOD9SfnDgEUya64u9e4P8n?=
 =?us-ascii?Q?2PX0rqOQrxxQDYlqxFKGQjuB1U69li4PDKI1IQLv1RWLx2l2j9svYuEu1XU/?=
 =?us-ascii?Q?UV9fE6eEVerBKpOuFsRLOgTWeI6fo1s03Rint1ng5uypcy9MCQz+vkuBlEc5?=
 =?us-ascii?Q?nw3pxO74HswCGd1+uYmu4zU9Z4Nzs4O7iwhwN8eHkVqg+4rUrAfHHxtuewx/?=
 =?us-ascii?Q?MfDFSavFGrwo53V1EaNBX8Q0ryMhvaZUbufLzLiAezeoI3qoJyhlQbXl4qar?=
 =?us-ascii?Q?go4bkih2xVpAlCRx/feh5ZOrbkyWBQkywgTCSKin+2ooZb4w4YdqY+4ktVXY?=
 =?us-ascii?Q?oo2EyCg4Y8sEQZRv9UvzU4fwYgmDFF93MNBYcy7LTDDjJSi/Dk9FWRhi7AzC?=
 =?us-ascii?Q?s1BqyYwzRYB+iafyjwXIXqcTGUP5nTqSSVhpq06PlkFfRRrZuL7e21SSvzrq?=
 =?us-ascii?Q?iD5JBWMxbznefVI98ZsCe2wxSlx+Do9qOYsiXu/jv4D4XthSHttq/slqMokI?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca5ea93-216d-496c-cece-08ddde2da287
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:02:54.0224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrjsL6611bZNLZtrMsxtiWA9PhEG3RiYJSzWAiHPSVOiRYg2EjnMuiO17w+TgtSvjXJfNza3eqdT1yeZmu34rrBJGhqj9L9Np5ZWyD69G+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
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

On Thu, Aug 14, 2025 at 02:28:50PM -0700, Stephen Hemminger wrote:
> Use of comma as statement separator is discouraged and
> reported as warning by clang with -Wcomma
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_compressdev.c          | 4 ++--
>  app/test/test_link_bonding_rssconf.c | 2 +-
>  app/test/test_thash.c                | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

One suggested improvement for the last update below.

> diff --git a/app/test/test_compressdev.c b/app/test/test_compressdev.c
> index c217ad6cda..dcea8e2f30 100644
> --- a/app/test/test_compressdev.c
> +++ b/app/test/test_compressdev.c
> @@ -273,7 +273,7 @@ testsuite_setup(void)
>  
>  	/* Initializes default values for compress/decompress xforms */
>  	ts_params->def_comp_xform->type = RTE_COMP_COMPRESS;
> -	ts_params->def_comp_xform->compress.algo = RTE_COMP_ALGO_DEFLATE,
> +	ts_params->def_comp_xform->compress.algo = RTE_COMP_ALGO_DEFLATE;
>  	ts_params->def_comp_xform->compress.deflate.huffman =
>  						RTE_COMP_HUFFMAN_DEFAULT;
>  	ts_params->def_comp_xform->compress.level = RTE_COMP_LEVEL_PMD_DEFAULT;
> @@ -281,7 +281,7 @@ testsuite_setup(void)
>  	ts_params->def_comp_xform->compress.window_size = DEFAULT_WINDOW_SIZE;
>  
>  	ts_params->def_decomp_xform->type = RTE_COMP_DECOMPRESS;
> -	ts_params->def_decomp_xform->decompress.algo = RTE_COMP_ALGO_DEFLATE,
> +	ts_params->def_decomp_xform->decompress.algo = RTE_COMP_ALGO_DEFLATE;
>  	ts_params->def_decomp_xform->decompress.chksum = RTE_COMP_CHECKSUM_NONE;
>  	ts_params->def_decomp_xform->decompress.window_size = DEFAULT_WINDOW_SIZE;
>  
> diff --git a/app/test/test_link_bonding_rssconf.c b/app/test/test_link_bonding_rssconf.c
> index 2cb689b1de..693b0ccd12 100644
> --- a/app/test/test_link_bonding_rssconf.c
> +++ b/app/test/test_link_bonding_rssconf.c
> @@ -384,7 +384,7 @@ test_propagate(void)
>  		}
>  
>  		memset(bond_rss_key, i, sizeof(bond_rss_key));
> -		bond_rss_conf.rss_hf = default_rss_hf,
> +		bond_rss_conf.rss_hf = default_rss_hf;
>  		bond_rss_conf.rss_key = bond_rss_key;
>  		bond_rss_conf.rss_key_len = 40;
>  
> diff --git a/app/test/test_thash.c b/app/test/test_thash.c
> index 33b0c6adac..398db71839 100644
> --- a/app/test/test_thash.c
> +++ b/app/test/test_thash.c
> @@ -910,7 +910,7 @@ test_adjust_tuple_mult_reta(void)
>  {
>  	uint32_t i, j, np, nt;
>  
> -	nt = 0, np = 0;
> +	nt = 0; np = 0;

Again, I think we should just assign to zero these where they are defined.

>  	for (i = 0; i < CHAR_BIT; i++) {
>  		for (j = 6; j <= RTE_THASH_RETA_SZ_MAX - i; j++) {
>  			np += (test_adjust_tuple_mb(j, i) == 0);
> -- 
> 2.47.2
> 
