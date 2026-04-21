Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D485EF89254
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 10:34:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00E194029D;
	Tue, 21 Apr 2026 12:34:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 375F24027C
 for <dev@dpdk.org>; Tue, 21 Apr 2026 12:34:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776767695; x=1808303695;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=eBDqDZ2t/TTySEGMGZDvCQs30lmwAJ/vB+5gziVdOs4=;
 b=BGmVSglcL+tb61DHQFk3hdGTvMEEOPXCFvAuJGOZaB7lwO2x1RAvl/Q6
 faHenWgqP40rY+7afjOERkiJIBrClaKWjc6oNr0mp97c+sSMYZoIK/92o
 V1Q7e5MJfG0w4RD8dA43v7PxI0/KakOl9g2vMwS53jLaidqPfHr/hz6jZ
 K9pFtfF6ulqzw0oaUNXkDxixIyEBJjw4f00Yolq/+iUwYMAnRl5OLcEZn
 OYDQmqJyV/Az7BVZ7vvsKESzTrAEJKZrllC2/gGYJzcRhV2GGuhhKEhSu
 /Adma6rNnj7UmEU+enowy41QIA6BwoV0YLRdGdPgldLQD0oGLUeuTDYTu A==;
X-CSE-ConnectionGUID: XsQc+qiPS66hKF3JFJ624Q==
X-CSE-MsgGUID: 1PRZk3OVRiqtPstz9kDWSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="65233777"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="65233777"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 03:34:54 -0700
X-CSE-ConnectionGUID: NX4vnBv2QqmtD16DgotyfQ==
X-CSE-MsgGUID: DdWJruVaSk+Po1zP/dZSKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="228838282"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 03:34:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 03:34:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 03:34:53 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 03:34:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Idd6AKyT0Dr892ewhCBeeSRTrkmofcRF83YZDDhi06AcYQZ4rm13z5MMCuNjZfBw/Wqe58giRshC/htSgOFgTsVdnEKlWdG0BrIed4W/RJNrJa6ZwIYqdNMBE7d5MQ+6NRtYn4NPjpfZpvGdRtRMCMkMZvOuAVg8hGdqY4MJIEnhqEbp6XMkKrPW0DL338OGM4tQyUtALgQXhVT0wVJoNjMZa9k1YQNxtgkTwgQXN2QL12p6byR5ZNffjFhVU6Ic6qFbGCvO7C2s43jLI8Byqt+eSUyvk6bKlTulHeOv9t4d94DHF4IeAbAU7qnR9gbzmMqXQkHsvwWw/mi/Du0YCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLLxMPVUj5BbcaJrmh09FrcwJDEJQhLYZdPYg/kDlC0=;
 b=dakZWc+xl8Bl2uvrD2fuDBn/uqVBg8342HGcvQR7qokLy0xfhaeulxiuChY2i8QmY0TDAtztMDcgBkzbyJ7J+Uh/Wm074yt/wKFBaKOWnYIEiCMP6klX7CS8RVLiDJqoWj/TiNszvFGzt2UDz3USPRIfcCQv4V+t4ppHiLLUF22gXrJuMhz5SpfArHcsBE3aRIwyJQGcOm2DfOFuOc4PrN1C9oyKK5LEiS9fYv1ZfEhbCC2vORiedaPrfPnvcfFnDq6ef1YAzn7TId5DBxbzSmq7PNtveaVQM9GzPDfu09mK/1bmNIt7Q1NTKB3JopaD4EJJ6c2I4V7ddyIDRVC82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CHXPR11MB9651.namprd11.prod.outlook.com (2603:10b6:610:2fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:34:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 10:34:51 +0000
Date: Tue, 21 Apr 2026 11:34:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/intel: do not bypass mbuf lib for mbuf fast-free
Message-ID: <aedSxmC4gskM6mHM@bricha3-mobl1.ger.corp.intel.com>
References: <20260418095639.10003-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260418095639.10003-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DU2P251CA0026.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CHXPR11MB9651:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2dc06b-eb93-4525-bdb7-08de9f919e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: tk/3BtNncLpeQ/uGIOXz5qnqI2ByrWg5YrxzoX63hEgzfIq38pzKngJqWqziwnRddR6vdRYxrnCGqHhJ91gMxRCqfGUt0nCk9P6DS/NbOzoeKGS5CU87tAVpsTPqfOJk/PJaYHVNydRqnTsETis7IPwte5As2E+G0UgZMitqdLeePMDrIu08sfOGidmWAFHRB0Tl3noLY+KACnPJsRooNkBOmQKjo/4h1BZj6JAHcCkrGQnSIoCtvtC2fFMXrml08CRUf1MwkbICQMGNd6s/NkDJIPRkahSjvSbWtjgIks1LnKIYX7UtxkoulFAumxO3RjCe2jq4ze/LP8FTULah4BqWrdYYQFc1BeySNOTZReUK9Crx1o+ugfg+OhG+3IYrjfsW/MXhy/l8qN2UYtvBpu2gMn+cT9gEv7ty/0zoozOG2K3jxMLDkgIEVMBPEfe1FmCH5olkutQx2cC0fZNqjqh9GTJhSYVngGnH+eHIVRzrEU30ESXax7zEfMzWRcc+8TUdj78NAg8o4cqP1efCtHzPDpFu7txQr4dzN8DYnSQyVJHDyIsyBs/YXEnyX+jk0Cu3devopP0DW0YBP/h2lOJFgLIlg6nOcvhfaatcES9KihD2GYpnivGgj+cytJcwcaktpvIYE4ZjCWwFxkpOioTjXf5fSPytNdNuiAJvTdVUPLLDPNCBomIkg1/V69Y4uY5VuXmSZMi8pU1ADy5Zf16a6BQw07WUQVyfrEwcv5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?J+RtKKCU1dTep8VFlP97+DedSLAs4neSQUM0w5cPLgV9eh7TB4XKnqEfqe?=
 =?iso-8859-1?Q?8ZG9xY0PwEixxZCNpQlFuNLiII+O4hElJpnjU6+5+mVNNjXw72IY8HvWYt?=
 =?iso-8859-1?Q?OJzv9P1yNgT0BNG7zrkBHgkiTDGMoJ+i1FPnP0lJFCadyBrAc6LxJrSRKe?=
 =?iso-8859-1?Q?LhfqqLkdzqatB/l626x6/HTSX56PjteWQEronL9g8o6HF2hixakIvhB0bm?=
 =?iso-8859-1?Q?mDsHxcCsx4pHenIGJeUOAjm7svQyh6eyITz3YUIWSGBeJUiqS64wBbhy7I?=
 =?iso-8859-1?Q?1W3x3hJt5pKtUkhPrycjJyuBFcIWJneGU7Jt+06rMAoG5w2vmNfcy1VIhu?=
 =?iso-8859-1?Q?smFGcrn77BV6q7GxNMES1Uhtpnut6V9jzkN8Bt2Op+xJIElPX1sTYp5/Pw?=
 =?iso-8859-1?Q?iAJ4v0v5MYdFRAJn3lGSHCOooIFPvHD+V5zZvMBftHaj5S4vMcApy3kbRM?=
 =?iso-8859-1?Q?tg4DNz0w6jNtzmoxKfrorhX3CXHZFUWli7+h1Wv+zfnxkMb+gHG/hyki0C?=
 =?iso-8859-1?Q?d+FiDg8mpjxWXTAlNzaT35gEEU2ntBAMCS1D23v8ydMMIjwxClAHr9h3MA?=
 =?iso-8859-1?Q?2xlEVpaQG6QW5HWvI0yyKOfTyIab/QCC2clSbmaJ9vmhRFMX4tLVxsCq17?=
 =?iso-8859-1?Q?RyFMLMYBsoXq2QcdCHUX3F7OV4n0L5svwmL+QmJPoDLK4EemDoaorYRCUJ?=
 =?iso-8859-1?Q?VnuRO/FvRxU3cSYuJZtoQKZXp3ZbOWl3RVSsBseTdR/BHJ1Wj7xtOd3Q3Q?=
 =?iso-8859-1?Q?L80G2wBe49fO+Qg4LgF7ykYUisNlogaYlCyc/aOvvYpfXU2j/uTOmGZUq3?=
 =?iso-8859-1?Q?bv0J74KfIh3fxjXlhyFc6EPMTgu30Uom41h/aDzbdV02h1wuQ9COvZAMIC?=
 =?iso-8859-1?Q?DkOwW9plaGFZbE3OQVZMI5nnApbNAmLAZ1ToOTxIsNZUkqZA3ys66VSShf?=
 =?iso-8859-1?Q?3fYdPE+lGbwJaQutfVJ2LXzWpG1pnG26a5SL2+srVvLO1zugtPlZ82FER+?=
 =?iso-8859-1?Q?jJxGqAKMsLpRoOraL3lCPL84Np5Ds7yfUNNod/87QK4KdBhmjozREi86JR?=
 =?iso-8859-1?Q?Z/CAM/3/2eQQbO3AHr9LTKLuE7CLDUq4l4LuysPoED97WyXBNy55hI99tv?=
 =?iso-8859-1?Q?GoVcvPk/TxxbJCOGZ0OJKUS4rH2KjDQIJ3YvifZ6yV2Ww/ewOdy1mT/zAM?=
 =?iso-8859-1?Q?cxnmTeHXORCkeSuePmtbwAt8tlWZ6XiBoDZyD7wVEiKDFS/ayzG+jj3hR7?=
 =?iso-8859-1?Q?8g10r3IohTcx7bhwECO0dEj7Nf4WmmZdPQYRHhM8sSI/6HfSvJOyys4FUw?=
 =?iso-8859-1?Q?wlSDp2KYaSUmHWA/O0K1osmQqJy0nJYfzOTC1S+9GPm1ARrG2MSFDe92jJ?=
 =?iso-8859-1?Q?gyP4Ya3Jqn2rAYfvvi3l5tDqcsD6cZ3Sfo+UBzMd9SyVci150JvFvQG9tg?=
 =?iso-8859-1?Q?B1Hr9Ds+tr/l1YU6nBzibsZesBPWV8gimeSCdMmhPxrqEVpox/5NUKlqwv?=
 =?iso-8859-1?Q?qCcaBvgnAJLC/vNNwTmsRyW5SNWdlnzYOHMDgC5r4tK89mAn/PS9Ok9mBQ?=
 =?iso-8859-1?Q?GsERRKgs8nFwxH1kuleeM35gM5sw9Z6riD/JFmAZKgg0Eeln4kBpOgr5nL?=
 =?iso-8859-1?Q?dhFej1IA4FDkdTedx7zf02TkCmfTBg7i710g/RJVUFEcMhvzi5XT35Dznl?=
 =?iso-8859-1?Q?sEtk7Wln5Ra7/ttflxtQRmXQWSpyUFy8OUlHoDI/LC6oMj/W5w40bSRy2Q?=
 =?iso-8859-1?Q?xyNGPmlpeCKih2SwuZGiy1h016QVOYCypw7rxe1uUVix2GUzxE7gURZl53?=
 =?iso-8859-1?Q?I/qDRKg1o5Cy4/7hjmGtud0qut+yH88=3D?=
X-Exchange-RoutingPolicyChecked: pj7GBsWzztwJg5Hu4SHyyIqVs7vMzmYv6/fjkf+0P8ifhORruJR5S5FP9Od232GtWoAoKAI+z6S0K4xzXgHdA8xpu6OalFe+EFF7VGJ86hN53rd1jAV6C+mWfeiCD8aoJouivyHWziP5vEWMgu4uPCrqXRPmJWgsf2ocN0wuPOEyudv6jzPUoN0GBzELCzdovU2q8FYFdJ7WyqvpnNu8bNvD2fBuYFz9EJnLuhFi3+fR+sACkKwAc7pe6AffmSurvYdL2e6RLrCLWA9ZwSDxgAPsEYBnjNxL2Lu9Ya7E1QLZ7xYOgtCIcaJZuPiR2/4NyezocZe9xG1J5V504yisfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2dc06b-eb93-4525-bdb7-08de9f919e9f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:34:51.6230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASxMbDBZbiB15QCe2yyNqjPUCJ2DM6nsEbwd53i9tQEZjXWnAsXY9Vb6e5Wm2YBCpEMHM/Y/AXBiM/GdQVrikD+C2k9Pgh/cEd1NBjLh+RI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR11MB9651
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

On Sat, Apr 18, 2026 at 09:56:38AM +0000, Morten Brørup wrote:
> Freeing mbufs directly into the mempool meant that mbuf instrumentation,
> including mbuf history marking, was omitted.
> The mbufs are now freed via the rte_mbuf_raw_free_bulk() function instead.
> 
> Added a static_assert to ensure that type casting the array of struct
> ci_tx_entry_vec to an array of rte_mbuf pointers remains sound.
> 
> Performance note:
> The (n & 31) condition was not removed.
> For the default tx_rs_thresh value (32), the condition will be true.
> And due to inlining, the rte_mbuf_raw_free_bulk() ends up in an
> rte_memcpy(), where the optimizer takes advantage of knowing that the
> lower bits are not set.
> This should compensate somewhat for removing the handcoded optimization of
> copying in chunks of 32 mbufs.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---

Ran a very quick perf test using a couple of 100G ports, no regression
seen with this patch, maybe even a slight perf bump. Therefore:

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Tested-by: Bruce Richardson <bruce.richardson@intel.com>

One comment inline below:

>  doc/guides/rel_notes/release_26_07.rst |  4 +++
>  drivers/net/intel/common/tx.h          | 36 +++-----------------------
>  2 files changed, 7 insertions(+), 33 deletions(-)
> 
> diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
> index 060b26ff61..9367d38b13 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -24,6 +24,10 @@ DPDK Release 26.07
>  New Features
>  ------------
>  
> +* **Updated Intel common driver.**
> +
> +  * Added missing mbuf history marking to vectorized Tx path for MBUF_FAST_FREE.
> +

I don't think this is a big enough change to require a release note update.
It's really more of a bug fix. If you are ok with it, I'd like to drop this
RN entry on apply of the patch?

>  .. This section should contain new features added in this release.
>     Sample format:
>  
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index 283bd58d5d..4a201da83c 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -285,42 +285,12 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq, ci_desc_done_fn desc_done, bool ctx
>  			(txq->fast_free_mp = txep[0].mbuf->pool);
>  
>  	if (mp != NULL && (n & 31) == 0) {
> -		void **cache_objs;
> -		struct rte_mempool_cache *cache = rte_mempool_default_cache(mp, rte_lcore_id());
> -
> -		if (cache == NULL)
> -			goto normal;
> -
> -		cache_objs = &cache->objs[cache->len];
> -
> -		if (n > RTE_MEMPOOL_CACHE_MAX_SIZE) {
> -			rte_mempool_ops_enqueue_bulk(mp, (void *)txep, n);
> -			goto done;
> -		}
> -
> -		/* The cache follows the following algorithm
> -		 *   1. Add the objects to the cache
> -		 *   2. Anything greater than the cache min value (if it
> -		 *   crosses the cache flush threshold) is flushed to the ring.
> -		 */
> -		/* Add elements back into the cache */
> -		uint32_t copied = 0;
> -		/* n is multiple of 32 */
> -		while (copied < n) {
> -			memcpy(&cache_objs[copied], &txep[copied], 32 * sizeof(void *));
> -			copied += 32;
> -		}
> -		cache->len += n;
> -
> -		if (cache->len >= cache->flushthresh) {
> -			rte_mempool_ops_enqueue_bulk(mp, &cache->objs[cache->size],
> -					cache->len - cache->size);
> -			cache->len = cache->size;
> -		}
> +		static_assert(sizeof(*txep) == sizeof(struct rte_mbuf *),
> +				"txep array is not similar to an array of rte_mbuf pointers");
> +		rte_mbuf_raw_free_bulk(mp, (void *)txep, n);
>  		goto done;
>  	}
>  
> -normal:
>  	m = rte_pktmbuf_prefree_seg(txep[0].mbuf);
>  	if (likely(m)) {
>  		free[0] = m;
> -- 
> 2.43.0
> 
