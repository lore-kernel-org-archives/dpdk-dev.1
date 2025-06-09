Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C9EC61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 11:54:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9156B40A6C;
	Mon,  9 Jun 2025 13:54:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 1DD474060F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 13:54:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749470079; x=1781006079;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Y2PaEZL/GqpLV6qJanhc5xLDfn2/ITvldaWeuydbXVU=;
 b=bgatyawM+3B5Aw/7qqGt+m6eGnU0OxnHpzZQzcJulKjm3ZC6w4gsgWYm
 UopZ2Bxl/HFeShpvcQ3cLJmmCGvL8+D1qGswImjepY+Fh/++dAXihA4NK
 p84Ge/E40ENq6bQnhn7ayACa+J8iz/zG2qJhiBAUO7zvu3FbqZyTJr2fK
 eQyy3e82mo+u+HjTHZKrGswux8X7fVn+BCFf/EYPG6JiUEkvzC3PjHkpQ
 36N/nh8F1210oS5DT6WK/6vjkAmn5lgFaOGj/JF5CxOxEzN3MdjiT0nEQ
 VLJ8G/88TGuOm55g1VDGAfKYkcEX/o3mdHofZpIagRIc9rz6Y7iBPp+FU A==;
X-CSE-ConnectionGUID: DX1dBhEXT5WDwWzpG48nOA==
X-CSE-MsgGUID: PnGqWKmiQlmItbNor7bglw==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="62945376"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="62945376"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 04:54:36 -0700
X-CSE-ConnectionGUID: U5rvMCCuTI+9srHdsrn4Lg==
X-CSE-MsgGUID: x3k1ZVuwSMOZJe35zpfcWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="147459442"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 04:54:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 04:54:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 04:54:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.60)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 04:54:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2xCYgBxpLyFq70nSflVL7FFMvuV4ZYAR7b9H3B8zxcPXDYLql5dnTeGexVN2k0FTSgES2+2/NeI51ovYSTBLPiZ1smVYIWyw2v9yJC+EyAuIhVSwf65vAzg2rQH/9BodTpayT2eKudW7m4eSuS59XqJEAu/cLMtkIRAt2rIC5U9sJUZHq3fF76CBQFvPeVN2JJ6X51ZHWGD7cpxrx0MyVmdFq/Sbt2c693R3mLNH+yfxxMbq3G0dmWmcWcNAdPckFsw/4SbqbsZ+1kjfcIry6mPTJcfl5UUSxt+Ao+LPo/wgxHzU+ai2A3DAag8Lnx5gaorLSfWAF8W2LujkH3b4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byrnE/jSeTtZegUvtv5ZW1YiLgqAmmRlqVRc20ik5hg=;
 b=QF7RyjRL2UuM9ouE+kGj+QjSASpMs88uh3CyX1C2NITCfTQvNEj94LNj3Cxo+5gK0KcFkBG1+Qk3rZN/btl4Wk7r5OhgivymzHt9KYn48U9Y1x011OBLRsUDJMlybi2FWzuab4Q3KkFUYWTSdH/1jEZSxoafZF1xdJcpZlPc6CxdqA3Gov3CqRfAppeaZ93edUwfUwIwoBJ2LTftUf7wvwfYpZA2PwXAwXw98IVV42DEsdno213+1+R4aQ7zPabT22PFuH52U5axbABhFbotY0oKdVwwWucVfDCs7LiqgRXGnZzWzbGbApFS1L3c6R9rzTU2Fs+lNlJFH+jVk15DAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ1PR11MB6108.namprd11.prod.outlook.com (2603:10b6:a03:489::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 11:54:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 11:54:32 +0000
Date: Mon, 9 Jun 2025 12:54:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5 32/34] net/intel: support wider x86 vectors for Rx rearm
Message-ID: <aEbLcjsxW2K9GCmy@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
 <50d03ad98dbed61ffbfec689337b20f41849c11c.1749229651.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <50d03ad98dbed61ffbfec689337b20f41849c11c.1749229651.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0289.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ1PR11MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e41a0be-b3c0-4129-39ad-08dda74c65a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/i7cCgOl+eMbHARDv4SBws2bPgBCCXqL62tOa4hbWLFrS1B5QEAT6inwH0Kr?=
 =?us-ascii?Q?nuqBYx/RAMseP3kb28sLpe9PgaeHHjKeULBYKP9gy+5yFhR8A2MkRRvDC88F?=
 =?us-ascii?Q?/hf48mpiudxF+QAKevPYvtr8uzTH5ghOcbGzquXiy8A8jr/IPIADwnhRWCTQ?=
 =?us-ascii?Q?VwCoFjVzXO+J2k28u1gqqHnhK3Qg4+tXenNTYfEyAuiZshu8z0mSuX5MKvkv?=
 =?us-ascii?Q?EhPRmEhydmSMIXe0l1mv/oE+JaoXgdCHY0ql0tdzzcNOgmC6ZfxtVB5r/ehb?=
 =?us-ascii?Q?RUq0U2W6AEvwSw6ypNaDC1UpG4p4MB4/SMjhcDznTjm/zcspJQLWL0rDDMhi?=
 =?us-ascii?Q?ZpHj/47AqmKb/VngUwXmXBCN6zilFlHMQgv583rn6uP/zGburkdTGpHZzbAV?=
 =?us-ascii?Q?dNgMOcQwmKuUMQ8FXjTtWcxw4XUb/bKbxLIdPFrlqfCzno/uzh8/LxnPFkb5?=
 =?us-ascii?Q?GQ0odcE+O5/VzirrAzKxZwCicaHrtubisKiTOGzVyKoMUKap7GL6WOXP35OT?=
 =?us-ascii?Q?j3j33EaWzU45pksPG5rMCNbevgSqTbY8N8MnOydW59bDM0OI779OBmlB1Tl1?=
 =?us-ascii?Q?WnEmZaYNRdo1w2L+82x8hlLWre9lvuXU5V224QZJf3fANMT1sKho7cFRea7k?=
 =?us-ascii?Q?IT8udreYvMYlUnETpERNrnoavEi4t83+hDfaFwym8EBy4D8ObHM6NNTCL4yU?=
 =?us-ascii?Q?GHiGspFH/EKTyeJAZtJOQKDeRB5AfDEgdD28GBK8ZJKF1jY6LlYK2so/hBAO?=
 =?us-ascii?Q?u5wIunpIhChdIzU69QWtFxowSGvyXuBSpcEasHFS720Y0YE5ekizCgnA1iLO?=
 =?us-ascii?Q?xV8fWkvNDnIdGANcA2AC1jdmVyjGVV7FOapJyO3dV/fSRleWk3ltvub71a8j?=
 =?us-ascii?Q?NG1XLaTVLAdyEekuM2EExKSNfdh0Nvuli0SzJQet0dnKa3rItJpMVXlMLgUe?=
 =?us-ascii?Q?vcPaE7VnmugQ6ew7NpK6vZheWNOiyWH7BUFfFEPMBmhtSFrJW/jMdvkGgGCj?=
 =?us-ascii?Q?x1Mb2G9oP7F4EXwxRrd8WCFn0wpU50YryHCOT9ueUZfgNAK+HX1M63DQGXjU?=
 =?us-ascii?Q?xQV2Ph8R5ixt/uVGGDpH8k0sXL7Nq9FBBlSlvKUSBRpNPCEH9dzWvlS92psh?=
 =?us-ascii?Q?w6wzlvQ930+1qQ5m1VwXmrTsttHRFriuDg7qe6IBljzfiFHbExznKV8sW36B?=
 =?us-ascii?Q?tcFWJOKhFrBwXi2H/gSQC8Yw8cDjNpgsNg+yyBd+DM2/IqH7AVSSGN8CIMMd?=
 =?us-ascii?Q?N3k2FS1nBoFRCtKZ0s1F44U8vGr9VQxde+v8HSuwaLTovwdcldohfDHaShKs?=
 =?us-ascii?Q?l3i8g+IfwY1IE1iSzrwCdhbf8ixaeBN7jUegYdhVTs38dpewiQROYwK1Zskp?=
 =?us-ascii?Q?1CVnIdmOCEZRl385kqTBC8yjp22lt3imajRd7dtvz8w4HcJAqKvjjf3mbsO1?=
 =?us-ascii?Q?jM7SMYULtVM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yFdjOGaK7EsZbGKLT5HqELOu36yFWZGP9Vu/fUQbYdLOOYO2K9209ETVfSmr?=
 =?us-ascii?Q?OuCue0MbzYw8P+6PSngAJfSd0vYTz6MDIAdfTMGuCMtbbTwEXLSbmKS0ShfS?=
 =?us-ascii?Q?ULN4YF/3vMJ7D1o1Yq8nvUT82LbaPe0gRGG8nEQVtWSBJFh4HuwFyiaKBDfc?=
 =?us-ascii?Q?7+XQZmRoTVBzQ21hmPSK84I+OcE99xr0yf9NQx9PloymlLnJLPI2ZHZyEa90?=
 =?us-ascii?Q?KKUueyt2S7siZ736nfVhjt9QOMOVOiXg7OTwDJaj51yCSxKWJgci8NsAix0O?=
 =?us-ascii?Q?/drlUT5mrxlEt+cwy9IkWefVIErQ9AXFqn3qXcTNvWfOXxPqAUTcUSMf3xe/?=
 =?us-ascii?Q?x6PPb2/fz6wWZ52vF95Cd1zkc9guwaGSEGSFQXocqxmJC3TziTWk5HzPqJlE?=
 =?us-ascii?Q?ktIfoNaW9BgTKM86XvJCleZDC0SsKmUf1sHZz/w7HyjHr1aGlF8ujGMu9l6U?=
 =?us-ascii?Q?tidthOZVal0cBbAESJmtrsIemo2RB8+YEjbQKQgeDcN06bszk39Yw3pYwUWk?=
 =?us-ascii?Q?CP1XLESil6RXI7HiMvlgB9aVe93kNYI0WuPtjc2ZYSQb9/AXtQIVCaS9TlZl?=
 =?us-ascii?Q?UXgjunRfIiHZd4GwghP3y0Rk9xr0yMVTaqEZVYmXeO4GJAm31ql7T1tr39K0?=
 =?us-ascii?Q?uhSeM/bPTJLHaOTWu4AkgNjBiRBWFB10khr86coy43+M+L2d261MvC7sJr+O?=
 =?us-ascii?Q?NphmAfsQjuXv0Gx4f7UMASxNGR+HHEDyTpePejNr1YqIWrjaGNinECgA7CTF?=
 =?us-ascii?Q?u6s+QhCpM/P0ELxd+pnEvxmz6S+Ql3TnV+O4B89/sdlpeFF0wT0d76JPqTL4?=
 =?us-ascii?Q?5TWdjxjfOI/mPUuA0eLW85h3xammR1XBlKDhkZDfPhiaIWMKfFD/LHq2ALt4?=
 =?us-ascii?Q?AnHjpkdsfyePSsZGcPntAo9lsglRTdzA7cbFTkWKjAAfEBcw+yIPjvS5rUQH?=
 =?us-ascii?Q?FeEq/Ivlqvu6Jwx3b/c9Ng6BnHAyV3c7yFKhv8qOAHhswSDKBUs0nbmgvOEH?=
 =?us-ascii?Q?zm8cxZyCH8Li7pAiNULgQefhDj90tELIlv//TdgxxBxVbRbknN2PIR0SGYql?=
 =?us-ascii?Q?Wa2IJZttORMf8/E5dQJIDBSvq+BAqAQNNJSkoZQs7ea///x4XrtDt1qaI3qu?=
 =?us-ascii?Q?tx1ygcsx/lr+8kUjsca5wGbxKCQdhoM8inJpWgUH3WotxrC3B/at8hbxAcCL?=
 =?us-ascii?Q?yrsTyk5A++YOwtouarYdDybuuzoWeZO1/Z9CGfraYljF1Kazbc8a6fyJLXoE?=
 =?us-ascii?Q?ZXCYyHREeICMLA2LAaaOdeaIUHlYLHj5apMmbaqxyPvsd4tG8YKncgp76F6H?=
 =?us-ascii?Q?lxKtgIdNlxF93F1KM4tb/aLyoZrbo0PfYdw8ukUaxJMPzteo/i8Mfn93U129?=
 =?us-ascii?Q?vQfZWZZplA3WkylmD0Lnmt/4iMA7kVOrPsrk/2JHGAcehu31rYE+4ya0Wep7?=
 =?us-ascii?Q?2XWV3SOoEzzMDRSMYBd+BEpnVd0DysrNlR8bTZ5kSX1jTecI19D9Xwko/9tl?=
 =?us-ascii?Q?QOuzSJE0WRyQY70ncDvz98EgtEvUYzo0evcIhD7u/Wm86ltbs0AiZSR/4qJl?=
 =?us-ascii?Q?++t0OqrSmlve3ck6NzA9ry8PBoV6B/vdDrVgxxGS0A94ybxNkiLKFxMrufbI?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e41a0be-b3c0-4129-39ad-08dda74c65a4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 11:54:32.3566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOboSjv9e5JAgS1M23koEOUnDBc6Ke8qiG1SLDOARGBA3yv9Kuve7qvWY/JL3Apz2VF+kixqeyMpaqquc/xcxerIt7B8JJmLZsnhlCRsrU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6108
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

