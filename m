Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40483CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 17:41:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DEE3402DD;
	Tue,  4 Nov 2025 18:41:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 644C2402B6
 for <dev@dpdk.org>; Tue,  4 Nov 2025 18:41:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762278086; x=1793814086;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6fGg0ESSHQNgppkx7/CQ6iufbhK/1EE5Yg0XLxJNPNQ=;
 b=HqumIDuzklVn01nUkmFPntePp9zzfZB3wdyeMdxFWrAaVs5hFtu8ByHs
 D46drBsPE8wlujk5LSpx+ZX+d/p9uQojQoH2EX6ctE4lVATSqPY0YcvP6
 HOIt8DeIqh2X/ozwC2qNLZvWfGFHAx5TUBPUcspwAyf6qZb36rQAOylGt
 EBeRWmuyzGWk5QrkOBQic6c5XDBeO7ftIYFAeybM5x0AmxOnLbg7FNtiR
 I/1yEyuEZqbc24QP+W9XQilH+tNBilnEupn5aIuquOYJ4tH4WDRCV8pmR
 N7XQyUgVy6kfl5tMgdmHcvS+ZhUbJvtcukgNlSDTJVrrxJXbAG7MZBeCA w==;
X-CSE-ConnectionGUID: t06g8Ok5RkObw7sLKnVY+Q==
X-CSE-MsgGUID: /hbHEEcpSR+jfBv1dmpmxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64077488"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="64077488"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 09:41:24 -0800
X-CSE-ConnectionGUID: v85f0XViQu2Mb9qayMp+Kw==
X-CSE-MsgGUID: mgw9khVHTbmlrWYTHN2z5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="187665824"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 09:41:23 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 09:41:23 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 09:41:23 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 09:41:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddmg5C2R1lzffM8Dvpu7mTpnmSCma3EHCbxL5Rf5w6Ub7ilYox5RB8SkBrXmHQ47PQ97hI7F0PGwWprmBsJZC3FfSHDytxOC9GjEVUh6+HZFaa6VDH/PxwLuYnK67JsPWtqC/2cIEI0bzkFRvSyFASFw5p66yX6Hm9yTRLSRzPd9Mspy5CI1eo5FJ3fgo5ZrhkGbate6Q/zBvxRb/QWEOqEAnP80U8tXL6BzH2kiVV/HnbKDteLQQ1a56TSsxJ0aGFaM4edcx7QM8sSV51SRl3Vbuy0E9ZiqFLE6/d8ojB6OQUJ5oqdCVJyQbI6fxfvdoIt+kfxv615q/ggmqJnzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJsyDlgWK/eCF+mK1D3HFv6poNzOpwByDUWE5SeEi9g=;
 b=V+eQ5U2SVZH7BqI18asiugSgQh1ye8bcpKVcFMPGLBisg2HIAS+1F4EluHw/DMxAqr+AXeGKeHiiUvQMOn/xB80ZeUwreO7dwJxRDSwHCYKKorzTLCFy4rDBKwkUf/isf25tDnFbRZFPPt9UoO7rz/Qc/5gNaMbnl34nB2Yv8eqBct8bBUabIjGNfZUGS0lXu4Sr5icXE4WGsIuOUvS5ErzogNSySG+vF/jRzz/9QDVwZ9sKMPDF8oDPrB4+RuWwFiMvKvAcgK3sYkjzKdf9XhAR2bCZ/bSg3PA3AgJqtUtcdoqwlIkfThDHNEIbakLkzU3+zpQbMf1brsnSAdmoUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6440.namprd11.prod.outlook.com (2603:10b6:930:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:41:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 17:41:20 +0000
Date: Tue, 4 Nov 2025 17:41:14 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v2] net/ixgbe: add E610 NIC speed support
Message-ID: <aQo6uihGdpCzPqSq@bricha3-mobl1.ger.corp.intel.com>
References: <20251103133804.585506-1-shaiq.wani@intel.com>
 <20251104150113.729184-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251104150113.729184-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU2P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b1e70d-dd77-4f5c-32d8-08de1bc95d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4nnCUCPhphiuTLJBzlv2449967BJc0268+ERUbFUL/KbD9vVfxHXGg0GrYzR?=
 =?us-ascii?Q?XVwjnWF/2eM71z79kOYxoc5bMy1O69j5GmgCfPPRegPjmzchwnQSK3tATKxo?=
 =?us-ascii?Q?YvliTvH7C9ETfDR31tcQjCsA0a1jTmJB7to013Qs/PSXqstc5/yNjNYUaqdr?=
 =?us-ascii?Q?e6yrMRY5opvOCRP0lEOLlZJ9XPWjMofXtlZu7dk58qSUgvTFiZwnQnmssaEs?=
 =?us-ascii?Q?Q0gujqPWP5iSnXalYyfXcpFOvkUhl2gGHsLghjvfYdeXnTZXSUvatP32bTMS?=
 =?us-ascii?Q?8Mz2vepyv8xvHtNTZPgxvKS4dT0bTJZ3Tfgrfy/D9FB2X/ied5p2nHOgtpwL?=
 =?us-ascii?Q?urrS7kAF8S0VB2tlu5gzTxKDD9WwAFdS5csYtH61QzqqxL+8PGqleGz77uDZ?=
 =?us-ascii?Q?HZOCInez41cFzW/sFzKK0fuL5I4nfkg4y1RBf9aI/uNDp/HwSNIgswpN7lS7?=
 =?us-ascii?Q?+yUVmlhNS47CE5C1+M65jXEqGB9XHu+IhacauafCBiF8Q4kKU3UP5OMR1ZLV?=
 =?us-ascii?Q?4eu7X8L152xFs8SC8r5mxhSWjr4TQBS9hkK44r89IdzLnYudtYb/fQl9azHG?=
 =?us-ascii?Q?opSfCBcjpydGgPPamdzVKiTcTe61Z3cer7aw3KxOun6yjFSxzpm0T8fdAJXK?=
 =?us-ascii?Q?fr51R1aVB5346ahSLsmkpM2Oln6Xo9ymW7i3SlNmbAIgYrR6+rgm1v4y2TJ3?=
 =?us-ascii?Q?cDTSTuPRAx0CjTqoSWH7iAb4XU/QsDLdAVCPVPrhEOaJ4+klwsghd/kxh7tc?=
 =?us-ascii?Q?m9nAVYufl+wlHefM/yh4sOy62PN5cFpTdOTcx82duoPEDIyG5RKUUUUs5Hu1?=
 =?us-ascii?Q?24qBHyjcwPCgQrzzCWf/irdoF5wA60WC3B+xvLZMxioi9NSq+6gcI2E0uAdq?=
 =?us-ascii?Q?TBP9t6yVgJq4pUwP2Blzkm/gom8Jz24CCBBw2wBFPVWqRziBoRtF+vM3ZXuJ?=
 =?us-ascii?Q?ifkJ74LMrdkSdI574Ynf9ajoFfjXE3Tpw+KeH4ru50JuZCZgbVWYOwa8PAdu?=
 =?us-ascii?Q?Y3163DAe08L9sPhmzk70bT1VT0LBRtWZD+g5NZ7o0SK00j76mPRS1ecZdxgt?=
 =?us-ascii?Q?ISBuvudAgc5BG2bKLG1y6ffXpt+jo3Kvr4mqDl7D4f+cyUqMyEbrgRBY2tsS?=
 =?us-ascii?Q?ES2frpTJngdnmtNlEzCD3enEV2BMPYSygII2cdic82gBHbUmz1pQ95DiyjWh?=
 =?us-ascii?Q?YDWker7bHdlcw7bnrbFQF8lIWK1koIwq/jFc5iuxhx3Gbj96Y7HuJM5SuZyO?=
 =?us-ascii?Q?rqSqDjxEZFMZuiNiGmre6LvLIG87GU+lBoQaZgYF9jhaM2kXs0iKYVgLetkQ?=
 =?us-ascii?Q?nwLsCU1UQ1homcn8q0C29kbEnePhSp2wusN1A3StZ/cu2vaZWlGGsULILrJp?=
 =?us-ascii?Q?63bPc6L3TjzxVejrJnF4ETraCdzt25p4/ohW+1Q1oy8ZL3bM+Cfn5uonHipG?=
 =?us-ascii?Q?W7vctOVlOhwJOjg6NWB6HkWquc/TGhYc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4YY5ksuxycTktWihblRqyBehB75VPf6phBpNxSpkxjbpzOW0RUuu+/7+WuET?=
 =?us-ascii?Q?4n5n6949XRTVpCevNgdELM7B3UkkmP5JrC0lPsPqo9DjgJAQF+sTl5gbI4Dq?=
 =?us-ascii?Q?K9CDArEHe7RHtUqZC5QK07XNQDovICNMvEdW/zNAD4DvWa2CclzQ4QtHnxCX?=
 =?us-ascii?Q?UYm9OhzKgKtBPPP1VTqL0YVVZ8IaqTTGz3NZ+3FHmLXvNp4+aIIj6ix1qOGg?=
 =?us-ascii?Q?HTueXDxZl4liJWePjdWaLxT/D1+R4D9FVCWFasieoNV59e08Vqjs2QKtvdnu?=
 =?us-ascii?Q?wrMCpv0ZzSbIF7YThRaFpGUpzCqJSNF4FLq/vwJlIwRm9N0dQtKx5J13E4FH?=
 =?us-ascii?Q?T36QcI+jgPWoFHgwcT5gOv9nizxof6Wbsih/i45LbHqpQ6EJkS/jfSLwNnQL?=
 =?us-ascii?Q?oBobmvUgZkg5h6KegwjSsYFi0m8bv25lJHA3+jvA3niHTPBOpIU+Jw2cluZ9?=
 =?us-ascii?Q?wQSXCjzW2sZxmlUN15dF/Y14R558WF53Kt03lZ4PbJIBusq8CREKXsUrMEdy?=
 =?us-ascii?Q?2tTcXBTGkpbNfsFgASMZehZNjwXTylW7nL3FZ/Szm703apkPf3KKcPiyGN6b?=
 =?us-ascii?Q?4Dy4ri58hdkwfGkwM586VhBbHXrlpoSoQowesd9nn96g8qI8g1NJgSJzsJeo?=
 =?us-ascii?Q?Yl0BFf8vyOyqYr+s7SyFNE+y6t9nMj+gtHW8/k34LSiMERfhzAA/nG8wuYy8?=
 =?us-ascii?Q?oc99ug3G3vOT9VvWAncp1eE2Y+XfO1NXaS3I3gt7kdhlmZdN4heFFGo680QM?=
 =?us-ascii?Q?VqwI372xnG5LlQ7aFnZHqXhoxwy1y5vswUr9rVzXxut/2dkKoI9FIUT2w4qE?=
 =?us-ascii?Q?jpGXtq/Qk4365/LbclLitX+E08fahDy/Mo1LR2VSHzN8MSJduGt0qVgldxAd?=
 =?us-ascii?Q?u/SKqyLfzwOjq2kEYq+VGvIQziBd9aqQ5StrfXE+Fm0CnOjhTUrNChaUe90y?=
 =?us-ascii?Q?AOryQQXMQszewWe/T2LylNY7Tbf2lBA0QKojW8wEHp9WpLsQK2ittD+1j979?=
 =?us-ascii?Q?ys7sb2eCZqrjzoFWr0OFUhOt4oSeFW9aU9aFOcYZlMPsmi/IVnqoVsG2ltUF?=
 =?us-ascii?Q?l7NkgaHXwYdc9nCPJyK2Q7VtirB0PzfVwTHRkY8gmAjImhZPK/Sq/3hWrQgs?=
 =?us-ascii?Q?zhsUytz7rDVWhMZ6Op6Ijw+1ClWEcphlfVBKFvh+RibEM65Z4oAQaFeVRc+n?=
 =?us-ascii?Q?r9702zbdahCfDGtBD5eFopuphJE2D+uwoG450n5Qrpby7q2QkPm0xs1ftQZo?=
 =?us-ascii?Q?+KLdBtEMk40klPC8QUtzMTl/405XteNlkLiB2QGnFEGI8Hzd+x1eGYiMeibA?=
 =?us-ascii?Q?73fBENlBgmbbKqmi/UvQ3G1S91TgviAYREDFiWqaXByXJvgbXPF+ubq0obZL?=
 =?us-ascii?Q?Vcc/oFJZol+szToYAuhJZsOynfVVYC8qCktWEef2QE9QSU6roT8vQVpJuJ29?=
 =?us-ascii?Q?NIkEDW5WS7EmQDIszj/jGB45qzQiq4qf90iZct4ADnl9tRiapbRlSH8XN7hP?=
 =?us-ascii?Q?le0PoixXPWNNuPqt590jO44TrqbWVlkeGUdjMwkd9laTh70IJIFNMizRCuJ4?=
 =?us-ascii?Q?0cVDimGU8mrA3EIU8am61UFgI2ggrNuSt/PgjqKAsSxbDRRcRzE2qbf3pN4d?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b1e70d-dd77-4f5c-32d8-08de1bc95d21
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:41:20.0507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/vU2VOGfkk2KBhHum4+Hf+SXcj9xD9Jz1I93Xqd4d5c6ZOSal6S7cwsI8eaanEVUq55YSyQkYdLtLUjXi1thKwgVJnhY3OrlLdkaJW1ZMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6440
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

On Tue, Nov 04, 2025 at 08:31:13PM +0530, Shaiq Wani wrote:
> Added a switch case for the E610 NIC adapter to set all supported link
> speeds (100M, 1G, 2.5G, 5G, 10G) in the ixgbe driver.
> Previously, E610 was not explicitly handled.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to next-net-intel.

Thanks,
/Bruce
