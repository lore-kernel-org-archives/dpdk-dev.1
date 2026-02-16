Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4209AE81A56
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:10:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E75640296;
	Mon, 16 Feb 2026 18:10:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1F1F140289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:10:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771261802; x=1802797802;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qGQ7MBaKtPyolcNpsU92kUVtAcchHB4opVx3Y8xD1pQ=;
 b=Zkz+y0Wrrr5sE27rvdXrfpbo17rjSEY+BlZ4p5eqRtmhh/z4DXQO26+U
 oE76wr48mDvGjwIVXEAYUmoBfPsVYSDed4V3QET4XuafXXJlvNfFrGIms
 fHodEiLRSC5MX0lvfAUhr6r2B2zKfUfENfReKY0wnOqjSABNl8iYqlkIQ
 M5NzK5YQZJKojTi1q701DiL/yFpbewSteWkVnR3F7jffKOi9QWLdF3GdQ
 XjRdDtfNiCutiLCsAwDngyewDgtRGjowybs2IhtW8rZctkgBEOi1ElGMH
 8ZnnfD7V9FkuTVbunEYZuJBZzvwMfC+tX8SntnZ+dTzGVdbeZDu3gzpVH w==;
X-CSE-ConnectionGUID: 8t2o7LTJSFG9A55YHm5/3g==
X-CSE-MsgGUID: ipF0+CJlRmCINkWl7xN2vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83708996"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="83708996"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:10:01 -0800
X-CSE-ConnectionGUID: 1BZk+1LRT4SsF5F+HJPXpw==
X-CSE-MsgGUID: l4urdSpiQbmfq6NGSmIuVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="251337715"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:10:01 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:10:00 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:10:00 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:10:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7njbM5uvLSdStsIXmWe6cK5vJtgjGddcwyAf7v2l6DjzcGanRAfSkffzNu+QyTyHtJy3/s6kQhubG8DxEYMY/Cx3fkWzpdF+LqO9ZjsuF6QPlegKHAAiMtXX9NT1UEDZGFVAIaEb7ltROiMgiCIQNvoS2uMXK0U+HwV7Gg25inzmZz0pmw3Eknf9/wM4BbZrgeEZsASS7A7sE9GB9W/Zt/oUZdi82F2hBMM8dWps2QE8+UKonBfJrsmojQbUiDjuRG6PF5h8jKth7VgRpHCWje7KX47/56ZcGc2eEKIpMGaLDIDr8tnnDhIHhlvC2JCU7iDdjMPdPpBw42tFnxfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTHgVA7YEJ1lSQh6cyabpMwIRBmKWHZfL1KOxUotPXM=;
 b=KgvbM+3IrHamSs1xQuSeywftGiD6BAkr/nLRKyPLqTssc05XxD9dtXKZbEBR2U4XyyaBFZF2GpeLBt4mUgSPLSkchUlbEESnuqxwf0owOy9MN1PV5tkc6OP9P7qUeba+y4hTz0fXfZvIiesfEoNNHbJmfZQrvptZGx7U0Z6yuBNbxrzSUpRMW8Z3yqSmkM1VTbzaMYNgMJcV0/zJpJYtCdxGPr3yVnnOt5gdKXaUjaF7YR4a7lc9pX9VlebI5w2FtQRupGtYDrjNKU6SF7PgI48NE5/VD3M5R19Of2I39kjzdpApjt0gwXi1nffSLSyK3ZHibxV/ne/D4CFTsCMiZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB4623.namprd11.prod.outlook.com (2603:10b6:806:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Mon, 16 Feb
 2026 17:09:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:09:58 +0000
Date: Mon, 16 Feb 2026 17:09:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 12/27] net/i40e: avoid rte malloc in VF resource queries
Message-ID: <aZNPYmfqFwJMK1b1@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
 <506b85c8822496fa6f1628834a353975ffc71302.1770817884.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <506b85c8822496fa6f1628834a353975ffc71302.1770817884.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB4623:EE_
