Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0A0C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 09:11:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 435DE40264;
	Mon, 30 Jun 2025 11:11:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 645674025D;
 Mon, 30 Jun 2025 11:11:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751274710; x=1782810710;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=KzJSEHhyVKRTl38nesiMkSLKwItM6ejGlcpvs4iKv2E=;
 b=fhdYUBVtfJRmjeN73Ra0bxFCkSloaSbIXEYecah0frIr07Ryh0SIIA4X
 HC5zA0y/mqD/D9naOTLjoc7oyNghErrIOCodpqhbWPIIKxorwBXGcbTTn
 RE6IoSrcbEVpA2bct1fgPZpEOiPvqOl1oRn57SDKFx/NNz74udVJ3CZz7
 SAo7TjQu486TjqW5T4ExyfZ2CfK4WQ+omA6XDMe0wrIOggwGUBAJohCIb
 pkr80JoV0YStxAaLdN2WaK2+MglI75rWNqp5HJQJFG6l31ANcPEhgXM54
 5mqa07kbxmWc5DnGKCUODtBXmYvv8P+G4dOR91PsaD0TFYE12qsv86CUF A==;
X-CSE-ConnectionGUID: CD+LY/U0T9qnf/cDpwkADw==
X-CSE-MsgGUID: xFZD//Q3RzK9VqQLHabNYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="71062506"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="71062506"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 02:11:11 -0700
X-CSE-ConnectionGUID: JtwbumfnRGKecuPNubMT4A==
X-CSE-MsgGUID: aQPfkrvFTWmyC/KKLPIUQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="184325638"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 02:11:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 02:11:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 02:11:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 02:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROtz4JhPDU56aSZYKu2eGwewHhPh3MUuSC7tXoqV38rCOy3fD0GtoKOL2Axc2IBnII0uYl6MYxwEMC/iZ42HKv0YeOgcu+Nh4uPAdZcoKAxlE+yZsYcW1RuKQFZhqbEW5WAvyuaYaDNhvm1/inD+4LGcQ2KhM4TRlDs3C6WVW6J5m6tQWwUrOyvYogDLBajdBL4f4OmVzmlokr5YA0XOTXlfx7tUjGwEuYsaEl+AUDuUvIqfvzW35kRVmC1QtRvPAboykkocQfV6e85C1w3+tPUYYpTQDTuHWNyjjg69nXFwhtpF21jn+Lh+CyodmWloI5RP/+kIqTRpGubPy5h4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+Be0/moy6IjXwbPNmTpLpDb5Qje7BoFeJ75zpP/mVY=;
 b=tLOptOhBnWLhdV/DVlnVKp2jJM+WNJtOr3KsrZO/bpVsGy0J6V6Lhk0QDf3Z3n7dw4eUMoKNF4FOM/EnR5wPdeCZFxxHxFx2gajZfq1PxhMdx7prJP0bD1d/yEOEbXKDesG/oEKfcqJ+9I5IxcNO+TaQVew2+mz7cI8RD1CezTFJm20b56ZiyLm7dbI6T0ouYUhP3cuoZhegdNY7TVCoMbRahC9Vy23nPvbhy3/gG3SUyCqrcaTBZTiFqmq9+MWmU8TNwNLo2kS/UYm9Brg7VILJzeJLKQodT3a8gfwowqPRpGlG9gxlLRe70KBinn+tnBCGDFCRLI3quM4Dt2qIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB8030.namprd11.prod.outlook.com (2603:10b6:a03:522::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 09:10:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 09:10:53 +0000
Date: Mon, 30 Jun 2025 10:10:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Yuan Wang <yuanx.wang@intel.com>
CC: <anatoly.burakov@intel.com>, <vladimir.medvedkin@intel.com>,
 <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ixgbe: fix sctp mask in flow director
Message-ID: <aGJUmNRzQU7SARCl@bricha3-mobl1.ger.corp.intel.com>
References: <20250627085953.286939-1-yuanx.wang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250627085953.286939-1-yuanx.wang@intel.com>
X-ClientProxiedBy: DUZPR01CA0343.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e55002-5b53-4e04-5d81-08ddb7b603fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JP8bMuh9PnFodRNsvH7wkn9XyKYMTv8OvPs9RL1NUuj2ZQ0GrYVkbMdFCCNl?=
 =?us-ascii?Q?R67nolXUjFpDiEEd2juZedcY0nhmTAYBCYuZvwbCcCgy7WRPn19er85jWxUP?=
 =?us-ascii?Q?jsMmTTcR6iJg5QqEQmsufPlUcdEOpjktAMNsX+VIvvHm1QwlVqdttBQD4xgX?=
 =?us-ascii?Q?AHINwLJtlRuo4KPh1bc0UcpLzKsMKkfH2JZywJtDEG54XinY8BhPxsANRA3E?=
 =?us-ascii?Q?8U7uFNxvDVUz21vIXDfrImKjAJLHgZdUBvWdHxDBIVeg2orql6yP14yoNaJc?=
 =?us-ascii?Q?RcBFCWOqgu/nDSiKuc0fEY3F1Mz09cF+pw1vpLciWzMNod0tEjG5Zko+GMNl?=
 =?us-ascii?Q?oNQXCgTJiEHmCqeMcw/8ACj2Qx3B2Rl951/CtOLyQu1W/o1Gr8QrfH0CHVDg?=
 =?us-ascii?Q?SYefyWEEdd5/uKQR39PqjP0IU6x+/aGQ53xE1pZSQzXYry8p59SZJeY1uj68?=
 =?us-ascii?Q?6UqBA1hdjIpZE859Xl8jcTq37LfVwuJU2fVR6SIm4y++xx/HpVyXr3YEhTVV?=
 =?us-ascii?Q?ShGGxB7SpxSr49B2+9bMPMfgUlV/m+70NYJzW0faDgvwKPCThdKpNhB9Src9?=
 =?us-ascii?Q?LG9Rnwr2WFzRxFNNdyM0+4S0qLKK4URuqYAzp1pbtm5RQENXVeQ9+QIU5WcH?=
 =?us-ascii?Q?0MH78LTLgKnaQ25g9QMaw8NPQFTj6SwHJa55S8a/xVCG3kXqkiZPWqtADGwO?=
 =?us-ascii?Q?lDClOFDrJF9HkqEqftwAbcUgabxMsHkpkRAxG9rkGWZmv2Otb5JP78McZZgs?=
 =?us-ascii?Q?y5v1Rmwm0Fkng7pKUOR70ia1bTEw9NHeY/Es9mLP9GeeQijzmFS3gt26s7Gd?=
 =?us-ascii?Q?rdfwk2hsLBntrhMCkHTczAJJl/TtqGa0zv+pxSUuVvld7083Ny2nWhQYvRCG?=
 =?us-ascii?Q?BrkgHUlaWAymV25qHW+atajFDOX0zDzfNv5ikTPUX81tj/ll/fl1F+wUncOx?=
 =?us-ascii?Q?7pmM9ZZYUNnuQmsyWxkXdhKOYGOorhkBNohSpcQuIPO4ADvzn/5pDnWmDxvb?=
 =?us-ascii?Q?54zRCxpUXYn5kdYz6Fgt95WDTbzNvKrEsJInKFWCCNpepOfnk0E7b3KUicy+?=
 =?us-ascii?Q?6RpkjVtaBx2WaHP6nXhFjiCbH4PJOrsWXu6bW1rZb3C5bDV7X1gEvMAsyCgG?=
 =?us-ascii?Q?3Bcq9fl6L8UFECWOHMYV1Mhx8slYlCHs2d3Uur+9X18zyejz0c9UZOrcNdOu?=
 =?us-ascii?Q?FvPV76H7vfNlT38CG2ejt5gjg2yNwol7EjNNSg31Z3IliuZkYqy1AFP6x7ya?=
 =?us-ascii?Q?zTeEsc2G2KNAu/jy5Jquke7Y7pmFMIRDDeTgYeZhLtafwoYuFKr4huRn2a3O?=
 =?us-ascii?Q?Qui6K0EmdMojXFvwNUn1ekX9AAr2kSlO9+trfE1dQ/a1kI4OMEjxlks+QT64?=
 =?us-ascii?Q?CJs6798WKKe8wYbOBGbT8C1g2Y+dqVWdJPxBu0dIeiW71Bpx8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BhYvn2h6s5xf4xyRze9xLwuRFpZ4RuqgI/X5wYgZprmPkSpNJsDPjMlxwDYY?=
 =?us-ascii?Q?XNkqvEbo7edpPi73FstI5T/FqS6QYXx3sHcipbbQJbzD48b6EcKI8kcztV5v?=
 =?us-ascii?Q?5uUOPRtkmvYi8fVICApbSiRiqzqXORkWi9vjRBgueq5nXXkNsK/n7x+c6Y+X?=
 =?us-ascii?Q?CsOP8Oh3vQy1taG2u0VMjBv2itaNNfVbg8OY5me1s33M/zjOltpui92uQDnA?=
 =?us-ascii?Q?5Ox3JsCnPwdKvseuL1Ho+xR6juIeF2HlD3+FY+RxxgQilA0rc7IxAWMPrxI9?=
 =?us-ascii?Q?rWgBAAjBGpWZmpy33RIrgT3Qo6miZPGKbvVOY4sWdOXDR8nNZ7emOwpmSUF4?=
 =?us-ascii?Q?WO+BtJmnI3Jd26fnKIMIZFfkoDYU4WXuZelNMOYgAUzvJn0wFxlIja20bC1X?=
 =?us-ascii?Q?OJaTcTLNA/+YO+lzsKu7CEBC8u08FLjNYPEDaiNKZAAiMMHXe33z2o6B71u8?=
 =?us-ascii?Q?/8L/yHoBlJtrHoT3UO21PMFV9hj6AVhZQSj/Ieoci59WhhTqlVLGlRrM+/p8?=
 =?us-ascii?Q?ZfO9cEt7+GfS2mCeg0PB5a/MuaXpujZ1jPpHiKz7aea7KSgrosnZs0EcMuj9?=
 =?us-ascii?Q?eWmRXSBBDybATVRozJnhTcTiZDP6HnHJeHz79hgBwx7A6VoAt++loFjYP8kM?=
 =?us-ascii?Q?gt1APO4y3ayoQ5xwjWhUFGf6bqLpLmHHC9nJ/jHJmJhnyWhdIxOJu1vT/Z0q?=
 =?us-ascii?Q?i60MW/R8F+z01bcer8DnO4sn2SM7BLf461DtOD3ZLEtCQUb92B56nzE6rHR9?=
 =?us-ascii?Q?ixWNh+TIHoHZjkWXVAHVquWQzmWzyYo0hTY2gRTA6ClyHjeo6wvGp967qjz0?=
 =?us-ascii?Q?15q9PqOXv6YrxDkSzq7BvMb6jKcFmTESJrdr8CGd3atEl8kB4opQkL2NPlnF?=
 =?us-ascii?Q?TNaAdkgVubL8vWyJaGAh6m3tEheUFCwhqqCMMaP0GSN/uUFYbxYRzqxgcePp?=
 =?us-ascii?Q?auglebVd0RpFqRQqCptZpaVEN7BYkWHHF0dBwaE+qCH2kDue9Xftomz1UWX/?=
 =?us-ascii?Q?0P9aJyy9qmD05aEOq6y9Mxtw6AD6veC7o7A10TU14ntPDEVhphT8q0TsuDBV?=
 =?us-ascii?Q?LbLOGhDPteoeP1EIneBwwKgcL2rtT+CdAFdXfQau+ui5cfhrB3V6HLPI8Zy3?=
 =?us-ascii?Q?qpG9Qaxp8WJUeWKnFZTdi1njPu07YT+H86/gG3dZjrlL1RK/ZEV1EF1ZDImh?=
 =?us-ascii?Q?yQTn8fqHIqUT1A37Mf45fyYNUAtqf/H0XnbzZI/n+1/f0KIeFfMPsrFSyRI8?=
 =?us-ascii?Q?mIBAJvGBVsV1h068wzThmwA3suPfuXWMyZ9LDgr6rbVvnli2GMk4SNyquOJ+?=
 =?us-ascii?Q?2nTgLLyGZofmb3UK8ktEOT2f/TGTq27+GnvbVE7luRbMQR6Y0N9qn7jApPzl?=
 =?us-ascii?Q?hhKzZhJerwIlhlKcoakE878/zPlm0VPtFEoIkk5OCj0dPb2pipG9Ov94pdlW?=
 =?us-ascii?Q?7Ndp5opq4rk7RfQfXzEupJdqCpBxiPcF2yAvx05jFNvdikof1sPh+vIB7DaD?=
 =?us-ascii?Q?wH5sosUKB9jeTTzDl0iIqkFitm763g8qUEI5m1s5/vL9GPuJ6fzuf7MMTM21?=
 =?us-ascii?Q?eyF2SHgkRb3p7oyz6YqaCEJz2otqFQ+Nd8ADHRQ1CnfTWuzs/mBnZWUBSYQm?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e55002-5b53-4e04-5d81-08ddb7b603fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 09:10:53.7988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4OgLHs1uWisIjECdJkdRclrQkcgHQGGHX6Zpe3aAbIagPIgzodS1pbiVFciJ6SiygcYiSdfnIXtjeyLcRS32zI17z7EBQiySPbcwA2gzj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8030
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

On Fri, Jun 27, 2025 at 04:59:53PM +0800, Yuan Wang wrote:
> Since the default value of the port mask is set to 0, the port mask does
> not change in some cases when creating SCTP flow rules, which results in
> incorrect L4P register configuration.
> 
> This patch fixes this issue by setting the mask to 0xffff in these cases.
> 
> Fixes: c81daae2383a (net/ixgbe: fix port mask default value in filter)
> Cc: stable@dpdk.org
> 
> Signed-off-by: Yuan Wang <yuanx.wang@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_flow.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
> index 6278646720..9f2e470ad9 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> @@ -2161,6 +2161,8 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
>  					item, "Not supported by fdir filter");
>  				return -rte_errno;
>  			}
> +			rule->mask.src_port_mask = 0xffff;
> +			rule->mask.dst_port_mask = 0xffff;
>  		}
>  

Hi,

can you give a quick example of how to demonstrate the issue here, so I can
test the patch? Presumably without this patch some packets are incorrectly
classified/filtered based on the rte_flow rules?

Thanks,
/Bruce
