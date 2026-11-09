Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC6606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cy/XezdE
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1DB940B9A;
	Mon,  9 Nov 2026 19:03:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTPS id E197E40270;
 Mon,  9 Nov 2026 19:03:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794247417; x=1825783417;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yLt6b2G22IHAnPNKqktDG80jZOZXR6YWlEhQzcUycx8=;
 b=Cy/XezdEBnSZHMBhtE4ECV+tV0UzA2VzAbbKipXymaC7M2WkKur2T8NX
 2ISnbPEtYqzvrB2e3MGOMeqbRnFbU113VqmfTMnLQML0uKFkbeFJ2PrjP
 w96eB/Y4dVRlKGrVM6kt8BwkKxOTgF45A7EUUYOIw7M5jU5D0NOBlhOi3
 aUrxpVn4wCMht56duDD0bp3E46mH1hkC3UFkSwkw/xVzd5HjpygZXSZjm
 TzvkLd6p2AolYkvP0abeFpCn/0ZHJzwtBvRj2bXcgOfxzflW3QFnXY/nq
 jJR5s9E5WkfklJKdHDxFeSI3gzmamxpaXcYTS8rteqPWJcYDOqCzzEBGL A==;
X-CSE-ConnectionGUID: WjbIKPVQTIul0SL4MxkLGg==
X-CSE-MsgGUID: 3IA80ol5TamWP9oMPT78hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3019401"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3019401"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 10:03:33 -0800
X-CSE-ConnectionGUID: BS9TxVi6S2iuBscC+ADOgg==
X-CSE-MsgGUID: +uBcqVbZR3GVKXln/JTYzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8357117"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 10:03:33 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 10:03:33 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 10:03:33 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 10:03:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1nq9yQcqntNspOq/MC2h6Z6C26MdVtbzr6RPDq0jb5t2pO+0j6YUWck82W1mYRgSn9HfDjgOi/ALCF4TXNKzqdYWJHvETxdx1cgR0xGFYCZBpuZSbqt9wX5FnWBshrYWgBSlSs4ZDafAo467fPxs2CdCwX44lP30CukpbWd6a3y/z8lGabYQtLG4LLghF2IGkHZw0ffmm3sNcp6NOhHN3dKNw9+L5ZGqVlbKH07kM4hDkjDnLqdeAPxPWXHqUshVkaAblqCUHDog0VKoafUbMv09sHAPUIb4LLC9UKIKBPyEREugfQrS38QfXK/s5QwKicMVbpEZWKairybP7Mnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRObKqX9LJWVsPtAF26KAi31sF/CnmEwj7dApLOrZ5k=;
 b=wCkRu2FIM6XCR70hJHE7bE3z7VDoycFza3lPBEjSaSPKFzDCOsWyPZVfIVV4amJJG6M7CLO58tDdrg23A0njJTdO7c2/pY492wf0qo4k2/LBtzOTIr0pcytL/JPLeYXX+qN0tLcBFTxYs6wKooFwIEhveTrTxcQJndTA5UDf7nUVT2s8jPfj3teQzv1Dp+kv4PWfAesxhBv9UGujwrYrB5a/l81+CZMMCXdPaEzCRDEOF2y8pm555oeuUJ10haUDXfkhpCHe2f8OdXpOz/e+uz2dixxZNnUCWKb5E72dDSbf5ICqXiPqTudIp+aB9xinv5Pp1gGBZjXmoEhjN6PXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH3PR11MB838679.namprd11.prod.outlook.com (2603:10b6:610:367::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 18:03:31 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 18:03:31 +0000
Date: Mon, 9 Nov 2026 18:03:26 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix ACL entry limit on devices with 8 ports
Message-ID: <avIK7iqm2W0hr2h9@bricha3-mobl1.ger.corp.intel.com>
References: <20261109153245.53360-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261109153245.53360-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0266.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::31) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH3PR11MB838679:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af81a7f-7760-4555-aeaf-08df3e8bc36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|261021121427099003|261022105027099003|261021123027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: F2IDlNSbBwFApzh+Z8thuqU/iXv5uLUwC9NWRcz8E/2szXlYRWq98tFCp3TIskb2RAzI7WtNNHvjEC+/rEPDIpDsSeytpC6e73tnNtDn7YpJ8QB408ZV8ZfBQp7pNIGaCd+S3cN6TTVgdvDXuvuSN2oLDu7CFb5ZkUhIv8IGm26m/YMPXjc5mGSo6JgoFOAi4tJscSx8u8ToaDo9Gzv/X62RgdKqPlI8IkZgsopbgejYvlg9oz6z1+pzuuRGETfAKHK08IecnumBYwt4tYivKlCBdP7StO5ZfYjvLfeE7EYZzjUBhpDwirK69rgVO//Xybs2g1Nk670pmtnHUNlNpOfg44nLEx4zMX3YH1fOESRrbptekl6eoKbeNQfxeCz8gXchyssdkB7jBszwuyn0i4znX8wtOlK0lzVpQM/pqDUDRbVQkRvMzNj8ywvnBKjTpMRjkwrpDZ2vsFRBPYbFQk/73m0MfRS0J0+f4vns2qLMB8eLwqt/MHfnmEc922LrZUEDPCZBsg4jYHcFB3HxQ+2dwNjeOvF9GnkmwhIovyFbA/1CBVDP9XlRCHenlyyUr82/2MZJ+x6yAWuaVuMuVrwtMgn8tE2lR6ussSxsboRQtsWB1sTFMAVOe095/JBWy1EzOIfMg856dUoxRx432khZ+ZQ5MsosIsb1qbsAL04=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ikT1W5TsroR8clI7Z2CvLBnctvZnxFa5zG8KL3uUKTd02h0cFnWEw7KaZwV9?=
 =?us-ascii?Q?LIk+Uf6lkJg+xp5baEAV/ZBuhhTbJtO55ex0m5VVzCFc0yK6S8JdFBxblBky?=
 =?us-ascii?Q?SRYPWA/lOqS6WaO7gNaWgAcKgFsufXqNTf+hgGdb0ijIeJ8gc01BrOZGAvpj?=
 =?us-ascii?Q?6bCOnqeH2jo/oajEPtBKrwgjnTIXzdpWxV8Bjl2FmV4Z2Whg+n6HHY94o/Ld?=
 =?us-ascii?Q?Ny7KudrBJ8yKfTUqZeFrONgXknw/wCgF8gx6lw8MnRPLRgpxBwU36Z2rLVLq?=
 =?us-ascii?Q?GYOsOqX69I/7f5/3pYJfR4/aW5gQqKF9snPTB3bE1FWxPCU4dW/vlTsqnou7?=
 =?us-ascii?Q?GHgPZqgDxQBqxr+AhJNXpRE+1nb6VXqB/dDb9l9yOmHHh/DWAOxF4kFmwWOQ?=
 =?us-ascii?Q?dWaC4eF4qQglp9PsVIwsmTTobfysyw2RhzlCZqDZ6gEK4ucMzCOW/ueQXBoA?=
 =?us-ascii?Q?kwyaaLgyBvORurEuNzM9fHHN+9eA74bFRx8KijnCHCEeS1yWk2mGm9db8BF0?=
 =?us-ascii?Q?5bYpEBTd4UNmIMOfbfl5dNZufI5c7s8exkEyLCwwqyDBfjTbNZlw16kff/C2?=
 =?us-ascii?Q?eS0jqo5xRFM790fM/Av14SuY3qOwzq1nrIMBfFCX2gs3JO5Kc6BpSGWbfaPe?=
 =?us-ascii?Q?tTxZrsR/xQJAvjCcHkxIx4u8Iyds7KjKGooNCFrMVx0MXFVOSLJMO4frUGWq?=
 =?us-ascii?Q?r9NRzC4sv2ghsjGND5SfheyhRXC3ZZg08cxK3uo/G2pD0pssDmNLCynRxKDQ?=
 =?us-ascii?Q?Meki24ihkjeQ5AQeW/SBkML0ZR2acAWLTve/X3+yFuQ3R3l3j2jnGxYGFRrL?=
 =?us-ascii?Q?B6TLvKt93LkzuraF4XySZfqStcrikeZdtkfNo6j0l+1piipM/j8Pc7+VjLNT?=
 =?us-ascii?Q?K0zFJpxgSGKJY8r9uoaC1Ys8w/cbMq5jVS1nDvMm1s+b5VJ0B38dnOcFvllx?=
 =?us-ascii?Q?qVJNJVRCnDJ+Bs4Tskr67dqNtamg1HcYe1zhauCe62q6tJ5fkSkeOHx0Fy+6?=
 =?us-ascii?Q?7k9zL8KysyczZH69QIEmRfO330YQvt7+kiVwJ/jT1NwXEicf/qwgpTWMpxfH?=
 =?us-ascii?Q?wVXykDWOxfbdg9SpwzsIT31m4jZYOrX2KCVn/I2Krk8ErJlETumPOwg3Ee8w?=
 =?us-ascii?Q?rAMblYJyILyn3Xl1fI3/gcdTywoPaMpCOqLYoLZSLaxvjmfMuyZ1GAI99V17?=
 =?us-ascii?Q?eQyEU/7Y9BzIebWiNd0gxdHL+2vCLwYh6dKmH7IQ/Gvza8dG3z4u9k0uFHox?=
 =?us-ascii?Q?nmX2hWGhuGKvLLIG0aNkTIBHyWiY1Z2xmdaL+v4fehuSRXl4ORngBAxSaXdf?=
 =?us-ascii?Q?V0Lm03ZsYula6bAt/cQ4217Vux1N2krGK5zxxZlhC8uxLRSaLnvh7h8+Wj36?=
 =?us-ascii?Q?zxqkBs3rXInmyS3nkKjs7bFR4n1nNoZ/fw7C69IzcnI75TrNXPAxLiCqSbw6?=
 =?us-ascii?Q?+OMAX32KXUStNum3d4ns0DIWbH9dgYUV56vBxeGexz2gzfj7c+WBfM79Lafg?=
 =?us-ascii?Q?HWY9LQ6QgaqloTsbGjLnDRdV2Jn+3PSyrJNQ2+ajrZg8WRat2kCsKCaASkg0?=
 =?us-ascii?Q?BcjLxHF3UgWzbHtys2W2MlSCC6+Zvu2rgGEwTERDAPkzkNCAd5J6KIuw9Pv8?=
 =?us-ascii?Q?p3j/+ZfQmShYfzf3vDGzzefynal0pD2wD3GcjsHIHvdgdkSKyB9qLkttpFMk?=
 =?us-ascii?Q?YIML8byr0fpgVnRT3R1IeUEZJdMnvy6MgI3J025alga//6JN/1HnEScZfGtC?=
 =?us-ascii?Q?iGLFigfiAA=3D=3D?=
