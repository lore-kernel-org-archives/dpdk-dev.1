Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E11AC98321
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 12:15:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 152C0402D9;
	Fri, 25 Sep 2026 14:15:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id D546740294
 for <dev@dpdk.org>; Fri, 25 Sep 2026 14:15:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790338530; x=1821874530;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=WYbB+zGJiJWjIOpuysMYaMWFf2goZXS9sCGI8INZ298=;
 b=m1Fb8I7ISON0F9iv8nqS/3ojATsyJNZMU7JOJ7xFNdDoRHCT42rgOPIn
 3S8sjbJei3W1drRL3/aoxSC7ffNx/ZBB07DYvUNhFx1lNHWUq0nv2/KHZ
 6euwumafElqXwMqy4/pPbvrDnLhYre3BTRjA5oc/3bSTsYOwFdUvmiji/
 XAVFS9ZZbVwzcd9HgAfEf1c19PCVfmpIYwK88d9DcpMeFGxKwvFvH55RF
 Lt47jnS0l/Ao8OfH2wiL040YgnqL778JNFNjIU7J6obYyhkez2jC6Yqzt
 u7GwnfEMiqjoSJ9KttUAalkLEOZAcb8TWYHEp9kCAM1UZPoxD7IIAAxkm A==;
X-CSE-ConnectionGUID: 32IAx4kNQkqqn10GfFFNAw==
X-CSE-MsgGUID: 8jCDGcWrQwiCGZwvIxaGeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90250027"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="90250027"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 05:15:29 -0700
X-CSE-ConnectionGUID: egNpG53SR8KzrgTL0PsOag==
X-CSE-MsgGUID: +MhL2sfoQ9CixobtZ0kQ7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="302274291"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 05:15:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 05:15:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 05:15:28 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 05:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8SRKBzblsRgQItd0LOactrkCH3wAS6NREVszwDJ5Rq5oeW+U5iGrFWsbiditG0d64Lw2atlSm34DJMF3wIgnXA+lLpCHePIzmCreFUxuP83IhN2Gus94m5b9WUcteCI3gYczqfibS+rWJ11eLGgQUL+CWw0xxaqXRAeKQk7o5v6l71Xe9mfLVHEirBKyTgAP2izxKnZwA7Cx9pGPLHX0K4Vf3Q4HT/GVvdXh8ZVD9UmSXCVZPPZ7t4l3kBwGAyV8Qb2oyzUkBQZ+Bue4GiGA4k1ZITcRlBHCv3fBxI5lszQPX6b35UuNQAmklEuPsIuRgfwEwtJ2pkzl2UWREcAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4vISPVTM0FXvERyuVp77+VhR6CGxpKMiwFGwQdUfJ8=;
 b=i2/KhhgqRadJWTNn3nNmY5RqlGvReUmGvHWV2n0XNiGWXuf5JjEw6E8bRzzJXgal5POtjxdQ9et7fb9z+yZuTiv4Ux9ndT6b6qlBwNHvhRafv2h7kXfKRgntOw2OLf4rGc7Hpf25l3eypbBMtQ+Olc1V01k7JKiZzTg6t9fTaFYKfcJEAa/hBUeiJ4lmG3efnvZPOvqK4ob1GkDjOrG2P/KXhIgkLu4OC83LjfuFePS0742pbva3BxkAvgPaThp91ejd8+/wr2d7sMj6UaRK0kO59Bcb9NKM2wHtQFFa0QqIqbgg+dvCrKdSPeUCBKtHleHP/MHjatG6W7k6sQg7JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LV8PR11MB8462.namprd11.prod.outlook.com (2603:10b6:408:1e8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 12:15:24 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.018; Fri, 25 Sep 2026
 12:15:23 +0000
Date: Fri, 25 Sep 2026 13:15:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH 0/2] net/ice: updates for link speed setting
Message-ID: <arZl1k_QBqcUUorG@bricha3-mobl1.ger.corp.intel.com>
References: <20260910150817.1521317-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260910150817.1521317-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::9) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LV8PR11MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 562f2419-122a-4f4b-5230-08df1afeacd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Bd4dCC8tijbxGVeKKBMdYzclsArLgAgj1hfQW5EuMOQR6d9WXpGSv3CjBx6WFUE17EpYwOnyiR29LEkF7pLaZ4Ath2XNXelqqtjN5zEZNmOkTESZ16XgFPhdSAAG1SXifX7Lgieax/TDh4TDgEbJX/tBo7i4uRF1IkSHn0CCPUiD7Z4122x/Yu8n2WxarKQSo9aNRkM0F0XbkKZexSivktid9XhagBuoghZXu7CnAYkSRWy4Nq/mYaGWS/OnkQ/Fuyb9znXWpZq1e+JvsrF29KUXCAWu18Bq7hpIYadcWOgalwQPpeiwrwnxsyHX7hOzyBlkX2IFF2naxUtGabDY5yQozgR4X9mNf+qVfMTsc9F+7BArh24uEPBHzm+Q/gu8EZC4KTegRyHSvJ2cMdOP8187mkAwGQdNdz1tc3qk6lBz2dy3Jyy0mfdhcOdtl8KB/DBDms4C8BW6ZKCJ81PjY9WnGOs+QO6c0Uw9JMtH3N8XYSZqi7hDhaqqmq0sXfB/hGBUoozpqpVifxtKv/lpbtiA9QgRO2fftgmSFdFKj1pmheGu2nNcR4gjtRSDOrLcdEylxJsHjjWGvFOnslsUDKEMD7y8A1kQQtlnxQT++S4w/krncGsYIHvhOc88HvQmka4FMe3kbeqvSRhesQdGU+3oKssMbTd8XorWzYThy+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A9/V5GgLXachCQPlDRWOzQD32/fDs/KZxEJmdJGJ/R4bIbPEm0uvnob9hYmD?=
 =?us-ascii?Q?dWecAz/zDW2zCCh9UckUOosBAyvlzlkNBL6c7zcG9OdmZLO7E22LJPO6PRQg?=
 =?us-ascii?Q?pVMIDD7TS8bSmI7b3XD+7vf+7geyP4ErDK7dLs/CKEg5AZykB80xYZvtkFjo?=
 =?us-ascii?Q?c++h6Ud690TbGmMaYYLDE5mItIlwQEdPhmqaLYL66AXdLbrqYmxRpfogZ/nK?=
 =?us-ascii?Q?LLilSBOzBW9JADGvp1Q6V5z/jJdg4GuZv30G6V5nX/1OB2PGVEikBgmJKwVa?=
 =?us-ascii?Q?XccW5YGSrE1liIVrkLP/S3nfvVU7tgvjXenpv91VeYG9XBnglSN7kwgmUgGJ?=
 =?us-ascii?Q?UKZ/LSoaBWDSnBqB4sZFvxEP948LHtlffBIr1hpsDw2zGleeR3xlxnIl3O23?=
 =?us-ascii?Q?Fbid7YH/vj8JLudJTVrpFTlHp81LeN1qBGSIIJDm9c0qTZPOsPLHWlPfWWoA?=
 =?us-ascii?Q?kUgjoJFdgbUsLA0o1YwCl2KrwQchh7mBbCW+HxUlLnGltqBcLURqiLbZPcMn?=
 =?us-ascii?Q?ruhchpbkBLGuF1DLMXljJi764PE1mR26MRwIxyYDijhUnfQ/TxkhmEjT9WGK?=
 =?us-ascii?Q?7WLYGsKuuPwnqED2BPOuYkScPYRfvXWxRpSHAo7Mb8TACKh/JSwrZoj0zmHK?=
 =?us-ascii?Q?Nilvg7qkL+a8p9SN9k1aMHWHl7NBNUjXoDTFB5zLF6ZiuM5e82cZelHXNZhG?=
 =?us-ascii?Q?Muija8PqNiqDZFHlkoaH61WbBMdFKvslnTAkkXtXstcrs6zpvB9bJJsxXPU/?=
 =?us-ascii?Q?hfVCmL9lRUzuoPIMyRZ/ZpsCsGxwmBnYOzLa1VCm7G73qRPIuTSyn73PctTS?=
 =?us-ascii?Q?eao4J9ErgapUhPr3JfWSYVMHZ9+bHLqDzU6B/HSDxLV3Jy3koQ7TvxqZl/3d?=
 =?us-ascii?Q?zThZGVxtj281nGzGHfB4DTo61GDhkGWfpnGv+M0XU9cAqMhDpLhtfFLa21rQ?=
 =?us-ascii?Q?b+LxWFGIplZn4YQkbnuC3yHNlsuFxSDOz/dLrBBLvGbhH6CmKXX+CVrQSu3J?=
 =?us-ascii?Q?hPDvDLyJ4YUKo2aQO1DZw/BzOkF9ERH+8VK4tEJviwN5KKnwEM8PwwH0wsSR?=
 =?us-ascii?Q?8HXkW8UKx64JmbiLGvACff7PFtzhhks4TiaqywfD1oIwCXD8W+RTtPahcUEz?=
 =?us-ascii?Q?P/VDGtGeF2y6LCdi1t5F6t1m/kGo5DGUnYO4A3j7M4BDTrDbqNUjo3Zf9cjO?=
 =?us-ascii?Q?oVl80kSPJxAuGRPMc6VOaMG12cqILH/o+AXyn+JIkS/FS3lV3XBFLLNwi9HZ?=
 =?us-ascii?Q?S87DH4d06qedAIsch2cqyAk1VkY2hXBjDyRVug6WtxGfcg2Qr9FsV8wAVaxY?=
 =?us-ascii?Q?NsZJ8xjJDtldkBm1jU0BVUk+HAH9P+a1jvxbie26h29xPwEjDNR8+w5b3mKn?=
 =?us-ascii?Q?wBm+x70oBDOWxqwNdfv4MxtTVD4eAI8q5tcVdqaiTL9Vune/mKlnNv1xhDhe?=
 =?us-ascii?Q?L9/lArrVkrMIQczvNplS7yKwNGQxB+OP80nt/2FXqpvx4mBEE+LxhRkZkeKR?=
 =?us-ascii?Q?jRt3oZ+azUaH3x2Gb9+rMMtj0D0lxrkil2PdkKJHDBCwVf82japkY0KdnwNp?=
 =?us-ascii?Q?gPPfGTURwKwy8XFP7Nltp5G9C63obBpDZyzXLWFI6HxW7q7Ejs/bliQY5mDG?=
 =?us-ascii?Q?p83/cTOrj5xVNyRGh1dQntsmOZYfLHM6r0sSTcLLph8ZWsMbcu02MQJ6kCse?=
 =?us-ascii?Q?ixHbHmwaaLQQ1S1eN0Yp6670wiIkM8a09VcpNDAhzeDK1xDPwawn+WDFCZ9G?=
 =?us-ascii?Q?cW0IAPvf9JX7hzssI3TzRHWWfz697uw=3D?=
