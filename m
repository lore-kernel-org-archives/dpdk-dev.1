Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB9AC44527
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:19:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 332AD402A7;
	Mon, 20 Jul 2026 12:19:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 539654028C
 for <dev@dpdk.org>; Mon, 20 Jul 2026 12:19:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784542772; x=1816078772;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=7F8qMTjn1pXvKezU9eK/UIxSkrH3pu9vWPb66Gi6B6s=;
 b=Io0TfGuQYkLLV2AVW3VuSnsmyxvOok8CgVKmVcn2gIvPKddyZls3RPfC
 gVWr4kjp3KZbGH8xH7k0/FFxcP8SE4UrDuLGNE+EySjdK8subCSz41rmF
 hgDfHmq5GDxKQjF7Jk/DzO43Jmt1K5ga1peJ8RGvdqu/gCVP6gCkl5k1Q
 +xPsWo1VWaDoxPEUjLEBGL3wqRONz+zwDvY6Ylg7+8Zk2e7OKJU6GUZDa
 dkLX5Kns/yt4MYTaZwaNObKKVyonOPPhlHlyM6ZwR4EysB7TveliaK9ks
 3peFakel3o/Q2v/RxH9sSdqZVKPUwQC86ew2KFJsuOA2Ehux+bUApF0pQ A==;