On Fri, Jun 06, 2025 at 06:17:07PM +0100, Anatoly Burakov wrote:
> Currently, for 32-byte descriptor format, only SSE instruction set is
> supported. Add implementation for AVX2 and AVX512 instruction sets. Since
> we are using Rx descriptor definitions from common code, we can just use
> the generic descriptor definition, as we only ever write the first 16 bytes
> of it, and the layout is always the same for that part.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Two small comments inline below.

>  drivers/net/intel/common/rx_vec_x86.h | 365 ++++++++++++++------------
>  1 file changed, 198 insertions(+), 167 deletions(-)
> 
> diff --git a/drivers/net/intel/common/rx_vec_x86.h b/drivers/net/intel/common/rx_vec_x86.h
> index ecab8b30a6..86c599cda1 100644
> --- a/drivers/net/intel/common/rx_vec_x86.h
> +++ b/drivers/net/intel/common/rx_vec_x86.h
> @@ -43,206 +43,248 @@ _ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq)
>  	return 0;
>  }
>  
> -/*
> - * SSE code path can handle both 16-byte and 32-byte descriptors with one code
> - * path, as we only ever write 16 bytes at a time.
> +/**
> + * Reformat data from mbuf to descriptor for one RX descriptor, using SSE instruction set.
> + *
> + * @param mhdr pointer to first 16 bytes of mbuf header
> + * @return 16-byte register in descriptor format.
>   */
> -static __rte_always_inline void
> -_ci_rxq_rearm_sse(struct ci_rx_queue *rxq)
> +static __rte_always_inline __m128i
> +_ci_rxq_rearm_desc_sse(const __m128i *mhdr)
>  {
>  	const __m128i hdroom = _mm_set1_epi64x(RTE_PKTMBUF_HEADROOM);
>  	const __m128i zero = _mm_setzero_si128();
> +
> +	/* add headroom to address values */
> +	__m128i reg = _mm_add_epi64(*mhdr, hdroom);
> +
> +#if RTE_IOVA_IN_MBUF
> +	/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */

Comment doesn't seem right here - we are not doing a load op. Perhaps
reword.

> +	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
> +			 offsetof(struct rte_mbuf, buf_addr) + 8);
> +	/* move IOVA to Packet Buffer Address, erase Header Buffer Address */
> +	reg = _mm_unpackhi_epi64(reg, zero);
> +#else
> +	/* erase Header Buffer Address */
> +	reg = _mm_unpacklo_epi64(reg, zero);
> +#endif
> +	return reg;
> +}
> +
> +static __rte_always_inline void
> +_ci_rxq_rearm_sse(struct ci_rx_queue *rxq)
> +{
>  	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
>  	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
> +	/* SSE writes 16-bytes regardless of descriptor size */
> +	const uint8_t desc_per_reg = 1;
> +	const uint8_t desc_per_iter = desc_per_reg * 2;
>  	volatile union ci_rx_desc *rxdp;
>  	int i;
>  
>  	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
>  
>  	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
> -	for (i = 0; i < rearm_thresh; i += 2, rxp += 2, rxdp += 2) {
> -		struct rte_mbuf *mb0 = rxp[0].mbuf;
> -		struct rte_mbuf *mb1 = rxp[1].mbuf;
> -
> -#if RTE_IOVA_IN_MBUF
> -		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
> -		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
> -				offsetof(struct rte_mbuf, buf_addr) + 8);
> -#endif
> -		__m128i addr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
> -		__m128i addr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
> -
> -		/* add headroom to address values */
> -		addr0 = _mm_add_epi64(addr0, hdroom);
> -		addr1 = _mm_add_epi64(addr1, hdroom);
> -
> -#if RTE_IOVA_IN_MBUF
> -		/* move IOVA to Packet Buffer Address, erase Header Buffer Address */
> -		addr0 = _mm_unpackhi_epi64(addr0, zero);
> -		addr0 = _mm_unpackhi_epi64(addr1, zero);
> -#else
> -		/* erase Header Buffer Address */
> -		addr0 = _mm_unpacklo_epi64(addr0, zero);
> -		addr1 = _mm_unpacklo_epi64(addr1, zero);
> -#endif
> -
> -		/* flush desc with pa dma_addr */
> -		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[0]), addr0);
> -		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[1]), addr1);
> +	for (i = 0; i < rearm_thresh;
> +			i += desc_per_iter,
> +			rxp += desc_per_iter,
> +			rxdp += desc_per_iter) {
> +		const __m128i reg0 = _ci_rxq_rearm_desc_sse(
> +				RTE_CAST_PTR(const __m128i *, rxp[0].mbuf));
> +		const __m128i reg1 = _ci_rxq_rearm_desc_sse(
> +				RTE_CAST_PTR(const __m128i *, rxp[1].mbuf));
> +
> +		/* flush descriptors */
> +		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[0]), reg0);
> +		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[desc_per_reg]), reg1);
>  	}
>  }
>  
> -#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
>  #ifdef __AVX2__
> -/* AVX2 version for 16-byte descriptors, handles 4 buffers at a time */
> -static __rte_always_inline void
> -_ci_rxq_rearm_avx2(struct ci_rx_queue *rxq)
> +/**
> + * Reformat data from mbuf to descriptor for one RX descriptor, using AVX2 instruction set.
> + *
> + * Note that for 32-byte descriptors, the second parameter must be zeroed out.

Don't need this note any more, since this function is not used for 32-byte
descriptors.

> + *
> + * @param mhdr0 pointer to first 16-bytes of 1st mbuf header.
> + * @param mhdr1 pointer to first 16-bytes of 2nd mbuf header.
> + *
> + * @return 32-byte register with two 16-byte descriptors in it.
> + */
<snip>
