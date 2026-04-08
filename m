Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6390E10F995C
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 16:27:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A23BB4014F;
	Wed,  8 Apr 2026 18:27:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6EA314013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 18:27:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775665672; x=1807201672;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2u/GDtYUKXbn+6YJ6zZzjqt5ATVZ8+XA32o+ITNmXsA=;
 b=PFAcQBcozmy+N+UZn2ofPV8oJlp0+Fsw7nv8Lt8oX3RwtSEX0B4a2vHF
 5kPoKk2VKOpFIQ5R46rrDCP1OhoIe2KsIWf/S/QWFiGQE4Z+Yg9S/8Rea
 v0Hcp4Vwdjjk1ZRJnXQsG5nO70VVQ0PBnY+oFblkBt5WDE0klMSWv8Yam
 tHo2CGbYcQDERS8xKHKbROEHLaoI6Rql2akcOQ10+l935fuFU3iN2TQsb
 /Of8l0wQvc0fEZJAk9j2uKaJhh2py5EDqWG2M2QncGDavvgkBRqkp70bE
 ObhbMseuUhQTA4k1MHLGX8+kQqdfL9d7LT6VaF/vsQctSqzirt7JIgZz9 w==;
X-CSE-ConnectionGUID: ffp1Z48YSAGSwIuhwOlzkA==
X-CSE-MsgGUID: 5s7nEOmTQVuiXgjpbqwxXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76671584"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76671584"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 09:27:42 -0700
X-CSE-ConnectionGUID: YRhKGafTR9ilbMB+zHvivQ==
X-CSE-MsgGUID: ixMRr7NySi+VNa7StjKZ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="251664689"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 09:27:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:27:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 09:27:39 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:27:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvZ3C/MPn/lXFISjdTwFX9rWlE4TVGX8HSEXM9oygPLAtg4SY36Nczcdd3BXUwVdcPAsipYj2uLUtiNYqpQ4bHRUgbqQDwAYSP28LW6mVsBwmTCJz5EhHvN33qfic7Ml7tzVJ6kf6rrBCpt9HmwAjrXp15RoZ2jmBFA9673oC/Iv8L9wZW25X7zowTV9DK75O+jrRXFp3O+evu49dOb7iz6Iox8yyRxDCCyRz1VrHLAcCiy1wyXpYuxlk+KuOxm03jgL6mIdy4LobBbZN4BTacnkfl8/Q8deCLqsLKt0i9X3HoCeCw9GHYP1qdzC7SH+4G3nKwoobv1b1hm9TuPuiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuOrMzqFj+7HMqs8ZHt6iN5aN8ycjCMRSXMs5JPWrnA=;
 b=bW4hLxPl1z2KXd+MdFvY6Nv5vRb7A1HHEO1lULPgRKZCFWIA0+KMUMZpKL5P2oqP0J1NP7uds0891jh0SYdqWhKCGw9ZcmOMgv3Qvx1vsofjnUh4MYINIEoKEflUwyc1Map8oeH5ilyjJsy0fuo7BzJGtkTtISsuQPRy1eipciZWUVRyaz5st39lvWXjTXNqYNgCIkOgHCgLeALPa36TAfVFxT59r6BIp5/ayy8iCxQLL6uvZHrXQMGA43fuUMNF66B+dErRPzKq8RndvV0YR6n2FoudKSQZzHOdWrp8JvuanEZZUeoRDYByM+Q7QyY+HP5s+ZFWfM1NQAqF6PTwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 8 Apr
 2026 16:27:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 16:27:34 +0000
Date: Wed, 8 Apr 2026 17:27:29 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <manoj.kumar.subbarao@intel.com>, <aman.deep.singh@intel.com>,
 <dev@dpdk.org>, <rajesh3.kumar@intel.com>
