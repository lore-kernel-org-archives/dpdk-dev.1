Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF401C88E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:55:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 345FF40269;
	Fri, 11 Sep 2026 11:55:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id C8FB840264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:55:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789120511; x=1820656511;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jNbFEecjzZGQrrbY3t99btqjSExVMDUieq+VRnt7s84=;
 b=UwAjrVlzQ132aK/m7rhJkslEBQU2TueZ4KxuTrv6d3lyDV6kGxmh3BIY
 V/+gkxt5G6QGsYsiiG6x7PKLVKtcRrPfxF5dx7sjNXYYABIjA8NbGJZR2
 H5Dd3fwoefs8WxRrHYqXrNZ/zLRv2whPBkb3BX+CXkzxh/N4jKAc+2nHk
 lTeaK9TPCmzAkUaKuaWowgMQZV6/mHhoDfSykthLo4fLZBud1e2L4sagX
 i8MdwQzRLTz7589dN448zOMlbxXJIgHlH2pn6i1iPmiE2sWVkdA7TKR/f
 jSwZrde0ZXxSykPnE2pNKEYBZu+5K+I++z8Kax4FiN6++S/W5bOhbSUVD A==;
X-CSE-ConnectionGUID: u2nFOApmT5m3JqvfNeCpXA==
X-CSE-MsgGUID: lOV5wZjYT4q/ARjUfHMt2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="99912361"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="99912361"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:55:10 -0700
X-CSE-ConnectionGUID: N0r8F1I7StutpxgP8cd1bQ==
X-CSE-MsgGUID: KSWngICeRM6k7RAvqxAVnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="168611"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:55:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:55:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 02:55:09 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:55:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7jVcFSLiFmGOYnngGPIwsmZ8aHp+A5wWgZ3is3Rs697hWhKzt83Bp7u+2kdVOYeDADGi8YKCg3/QqoCpSbcWSEfxjMbqfwblcD98fjwTpLXBdGW5uHpr0gGHmV0O025WmSjtYrro2KX0r8+st2YgYImKB74X7MlP6OPbrRmflEOeY6bIJEC+OlgSG4ydA7b1J7bVcahY7T/UCmnKP//9GmKO9xhMriu4fawxzuekodEI22JNmk0bScNhUhje0ANZLckH6X/yvF4fbjuA2tGwhImwukgWHf90+pTRFwj0OjeOOZU4uESGfexIDthkDEA5ZnWHwMij+NSryIummDz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoH88C2ROFqwHHohR1kyafqCAoxVyasOf28ZwO4hn2c=;
 b=Jgwe/ecgt3l45TqrMPopZXK8X7paQJOMQzNIEIjRCEiorJKsJR3DE4wUQXEDBEDGNps4QYAdmBw7shpkrzv9J3YYeNujBfat9aixaBeMJXKqeOfCe8E184m3Qb+ZC9msrzK5R8m3SGWxoxzGGlGjjDA10T1DTwvb5ahh7pukwuITgPjqkCD4btI0Ap2SftMCuDR+N7ZmhLJq+UOm6Dg/NEa4hrZkF88kuKxb/N2sVTnupdHxjmcLfvN3iD3Jro/rmP8mRBKCMYtnttC6B34r+VqPVGFFVxomEOGCAaGS5Uyk6LTdUpB8IRJy+dpMTRjJ9Z/oviKL3NUyUCj4Ry7D7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB7118.namprd11.prod.outlook.com (2603:10b6:510:216::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:55:07 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 09:55:07 +0000
Date: Fri, 11 Sep 2026 10:55:02 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>
Subject: Re: [PATCH v2 50/68] net/virtio: replace use of rte_memcpy
Message-ID: <aqPP9rNKnJje_6gF@bricha3-mobl1.ger.corp.intel.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-51-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821192646.146382-51-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0082.eurprd04.prod.outlook.com
 (2603:10a6:10:232::27) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 66757098-63e4-4a56-4a76-08df0feac27e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xkHZx+9JK7Fxf6Weso8IDe3VLrwQsp4X7x3QEwdI1Y3GuhW9dNHG3KdgPJ6ur+D+cjGtdNqCt07Wi/2Q/sNQJai8aiYeOlNI3PCTlySm9LWrwHAY8x9ri1JqIS0eOLcgBHZYbmRJsE3NlNRcZ1Elqjf1eu8SA6J8rcEm6OlJFObGCX55o9JNlHpNpEF4zBQhERcv1uabfbqLXu37k0knqXG9aMTz7gVCMUdyFgsHxAJNIW7PjUWmFYlhnu+4G7jqp/tUp0b1fen4DwkIRSFVietUg253X1lzfzhbygnAEEyyh29q1gvOXinyl0mueMryynLf0CA4tEnYIlFKKyLjGla72LMTdL3lXQjWXVpiWbbwJBob6EPX3L+KE+EPdHs5KYc1qTL+mn93RC8YaashViRBO69smaRTfP76WyAAmkNx08frgiTFxeUgpvbftZghM3w4yQTKWwHpbTi9A7zSucEIUHRkkZidxvwFCL34XGrB3Z7aSLGvEVbs10bOijGVjuifOiy/eCcMECzxFFPXPcd7Ow50fj0YLw77dQ5pt3zXZKOd5wB6X8DqkP6rFIWZJo/p7EEL6Ju7YlpmUGnuDtCmRV8auirEaFOJ7+Md/wt0xFlQQtKQUcBs5pKrIYIAcoOQMngeHatRZPonVRi03Ypi6MieOUYJFXir3TnLV+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7D6zPKkpf2xlqMPqOc6bXUvF1hOCB0aR9WrhZjrOONzCzzGwrQ6Qng06YPy1?=
 =?us-ascii?Q?82Veb8lFiXAU5OYQhWyDoB3kFxU23oBsP5DOYZsVRS+7/5/8UMptRkYvBB4x?=
 =?us-ascii?Q?1ea5Ucj2xcxSLvlKSI1eA9SjZ8hnIA81TWpM/cJ3UtkTlXqo3BQ1gsM46Yyp?=
 =?us-ascii?Q?FV9MMC9CUEgqARVdVR8UMpuevFTp1wCpGBkF+sP8N9Jvs/f/WJ4qAslKKRlh?=
 =?us-ascii?Q?lHLubcEnrS1Cn5ZMP8RrCUeIP1wG2fZ+8o0eAS9kcRHAyLErla8yPFSXR+1E?=
 =?us-ascii?Q?+qeqlzG3r+ZsnU8U0vAkq2W3BKFtQRsfA6GlaE8YjgH6hKhgEs+9JGn6XWfo?=
 =?us-ascii?Q?kQq88Vv7C9c5l+MUpVfbT7SQLYbULtuvDCFG6DCGf4N2UVdqE4uIMWFJcgbR?=
 =?us-ascii?Q?+QKq3pKF7QHufKN3HEdmn+XF+WDADCQUNkJoZzF9mdymQ5QE9Tt764N9tHWR?=
 =?us-ascii?Q?q2nfj6B08SGIa9lOBRyZkmLCmGYGb6+OVNIOCQBfdj8UAF4aXCl05TIuEMTu?=
 =?us-ascii?Q?ccLjUnmfpMBi78zTQznweZjKcnISlXC5PlWy0e7vBhRcPjTIDrAR4QqR29nm?=
 =?us-ascii?Q?HmA75OGxVkjcvG8I2czSikiwhMLhCkVtEQtltbyrKOj1bhV0164oC29NMgYS?=
 =?us-ascii?Q?wf7pnsDPtcyI+qxwnKTvHvbZJ25PTr602gb6YHWAX0h4/4qu67XFxqNQcBWa?=
 =?us-ascii?Q?mb9KKf3ebqCoELVFWw0N1o7u2qdI0WKphvzDxcaVh0j+FszLBeVfG+5QCYep?=
 =?us-ascii?Q?eyb1ZwXk82EvDLfk8wBsYOLjhxuDqilFoMJUIGP6duqO0BHI8A+EBcz0Z7YE?=
 =?us-ascii?Q?hQTokX0DtlkEc6Nx2Pso9DRT7glmqcI/k8tUG1plQfZTt0z48mwAnElfcex6?=
 =?us-ascii?Q?6g9h4GGR+qjFfvAaqyL00ukUbbNAT7yZ+AC7P59LvrP+y7D3q1QfVlY/W7Gh?=
 =?us-ascii?Q?QzLqiMl8RbDtaOKF98EPKQFCUziKmJqASUPNwRwU+j7yF4IcaLLoMRX78AZD?=
 =?us-ascii?Q?fom2K0FDROc+IU2jYPkCXUrlFa4FEpQSP9XqUX9qhbrknIhMenLLChmqEOp4?=
 =?us-ascii?Q?ha1vZmtl8F0hYoib9h8o+XWAS3Qoh4wzyxkVPOQedHkYpJSmYRdIOYpQItZF?=
 =?us-ascii?Q?4+5g/HdqFDEiTEtLsNvqRrJ80l+rtt+xoH16gQL4X00pZbMGGoF9blUZ1Uyn?=
 =?us-ascii?Q?uZadeLCRsLPT8nbZdaTQO+pQZQUdsEmOJjlbJLcPUKIuJcztrg6+UoWRLjB6?=
 =?us-ascii?Q?lG1XDbgQb+nSACacjoX2RcMWB16FsA0PiF5imk8Zb1Smy6X9ys6HbYU4h+vI?=
 =?us-ascii?Q?rR9a/gnWPslNJUQP3RaOD/5ojm/MeiJ4oGgeSGZj7nFfzqSlNB5AuiYDxtkA?=
 =?us-ascii?Q?Uwk0HvUTTz3+B8YK+X7DrNsorTitTbNEnxuQLyLTHIO0RdnuQ+FEjSq9nyFK?=
 =?us-ascii?Q?8MWMI8GiuP4jLebXzx3iSj1CMcl3tTeQDNtR3UtEiXQrqSH/lGrzef0MzjBg?=
 =?us-ascii?Q?ga576tSVYgtHHAmyJ7HL3ZxF2fCygopXODo8jjiUVC/GZcQVy45U0A0U+zJg?=
 =?us-ascii?Q?6BUpKUCaWPNUZcLCPnsBy+PaE8MRDlSozxEjAkxGsqWUAFlrLiF2tGnG3/iq?=
 =?us-ascii?Q?z1U/2sEGOL2w8gKQNF7XURfUbyZQsc9AZnguWt7MOVd4fBAytt9oSjZiYVkv?=
 =?us-ascii?Q?+zDnuImvy87u9UN3Oe/t/iSqaXNNq77WJHkP5XmMpEkgGFSj8XfsUXg/7HWi?=
 =?us-ascii?Q?0iNaB7n7KQrMkVnZTaLJb5B7E3rzKYA=3D?=
X-Exchange-RoutingPolicyChecked: ecU/fn7jTN3640uA/ZAK3THZVXK7hMrlKYd34CWNqxG+/5WOfKLHFOAdnbyfYOjKLzxr8kNctVH5Ah2GgjW3vIfC1MHwxrUMfUHBLCXsdMBej0SU4g6H8+eO7KsdFfQCZWc317zAsj97je7Gdh82kujavFVssOhGOxTn6Lq6sNUv2QL5gTu8UoQML1bbx+fgyZ1x2udq11MBoBbDlov9p+Q4pwwBpfU+ntKUaTJeET8d3BSAVLbKyBWcK3SWYXjM6bR/Cp3htFhwXTaqFnhlblDqXE4sJfEKLW/Uc6922d5LiciwKMjzSW0PjFZMO1CwSOzOWp2yCeBoQ2Slk2Zz/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66757098-63e4-4a56-4a76-08df0feac27e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:55:07.1258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYT+gBmZ12BpeogLnQEZG5ybWrl2+MgDJ4vqM/1Ea6n4RbsfvySwKnLSo2O5MctO3VsNmf3HaGIl6OtFiYUoIwCXLbV9hrWeY7X1ZTZx/kM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7118
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

On Fri, Aug 21, 2026 at 12:24:45PM -0700, Stephen Hemminger wrote:
> Don't need rte_memcpy for fixed size value.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/virtio/virtio_ethdev.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Change is correct, but patch needs different title and commit log, since
you are removing an unnecessary header here, not removing rte_memcpy use
itself.

> diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
> index 9fd746b80f..62a9d7fff9 100644
> --- a/drivers/net/virtio/virtio_ethdev.c
> +++ b/drivers/net/virtio/virtio_ethdev.c
> @@ -10,7 +10,6 @@
>  #include <unistd.h>
>  
>  #include <ethdev_driver.h>
> -#include <rte_memcpy.h>
>  #include <rte_string_fns.h>
>  #include <rte_memzone.h>
>  #include <rte_malloc.h>
> -- 
> 2.53.0
> 
