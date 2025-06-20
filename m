Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EE2C71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 09:19:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFC6942EA9;
	Fri, 20 Jun 2025 11:19:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 2A4B9400D7;
 Fri, 20 Jun 2025 11:19:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750411171; x=1781947171;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=G/Q/rcs99aXhK7n1FdDjs3lh9LlTjzUdl6/k0V4JhZE=;
 b=GiD5yvwI9juh8E9sqWUVsfZmgG4BAMHqcp+s+BwKTtIseNuAId13ifeA
 u9+WSHb0yqwbE/dhXuoC4kaQ3LNZOCC5mg1bkML+ofTS3L4TLq5z9310W
 64pwlPnyWGHyNGVbTfRkagxtSu+hW7w1hJL+Z8W3lzN6zSuAxPJnbgJuw
 LmxLqoHQurZ9SSKRkd2/OMlISbLmfhqw1HQzSv2aFtQIxBEAZ0ZwsAvsC
 Ejh+e/SmrjPTFVB7/8rWG54u4Y2wHVF7cvR9LzmXOAdTB+kq/z2lmOZeq
 bIp4YKbYxtJYnAA1hZVOUWoQxkERio8X02fLtRah7HQio9YN6CsN/5cua A==;
X-CSE-ConnectionGUID: yl/IJllOQQOEgePG12hHAA==
X-CSE-MsgGUID: /5E7xisYRyKrHfD3+CF6BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="70236608"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="70236608"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:19:30 -0700
X-CSE-ConnectionGUID: z3SqyzcER8eHSpQqGierkg==
X-CSE-MsgGUID: Iby6R9NES7C2TnDjERLb8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="151160945"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:19:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 02:19:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 02:19:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.74) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 02:19:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkkn+dDa2833mmmSXamGJyJc9c+uD6xGNDeBz8hytqBM3rbfS837T/z1LgQmDaWycYk4sAkbrfZmrxzsOr3rUO8Jcxhf1yoAIZ8DbjyW8vuTAjzW61G3FXakFHLatO/0u4by7Gsp9JYP/5pMSU5yPM3IPesJIHsDn1tJXoB7Mm9ji/dE6Ch+0L2xB705Le68/a53vCml2l9aNjS0MlDiXFGD9nsMt+EM2z86eWYwsVgqA7zPBtLivqae4uhr7okotHDkrnrUvpABlOyK0ECIsj+CHFh1CZClb4W9N2Uv9pTPtG8hk1qH1zONAx0jLDcgBMkqHKT8N+6vSKwyx2KtCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jooc0onhYei2wxQWYe5T8+bRrBi9hQf/x9Yltq7aZAU=;
 b=IBBh0uIe4nMdlC35NLTkQ4qpb9bKohMcQDY0DLeD2tYP3umqcedhVwY986BYAwO6CVxnKS6VKCJlJa+D6+cf30oJ8fE81hkquSXO76MSV+Is5KHG999R5mBcQP28DmSO8Nc6zkfU2lB7WBtlleb5e3PTe1gLCmmPY9sKjvo/+Ek0TRA33Az1gGP0a3PWew1mw4eH5ApTumPN7Zv5VwQclYxVG4JAeVUifst9IAveWr1A4rr7AbaOKHtTT/yXBzGbuZj6wwV+wqg3uOxbeGSmazlrEZxS4rUuXjl6p+vJbiOk4rUV0xflTqFuboqDaZPGhJac7dRzokAEcyb45TG7Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL4PR11MB8799.namprd11.prod.outlook.com (2603:10b6:208:5aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Fri, 20 Jun
 2025 09:19:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.020; Fri, 20 Jun 2025
 09:19:26 +0000
Date: Fri, 20 Jun 2025 10:19:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
 Timothy Redaelli <tredaelli@redhat.com>
Subject: Re: [PATCH 04/10] eal: fix plugin dir walk
Message-ID: <aFUnmJ8NMj5S49kq@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250619071037.37325-5-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619071037.37325-5-david.marchand@redhat.com>
X-ClientProxiedBy: DU2PR04CA0272.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL4PR11MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e32cf8-99f2-4f01-dc77-08ddafdb8d57
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mV8PANHfPhCfgRSXd8A7FJ0IDVIATgt9zdxjjCamW/d040FhSkmH3e7qalw8?=
 =?us-ascii?Q?YgGG3epxuiEvnlyD3hfDQjZFkL5ZA6WxAZngXfeV2Z81ggcJaOCFB4bqzBKv?=
 =?us-ascii?Q?1cyK7m2M9887TMw+NVANEldWvss+WEkxTg49EWqI+Mz1idABARKQ+6NXGzud?=
 =?us-ascii?Q?0bPWSIeV07GyG9jWPgPJuwKOLxLjYCy3avbBGImN6m1lSbYspkrtZ7jKIeV6?=
 =?us-ascii?Q?ZTUECjHQFBA0IcaL6Md4sgAWLC6DhKEKvInuaI4Q6M6bLzq1NcDzoS0upuj+?=
 =?us-ascii?Q?nxtfG0AY4iMvQmzjz7UmetDdAkNcolkRa/V4/vBwvcdia4foXrQ7565nYDvj?=
 =?us-ascii?Q?QoCzmsWRKHjiZV1K+QwKqxbP/0D83B44XNMsYHUE1pu7pnrAkib2eLTtbRLT?=
 =?us-ascii?Q?S8VRJztodAfaiL1/nnEAMGJ/T3ET+/uLv0ZR/zwCRHDdhms8xAPOgod3Fm4E?=
 =?us-ascii?Q?CeI3tE1z/WVAQa6StZ6VsAYmZATMZX/ZJdm7J2dmty0bww3ozSiwrYQsbgg6?=
 =?us-ascii?Q?GILkTIglf0GCg3xnCxAncs3hVaAK3GhMyC18beM2ZXTd07cy2cOVRRC7zrxd?=
 =?us-ascii?Q?zun+Zv07iCr2Y/HfrqNS/huJFL/2kmrVY2lbOU+a0eWVjBT5pv79jYxn8oBv?=
 =?us-ascii?Q?0AvTBoE5nFPbidOrc/9IFDTJWPTH5v8s3VOieSS7u+NoPeujeF475LWJ8VYe?=
 =?us-ascii?Q?UvF01NjfjLm2w1IfLGKj84p7bvWLWLQ2V9gogrgL+fwnxul+0bYkVAh0x5wz?=
 =?us-ascii?Q?JBBSmrlF+s+/iCyfELBQjL/82F4a5xTJs9epUV9oIzgPXvnClwhSPK4CAowI?=
 =?us-ascii?Q?s+72esWIiAlyJsVKYC+Pivoyxd130es0EkhQEfzlvRO1e0uV6rSvLhdZ0OVv?=
 =?us-ascii?Q?iiFs2uAjLRMLVmHHkqzURDGpNXa32mou4LcKu73BHXEoZUpo7o/nGeAd14cM?=
 =?us-ascii?Q?vB98lG6LKCZh6lPvWV6ld81LrPoq7G7pv43odduAPT7CjYGQh1xKjS7rxw4m?=
 =?us-ascii?Q?7zBwglSjcXc9RVMI+25FqzszFPtPeZJlq+TOMxdRhVgSLCKJHMe0quN23h20?=
 =?us-ascii?Q?QOaHMOtgW+fj/zlsphHnTRCtmmFaW5K0WQ9pihvI36RWHYjhIDsDIz4N/6e0?=
 =?us-ascii?Q?JF1NV6oTJTubkrLpcGgWkVn5furHTX1PnTXTvffaN4Ii6dFpjk9m3w5miCvh?=
 =?us-ascii?Q?doFvqjkFUA60BeRlZW2o3qUERvDrxmjOJX+ioq8EsabsnGSwprymN6WX/V3D?=
 =?us-ascii?Q?JDEYZGZV6EZFe/WPi8WIzExHVVWhYUxHqvFX8JvyiT2jLvilDREX9+jijRLq?=
 =?us-ascii?Q?1NvpCmY0/l4KS9U/JjDGzXeR56eeLYBJtmrCh9r5sMyuIGBJ47rVYU3nMHnp?=
 =?us-ascii?Q?M8toQwsZfyq9uecu3/Jm7vf5EsqLhN+8ck866OqTdUQ51Djk744we2Gvvpk1?=
 =?us-ascii?Q?Bi2y3T5sGRs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n1E7Q8iUOowyvs3i3tTsxsj8ZpsN2frVx0QIVW4iAxHVUoa8CTkEU5uaA+cL?=
 =?us-ascii?Q?J+I9Kzq6GcUToHm1xkyv4QH3IkwTmegXGB3E/t1tzMbqDkdcYymv1Vh6LG76?=
 =?us-ascii?Q?NKgwxpj1iy5W1wImZRHZW5USp6gMumvUdUx86n0VqA5OJYy7r9jTbf+BuFcx?=
 =?us-ascii?Q?6AU/jbr51LsLo7b8WwuTURjZYyO3uAJUKQB/y2Q18NEXW8jU2Se0pwY3tUcD?=
 =?us-ascii?Q?nmqJWyq23Xzj+mAXorf8bFR67COJlmSkOn2sjHtdMjaRUO9aPyR0WiXf5X+C?=
 =?us-ascii?Q?eavN/0B7P8AEW0waippiKJfz8qTL1L7410VwI89mQyHn5mBAdAMVkbaIAiai?=
 =?us-ascii?Q?5N/ortmU//QhVKcFyxosB2yPPzSycInOdYNfpDtXRsEzJxUSx4fs1totIVNY?=
 =?us-ascii?Q?uebxENvQQHDa2uCjg6SDFHq+fIbFjYEbrfbYgkCWtP3T9eG6Fo89XV5CnVPV?=
 =?us-ascii?Q?aLvreD7exnN08pOSX5sfYEL0wZrzR1uypku9csaapcJ+hGYO29eGrB2COP43?=
 =?us-ascii?Q?UGvYApmkws0aX4jabckVKoZMzxf4Q9lo52n2yjmPl2AJRSZIDPu54aBJgOCN?=
 =?us-ascii?Q?ppRRrSLNmzp2YyGxSty2don8iq2ykYcrbbE/QX38cAsyJUjhsvsiONFfTabu?=
 =?us-ascii?Q?0sO0bWA1PjSkMjTe/RfCe8IdlbKuChz91CWyYkhFGONd5mwXMs8ACKqjd5yx?=
 =?us-ascii?Q?b2FoMXiLYN+WyiYymLL1BTBhrDCCumXwxcojlY73tHMmbtJfbmxDHHoSN2Eb?=
 =?us-ascii?Q?8nArFrW/0ZksZRJEoiof2qMcJM6r9lukubNDEwtv86sHI+hqu9pxaXdBwh9i?=
 =?us-ascii?Q?Ba+vWl0cVLv925tVp1n7vophPQfkPYMwKvqp9sJEaBOSNks6/HClkmdjIi6M?=
 =?us-ascii?Q?/GTG4FwBY7/I5QCYc5WBqy3sKYtSXWkpHOoH7KQ6HYk+SOaTtWt6vSlxTftF?=
 =?us-ascii?Q?IUYwHVSG3W4FQkf18j3Cc2RzxcRs+YM/ILpET82+I7cwUpG2lWMor/VbMUmw?=
 =?us-ascii?Q?UwubWiirkln/JNypwv79Wo1Ana7vzhc+O34o5L/Uj/OR/vi5VDW/rlcPUg1s?=
 =?us-ascii?Q?XSFJ7S1+dl66ewnCMMF75Kul/swTpH/GO9u0ru9/Osi6/5lHqf4huFqYjXUy?=
 =?us-ascii?Q?9fyIdqp5nvmhBwPvg/++bStgYf6xOzjyUqCbU3XPNbRT2g44YTwF0j9PEHqC?=
 =?us-ascii?Q?54V1/gkAiPtvY9uS9oqoXYNELM715/oPrqvcgGxuEJdCX6aD7SI/Hi4BuhGa?=
 =?us-ascii?Q?BdtVt0EAZXhFSWGzKRYqZpePDX1vR33dwi3iMhD+iVWUpgF9gnrtAgkHi65R?=
 =?us-ascii?Q?URJXVNcyKNK/gSP0skIHj6VXX775HH/UaahUOqMPCIsEGSxv0iLaUKlALEkZ?=
 =?us-ascii?Q?JYWXjzNvfHsb/7XTkxGHrsHhKXVOyC9NTa4VfY44hCUSekq7Td3QnDMXZ+e6?=
 =?us-ascii?Q?wH6MRwAd5oP9ImkzFxbGItnUuYhYXnsGC+AAAZptXR5s7MsCSBntMD1q5vGD?=
 =?us-ascii?Q?4GxC57h9hc6cBp6hKKYVwRl5v9lqx/+bbwdlyYBF0LEuLkeJJ0syv5m4tqkA?=
 =?us-ascii?Q?kyYFqPVQl6qgFs9bw9I/Fip9RzhIMU+IKZrCSg7Gxw/8GaS2uc1/MhXwKDyl?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e32cf8-99f2-4f01-dc77-08ddafdb8d57
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 09:19:26.2694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/fIOQLZvgmoSuI6+3sO15/PTkvPAjUvEv328Ce3kVmKDWb5wSgyVhYY28BngRdfCCCWxDClypnO2ZVZM4Blo4BwbFR1tg7NU0Nc05EMSME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8799
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

On Thu, Jun 19, 2025 at 09:10:30AM +0200, David Marchand wrote:
> For '.' and '..' directories (or any short file name),
> a out of bound issue occurs.
> 
> Caught by UBSan:
> 
> EAL: Detected shared linkage of DPDK
> ../lib/eal/common/eal_common_options.c:420:15: runtime error: index -2
> 	out of bounds for type 'char[256]'
>     #0 0x7f867eedf206 in eal_plugindir_init
> 	eal_common_options.c
>     #1 0x7f867eede58a in eal_plugins_init
> 	(build/lib/librte_eal.so.25+0xde58a)
> 	(BuildId: e7e4a1935e4bacb51c82ab1a84098a27decf3b4c)
>     #2 0x7f867efb8587 in rte_eal_init
> 	(build/lib/librte_eal.so.25+0x1b8587)
> 	(BuildId: e7e4a1935e4bacb51c82ab1a84098a27decf3b4c)
>     #3 0x55b62360861e in main
> 	(/home/runner/work/dpdk/dpdk/build/app/dpdk-testpmd+0x9e061e)
> 	(BuildId: d821ec918612c83fad8b5ccb6cc518e66bee48cd)
>     #4 0x7f8667429d8f in __libc_start_call_main
> 	csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #5 0x7f8667429e3f in __libc_start_main
> 	csu/../csu/libc-start.c:392:3
>     #6 0x55b622d9d444 in _start
> 	(/home/runner/work/dpdk/dpdk/build/app/dpdk-testpmd+0x175444)
> 	(BuildId: d821ec918612c83fad8b5ccb6cc518e66bee48cd)
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/eal/common/eal_common_options.c:420:15 in
> 	../lib/eal/common/eal_common_options.c:421:15:
> 	runtime error: index 18446744073709551609 out of bounds
> 	for type 'char[256]'
> 
> Fixes: c57f6e5c604a ("eal: fix plugin loading")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

One thought inline below...

>  lib/eal/common/eal_common_options.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
> index 83b6fc7e89..153f807e4f 100644
> --- a/lib/eal/common/eal_common_options.c
> +++ b/lib/eal/common/eal_common_options.c
> @@ -399,6 +399,14 @@ eal_plugins_init(void)
>  }
>  #else
>  
> +static bool
> +ends_with(const char *str, size_t str_len, const char *tail)
> +{
> +	size_t tail_len = strlen(tail);
> +
> +	return str_len >= tail_len && strncmp(&str[str_len - tail_len], tail, tail_len) == 0;
> +}
> +

I wonder if that function is worth renaming to "rte_str_ends_with" and
putting in rte_string_fns.h?


>  static int
>  eal_plugindir_init(const char *path)
>  {
> @@ -417,13 +425,12 @@ eal_plugindir_init(const char *path)
>  	}
>  
>  	while ((dent = readdir(d)) != NULL) {
> +		size_t nlen = strnlen(dent->d_name, sizeof(dent->d_name));
>  		struct stat sb;
> -		int nlen = strnlen(dent->d_name, sizeof(dent->d_name));
>  
>  		/* check if name ends in .so or .so.ABI_VERSION */
> -		if (strcmp(&dent->d_name[nlen - 3], ".so") != 0 &&
> -		    strcmp(&dent->d_name[nlen - 4 - strlen(ABI_VERSION)],
> -			   ".so."ABI_VERSION) != 0)
> +		if (!ends_with(dent->d_name, nlen, ".so") &&
> +				!ends_with(dent->d_name, nlen, ".so."ABI_VERSION))
>  			continue;
>  
>  		snprintf(sopath, sizeof(sopath), "%s/%s", path, dent->d_name);
> -- 
> 2.49.0
> 