Subject: Re: [PATCH v3 1/2] net/iavf: remove PHC polling from Rx datapath
Message-ID: <adaB8ar4Kb5lzpAD@bricha3-mobl1.ger.corp.intel.com>
References: <20260402154655.1540930-2-soumyadeep.hore@intel.com>
 <20260406212208.1562899-1-soumyadeep.hore@intel.com>
 <20260406212208.1562899-2-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260406212208.1562899-2-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DUZPR01CA0123.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4f4ee3-7ad4-4fad-f1a2-08de958bbd24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: HwyeGrcWbNhl5B2Yz3L16BcPd8CSfrvdXYtQM9Ir54lA57+TGQyfu4qLlbqlxKJJWELsQGiETUYq88TO6LiJ8lnhvc/P83RWmRsXGp1RtaO2Ex5f3lYPsk4uyjKs+yDVMWaznutSIZVGZEb1d+lnIq+wsTz33FhtaBHUz7PDqfvunizlCTeAN1zWu4rYGzlhRcMd27VS6sdw+No8O56gnQlkMIcWMsZ1NCEeA4PFpokGBBZTyn1nawoMzFHp5Mt8jgmR2Npw1birQPISjx+z+ASXbFtBcroUrg8xoNfDyOBZq7sJyhPYjtPNvgwtzEOQ0jV13rqjA/mNVFn4L5c5L8VINjaHG5xURMEiX0gZGiCcoCro9EdBTTJudPqbGCH9WAuiPVZ3Wi3RuIVwjxgCQpH0u+a7zuGXcRUGjbsnaB9115QLidZFCuYExnwQzeRzTzeKOddN484t0fyCEEBMt0bWpbZJarulS0jEy0ofpMAjgFy96zYVpECVJRSPSS0GKsLYVU8UAvXGOOjbtGaWxRp7yZLgngLhoC2CCwgiN/8xh0nr0UR4vvBc8O90bXw0PolTV+xZU0GbvIdjSVoeCS3yVZVZvxwzFCJ18c60S7NE23x01Op1xxLyVmwv4alwNEJhUQFGO732QQS4vQaFdsAfmHJpSfbecda1THpw5zFpQC5BTGutZ9iXMXvDSsEM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d8Ib1xdHJXkvUQPW5SHAlYLtHTy9VCZLywUMiHci0Z6RzVULuPw8KwKpiTtZ?=
 =?us-ascii?Q?9VZV/TAdKtFx7NuuYy5c+K04Z0pmayFD7k50PCzQvz1c1+dWXH5P9L5H4j6x?=
 =?us-ascii?Q?9nzUk5wcMG9QkTcIaWuUh5RbHXu9QQKCucJf4P0ywKZqscw6qqqtyab3FMy3?=
 =?us-ascii?Q?dOnzuKIzc9DAW/7aZ5FUdC7TVqWnJFCN0B9lDNRhqHwSFE+mm0TUwTqE5nqf?=
 =?us-ascii?Q?mXwcToNcl5F1D/jRajo1L8iOY2HFG9NN7BZyrKRnDwo2uzHP55YM5pSnIiXe?=
 =?us-ascii?Q?knoMdCNJE9Hfc0REg33n7iC2CCLc7G3EO3uoOqKmNuaNYfQmns1HZHg4SUtD?=
 =?us-ascii?Q?/sa8L6ztc3TxMaQQwQgHQptYXBsMZ0jdPKXKqvcTigIUa8kZzh6gH8bMLW34?=
 =?us-ascii?Q?sBqpIVnAjMJN0xRvsbk0ZYgkiroOToTNl4P5DoRXyPjKaW0ZdDSaFBqHr+Ck?=
 =?us-ascii?Q?7zxfTVlbwv8ycfcicCKoJorvZOvslYLsDV5xN6YV0IaYFJRmlDc1YnlwTNyl?=
 =?us-ascii?Q?CQAdwkaTvVhjB0gwY307gai1k+K2G+rwdC7g6PE15lPzc48zlApGhMkxBDKT?=
 =?us-ascii?Q?VyoiW0TwWmbSUdU778GgalcfxqFPrlRVsTqTHBgFdQyyW0fYTYyzzGzF8+UK?=
 =?us-ascii?Q?Ys5T6Ns5zHXZBuCn2tj6N+a6YYtkETtbBAhVGcDhGEVSjDHuhrTuLl3ZX7rr?=
 =?us-ascii?Q?6lRfAt7MJ8lygfUDQfT54vSdJf41NstJK1vvOTgYPetZemMtraRi9i5Cwv6d?=
 =?us-ascii?Q?LsLiLupGcZqvcFbH0rG34TSFl+fXzKCBUv4xIprmiaXqUu1xSeAMFPsw1nUi?=
 =?us-ascii?Q?q6kN74icw/W71tSv/WLgp83Rq6yg5omLhUE9qmf5Ls6p70fMU994SNrQjz/u?=
 =?us-ascii?Q?knwLCclY6KV4Eul49TMGFGOw++N02fxRht+NIwzFD6oGV0ccmRndjied1DnJ?=
 =?us-ascii?Q?kxD3wc7y7soCKZC3TGKDh4dCRCboLagaoM7EQSjIbiOgKNDErGnOU2nvb6eE?=
 =?us-ascii?Q?EOqnNph2kcgBJrRxfOuHzVW1OUUt0mCVB/3Q76zQaP96eeO+OFZdIG0zD/nd?=
 =?us-ascii?Q?9FTNbACeSRixu781CNYjSykORiDIXZMc1ATo23anUREI0KjIQ5oXUv0hg+nK?=
 =?us-ascii?Q?jqNvFaoHT+yw9JNqDgx/weRzfDJSJTT+CMerapuNfYXhbRRwrgpVUu3gmfB5?=
 =?us-ascii?Q?qpilEO57TGEmVm3HMZmz/kOpuLwSWou1+Zj4fIwchw256GdYH6MT0oSTASf8?=
 =?us-ascii?Q?eclY5RfPuAY0kssJHWgzT3Q0CkWtSVdxV0jBfVDJ69hIw1ROWV+gh6XovMej?=
 =?us-ascii?Q?bHi9cNkBejNbQzw1EhwdiTYvpp4OkdBFt1Zd5pj48zCakwEabTav9aMvVDYb?=
 =?us-ascii?Q?qNrWwOMZ5LyPTSHUlCDz43rdQpVcz40+iDsIu4hzbJqSPERvySh5k2WFUER0?=
 =?us-ascii?Q?nHP6nPkPcxXZ9QD3OJuhAXtPEVsI8LGfpVV5RBREV1XEIZ2IB3IHsp3eIJAV?=
 =?us-ascii?Q?a1HlBc1WOAvc56fMLbcFWsZE+4XMF/OunZCEY/ZzRXFmAfINM8Qe6SGnFqCS?=
 =?us-ascii?Q?rd/rRgyaxoR0m36iNSodIdIxuny3lxAzzHSWOvZbSefzo/Jyeik8voixr3Ks?=
 =?us-ascii?Q?JH3QLwtcblWb3ytzlUtqC+eGd7Wp0FHBl5I69oTJbZAD1f96vlJczkTNGRvh?=
 =?us-ascii?Q?uTkV0w7PDh89PtEiz57Jj9FjUrXu3Jjfg4DQuN++/jAv/99fSkUR+CVKcxHK?=
 =?us-ascii?Q?o3/vpQwjphYk+CL5/bALueOCN1fpUIw=3D?=