X-Exchange-RoutingPolicyChecked: PwI+r/ytUAYxN5xWgI5fCTz56R8RANXLXXMEekBFQXbh42NRm+TZ59nLNC36TDjKTyh1c+P/eXw+SACUlYq162VtKUc2/sVyJosjNoVJroBjMBll379Z2yhelTL6tTMrgFVGlqPqGHC87XeXorbN/REymCOVutwtNO+PM7wPZ52rFtc2YxZ8o72sCYjeYx1b9Jb1hYHKoN71BwX2r2PHG28wq7vcv0Aufo9BDv2d7A4riPfbxE9dn9eBg+YJudFGp2X1gPC8mjtOnHnoeEouBLhXGlgq5dpl7uWaNMhsoX1vSOz2O9kY6AgB78K9kXE+p6iCL2HgBxUICJmoNDaKvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af81a7f-7760-4555-aeaf-08df3e8bc36f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:03:31.0863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMFfYL84GTxswDllkaPqaf0wzXzO0wQxWMxrJ2rpvGeWXxfvcZ94cJl87wMDvVZAobPCZ+fiGleCz69EiII9zPVgagrnUzIk2QvBtN/v1Nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB838679
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 03:32:45PM +0000, Ciara Loftus wrote:
> Currently, the ACL table depth is halved on devices with more than 4
> PFs, but the driver still assumes 256 entries are available. The base
> code reserves only 50% of the scenario for the NORMAL priority band,
> so on an 8-port device adding the 129th rule fails and the flow silently
> falls back to the switch engine.
> 
> Fix it by deriving the entry limit from the configured depth so the
> driver rejects rules beyond the NORMAL band with an explicit error.
> 
> Fixes: 17a8fc206178 ("net/ice: fix initialization with 8 ports")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/ice/ice_acl_filter.c | 9 ++++++---
>  drivers/net/intel/ice/ice_ethdev.h     | 1 +
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
