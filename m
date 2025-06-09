Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C6AC61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 11:56:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E720C40A6C;
	Mon,  9 Jun 2025 13:56:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id F0CF14060F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 13:56:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749470207; x=1781006207;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=R1z8/YuLPwlc/5vL6lD7vltb8ZDtD1oFl7fIzHQXx/4=;
 b=T5np+qysp/MRPmTE0gEVZ/CqO0ETwuO7G7+Ea5sALW6Lx7D4509NlRpk
 GQOdC7M1H9RTDAQ1+L2pY9lR1MwuXEjSQcGSs7whGeAtj7xYsP1lAYt6F
 39Mq0kI8uGAn1KZX3J9mBzHTnxGA7SVk/4kaVRRZLPhMwFT8xP2WXK+aB
 4b1g7tR9n5KpPXengHgDrfiEQt8ibybKNpKHTXKXOq2e9HIAP396uZkhA
 vSM1bph+hzR1CORF/+Dr0QOocuej/6yDzizJpuaQDdqEn1OD7XJD7z3Pq
 PKX2Sx7WK3EY1kId0oNyvb/3uq1CoeyWzuq3Qq3HRHjacJ+5zmh2noE+I w==;
X-CSE-ConnectionGUID: 8nMObBziQMqTAD1WPnyQkA==
X-CSE-MsgGUID: Uy0R5+DwSmOzGEo9OILSpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="62579507"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="62579507"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 04:56:46 -0700
X-CSE-ConnectionGUID: o7JlRWUtRDu0Z4eHh0VOqg==
X-CSE-MsgGUID: zkD22UgtQUaMJULCycJetw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146846937"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 04:56:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 04:56:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 04:56:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.81)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 04:56:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmR+ExEEgyhU3oogi91dk6wmVAsFoMTQCne2FHYeiqotds/zEnbZ896qoV0tlz8lkwLM2g8fNsr0YKyIznDDjwEuxjXnGi1ncO71DkLmu9B5zB+81fNSX9p4WBrw7rcMvcL6ZyACjQPofOdBMmMhUOtsQxbYeZqqcQjaz0zmDU+kLlclLaG2m5RgwhNyu0IACH6cxtlOCNHoXyQURZAdgloNNjNd9qH4IK4ZMATuT6kKjv04GeeeJ0rKO9SP5G2ztB4eS6/Lmt8c8T4I3jI1SOthLARkm+evi3gXR4zBP3r9uHwzlR9I9J8HXiC6gJDb9S2hntYBpXOPrccpNaRKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKSfq73IIhvF4oBIl15/nE0L1gq+fZauarvPZb5DVuA=;
 b=CV4pRSq4b/MRTLbWKE0KfZnuxe993zmNC7TjyX8qrFJ+0UHi3Jj7QKEqiF7Cs+g7vtilH/JmaW+3v6UPJIno6KY+mdqqKvyyCGEdgnMIm8m1nZQY3dXYhn/lIzdyShBpPANuLCA1lqjescAOKhWwOKxrqCb83OKJFsWFy68HTydpuBSsm7s59zlBZcy/lnlBIvhNDYmMFzeAZx4ZPJdM5rNWp9IlDG3f3+7DNKCuJezh9CVGWpKeFZJGSNMgdRzHbvMTGzGqXw78GvAaAMmdss/apHRQ9AzbCKZiZa46tVFiwE80/+UrqrHGRbWrt1b04TcyIA/zfqaDZQ9CPGEtig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ1PR11MB6108.namprd11.prod.outlook.com (2603:10b6:a03:489::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 11:56:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 11:56:41 +0000
Date: Mon, 9 Jun 2025 12:56:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v5 19/34] net/ixgbe: add a desc done function
Message-ID: <aEbL9JxB-QK8xqMf@bricha3-mobl1.ger.corp.intel.com>
References: <75f2d5852f52e7b81b0036cb921e661edca8569b.1749229650.git.anatoly.burakov@intel.com>
 <a0493826-41d1-41f0-8b9c-b45c7894bb13@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a0493826-41d1-41f0-8b9c-b45c7894bb13@intel.com>