X-CSE-ConnectionGUID: qV4X2uRPSsCA4Cf0lQz1cA==
X-CSE-MsgGUID: 2NdCwGvoTXmMnMEI8BtjIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="72655669"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="72655669"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:19:31 -0700
X-CSE-ConnectionGUID: QDgN90H+SrKyGHLafoePbw==
X-CSE-MsgGUID: Gq4ICbItSjKbeGreCv8+ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="262378479"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:19:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 03:19:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 03:19:30 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.11) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 03:19:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSUl8kpJLoQNCPRknNK833O3dIDLP1F/bQJBrcsiQfOBSubQlTRze2N+7q+9LwlQTcl4iSYBRPW+PULkPKA4l6EdmaHmgmYA3KhKTcn63YLp+yOlciNlSGyIEbnOJiX4KKfIaMYLMyKRuXjeLC/rDLdVFcmTjiQqxo0UDpRU24wE4XmbrrTIiY1FUuMKRjgewqRR6cvuuO4ZJTwkcB9Em5C57DHzmq9y2xO672zCI9oo2XjHlPbIY8NBdw2XNV614UsEbN4AR52qfR9pIncwaFIwq9Ac+8zm17DwR9UmbDnvfFUJFlopqXN/cowGbC4umJYcxprYSja6QKeL+/fgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+wksV9ks+epvCF5JBl23tPXE+uXYZfwC76PamTpMGs=;
 b=HWZNhEG4zQyg9g0oax5Kky3TbkC/vu8fObFcbgcpD5ovM8Kjm19WpumPNJ/+L4ojuOJlV7So9R5rUh7oA5QZVKsFVaZ9Ka4dy3V9M9/TtAFqhCEUHDLpmmVlTrDl3H4aysxj4p7lHvDVMzdNurJ1bqt03j5I9eW1ZHGEq8g7xv3ccwYDNJ0CuYXPoMMKYTqqfiPzqARzUuoWewe2Cc8jGOQoNo7AFY5KXccdppqLiwunV62A+YlJ8CX3hn6Hq1yw+DvecruIDzD0Aeyh0hyigDmqPx7PUibq9j3/QbCkAgSkOODXhq9vDbOLYyRy6CJrMkzUdA9odapiWrtO+LfdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA3PR11MB7609.namprd11.prod.outlook.com (2603:10b6:806:319::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 10:19:22 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 10:19:22 +0000
Date: Mon, 20 Jul 2026 11:19:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, Vipin Varghese
 <vipin.varghese@amd.com>, <dev@dpdk.org>, Leyi Rong <leyi.rong@intel.com>,
 <qi.z.zhang@intel.com>, <wenzhuo.lu@intel.com>, <ferruh.yigit@intel.com>,
 <beilei.xing@intel.com>
Subject: Re: AVX512 block copy performance?
Message-ID: <al32I4FcmBAXTx3q@bricha3-mobl1.ger.corp.intel.com>
References: <20201215021945.103396-1-leyi.rong@intel.com>
 <20210114063951.2580-1-leyi.rong@intel.com>
 <20210114063951.2580-4-leyi.rong@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6597E@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6597E@smartserver.smartshare.dk>
X-ClientProxiedBy: DB8PR06CA0061.eurprd06.prod.outlook.com
 (2603:10a6:10:120::35) To SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA3PR11MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 9059b138-831c-483c-47cd-08dee6485d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|3023799007|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: okyMCbY9R+sGYCEJSA3lp8OMx/ZpT8OaaXC4vDXMZwAf9hKUdxDYkF4ZyzjslACjAUuZIKkSe7GVWd+7spix6c2+geBNPNqAxPfwCMQxMBhBe9e1vOt0BMmWxkiuv5C4lx/KIiCj0mTED8iCavk5tAVhEADI18zu2cKDI8PoYouz+Cr0VwrhMcuU/PczLDpUjo+YknSP+S8yQICMu8lO28jEdOkAO9xlQJxOj2WZ2h0YLKzJ0WVz+Byg1Dal3J1OjKfQfbkIy/wUB7vtTB6mw9IJFJcDIs1Yci6B9/XUh2qgn2xvTUYwznUpmv9xqCLTo/fbT4hQMHQnHhQck24XuqbpZCIQDtU2loPh/j8OGthuZ7dqBsBM9J82hc+h/rlMWVfgzC3vbp1qoYaLynNgS63EXvXFx0mvjr9u3o9CgsNenwsNQknELcG70GEcGZ2ebvDjNzDp6B4tBPcx6jKexpfgW1/tXBTQgStJXcGAQqvZsDq9SE2r+fRfsszAw4KaDYe4z6VD2JHGgdUMfk/uIzQYHklq5vRUhdm688x45/VmMKzfrlIu6LbOW1LrcdGmoj4xcPMcESJ8g45mCVOTGeDLC60p6brgv8IJCnseLA1u5qzfXCWMRyxlkZtokcRe14I96y/vzvQFDLjuYkcxF8Jf8M2u0m/NvzQkzPQvW5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(3023799007)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pKhiixgkD/Yo+I+AMjwagGYPyVuyo0YKKTBj9cXAY3APaLeP/8UXGO7JGN?=
 =?iso-8859-1?Q?F61NLtQp6w7+6V+A6iygVUoG2P11EQRPCOktBPvhUqla+c+os4K64a3kEA?=
 =?iso-8859-1?Q?xOwjMr8u5CY3o07M8dOskZJa2N2aJ4X4n6+o7aeyvpTLPN9gnRyESpDDlC?=
 =?iso-8859-1?Q?oBuibxZCjeNfJDSoGXlXO4K0MsR/1fQo0MyZCCy3BUhVEwFLE9uJS6hK71?=
 =?iso-8859-1?Q?2iY9IUYwdbjN263veGv1pVGHOKHqFrigEZ0VaUansXyyMUSUgdNSrHB8iE?=
 =?iso-8859-1?Q?gmwkoMOT+2hMWtHzzuCWsWkHbvg9yigOitLn90Uo54I8qWA/+FAgA16F7f?=
 =?iso-8859-1?Q?g/cLtBTGLz+4lEquMo0dSgbFulTE54R3svJHAmIl28uPYSzgb5kQYC4l0m?=
 =?iso-8859-1?Q?+557ewF3BavwrEbCOPmIMJGiyHHZwKHiyCKsIs2oKlVN7oplzl5CEEARH8?=
 =?iso-8859-1?Q?imnavdynXVlHW/HfTAFnu0LtN2UGnt7CPXeYndMm+BO3wM2+vAMq9iqQlG?=
 =?iso-8859-1?Q?yfExI6OydBTQqp+Mwa7LJVvwFrpCEQdBF0u4Fo/eXUR0D7clZMbeYrAv7i?=
 =?iso-8859-1?Q?kncbwKrfGmcH4fgR0Vm2GTBf3dlUV6hMbelwwqUOugmjJExFa4Bjt4v25Y?=
 =?iso-8859-1?Q?tgR7sWSELcnf++uoG0L2EreNRBypnZXAum230brTF41UhiAXKO0/TR3RlC?=
 =?iso-8859-1?Q?6GKxVpQ1d9XXKwmixtdZ4Tq4eZ0ldETvwoY07b6mhozThx5DENCjAK9joJ?=
 =?iso-8859-1?Q?GvV95evYfEcnwqyjy9gyzN3aK/DKfDo40FlPPM2bpY5KmBBevvc4vgl53H?=
 =?iso-8859-1?Q?WpHfZS1wi+5hEqhNAFBtPND7yEwmNAdJzwOn4YpllA2xnute0VV+P9n5YE?=
 =?iso-8859-1?Q?spedoXVnAXUpHp1A2Zi9smV5a5eyTaJ6Qlp0D49B0ehW1+OpvULjRbURXY?=
 =?iso-8859-1?Q?q11mdQEUnckOITs4Jh2c+hGSJ2aJ2R5wtycmKzSlQAM9bFqs492e/jzmqp?=
 =?iso-8859-1?Q?q88bJbM9UxU33n0Aa95xZlprNXmVNOhEUrpmIuGUtL22oibU4yUKnILCMB?=
 =?iso-8859-1?Q?br53SoghCVKbuhwnzFe+1c3oHrdUs6/62vSwjmYRip5Wymd48P74zqsft+?=
 =?iso-8859-1?Q?DDnGFi3gDiqbQAunCpT/YOH0EXICjVjsCN4FnLsjKzRiRPp6DeYsi5fsGd?=
 =?iso-8859-1?Q?g/T1j4JGde2HmRrKhojzCxpOtP1DiUbPgLyRvXnXY23/8Z1oqws8qSJEnz?=
 =?iso-8859-1?Q?WyM34OeI9QJ06oESXLqY+F9xBoB8BVFpYWRqwcONxwooZ/gk3gzgiLeani?=
 =?iso-8859-1?Q?3gWn4z/iZGUcOdu9davEAm7jMyVeqvR8ESiIpIjqtIoaLRGHQ0J+EIDN0B?=
 =?iso-8859-1?Q?uywG73P2ghPpWw6qbpvETQwS3Zi/BlJB3QeTEtSKb1GhxHGMFGl/GonoHt?=
 =?iso-8859-1?Q?UZete4Kgt+I3J97vnvdv6zOB8QIPUOO6mMA0bqhsp5tBzdWgPIUD9O4zKS?=
 =?iso-8859-1?Q?6lbPimaK6t8kZkFD+cSgOqCxJdRneihWebwdO0GlZTJUKaBcslzSdlbrua?=
 =?iso-8859-1?Q?pJyGnMxLd9HgSpd2SkB2GXqg+1Bq/OQpFNEiLUzou39qU0V+5qCi0DAtab?=
 =?iso-8859-1?Q?9ILeotavyZvtuVOSPRARgb7pMSzGOPCmlEZ6r2y+rK9xC8HHPkVUxw/HQE?=
 =?iso-8859-1?Q?VOKHh4iaB29JGnRR9oMTkCU4ZiL+YUPtFMzAFodkiB5sLPz/bVWUjOjZF6?=
 =?iso-8859-1?Q?xJEd8+TWgyz6ZXa3BEmfyLvEfWYrRJE2hudItny4W3MAYaHU07EqV3ReZW?=
 =?iso-8859-1?Q?MVTSB32p13PC8DaZqJXpqlpNEAZ2wIA=3D?=
X-Exchange-RoutingPolicyChecked: DAYU/SdEiDO0LZl+zc1Uan3mdcjokkd7nZkh8O55RKm5Io5/BrmWq1C0L7+rb6jul+Pyw01XNsZXfgpejBq62M0+LBoqkhDQT1WW+rDGmzlOUj2aBQkBnLwDlZPIeVkBeUdeVG01Dm/dQOsVUpI2ueGqe1AYpenkOwKKTUU34VkiGzl4/DfiT9396edDc6+59ziwjQ7RtR4gPUbIEcEdxcZh0gV7Z0HP+tJmI2dpBw3+8NCYOW4+12PwWdYjRsluiqZcb2cSm4WY3FwAefdWMrELxfSyfDEgUsxTEqnVrU9E7fgBRpe49h+/IG7XuUTwROrFS869Hp/o3XZxLehWjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9059b138-831c-483c-47cd-08dee6485d27
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFED9C9AC99.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 10:19:22.6976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SZJTXdiaCtLeunjVofp/Dw2g0rn+MHwxQ+kTnBAaufeA/m+Nptl8pAZUQwa2+rDDUt1CJ5w14z7AVp486sN2BSeFx6nP+dwmxGkQEPymHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7609
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

On Mon, Jul 20, 2026 at 12:10:34PM +0200, Morten Brørup wrote:
> > From: dev [mailto:dev-bounces@dpdk.org] On Behalf Of Leyi Rong
> > Sent: Thursday, 14 January 2021 07.40
> > 
> > Optimize Tx path by using AVX512 instructions and vectorize the
> > tx free bufs process.
> > 
> > Signed-off-by: Leyi Rong <leyi.rong@intel.com>
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> [...]
> 
> > +static __rte_always_inline int
> > +i40e_tx_free_bufs_avx512(struct i40e_tx_queue *txq)
> > +{
> > +	struct i40e_vec_tx_entry *txep;
> > +	uint32_t n;
> > +	uint32_t i;
> > +	int nb_free = 0;
> > +	struct rte_mbuf *m, *free[RTE_I40E_TX_MAX_FREE_BUF_SZ];
> > +
> > +	/* check DD bits on threshold descriptor */
> > +	if ((txq->tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
> > +			rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) !=
> > +			rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE))
> > +		return 0;
> > +
> > +	n = txq->tx_rs_thresh;
> > +
> > +	 /* first buffer to free from S/W ring is at index
> > +	  * tx_next_dd - (tx_rs_thresh-1)
> > +	  */
> > +	txep = (void *)txq->sw_ring;
> > +	txep += txq->tx_next_dd - (n - 1);
> > +
> > +	if (txq->offloads & DEV_TX_OFFLOAD_MBUF_FAST_FREE && (n & 31) ==
> > 0) {
> > +		struct rte_mempool *mp = txep[0].mbuf->pool;
> > +		void **cache_objs;
> > +		struct rte_mempool_cache *cache =
> > rte_mempool_default_cache(mp,
> > +				rte_lcore_id());
> > +
> > +		if (!cache || cache->len == 0)
> > +			goto normal;
> > +
> > +		cache_objs = &cache->objs[cache->len];
> > +
> > +		if (n > RTE_MEMPOOL_CACHE_MAX_SIZE) {
> > +			rte_mempool_ops_enqueue_bulk(mp, (void *)txep, n);
> > +			goto done;
> > +		}
> > +
> > +		/* The cache follows the following algorithm
> > +		 *   1. Add the objects to the cache
> > +		 *   2. Anything greater than the cache min value (if it
> > +		 *   crosses the cache flush threshold) is flushed to the
> > ring.
> > +		 */
> > +		/* Add elements back into the cache */
> > +		uint32_t copied = 0;
> > +		/* n is multiple of 32 */
> > +		while (copied < n) {
> > +			const __m512i a = _mm512_load_si512(&txep[copied]);
> > +			const __m512i b = _mm512_load_si512(&txep[copied +
> > 8]);
> > +			const __m512i c = _mm512_load_si512(&txep[copied +
> > 16]);
> > +			const __m512i d = _mm512_load_si512(&txep[copied +
> > 24]);
> > +
> > +			_mm512_storeu_si512(&cache_objs[copied], a);
> > +			_mm512_storeu_si512(&cache_objs[copied + 8], b);
> > +			_mm512_storeu_si512(&cache_objs[copied + 16], c);
> > +			_mm512_storeu_si512(&cache_objs[copied + 24], d);
> > +			copied += 32;
> > +		}
> 
> Do you have any indications about how this copy loop performs, compared to e.g. the 64-byte block copy in rte_memcpy() [1]?
> 
> [1]: https://github.com/DPDK/dpdk/blob/v26.07-rc4/lib/eal/x86/include/rte_memcpy.h#L657
> 
> I'm wondering if it would be worth adding something similar to the mempool library, for speeding up mbuf alloc/free.
> 
Possibly, but you also need to put in an additional checks for AVX-512 at
runtime. The reason that we are doing the 64-byte copies explicitly here is
that we are already in a function which is already using AVX-512 and for
which we have no penalty or branch to check for its presence. The check is
done at function pointer selection time for us. For inline copies, you may
have a cost for that, though hopefully it could be very minimal. Only way to
know is to test it out!

/Bruce
