Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EA3CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 14:39:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F147C4025A;
	Fri, 29 Aug 2025 16:39:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 24DC140150
 for <dev@dpdk.org>; Fri, 29 Aug 2025 16:39:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756478376; x=1788014376;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=4BpD7TvBDQ7amwXxB5G5YOM7cMJbU7KPHla03yNd6WM=;
 b=FNV1meDQgK7gD+mmXsC/3H7RnH/Nsl0/fgoj+mHUGVIl/+sa3+bKKpA4
 L7ZQUtR8rCjkWQdnmocmDpBAZoAwUDeCEfU8cuBdG1XEOy3slFIuOZ8kX
 Qbdr/B89M4qmkhDhFmLLhuxH9UEM4IojQFRFKHHtdC/gw+5fjTt1U2Vfq
 SqKjy8cWSYUFYaKLQlhBNlWaY5E0YzdrH2q1UIItJVqZvbM9BqShkLLX/
 k5bqcgQJ2UEayET/RxOTxCNIahpx6dUzz7WlOu+upaF0KSM9Q00n3pL4O
 BUXpaNHJKKTl0dPUdPp8zlYQbVPoHwdtbdA3SLg/1n0Gg5kQmGsBVzXJC g==;
X-CSE-ConnectionGUID: gfipMpLyRbydcZpuLF6Efg==
X-CSE-MsgGUID: GadyIbOrSfiv80H5eE4xew==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="58618022"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="58618022"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 07:39:35 -0700
X-CSE-ConnectionGUID: 8L2Ve6YrSlWbOhDfJqy2sQ==
X-CSE-MsgGUID: wjTFAOoQRO+F/Z9BdXO2yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="169968762"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 07:39:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 07:39:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 07:39:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 07:39:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6fAJSiZ+sA3DTOzs/Y90kdiLnHa+Vh/PsapOxlauLim2pHJXiTzDkFD0XIgxe6krDbrlRx0KglBTXv4vLRP4Ai/oFqDtDJlwSE7UQaAq7uaeFhltqpdThQneYjCBeCepHgBpIMujdpW84KnTqUjDA8zc4g5VKZfmrzCn8UkwYdjgV++uh6DEMAVM1VTNh9gDkM0o3DJ+uZYxf1NAzJ0VoHBxBND4Z9mXuhpfUA17/4x7CxsO2rv1kOEWKr2iwMhV5Q7RhRgFXmgtNAUc51ynl5ICg064/fj/FWv97InV0GsMH11VZTKS2lzr6p+yfh0Uv9HW6HEHH7W4fQQf6RqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxOpuBUMau5vq03ShaLwYt/M5OQ3WAYKGe0ETu3C+Ks=;
 b=lVsq0tmpUtC2q2aUKLH09kclAr+UqMx+D94xfDXjt4TfyKz4K9VnrIYikncjBCWpwM3PpxiDfcEjGwJFXF1ZrosHvgA9cZZKrGAO1/IHwypWXd6Imh8l5n1MualUv9kh3oQ8Mbmi8YO0+2+jp33KLxfyZR+3PSmM0/2ceEUjEFNVG2iCUHltPS9XABTE5QTQg8NU6abWsg3Tgiq94XyuLagaVu1OJVsr97VL0WbRYksK6BmKOrB9e5Bessq2wopi1tS5wEV7Asrt+7Izl0eCycyak2QghhT4ryu6op1eVmHsS8W/7aNese5XSye97xYyjFREHONizbuVXLtC7R974w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DM6PR11MB4563.namprd11.prod.outlook.com (2603:10b6:5:28e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 14:39:25 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 14:39:25 +0000
Date: Fri, 29 Aug 2025 15:39:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH v7 00/13] Simplify running with high-numbered CPUs
Message-ID: <aLG7l8g67JGgSVVI@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250723162013.2392-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250723162013.2392-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::6) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DM6PR11MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a1d039-06e9-44b9-6da8-08dde709d970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F4snB8LbDAgk0iz8RE6AoLSM/cKi0amy70mJiQbdm8tXk1WAKu4S+VsB6TKQ?=
 =?us-ascii?Q?cV2dWbvZoENfe2DiHL5ApO5MLtOZ1INFH5YGrxa03du1a6C14aFT3LSZX7l0?=
 =?us-ascii?Q?KXbh3ay3S7a/EhfadyO5ItgUzahLe4t4c0i8gcTgNrEtFxF0DjkLZO3l/CAE?=
 =?us-ascii?Q?pHsPnYl7m8dvenn4dL74QN5r+e7LvVkj2ph7HVXYEBBtz1R8AKDKhBcQepXw?=
 =?us-ascii?Q?p+vreqTLJEvskCWbt/9K4tl1cJ36Mx15/s5a+gb4Ysw8vc10vU4n7ReHkMD1?=
 =?us-ascii?Q?JKi7kOzehHW+VMrL701KFZefudUgi+Qcx/zqKQykGyIPSGGH5Zr1X0G4zbSk?=
 =?us-ascii?Q?MMSrXe1c3HEyIF4LFL+H+xgF3oDwJAf79Prk8xrottYHvqsjNoapdYt9Ts9q?=
 =?us-ascii?Q?bCLh48N/VD0UIyGT/+DRdfn5bSlMQgSsnC0vQ94HCHg1Lts8gJrGSPkv3FD8?=
 =?us-ascii?Q?DQLcKzF5Griespi3nIi8F1unSosRfU6uDBcqK0Ooi+KNe5TYBZh6UH1zdOxC?=
 =?us-ascii?Q?n0zlu9e0ttb3CMRt69MmgcSA/HeDxB1iwSSIH334SDZpXFlFttXkYNahaYQC?=
 =?us-ascii?Q?lkqFb/hg0aVBaeCnRed/fY/yyw5Pf8FzGRXXgdF9/mtzKzQWMt4l6cB3tnt1?=
 =?us-ascii?Q?Ijr8+DK4BCYA5BA5FSylPgWosCo3CPS8nDgwjrlXu6JjEWy171bZ+fDHsQi+?=
 =?us-ascii?Q?l+PBxLxJ/q7+R8cjM2AGTG+lPQepy4CIfaBeprgCCh7Qe411nakCvA4ZMDZh?=
 =?us-ascii?Q?4DMLzPiJTZta6buEi3LmGww/k9VIBOQ8LK+TSlx+ylBlwAKv004UPnBbLxuR?=
 =?us-ascii?Q?1jvM98/WoDO332oaTikrjR0UQSWi5eus3zmur8YrkmfmLd+B/53YMXCQfhmA?=
 =?us-ascii?Q?XKbN1Ld4p89KPo/CP9yUN/2RQ+xRZY5Ht/3DFjFEnkS6sUjXzsRVcYU9l/40?=
 =?us-ascii?Q?E7zXLJEtxdvJlE4uOuS/aPU8OxKNI3R4YvqxKPC9z5GCgSnZp6NV/FVRbJzq?=
 =?us-ascii?Q?Ikn/o1O5vfACXTOLWbmtKNqpuDL6w1I5wwRHbd5j7EkyyMTQtfdbOXycX9jg?=
 =?us-ascii?Q?ZpKZN9VCZUO8wM5i6mQdKx1pYZ60lnjGpGRXR5exHEoFnHK9+9SPc4euUb16?=
 =?us-ascii?Q?k5lMEeuKobdmO2CrpcBYfYQpKuCgwoeExmUpPhFyw6vDXVPF2sF1fRnAQHil?=
 =?us-ascii?Q?qrMwh2JecCGgYgid6FxEzuR96GcDs4MHWi8jIzNCj3f8HHFNdZHle3TRjjXq?=
 =?us-ascii?Q?9foXrgCB9N1k5J5qzl6902TuMCwUCh0DwcsorbhOvNrXQk5DmqpcCATd/BWn?=
 =?us-ascii?Q?TOWWf/wRTVLO0zwuiDXzc4Z67ZRfRQlz2CVfsiS9g/8srlnSWGejCHT3DxqK?=
 =?us-ascii?Q?VliuU2ASTyl6qUx8k8ZtXdjKctyJKMPXM1SPrDTRQSL1oA7H9k5XhgTG0yYb?=
 =?us-ascii?Q?vRJtPfbMxwM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aXYfgeowa54evWHPE81EksifcUwYWfX3EZbK0mcwZfy0GgZWcIlJ5Sv8ekU+?=
 =?us-ascii?Q?LUqdl1mp+KVuNzyi+bH9/CXaWaopJlrLJHJ2yUU1/8Q2V5wjEoXu1dZVKbS3?=
 =?us-ascii?Q?V82KcfHSkOELpjplfCbu/3PYJP5eR06W9n8yTB9BWSxDaFIVY8drnaqU1pha?=
 =?us-ascii?Q?gYz8w4lf5qnWRMTPTMSf0D7l1/aNnQKt+nAyIy9AHqa6aMnGQVMhH7ca6gAb?=
 =?us-ascii?Q?yOS3z7Cc211NqdgcsCk32DTy8dSpFgKJ6+hV1KdiG/mlqz+ZMFG6uuCuYy+o?=
 =?us-ascii?Q?ssMf4j9BJ8KhCGMxfSg5rOup78x9OBNgBZz3ms4mL46FWqmlAV1Gocg84+HX?=
 =?us-ascii?Q?dQKewWhbFw08GJUJg0D2QxkODXThHXe0X11O+MTHdZsIMW01wOp9xQ2C6aqJ?=
 =?us-ascii?Q?6LHByRmfqNMICi4eBRuOhtkUNHqtYjD6RQzwxeaio67uURT+sHJB/i6/wz0w?=
 =?us-ascii?Q?X3psxOprs1tDbjwSKkjJGQNyuWsmID+SC8dAMw31/jiFuOTgw75fDIzkILkE?=
 =?us-ascii?Q?aX0nzmMRCi5eC6oc01qu32hQJJfcUpKWePR32qPA0zy0o4+L30FZkyo1SBAI?=
 =?us-ascii?Q?05VrvcJ9L18oOickQS0AV0WY8pEaUlUEJkRIDEdg+Q1WIq0u2s+YdxDtMLwy?=
 =?us-ascii?Q?1+YtFloPJfdvY/MyKakUYa2JM6cVXmYZEpLZd3ZfLdIcQ54KH0pv/084Jj5r?=
 =?us-ascii?Q?kPf5pv1Bfjg6Wja4jSbQ9AYAGJ4MHtoOuDHPCLIUSFYJWYUgiBKU98kbuRi4?=
 =?us-ascii?Q?27XodYG5Qzw8jxLKaE6db+RUcKU+bcSgcnS2qGWlZ/rKxpJVITJkVDOzc3pV?=
 =?us-ascii?Q?lMiJhA/qT9Ai/VBtjyHi/2fiFpmAISjnEQt98g4iGZ7mMfk4xOwXut44okzn?=
 =?us-ascii?Q?aTj5L15kgD+ObYleyer2T0+Qf3BBlQ0PSGwFhFJK0qN8xEQxvTSLYdyndli/?=
 =?us-ascii?Q?5aSoxcsLnCD9RU92+NYqXMct0+4+wbmg0QSSnS3YtQrjDhQQhEU+Nyd59hu/?=
 =?us-ascii?Q?fI+L0fLa/Y+JM+zTUE9f9hSGecQEO+x73rhFAcjkHy71u3Wk60mLWUYBhzi8?=
 =?us-ascii?Q?bzu4zFCLWICYRqRQkd5KAwjCZrj2y6MTNY9pCVIPsJ8xx2qgrDC/3YKgxZC0?=
 =?us-ascii?Q?hlqz2zTWWU5pacqW+yPm4t0YJjkTH4kD/PbfKR/csaZWByGveLzN8ASnU9qU?=
 =?us-ascii?Q?l3UfuY8E+uMaViurdqhqgReBNvHpPHVa8aQbYPqZkW/sCMN4mmQRLAPT22+b?=
 =?us-ascii?Q?FM6DO0HD0xGF55x8coApN77xlNEbHz9WLvNR+SBMLbiHWX7/lgtoVFvTLjvC?=
 =?us-ascii?Q?1XDF2EbKiLQ66eo6M7kIcUlO8yd4BOclj8rrvlQPfS3y6k5ep/khEl64emNU?=
 =?us-ascii?Q?xFq51CfEr0035wjkOm4DnQ6xjiSzv1oWkACJZ7EHWV9B/18Nl+lSxD35cNta?=
 =?us-ascii?Q?/H7JGtmmM0G+E2qSrROAo0BUeDGhIX7/CguGf4YIiX/aILpjOOb58Tc/LSCS?=
 =?us-ascii?Q?CyjVn4tE3tfezQFsaNlRMDNx1vkSSWDINwHZDacLjv4+m5Wh2rLm7QHOTip7?=
 =?us-ascii?Q?pRQTsTmp/qbM+AYKc+1UVvrMJw5Yh1iXYNdtrjAsIN0SFEZfqcaiBvF299dg?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a1d039-06e9-44b9-6da8-08dde709d970
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:39:24.8584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6gKiK7+fJ53iBW3Ob1sHwzbimbXYd/k9CHz6RXkzzvEXM4VZf+Mr2TSlW1O+McLGegQwHTrae4whMKoehsdLRky5rohOCRCePkm8VK48EY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4563
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