X-Exchange-RoutingPolicyChecked: Azr1ZhxGT8g/WWglG//ZaJB6F1qoO6f9dGPgaW347VZmK33SqJMsUZUzMBDJTcSjwPxKGP7hUYlHeYd8K2GNuRSp2mzH36XBb3IW5j/QFS0myf7O1J32eCtqOB6GbcMv5sR95dAD66WyI0huLHmldgyIUjh/CVsWQ1BNmMHZ5m1ZVCk1Uz3Dy74bCJLg2qgJF02gDbgVoaXuqHV/TBI5N9th2WMp9X8M3z3GzcfaIJ4zn4Jd7+SAtuM31onW83b8XQWr3LyazDns0YLgEYXYFl924vnTe2VGhXQ4Q7cwA0jTUtRIfGzz6zSTfh5LtzT1Z689yDQI6pT7nLKhbZ7fsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4f4ee3-7ad4-4fad-f1a2-08de958bbd24
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 16:27:34.1889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+1V3kf6W3451mQWtoc/lHtugtS7euX3BgIDoe9KnTAvOzif9qPbtGDPueVSnnPHYnE45Yi3HHp7q55+T/GimtQ5LhP4N66AMCngqCe/5S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5191
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

On Mon, Apr 06, 2026 at 05:22:07PM -0400, Soumyadeep Hore wrote:
> Remove periodic PHC read/update checks from scalar and vector flex
> RX paths, keeping timestamp conversion based on queue PHC state.
> 
> This avoids hot-path PHC polling overhead and preserves the latency
> fix for RX timestamp-enabled traffic.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_rxtx.c            | 34 -------------------
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 24 ++-----------
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 26 ++------------
>  3 files changed, 6 insertions(+), 78 deletions(-)
>

