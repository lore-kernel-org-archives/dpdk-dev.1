Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB47DCCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 11:32:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F52D402EA;
	Tue,  4 Nov 2025 12:32:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2C4CB40285;
 Tue,  4 Nov 2025 12:32:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762255944; x=1793791944;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NlROMIDJTlXMgZ4GSGpJRvWF4GFd1qFmBtcWzQkIz2s=;
 b=ja6TZnxscTU5v5DNZmHTR1tK+egXaWJWfa1H9j0CH95/jzAKydSZAgWY
 D7CO4ahwYpWqTyZKqaamcMeFQQKd7F08KmwEHOaCfW95uFviVT7ap4Tkx
 6mEs1zGCe5ZzDmmUfg4yCIQm/iPS1gSxz8ouX51D5PoKCtTfHCLmaT/Pp
 fvrsWYtptubRlLDM58hF1FjiPD2IBV5IJSoFDGhAvI1f6PLZUd643f4Ze
 jSzIlz34IMrUb294Tz411QsnScyIzwdhGftYghg1pGFEb6verd3N53W2T
 zVjdzPRnqo0J/zPAMwYqEW4Dia4//G05KDroegpp0hn7oOpmdjHvDe0Yj g==;
X-CSE-ConnectionGUID: iDVl5BOkRHmachhwg3B6xw==
X-CSE-MsgGUID: PeLvOSaGQa+VEaCBAUyk/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="51918941"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="51918941"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 03:32:23 -0800
X-CSE-ConnectionGUID: BoVwwgzdQwO1KFHvt6sCiA==
X-CSE-MsgGUID: ALIvua6CSKyAxA5Ga98Mog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="192224713"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 03:32:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 03:32:22 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 03:32:22 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 03:32:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqYYj2OACg+9pdLZbW7jmTlTgqptNPl88CZgRuqG/dHL0+LRtWd1DzjL/SNQV/6aruGPzFbB3pe5HjaHKKRLReM01YG252NUc8te6hNJRhVeflTr/bcoyUIdjxseH47PKbcwBotMoTwq1L103F7sGyWJGcnfUeeSTMLeqHP00xtYFBAOdIZsFmrtO812JFgQO5lgmyy5g+1dvPQfQ0vVvAGb9f1Yvnv3qV0VIngQnX31YmqkKPXTLOv9xSBUa8JEFehnue7kY8YExfaVqhZJI7taFS5RrvFQrAzvHvThtnK0f3fFlWakpAGDG2Ge0P91yjNRT0aHHpIuMKGfC4xgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdW56erARqPOoMwd2cFRBy3lD2EyOdMcUnmsYqJC6sQ=;
 b=C9e1PvYQTO6JfI82S6RE12yTYKBlFS7pG1xrPDGhIhk2D22BIHQqKRI/ATdBLOjhFSwMTKBPbm+wgnT1LC4dwntQY/kDFoT7t+ZOJC8D8rWbLuQTstv6S8e/2qxIszCg/eizo9YChXnW2r1z/2tZ89zI1XOfroe7c3A8pSuL16wl5TNpn2Abc/sqp7d9TBc8aCNY3dmO+LuEop4Wc2Eeoh7sJlRN3HzL/+9Rji7TedeBKvlO9+b+EJgO7GOrGeLGPkeoQiR9Y5C2laLHJeYcA3y09UKxn2spENGnQCqBAblghdROcIon8Vy9SsMRrzPBAZ78frSkW2oKGXB/PurcPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7099.namprd11.prod.outlook.com (2603:10b6:510:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 4 Nov
 2025 11:32:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 11:32:20 +0000
Date: Tue, 4 Nov 2025 11:32:14 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <rajesh3.kumar@intel.com>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>, <ciara.loftus@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 2/3] net/ice: fix PTP clock corruption with TxPP
Message-ID: <aQnkPqqlK0vu12il@bricha3-mobl1.ger.corp.intel.com>
References: <20251027182801.191295-1-soumyadeep.hore@intel.com>
 <20251030173304.260209-1-soumyadeep.hore@intel.com>
 <20251030173304.260209-3-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251030173304.260209-3-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DUZPR01CA0194.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 33292a7b-3ab2-4dae-c381-08de1b95d0e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tEjTzA65K98UINei/OD/kLx/F+NaWXQsWijMyWgng53IkbxSUCJt2TTMJc5V?=
 =?us-ascii?Q?tocw29PKxImB/VGEMyLTKKDO4UlYXNITQY1slTWmL8A47OpyNmcB9TKeSMKY?=
 =?us-ascii?Q?WmhNeufH5JA443R7XqIxX5FevIdEXTxIj6kpND6vCy0gPUjUqFeFXEapr4Dw?=
 =?us-ascii?Q?WLLRzdTSc+DEpl5Pz0pPvUMcgO2crPVDS5WQ4w4IiTIRt88GxcZ7g8UoO4H2?=
 =?us-ascii?Q?2SZ4QQxN8oIRJull0IZoyMVr0T89Gm6hwKnlhsgIHvcQY/19BpExP93sQhod?=
 =?us-ascii?Q?19YVxk+eu9AwL6a1vghVVHyxq9+y0nyi19Q7WCFpgXEyHGDHpjkjQEyZlvof?=
 =?us-ascii?Q?DEbOQmaM9cDx3TIBsKvhgq6LqpC2MfqUAP5iOLhI9IugI8CkGmGR0XoWnIjB?=
 =?us-ascii?Q?IG6BAwFvAUtiv4dxW0LvlxcfRLieVMXImpDI7DS0+g12x7JWf7bWewI7InbG?=
 =?us-ascii?Q?jWPVr02PrIva75+EG/kjj4SnouTxNDD0keAov6/UI8dzKdyou6iPddr6xm0r?=
 =?us-ascii?Q?H6OSaIgK/xM4DZUCaHIDdnFLo4RUy1/3c/feZiE8xghKzpx07cyUXsLzl9zk?=
 =?us-ascii?Q?6yAhccSKHOclFtiCbeVG5ZzM6DBjk5A8Z9wSYM9mEI8YpN8dG7glAk0SCq6v?=
 =?us-ascii?Q?1j5/9tJ6XFoVKC1OGs9LOd0HZ+t/gjsPK1eW4arM798Oy16DUIAjaIAXDN4z?=
 =?us-ascii?Q?VpNdB5mrfpMQb4Y/gPKTvOaaNVJDPRqe3GuoOlTFWeethdtQ+F+dZYToRy3s?=
 =?us-ascii?Q?ywimWsE0aaSXuCg2e6E7p4OVj+JQSq1lcmzbFSsKu7xm1hsp5RWEXIkfjlLE?=
 =?us-ascii?Q?i6bGgBZlE61c5ePmwhBALoyXiJF5yuqz3v1yRHvfhZo0lOVFQJlth7rklF3W?=
 =?us-ascii?Q?a4+6+4AD8rMXMKw+5OPtONTCjYwo8TiiQoiafYTwqycnci8J+EFS2QULUCE+?=
 =?us-ascii?Q?ISGT5HGrkq8DbxTmWm/Sw9C0c1ixE55MDFsasIlofwSTJJ/iJC1h+4DX4hRI?=
 =?us-ascii?Q?ZU/qt9t02+pIFC3Phq54zOBlqcMrsJ4uhmyA+WolxNNndkKyNearLLShu/dX?=
 =?us-ascii?Q?24+CM/4wuLDj31jC2OX7ry6G7qExk1lXsv4rW7Xx+c3NQgZCZflIcWLPQ+QA?=
 =?us-ascii?Q?ujJ57ZymUcCeB/QbPGAZpjkh6M4yhxH2d3rk35wrRi0FXnkgWbdm7FOUQlDS?=
 =?us-ascii?Q?6CPSKsbWdDx+qc7hABFxCLbRoZhOxC6WTlAUwpmtmzU6W05nQZ6y13v5uars?=
 =?us-ascii?Q?d8mcnlEMUygCtbKnmZO6AYXFrGC7TtBwOkrOZsmC1BMD9yg6ufi8PMn3Hbot?=
 =?us-ascii?Q?DdK+UrNe0jWn4aVUN2KPe7u6ngdEQ+sq7h7Vqo1xNrENMUzecGsIvHzRUPYi?=
 =?us-ascii?Q?qhuascLdt79lyzUy+JJJHPWgAKd8MHBU0UjwtnzD/QJUmq8ZTLdPzkGEdGEC?=
 =?us-ascii?Q?xJlk23ii3+Z/yh4PCxhBvtUngAxfGtff?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ssWPqbUm8KyNYU3TkJ4OSIS0Q8/xMpLdSQvzCfWXW3oDdbxMgoy3He1rXaM8?=
 =?us-ascii?Q?w4W7kau/a10QLnJ6w8cJmzKnIen2AMuEjzjZa6+X5yCD9ZxnGesc+klVEU4y?=
 =?us-ascii?Q?2fbwQYxhn4Gq6hoY1oz9Y/ymKlMfrEAmuyuKJbJwFDC4yzlJLwOQjdgFhTgJ?=
 =?us-ascii?Q?novTf64aouRg5VqVA2rctXyJn9U1gbMY7mMkFacwPR+oQlYtrogNYKy0dxAG?=
 =?us-ascii?Q?CwaivDWN7w8DpZDKAmnMqxz362IU2VvXPpQbDHSjAaTRaH+AlE4pqvRRoRPU?=
 =?us-ascii?Q?HmQAArSCscyI5qnfMyzZ9kaGU5aCbewcYOFQVY/nL6OrXN0TbrFABWZhum0P?=
 =?us-ascii?Q?6MHZcNmSn+Wm1svZ5LIIDMQZaDzxDTY0WhjOEbEk+jlYkhIgqAqZR57DHshW?=
 =?us-ascii?Q?xtolDzFno2DTYnmmhFrY5685xfqTCK3GoUB2aTLamYW7A5GUiGROgXSvrwVc?=
 =?us-ascii?Q?38bywr1wxnHx1Y/EPXPl9dVuVW+Z2wkuVTXEHMxWvsxF9FHDJSTn8IsN/W8t?=
 =?us-ascii?Q?DmIR0IRSKGTGQL5oMfxmn60ED6KVg9LeiVuXRkGYDf6RgVVwHtMaca68DaZP?=
 =?us-ascii?Q?05yotr/n34aLb57qssH5RatDVZLnhFJ7yL7AkVi1fgGMZq+EM+ozvF38HK3r?=
 =?us-ascii?Q?gyGuHQLr5k2Qvzur8FQ/hqPD6yjKpZICl7MCEEEmh49pkrOowA/4QA8gVzEc?=
 =?us-ascii?Q?TmVwHPSHiMrF2408k5c08GQ06NQFqrvnRqahoooxn3qlEwyVkgav12qKOoSG?=
 =?us-ascii?Q?y+so+gGfjJXk929nUBoHdCugIhXzfnCcZtwXHenaCwgKbPKIIwhRxOIo7dcI?=
 =?us-ascii?Q?JdgatgHemzV0jof3LEqIB6C25jUYNUkeRNfd6LQGKlvakOWBKJDIro0eVREE?=
 =?us-ascii?Q?Ly1ijikBLfFqYBAVZjessHZDEf8ZiM4rmklndvZKrIWhLtbxui3xWn7eQJIZ?=
 =?us-ascii?Q?yOrrj7KJq8feePN/u7nhPQCMtXqVBePKVfV8gyCeYCq0yETlR3ibjuySX4/X?=
 =?us-ascii?Q?HtBnVlwfBrD7IunjJsxa5pie/A0xMr8UKlvxAEvBt4lJoXkMDU76ogWomkLH?=
 =?us-ascii?Q?5m2mLZ9SDwCejugMAEiqtlNtLeBvGs6vSyG8s8Z+awB9d3NKfMc3Oj3Ds3ei?=
 =?us-ascii?Q?ptV86rmZuiDE7Sx1Rg3LXLWF7zEbmwpLlA4zHo/8cxl//HeM375gAJOpOTIK?=
 =?us-ascii?Q?luGaXTS32rA5/kLZUoXNuiMPeRoYc4sKCw9t6lO2JYvA5DoEi4y0QTQVatE+?=
 =?us-ascii?Q?L94ohpq3wC+ulyzcQ3IGeN/8kVCeLvjk56Xgo8Fn3TsBJRQcldgUsXTi4aqo?=
 =?us-ascii?Q?i3BMO1nn3AeY4tSuMRMituf4YWiXTXedppp1THFvkfKw3+b+IkO2jt40Pwxo?=
 =?us-ascii?Q?4zHsjAC1/yV/teVr7lbR42l3BJStOD7LIqNGEJOBVozhJSoajUkix5TCTSFt?=
 =?us-ascii?Q?jjp1ko7DuAkf5mfPnnQvOM/jO/gJkVuwhocrCpGnPM0tFC1XcdFMOqOSIqsz?=
 =?us-ascii?Q?85Rd5w/IETUijghNGUuD7fOvCqRhaxiXzJutgxbqbawK+YuW4g19B0IJKBEg?=
 =?us-ascii?Q?fTBzU/HknZ4OlTg6r5eYfbF8xaNirX/SaXKJpMc9AZo3dZHRtp0wmElIZoQ8?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33292a7b-3ab2-4dae-c381-08de1b95d0e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 11:32:20.4708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k17iP9Bnyo8/GDUdubuCVRArpMCZcbMArMXPHWZqlE8cmSM7F8cXYyepeTkIZqMDCfznOgrdNonCwr3yjMCZjIqAkYxK54M7dUao1VZqxDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7099
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