On Wed, Jul 23, 2025 at 05:19:58PM +0100, Bruce Richardson wrote:
> The ultimate of this patchset is to make it easier to run on systems
> with large numbers of cores, by simplifying the process of using core
> numbers >RTE_MAX_LCORE. The new EAL args "--lcores-remapped", also
> shortened to just "-L", and "--lcoreid-base", are added to DPDK to
> support this. However, in order to enable the addition of these new
> flags, the first 10 patches of this set do cleanups, for reasons
> explained below.
> 
> When processing cmdline arguments in DPDK, we always do so with very
> little context. So, for example, when processing the "-l" flag, we have
> no idea whether there will be later a --proc-type=secondary flag. We
> have all sorts of post-arg-processing checks in place to try and catch
> these scenarios.
> 
> To improve this situation, this patchset tries to simplify the handling
> of argument processing, by explicitly doing an initial pass to collate
> all arguments into a structure. Thereafter, the actual arg parsing is
> done in a fixed order, meaning that e.g. when processing the
> --main-lcore flag, we have already processed the service core flags. We
> also can far quicker and easier check for conflicting options, since
> they can all be checked for NULL/non-NULL in the arg structure
> immediately after the struct has been populated.
> 
> To do the initial argument gathering, this RFC uses the existing
> argparse library in DPDK. With recent changes, and a few additional
> patches at the start of this set, this library now meets our needs for
> EAL argument parsing and allows us to not need to do direct getopt
> argument processing inside EAL at all.
> 
> An additional benefit of this work is that the argument parsing for EAL
> is much more centralised into common options and the options list file.
> This single list with ifdefs makes it clear to the viewer what options
> are common across OS's, vs what are unix-only or linux-only.
> 
> Once the cleanup and rework is done, adding the new options for
> remapping cores becomes a lot simpler, since we can very easily check
> for scenarios like multi-process and handle those appropriately.
> 
> V7:
> * expand the scope of the patchset beyond just cleanup to add in the
>   extra 3 patches for -L and --lcoreid-base option.
> 
Recheck-request: rebase=main, iol-abi-testing
