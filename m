Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AEBF013D5
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 08:44:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A48C4025E;
	Mon, 16 Mar 2026 09:44:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id D07104025E
 for <dev@dpdk.org>; Mon, 16 Mar 2026 09:44:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773650685; x=1805186685;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=OnKJLuoD3cgZD/rNl2GmdYSy1Du5Wd1ZM+oGiQ3Z9wE=;
 b=De1O2RMsqM0HGhv3gXTJXTiVA7/YYkhn0cpfxMgMgTG6c7dN/DkW7GXa
 H0jOlakWBE/hTJwG4U9V+w+3oH6vb18dANomhjdYa/htfBArCGarqGya6
 Y2Ho8v7XTEsyvJI/O3TW1TjQh2hhhw0kBwpdYs36o4hY0j7UvCsnvUXfd
 5XZe3QpyihFeh5jRD9sSJs56LT9iYPR8PLfYlpaujwLd0kh+WvjyFHY1H
 9BMY8OhsFcEBrKyZOdrfUKCKW2VPlbkaH8Lp0zYYkJUoKTXgalVMq/GYG
 mbP6F3fwOHsX5t7vLrQvElL7krv7TbNYxA6R02GGl/uq7Y56oJE+FBh97 A==;
X-CSE-ConnectionGUID: rvS5b3RbR4WWaIL56j3plg==
X-CSE-MsgGUID: WX0Yi98/T9uJU8xTxgo1mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="97270409"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="97270409"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 01:44:44 -0700
X-CSE-ConnectionGUID: j7QbohwMSLiXLzzPw3QcSw==
X-CSE-MsgGUID: VgekYWRoR6ikmx1QWPUVWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="221077074"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 01:44:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 01:44:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 01:44:43 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 01:44:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMFRRJz8CcX+1LmtBxSnrKS9qHPnuHzBRb5VkSxg8oNdTMwAmwZG4yLk9ylfW8GtGjNEKxS7m16x96nzwpzrBLOiaOQiou5BBQy4gBhuKvtEsGZY/DF3vdVFIbxpF94YiJjIcxNS00srr2BomQRS2ZGFDdma8ZwhPxezYxSyeY+qx0s46yTVH538J50CmXsh8+dgRzbVHGbRUMqTH+I3KpIUME5ANkJ/TnrFOZ22l587kadqZK0fr6fpzNvUG2dI2KaJurRzPPISm1FqKqrrskHaFAZzzR7gsXeatzKj+RGl6Mr1t/lIpKxdQpWCDHs3Xkn34+6Utok0hc2nSrVnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQx9rYhmObZMnw6bliaHSb6F76m23NB3nUTbG2zYiJg=;
 b=h+GfHAI694Z62XWQxEEREPl+Xz6bcHcwVEUY3ZXtP6G7G9PF7+mHAIOJPs8iVm16HTtCDA9qG+EwW1p6mfRvHL5r2qgJLpreydB15HliMC6LQZDS0PlplbkhgD4BTM+9499PQVshIYHHoyFR1lAdNkMt7plB8R61xCYLCWFSbz0Oc6iPVFQF5yKP9Xc5puLwweCl14zE+TSJM1I3mzlJ6JnukwjmZYXrt+qGz1cB+3JeIqpUsZMUXON7S8Ssw8Q6TD3iGeQvXpYOBoyHjJb6AIJHVY4sWn/uKTEvNH/qmci0ktFmBnIBLEy/qs5L/Bvg6V3CWZ2ikW/AePaYQVK8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB6496.namprd11.prod.outlook.com (2603:10b6:8:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 08:44:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 08:44:40 +0000
Date: Mon, 16 Mar 2026 08:44:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: Intel PMD fast free layer violation
Message-ID: <abfC8e0FOlkuJAjz@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F65793@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65793@smartserver.smartshare.dk>
X-ClientProxiedBy: DU6P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: b6efd0db-4722-4e4e-36c9-08de83384330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: uL1cY5zMfAwonHjr9coKZ10vLECmJkK++XTwNF/FHJZRWRMUw1ByDK9R6Z2/9A2NEnnOhQqY1xKSFy4VDTLdChyIVLk0PhQmMmqDGCLM+ewN+9/3YQw/ah/0if1NbWyjZ4qNxfFjoCQP0SgEc0pxgm8vOyuISD5gPO6xUsb1wjLbUZHiz/Z9a/7zJ+hUFraYGMQksU+UYoCLAYbc7VWROpeE07BpuRg4RaQ1Eux3rQo69TE2fm7K5Us+/wsnI+28ArncgI+KlFm7nfwZHM/+4El5iW62C0t9jEewBY/rAOO16F5U919zDwIH14W4jR3KVkEj5sRNJrqggSeYEC5jp9LSZBnCKqh/7vXUHG6Gkn6yqhMUAcXVP5Ku2Hn076HudToTO+rj976DTK864nG68MNhGKawieDCEo4zofZQtneYU2ZfLwLsBAeUL1YBqGYCG9BsH7bTX9d/0TpsE6aIxk/PbsW4+m1VD9l01qX8pcdIAVJA3IpTT0TI6E254xgE2DO41TGGYj9NulgSVt1KYVtLl3M9bYUdcw/7kPXM84q2yXkfbzIKTDwWK4XrF6nxEG0CUqEciOkEqlFGIi6J+I0iJS7uKPQyMG5ymtRaRdEOU09mW3zx+SoMDrZ6KguX08PLsWF8/q6tUoV3F9eAQ0VtzVybcpwqFBbacSo0fY8v+9xXXgtzqow382wKiYgrx7Zqwz4lbkhDiBIhcvhlPVJmvEqhDLUSoaslbBDRQ8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8z1XwJRDuMry6th0DFGEAkXph6yv3JKfSijrYDbZSVQKJDwunqCway02tD?=
 =?iso-8859-1?Q?MPrVpEjUnhoJr02dhNnzwQgdW2uha84deZbvV/PlzbWeSt8eSmRz6sCfHd?=
 =?iso-8859-1?Q?kEKruPF/tgl7qrrqSvIQz15oWCd+csh9mbOTIFPnc2hZX9OJ32evyDVP/Y?=
 =?iso-8859-1?Q?lKbPUH24WmSR9lQwcfR3BtEqJNF3jFT8Wzz9SdrP1UkUYw9vSTNoJ1w7oh?=
 =?iso-8859-1?Q?6UcmHmsA1C+5OxJTb9EEOjA/MapnL6qnpq/DmrrYvLMNlvae3Jna+J9MQF?=
 =?iso-8859-1?Q?Az18ZNc1Om4bJyR06DJzDxxacuZXMm4RR/3CWmg2oiUN1mw4dTFwSzyrHz?=
 =?iso-8859-1?Q?+vahbhqNn2EQFvbiB+xDJsAsn1AWOUTGCry/WQBl9rK2n4iBsIOsIrIhDa?=
 =?iso-8859-1?Q?UH+xIjQ/I0QqqOcEGb1xC8TLhr5gWzLL5PUom2lJeFRsXEr5riEWOmnVy2?=
 =?iso-8859-1?Q?Upo/9Lh+0C7YOkhnPCSdLM+nJQmawD/L1ZzbGONzXSYhIpgSDL/bZKptE0?=
 =?iso-8859-1?Q?N4SMJMwPljs43G+fnBRDfDSr9BoZskigmUGK+OR2lDgGj645w1G6WuIao8?=
 =?iso-8859-1?Q?WiX4NiUGSlgyIZJ0aPnOC8hmICIWsV8AeAXdS+0SZysRJqN4VqEhHVcGnG?=
 =?iso-8859-1?Q?YwRHOOWPYb2O2XQwMfF8laPSyvLzuPx1nZGb5QHZwOegXXtod5OQiU6rsf?=
 =?iso-8859-1?Q?oj4F89g5LgYeE5RaUsXgsBQFuj+Q1ApiZ4PJLGg+uVeVixUh8yBa1JG78R?=
 =?iso-8859-1?Q?9vRTv+2pdugTmoh8YfvXC7/YaKdj6ic5cn5kkf15IH4BlEXruYN2iH1TrD?=
 =?iso-8859-1?Q?bz4tAD/Cu1ZvU8CcJYPo7YOzvjWVNXqJtfSTk3aEvtVICfMyn00NCh2Ymq?=
 =?iso-8859-1?Q?YrOKs5rESiT87r7olePNF+f0VSFNX7cxe7i07E4hpXwew3zq+XHei1P0l4?=
 =?iso-8859-1?Q?oH9foteGiTvzQy3eFYkazceReiuHMXtApzxtIVuN4BstVSaF7MrZiMkRD9?=
 =?iso-8859-1?Q?lEILxFuux80u1IB1SZci8D/dFyvEBo9qSnSWzY52PXQr81OZlW2tTz4DQ5?=
 =?iso-8859-1?Q?XyP0BGWiTCOZla77y+Nvafih53gQWGfYsO1PgDMOn2HKSly8L04kdXyU+P?=
 =?iso-8859-1?Q?8Az+9UvVqu0bw5nGZKds/QaNQoODCdBwdyHwJE5H0VX98Py0jYD0zFcqHW?=
 =?iso-8859-1?Q?1V8SA/LGV0IcWe3T6xZJfAWtQXZWrJMyQ4FnvzSGRwrcbnXchLWBv5plUE?=
 =?iso-8859-1?Q?mPcH5+H6CCUrBTGZnycBm81gsruAm+9sYYurDE0AP3q9Ia/2J9cQ+Yiagi?=
 =?iso-8859-1?Q?4ZUGDDS2wTJaM+2S4bkHrNd6uyigngyf0qzOF1NwXAFfNuknIXeaq0jKvZ?=
 =?iso-8859-1?Q?or3booDgqs66vSB3fUDtxj25qy1PjlADg96CP4+hgV6m1qFXwCSS3l8MoW?=
 =?iso-8859-1?Q?lzqtE9lfr+QuGWK5orhgi5NAyCwNceW+cjEXafz8Arnv/xsfo27hI6ySVi?=
 =?iso-8859-1?Q?ACBKRpqJwgBKaoVhZR7R7IdB8vRGes70JAnkALdoF/6rxWMvS+k8jjG/o0?=
 =?iso-8859-1?Q?S3se5Rj/MiuZ2Uf/VfLll+eg6JkgeqocFpEpVQa3VlZAXgEIfCuQcl2gj3?=
 =?iso-8859-1?Q?fdEYxw4pQNYhw/IO92L4sz0z8RkOTw3Q9xb020rnkjgiCiF6nC+nmCOrwy?=
 =?iso-8859-1?Q?WH/aRKcdMAFIz88IrbGIOK3kLRKvqQBEd3ixRVLJ3Pw+usdBSnFZ/9Nlna?=
 =?iso-8859-1?Q?KfbGmTnSxFtyip4h59ZSoNs8ePJbUoF9eTwqzmqWM9TPA3SOThSE74yTT+?=
 =?iso-8859-1?Q?011mWVp/1KB5czlVKXESue9WYhWhtV8=3D?=
X-Exchange-RoutingPolicyChecked: na+maHpthYJqWg84cX4iEWf/UzeA/K689Sf0C6lotRJr71twVKBV0Z3YXnW1NPY1lTvoU1ovyTcjKK70JN7+7QMkavqG7DoGx7Vt41IAFxKj3qbqksc5HVj6c2OlnyVYUqYCGH3/936lT2nOIZcIvYuqc4NLdfZGW9V3AXh0V7wWOCfcyCABl/k11gil0AoS62add19bLql9Z1x4WfpQW5yFhh6pa0w0bCqAgmMMqOb4q5lHUFwEVRQRvqhDkhQH95bDn+2MJ+WFXSXBI+0aWtseCUCYXs9Z5Mnhv7MrDW8025F0XA1UD4WV2V2p+lrhNpgnnnAVmohRIppnf/+6rQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6efd0db-4722-4e4e-36c9-08de83384330
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:44:40.5703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qx8Dah3FUFCPGWYGszUNV8ANS+8YgPKoZsAT9Qanm3czRULdSS6ZshsBP/6TFpVVJSjG4mXeEtaQz30TpSL9qomCalJaAgMEBSC1s0U/nsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6496
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

On Sat, Mar 14, 2026 at 08:41:27AM +0100, Morten Brørup wrote:
> Bruce,
> 
> I haven't looked at the Next-net-intel tree, so it might already have been fixed...
> 
> ci_tx_free_bufs_vec() in drivers/net/intel/common/tx.h has:
> 
> 	/* is fast-free enabled? */
> 	struct rte_mempool *mp =
> 			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
> 			txq->fast_free_mp :
> 			(txq->fast_free_mp = txep[0].mbuf->pool);
> 
> 	if (mp != NULL && (n & 31) == 0) {
> 		void **cache_objs;
> 		struct rte_mempool_cache *cache = rte_mempool_default_cache(mp, rte_lcore_id());
> 
> 		if (cache == NULL)
> 			goto normal;
> 
> 		cache_objs = &cache->objs[cache->len];
> 
> 		if (n > RTE_MEMPOOL_CACHE_MAX_SIZE) {
> 			rte_mempool_ops_enqueue_bulk(mp, (void *)txep, n);
> 			goto done;
> 		}
> 
> 		/* The cache follows the following algorithm
> 		 *   1. Add the objects to the cache
> 		 *   2. Anything greater than the cache min value (if it
> 		 *   crosses the cache flush threshold) is flushed to the ring.
> 		 */
> 		/* Add elements back into the cache */
> 		uint32_t copied = 0;
> 		/* n is multiple of 32 */
> 		while (copied < n) {
> 			memcpy(&cache_objs[copied], &txep[copied], 32 * sizeof(void *));
> 			copied += 32;
> 		}
> 		cache->len += n;
> 
> 		if (cache->len >= cache->flushthresh) {
> 			rte_mempool_ops_enqueue_bulk(mp, &cache->objs[cache->size],
> 					cache->len - cache->size);
> 			cache->len = cache->size;
> 		}
> 		goto done;
> 	}
> 
> It should be replaced by:
> 
> 	/* is fast-free enabled? */
> 	struct rte_mempool *mp =
> 			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
> 			txq->fast_free_mp :
> 			(txq->fast_free_mp = txep[0].mbuf->pool);
> 
> 	if (mp != NULL) {
> 		rte_mbuf_raw_free_bulk(mp, txep, n);
> 		goto done;
> 	}
> 
> This removes a layer violation and adds the missing mbuf sanity checks and mbuf history marks due to that layer violation.
> And it implements fast-free for bulks not a multiple of 32.
> 
Right, agreed that this would be better. Apart from the missing checks and
history, the current code is functionally correct right now, though? Unless
it's likely to break, I'd rather take this patch in 26.07 rather than risk
changing this code post-rc2 of this release. Any issue with that?

/Bruce
