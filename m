Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48C3CCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 07:55:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B07B4021E;
	Mon, 13 Oct 2025 09:55:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 8D7EE4013F
 for <dev@dpdk.org>; Mon, 13 Oct 2025 09:55:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760342117; x=1791878117;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/kQCCxh7sXVj/6nrSHPuEzpZz+J4RYuJI6qD6tROh3o=;
 b=AxRZEkVVFYDwL/LkhwIEPlZx8NWRleYBNkcW+Sqzw5kGSOz2vpkcbMCP
 /yBtpFteh59LwaQyGY4uqWVxAz3m3ik81KPIfWN1iIMXKNIAND8RLI5Wr
 kn/pFibL3XHxpsccAI3WFvj/W3qGNvATC3yQY3/ZanFmwcy/EmaZ9kAaV
 /DTXVCWCR3K0OyTM4T0m+6hneusFxnN8kGlQ42ffrBBZYXjkTjyt5uZUY
 kp+ysLCKkiktrnJdbqfldWA6KKbTO3asS9nGJaxrOU1wi9od1D2EQP6eD
 wui8deY1AuK3uhdKLPreAxXYF9Ymlp0pWVGSscxZHATT6LaK3VRTegzJ9 A==;
X-CSE-ConnectionGUID: vtdfrBSwTqKLAT4aKc9s5Q==
X-CSE-MsgGUID: LfWLdNQJR4ChvQnUBGIyLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62389971"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62389971"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 00:55:16 -0700
X-CSE-ConnectionGUID: k/QJQpuUREuAXg03/e4ISQ==
X-CSE-MsgGUID: U/RmyIwJS+mwRw/OTu6GtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="181488645"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 00:55:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 00:55:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 00:55:16 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 00:55:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaapuM+Eb178PF8uhT3IEQOUgKhVhJLXKZoraz97ymTkQL2mmPoCSMd6DIKeBur3ssbGQuhhrRP4avpDrrK7i7bYFwuel9sa6hSQa7Iht2+XSphg7EeFhvKSG46bTFH6JweaPm9/wfOzYbjp9CpRPGTLuSRP9jgGmQI01TH5NKVIkrBuPi9hO8f3sO8k2SUdBLJOXWJzpfzEhPxMuzJ9pUB9X0kv8dqngg6jjb0LnMgeVf6UVL1wZzZJisJQdAVwHEx3aKO0/MnDu4jfD5R+g1/UTwYUsMgkLrnOol59hq496iCRF+ekLZCDwBo4R+TOP+iZnp3/RZ8MB1tqyFrGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsp7QjprmwPnEx8bNZpJj/G71BnWj9ZGi++HHYRb2z8=;
 b=nI3ftveho4+ibINZI6ZNJd/6DNXSjQgJnmBudzjJCSIIOMot04GpVdoJaNgABPMtKrxf6wLsHNT3zv12Kj2YF7YZIxSOut8UkPtfvLhtH2LVlrBxQspOew0yq0HGI8x8GQjE2QzK7MiW/OFVH2ujFI9JejqKJ7ytpP95oaeztxPcTeG858IuM4oy01uURu61ULgCvxIAJQNzMVyDZaIh9q1iKalDFtVi68+mRuV890ZXmKZDMwRjb6pix48hxwCISLw+L4K4CoXgn2EBx0uQnWlnPaVYjgzfGzsvMzjThuLzdRwVb19uYdk0DBB1VXSu8CZASXSKptIRuWGZYCpp5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB8296.namprd11.prod.outlook.com (2603:10b6:a03:47a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 07:55:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:55:13 +0000
Date: Mon, 13 Oct 2025 08:55:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Chengwen Feng <fengchengwen@huawei.com>
CC: <thomas@monjalon.net>, <honest.jiang@foxmail.com>, <dev@dpdk.org>,
 <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: Re: [PATCH v3 01/13] app/dma-perf: fix use-after-free
Message-ID: <aOywXJ5xJ5lcb11m@bricha3-mobl1.ger.corp.intel.com>
References: <20250811105430.55791-1-fengchengwen@huawei.com>
 <20251013030236.3861-1-fengchengwen@huawei.com>
 <20251013030236.3861-2-fengchengwen@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251013030236.3861-2-fengchengwen@huawei.com>
X-ClientProxiedBy: DB9PR01CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 5783e0c6-4fda-43b4-38eb-08de0a2dd724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YwAmjlryrB/r6U5aFDBti4l+X/L2dajG39lMleGhG9YySLoLJIzLtnv0mwy2?=
 =?us-ascii?Q?AkZZkZAFtZIyTuLCDEta0UZgzF3G52UJi0tAXvKh7zUTAjxm/SAxkVcBGrAY?=
 =?us-ascii?Q?5UG1R2M2v8cUO2ifVO7URgLLLz+8ZRiP93ox9ysuyK9GPHwCw6gReeY5TRIj?=
 =?us-ascii?Q?+oEXwsbJEvcwghGATVp0ftclz28HcFH/F0hY3eEprEstRmNP4bZvVxqhVi35?=
 =?us-ascii?Q?8aIiizfNnPtaw04mOQT7zVDPXQEAcB6RLB8fvv+seW5SKSvxf+MibQ/RNhAF?=
 =?us-ascii?Q?qJpg0m0Dda1E+zSKCNz24beORLi5w/Gs6mm0MKGbnzFdUUVjqsn96u45N7Vm?=
 =?us-ascii?Q?WexRg6wFpMkx5Vdw7YlUYWYHC/x/HSPVzCVvO8BePgcd3GQ9qQJcSt9jH5bv?=
 =?us-ascii?Q?fdIfXzEqUooSHCyNqBfks5c7YvOYCZkAA9extGlEq4dPruDblLjswe+cnLDJ?=
 =?us-ascii?Q?DYjfzG/Utpln2+w1HzqgeiZmsZCs4cVK1y02DA3tb+OC+7d3MoTa53EuSKtA?=
 =?us-ascii?Q?ti4dcM25J+I6/kO1bo56lMYFLAMZcMbcPTSQWoB55xlDH8ptlzwbUqRDd5/s?=
 =?us-ascii?Q?+BBLvU054Uwjjiust0GER2V1RetOt8XIqnVr+dWW0vN1plwzYT2CgAVsXDR0?=
 =?us-ascii?Q?ICfS7g9NSdwxbxBL2iB5ZrvAVn0O7W5E5vPY87nUzyh5Smu+hEOdjqezdR1I?=
 =?us-ascii?Q?vo/jyWwgm3ceOHQzVBxv8B5GKrud/dUCxTu9P9td6hpBf8SDolVgxkoLMqcE?=
 =?us-ascii?Q?7XAvXYYRd1eZAOI/YGDzYZt8PDiuO+xPG5vCZs3WmCQ64Hfu5y6mYusXfNgq?=
 =?us-ascii?Q?zHJgJN578kGVsJR1Nb7pG6Vf5/M2h8+jO5s+OVSU+DZVv4w1LSWlBM7fICsU?=
 =?us-ascii?Q?xLo/YERaTxMfXDW1OpNurw5/nyLPaHVOnADdh7ZrKzmb593QU02kJsVwyvZC?=
 =?us-ascii?Q?lARk0ioCgFQi5/27TFLX5ScvsnQmv7YcNBskcyTPJWZaNe77ssYCoKYnKvt6?=
 =?us-ascii?Q?EV9zA3I5Zmus4LBwxCbzvTOlUb3FE7G2ZyeRGOgeRev6K+/KPuv5UADwnGzG?=
 =?us-ascii?Q?S4wcZ3yQN0AIOdOVgg9bUMY1zSlgpqAxLl2Df1sAcIWZ9zqin4z9YFjudPc3?=
 =?us-ascii?Q?/AwnTdIy16kOpma8fqD08BuNr0LaEsrgLMu0ERAVipAFfQZs3ll2M5uT9FGP?=
 =?us-ascii?Q?VSTpGDr6Iz7F9YIEe9j8BnVCL/vPCIPoG+S2YR2SQJdVPwLIPZbF/oxFRUjD?=
 =?us-ascii?Q?KEjQI78WZweMOtav0IF3VK5+G+roAT7grqy4KX9QjhtC4pxtzVBBHwt2Wq32?=
 =?us-ascii?Q?97x/kT/rs/x9rI/kDayjFf6hm/FSXlV2fSQ84salnorDk1iv7oYrI5DLuhoJ?=
 =?us-ascii?Q?Wvdv0gMNrXmNqog1jqAEozp0+gbXMxGsL9usvJdnYIugOP2aZ+i+k0nqfHnG?=
 =?us-ascii?Q?CWcZIOZBoGpS0CBXJRWAEbV0CG4fWp77?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HVEahD86B0T3WSd8Dw3JmuY/AiTxrP2xfFwnP3fX0blCGfTUObxaPwT2kgVY?=
 =?us-ascii?Q?U4TArCY8YsxwyNweIuambfAkw/xYnjer6To4Mu3aXDgxtwlzM9dOGJD7NPr7?=
 =?us-ascii?Q?CV2ZMkkS+cUyisd/TmD1wnuOITY90W+PeG5Yv8JMz/H5XyGZbAYl8WPJEuzU?=
 =?us-ascii?Q?KitlHrXSrbPRl9kY7WlPv/8K+Pv/qCyE3MV1VXKF9C51zu23npbRicPhj1Td?=
 =?us-ascii?Q?YQ/1RK6ogKVQ9Wc8xGMCvLJLtDlVCidOw2mOYm/Z8z48okjulWOxM4t1zXnq?=
 =?us-ascii?Q?CEmQw+gRu4JgMn7/jMqbM87Hq41piQIsZXTAzzXyd4v2Aznb+Ggu8m2gLJyW?=
 =?us-ascii?Q?vLbFw/yH6mDHFu57kyIWtEga1W6Qb7lbiPsZq2xZFt3JsLWJX6uu4pC9p/dR?=
 =?us-ascii?Q?j/RlKgupa3tSti8Ett2FQjQZO8h6fFgjZb2+hcMltC+Y+1MvW750ZPxJ68Dz?=
 =?us-ascii?Q?OCQV/C2Z2vrqn2sVxAgv1/KuytmPLUL738o4awOKng5pXVztYS9PzfCf8OBP?=
 =?us-ascii?Q?59yT9da3hGPL2smBlR9X47XS/sdVEESFQddIc8ptVN0KTwLKpcqB2DnsIMEg?=
 =?us-ascii?Q?ZzbTdwY38H98zi/C9EbgiHd2/wVhvW8GXSZVsevLjpxJizToe54Yy7ovmYOO?=
 =?us-ascii?Q?4/uCnx6JmUAO7FtUy1YscSKqIFb6nQf1ut3lhlHfMvbzMEHDqB2ovKupGwzW?=
 =?us-ascii?Q?gRV1N9Nja3WymWw0cn8aEQLGKyemLlhdRPrJtm7CfXy/LTXAQfMmr1hQbDf7?=
 =?us-ascii?Q?Iu8nI3HTurPVfGYfc7cnmjKWoFP9ghDKhQtrQ9On1MA5NFvn1fAr3+vMJimD?=
 =?us-ascii?Q?Nee8YNsDRfOriaezc/UqtExlw0AKCcAe12YYSGaLrbo9FLNlqz971vesYNQM?=
 =?us-ascii?Q?uKMRLwaxYgz/pkH8Za/4PbXswGVIFZ49E9giByCbRctr2dgl+KUVHFoeJW7b?=
 =?us-ascii?Q?qytAEGc7qiesDv3iWg3kCWt/lTKTwpPcWgg5vgTIyPYjgXHFuHPChkHyDGOn?=
 =?us-ascii?Q?exQs+LkwGo1U9duhjFvPeO7MKz1R8B6J0/qr4wkaNRYWZE4Wy1tpMboT9HF9?=
 =?us-ascii?Q?w+b+OHFwHudvJULc3ZQgyfR+cgKM9WQDzSNy6xdqKiILbBxWvpXnwg2DUzgo?=
 =?us-ascii?Q?Rv7zyXJkdYUhXtMgh5Kibg4/SjtRFTQGoXn+/p03wcc4M6fEu5iIpsVI1O1U?=
 =?us-ascii?Q?CYVCjvuwWi0K9a7klRT3ZLBdGfMMF8oWSdm1HmErqVOgNruJVrxALKTnqdDQ?=
 =?us-ascii?Q?eUfRVvMCqjCHjjMlbc+J87n26WGXDFNVeDh3vDbZsWp28aOGV7o6w5TL88Z3?=
 =?us-ascii?Q?kmYvDBouWXNCBje6RP23D8Qa6yIRrE/RazVitGroIN1xz52yyRQtXf26ZGhV?=
 =?us-ascii?Q?6KOw1ZF7VIzQDY2z/RLhHNDxi3zWZk3ScMHs6Rb0osVySDx8X20zcv+9uRH7?=
 =?us-ascii?Q?oWozV6NrSMN6TVSTn3Wv8DmUXIYbW/Lu35hl4fbn5r5JLWfc95IIdBe3CTty?=
 =?us-ascii?Q?oekSY2EHekIPk3peYH6fGTtmofOC2llz1TYHq/+BuszOanQ5xHF6NVU+A5KP?=
 =?us-ascii?Q?NqI5byZKcxRagGM38dGVtIZhDtIuJvJdtoYS6pephLpodxveH8KgM7tdD6q+?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5783e0c6-4fda-43b4-38eb-08de0a2dd724
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 07:55:13.5908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99Cc2RQ35EyBeYHLKNLhOEIIyt46htH5CTmc+daAJjmSlHJlKjsxu4HJJyORAHkt7JbdvWn66juMe7oKKo9blNtyCcgSsLR5IbVkp3DrrFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8296
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

On Mon, Oct 13, 2025 at 11:02:24AM +0800, Chengwen Feng wrote:
> The test_case->eal_args was pointer the entry of cfgfile, it will be
> used later, but the cfgfile was closed in load_configs(). This commit
> fix it by using strdup.
> 
> Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> Acked-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
>  app/test-dma-perf/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
> index 0586b3e1d0..25a79d1d6c 100644
> --- a/app/test-dma-perf/main.c
> +++ b/app/test-dma-perf/main.c
> @@ -480,6 +480,8 @@ load_configs(const char *path)
>  					section_name, "test_seconds"));
>  
>  		test_case->eal_args = rte_cfgfile_get_entry(cfgfile, section_name, "eal_args");
> +		if (test_case->eal_args != NULL)
> +			test_case->eal_args = strdup(test_case->eal_args);
>  		test_case->is_valid = true;
>  	}
>  
Do we not need a matching free() for each strdup call? (Same comment applies
to next patch too.)