X-Exchange-RoutingPolicyChecked: AMv0KevueJHbiy9jyYFyQTdnPDnWsdgXI8WT8ZMtAfRL5BeS94foLurgkQ9QnPruSqV2q2bixtMx9RaLtBvVN7Og0BmRB64aavm/GJmOwkIQLsqZWaNyVCK2XuR9mgszgVxP95NYPwY7vyYdnNzZSj1g890rkjGhjiV+cJMTXRQqePQs3JSodR5Xh75ECAV3PP9XHc3wXqOSMdIQVcO0zXYEKhgbWFB+I0gwzzMrmHVQ/ZGkBYLHJBmM72A4z8FC4C0VApCk4vnRduD+ECzCZ8RyGypmMRh6MtUDAcoqYl7+m9LmNSgNrdVvnjKNvWXBaTSU7hpnHgQSaQVFgwYprw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 562f2419-122a-4f4b-5230-08df1afeacd2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:15:23.6246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCsBQYi8DJYOFk9LagRk2TgfK5UcuO1e7Ml2I5TQAMMBqxt7+P/m5W1FD7mGAdZfv3uVP3JJWr706Kv+LzUHwuQpACE9m8FkANApp3k3utU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8462
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

On Thu, Sep 10, 2026 at 04:08:15PM +0100, Bruce Richardson wrote:
> A pair of patches to improve the setting of link speeds for ice
> 
> Bruce Richardson (2):
>   net/ice: check for missing fixed speed setting
>   net/ice: disable link negotiation for fixed speed selection
> 
>  drivers/net/intel/ice/ice_ethdev.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
Applied to dpdk-next-net-intel.

/Bruce