With all the code deletions, does the feature still work after this patch?
If not, I will probably need to squash patches 1 & 2 together on apply so
that the feature is not broken in the middle of the set.

Also, patches are missing fixes lines and the reference to the relevant
bugzilla [1].

Thanks,
/Bruce

[1] https://bugs.dpdk.org/show_bug.cgi?id=1898
 
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> index 4ff6c18dc4..fabccc89bf 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -1507,16 +1507,6 @@ iavf_recv_pkts_flex_rxd(void *rx_queue,
>  	rx_ring = rxq->rx_flex_ring;
>  	ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
>  
> -	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
> -		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
> -
> -		if (sw_cur_time - rxq->hw_time_update > 4) {
> -			if (iavf_get_phc_time(rxq))
> -				PMD_DRV_LOG(ERR, "get physical time failed");
> -			rxq->hw_time_update = sw_cur_time;
> -		}
> -	}
> -
>  	while (nb_rx < nb_pkts) {
>  		rxdp = &rx_ring[rx_id];
>  		rx_stat_err0 = rte_le_to_cpu_16(rxdp->wb.status_error0);
> @@ -1585,7 +1575,6 @@ iavf_recv_pkts_flex_rxd(void *rx_queue,
>  				rte_le_to_cpu_32(rxd.wb.flex_ts.ts_high));
>  
>  			rxq->phc_time = ts_ns;
> -			rxq->hw_time_update = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
>  
>  			*RTE_MBUF_DYNFIELD(rxm,
>  				iavf_timestamp_dynfield_offset,
> @@ -1627,16 +1616,6 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
>  	volatile union ci_rx_flex_desc *rxdp;
>  	const uint32_t *ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
>  
> -	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
> -		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
> -
> -		if (sw_cur_time - rxq->hw_time_update > 4) {
> -			if (iavf_get_phc_time(rxq))
> -				PMD_DRV_LOG(ERR, "get physical time failed");
> -			rxq->hw_time_update = sw_cur_time;
> -		}
> -	}
> -
>  	while (nb_rx < nb_pkts) {
>  		rxdp = &rx_ring[rx_id];
>  		rx_stat_err0 = rte_le_to_cpu_16(rxdp->wb.status_error0);
> @@ -1755,7 +1734,6 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
>  				rte_le_to_cpu_32(rxd.wb.flex_ts.ts_high));
>  
>  			rxq->phc_time = ts_ns;
> -			rxq->hw_time_update = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
>  
>  			*RTE_MBUF_DYNFIELD(first_seg,
>  				iavf_timestamp_dynfield_offset,
> @@ -1969,16 +1947,6 @@ iavf_rx_scan_hw_ring_flex_rxd(struct ci_rx_queue *rxq,
>  	if (!(stat_err0 & (1 << IAVF_RX_FLEX_DESC_STATUS0_DD_S)))
>  		return 0;
>  
> -	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
> -		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
> -
> -		if (sw_cur_time - rxq->hw_time_update > 4) {
> -			if (iavf_get_phc_time(rxq))
> -				PMD_DRV_LOG(ERR, "get physical time failed");
> -			rxq->hw_time_update = sw_cur_time;
> -		}
> -	}
> -
>  	/* Scan LOOK_AHEAD descriptors at a time to determine which
>  	 * descriptors reference packets that are ready to be received.
>  	 */
> @@ -2041,8 +2009,6 @@ iavf_rx_scan_hw_ring_flex_rxd(struct ci_rx_queue *rxq,
>  					rte_le_to_cpu_32(rxdp[j].wb.flex_ts.ts_high));
>  
>  				rxq->phc_time = ts_ns;
> -				rxq->hw_time_update = rte_get_timer_cycles() /
> -					(rte_get_timer_hz() / 1000);
>  
>  				*RTE_MBUF_DYNFIELD(mb,
>  					iavf_timestamp_dynfield_offset,
> diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
> index db0462f0f5..c91123ead4 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
> @@ -514,19 +514,8 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct ci_rx_queue *rxq,
>  	if (!(rxdp->wb.status_error0 &
>  			rte_cpu_to_le_32(1 << IAVF_RX_FLEX_DESC_STATUS0_DD_S)))
>  		return 0;
> -	bool is_tsinit = false;
>  	uint8_t inflection_point = 0;
>  	__m256i hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, rxq->phc_time);
> -	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
> -		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
> -
> -		if (unlikely(sw_cur_time - rxq->hw_time_update > 4)) {
> -			hw_low_last = _mm256_setzero_si256();
> -			is_tsinit = 1;
> -		} else {
> -			hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, rxq->phc_time);
> -		}
> -	}
>  
>  	/* constants used in processing loop */
>  	const __m256i crc_adjust =
> @@ -1152,14 +1141,9 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct ci_rx_queue *rxq,
>  					*RTE_MBUF_DYNFIELD(rx_pkts[i + 7],
>  						iavf_timestamp_dynfield_offset, uint32_t *) = _mm256_extract_epi32(ts_low1, 7);
>  
> -					if (unlikely(is_tsinit)) {
> -						uint32_t in_timestamp;
> -						if (iavf_get_phc_time(rxq))
> -							PMD_DRV_LOG(ERR, "get physical time failed");
> -						in_timestamp = *RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
> -								iavf_timestamp_dynfield_offset, uint32_t *);
> -						rxq->phc_time = iavf_tstamp_convert_32b_64b(rxq->phc_time, in_timestamp);
> -					}
> +					rxq->phc_time = iavf_tstamp_convert_32b_64b(rxq->phc_time,
> +						*RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
> +						iavf_timestamp_dynfield_offset, uint32_t *));
>  
>  					*RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
>  						iavf_timestamp_dynfield_offset + 4, uint32_t *) = (uint32_t)(rxq->phc_time >> 32);
> @@ -1388,8 +1372,6 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct ci_rx_queue *rxq,
>  				PMD_DRV_LOG(ERR, "invalid inflection point for rx timestamp");
>  				break;
>  			}
> -
> -			rxq->hw_time_update = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
>  		}
>  		if (burst != IAVF_VPMD_DESCS_PER_LOOP_WIDE)
>  			break;
> diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> index 4e8bf94fa0..a7c0a02eba 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> @@ -615,19 +615,7 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct ci_rx_queue *rxq,
>  
>  #ifdef IAVF_RX_TS_OFFLOAD
>  	uint8_t inflection_point = 0;
> -	bool is_tsinit = false;
>  	__m256i hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, (uint32_t)rxq->phc_time);
> -
> -	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
> -		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
> -
> -		if (unlikely(sw_cur_time - rxq->hw_time_update > 4)) {
> -			hw_low_last = _mm256_setzero_si256();
> -			is_tsinit = 1;
> -		} else {
> -			hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, (uint32_t)rxq->phc_time);
> -		}
> -	}
>  #endif
>  
>  	/* constants used in processing loop */
> @@ -1343,15 +1331,9 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct ci_rx_queue *rxq,
>  					*RTE_MBUF_DYNFIELD(rx_pkts[i + 7],
>  						iavf_timestamp_dynfield_offset, uint32_t *) = _mm256_extract_epi32(ts_low1, 7);
>  
> -					if (unlikely(is_tsinit)) {
> -						uint32_t in_timestamp;
> -
> -						if (iavf_get_phc_time(rxq))
> -							PMD_DRV_LOG(ERR, "get physical time failed");
> -						in_timestamp = *RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
> -										iavf_timestamp_dynfield_offset, uint32_t *);
> -						rxq->phc_time = iavf_tstamp_convert_32b_64b(rxq->phc_time, in_timestamp);
> -					}
> +					rxq->phc_time = iavf_tstamp_convert_32b_64b(rxq->phc_time,
> +						*RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
> +						iavf_timestamp_dynfield_offset, uint32_t *));
>  
>  					*RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
>  						iavf_timestamp_dynfield_offset + 4, uint32_t *) = (uint32_t)(rxq->phc_time >> 32);
> @@ -1584,8 +1566,6 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct ci_rx_queue *rxq,
>  				PMD_DRV_LOG(ERR, "invalid inflection point for rx timestamp");
>  				break;
>  			}
> -
> -			rxq->hw_time_update = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
>  		}
>  #endif
>  		if (burst != IAVF_VPMD_DESCS_PER_LOOP_WIDE)
> -- 
> 2.47.1
> 