X-MS-Office365-Filtering-Correlation-Id: 22519e9f-d56a-4260-b546-08de6d7e36e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o0HftMPXA9trgkb2bF8Ali1jrDHoLO3HwXIzUVLrN4ypVJRTDHBZEtEtqRop?=
 =?us-ascii?Q?qKQJXhaOQwG3tPMascX08n2i3Bh44YhBNVKcygtChKB26ZSAzZxd5GgkQqWs?=
 =?us-ascii?Q?PtHv+aCZT6zXsLDV/yf57gE8KaSyBHk1ZRxA1co4wcVMbj36WQauC6s+HqnH?=
 =?us-ascii?Q?xeKWrzoCvL8VJ/uJUDXSowODC36A0JhsPjhWhqKW9PiRJnV0bEvf+Sri+JBh?=
 =?us-ascii?Q?fJ1nAO6xTitO45fFpA8q8bGr5IC9orEQf5esRopXXNlM2BhQuBcpAYcAIv/Z?=
 =?us-ascii?Q?bVuyv7wnUgGG9zQvGfMxBy1nIsDZnFk6S/j6dV1hQV2Zhb/I4Tg3X1d+/tC9?=
 =?us-ascii?Q?rnR5tLQ8MntoWbzO7JRUx1o/di5Ao80Z4TbDTTSKUj0IwKusf6xXv62rlZbe?=
 =?us-ascii?Q?obx29rxe/o3AQ4zKr0T9eQN0d8qg83TV0XIvINqaYqhRSYpSNki/0Spiddvt?=
 =?us-ascii?Q?lHU5bdHYxU8E7BOy6o2pI+Laf4ALxSI27MFI/+kOaOgeFPh4FS+6q1cr6XLR?=
 =?us-ascii?Q?AlBt+j7P8k66TeUTvhcojDXnjAUSTK/Hfht0xSxvIboSOZr11+3i3LOO0z35?=
 =?us-ascii?Q?T8H4QJtVDZNumOE15wIsfHg2bLblvzZF5tTgYZFUrPgd7UXHwf3ikGEFgLNz?=
 =?us-ascii?Q?2I+aZZap6OIgfGADLTgFLfebzjpzPVWu/3ZGPGaAcdm1eTE+kV26VpiTcKQl?=
 =?us-ascii?Q?5VKmCjA5FR1KctysNC22axgA5MmBTiKZ5Km3aRRfqjayKOE5k4+j+V1JCZKf?=
 =?us-ascii?Q?3WDOWdknCYLumi/dRMOadZ/xSAyz4liK7yEBW6h7jjObGMEaZAs+ES5YI0Bp?=
 =?us-ascii?Q?O6wry8okv+kO2e8UGadxiLj0L8bO2399O/OSYHyNZa8uq1rlUioA9pCdMQJK?=
 =?us-ascii?Q?UPG7UiDTuf/IY2yoFe+MNe0a069xbPjCSq8ehG520G8BkUe1IQANWS0fLQgX?=
 =?us-ascii?Q?55eQ8g+LRIRQj63phaIP2NBAFQDPXDmXCmHX2ykN5zGpfLQWYKxuEIph8Djb?=
 =?us-ascii?Q?5NmsrhLd2tSZJKkGiG+aWvUzNVk8m5lUfkas23j0UyqcNP/NVyQYUeS34ZVc?=
 =?us-ascii?Q?6mAl4RYIybLUTfYsHMrcjU6KaTyIDFn1VhdPmfMlsZmLjUOPUoiXBCEk57/z?=
 =?us-ascii?Q?78qz+w8e3T1g3n7zqHzNriwjnTmEpjtlyMqCQXwqHu3AVWdfF73xrXFV6o5H?=
 =?us-ascii?Q?Nez9irX3W/JpwmqB5J2saMkIILhFC3hYe4YcCycMIh8zw34319CMj7wuhDbX?=
 =?us-ascii?Q?jYfKLyA+6B2rAXPQBkYUUYjNl6mcMYVZ0f+Yv/1Lov6PoWFNDAj8uBcLls59?=
 =?us-ascii?Q?YBI68fjrdNpX5l92ioYX4lJaNvI0DEkvVHVQHq6SXCNOQFNf6NJyjr5kT6IE?=
 =?us-ascii?Q?lDAFHg6Q3cWjZNa/qADoCYbIkE9g7KR6GQoSepJvv8Rv+SfjJaRcEQjoxYh4?=
 =?us-ascii?Q?jPhrAnKaqVsDPhAwMk+dcd2CSq4Jl+0wbOq3++AHCJvns6eC63NBxoNdTBTE?=
 =?us-ascii?Q?lg7+6L/RU9c2CS6p76U95AyquXS59nDwa1fH1mhf5uxUCP5nB7UZircs0jk+?=
 =?us-ascii?Q?MbuTe5NrWMsQc/CIXKw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N09F2NPI2QieXbKAcXMV1fQBx3BvIy9lGfuEkJO1qiX8OwOkEF2TPCfnrc4Y?=
 =?us-ascii?Q?F+gL7Yx05VRB8zkP98FguKelihpYjj9IUfn9B4nm+zIiCFohMeBuej00wRDt?=
 =?us-ascii?Q?mwzrolPYCb15sNjRyHilloO0XLMIRFBCtdgNgYw0lHueM38ODFdkXCu1T6+x?=
 =?us-ascii?Q?xHJUWWUw9sA/a861Y8TMXazJmEv6oRvWYdKiriV14q1c+5kdW5CRGZr3eUwX?=
 =?us-ascii?Q?TWC+yb5tug2qdxACq5vem8tLGFAWCTsDriAqhfoBFaRBAORo1Idj0urp9f4b?=
 =?us-ascii?Q?E7gq4k/3sU0FUKPKjcDGlgZ7rSrauYdC0D1RQaThAip6ltG3P3/dcTIcTjhX?=
 =?us-ascii?Q?ARPg6Ol624mOSz2kBcgeFh2TD0UZYO9pfcQH9R238t7IS1yVsF0MIdFTMWso?=
 =?us-ascii?Q?VOan6Oh8GpIDI5Jlg4nNvAfh6Gpfzr7HYeds9inHp3digSPYjeNXhFR6Apuj?=
 =?us-ascii?Q?7vem6VkjKaJ1RsWXgIcTJRs5RuT/iV9JR5xWVYsF8FwbilLg8CilbsJBYB0H?=
 =?us-ascii?Q?o0GVsn2FSHbcMDNOj5HKEFsXiEN8Pd1LszUdASiuuiknbL8lMotR9hKVc6lL?=
 =?us-ascii?Q?9TjXaOp10lV/g0/fqXF5vDCang2GQZ8bJoEOfuDQkQBDKmLX1fTzJN5xAnUO?=
 =?us-ascii?Q?0MY26IB8QaGDWAhfhsgn6rm/H8Mve2Kq5MLYK1q90jq+MVqABmg+vCqVQ+YK?=
 =?us-ascii?Q?gvuQBQfW2bcKQnK38+7Y9cCi7ybB3+ZDjoeY4ih9qvcAR/FmhadfTjT3CNR8?=
 =?us-ascii?Q?+S4QldZZThd/mLK0D78UqXh2TXTF57zA4IR4m7BLOjrbka0kwfEE2fMo4JSE?=
 =?us-ascii?Q?6IgMrIzt/Ok9Y9GwAvWsUT4Yvn/7qHS3IONXgiM0TeH31mKa34mBhiLEFNzM?=
 =?us-ascii?Q?T7qV7frlt4HXZL4viqdXHt5eJ0qKEcIUeU3HMddFBsngNQVAS5PE4DPE4YZC?=
 =?us-ascii?Q?+MIIGruTwdhAcX6lMIpSn+2V+Of1bzEE8U4SoB3Tjntx2tFvVFj49Cc6bel0?=
 =?us-ascii?Q?B1drWvTICfRW9faGm+rC83RSLqGTYGhXaXqVZ6gJCNSx4O+dOVUpNvf50Mjq?=
 =?us-ascii?Q?pqu9stfE/K5R3BrIY2l1q2dejbVkvnjviK/JQI2XqQqA+uo9zhuTEnAofnD0?=
 =?us-ascii?Q?np6Qrggl8Xj5fYFtAppugjSMo1SB2KEYT4yHFkJT43Kfl1axbWbt6vAWhCa4?=
 =?us-ascii?Q?YNlFqgCZ5OFZy8ZEIlRxU87ipv6JJifdw23OgiUg2AWA0XqUE9H2/JtrrxOM?=
 =?us-ascii?Q?F+HychTlbSczpkWS/FccPt8TkgpmCWPTwNN25knd1PxDibvrd0eqGHA6vA4A?=
 =?us-ascii?Q?uS3d0q+tqc2weS5OudEbHKamSoRDNvoDTFGAjzCPWrDh6ayycM86s29mWTgZ?=
 =?us-ascii?Q?WFqhIve07H0yJ0z/S1LSQL5eDc37s07KvLwO43DjMv5b/uDinZBbVsGTt/8d?=
 =?us-ascii?Q?eYt1MWXmojb+6DNdeDnC6oT1PnFx4O7HY067dgarGWbnEFq7SoX3XsJjnyxB?=
 =?us-ascii?Q?JkVjzjdGqxIGkoE1gLV1yhqCqyS7PY/aNIAX4xg+5pNlV5mRTf3VdIjzbA6R?=
 =?us-ascii?Q?AI9RxM4LakdlpxGEFJqCzPqhhCe5e5CszHSzNkitshG7ykU7ZX1V2KzY/ySg?=
 =?us-ascii?Q?xRYj8eYvhvvbRm+ulHMd9lPbtY6GG/q+vDxGftGrFMXiIKpzRBOhqQlyo//q?=
 =?us-ascii?Q?3GsFCoctXmc9oV/a+wYPpRFpBRqyK9Xc2iUW40n6aZDReIJE5eJdOCHlRkGt?=
 =?us-ascii?Q?IJCVsbxWTgvgDXfgAyKupYAWYaZ9Tpg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22519e9f-d56a-4260-b546-08de6d7e36e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:09:58.8758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM3o0PBJzDsHtVrepXy8RfPOnyJwmVuhOiVhHKhipAIoH4ZkWxN/qcxTsQ4f7g95PY5F7lmU06nlL6LNFvNme6yucEljLXXkIkyosONqSOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4623
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

On Wed, Feb 11, 2026 at 01:52:54PM +0000, Anatoly Burakov wrote:
> Currently, when responding to VF resource queries, we are dynamically
> allocating a temporary buffer with rte_zmalloc followed by an immediate
> rte_free. This is not needed as the response is only used temporarily,
> so replace it with a stack-allocated structure (the allocation is fixed
> in size and pretty small).
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