X-ClientProxiedBy: DUZPR01CA0056.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ1PR11MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: fffa5024-1b90-475e-6a7a-08dda74cb2dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ECF/5X4jI6HK0RX79u3+CTkeQ+N4uXbINlOdmfuqt/GXO5O+zmkj37BgA5Wo?=
 =?us-ascii?Q?Bw0RBUDLAweUj3Kj1H4cU5YmaXsBcckBZeorZUtuD2mnHgDjRFkTRY9NpkNv?=
 =?us-ascii?Q?g0mkauw8I+zNNF1KKFiSBNMMYrCjpDnRcRmh8fJZ98NUxs0IvWJgasjDAkdP?=
 =?us-ascii?Q?zeyJkKfUwCk5yTAnyaD1j1ivvLoJU7BgjHCp/PuWYdw2c9I7P+ifWaSdEd9L?=
 =?us-ascii?Q?GyAKZpTi1ni9BghFDF0dK8AWc8l7OLal6a2eAbVqwKs1pj0pUV0919MI/Duq?=
 =?us-ascii?Q?dUq3KFHH9C4M1+gOqGGat8tK1i0pSH5iPEQYoBL2wtjkgQUz8rEH7pZS0xk5?=
 =?us-ascii?Q?3+E2MaGRvfGWS5tnyg2sktUdtdzd6i1xjcvXgFRwIEXGaqsFh02P7b4xzv6T?=
 =?us-ascii?Q?oUoLATmvkS7xWZeXLTN4+ijKkMqeAdyXUdCDfEucag96Oq/+lEul7QMUCd/j?=
 =?us-ascii?Q?8HZYvXGkBueJoikHPrKCJraxTraQxO6q8vDH1ygWJiocrsFw2Ek8RXOJCP6v?=
 =?us-ascii?Q?xy2VEw7W/ygfMcD1WHwlO7gDBDLPjYcKJKgKV9zo5eA5KTzIWhmWZE3PzgVk?=
 =?us-ascii?Q?lwqHE8UDtMkuP4MGvWpfEvo/ruoB5c63+L5eH6fISafZc54+gCdAH+2QoJDd?=
 =?us-ascii?Q?napMvGZX7wLAt0roWI+CKPjA8QstLNCv+OPtPb3lFBcdKGxJegYUjw63EKo/?=
 =?us-ascii?Q?JvYCqAPM0Bd9fub2+2CewTV53iBVga6l9gDXTnVLgXqaINrWOEqOcVQV8vZL?=
 =?us-ascii?Q?CUywMnUwERgSrA/D3jnvu90s2DfKqNy1bLsw8idziSNA08wGLY+cCwXnaC+o?=
 =?us-ascii?Q?l/MyMzwUEfaOiVW72hgV5/6rcabCbHTqrCxp2btGA7RoIFd/bYPuAJ6QGJWu?=
 =?us-ascii?Q?IfaJqQO+eY1iaeCiQyICea0PTjW+ndkjq2+BbIkWPGRA3Hi9O2jibHV5rJHL?=
 =?us-ascii?Q?WIbwLTmhCMGCr9rYx/aaWEhiCPtg8aBw+aYU/EYB46IWPWTJ+3KBhG9UmgqZ?=
 =?us-ascii?Q?OQgAQIx3EVC9ZiA2ITZOr2CXS22jTS9WE1fZ8h2yJzV/UvHUDwZfLF/EJH5f?=
 =?us-ascii?Q?4o0E9nBwmR++ymmWThoVNcsJDCvs1zA1Tzi8QtpdFtjD+HEMul0rknjaT1ec?=
 =?us-ascii?Q?JWl9wYnT/w4UJ3YBWzkcPVvB5WZC63PRVGPK8RZWwtpJC7ARsuftkWseBygc?=
 =?us-ascii?Q?DUmALdRysp8quVOr6sDWlz9zUh94oBj0KP3kJXa8pMA+O8QIQeQGh+anKfIT?=
 =?us-ascii?Q?6JL7sPAIK+HLlQNhI/8riEFy6haNOoEWCvqmg4rWnA6MVDyQTXxLRU0Cfqe0?=
 =?us-ascii?Q?LOuWBhzx989/pFY+0L3RFtS9xTMNk7nD83ll+x4pJkKGDKTpLCfmo5ldepr1?=
 =?us-ascii?Q?EPZ27VZrgbUYUBuQX324vykXGJMOMDA57Jj9ZD+WxbqaC56SVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZQ+VJsDx66Zy/VP7CU6WgKXy0pdMLYJTuxLo0IYmXKVdqVR0529hTfoCOp9n?=
 =?us-ascii?Q?T5fB+C/Qp4qdAZk1WMiMFEruiEUHrW2dhL0CPGAUC3qKmW8e70KhXyb2qgdq?=
 =?us-ascii?Q?LxmvI7JpmTqU6MU2VR6admtENYlP0s+aB+BTsbMYYR1o5u7lmYgEXLMetZ7q?=
 =?us-ascii?Q?l0N+Vi7p+ALuy100krTNRUgrnS6GvFWadbIUPKDpDZ4FgTHrAucqacTpbTfV?=
 =?us-ascii?Q?dwdUO5uslV0TepeDhWuiqf4ge7ypVb6rs6lnRaWhbTK3B7TPG6qh4XzCzeby?=
 =?us-ascii?Q?hgjGXO3eXKFtCgYCQ6Pia2lYhScV7SxhYb06W6d+ENpVIwWPSXeJiVEgaKYP?=
 =?us-ascii?Q?t5gO/Wxi/snuW17UMGGtToPAf65/jBkOOzW4j61apyjYH17WRA4v/EiDLwaF?=
 =?us-ascii?Q?83u3BHvaQ9SN1G2Pq0aZFvQcLccy4BxHhj+jkQwiJkNX+V9Z5EC0L5kncexD?=
 =?us-ascii?Q?1E6Hd/LLojqA62xvJ8yaFsmFV11jAt924i0u3XFX09Nj6j9QR69HY1Pz8ha1?=
 =?us-ascii?Q?x1ZEo9MuJ2QKAJM6LNEZUlv5C60tEGWyrE1MC7cIyYiHYOzM1PzEZpd2Nv3P?=
 =?us-ascii?Q?knFl487yN/7c7Os73535i072gcGun1maXIeZn1Bfn7rVBdAblxTn3Gq6awKY?=
 =?us-ascii?Q?Alf8Ay6ZIfw8wJXxXv3HdL30+KhUS31yh9z2g7HaGUMqorlD7VDtJcOmezTs?=
 =?us-ascii?Q?SM5hL126AbHzkkS4jccNMWGc+QAHEpt5kyB8ahHYFnh0ovWKVbjL9ygO3rRJ?=
 =?us-ascii?Q?pkDTeDkdY6ztUWbLFb5c9fvgbqky4nTSCknICWkmG5QhhybEhsDJA7ik/tvm?=
 =?us-ascii?Q?Y8dtEWlNXGlvoSMsbGEwtvx7PxGXn3k47OVFj19btxxROwaCJH1hdzBY/lJ6?=
 =?us-ascii?Q?nOLYXjVI/eTPilRXDcPs8tPHtuPNjqG/ZNVG5TVZ13G1hGgBoGXa3ssjMlGf?=
 =?us-ascii?Q?3xKL0tO9zRNq/c/6P1aWOMfy9aXMZ9pEp05Epu+kH+OrQGxiywYHQayykCFk?=
 =?us-ascii?Q?3l/N5L2tyX5nA7pzBpw50M6P/Qv4YTdhATWwg32Xw8/1wCrMPx2qdUn/ssXQ?=
 =?us-ascii?Q?3LkfRhpc/v8WrUqdsFDWuq5myEBAvS2f1SwhF49DMG9EntkdIswmUqlQmr7C?=
 =?us-ascii?Q?YXdzOCmYV+B4jsA02WCF19B1n7nFPZWr2lYYjcTTPbB2Tjfwc8qmNcQO1tG7?=
 =?us-ascii?Q?zTPydd7qTFbY+uJ6PM38vBWGUIHUS261NvbHCRf/K8R7GhrYhv5SDiphFGjo?=
 =?us-ascii?Q?ED3nhOsykR1/3U6NkR0ovk08am+p3dZA3LXFhCOfb8JVg/y4HcjLtvnDjsug?=
 =?us-ascii?Q?rnpAQW7iCobY4SuRpeg4gjccvdrAjT7Ti/4qMOMAkvhvYfITOjPy/BVRCPkN?=
 =?us-ascii?Q?n5BQiQkHho1FohJ7+Ok3javNw9oCRuDiQBAXzebL1nBR2tENzezi+SjMsKSa?=
 =?us-ascii?Q?hoe1F7YIIg4dVQr+xefokvAsjqG/lWubHuN+8otNe7bIj0IQixxaDQIUjLwi?=
 =?us-ascii?Q?Y67+OHFL5sMTcL6O5DSNr33aXX06Z//nAYGVl7cYpSBDiFhH3ytEUiI0VVM9?=
 =?us-ascii?Q?r9PBxv2rM5ZVCExaGnN/tSdf1BGUb6WryxUW80bnf+2ZQ+pwcUH6/j2Juq6l?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fffa5024-1b90-475e-6a7a-08dda74cb2dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 11:56:41.8757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LvC6N4HLFWNuLEuDbnEXLkx4ijxeegNg/C4t56OikQ4WhMp5FsKh52xtIyooz+nLTYJ/qGgU6TFVx9DGlFCaBsgP8Xi8JAhQw4bUKQGxBI=
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