On Thu, Oct 30, 2025 at 01:33:03PM -0400, Soumyadeep Hore wrote:
> On enabling TxPP PTP clock was getting corrupted as timesync was enabled
> on during setup. Currently timesync will be enabled during start of tx
> queue, hence enabling PHC clock to get updated on starting and stopping
> of ports.
> 
> Earlier when timesync was enabled in tx queue setup, on stopping ports
> time will reset back to 0. Currently after every port restart PHC clock
> will be set to current system CLOCK_REALTIME.
> 
> Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/ice/ice_rxtx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index fd0b3a7532..752e52b8cd 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -908,6 +908,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  			rte_free(txq_elem);
>  			return err;
>  		}
> +		dev->dev_ops->timesync_enable(dev);
>  	} else {
>  		txq->qtx_tail = hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
>  

What happens in the case of multiple queues, the timesync is configured
multiple times? What happens when multiple queues are used and one stops,
is the timesync for the whole port set back to zero?

Basically, as I understand it, the clock is per-port rather than per-queue,
so why are we enabling it on a per-queue basis? For example, in the commit
message explanation above you say "on stopping PORTS time will be reset",
but here you configure it on starting a QUEUE.

Please clarify, thanks,
/Bruce

> @@ -1671,7 +1672,6 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  			PMD_INIT_LOG(ERR, "Cannot register Tx mbuf field/flag for timestamp");
>  			return -EINVAL;
>  		}
> -		dev->dev_ops->timesync_enable(dev);
>  
>  		txq->tsq->nb_ts_desc = ice_calc_ts_ring_count(ICE_VSI_TO_HW(vsi), txq->nb_tx_desc);
>  		ring_size = sizeof(struct ice_ts_desc) * txq->tsq->nb_ts_desc;
> -- 
> 2.47.1
> 
