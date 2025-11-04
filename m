Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207D1CCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 17:13:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F9104060B;
	Tue,  4 Nov 2025 18:13:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id D39954028C
 for <dev@dpdk.org>; Tue,  4 Nov 2025 18:13:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762276427; x=1793812427;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=m1l3thAH6KjjBCTYp16Qs4azucsCNi0EUC63GqF6EmE=;
 b=krqTR8DMzmOrpru+sZhg3r3l5ca7Gjd2EqZ9NCWKdQ3fX8BPZ+oTLfhg
 jYif8ta8GKTXRW8wm3/fwH7k1PTTYFLsKjpB0qtGH0VWONja3x0pQSWs+
 bs30o98s2ReHyWRCMlGjfjRGJxWnNm1NXSiNlraxh98OVG/zDjIvn/QZC
 kfrAR4k8Y/QlwT+7gRdrxo/+pcPtEM+Xr2JHl++uMvDFKCfHhN7E7DmQW
 tpK9iYx8orUcuh0UD1DL4iqlBDk54tnTRFF9Asj20xlj9SaHknz4A2o/L
 cPpjAK05/k4SZo7EYatXRMzuTS1P4ycuTXPodQGz8Vp6NZ8YdXGYkXTdQ Q==;
X-CSE-ConnectionGUID: jDnMXz9UQKCDKjL2GKz8mg==
X-CSE-MsgGUID: lwkCha10SHGaZdzpWEt/sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64262948"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="64262948"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 09:13:46 -0800
X-CSE-ConnectionGUID: O8pP3jBKQZeA0qtUGX88yg==
X-CSE-MsgGUID: jO/ozVN1RJC9OErWm/bvFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="186452464"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 09:13:45 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 09:13:45 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 09:13:45 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 09:13:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdXv3XL8IWCASfxQOl+/xWlZVwTv8M9q3vaibmnauNre1rmOHdg7bpWZs/UaDqHv/UxrsXQnO+oj8TYIOG1/zHOBIWqbmm1+Ijth8xxiLbFslFeX92+rhnSWKcFgliR/oyV54TLIW2BQkvOQ2ZPL31czVYuZSNFOejsSe8NA4qli2RSkY87VP/IwDJrNt49jXxyhqjIa4REOaaZvn6yB/IVppCdYhXN2Smmt4ZnXY+tHW+v2HOqF3bIQA6pJ/dzpoUd0rMbh+wnlnhBu6L0gC/YOixWxQ4EE6f14dVn7Sf/M3pYAv12vcEkk3lDRmfaCXuoNGkzeYCC5MXeKrClERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szXyyf6GZq2jyqo2PE4/CUdEnz8P2fDQKCYGLNuq4SY=;
 b=QNpExMtexZ078GD01qMpHY4b9Jcc/eIsiLOritJhNLCiyImSyZWJqS+nDhsb1T3rl2WRMQ1oZ0z3PUrL7yYp83434oga2wVVoJYBxbWgqBzfQZWTjk5hFvPgJSzDAU9Xs6qVrjMAPApUk8OdroOZdGZpMS4GJu4RVbxjafjzwvFLwIWubxyzyCSwIUVgPM0T8z54Q2GKQ3KRkx02/Gr1bzbh5eMlzqP1saDpnTiqPEZzzmcfB8VIOU6Jfw5Ql59zcf4PGt6xT33YBzTXggSj6EXZ6wP/Nx3gJ9W4y+Gvhksav9WCckw+jiv6vtUNylhn7+emAY1X9mofd66F3T9bow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7716.namprd11.prod.outlook.com (2603:10b6:a03:4f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:13:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 17:13:41 +0000
Date: Tue, 4 Nov 2025 17:13:36 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/2] net/iavf: fix AVX-512 double VLAN (QinQ) insertion
Message-ID: <aQo0QLplPKmTbZTS@bricha3-mobl1.ger.corp.intel.com>
References: <20251031152250.2441980-1-ciara.loftus@intel.com>
 <20251031152250.2441980-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031152250.2441980-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZP191CA0069.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f145dcb-8e4a-4de5-a0d6-08de1bc5803c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SaM+VNGgW4KYDaZvs7heQsduMw/ydVt773xOgTa3rVtLRW/FvPughlD7kZwH?=
 =?us-ascii?Q?5wBuh5r9/fIWDNa4OtdosJxqekqm+/cn5x4krVQbfzNUqDm+iu1RpkkdBZU1?=
 =?us-ascii?Q?5CKOP7gJEX0fiCwl0whbyvsLgel4TLCZjJUcYasz+lGF0TlHpUttHx/j6xr7?=
 =?us-ascii?Q?359hYFV9998MmjOuWBnnJoK2Fmnv6ld6fLqKrIfMQsM6+ITlXDBf2TCUCG0m?=
 =?us-ascii?Q?Krv9CMCB1IL4wcQiUec8gZ0DFuwyyIoUCRKF9IZC5Tzp3jkT7e64iXF5dr/T?=
 =?us-ascii?Q?2m71wNM3+bRF3+/Ktff4p3/UTm8BaIRZ4LGpmy3SmssjNgbt0yEhmJwAFaDl?=
 =?us-ascii?Q?U+39v0o6vLhbiQbefoza8iB0SIp1K6OnzdaskO7dIeDUf/WNliqoZQaOf6d7?=
 =?us-ascii?Q?GSEbfQJyiTyLdZMmWqIA5TqfOOBlii2DBsQB0lJ3YGBddiw4ZqrzrLuohyWs?=
 =?us-ascii?Q?Ver4GsfdoF1EIjoGSNk4UwFDrbDM8AZapSdBEBaalojDPM6bzqlClREST3DL?=
 =?us-ascii?Q?L6kMQqXQmd6zSs0mx8wZqQfrMKdH+jSljrclgDRO8GE7P4hse/iZTEPUr9NX?=
 =?us-ascii?Q?yr1tYlnNM2Yr6sxKhrk5q9ZyFT1e+vjxd6bEorMoPBqExmwjtdnR2aabn1R9?=
 =?us-ascii?Q?zvi0IpwIWQSYPM1eoshs4PaPTBK1frzF9CiZadjqeGzGLmvdVo2fv6h/GNLG?=
 =?us-ascii?Q?epYUtpMcwwnSDXDu0WlF/MbE263umjKwpxlQImAfs1HiIqXfOEZyIgcDcDLf?=
 =?us-ascii?Q?uti36oMc7qqCRef9wFIc2xel2NcA1WgGqLzTkMMm+D54M8DgpznKv9svH+5M?=
 =?us-ascii?Q?AihTMeczg70m9LnDuj9jfsFU39FmJxbMGovoKobsmRPcO+X8qOuufYjeM9ZP?=
 =?us-ascii?Q?/AmrjNCckxaW4atV+lszSLCdbHHhq5IDOJMPbh0HmI+/45YyNaS9MmIpxQwO?=
 =?us-ascii?Q?XTKpTFzEup4ao0xgFldgQCqBxb4srKA00VEyL/t4F68TL8Jwyk638Q7RAkGE?=
 =?us-ascii?Q?r7+RcCmj9R2wLiweSu+IXZv8XWnCEdsFI8D0Cld7kAXQCVBmWm8Btwc1UK4W?=
 =?us-ascii?Q?J7VmYKf34+6+cpKqwuPJn7otOzC8MM56a4l8Kot5a8jEAK4kgR/Mb/79W10/?=
 =?us-ascii?Q?5o1UiPYoXMeg4TPnJ3gqM/kS1TTlxVVNEQoKuhsgt8A4mUAm7VXP7tXK/rCN?=
 =?us-ascii?Q?ve9OEmuDKfPEmMCORxHNjHx9xr3M7sq4SNtFP31frsUGYkw1/46uRSJ+PxTY?=
 =?us-ascii?Q?IdmFUdU+Ss/3PCxj4V/XZhkEaXdcUXwExvldVNFAopoSP7jsSfJdPojL1FkD?=
 =?us-ascii?Q?TD+Egw7OJTTVj5gZoujfQokPu1wJABiDpTX08W324E55hWKM/4VlVujQbhJF?=
 =?us-ascii?Q?qH5DlxN6cekKWd47hLlFUCCoggGau/3ola9GBwfzh/uRDTT05iKMEKVjYJRs?=
 =?us-ascii?Q?jKN0THpC1ZwYb8HSX3u+ddLqn4yiiFkn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?th5p7ntDU1LJboIPkOs8FEANTktDPyYoj4VSm+bwbEbauDSGvOE/ApP+5e/a?=
 =?us-ascii?Q?vx1Kjhv6EQrdQlfvFuspZIYRo71tAxEknk0x0xmksucsDOYhtGpuj27nYh+V?=
 =?us-ascii?Q?OiEiEDWLyO5ef6dWS7DTc0ES0dWLLWSvuvz+XrhQzz4eiyo8QgEgawC5zEcl?=
 =?us-ascii?Q?+2DUYQaLVB1mDjWcCewLbAHy1+JFoS+bqbUqLJuHqufa/vQ1BaM9BDO0RNxm?=
 =?us-ascii?Q?w1m5uu77sIrQyXCPXw8ot9EZwQAlMEKSeo/vrQ0ZM+DB5UpOMe6+JjLphgK7?=
 =?us-ascii?Q?3TvhwEcO4uuVwej3DKMJuYxJz7sgHvzpVONI3+3Y7EvSW3dcskhLEJuehVOL?=
 =?us-ascii?Q?3V4p6sZOrSUnIJin8fGcyLESkbUfPIsOyu16ey1nO4fT+e3rjMAPQnJH3Mg8?=
 =?us-ascii?Q?Fh9L486+BaGLbFhRBUom9NZU51PG1vk2l8FkfQ4G84M1JA/KqDBPvrtgMUrE?=
 =?us-ascii?Q?50qQuc46DJR88YW9pz7Ca9cE6AHJboHv6iJx0+Mvj+vfAH3vYJVF5BYcyyVk?=
 =?us-ascii?Q?nUbqxC359EvpLb5gRP52BZQwqaUY5QipQ0G5hzLzT/82i4QMmSPRStcJcB/f?=
 =?us-ascii?Q?KmOnqGwkv/Mv4etZ0Mnvr7XygVp3bhAOCRl2ZFuL2kVVQ2rQtwn7aeO+YCtj?=
 =?us-ascii?Q?yuTxZ6/WlOlBP9vZp1+NH0OfDJpvCqJQgEYCU9GhCDitOcRJO1U9Q06bI4zf?=
 =?us-ascii?Q?kGnJTVH1D4RnL4PEFBwjKI7wyXkPAffE+LO2SE0V2UeP8rAQ441zVr/1t0on?=
 =?us-ascii?Q?Mo6EOj0xYgQMXRlUgLcaCvywCVa2ZDry77PsvrBtrVLCwYcpOOW0Y/6L68aX?=
 =?us-ascii?Q?IEzFV8vPFFLEBoffJUzMjIRocFVVR6sgsyYUvsjamHmusbGRXJEqW9av3DLJ?=
 =?us-ascii?Q?kizGEmWla+cQ8tJCLvmHYqNYq3NC1035yFuwAAERfIf0rrhCO47ujQM6mwTx?=
 =?us-ascii?Q?nMIpFgNhUgLz38wBLXauc51du2hvb6ODoHruBoDiu8fYpidq/0DeJlase7qx?=
 =?us-ascii?Q?Omc1kjyC6ulcbYBw1oO5rjI0Ye63oEnOuWbkp4J9b1vweEgEUFDAYy31wy2o?=
 =?us-ascii?Q?X20aMhwuW6/D4mFj1lhQWUd8IizUrg5WZfqCYTjYQ89urzhbRq1TQy2xb1nn?=
 =?us-ascii?Q?ek4gQRZ3jN56kIHnR2uA7e1bjsNlG14jf44XZRq+3w3pPFgIhSwdFhPjr6HI?=
 =?us-ascii?Q?YchAG93pQCIN+mgOg3axLOVNqa142V4ynQCjhSHOSXfNXp1p3UPUBi6d65cv?=
 =?us-ascii?Q?57tiuULEM3sD9uGFSOw/cJBkS2TW3IAbRDx5o19FFe9+x4B/RhcbB0k9d9rg?=
 =?us-ascii?Q?4NX44dXHQJN0whLW4O/5aH4hQYNVmCOB1y7lISEjojpDzfX1/7Igz8D3OFMd?=
 =?us-ascii?Q?e5bDNC1RToBppb8Detjtn6Fm3EpbX3PNPZ9fTq2flp1ey76sTymUsySZ9vkr?=
 =?us-ascii?Q?mTBzoWRqfBM/0VLMWO63+HZBua1Rp9QjewxIqx0wxX0BD5tdHPG6fPWhtZi9?=
 =?us-ascii?Q?7VWAvNltSr6J8E1+xSkexZS7xzEO++qWVm/PvHKjeATs+VNm1PlXg2Rf2iD/?=
 =?us-ascii?Q?tEVe1CoHwj01ybxV5FyVUfu09fxiJdBHqZjj4NZunUO0CbmRor/AzzhHTIar?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f145dcb-8e4a-4de5-a0d6-08de1bc5803c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:13:41.0372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urXihodih4L50QZAQ7PYo/rwwLl6FLXatynk/RJSDemfgmI0JdZaX050q4ubRNlf7x79D3CV9H5eS4eG9b8vydven/d7RUfxMl6O+MxR638=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7716
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