On Mon, Jun 09, 2025 at 11:04:39AM +0200, Burakov, Anatoly wrote:
> On 6/6/2025 7:08 PM, Anatoly Burakov wrote:
> > Add a function to check DD bit status, and use it everywhere we do these
> > checks.
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> > 
> > Notes:
> >      v5:
> >      - Add this commit
> > 
> >   drivers/net/intel/ixgbe/ixgbe_rxtx.c            |  8 ++------
> >   drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c |  4 +---
> >   drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h | 12 +++++++++---
> >   3 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> > index 5f0aedb4cd..50060ce64e 100644
> > --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> > +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> > @@ -118,13 +118,11 @@ static __rte_always_inline int
> >   ixgbe_tx_free_bufs(struct ci_tx_queue *txq)
> >   {
> >   	struct ci_tx_entry *txep;
> > -	uint32_t status;
> >   	int i, nb_free = 0;
> >   	struct rte_mbuf *m, *free[RTE_IXGBE_TX_MAX_FREE_BUF_SZ];
> >   	/* check DD bit on threshold descriptor */
> > -	status = txq->ixgbe_tx_ring[txq->tx_next_dd].wb.status;
> > -	if (!(status & rte_cpu_to_le_32(IXGBE_ADVTXD_STAT_DD)))
> > +	if (!ixgbe_tx_desc_done(txq, txq->tx_next_dd))
> >   		return 0;
> >   	/*
> > @@ -3412,7 +3410,6 @@ int
> >   ixgbe_dev_tx_descriptor_status(void *tx_queue, uint16_t offset)
> >   {
> >   	struct ci_tx_queue *txq = tx_queue;
> > -	volatile uint32_t *status;
> >   	uint32_t desc;
> >   	if (unlikely(offset >= txq->nb_tx_desc))
> > @@ -3428,8 +3425,7 @@ ixgbe_dev_tx_descriptor_status(void *tx_queue, uint16_t offset)
> >   			desc -= txq->nb_tx_desc;
> >   	}
> > -	status = &txq->ixgbe_tx_ring[desc].wb.status;
> > -	if (*status & rte_cpu_to_le_32(IXGBE_ADVTXD_STAT_DD))
> > +	if (ixgbe_tx_desc_done(txq, desc))
> >   		return RTE_ETH_TX_DESC_DONE;
> >   	return RTE_ETH_TX_DESC_FULL;
> > diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
> > index cf6d3e4914..707dc7f5f9 100644
> > --- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
> > +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
> > @@ -215,7 +215,6 @@ ixgbe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
> >   	struct ci_tx_entry *txep;
> >   	struct rte_mbuf **rxep;
> >   	int i, n;
> > -	uint32_t status;
> >   	uint16_t nb_recycle_mbufs;
> >   	uint16_t avail = 0;
> >   	uint16_t mbuf_ring_size = recycle_rxq_info->mbuf_ring_size;
> > @@ -232,8 +231,7 @@ ixgbe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
> >   		return 0;
> >   	/* check DD bits on threshold descriptor */
> > -	status = txq->ixgbe_tx_ring[txq->tx_next_dd].wb.status;
> > -	if (!(status & IXGBE_ADVTXD_STAT_DD))
> > +	if (!ixgbe_tx_desc_done(txq, txq->tx_next_dd))
> >   		return 0;
> >   	n = txq->tx_rs_thresh;
> > diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
> > index 4678a5dfd9..56e13b4125 100644
> > --- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
> > +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
> > @@ -25,19 +25,25 @@ void ixgbe_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs);
> >   uint16_t ixgbe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
> >   		struct rte_eth_recycle_rxq_info *recycle_rxq_info);
> > +static inline int
> > +ixgbe_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
> > +{
> > +	const uint32_t status = txq->ixgbe_tx_ring[idx].wb.status;
> > +
> > +	return !!(status & rte_cpu_to_le_32(IXGBE_ADVTXD_STAT_DD));
> > +}
> > +
> 
> This causes compilation errors down the line because vec_common isn't
> included by drivers that don't support vector driver, so I'll move this to
> ixgbe_rxtx.h in v6.
> 
> (alternatively, we can keep the stubs and not do conditional inclusion of
> vector code headers)
> 
When fixed, you can include my ack:

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