On Fri, Oct 31, 2025 at 03:22:49PM +0000, Ciara Loftus wrote:
> QinQ insertion was enabled in the bulk transmit function but not the
> single packet transmit function. Implement it in the single packet
> function.
> 
> Also, fix an issue that would arise in the event an mbuf had both the
> VLAN and QINQ offload flags set. In this case the L2TAG2 field would be
> written to twice and could cause the tag to be corrupted. Reorder the
> logic of populating the L2TAG2 field and ensure that the field is only
> written to once.
> 

While both these described changes fix the same commit, can you please
split this patch into two, because it fixes two separate issues with that
code.

Just one review comment inline below. You can keep my ack on any new
versions.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> Fixes: 3aa4efa36438 ("net/iavf: support VLAN insertion in AVX512 Tx")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 50 ++++++++++---------
>  drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 10 ++--
>  2 files changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> index d40a858413..c800ae29e1 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> @@ -2077,7 +2077,13 @@ ctx_vtx1(volatile struct iavf_tx_desc *txdp, struct rte_mbuf *pkt,
>  	if (((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) || offload)) {
>  		if (offload)
>  			iavf_fill_ctx_desc_tunneling_avx512(&low_ctx_qw, pkt);
> -		if ((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) ||
> +		if (pkt->ol_flags & RTE_MBUF_F_TX_QINQ) {
> +			uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
> +				(uint64_t)pkt->vlan_tci_outer :
> +				(uint64_t)pkt->vlan_tci;
> +			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
> +			low_ctx_qw |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> +		} else if ((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) &&
>  				(vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)) {
>  			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
>  			low_ctx_qw |= (uint64_t)pkt->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;

We are missing handling here for the case of vlan_flag set and L2TAG2 flag
not set. However, that is handled by iavf_txd_enable_offload - but only if
IAVF_TX_VLAN_QINQ_OFFLOAD is set, which it is by default as far as I can see.
[Maybe a future patch we can remove that define???]. If it's not set, do we
need to handle the vlan case here? There also seems to be a little
duplication between the code here and in that function.

> @@ -2127,17 +2133,6 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
>  				((uint64_t)pkt[0]->data_len <<
>  					IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
>  
> -		if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN) {
> -			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> -				hi_ctx_qw1 |=
> -					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
> -				low_ctx_qw1 |=
> -					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> -			} else {
> -				hi_data_qw1 |=
> -					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT;
> -			}
> -		}
>  		if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
>  			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
>  			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> @@ -2153,22 +2148,21 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
>  				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
>  							IAVF_TXD_QW1_L2TAG1_SHIFT;
>  			}
> -		}
> -		if (IAVF_CHECK_TX_LLDP(pkt[1]))
> -			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
> -				<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
> -
> -		if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN) {
> +		} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN) {
>  			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> -				hi_ctx_qw0 |=
> +				hi_ctx_qw1 |=
>  					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
> -				low_ctx_qw0 |=
> -					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> +				low_ctx_qw1 |=
> +					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
>  			} else {
> -				hi_data_qw0 |=
> -					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT;
> +				hi_data_qw1 |=
> +					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT;
>  			}
>  		}
> +		if (IAVF_CHECK_TX_LLDP(pkt[1]))
> +			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
> +				<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
> +
>  		if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
>  			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
>  			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> @@ -2184,6 +2178,16 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
>  				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
>  							IAVF_TXD_QW1_L2TAG1_SHIFT;
>  			}
> +		} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN) {
> +			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> +				hi_ctx_qw0 |=
> +					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
> +				low_ctx_qw0 |=
> +					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> +			} else {
> +				hi_data_qw0 |=
> +					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT;
> +			}
>  		}
>  		if (IAVF_CHECK_TX_LLDP(pkt[0]))
>  			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
> diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> index f513777663..bf8faf3632 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> @@ -225,12 +225,6 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
>  #endif
>  
>  #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
> -	if (ol_flags & RTE_MBUF_F_TX_VLAN && vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) {
> -		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
> -		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
> -			    IAVF_TXD_QW1_L2TAG1_SHIFT);
> -	}
> -
>  	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
>  		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
>  		if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1)
> @@ -239,6 +233,10 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
>  		else
>  			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer <<
>  					IAVF_TXD_QW1_L2TAG1_SHIFT);
> +	} else if (ol_flags & RTE_MBUF_F_TX_VLAN && vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) {
> +		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
> +		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
> +			    IAVF_TXD_QW1_L2TAG1_SHIFT);
>  	}
>  #endif
>  
> -- 
> 2.34.1
> 
